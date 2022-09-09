Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA85B2B67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIIBNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIIBNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:13:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DB7C0BF7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662686024; x=1694222024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dtTxRr3rCqwFdZpT9ahFuDM4MIQN+cIf0773uq3XX54=;
  b=eHwkS4L6hVtlgVAWt68ULRH6DU0dMN4+yMSdhwKs8PHC3kDCv+z+9QFp
   XJ2OEKObjrimQqWQsFqd61CRQxAID6MkRxxQsHMfMu0LeQ2E99/jreDhu
   i6Td/+zC1DtvYz0U3kg2YoxYtOwQ6Go+ngiLKZmDL0m/ZpHKnNBkxrdyN
   7IRXaQlSqVq1n0h9hZ3qzVzAJClm53XmriSsZo/2q874jsRUW3L0Cs2hi
   0xX65cNdzJzR/8OPw++xKXmQ0jUUSiSuc9oWtfOR8PAFFoROm8GpA2/25
   sG/YABYaNvs/nNROAyjZN18Ue9w2/ZIgbrSka54sk9/e5eMVlDMCqUAbf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277100412"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="277100412"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 18:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="718787718"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Sep 2022 18:13:39 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWSaR-0000XB-0D;
        Fri, 09 Sep 2022 01:13:39 +0000
Date:   Fri, 9 Sep 2022 09:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 4/7] sched: Introduce affinity_context structure
Message-ID: <202209090937.23d2iFjb-lkp@intel.com>
References: <20220908194121.858462-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908194121.858462-5-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v6.0-rc4]
[cannot apply to tip/sched/core tip/master next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/sched-Persistent-user-requested-affinity/20220909-034411
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 506357871c18e06565840d71c2ef9f818e19f460
config: arm-randconfig-r033-20220907 (https://download.01.org/0day-ci/archive/20220909/202209090937.23d2iFjb-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/039ce835b17cfa35f47f3cb5fd4938e57643cb63
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Waiman-Long/sched-Persistent-user-requested-affinity/20220909-034411
        git checkout 039ce835b17cfa35f47f3cb5fd4938e57643cb63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/core.c:6602:35: warning: no previous prototype for function 'schedule_user' [-Wmissing-prototypes]
   asmlinkage __visible void __sched schedule_user(void)
                                     ^
   kernel/sched/core.c:6602:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage __visible void __sched schedule_user(void)
                        ^
                        static 
>> kernel/sched/core.c:8104:40: error: too few arguments to function call, expected 3, have 2
           retval = __set_cpus_allowed_ptr(p, ctx);
                    ~~~~~~~~~~~~~~~~~~~~~~       ^
   kernel/sched/core.c:3555:19: note: '__set_cpus_allowed_ptr' declared here
   static inline int __set_cpus_allowed_ptr(struct task_struct *p,
                     ^
   kernel/sched/core.c:8972:26: warning: unused variable 'ac' [-Wunused-variable]
           struct affinity_context ac;
                                   ^
   2 warnings and 1 error generated.


vim +8104 kernel/sched/core.c

  8079	
  8080	static int
  8081	__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
  8082	{
  8083		int retval;
  8084		cpumask_var_t cpus_allowed, new_mask;
  8085	
  8086		if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
  8087			return -ENOMEM;
  8088	
  8089		if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
  8090			retval = -ENOMEM;
  8091			goto out_free_cpus_allowed;
  8092		}
  8093	
  8094		cpuset_cpus_allowed(p, cpus_allowed);
  8095		cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
  8096	
  8097		ctx->new_mask = new_mask;
  8098		ctx->flags |= SCA_CHECK;
  8099	
  8100		retval = dl_task_check_affinity(p, new_mask);
  8101		if (retval)
  8102			goto out_free_new_mask;
  8103	again:
> 8104		retval = __set_cpus_allowed_ptr(p, ctx);
  8105		if (retval)
  8106			goto out_free_new_mask;
  8107	
  8108		cpuset_cpus_allowed(p, cpus_allowed);
  8109		if (!cpumask_subset(new_mask, cpus_allowed)) {
  8110			/*
  8111			 * We must have raced with a concurrent cpuset update.
  8112			 * Just reset the cpumask to the cpuset's cpus_allowed.
  8113			 */
  8114			cpumask_copy(new_mask, cpus_allowed);
  8115			goto again;
  8116		}
  8117	
  8118	out_free_new_mask:
  8119		free_cpumask_var(new_mask);
  8120	out_free_cpus_allowed:
  8121		free_cpumask_var(cpus_allowed);
  8122		return retval;
  8123	}
  8124	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
