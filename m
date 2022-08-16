Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C5596362
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiHPT4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiHPT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:56:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693957962E;
        Tue, 16 Aug 2022 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660679764; x=1692215764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0EwQpfJ5on5K89En304TdU706UFm4II21M0QMOuWnIE=;
  b=ht3MFQU2jjY93X6a3ieZyEAaGAgzlmJ9BX5KOz7tQwCEF0sC+uPfHWey
   f75ZPLB0VrwuSYzFd4CgbDCFvh/aRpzALyV/S7P0IZvkM364S4nG/hIKD
   Y/dxg4mSIo5h5QlfluwJV4I9ryI13rNBO77yJdygj1g8x1QA8XZF5s8am
   I0U4slC+zkRBBw6+S4yyGvhi8FMvQpHddwVpk8r5Y+Yaz42q4LaPaLu3X
   F/pY98OKetv5PbOlKzhl4+Szx/zTlVBZVyO4QW9igbRi5v5o6A0wXkGMZ
   M1nFyjp9SxEG4BrXZbpyJpRaLOZUokYUAny4EFdV4mYcPNy2XqVYXDJvO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="289887554"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="289887554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 12:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="749433429"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 12:56:01 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO2fQ-0000CC-19;
        Tue, 16 Aug 2022 19:56:00 +0000
Date:   Wed, 17 Aug 2022 03:55:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3 2/2] rcu: Simplify the code logic of rcu_init_nohz()
Message-ID: <202208170309.j1yYU9wN-lkp@intel.com>
References: <20220816124839.1911-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816124839.1911-3-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on paulmck-rcu/dev]
[also build test WARNING on linus/master v6.0-rc1 next-20220816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: x86_64-randconfig-a004-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170309.j1yYU9wN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a1d5079765918764de3ff6e3e63fa2db7f7c14df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
        git checkout a1d5079765918764de3ff6e3e63fa2db7f7c14df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4801:
   kernel/rcu/tree_nocb.h: In function 'rcu_init_nohz':
>> kernel/rcu/tree_nocb.h:1216:17: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1216 |         cpumask = cpu_possible_mask;
         |                 ^


vim +/const +1216 kernel/rcu/tree_nocb.h

  1208	
  1209	void __init rcu_init_nohz(void)
  1210	{
  1211		int cpu;
  1212		struct rcu_data *rdp;
  1213		struct cpumask *cpumask = NULL;
  1214	
  1215	#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> 1216		cpumask = cpu_possible_mask;
  1217	#elif defined(CONFIG_NO_HZ_FULL)
  1218		if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
  1219			cpumask = tick_nohz_full_mask;
  1220	#endif
  1221	
  1222		if (cpumask) {
  1223			if (!cpumask_available(rcu_nocb_mask)) {
  1224				if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
  1225					pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
  1226					return;
  1227				}
  1228			}
  1229	
  1230			cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
  1231		}
  1232	
  1233		if (!cpumask_available(rcu_nocb_mask))
  1234			return;
  1235	
  1236		if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
  1237			pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
  1238			cpumask_and(rcu_nocb_mask, cpu_possible_mask,
  1239				    rcu_nocb_mask);
  1240		}
  1241		if (cpumask_empty(rcu_nocb_mask))
  1242			pr_info("\tOffload RCU callbacks from CPUs: (none).\n");
  1243		else
  1244			pr_info("\tOffload RCU callbacks from CPUs: %*pbl.\n",
  1245				cpumask_pr_args(rcu_nocb_mask));
  1246		if (rcu_nocb_poll)
  1247			pr_info("\tPoll for callbacks from no-CBs CPUs.\n");
  1248	
  1249		for_each_cpu(cpu, rcu_nocb_mask) {
  1250			rdp = per_cpu_ptr(&rcu_data, cpu);
  1251			if (rcu_segcblist_empty(&rdp->cblist))
  1252				rcu_segcblist_init(&rdp->cblist);
  1253			rcu_segcblist_offload(&rdp->cblist, true);
  1254			rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
  1255			rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
  1256		}
  1257		rcu_organize_nocb_kthreads();
  1258	}
  1259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
