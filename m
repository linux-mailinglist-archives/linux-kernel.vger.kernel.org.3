Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFE556FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347078AbiFWBjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiFWBjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:39:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306D4161F;
        Wed, 22 Jun 2022 18:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655948344; x=1687484344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5RPKHZR/rmSIcjQzAuwrHX3MO023dyRepHj/Cf3fQUM=;
  b=jqpNlDOfbGkscEuSvOi9/XwZZd2KbCDPj3GYQn6k6qtkxW61Vmzg5VTp
   nNzhLkg7q4SYXS+I69C5ut/0tp1qi+akUFEOSdK95Hr1tRwBgYqL1n+aK
   K2kPERWzZwhJ19zHnooZBB6LfNUFBJnl8NONCtrTFl0+wPha1XObFWPAj
   IOrz8JEip2DWMJ8VpA7NlmRuHX0ZV53EkvYTxu3JPlBeE8uFliLcScrpy
   f4cpJ16rcUK27RNv14B4wZAa3ng/ejK/tXX0+i9v3ZjSgHQwt9yPKxv1H
   PTrVo57Fa7PL88oNzoMFJfAY3vVpWa0TR9mu+Knx73U5hwKc5rdSeph94
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263627236"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="263627236"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 18:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="677841420"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2022 18:39:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4BoC-0000K1-FA;
        Thu, 23 Jun 2022 01:39:00 +0000
Date:   Thu, 23 Jun 2022 09:38:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <202206230916.2YtpR3sO-lkp@intel.com>
References: <20220622225102.2112026-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Joel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc3 next-20220622]
[cannot apply to paulmck-rcu/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220623-065447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git de5c208d533a46a074eb46ea17f672cc005a7269
config: riscv-nommu_k210_defconfig (https://download.01.org/0day-ci/archive/20220623/202206230916.2YtpR3sO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/543ee31928d1cff057320ff64603283a34fe0052
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220623-065447
        git checkout 543ee31928d1cff057320ff64603283a34fe0052
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/rcu/tree.c:3103: warning: Function parameter or member 'lazy' not described in '__call_rcu_common'
>> kernel/rcu/tree.c:3103: warning: expecting prototype for call_rcu(). Prototype was for __call_rcu_common() instead


vim +3103 kernel/rcu/tree.c

b2b00ddf193bf83 kernel/rcu/tree.c Paul E. McKenney        2019-10-30  3060  
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3061  /**
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3062   * call_rcu() - Queue an RCU callback for invocation after a grace period.
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3063   * @head: structure to be used for queueing the RCU updates.
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3064   * @func: actual callback function to be invoked after the grace period
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3065   *
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3066   * The callback function will be invoked some time after a full grace
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3067   * period elapses, in other words after all pre-existing RCU read-side
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3068   * critical sections have completed.  However, the callback function
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3069   * might well execute concurrently with RCU read-side critical sections
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3070   * that started after call_rcu() was invoked.
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3071   *
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3072   * RCU read-side critical sections are delimited by rcu_read_lock()
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3073   * and rcu_read_unlock(), and may be nested.  In addition, but only in
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3074   * v5.0 and later, regions of code across which interrupts, preemption,
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3075   * or softirqs have been disabled also serve as RCU read-side critical
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3076   * sections.  This includes hardware interrupt handlers, softirq handlers,
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3077   * and NMI handlers.
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3078   *
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3079   * Note that all CPUs must agree that the grace period extended beyond
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3080   * all pre-existing RCU read-side critical section.  On systems with more
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3081   * than one CPU, this means that when "func()" is invoked, each CPU is
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3082   * guaranteed to have executed a full memory barrier since the end of its
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3083   * last RCU read-side critical section whose beginning preceded the call
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3084   * to call_rcu().  It also means that each CPU executing an RCU read-side
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3085   * critical section that continues beyond the start of "func()" must have
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3086   * executed a memory barrier after the call_rcu() but before the beginning
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3087   * of that RCU read-side critical section.  Note that these guarantees
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3088   * include CPUs that are offline, idle, or executing in user mode, as
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3089   * well as CPUs that are executing in the kernel.
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3090   *
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3091   * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3092   * resulting RCU callback function "func()", then both CPU A and CPU B are
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3093   * guaranteed to execute a full memory barrier during the time interval
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3094   * between the call to call_rcu() and the invocation of "func()" -- even
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3095   * if CPU A and CPU B are the same CPU (but again only if the system has
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3096   * more than one CPU).
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3097   *
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3098   * Implementation of these memory-ordering guarantees is described here:
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3099   * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3100   */
543ee31928d1cff kernel/rcu/tree.c Joel Fernandes (Google  2022-06-22  3101) static void
543ee31928d1cff kernel/rcu/tree.c Joel Fernandes (Google  2022-06-22  3102) __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18 @3103  {
b4b7914a6a73fc1 kernel/rcu/tree.c Paul E. McKenney        2020-12-08  3104  	static atomic_t doublefrees;
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3105  	unsigned long flags;
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3106  	struct rcu_data *rdp;
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3107  	bool was_alldone;
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3108  
b8f2ed538477d9a kernel/rcu/tree.c Paul E. McKenney        2016-08-23  3109  	/* Misaligned rcu_head! */
b8f2ed538477d9a kernel/rcu/tree.c Paul E. McKenney        2016-08-23  3110  	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
b8f2ed538477d9a kernel/rcu/tree.c Paul E. McKenney        2016-08-23  3111  
ae15018456c44b7 kernel/rcutree.c  Paul E. McKenney        2013-04-23  3112  	if (debug_rcu_head_queue(head)) {
fa3c66476975abf kernel/rcu/tree.c Paul E. McKenney        2017-05-03  3113  		/*
fa3c66476975abf kernel/rcu/tree.c Paul E. McKenney        2017-05-03  3114  		 * Probable double call_rcu(), so leak the callback.
fa3c66476975abf kernel/rcu/tree.c Paul E. McKenney        2017-05-03  3115  		 * Use rcu:rcu_callback trace event to find the previous
1fe09ebe7a9c990 kernel/rcu/tree.c Paul E. McKenney        2021-12-18  3116  		 * time callback was passed to call_rcu().
fa3c66476975abf kernel/rcu/tree.c Paul E. McKenney        2017-05-03  3117  		 */
b4b7914a6a73fc1 kernel/rcu/tree.c Paul E. McKenney        2020-12-08  3118  		if (atomic_inc_return(&doublefrees) < 4) {
b4b7914a6a73fc1 kernel/rcu/tree.c Paul E. McKenney        2020-12-08  3119  			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
b4b7914a6a73fc1 kernel/rcu/tree.c Paul E. McKenney        2020-12-08  3120  			mem_dump_obj(head);
b4b7914a6a73fc1 kernel/rcu/tree.c Paul E. McKenney        2020-12-08  3121  		}
7d0ae8086b82831 kernel/rcu/tree.c Paul E. McKenney        2015-03-03  3122  		WRITE_ONCE(head->func, rcu_leak_callback);
ae15018456c44b7 kernel/rcutree.c  Paul E. McKenney        2013-04-23  3123  		return;
ae15018456c44b7 kernel/rcutree.c  Paul E. McKenney        2013-04-23  3124  	}
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3125  	head->func = func;
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3126  	head->next = NULL;
300c0c5e721834f kernel/rcu/tree.c Jun Miao                2021-11-16  3127  	kasan_record_aux_stack_noalloc(head);
d818cc76e2b4d5f kernel/rcu/tree.c Zqiang                  2021-12-26  3128  	local_irq_save(flags);
da1df50d16171f4 kernel/rcu/tree.c Paul E. McKenney        2018-07-03  3129  	rdp = this_cpu_ptr(&rcu_data);
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3130  
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3131  	/* Add the callback to our list. */
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3132  	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3133  		// This can trigger due to call_rcu() from offline CPU:
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3134  		WARN_ON_ONCE(rcu_scheduler_active != RCU_SCHEDULER_INACTIVE);
34404ca8fb252cc kernel/rcu/tree.c Paul E. McKenney        2015-01-19  3135  		WARN_ON_ONCE(!rcu_is_watching());
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3136  		// Very early boot, before rcu_init().  Initialize if needed
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3137  		// and then drop through to queue the callback.
15fecf89e46a962 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  3138  		if (rcu_segcblist_empty(&rdp->cblist))
15fecf89e46a962 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  3139  			rcu_segcblist_init(&rdp->cblist);
143da9c2fc030a5 kernel/rcu/tree.c Paul E. McKenney        2015-01-19  3140  	}
77a40f97030b27b kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  3141) 
b2b00ddf193bf83 kernel/rcu/tree.c Paul E. McKenney        2019-10-30  3142  	check_cb_ovld(rdp);
543ee31928d1cff kernel/rcu/tree.c Joel Fernandes (Google  2022-06-22  3143) 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
d1b222c6be1f8bf kernel/rcu/tree.c Paul E. McKenney        2019-07-02  3144  		return; // Enqueued onto ->nocb_bypass, so just leave.
b692dc4adfcff54 kernel/rcu/tree.c Paul E. McKenney        2020-02-11  3145  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
77a40f97030b27b kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  3146) 	rcu_segcblist_enqueue(&rdp->cblist, head);
c408b215f58f715 kernel/rcu/tree.c Uladzislau Rezki (Sony  2020-05-25  3147) 	if (__is_kvfree_rcu_offset((unsigned long)func))
c408b215f58f715 kernel/rcu/tree.c Uladzislau Rezki (Sony  2020-05-25  3148) 		trace_rcu_kvfree_callback(rcu_state.name, head,
3c779dfef2c4524 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  3149  					 (unsigned long)func,
15fecf89e46a962 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  3150  					 rcu_segcblist_n_cbs(&rdp->cblist));
d4c08f2ac311a36 kernel/rcutree.c  Paul E. McKenney        2011-06-25  3151  	else
3c779dfef2c4524 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  3152  		trace_rcu_callback(rcu_state.name, head,
15fecf89e46a962 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  3153  				   rcu_segcblist_n_cbs(&rdp->cblist));
d4c08f2ac311a36 kernel/rcutree.c  Paul E. McKenney        2011-06-25  3154  
3afe7fa535491ec kernel/rcu/tree.c Joel Fernandes (Google  2020-11-14  3155) 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
3afe7fa535491ec kernel/rcu/tree.c Joel Fernandes (Google  2020-11-14  3156) 
29154c57e35a191 kernel/rcutree.c  Paul E. McKenney        2012-05-30  3157  	/* Go handle any RCU core processing required. */
3820b513a2e33d6 kernel/rcu/tree.c Frederic Weisbecker     2020-11-12  3158  	if (unlikely(rcu_rdp_is_offloaded(rdp))) {
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3159  		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3160  	} else {
5c7d89676bc5196 kernel/rcu/tree.c Paul E. McKenney        2018-07-03  3161  		__call_rcu_core(rdp, head, flags);
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3162  		local_irq_restore(flags);
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3163  	}
5d6742b37727e11 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  3164  }
64db4cfff99c04c kernel/rcutree.c  Paul E. McKenney        2008-12-18  3165  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
