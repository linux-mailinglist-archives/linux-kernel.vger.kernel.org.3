Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35145597B23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbiHRBgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiHRBgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:36:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF4A406A;
        Wed, 17 Aug 2022 18:36:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M7S7p3XvwzZfkK;
        Thu, 18 Aug 2022 09:33:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:36:32 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:36:31 +0800
Subject: Re: [PATCH v3 2/2] rcu: Simplify the code logic of rcu_init_nohz()
To:     kernel test robot <lkp@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>
References: <20220816124839.1911-3-thunder.leizhen@huawei.com>
 <202208180940.Jks0rOXz-lkp@intel.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9b5d69d3-a926-4111-af72-bd3edcc99e6f@huawei.com>
Date:   Thu, 18 Aug 2022 09:36:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202208180940.Jks0rOXz-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/18 9:19, kernel test robot wrote:
> Hi Zhen,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on paulmck-rcu/dev]
> [also build test ERROR on linus/master v6.0-rc1 next-20220817]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> config: hexagon-randconfig-r041-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180940.Jks0rOXz-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/a1d5079765918764de3ff6e3e63fa2db7f7c14df
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
>         git checkout a1d5079765918764de3ff6e3e63fa2db7f7c14df
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/tree.c:4801:
>>> kernel/rcu/tree_nocb.h:1216:10: error: assigning to 'struct cpumask *' from 'const struct cpumask *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>            cpumask = cpu_possible_mask;
>                    ^ ~~~~~~~~~~~~~~~~~
>    1 error generated.

I fixed it yesterday and post v4. Please check for v4.

> 
> 
> vim +1216 kernel/rcu/tree_nocb.h
> 
>   1208	
>   1209	void __init rcu_init_nohz(void)
>   1210	{
>   1211		int cpu;
>   1212		struct rcu_data *rdp;
>   1213		struct cpumask *cpumask = NULL;
>   1214	
>   1215	#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
>> 1216		cpumask = cpu_possible_mask;
>   1217	#elif defined(CONFIG_NO_HZ_FULL)
>   1218		if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
>   1219			cpumask = tick_nohz_full_mask;
>   1220	#endif
>   1221	
>   1222		if (cpumask) {
>   1223			if (!cpumask_available(rcu_nocb_mask)) {
>   1224				if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
>   1225					pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
>   1226					return;
>   1227				}
>   1228			}
>   1229	
>   1230			cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
>   1231		}
>   1232	
>   1233		if (!cpumask_available(rcu_nocb_mask))
>   1234			return;
>   1235	
>   1236		if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>   1237			pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>   1238			cpumask_and(rcu_nocb_mask, cpu_possible_mask,
>   1239				    rcu_nocb_mask);
>   1240		}
>   1241		if (cpumask_empty(rcu_nocb_mask))
>   1242			pr_info("\tOffload RCU callbacks from CPUs: (none).\n");
>   1243		else
>   1244			pr_info("\tOffload RCU callbacks from CPUs: %*pbl.\n",
>   1245				cpumask_pr_args(rcu_nocb_mask));
>   1246		if (rcu_nocb_poll)
>   1247			pr_info("\tPoll for callbacks from no-CBs CPUs.\n");
>   1248	
>   1249		for_each_cpu(cpu, rcu_nocb_mask) {
>   1250			rdp = per_cpu_ptr(&rcu_data, cpu);
>   1251			if (rcu_segcblist_empty(&rdp->cblist))
>   1252				rcu_segcblist_init(&rdp->cblist);
>   1253			rcu_segcblist_offload(&rdp->cblist, true);
>   1254			rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
>   1255			rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
>   1256		}
>   1257		rcu_organize_nocb_kthreads();
>   1258	}
>   1259	
> 

-- 
Regards,
  Zhen Lei
