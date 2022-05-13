Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EEB525B99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377323AbiEMGeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiEMGeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:34:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917A2A1FD0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652423646; x=1683959646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NCLw1D/Ap7uQdQ5sir8JCYLSzQQo6N/3LNNrH7SbUHg=;
  b=KFhotyg06aJYa6+apfzKFc7fH1mmLUvw65BerqjNXyu7gIOWYmWqDVVS
   ofKpCJX7mgXlwFmluJH0Y2cxR2rTHjYmWQtlPVkWqdROAhpAqgKFgd4Zl
   LMjvODoq0PR+uiIbx6h4HTrD+BdklXN17v4vBKtJ8RsGlmndtBR+uutPU
   dWVr41ruXs72O3NalXX1hSjloG0xiPvf0NRYh9ruDIv32/A0PHAYF7YKp
   IeWLMc0FfVbh2vlSfS/E1ebbu9GHdsz8Q0fQgOcLYVQs3cTD2wRH1bf9T
   CG3Xn6EWzBWnY0a55IUATtq1i0FRrCwqF2JNQy5Eil+p6XDHLRRoD2NRf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267825472"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="267825472"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 23:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="658969597"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 May 2022 23:34:03 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npOsE-000LQK-S3;
        Fri, 13 May 2022 06:34:02 +0000
Date:   Fri, 13 May 2022 14:34:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     kbuild-all@lists.01.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>
Subject: Re: [PATCH] sched/core: add forced idle accounting for cgroups
Message-ID: <202205131429.4xuc9fjB-lkp@intel.com>
References: <20220513005427.2507335-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513005427.2507335-1-joshdon@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on tip/master linux/master linus/master v5.18-rc6 next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220513-085621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 734387ec2f9d77b00276042b1fa7c95f48ee879d
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220513/202205131429.4xuc9fjB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/21dca7763777c1985d6f5ac289e6e0c20d429d05
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220513-085621
        git checkout 21dca7763777c1985d6f5ac289e6e0c20d429d05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/core_sched.c: In function 'sched_core_rstat_flush':
   kernel/sched/core_sched.c:306:35: error: invalid use of undefined type 'struct task_group'
     306 |         struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
         |                                   ^~
   kernel/sched/core_sched.c:307:39: error: invalid use of undefined type 'struct task_group'
     307 |         struct task_group *parent = tg->parent;
         |                                       ^~
   kernel/sched/core_sched.c:319:19: error: invalid use of undefined type 'struct task_group'
     319 |         delta = tg->forceidle_sum_pending;
         |                   ^~
   kernel/sched/core_sched.c:321:19: error: invalid use of undefined type 'struct task_group'
     321 |                 tg->forceidle_sum_pending = 0;
         |                   ^~
   kernel/sched/core_sched.c:333:11: error: invalid use of undefined type 'struct task_group'
     333 |         tg->forceidle_sum += delta;
         |           ^~
   kernel/sched/core_sched.c:334:15: error: invalid use of undefined type 'struct task_group'
     334 |         parent->forceidle_sum_pending += delta;
         |               ^~
>> kernel/sched/core_sched.c:304:56: warning: parameter 'cpu' set but not used [-Wunused-but-set-parameter]
     304 | void sched_core_rstat_flush(struct task_group *tg, int cpu)
         |                                                    ~~~~^~~
   kernel/sched/core_sched.c: In function 'sched_core_forceidle_sum':
   kernel/sched/core_sched.c:340:16: error: invalid use of undefined type 'struct task_group'
     340 |         if (!tg->parent) {
         |                ^~
   kernel/sched/core_sched.c:353:26: error: invalid use of undefined type 'struct task_group'
     353 |                 return tg->forceidle_sum;
         |                          ^~
   kernel/sched/core_sched.c:355:1: error: control reaches end of non-void function [-Werror=return-type]
     355 | }
         | ^
   cc1: some warnings being treated as errors


vim +/cpu +304 kernel/sched/core_sched.c

   303	
 > 304	void sched_core_rstat_flush(struct task_group *tg, int cpu)
   305	{
   306		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
   307		struct task_group *parent = tg->parent;
   308		u64 delta, curr_sum;
   309	
   310		/* root uses cpustat */
   311		if (!parent)
   312			return;
   313	
   314		/*
   315		 * Note: cgroup_rstat_lock protects cfs_rq->forceidle_sum_prev and
   316		 * tg->{forceidle_sum, forceidle_sum_pending}.
   317		 */
   318	
   319		delta = tg->forceidle_sum_pending;
   320		if (delta)
 > 321			tg->forceidle_sum_pending = 0;
   322	
   323		/* rq lock not held; value may change concurrently */
   324		curr_sum = READ_ONCE(cfs_rq->forceidle_sum);
   325		if (curr_sum != cfs_rq->forceidle_sum_prev) {
   326			delta += curr_sum - cfs_rq->forceidle_sum_prev;
   327			cfs_rq->forceidle_sum_prev = curr_sum;
   328		}
   329	
   330		if (!delta)
   331			return;
   332	
   333		tg->forceidle_sum += delta;
   334		parent->forceidle_sum_pending += delta;
   335	}
   336	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
