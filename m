Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9E47511B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhLOCyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:54:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:18656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239396AbhLOCyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639536883; x=1671072883;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xD+WATrOKd+Byr4dh3vrk26ybxhvI2IYzGyYupBfjIg=;
  b=HgSRmhoHIhNIq4Q+wFFFgLey0+gwsOkxGUeTLdv0jEPcVIUoOnDsPbWW
   3QvN+fYAc5qbVpsL6HqITWnI5SYyS/DqWRPbETBfcTgoGyfsiUEWn8iul
   yDtk2zH82439PdmGkyO4LTsaeNu3syj9ZIKYudQgUub1nN9PZ/t/NT1GN
   ZNCgOtGru9f4KMqyEghNi26BDBoniTqW1yc2czBbypFVverzqc6XwAYSG
   EtDe39v/seaGci0si+yh32B2khYoHC5a6eEATHY6x6lY9pTe3wFpWz7D5
   2tTrRfSghzkmyB6wjSMYK29N+S4wHLiHkpzpJCQrgcpgFvxx/RJd2a0+X
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="237870532"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="237870532"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 18:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="682313466"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2021 18:54:41 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxKRF-00019D-9r; Wed, 15 Dec 2021 02:54:41 +0000
Date:   Wed, 15 Dec 2021 10:54:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.12.09b 35/37] kernel/rcu/tree.c:4072:23:
 warning: variable 'lseq' set but not used
Message-ID: <202112151008.JsE9k2En-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.09b
head:   0f1825f9df5a83cfeca5f1ecce96633223bf78d2
commit: ca34220fecf856ef7521c912a8812f2c1ea53ab3 [35/37] rcu: Rework rcu_barrier() and callback-migration logic
config: nds32-defconfig (https://download.01.org/0day-ci/archive/20211215/202112151008.JsE9k2En-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=ca34220fecf856ef7521c912a8812f2c1ea53ab3
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2021.12.09b
        git checkout ca34220fecf856ef7521c912a8812f2c1ea53ab3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/rcu/tree.c: In function 'rcu_barrier':
>> kernel/rcu/tree.c:4072:23: warning: variable 'lseq' set but not used [-Wunused-but-set-variable]
    4072 |         unsigned long lseq;
         |                       ^~~~


vim +/lseq +4072 kernel/rcu/tree.c

  4058	
  4059	/**
  4060	 * rcu_barrier - Wait until all in-flight call_rcu() callbacks complete.
  4061	 *
  4062	 * Note that this primitive does not necessarily wait for an RCU grace period
  4063	 * to complete.  For example, if there are no RCU callbacks queued anywhere
  4064	 * in the system, then rcu_barrier() is within its rights to return
  4065	 * immediately, without waiting for anything, much less an RCU grace period.
  4066	 */
  4067	void rcu_barrier(void)
  4068	{
  4069		uintptr_t cpu;
  4070		unsigned long flags;
  4071		unsigned long gseq;
> 4072		unsigned long lseq;
  4073		struct rcu_data *rdp;
  4074		unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
  4075	
  4076		rcu_barrier_trace(TPS("Begin"), -1, s);
  4077	
  4078		/* Take mutex to serialize concurrent rcu_barrier() requests. */
  4079		mutex_lock(&rcu_state.barrier_mutex);
  4080	
  4081		/* Did someone else do our work for us? */
  4082		if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
  4083			rcu_barrier_trace(TPS("EarlyExit"), -1, rcu_state.barrier_sequence);
  4084			smp_mb(); /* caller's subsequent code after above check. */
  4085			mutex_unlock(&rcu_state.barrier_mutex);
  4086			return;
  4087		}
  4088	
  4089		/* Mark the start of the barrier operation. */
  4090		lseq = rcu_state.barrier_sequence;
  4091		rcu_seq_start(&rcu_state.barrier_sequence);
  4092		gseq = rcu_state.barrier_sequence;
  4093		rcu_barrier_trace(TPS("Inc1"), -1, rcu_state.barrier_sequence);
  4094	
  4095		/*
  4096		 * Initialize the count to two rather than to zero in order
  4097		 * to avoid a too-soon return to zero in case of an immediate
  4098		 * invocation of the just-enqueued callback (or preemption of
  4099		 * this task).  Exclude CPU-hotplug operations to ensure that no
  4100		 * offline non-offloaded CPU has callbacks queued.
  4101		 */
  4102		init_completion(&rcu_state.barrier_completion);
  4103		atomic_set(&rcu_state.barrier_cpu_count, 2);
  4104		cpus_read_lock();
  4105	
  4106		/*
  4107		 * Force each CPU with callbacks to register a new callback.
  4108		 * When that callback is invoked, we will know that all of the
  4109		 * corresponding CPU's preceding callbacks have been invoked.
  4110		 */
  4111		for_each_possible_cpu(cpu) {
  4112			rdp = per_cpu_ptr(&rcu_data, cpu);
  4113	retry:
  4114			if (READ_ONCE(rdp->barrier_seq_snap) == gseq)
  4115				continue;
  4116			if (!rcu_segcblist_n_cbs(&rdp->cblist)) {
  4117				raw_spin_lock_irqsave(&rdp->barrier_lock, flags);
  4118				WRITE_ONCE(rdp->barrier_seq_snap, gseq);
  4119				raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
  4120				rcu_barrier_trace(TPS("NQ"), cpu, rcu_state.barrier_sequence);
  4121				continue;
  4122			}
  4123			if (rcu_rdp_cpu_online(rdp)) {
  4124				if (smp_call_function_single(cpu, rcu_barrier_handler, (void *)cpu, 1)) {
  4125					schedule_timeout_uninterruptible(1);
  4126					goto retry;
  4127				}
  4128				WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
  4129				rcu_barrier_trace(TPS("OnlineQ"), cpu, rcu_state.barrier_sequence);
  4130				continue;
  4131			}
  4132			if (!rcu_barrier_entrain_if_ofl(rdp)) {
  4133				schedule_timeout_uninterruptible(1);
  4134				goto retry;
  4135			}
  4136			WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
  4137			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu, rcu_state.barrier_sequence);
  4138		}
  4139		cpus_read_unlock();
  4140	
  4141		/*
  4142		 * Now that we have an rcu_barrier_callback() callback on each
  4143		 * CPU, and thus each counted, remove the initial count.
  4144		 */
  4145		if (atomic_sub_and_test(2, &rcu_state.barrier_cpu_count))
  4146			complete(&rcu_state.barrier_completion);
  4147	
  4148		/* Wait for all rcu_barrier_callback() callbacks to be invoked. */
  4149		wait_for_completion(&rcu_state.barrier_completion);
  4150	
  4151		/* Mark the end of the barrier operation. */
  4152		rcu_barrier_trace(TPS("Inc2"), -1, rcu_state.barrier_sequence);
  4153		rcu_seq_end(&rcu_state.barrier_sequence);
  4154		gseq = rcu_state.barrier_sequence;
  4155		for_each_possible_cpu(cpu) {
  4156			rdp = per_cpu_ptr(&rcu_data, cpu);
  4157	
  4158			WRITE_ONCE(rdp->barrier_seq_snap, gseq);
  4159		}
  4160	
  4161		/* Other rcu_barrier() invocations can now safely proceed. */
  4162		mutex_unlock(&rcu_state.barrier_mutex);
  4163	}
  4164	EXPORT_SYMBOL_GPL(rcu_barrier);
  4165	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
