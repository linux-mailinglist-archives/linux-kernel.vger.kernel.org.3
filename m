Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0216659669E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiHQBWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHQBWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:22:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9768B98D;
        Tue, 16 Aug 2022 18:22:30 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6qvN5fCszmVm6;
        Wed, 17 Aug 2022 09:20:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:22:28 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:22:27 +0800
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
CC:     <kbuild-all@lists.01.org>
References: <20220816124839.1911-3-thunder.leizhen@huawei.com>
 <202208170309.j1yYU9wN-lkp@intel.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1d0fdfb2-a134-546a-9159-8392d99f25c4@huawei.com>
Date:   Wed, 17 Aug 2022 09:22:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202208170309.j1yYU9wN-lkp@intel.com>
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



On 2022/8/17 3:55, kernel test robot wrote:
> Hi Zhen,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on paulmck-rcu/dev]
> [also build test WARNING on linus/master v6.0-rc1 next-20220816]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> config: x86_64-randconfig-a004-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170309.j1yYU9wN-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/a1d5079765918764de3ff6e3e63fa2db7f7c14df
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Zhen-Lei/rcu-nocb-Delete-local-variable-need_rcu_nocb_mask-in-rcu_init_nohz/20220816-205131
>         git checkout a1d5079765918764de3ff6e3e63fa2db7f7c14df
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/tree.c:4801:
>    kernel/rcu/tree_nocb.h: In function 'rcu_init_nohz':
>>> kernel/rcu/tree_nocb.h:1216:17: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>     1216 |         cpumask = cpu_possible_mask;
>          |                 ^
> 
> 
> vim +/const +1216 kernel/rcu/tree_nocb.h

It's a shame. Sorry, I forgot to check "> error.txt".

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
