Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775F95282A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbiEPKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiEPKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:53:22 -0400
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE0C25EB9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:53:14 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id DEFA5FA878
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:53:12 +0100 (IST)
Received: (qmail 8810 invoked from network); 16 May 2022 10:53:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 May 2022 10:53:12 -0000
Date:   Mon, 16 May 2022 11:53:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <20220516105311.GL3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512124325.751781bb88ceef5c37ca653e@linux-foundation.org>
 <20220513142330.GI3441@techsingularity.net>
 <20220513123805.41e560392d028c271b36847d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220513123805.41e560392d028c271b36847d@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:38:05PM -0700, Andrew Morton wrote:
> > The sentence can be dropped because it adds little and is potentially
> > confusing. The PCP being safe to access remotely is specific to the
> > context of the CPU being hot-removed and there are other special corner
> > cases like zone_pcp_disable that modifies a per-cpu structure remotely
> > but not in a way that causes corruption.
> 
> OK.  I pasted in your para from the other email.  Current 0/n blurb:
> 
> Some setups, notably NOHZ_FULL CPUs, may be running realtime or
> latency-sensitive applications that cannot tolerate interference due to
> per-cpu drain work queued by __drain_all_pages().  Introduce a new
> mechanism to remotely drain the per-cpu lists.  It is made possible by
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
> lists.  The local_lock on its own prevents migration and the IRQ disabling
> protects from corruption due to an interrupt arriving while a page
> allocation is in progress.
> 
> This series adjusts the locking.  A spinlock is added to struct
> per_cpu_pages to protect the list contents while local_lock_irq continues
> to prevent migration and IRQ reentry.  This allows a remote CPU to safely
> drain a remote per-cpu list.
> 
> This series is a partial series.  Follow-on work should allow the
> local_irq_save to be converted to a local_irq to avoid IRQs being
> disabled/enabled in most cases.  Consequently, there are some TODO
> comments highlighting the places that would change if local_irq was used. 
> However, there are enough corner cases that it deserves a series on its
> own separated by one kernel release and the priority right now is to avoid
> interference of high priority tasks.
> 

Looks good, thanks!

-- 
Mel Gorman
SUSE Labs
