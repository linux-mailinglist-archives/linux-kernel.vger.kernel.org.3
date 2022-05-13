Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BDA52692B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383281AbiEMSXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350261AbiEMSXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:23:08 -0400
Received: from outbound-smtp11.blacknight.com (outbound-smtp11.blacknight.com [46.22.139.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC35E0A1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:23:04 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 6064C1C6018
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 19:23:03 +0100 (IST)
Received: (qmail 1396 invoked from network); 13 May 2022 18:23:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 May 2022 18:23:03 -0000
Date:   Fri, 13 May 2022 19:23:01 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] mm/page_alloc: Remotely drain per-cpu lists
Message-ID: <20220513182301.GK3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-7-mgorman@techsingularity.net>
 <20220512123743.5be26b3ad4413f20d5f46564@linux-foundation.org>
 <20220513150402.GJ3441@techsingularity.net>
 <167d30f439d171912b1ef584f20219e67a009de8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <167d30f439d171912b1ef584f20219e67a009de8.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 05:19:18PM +0200, Nicolas Saenz Julienne wrote:
> On Fri, 2022-05-13 at 16:04 +0100, Mel Gorman wrote:
> > On Thu, May 12, 2022 at 12:37:43PM -0700, Andrew Morton wrote:
> > > On Thu, 12 May 2022 09:50:43 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> > > 
> > > > From: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > > > 
> > > > Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
> > > > drain work queued by __drain_all_pages(). So introduce a new mechanism to
> > > > remotely drain the per-cpu lists. It is made possible by remotely locking
> > > > 'struct per_cpu_pages' new per-cpu spinlocks. A benefit of this new scheme
> > > > is that drain operations are now migration safe.
> > > > 
> > > > There was no observed performance degradation vs. the previous scheme.
> > > > Both netperf and hackbench were run in parallel to triggering the
> > > > __drain_all_pages(NULL, true) code path around ~100 times per second.
> > > > The new scheme performs a bit better (~5%), although the important point
> > > > here is there are no performance regressions vs. the previous mechanism.
> > > > Per-cpu lists draining happens only in slow paths.
> > > > 
> > > > Minchan Kim tested this independently and reported;
> > > > 
> > > > 	My workload is not NOHZ CPUs but run apps under heavy memory
> > > > 	pressure so they goes to direct reclaim and be stuck on
> > > > 	drain_all_pages until work on workqueue run.
> > > > 
> > > > 	unit: nanosecond
> > > > 	max(dur)        avg(dur)                count(dur)
> > > > 	166713013       487511.77786438033      1283
> > > > 
> > > > 	From traces, system encountered the drain_all_pages 1283 times and
> > > > 	worst case was 166ms and avg was 487us.
> > > > 
> > > > 	The other problem was alloc_contig_range in CMA. The PCP draining
> > > > 	takes several hundred millisecond sometimes though there is no
> > > > 	memory pressure or a few of pages to be migrated out but CPU were
> > > > 	fully booked.
> > > > 
> > > > 	Your patch perfectly removed those wasted time.
> > > 
> > > I'm not getting a sense here of the overall effect upon userspace
> > > performance.  As Thomas said last year in
> > > https://lkml.kernel.org/r/87v92sgt3n.ffs@tglx
> > > 
> > > : The changelogs and the cover letter have a distinct void vs. that which
> > > : means this is just another example of 'scratch my itch' changes w/o
> > > : proper justification.
> > > 
> > > Is there more to all of this than itchiness and if so, well, you know
> > > the rest ;)
> > > 
> > 
> > I think Minchan's example is clear-cut.  The draining operation can take
> > an arbitrary amount of time waiting for the workqueue to run on each CPU
> > and can cause severe delays under reclaim or CMA and the patch fixes
> > it. Maybe most users won't even notice but I bet phone users do if a
> > camera app takes too long to open.
> > 
> > The first paragraphs was written by Nicolas and I did not want to modify
> > it heavily and still put his Signed-off-by on it. Maybe it could have
> > been clearer though because "too busy" is vague when the actual intent
> > is to avoid interfering with RT tasks. Does this sound better to you?
> > 
> > 	Some setups, notably NOHZ_FULL CPUs, may be running realtime or
> > 	latency-sensitive applications that cannot tolerate interference
> > 	due to per-cpu drain work queued by __drain_all_pages(). Introduce
> > 	a new mechanism to remotely drain the per-cpu lists. It is made
> > 	possible by remotely locking 'struct per_cpu_pages' new per-cpu
> > 	spinlocks. This has two advantages, the time to drain is more
> > 	predictable and other unrelated tasks are not interrupted.
> > 
> > You raise a very valid point with Thomas' mail and it is a concern that
> > the local_lock is no longer strictly local. We still need preemption to
> > be disabled between the percpu lookup and the lock acquisition but that
> > can be done with get_cpu_var() to make the scope clear.
> 
> This isn't going to work in RT :(
> 
> get_cpu_var() disables preemption hampering RT spinlock use. There is more to
> it in Documentation/locking/locktypes.rst.
> 

Bah, you're right.  A helper that called preempt_disable() on !RT
and migrate_disable() on RT would work although similar to local_lock
with a different name. I'll look on Monday to see how the code could be
restructured to always have the get_cpu_var() call immediately before the
lock acquisition. Once that is done, I'll look what sort of helper that
"disables preempt/migration, lookup pcp structure, acquire lock, enable
preempt/migration". It's effectively the magic trick that local_lock uses
to always lock the right pcpu lock but we want the spinlock semantics
for remote drain.

-- 
Mel Gorman
SUSE Labs
