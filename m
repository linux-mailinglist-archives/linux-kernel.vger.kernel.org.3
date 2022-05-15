Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40A5274D3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 03:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiEOAyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 20:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiEOAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 20:53:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D381626E
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 17:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652576035; x=1684112035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mby6oFwiZLrFRKWGPHvOQ+mlKgyeKPUM3Ufx5Iclavg=;
  b=nr0a+uZ9zJHIVi44FBr11SAHI6xzjt3T6BwIwDRLgNjc44taB3dEYXXk
   wdw+Kj0xD/kVsM/65bhEPFriizE4lOP7+BPtFo8/QAcZ1CrdOOglz/zMR
   GOorxxmJulZ+Xaqtd3QNObUsYl2EWo6Bk87HtVtq8yCdccclGMF0mO6Kv
   UAh1RLWZTSLUfod0PjWmx8wLaUWrnMQ76c9c+BRBmd48s1MJHK5DNxiqt
   bd0H3hiE1ruhDE1eh3NmoVs/vm71r8X7XY/zB6IIk5tgP0m/Lbldbl38/
   Ssf7z0GbcicMcxPSFa/lhph/EWmTEeQhZjgaXq4qI1hGXqmgEghcgkM6B
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="270703784"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="270703784"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 17:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="671847696"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 May 2022 17:53:51 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq2W6-00019p-VW;
        Sun, 15 May 2022 00:53:50 +0000
Date:   Sun, 15 May 2022 08:53:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     kbuild-all@lists.01.org, Lukasz Luba <lukasz.luba@arm.com>,
        dietmar.eggemann@arm.com, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Subject: Re: [PATCH] sched/rt: Support multi-criterion fitness search for
Message-ID: <202205150843.y0w5RC5K-lkp@intel.com>
References: <20220514235513.jm7ul2y6uddj6eh2@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514235513.jm7ul2y6uddj6eh2@airbuntu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qais-Yousef/sched-rt-Support-multi-criterion-fitness-search-for/20220515-075732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 734387ec2f9d77b00276042b1fa7c95f48ee879d
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220515/202205150843.y0w5RC5K-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0eee64011b1d43795b5c8d1aa62927ba3f07a225
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qais-Yousef/sched-rt-Support-multi-criterion-fitness-search-for/20220515-075732
        git checkout 0eee64011b1d43795b5c8d1aa62927ba3f07a225
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:45:
   kernel/sched/rt.c:259:6: warning: no previous prototype for 'unregister_rt_sched_group' [-Wmissing-prototypes]
     259 | void unregister_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:261:6: warning: no previous prototype for 'free_rt_sched_group' [-Wmissing-prototypes]
     261 | void free_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:263:5: warning: no previous prototype for 'alloc_rt_sched_group' [-Wmissing-prototypes]
     263 | int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~
>> kernel/sched/rt.c:2496:13: warning: no previous prototype for 'init_sched_rt_fitness_mask' [-Wmissing-prototypes]
    2496 | void __init init_sched_rt_fitness_mask(int cpu)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sched/build_utility.c:87:
   kernel/sched/cpupri.c: In function 'cpupri_find_fitness':
>> kernel/sched/cpupri.c:255:27: warning: array subscript 0 is outside array bounds of 'bool[0]' {aka '_Bool[]'} [-Warray-bounds]
     255 |         if (fallback_found[0]) {
         |             ~~~~~~~~~~~~~~^~~
   kernel/sched/cpupri.c:148:14: note: while referencing 'fallback_found'
     148 |         bool fallback_found[NUM_FITNESS_FN];
         |              ^~~~~~~~~~~~~~
   kernel/sched/cpupri.c:180:36: warning: array subscript 0 is outside array bounds of 'bool[0]' {aka '_Bool[]'} [-Warray-bounds]
     180 |                 if (!fallback_found[0]) {
         |                      ~~~~~~~~~~~~~~^~~
   kernel/sched/cpupri.c:148:14: note: while referencing 'fallback_found'
     148 |         bool fallback_found[NUM_FITNESS_FN];
         |              ^~~~~~~~~~~~~~
   kernel/sched/cpupri.c:182:47: warning: array subscript 0 is outside array bounds of 'bool[0]' {aka '_Bool[]'} [-Warray-bounds]
     182 |                                 fallback_found[0] = true;
         |                                 ~~~~~~~~~~~~~~^~~
   kernel/sched/cpupri.c:148:14: note: while referencing 'fallback_found'
     148 |         bool fallback_found[NUM_FITNESS_FN];
         |              ^~~~~~~~~~~~~~


vim +/init_sched_rt_fitness_mask +2496 kernel/sched/rt.c

  2495	
> 2496	void __init init_sched_rt_fitness_mask(int cpu)
  2497	{
  2498		cpumask_var_t *fitness_mask_array;
  2499		unsigned int i;
  2500	
  2501		if (!NUM_FITNESS_FN)
  2502			return;
  2503	
  2504		fitness_mask_array = kcalloc_node(NUM_FITNESS_FN, sizeof(cpumask_var_t),
  2505						  GFP_KERNEL, cpu_to_node(cpu));
  2506	
  2507		per_cpu(local_cpu_fitness_mask, cpu) = fitness_mask_array;
  2508	
  2509		for (i = 0; i < NUM_FITNESS_FN; i++) {
  2510			zalloc_cpumask_var_node(&fitness_mask_array[i], GFP_KERNEL,
  2511						cpu_to_node(cpu));
  2512		}
  2513	}
  2514	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
