Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E65274DF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 03:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiEOBpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 21:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiEOBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 21:44:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878DD3EB8F
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 18:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652579097; x=1684115097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c8F5ZvultSFrPTnzTi02skO4Qqna3iIHgrtHNcAITDM=;
  b=G5xBF/RViegvtKXQz+yB5otcFoxRosVGN1gyNk9tjZhbKG6zU72z5cST
   c0Egv8O/NOpyVTgA6tFDX3WtvMxYOmT9nfqpGA/jHiILRTIaYKMT7YkBu
   Ti76VS+9xZEO/XpksPWJjk+g9Co2RXVQK9SoQkAH07Z4CZORPWtlk6BIg
   MrA2/d5wi9tCY/qJC9qph1pGS6e+xNJGiE7vILiegZ4UMtDpE9TYcgpbS
   dRa/nPEkQkRJF/PVZUiprrtY6Py6O+P4HuHqjvClYmMLlwYlXJSusrTsD
   OFXSKfuAAVQf/yctrNyRpyjCLH3RtcObPyORBvrcbM+Z0faKuckhtiW1e
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="270707233"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="270707233"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 18:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="659634067"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2022 18:44:53 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq3JU-0001CD-Mn;
        Sun, 15 May 2022 01:44:52 +0000
Date:   Sun, 15 May 2022 09:43:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Lukasz Luba <lukasz.luba@arm.com>, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Subject: Re: [PATCH] sched/rt: Support multi-criterion fitness search for
Message-ID: <202205150940.Pgx1V75s-lkp@intel.com>
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
config: hexagon-buildonly-randconfig-r005-20220515 (https://download.01.org/0day-ci/archive/20220515/202205150940.Pgx1V75s-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0eee64011b1d43795b5c8d1aa62927ba3f07a225
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qais-Yousef/sched-rt-Support-multi-criterion-fitness-search-for/20220515-075732
        git checkout 0eee64011b1d43795b5c8d1aa62927ba3f07a225
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:45:
   kernel/sched/rt.c:259:6: warning: no previous prototype for function 'unregister_rt_sched_group' [-Wmissing-prototypes]
   void unregister_rt_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/rt.c:259:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_rt_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/rt.c:261:6: warning: no previous prototype for function 'free_rt_sched_group' [-Wmissing-prototypes]
   void free_rt_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/rt.c:261:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_rt_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/rt.c:263:5: warning: no previous prototype for function 'alloc_rt_sched_group' [-Wmissing-prototypes]
   int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/rt.c:263:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
>> kernel/sched/rt.c:2496:13: warning: no previous prototype for function 'init_sched_rt_fitness_mask' [-Wmissing-prototypes]
   void __init init_sched_rt_fitness_mask(int cpu)
               ^
   kernel/sched/rt.c:2496:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init init_sched_rt_fitness_mask(int cpu)
   ^
   static 
   4 warnings generated.


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
