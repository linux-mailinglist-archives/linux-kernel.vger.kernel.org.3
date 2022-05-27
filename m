Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F7535BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbiE0Ij5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349814AbiE0Ijz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:39:55 -0400
Received: from outbound-smtp21.blacknight.com (outbound-smtp21.blacknight.com [81.17.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1A15FF3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:39:51 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 57240CCBC7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:39:49 +0100 (IST)
Received: (qmail 13188 invoked from network); 27 May 2022 08:39:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 May 2022 08:39:49 -0000
Date:   Fri, 27 May 2022 09:39:46 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <20220527083946.GF3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <Yo+2qqHqSdpE5l7m@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Yo+2qqHqSdpE5l7m@qian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 01:19:38PM -0400, Qian Cai wrote:
> On Thu, May 12, 2022 at 09:50:37AM +0100, Mel Gorman wrote:
> > Changelog since v2
> > o More conversions from page->lru to page->[pcp_list|buddy_list]
> > o Additional test results in changelogs
> > 
> > Changelog since v1
> > o Fix unsafe RT locking scheme
> > o Use spin_trylock on UP PREEMPT_RT
> > 
> > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > per-cpu lists drain support" -- avoid interference of a high priority
> > task due to a workqueue item draining per-cpu page lists. While many
> > workloads can tolerate a brief interruption, it may be cause a real-time
> > task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> > the draining in non-deterministic.
> > 
> > Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> > The local_lock on its own prevents migration and the IRQ disabling protects
> > from corruption due to an interrupt arriving while a page allocation is
> > in progress. The locking is inherently unsafe for remote access unless
> > the CPU is hot-removed.
> > 
> > This series adjusts the locking. A spinlock is added to struct
> > per_cpu_pages to protect the list contents while local_lock_irq continues
> > to prevent migration and IRQ reentry. This allows a remote CPU to safely
> > drain a remote per-cpu list.
> > 
> > This series is a partial series. Follow-on work should allow the
> > local_irq_save to be converted to a local_irq to avoid IRQs being
> > disabled/enabled in most cases. Consequently, there are some TODO comments
> > highlighting the places that would change if local_irq was used. However,
> > there are enough corner cases that it deserves a series on its own
> > separated by one kernel release and the priority right now is to avoid
> > interference of high priority tasks.
> > 
> > Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
> > 	and when it is storing per-cpu pages.
> > 
> > Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
> > 	this is not necessary but it avoids per_cpu_pages consuming another
> > 	cache line.
> > 
> > Patch 3 is a preparation patch to avoid code duplication.
> > 
> > Patch 4 is a simple micro-optimisation that improves code flow necessary for
> > 	a later patch to avoid code duplication.
> > 
> > Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
> > 	relying on local_lock to prevent migration, stabilise the pcp
> > 	lookup and prevent IRQ reentrancy.
> > 
> > Patch 6 remote drains per-cpu pages directly instead of using a workqueue.
> 
> Mel, we saw spontanous "mm_percpu_wq" crash on today's linux-next tree
> while running CPU offlining/onlining, and wondering if you have any
> thoughts?
> 

Do you think it's related to the series and if so why? From the warning,
it's not obvious to me why it would be given that it's a warning about a
task not being inactive when it is expected to be.

-- 
Mel Gorman
SUSE Labs
