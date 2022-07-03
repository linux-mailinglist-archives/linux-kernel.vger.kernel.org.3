Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC54564A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiGCXfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiGCXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:35:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D605FF3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 536B3B80CE5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B843BC341C6;
        Sun,  3 Jul 2022 23:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656891332;
        bh=HZril8bI8S7GwL97fvRQZecdLwnEvyV43EQQe4DOpCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=opkLcsOPDkzd81C0RtLgvAyPDNTJ3CJDvP3+isfxMImLJAmJ3pYWMz1T8TRxS2hy3
         KG75/iGZ2NcV1Qp9GTlASlgxpp1gjaQaVgscixYacs9mZBGQON0VwSdxImVN4Ssuii
         SxxDzYI1DmakLx+r+Zs4yEbKvgt+fixkoxQBsMqc=
Date:   Sun, 3 Jul 2022 16:35:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v5 00/7] Drain remote per-cpu directly
Message-Id: <20220703163531.beed10c723f1c74a9001573c@linux-foundation.org>
In-Reply-To: <CAOUHufZj87ewG6_OObmDByxHv51DgbkB-O6oMitw72QF1JrkcQ@mail.gmail.com>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
        <20220703162821.f097d6e4b3e2a0114820a8d9@linux-foundation.org>
        <CAOUHufZj87ewG6_OObmDByxHv51DgbkB-O6oMitw72QF1JrkcQ@mail.gmail.com>
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

On Sun, 3 Jul 2022 17:31:09 -0600 Yu Zhao <yuzhao@google.com> wrote:

> > > This series adjusts the locking.  A spinlock is added to struct
> > > per_cpu_pages to protect the list contents while local_lock_irq is
> > > ultimately replaced by just the spinlock in the final patch.  This allows
> > > a remote CPU to safely. Follow-on work should allow the spin_lock_irqsave
> > > to be converted to spin_lock to avoid IRQs being disabled/enabled in
> > > most cases. The follow-on patch will be one kernel release later as it
> > > is relatively high risk and it'll make bisections more clear if there
> > > are any problems.
> >
> > I plan to move this and Mel's fix to [7/7] into mm-stable around July 8.
> 
> I've thrown it together with the Maple Tree and passed a series of stress tests.

Cool, thanks.  I added your Tested-by: to everything.
