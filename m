Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372A158853E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiHCBCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHCBCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:02:51 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5E9151A1B;
        Tue,  2 Aug 2022 18:02:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D49BD62CDE5;
        Wed,  3 Aug 2022 11:02:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oJ2mc-008UEk-93; Wed, 03 Aug 2022 11:02:46 +1000
Date:   Wed, 3 Aug 2022 11:02:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-xfs@vger.kernel.org, lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [xfs] 016a23388c: stress-ng.xattr.ops_per_sec 58.4%
 improvement
Message-ID: <20220803010246.GB3600936@dread.disaster.area>
References: <Yti6PccitrglBtIj@xsang-OptiPlex-9020>
 <20220721220142.GW3861211@dread.disaster.area>
 <9d4e37e2-417e-7a2f-a187-5c7b680c6777@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d4e37e2-417e-7a2f-a187-5c7b680c6777@intel.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62e9c939
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=8nJEP1OIZ-IA:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=5YEsyfgjv6GE_ygq1SgA:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 02:36:00PM +0800, Yin, Fengwei wrote:
> Hi Dave,
> 
> On 7/22/2022 6:01 AM, Dave Chinner wrote:
> > A huge amount of spinlock contention in the xlog_commit_cil() path
> > went away. The commit identified doesn't remove/change any
> > spinlocks, it actually adds more overhead to the critical section of
> > the above spinlock in preparation for removing said spinlocks.
> > 
> > That removal happens in the next commit in that series - c0fb4765c508 ("xfs:
> > convert CIL to unordered per cpu lists") - so I'd be expecting a
> > bisect to demonstrate that the spinlock contention goes away with
> > the commit that removed the spinlocks (as it does in all the testing
> > of this I've done over the past 2 years), not the commit this bisect
> > identified. Hence I think the bisect went wrong somewhere...
> 
> We did some investigation and got:
> 
> commit:
>   df7a4a2134b0a ("xfs: convert CIL busy extents to per-cpu")
>   016a23388cdcb ("xfs: Add order IDs to log items in CIL")
>   c0fb4765c5086 ("xfs: convert CIL to unordered per cpu lists")
> 
> df7a4a2134b0a201 016a23388cdcb2740deb1379dc4 c0fb4765c5086cfd00f1158f5f4
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>      62.07            +0.0%      62.09            -0.0%      62.06        stress-ng.time.elapsed_time
>      62.07            +0.0%      62.09            -0.0%      62.06        stress-ng.time.elapsed_time.max
>       2237            +0.0%       2237            +0.0%       2237        stress-ng.time.file_system_inputs
>       1842 ±  4%     +16.9%       2152 ±  3%     +17.6%       2166        stress-ng.time.involuntary_context_switches
>     551.00            -0.3%     549.10            -0.3%     549.40        stress-ng.time.major_page_faults
>       6376            -1.1%       6305 ±  2%      +0.6%       6416        stress-ng.time.maximum_resident_set_size
>       9704            -0.3%       9676            -0.1%       9691        stress-ng.time.minor_page_faults
>       4096            +0.0%       4096            +0.0%       4096        stress-ng.time.page_size
>     841.90            -2.4%     821.70            -2.4%     821.90        stress-ng.time.percent_of_cpu_this_job_got
>     512.83            -3.4%     495.24            -3.6%     494.18        stress-ng.time.system_time
>      10.05 ±  8%     +52.3%      15.30 ±  3%     +61.1%      16.19 ±  2%  stress-ng.time.user_time
>       2325 ± 16%     +66.5%       3873 ±  7%     +70.3%       3962 ±  6%  stress-ng.time.voluntary_context_switches
>       1544 ±  4%     +54.4%       2385           +63.9%       2531        stress-ng.xattr.ops
> 
> Yes. commit c0fb4765c5086 ("xfs: convert CIL to unordered per cpu lists")
> could bring performance gain also. But the most performance gain (54.4%)
> is from commit 016a23388cdcb ("xfs: Add order IDs to log items in CIL").
> 
> 
> Based on commit 016a23388cdcb and add following change:
> 
> diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
> index 6bc540898e3a..7c6c91a0a12d 100644
> --- a/fs/xfs/xfs_log_cil.c
> +++ b/fs/xfs/xfs_log_cil.c
> @@ -659,9 +659,14 @@ xlog_cil_insert_items(
>                         continue;
>  
>                 lip->li_order_id = order;
> -               if (!list_empty(&lip->li_cil))
> -                       continue;
> -               list_add_tail(&lip->li_cil, &cil->xc_cil);
> +
> +               /*
> +                * Only move the item if it isn't already at the tail. This is
> +                * to prevent a transient list_empty() state when reinserting
> +                * an item that is already the only item in the CIL.
> +                */
> +               if (!list_is_last(&lip->li_cil, &cil->xc_cil))
> +                       list_move_tail(&lip->li_cil, &cil->xc_cil);
>         }
> 
> The performance will drop to the same level as commit df7a4a2134b0a
>  ("xfs: convert CIL busy extents to per-cpu"):

Thanks for looking into this.

This looks like a case of the workload being right at the threshold
of catastrophic cache line contention breakdown on this workload.
i.e.  a single extra exclusive cache miss inside the spin lock
critical region is sufficient overload the memory bus bandwidth and
so the cacheline contention on the lock from nothing to "all the
spare CPU time is spent contending on the spin lock cache line".

IOWs, the lock contention problem doesn't go away with this commit,
it just falls back under the critical threshold where the cache
coherency protocol runs out of memory bus bandwidth bouncing dirty
cachelines around all the CPU cores and so causes spinlock overhead
to go from linear cost to exponential cost.

That a single cacheline miss avoids all the spinlock contention is
just pure luck - it'll come back if other work is being done on the
machine that consumes enough memory bandwidth to push this back over
the edge. Hence the real fix for the spinlock contention problem is
still the patch I pointed out that removes the spinlocks
altogether...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
