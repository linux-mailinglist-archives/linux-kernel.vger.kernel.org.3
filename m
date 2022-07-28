Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F355836F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiG1CfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiG1CfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:35:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942CB192;
        Wed, 27 Jul 2022 19:35:06 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LtZTY5LT8z9syc;
        Thu, 28 Jul 2022 10:33:53 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 10:35:04 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 10:35:04 +0800
Subject: Re: [PATCH] rcu: Display registers of self-detected stall as far as
 possible
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
References: <20220727060929.1149-1-thunder.leizhen@huawei.com>
 <202207280520.yvgjXjJx-lkp@intel.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fad2fcf8-9dd9-e2dc-dc04-203311ade6c9@huawei.com>
Date:   Thu, 28 Jul 2022 10:35:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202207280520.yvgjXjJx-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/28 5:12, kernel test robot wrote:
> Hi Zhen,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on paulmck-rcu/dev]
> [also build test ERROR on linus/master v5.19-rc8 next-20220727]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/rcu-Display-registers-of-self-detected-stall-as-far-as-possible/20220727-141107
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220728/202207280520.yvgjXjJx-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/9f3fe5a0e46546db5bcfd1f33f12d87339e5de98
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Zhen-Lei/rcu-Display-registers-of-self-detected-stall-as-far-as-possible/20220727-141107
>         git checkout 9f3fe5a0e46546db5bcfd1f33f12d87339e5de98
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/tree.c:4641:
>>> kernel/rcu/tree_stall.h:358:10: error: call to undeclared function 'get_irq_regs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    regs = get_irq_regs();

OK, I will fix it in v2, thanks.

>                           ^
>>> kernel/rcu/tree_stall.h:358:8: error: incompatible integer to pointer conversion assigning to 'struct pt_regs *' from 'int' [-Wint-conversion]
>                    regs = get_irq_regs();
>                         ^ ~~~~~~~~~~~~~~
>    2 errors generated.
> 
> 
> vim +/get_irq_regs +358 kernel/rcu/tree_stall.h
> 
>    352	
>    353	static void rcu_dump_cpu_task(int cpu)
>    354	{
>    355		if (cpu == smp_processor_id() && in_irq()) {
>    356			struct pt_regs *regs;
>    357	
>  > 358			regs = get_irq_regs();
>    359			if (regs) {
>    360				show_regs(regs);
>    361				return;
>    362			}
>    363		}
>    364	
>    365		dump_cpu_task(cpu);
>    366	}
>    367	
> 

-- 
Regards,
  Zhen Lei
