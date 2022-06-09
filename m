Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED77E544893
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiFIKPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbiFIKPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:15:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1BC0452
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654769751; x=1686305751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WmW1myMMr9+mjgMYSm5lqOOv/Z0g47xYx8M8+p8Eeu8=;
  b=ijYh++itHcPOB/hDeYxxyvEAzCzbWQ1kvKgCvAHX6ugOut6AKf5LmGQB
   72BhLsHbvWeg6BGixRqSg/BeKslMiO8gIhiHLu0lAZrsSyJJL7WoRzHrC
   iwiIwnT1QiUFQo/slWXNpF2WWoveOXJAPwENAWqJBdAHIV2Nbck90zRQJ
   GwddoRmri6znMBDuvhzxehk3AjQ+EfzluvSUkicWgizvN/fTGH9Bsb3Q/
   4EeggXc966yuojv6fYjgTZUF2MVi8wjk/amhlLQXt9S4nULqvWBdcq1OT
   7GrJWQxYTvfVR3bcFws93MC2perJE1xSIQRCkAGNaYyHg/yAbqzwmjOB+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278042815"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="278042815"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 03:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585438822"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 03:15:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzFCL-000FsP-0l;
        Thu, 09 Jun 2022 10:15:29 +0000
Date:   Thu, 9 Jun 2022 18:14:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com
Subject: Re: [PATCH v3 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <202206091846.fm1bYjWk-lkp@intel.com>
References: <20220608095758.60504-3-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608095758.60504-3-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v5.19-rc1 next-20220609]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/sched-fair-Wake-task-within-the-cluster-when-possible/20220608-181847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 991d8d8142cad94f9c5c05db25e67fa83d6f772a
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220609/202206091846.fm1bYjWk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f2b15e8641f351783c1d47bc654ace164300b7f1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yicong-Yang/sched-fair-Wake-task-within-the-cluster-when-possible/20220608-181847
        git checkout f2b15e8641f351783c1d47bc654ace164300b7f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'select_idle_cpu':
>> kernel/sched/fair.c:6381:36: warning: passing argument 2 of 'scan_cluster' makes integer from pointer without a cast [-Wint-conversion]
    6381 |         idle_cpu = scan_cluster(p, cpus, target, &nr);
         |                                    ^~~~
         |                                    |
         |                                    struct cpumask *
   kernel/sched/fair.c:6327:59: note: expected 'int' but argument is of type 'struct cpumask *'
    6327 | static inline int scan_cluster(struct task_struct *p, int prev_cpu, int target, int *nr)
         |                                                       ~~~~^~~~~~~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:11114:6: warning: no previous prototype for 'task_vruntime_update' [-Wmissing-prototypes]
   11114 | void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/scan_cluster +6381 kernel/sched/fair.c

  6332	
  6333	/*
  6334	 * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  6335	 * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  6336	 * average idle time for this rq (as found in rq->avg_idle).
  6337	 */
  6338	static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
  6339	{
  6340		struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
  6341		int i, cpu, idle_cpu = -1, nr = INT_MAX;
  6342		struct rq *this_rq = this_rq();
  6343		int this = smp_processor_id();
  6344		struct sched_domain *this_sd;
  6345		u64 time = 0;
  6346	
  6347		this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
  6348		if (!this_sd)
  6349			return -1;
  6350	
  6351		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
  6352	
  6353		if (sched_feat(SIS_PROP) && !has_idle_core) {
  6354			u64 avg_cost, avg_idle, span_avg;
  6355			unsigned long now = jiffies;
  6356	
  6357			/*
  6358			 * If we're busy, the assumption that the last idle period
  6359			 * predicts the future is flawed; age away the remaining
  6360			 * predicted idle time.
  6361			 */
  6362			if (unlikely(this_rq->wake_stamp < now)) {
  6363				while (this_rq->wake_stamp < now && this_rq->wake_avg_idle) {
  6364					this_rq->wake_stamp++;
  6365					this_rq->wake_avg_idle >>= 1;
  6366				}
  6367			}
  6368	
  6369			avg_idle = this_rq->wake_avg_idle;
  6370			avg_cost = this_sd->avg_scan_cost + 1;
  6371	
  6372			span_avg = sd->span_weight * avg_idle;
  6373			if (span_avg > 4*avg_cost)
  6374				nr = div_u64(span_avg, avg_cost);
  6375			else
  6376				nr = 4;
  6377	
  6378			time = cpu_clock(this);
  6379		}
  6380	
> 6381		idle_cpu = scan_cluster(p, cpus, target, &nr);
  6382		if ((unsigned int)idle_cpu < nr_cpumask_bits)
  6383			return idle_cpu;
  6384	
  6385		for_each_cpu_wrap(cpu, cpus, target + 1) {
  6386			if (has_idle_core) {
  6387				i = select_idle_core(p, cpu, cpus, &idle_cpu);
  6388				if ((unsigned int)i < nr_cpumask_bits)
  6389					return i;
  6390	
  6391			} else {
  6392				if (--nr <= 0)
  6393					return -1;
  6394				idle_cpu = __select_idle_cpu(cpu, p);
  6395				if ((unsigned int)idle_cpu < nr_cpumask_bits)
  6396					break;
  6397			}
  6398		}
  6399	
  6400		if (has_idle_core)
  6401			set_idle_cores(target, false);
  6402	
  6403		if (sched_feat(SIS_PROP) && !has_idle_core) {
  6404			time = cpu_clock(this) - time;
  6405	
  6406			/*
  6407			 * Account for the scan cost of wakeups against the average
  6408			 * idle time.
  6409			 */
  6410			this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
  6411	
  6412			update_avg(&this_sd->avg_scan_cost, time);
  6413		}
  6414	
  6415		return idle_cpu;
  6416	}
  6417	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
