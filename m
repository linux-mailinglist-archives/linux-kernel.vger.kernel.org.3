Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9414E445B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiCVQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiCVQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:40:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F001F5D1B7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:39:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1D271042;
        Tue, 22 Mar 2022 09:39:15 -0700 (PDT)
Received: from wubuntu (unknown [10.57.72.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 056643F73B;
        Tue, 22 Mar 2022 09:39:12 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:39:11 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 0/6]  Add latency_nice priority
Message-ID: <20220322163911.3jge4unswuap3pjh@wubuntu>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311161406.23497-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent

Thanks for reviving this patchset!

On 03/11/22 17:14, Vincent Guittot wrote:
> This patchset restarts the work about adding a latency nice priority to
> describe the latency tolerance of cfs tasks.
> 
> The patches [1-4] have been done by Parth:
> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> 
> I have just rebased and moved the set of latency priority outside the
> priority update. I have removed the reviewed tag because the patches
> are 2 years old.

AFAIR the blocking issue we had then is on agreement on the interface. Has this
been resolved now? I didn't see any further discussion since then.

> 
> The patches [5-6] use latency nice priority to decide if a cfs task can
> preempt the current running task. Patch 5 gives some tests results with
> cyclictests and hackbench to highlight the benefit of latency nice
> priority for short interactive task or long intensive tasks.

This is a new use case AFAICT. For Android, we want to do something in EAS path
to skip feec() and revert to select_idle_capacity() (prefer_idle). I think
Oracle's use case was control the search depth in the LB.

I am not keen on this new use case. It looks awefully similar to how nice
works. And if I tweak nice values I can certainly achieve similar effects
without this new addition:


	--::((TESTING NICE 0))::--

	  hackbench -l $((2560 / $group)) -g $group

	       count     mean       std    min  ...     90%      95%      99%    max
	group                                   ...                                 
	1       20.0  0.69315  0.119378  0.545  ...  0.8309  0.84725  0.97265  1.004
	4       20.0  0.54650  0.063123  0.434  ...  0.6363  0.64840  0.65448  0.656
	8       20.0  0.51025  0.042268  0.441  ...  0.5725  0.57830  0.59806  0.603
	16      20.0  0.54545  0.031041  0.483  ...  0.5824  0.58655  0.59491  0.597

	  hackbench -p -l $((2560 / $group)) -g $group

	       count     mean       std    min  ...     90%     95%      99%    max
	group                                   ...                                
	1       20.0  0.48135  0.036292  0.430  ...  0.5300  0.5481  0.54962  0.550
	4       20.0  0.42925  0.050890  0.339  ...  0.4838  0.5094  0.51548  0.517
	8       20.0  0.33655  0.049839  0.269  ...  0.4002  0.4295  0.43710  0.439
	16      20.0  0.31775  0.031001  0.280  ...  0.3530  0.3639  0.39278  0.400

	  hackbench -l 10000 -g 16 &
	  cyclictest --policy other -D 5 -q -H 20000 --histfile data.txt

	# Min Latencies: 00005
	# Avg Latencies: 00342
	# Max Latencies: 23562


	--::((TESTING NICE -20))::--

	  hackbench -l $((2560 / $group)) -g $group

	       count     mean       std    min  ...     90%     95%      99%    max
	group                                   ...                                
	1       20.0  0.76990  0.126582  0.585  ...  0.9169  0.9316  1.03192  1.057
	4       20.0  0.67715  0.105558  0.505  ...  0.8202  0.8581  0.85962  0.860
	8       20.0  0.75715  0.061286  0.631  ...  0.8276  0.8425  0.85010  0.852
	16      20.0  0.72085  0.089566  0.578  ...  0.8493  0.8818  0.92436  0.935

	  hackbench -p -l $((2560 / $group)) -g $group

	       count     mean       std    min  ...     90%      95%      99%    max
	group                                   ...                                 
	1       20.0  0.50245  0.055636  0.388  ...  0.5839  0.60185  0.61477  0.618
	4       20.0  0.56280  0.139277  0.354  ...  0.7280  0.75075  0.82295  0.841
	8       20.0  0.58005  0.091819  0.412  ...  0.6969  0.71400  0.71400  0.714
	16      20.0  0.52110  0.081465  0.323  ...  0.6169  0.63685  0.68017  0.691

	  hackbench -l 10000 -g 16 &
	  cyclictest --policy other -D 5 -q -H 20000 --histfile data.txt

	# Min Latencies: 00007
	# Avg Latencies: 00081
	# Max Latencies: 20560


	--::((TESTING NICE 19))::--

	  hackbench -l $((2560 / $group)) -g $group

	       count     mean       std    min  ...     90%      95%      99%    max
	group                                   ...                                 
	1       20.0  0.46560  0.013694  0.448  ...  0.4782  0.49805  0.49881  0.499
	4       20.0  0.43705  0.014979  0.414  ...  0.4550  0.45540  0.46148  0.463
	8       20.0  0.45800  0.013471  0.436  ...  0.4754  0.47925  0.48305  0.484
	16      20.0  0.53025  0.007239  0.522  ...  0.5391  0.54040  0.54648  0.548

	  hackbench -p -l $((2560 / $group)) -g $group

	       count     mean       std    min  ...     90%      95%      99%    max
	group                                   ...                                 
	1       20.0  0.27480  0.013725  0.247  ...  0.2892  0.29125  0.29505  0.296
	4       20.0  0.25095  0.011637  0.234  ...  0.2700  0.27010  0.27162  0.272
	8       20.0  0.25250  0.010097  0.240  ...  0.2632  0.27415  0.27643  0.277
	16      20.0  0.26700  0.007595  0.257  ...  0.2751  0.27645  0.28329  0.285

	  hackbench -l 10000 -g 16 &
	  cyclictest --policy other -D 5 -q -H 20000 --histfile data.txt

	# Min Latencies: 00058
	# Avg Latencies: 77232
	# Max Latencies: 696375

For hackbench, the relationship seems to be inversed. Better nice value
produces worse result. But for the cycletest, the avg goes down considerably
similar to your results.

Aren't we just manipulating the same thing with your new proposal or did
I miss something? Can we impact preemption in isolation without having any
impact on bandwidth?

I am worried about how userspace can reason about the expected outcome when
nice and latency_nice are combined together.


Thanks

--
Qais Yousef
