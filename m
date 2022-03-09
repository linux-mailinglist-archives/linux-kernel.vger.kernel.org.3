Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7C4D2DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiCILZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiCILZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:25:09 -0500
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E236C13D92D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:24:07 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id 1225717B4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:24:06 +0000 (GMT)
Received: (qmail 23128 invoked from network); 9 Mar 2022 11:24:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Mar 2022 11:24:05 -0000
Date:   Wed, 9 Mar 2022 11:24:04 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, fengwei.yin@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [LKP] Re: [sched/numa]  0fb3978b0a: stress-ng.fstat.ops_per_sec
 -18.9% regression
Message-ID: <20220309112404.GH15701@techsingularity.net>
References: <20220302140220.GA32817@xsang-OptiPlex-9020>
 <87mti7s9xz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87tuc7fp9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87tuc7fp9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:28:55PM +0800, Huang, Ying wrote:
> Hi, All,
> 
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> > Hi, Oliver,
> >
> > Thanks for report.
> >
> > I still cannot connect the regression with the patch yet.  To double
> > check, I have run test again with "sched_verbose" kernel command line,
> > and verified that the sched_domain isn't changed at all with the patch.
> >
> > kernel test robot <oliver.sang@intel.com> writes:
> >>       0.11   6%      +0.1        0.16   4%  perf-profile.self.cycles-pp.update_rq_clock
> >>       0.00            +0.1        0.06   6%  perf-profile.self.cycles-pp.memset_erms
> >>       0.00            +0.1        0.07   5%  perf-profile.self.cycles-pp.get_pid_task
> >>       0.06   7%      +0.1        0.17   6%  perf-profile.self.cycles-pp.select_task_rq_fair
> >>       0.54   5%      +0.1        0.68        perf-profile.self.cycles-pp.lockref_put_return
> >>       4.26            +1.1        5.33        perf-profile.self.cycles-pp.common_perm_cond
> >>      15.45            +4.9       20.37        perf-profile.self.cycles-pp.lockref_put_or_lock
> >>      20.12            +6.7       26.82        perf-profile.self.cycles-pp.lockref_get_not_dead
> >
> > From the perf-profile above, the most visible change is more cycles in
> > lockref_get_not_dead(), which will loop with cmpxchg on
> > dentry->d_lockref.  So this appears to be related to the memory layout.
> > I will try to debug that.
> >
> > Because stress-ng is a weird "benchmark" although it's a very good
> > functionality test, and I cannot connect the patch with the test case
> > and performance metrics collected.  I think this regression should be a
> > low priority one which shouldn't prevent the merging etc.  But I will
> > continue to investigate the regression to try to root cause it.
> 
> Done more investigation for this.  It turns out the sched_domain has
> been changed after commit 0fb3978b0a, although it's not shown in default
> sched_verbose output.  sd->imb_numa_nr of level "NUMA" has been changed
> from 24 to 12 after the commit.  So the following debug patch restore
> the performance.
> 

If Ice Lake has multiple last level caches per socket (I didn't check)
then the sd->imb_numa_nr would have changed. I didn't dig into what
stress-ng fstat is doing as it's a stress test more than a performance
test but given that the number of threads is 10% of the total, it's
possible that the workload is being split across nodes differently.

-- 
Mel Gorman
SUSE Labs
