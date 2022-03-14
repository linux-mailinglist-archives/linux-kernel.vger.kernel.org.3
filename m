Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD544D8589
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiCNM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiCNM6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:58:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0EE11A3E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647262629; x=1678798629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N+rue5gtSfzTxtTiqEDZ4Rh44H4UqnVTpwdh67a7NTg=;
  b=lpJsjyfbXeReylfxMuPu7BhsE0g3po0MyvIJUAki6Z3RyH15Q6+/4Xrs
   bf3a6bt4im/YAHBFaglpIX+NcgF312oxF4T67jAnGW82OYvcgIGNrh1n2
   Ri4k0Qx1S+9MS04UR2AkzFN4V0RGTjg/7347ndGtpEnloSsFiCDFqjhc/
   29qslv6X7biKi+fGbaB/Q7WtZAYm0IZx8V1XpX+dXzyJyW3UMhRnFtzY8
   bA5J1s+9WBLcj9nOe63WGNqDRzcCfSORPq7J1vABzWk/2NXoXGjy0siQM
   9weKCVAws//goErNn6glepxtpDGFD8RXuwtOO9/clQNDfubqqoUhUdKNH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="236620988"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="236620988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 05:57:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="515412926"
Received: from junhongo-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.192.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 05:57:01 -0700
Date:   Mon, 14 Mar 2022 20:56:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Aubrey Li <aubrey.li@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
Message-ID: <20220314125657.GA30418@chenyu5-mobl1>
References: <20220310005228.11737-1-yu.c.chen@intel.com>
 <444bfebb-ac1c-42b9-58f5-332780e749f7@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <444bfebb-ac1c-42b9-58f5-332780e749f7@bytedance.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,
On Mon, Mar 14, 2022 at 12:53:54PM +0800, Abel Wu wrote:
> Hi Chen,
> 
> 在 3/10/22 8:52 AM, Chen Yu 写道:
> > [Problem Statement]
> > Currently select_idle_cpu() uses the percpu average idle time to
> > estimate the total LLC domain idle time, and calculate the number
> > of CPUs to be scanned. This might be inconsistent because idle time
> > of a CPU does not necessarily correlate with idle time of a domain.
> > As a result, the load could be underestimated and causes over searching
> > when the system is very busy.
> > 
> > The following histogram is the time spent in select_idle_cpu(),
> > when running 224 instance of netperf on a system with 112 CPUs
> > per LLC domain:
> > 
> > @usecs:
> > [0]                  533 |                                                    |
> > [1]                 5495 |                                                    |
> > [2, 4)             12008 |                                                    |
> > [4, 8)            239252 |                                                    |
> > [8, 16)          4041924 |@@@@@@@@@@@@@@                                      |
> > [16, 32)        12357398 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         |
> > [32, 64)        14820255 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [64, 128)       13047682 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       |
> > [128, 256)       8235013 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@                        |
> > [256, 512)       4507667 |@@@@@@@@@@@@@@@                                     |
> > [512, 1K)        2600472 |@@@@@@@@@                                           |
> > [1K, 2K)          927912 |@@@                                                 |
> > [2K, 4K)          218720 |                                                    |
> > [4K, 8K)           98161 |                                                    |
> > [8K, 16K)          37722 |                                                    |
> > [16K, 32K)          6715 |                                                    |
> > [32K, 64K)           477 |                                                    |
> > [64K, 128K)            7 |                                                    |
> > 
> > netperf latency:
> > =======
> > case            	load    	    Lat_99th	    std%
> > TCP_RR          	thread-224	      257.39	(  0.21)
> > UDP_RR          	thread-224	      242.83	(  6.29)
> > 
> > The netperf 99th latency(usec) above is comparable with the time spent in
> > select_idle_cpu(). That is to say, when the system is overloaded, searching
> > for idle CPU could be a bottleneck.
> > 
> > [Proposal]
> > The main idea is to replace percpu average idle time with the domain
> > based metric. Choose average CPU utilization(util_avg) as the candidate.
> > In general, the number of CPUs to be scanned should be inversely
> > proportional to the sum of util_avg in this domain. That is, the lower
> > the util_avg is, the more select_idle_cpu() should scan for idle CPU,
> > and vice versa. The benefit of choosing util_avg is that, it is a metric
> > of accumulated historic activity, which seems to be more accurate than
> > instantaneous metrics(such as rq->nr_running).
> > 
> > Furthermore, borrow the util_avg from periodic load balance,
> > which could offload the overhead of select_idle_cpu().
> > 
> > According to last discussion[1], introduced the linear function
> > for experimental purpose:
> 
> It would be better if you can prove it's a linear model by the
> SIS efficiency statistics :)
>
Thanks for your comments!
 
Good point, the SIS efficiency could be used to verify if the real
search number fitting this linear mode well, I'll collect this statistics.
But TBH I'm not sure whether there is a convergent/accurate mapping
between the sum of util_avg and the number of CPUs to be scanned(unless we use
sum_util/pelt_scan_cost to approach it). Choosing a model seems to always be a
heuristic search policy.
> > 
> > f(x) = a - bx
> > 
> >       llc_size
> > x = \Sum      util_avg[cpu] / llc_cpu_capacity
> >       1
> > f(x) is the number of CPUs to be scanned, x is the sum util_avg.
> > To decide a and b, the following condition should be met:
> > 
> > [1] f(0) = llc_size
> > [2] f(x) = 4,  x >= 50%
> > 
> > +	 * newidle balance.
> > +	 */
> > +	if (env->idle == CPU_NEWLY_IDLE || env->sd->span_weight != llc_size)
> 
> So nr_scan will probably be updated at llc-domain-lb-interval, which
> is llc_size milliseconds. Since load can be varied a lot during such
> a period, would this brought accuracy issues?
>
I agree there might be delay in reflecting the latest utilization.
The sum_util calculated by periodic load balance after 112ms would be
decay to about 0.5 * 0.5 * 0.5 * 0.7 = 8.75%.
But consider that this is a server platform, I have an impression that
the CPU utilization jitter during a small period of time is not a regular
scenario? It seems to be a trade-off. Checking the util_avg in newidle
load balance path would be more frequent, but it also brings overhead -
multiple CPUs write/read the per-LLC shared variable and introduces cache
false sharing. But to make this more robust, maybe we can add time interval
control in newidle load balance too.

thanks,
Chenyu


> Best regards
> Abel
