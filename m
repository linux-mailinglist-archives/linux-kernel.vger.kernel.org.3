Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F55597992
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiHQWQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiHQWQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:16:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B769A99FC;
        Wed, 17 Aug 2022 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660774607; x=1692310607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/P92gqk+BeZiy3uuyTljauK8Mls5EZ+vGEZqMfpHoKc=;
  b=XLcSWtE2RGWFxAh/Qo4dtip5ACon1iWwBlUUxUo//hvq7drGDnGjrvx5
   qr9MoF8TaUiiT/8Xrpg1bmXWx5cyGuASlYtwyjzyDeLvMGfnkWNBS24JO
   58fwzc2uuXf9Dtj6YTVRgz+EON4lXZsbtXs8PAOIx+NuptR8IKEGkywjc
   osvCQS5RxU/5AMe6QEg46OxvH5n6Z8wrihAsu4QuvlIovq4W6YuMUKojo
   Mo28EnsBpUxzVeokc/hPTrQxyArzpuIseAcmgQpcQXkLqSvb3l7z+GVeU
   X98NmM27NeR6ouq3TqqPQb+G2edkfr1WESlC+DHADWY26Ollw0kH52Cjv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356607496"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="356607496"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 15:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="675811988"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 15:16:37 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oORL3-0001Or-10;
        Wed, 17 Aug 2022 22:16:37 +0000
Date:   Thu, 18 Aug 2022 06:16:14 +0800
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
Message-ID: <202208180612.UVvfRJSR-lkp@intel.com>
References: <20220816124839.1911-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816124839.1911-3-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on paulmck-rcu/dev]
[also build test WARNING on linus/master v6.0-rc1 next-20220817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: s390-randconfig-s052-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180612.UVvfRJSR-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a1d5079765918764de3ff6e3e63fa2db7f7c14df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
        git checkout a1d5079765918764de3ff6e3e63fa2db7f7c14df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_nocb.h:1216:17: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct cpumask *cpumask @@     got struct cpumask const * @@
   kernel/rcu/tree_nocb.h:1216:17: sparse:     expected struct cpumask *cpumask
   kernel/rcu/tree_nocb.h:1216:17: sparse:     got struct cpumask const *
   kernel/rcu/tree.c:1032:9: sparse: sparse: context imbalance in 'rcu_start_this_gp' - different lock contexts for basic block
   kernel/rcu/tree.c:1413:9: sparse: sparse: context imbalance in 'rcu_poll_gp_seq_start_unlocked' - different lock contexts for basic block
   kernel/rcu/tree.c:1428:9: sparse: sparse: context imbalance in 'rcu_poll_gp_seq_end_unlocked' - different lock contexts for basic block
   kernel/rcu/tree.c:1544:9: sparse: sparse: context imbalance in 'rcu_gp_init' - different lock contexts for basic block
   kernel/rcu/tree.c:2004:1: sparse: sparse: context imbalance in 'rcu_report_qs_rdp' - different lock contexts for basic block
   kernel/rcu/tree.c:2186:13: sparse: sparse: context imbalance in 'rcu_do_batch' - wrong count at exit
   kernel/rcu/tree.c:2371:9: sparse: sparse: context imbalance in 'force_qs_rnp' - different lock contexts for basic block
   kernel/rcu/tree.c:2424:25: sparse: sparse: context imbalance in 'rcu_force_quiescent_state' - unexpected unlock
   kernel/rcu/tree.c:2454:30: sparse: sparse: context imbalance in 'rcu_core' - different lock contexts for basic block
   kernel/rcu/tree.c: note: in included file:
   kernel/rcu/tree_exp.h:191:9: sparse: sparse: context imbalance in '__rcu_report_exp_rnp' - different lock contexts for basic block
   kernel/rcu/tree_exp.h:1032:9: sparse: sparse: context imbalance in 'start_poll_synchronize_rcu_expedited' - different lock contexts for basic block
   kernel/rcu/tree.c: note: in included file:
   kernel/rcu/tree_nocb.h:134:16: sparse: sparse: context imbalance in 'rcu_nocb_bypass_trylock' - wrong count at exit
   kernel/rcu/tree_nocb.h:151:13: sparse: sparse: context imbalance in 'rcu_nocb_lock' - wrong count at exit
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: context imbalance in 'rcu_nocb_unlock' - unexpected unlock
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: context imbalance in 'rcu_nocb_unlock_irqrestore' - unexpected unlock
   kernel/rcu/tree_nocb.h:312:9: sparse: sparse: context imbalance in 'rcu_nocb_do_flush_bypass' - unexpected unlock
   kernel/rcu/tree_nocb.h:327:13: sparse: sparse: context imbalance in 'rcu_nocb_flush_bypass' - wrong count at exit
   kernel/rcu/tree_nocb.h:489:13: sparse: sparse: context imbalance in '__call_rcu_nocb_wake' - wrong count at exit
   kernel/rcu/tree_nocb.h:581:9: sparse: sparse: context imbalance in 'nocb_gp_toggle_rdp' - wrong count at exit
   kernel/rcu/tree_nocb.h:635:9: sparse: sparse: context imbalance in 'nocb_gp_wait' - different lock contexts for basic block
   kernel/rcu/tree_nocb.h:888:9: sparse: sparse: context imbalance in 'nocb_cb_wait' - wrong count at exit
   kernel/rcu/tree_nocb.h:1002:9: sparse: sparse: context imbalance in 'rdp_offload_toggle' - wrong count at exit
   kernel/rcu/tree_nocb.h:1086:34: sparse: sparse: context imbalance in 'rcu_nocb_rdp_deoffload' - different lock contexts for basic block
   kernel/rcu/tree_nocb.h:1124:13: sparse: sparse: context imbalance in 'rcu_nocb_rdp_offload' - different lock contexts for basic block

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
