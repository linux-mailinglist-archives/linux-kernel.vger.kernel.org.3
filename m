Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25DE51F26A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiEIBbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiEIAHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:07:22 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCB33DEF1;
        Sun,  8 May 2022 17:03:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 88BAC52DCAB;
        Mon,  9 May 2022 10:03:28 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nnqs2-009h1M-Jk; Mon, 09 May 2022 10:03:26 +1000
Date:   Mon, 9 May 2022 10:03:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Carel Si <beibei.si@intel.com>
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org, lkp@lists.01.org,
        fengwei.yin@intel.com, linux-xfs@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [LKP] Re: [xfs]  32678f1513:  aim7.jobs-per-min -5.6% regression
Message-ID: <20220509000326.GN1098723@dread.disaster.area>
References: <20220502082018.1076561-2-david@fromorbit.com>
 <20220506092250.GI23061@xsang-OptiPlex-9020>
 <20220506212924.GJ1098723@dread.disaster.area>
 <20220507110941.GA10880@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220507110941.GA10880@linux.intel.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62785a51
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=8nJEP1OIZ-IA:10 a=oZkIemNP1mAA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=OIWXXrKM4WwZCH1KPDMA:9 a=wPNLvfGTeEIA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 07:09:46PM +0800, Carel Si wrote:
> Hi Dave,
> 
> On Sat, May 07, 2022 at 07:29:24AM +1000, Dave Chinner wrote:
> > On Fri, May 06, 2022 at 05:22:50PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a -5.6% regression of aim7.jobs-per-min due to commit:
> > > 
> > > 
> > > commit: 32678f151338b9a321e9e27139a63c81f353acb7 ("[PATCH 1/4] xfs: detect self referencing btree sibling pointers")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/xfs-fix-random-format-verification-issues/20220502-162206
> > > base: https://git.kernel.org/cgit/fs/xfs/xfs-linux.git for-next
> > > patch link: https://lore.kernel.org/linux-xfs/20220502082018.1076561-2-david@fromorbit.com
> > 
> > Well, that answers the concern I had about the impact of 
> > changing the way endian conversions were done in that patch.
> > 
> > > a44a027a8b2a20fe 32678f151338b9a321e9e27139a 
> > > ---------------- --------------------------- 
> > >          %stddev     %change         %stddev
> > >              \          |                \  
> > >     464232            -5.6%     438315        aim7.jobs-per-min
> > ....
> > >       0.13 ±  5%      +0.2        0.33 ±  6%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
> > ....
> > >       0.11 ±  4%      +0.2        0.30 ±  5%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
> > 
> > Because there is it, right at the bottom of the profile.
> > 
> > Can you try the patch below and see if that fixes the issue?
> 
> We tested below patch, it didn't fix the issue, still has -6.4% regression [1] 
> comparing to a44a027a8b ("Merge tag 'large-extent-counters-v9' of 
> https://github.com/chandanr/linux into xfs-5.19-for-next"). 

Really? It made the regression *worse*?

Oh, wait, *that* wasn't in the last set of profiles:

....
>      35.30 ±  4%      +1.3       36.59 ±  3%      +1.9       37.24 ±  3%  perf-profile.children.cycles-pp.osq_lock
>      36.88 ±  4%      +1.3       38.19 ±  2%      +1.9       38.83 ±  3%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>      37.40 ±  4%      +1.4       38.77 ±  2%      +2.0       39.35 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
....
>       1.89 ±  3%      +0.1        1.96 ±  4%      +0.0        1.90 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>       0.11 ±  4%      +0.2        0.30 ±  5%      +0.2        0.29        perf-profile.self.cycles-pp.__xfs_btree_check_sblock
>      35.08 ±  4%      +1.3       36.33 ±  2%      +1.9       37.01 ±  3%  perf-profile.self.cycles-pp.osq_lock

This test is hammering an rwsem which is them spinning on exclusive
write locks somewhere. That's where all the increase in system time
has come from, and that's what's causing the difference in
perofrmance. I bet this test is hammering single file write IO from
all 96 CPUs at once, and that's where all the problems start.

IOWs, this likley has nothing to with the btree validation change,
and everything to do with the system being driven into a lock and
cacheline contention corner. When there is lock contention like this
on a large CPU count system, we can't infer anything at all from any
other measurement because the cacheline contention skews
everything...

I'm not going to look at this any further, and I think I'm going to
ignore AIM7 write test regressions in future until the test is
reconfigured to avoid this sort of "100 cpus all trying to do
buffered writes to the same file" contention issue.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
