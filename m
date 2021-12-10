Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBBA46FB94
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhLJHef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:34:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:49408 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhLJHee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639121459; x=1670657459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6F7J7wB5OupPxBTL1c7gHPRx1aXMilaoOzruQyXy+xQ=;
  b=n1HzFNq4WjVLPCcJJWoMVX5zAtQ5woGm6mi0PmNr3gY8tdupghLTkZVT
   wTzHBCv7/xf83GEOYWiaHBDfrm95EI42cieopEugf35L9oqHmmsFxWEvj
   PiEKJ7XDmejsWSly68DJdfsnYRN0xc6JhFWOQG7/ExvJWrNQYHgd3hSky
   RHGKMmTcioRk5TZ1Tkdakv7IaGiEqC1ZiScMZYzOeAGhOxvooPorpJeFX
   jSm4/Hr7OlIx5W4R917th1tx/v1d1qkEOP43VFkcNiD2ISAN86BFAEzxL
   zx7aYTucUwK3adMiL4Cu2gYgDviTwDFip4xyrrmWeioopflkPqo3ZmcaU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238238690"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="238238690"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 23:30:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="463577110"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 23:30:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvaMr-0002uf-0X; Fri, 10 Dec 2021 07:30:57 +0000
Date:   Fri, 10 Dec 2021 15:30:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Woodhouse <dwmw@amazon.co.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:dev.2021.12.07a 56/57] kernel/rcu/tree.c:4312:45:
 warning: variable 'flags' is uninitialized when used here
Message-ID: <202112101543.wHvqhgYk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.07a
head:   89ddc546d3ad541bc89ec553c92036c98aef57a6
commit: 342f2d0f88f3c2d7ab2ae206be5846579319e3bf [56/57] rcu: Kill rnp->ofl_seq and use only rcu_state.ofl_lock for exclusion
config: hexagon-randconfig-r041-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101543.wHvqhgYk-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=342f2d0f88f3c2d7ab2ae206be5846579319e3bf
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2021.12.07a
        git checkout 342f2d0f88f3c2d7ab2ae206be5846579319e3bf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/rcu/tree.c:4312:45: warning: variable 'flags' is uninitialized when used here [-Wuninitialized]
                   rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
                                                             ^~~~~
   kernel/rcu/tree.c:4280:21: note: initialize the variable 'flags' to silence this warning
           unsigned long flags, seq_flags;
                              ^
                               = 0
   1 warning generated.


vim +/flags +4312 kernel/rcu/tree.c

4df8374254ea929 Thomas Gleixner         2016-07-13  4266  
7ec99de36f40261 Paul E. McKenney        2016-06-30  4267  /*
7ec99de36f40261 Paul E. McKenney        2016-06-30  4268   * Mark the specified CPU as being online so that subsequent grace periods
7ec99de36f40261 Paul E. McKenney        2016-06-30  4269   * (both expedited and normal) will wait on it.  Note that this means that
7ec99de36f40261 Paul E. McKenney        2016-06-30  4270   * incoming CPUs are not allowed to use RCU read-side critical sections
7ec99de36f40261 Paul E. McKenney        2016-06-30  4271   * until this function is called.  Failing to observe this restriction
7ec99de36f40261 Paul E. McKenney        2016-06-30  4272   * will result in lockdep splats.
deb34f364398083 Paul E. McKenney        2017-03-23  4273   *
deb34f364398083 Paul E. McKenney        2017-03-23  4274   * Note that this function is special in that it is invoked directly
deb34f364398083 Paul E. McKenney        2017-03-23  4275   * from the incoming CPU rather than from the cpuhp_step mechanism.
deb34f364398083 Paul E. McKenney        2017-03-23  4276   * This is because this function must be invoked at a precise location.
7ec99de36f40261 Paul E. McKenney        2016-06-30  4277   */
7ec99de36f40261 Paul E. McKenney        2016-06-30  4278  void rcu_cpu_starting(unsigned int cpu)
7ec99de36f40261 Paul E. McKenney        2016-06-30  4279  {
342f2d0f88f3c2d David Woodhouse         2021-12-09  4280  	unsigned long flags, seq_flags;
7ec99de36f40261 Paul E. McKenney        2016-06-30  4281  	unsigned long mask;
7ec99de36f40261 Paul E. McKenney        2016-06-30  4282  	struct rcu_data *rdp;
7ec99de36f40261 Paul E. McKenney        2016-06-30  4283  	struct rcu_node *rnp;
abfce0414814149 Wei Yang                2020-04-19  4284  	bool newcpu;
7ec99de36f40261 Paul E. McKenney        2016-06-30  4285  
c0f97f20e5d97a1 Paul E. McKenney        2020-07-24  4286  	rdp = per_cpu_ptr(&rcu_data, cpu);
c0f97f20e5d97a1 Paul E. McKenney        2020-07-24  4287  	if (rdp->cpu_started)
f64c6013a202931 Peter Zijlstra          2018-05-22  4288  		return;
c0f97f20e5d97a1 Paul E. McKenney        2020-07-24  4289  	rdp->cpu_started = true;
f64c6013a202931 Peter Zijlstra          2018-05-22  4290  
7ec99de36f40261 Paul E. McKenney        2016-06-30  4291  	rnp = rdp->mynode;
7ec99de36f40261 Paul E. McKenney        2016-06-30  4292  	mask = rdp->grpmask;
342f2d0f88f3c2d David Woodhouse         2021-12-09  4293  	local_irq_save(seq_flags);
342f2d0f88f3c2d David Woodhouse         2021-12-09  4294  	arch_spin_lock(&rcu_state.ofl_lock);
2caebefb00f03b5 Paul E. McKenney        2021-07-28  4295  	rcu_dynticks_eqs_online();
4d60b475f858ebd Paul E. McKenney        2020-10-13  4296  	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
342f2d0f88f3c2d David Woodhouse         2021-12-09  4297  	raw_spin_lock_rcu_node(rnp);
105abf82b0a6266 Paul E. McKenney        2020-01-03  4298  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
abfce0414814149 Wei Yang                2020-04-19  4299  	newcpu = !(rnp->expmaskinitnext & mask);
7ec99de36f40261 Paul E. McKenney        2016-06-30  4300  	rnp->expmaskinitnext |= mask;
313517fc44fb2d8 Paul E. McKenney        2017-06-08  4301  	/* Allow lockless access for expedited grace periods. */
abfce0414814149 Wei Yang                2020-04-19  4302  	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
2f08469563550d1 Paul E. McKenney        2020-02-10  4303  	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
e05121ba5b81e2f Paul E. McKenney        2018-05-07  4304  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
eb7a6653887b540 Paul E. McKenney        2018-07-05  4305  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
eb7a6653887b540 Paul E. McKenney        2018-07-05  4306  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
9f866dac94292f9 Joel Fernandes (Google  2020-09-29  4307) 
9f866dac94292f9 Joel Fernandes (Google  2020-09-29  4308) 	/* An incoming CPU should never be blocking a grace period. */
9f866dac94292f9 Joel Fernandes (Google  2020-09-29  4309) 	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
516e5ae0c940162 Joel Fernandes (Google  2019-09-05  4310) 		rcu_disable_urgency_upon_qs(rdp);
99990da1b3c00f6 Paul E. McKenney        2018-05-03  4311  		/* Report QS -after- changing ->qsmaskinitnext! */
b50912d0b5e03f1 Paul E. McKenney        2018-07-03 @4312  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
99990da1b3c00f6 Paul E. McKenney        2018-05-03  4313  	} else {
7ec99de36f40261 Paul E. McKenney        2016-06-30  4314  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
7ec99de36f40261 Paul E. McKenney        2016-06-30  4315  	}
342f2d0f88f3c2d David Woodhouse         2021-12-09  4316  	arch_spin_unlock(&rcu_state.ofl_lock);
342f2d0f88f3c2d David Woodhouse         2021-12-09  4317  	local_irq_restore(seq_flags);
313517fc44fb2d8 Paul E. McKenney        2017-06-08  4318  	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
7ec99de36f40261 Paul E. McKenney        2016-06-30  4319  }
7ec99de36f40261 Paul E. McKenney        2016-06-30  4320  

:::::: The code at line 4312 was first introduced by commit
:::::: b50912d0b5e03f11004fec1e2b50244de9e2fa41 rcu: Remove rsp parameter from rcu_report_qs_rnp()

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
