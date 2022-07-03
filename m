Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E184564A91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiGCX23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiGCX2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B75F1105
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8E36B80CE6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD2BC341C6;
        Sun,  3 Jul 2022 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656890902;
        bh=aEIGXJCrTumxaF3V0DderfrmrH0jO1WyIFbOI/yMixw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XgbQhYjIGDLZiG0Dhro2Rsr+hRmWMjyG8YOas3RxDMBM7GniGrmVreuyJFmRd6UPR
         YvvWlxPb/unCQ0yNA7Y2V4m9PIoy5oSXNuZx883GlFlFSAdk9hNJltdu/PdzG4LlPt
         TqbaP4VyTeSnu8GrvVaTc6PNA86FQEiBKm+rqZ2U=
Date:   Sun, 3 Jul 2022 16:28:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v5 00/7] Drain remote per-cpu directly
Message-Id: <20220703162821.f097d6e4b3e2a0114820a8d9@linux-foundation.org>
In-Reply-To: <20220624125423.6126-1-mgorman@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 13:54:16 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> Some setups, notably NOHZ_FULL CPUs, may be running realtime or
> latency-sensitive applications that cannot tolerate interference due to
> per-cpu drain work queued by __drain_all_pages().  Introduce a new
> mechanism to remotely drain the per-cpu lists. It is made possible by
> remotely locking 'struct per_cpu_pages' new per-cpu spinlocks.  This has
> two advantages, the time to drain is more predictable and other unrelated
> tasks are not interrupted.
> 
> This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> per-cpu lists drain support" -- avoid interference of a high priority task
> due to a workqueue item draining per-cpu page lists.  While many workloads
> can tolerate a brief interruption, it may cause a real-time task running
> on a NOHZ_FULL CPU to miss a deadline and at minimum, the draining is
> non-deterministic.
> 
> Currently an IRQ-safe local_lock protects the page allocator per-cpu
> lists. The local_lock on its own prevents migration and the IRQ disabling
> protects from corruption due to an interrupt arriving while a page
> allocation is in progress.
> 
> This series adjusts the locking.  A spinlock is added to struct
> per_cpu_pages to protect the list contents while local_lock_irq is
> ultimately replaced by just the spinlock in the final patch.  This allows
> a remote CPU to safely. Follow-on work should allow the spin_lock_irqsave
> to be converted to spin_lock to avoid IRQs being disabled/enabled in
> most cases. The follow-on patch will be one kernel release later as it
> is relatively high risk and it'll make bisections more clear if there
> are any problems.

I plan to move this and Mel's fix to [7/7] into mm-stable around July 8.

