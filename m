Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62235597AED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbiHRBUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHRBT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:19:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3257C9C1E5;
        Wed, 17 Aug 2022 18:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660785596; x=1692321596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wjx0XqD9cFjWyD1bNJ9K30XZBXls3j00dj3A2yk+2NU=;
  b=Ws1fJsFzAVqCOD2weFdZHBJmKPOHYHt/VYQWn+KscKc+l9m8Vopp0fJs
   XmpWNcVzTiasJIrp4zdNcIK+rmxvvUdxiEsdug0+atphMMkAI8lfC5i1B
   KJwbDQMGVZsXPV0TUGlr3qqFzQMNQ6GNv5oNF9dBwOgqgqyc7M/PVnpsI
   ndXLKWX1Dvz66iS4M40jYG6ceFeOfWV16pokQNQaVvSUsjQb9FtO4kkha
   AUzOegH6JMqkrFd8idO5uUkiYNhLGd1ilzKkn0ExuGPpkXYUYfx0MK/4G
   GTRqS03uPkK5ZrLgRBYYna7HW16MYyOFHYBuQ6FDFBO+GeTR/pxjOEYjm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293431273"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="293431273"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 18:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="640670392"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2022 18:19:51 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOUCN-0001YI-0L;
        Thu, 18 Aug 2022 01:19:51 +0000
Date:   Thu, 18 Aug 2022 09:19:17 +0800
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
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3 2/2] rcu: Simplify the code logic of rcu_init_nohz()
Message-ID: <202208180940.Jks0rOXz-lkp@intel.com>
References: <20220816124839.1911-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816124839.1911-3-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on linus/master v6.0-rc1 next-20220817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: hexagon-randconfig-r041-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180940.Jks0rOXz-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a1d5079765918764de3ff6e3e63fa2db7f7c14df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
        git checkout a1d5079765918764de3ff6e3e63fa2db7f7c14df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4801:
>> kernel/rcu/tree_nocb.h:1216:10: error: assigning to 'struct cpumask *' from 'const struct cpumask *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           cpumask = cpu_possible_mask;
                   ^ ~~~~~~~~~~~~~~~~~
   1 error generated.


vim +1216 kernel/rcu/tree_nocb.h

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
