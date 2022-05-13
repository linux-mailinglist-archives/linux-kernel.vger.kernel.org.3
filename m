Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7124B526A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383846AbiEMTiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiEMTiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:38:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E92C692B2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA6D9B83193
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 19:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4246CC34100;
        Fri, 13 May 2022 19:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652470686;
        bh=ywucsifpeTrhmSlANeerZ/FfD2u6HRZohJjqkLL8LyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ufFHIQ2sdh+3D/s3koGgMG1J0VYzIzwh/3wfDxSS8hv8MP8XMgO7UbGWZA4Xjfm0N
         FWHNfY+MImPnQZkDhwpSftx9DKFKxfzYircmMgE2pHkncRCu0b0GsC4D1Z9dTBDGgD
         uTGYun6Npfbgg3BPhO/Ntn2Llv94H1LWA5GhGw9o=
Date:   Fri, 13 May 2022 12:38:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-Id: <20220513123805.41e560392d028c271b36847d@linux-foundation.org>
In-Reply-To: <20220513142330.GI3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
        <20220512124325.751781bb88ceef5c37ca653e@linux-foundation.org>
        <20220513142330.GI3441@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 15:23:30 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> Correct.
> 
> > > the draining in non-deterministic.
> > 
> > s/n/s/;)
> > 
> 
> Think that one is ok. At least spell check did not complain.

s/in/si/

> > > Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> > > The local_lock on its own prevents migration and the IRQ disabling protects
> > > from corruption due to an interrupt arriving while a page allocation is
> > > in progress. The locking is inherently unsafe for remote access unless
> > > the CPU is hot-removed.
> > 
> > I don't understand the final sentence here.  Which CPU and why does
> > hot-removing it make the locking safe?
> > 
> 
> The sentence can be dropped because it adds little and is potentially
> confusing. The PCP being safe to access remotely is specific to the
> context of the CPU being hot-removed and there are other special corner
> cases like zone_pcp_disable that modifies a per-cpu structure remotely
> but not in a way that causes corruption.

OK.  I pasted in your para from the other email.  Current 0/n blurb:

Some setups, notably NOHZ_FULL CPUs, may be running realtime or
latency-sensitive applications that cannot tolerate interference due to
per-cpu drain work queued by __drain_all_pages().  Introduce a new
mechanism to remotely drain the per-cpu lists.  It is made possible by
remotely locking 'struct per_cpu_pages' new per-cpu spinlocks.  This has
two advantages, the time to drain is more predictable and other unrelated
tasks are not interrupted.

This series has the same intent as Nicolas' series "mm/page_alloc: Remote
per-cpu lists drain support" -- avoid interference of a high priority task
due to a workqueue item draining per-cpu page lists.  While many workloads
can tolerate a brief interruption, it may cause a real-time task running
on a NOHZ_FULL CPU to miss a deadline and at minimum, the draining is
non-deterministic.

Currently an IRQ-safe local_lock protects the page allocator per-cpu
lists.  The local_lock on its own prevents migration and the IRQ disabling
protects from corruption due to an interrupt arriving while a page
allocation is in progress.

This series adjusts the locking.  A spinlock is added to struct
per_cpu_pages to protect the list contents while local_lock_irq continues
to prevent migration and IRQ reentry.  This allows a remote CPU to safely
drain a remote per-cpu list.

This series is a partial series.  Follow-on work should allow the
local_irq_save to be converted to a local_irq to avoid IRQs being
disabled/enabled in most cases.  Consequently, there are some TODO
comments highlighting the places that would change if local_irq was used. 
However, there are enough corner cases that it deserves a series on its
own separated by one kernel release and the priority right now is to avoid
interference of high priority tasks.

Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
	and when it is storing per-cpu pages.

Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
	this is not necessary but it avoids per_cpu_pages consuming another
	cache line.

Patch 3 is a preparation patch to avoid code duplication.

Patch 4 is a simple micro-optimisation that improves code flow necessary for
	a later patch to avoid code duplication.

Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
	relying on local_lock to prevent migration, stabilise the pcp
	lookup and prevent IRQ reentrancy.

Patch 6 remote drains per-cpu pages directly instead of using a workqueue.

