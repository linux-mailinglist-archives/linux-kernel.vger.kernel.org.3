Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA553D8AB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 23:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbiFDVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 17:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiFDVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 17:49:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A21114A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654379395; x=1685915395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wUm9xelcIQqhoopPywKR+bku9RE4WkYy+McCJUpUrAw=;
  b=aFlaGGwkQc2TbjquRlae3OrCYw3Q9ojFpEvq0zfW2CTv9HrCvbK35/Yj
   A0H1QUSSJH2q4UmCILfV8sTtZ11IDqrwYLJUQ4J56BPTDHm0vcoCRRoFQ
   R6VDA7Ulhk7z9HrnL/xs2dzx4cejLKtNrXA03KIdznHPRsCjtuKz1Krco
   kd92mMvg0InYOqd+sf9AIZ6m5NvLA0ZSGNv3sjgt49nDH8JlJ6F4Al+jm
   Bra3XTX/kadqJVunA3bVDD65GwGJ9I3OCs+kbiEr1C3LewfV2yTp4YFYe
   j/olwwOsa5TAN9TdsCSzsqCdM9eqsszwaNo+m+ogdGV45yi72A2Grs5Pf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="275281255"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="275281255"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 14:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="531483557"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jun 2022 14:49:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxbeb-000BEj-9I;
        Sat, 04 Jun 2022 21:49:53 +0000
Date:   Sun, 5 Jun 2022 05:49:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v4 9/20]
 kernel/softirq.c:610: undefined reference to `ct_irq_enter'
Message-ID: <202206050548.DSjyYju7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v4
head:   77493b1db618c61dec140cbab830832f77203d69
commit: ede17b80373d0c3e886b3b4d9533f6c12cf1e799 [9/20] context_tracking: Take IRQ eqs entrypoints over RCU
config: x86_64-randconfig-a008 (https://download.01.org/0day-ci/archive/20220605/202206050548.DSjyYju7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=ede17b80373d0c3e886b3b4d9533f6c12cf1e799
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v4
        git checkout ede17b80373d0c3e886b3b4d9533f6c12cf1e799
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable instruction
   ld: vmlinux.o: in function `irq_enter':
>> kernel/softirq.c:610: undefined reference to `ct_irq_enter'
   ld: vmlinux.o: in function `irq_exit':
>> kernel/softirq.c:662: undefined reference to `ct_irq_exit'
   ld: vmlinux.o: in function `trace_console_rcuidle':
>> include/trace/events/printk.h:10: undefined reference to `ct_irq_enter_irqson'
>> ld: include/trace/events/printk.h:10: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `bc_set_next':
>> kernel/time/tick-broadcast-hrtimer.c:64: undefined reference to `ct_irq_enter_irqson'
>> ld: kernel/time/tick-broadcast-hrtimer.c:64: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_irq_disable_rcuidle':
>> include/trace/events/preemptirq.h:36: undefined reference to `ct_irq_enter_irqson'
>> ld: include/trace/events/preemptirq.h:36: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_irq_enable_rcuidle':
   include/trace/events/preemptirq.h:40: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/preemptirq.h:40: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_clk_disable_rcuidle':
>> include/trace/events/clk.h:46: undefined reference to `ct_irq_enter_irqson'
>> ld: include/trace/events/clk.h:46: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_clk_disable_complete_rcuidle':
   include/trace/events/clk.h:53: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/clk.h:53: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_clk_enable_rcuidle':
   include/trace/events/clk.h:32: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/clk.h:32: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_clk_enable_complete_rcuidle':
   include/trace/events/clk.h:39: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/clk.h:39: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `irqentry_exit':
>> kernel/entry/common.c:421: undefined reference to `ct_irq_exit'
>> ld: kernel/entry/common.c:439: undefined reference to `ct_irq_exit'


vim +610 kernel/softirq.c

   604	
   605	/**
   606	 * irq_enter - Enter an interrupt context including RCU update
   607	 */
   608	void irq_enter(void)
   609	{
 > 610		ct_irq_enter();
   611		irq_enter_rcu();
   612	}
   613	
   614	static inline void tick_irq_exit(void)
   615	{
   616	#ifdef CONFIG_NO_HZ_COMMON
   617		int cpu = smp_processor_id();
   618	
   619		/* Make sure that timer wheel updates are propagated */
   620		if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
   621			if (!in_hardirq())
   622				tick_nohz_irq_exit();
   623		}
   624	#endif
   625	}
   626	
   627	static inline void __irq_exit_rcu(void)
   628	{
   629	#ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
   630		local_irq_disable();
   631	#else
   632		lockdep_assert_irqs_disabled();
   633	#endif
   634		account_hardirq_exit(current);
   635		preempt_count_sub(HARDIRQ_OFFSET);
   636		if (!in_interrupt() && local_softirq_pending())
   637			invoke_softirq();
   638	
   639		tick_irq_exit();
   640	}
   641	
   642	/**
   643	 * irq_exit_rcu() - Exit an interrupt context without updating RCU
   644	 *
   645	 * Also processes softirqs if needed and possible.
   646	 */
   647	void irq_exit_rcu(void)
   648	{
   649		__irq_exit_rcu();
   650		 /* must be last! */
   651		lockdep_hardirq_exit();
   652	}
   653	
   654	/**
   655	 * irq_exit - Exit an interrupt context, update RCU and lockdep
   656	 *
   657	 * Also processes softirqs if needed and possible.
   658	 */
   659	void irq_exit(void)
   660	{
   661		__irq_exit_rcu();
 > 662		ct_irq_exit();
   663		 /* must be last! */
   664		lockdep_hardirq_exit();
   665	}
   666	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
