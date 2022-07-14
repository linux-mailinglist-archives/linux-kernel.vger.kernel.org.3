Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57B575327
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiGNQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiGNQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306254B49E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657817011; x=1689353011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yg2ZZerL0/F7EzoSHWeE8jx7LHK7/UOy/NbpJTWfD4A=;
  b=el4ETHZaIWbuyPDKVrNdmyruKSkBV/ag/gyjePE7fLKOF3Mteh5pY1xm
   5ZTc8T2YJLFdycCqrPlRPMN2++/o3JqKfFWLUJU10uPlSvDF2UwQ0AcrT
   6ZOi6C51mGdXfyuvitSgLTcEVHQbRKWoYtag2vzZvczyGh9uXEHgBm9YS
   UDLtah+X2oDvRMTJqfBDkGTSqhVtP3ep9Os4cXGjIzyep9JJngaPq2dAV
   JmalDN8zIlqADmaffIMCxs4yrvL+LyZRfqUrWd4josPhsm8I8/kG/3/dC
   SrBB0u8NETsTp4AssgBlhde1Y1s3AG0T0DbJspojyCeEyRF0T4egP740Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265358265"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="265358265"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="596157089"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2022 09:43:28 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC1vz-0000sr-LP;
        Thu, 14 Jul 2022 16:43:27 +0000
Date:   Fri, 15 Jul 2022 00:42:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/12] locking/qspinlock: merge qspinlock_paravirt.h
 into qspinlock.c
Message-ID: <202207150022.DkhjTAWE-lkp@intel.com>
References: <20220713070704.308394-7-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713070704.308394-7-npiggin@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/x86/core powerpc/next linus/master v5.19-rc6 next-20220714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicholas-Piggin/locking-qspinlock-simplify-code-generation/20220713-151009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git eae6d58d67d9739be5f7ae2dbead1d0ef6528243
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220715/202207150022.DkhjTAWE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/91668ee1ed703d7ea84e314136dc732da05ec9e7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nicholas-Piggin/locking-qspinlock-simplify-code-generation/20220713-151009
        git checkout 91668ee1ed703d7ea84e314136dc732da05ec9e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/target/ fs/xfs/ kernel/locking/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/locking/qspinlock.c: In function 'pv_wait_node':
>> kernel/locking/qspinlock.c:513:14: warning: variable 'wait_early' set but not used [-Wunused-but-set-variable]
     513 |         bool wait_early;
         |              ^~~~~~~~~~
   kernel/locking/qspinlock.c: At top level:
>> kernel/locking/qspinlock.c:705:1: warning: no previous prototype for '__pv_queued_spin_unlock_slowpath' [-Wmissing-prototypes]
     705 | __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/wait_early +513 kernel/locking/qspinlock.c

   504	
   505	/*
   506	 * Wait for node->locked to become true, halt the vcpu after a short spin.
   507	 * pv_kick_node() is used to set _Q_SLOW_VAL and fill in hash table on its
   508	 * behalf.
   509	 */
   510	static void pv_wait_node(struct qnode *node, struct qnode *prev)
   511	{
   512		int loop;
 > 513		bool wait_early;
   514	
   515		for (;;) {
   516			for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
   517				if (READ_ONCE(node->locked))
   518					return;
   519				if (pv_wait_early(prev, loop)) {
   520					wait_early = true;
   521					break;
   522				}
   523				cpu_relax();
   524			}
   525	
   526			/*
   527			 * Order node->state vs node->locked thusly:
   528			 *
   529			 * [S] node->state = vcpu_halted  [S] next->locked = 1
   530			 *     MB                             MB
   531			 * [L] node->locked             [RmW] node->state = vcpu_hashed
   532			 *
   533			 * Matches the cmpxchg() from pv_kick_node().
   534			 */
   535			smp_store_mb(node->state, vcpu_halted);
   536	
   537			if (!READ_ONCE(node->locked)) {
   538				lockevent_inc(pv_wait_node);
   539				lockevent_cond_inc(pv_wait_early, wait_early);
   540				pv_wait(&node->state, vcpu_halted);
   541			}
   542	
   543			/*
   544			 * If pv_kick_node() changed us to vcpu_hashed, retain that
   545			 * value so that pv_wait_head_or_lock() knows to not also try
   546			 * to hash this lock.
   547			 */
   548			cmpxchg(&node->state, vcpu_halted, vcpu_running);
   549	
   550			/*
   551			 * If the locked flag is still not set after wakeup, it is a
   552			 * spurious wakeup and the vCPU should wait again. However,
   553			 * there is a pretty high overhead for CPU halting and kicking.
   554			 * So it is better to spin for a while in the hope that the
   555			 * MCS lock will be released soon.
   556			 */
   557			lockevent_cond_inc(pv_spurious_wakeup,
   558					  !READ_ONCE(node->locked));
   559		}
   560	
   561		/*
   562		 * By now our node->locked should be 1 and our caller will not actually
   563		 * spin-wait for it. We do however rely on our caller to do a
   564		 * load-acquire for us.
   565		 */
   566	}
   567	
   568	/*
   569	 * Called after setting next->locked = 1 when we're the lock owner.
   570	 *
   571	 * Instead of waking the waiters stuck in pv_wait_node() advance their state
   572	 * such that they're waiting in pv_wait_head_or_lock(), this avoids a
   573	 * wake/sleep cycle.
   574	 */
   575	static void pv_kick_node(struct qspinlock *lock, struct qnode *node)
   576	{
   577		/*
   578		 * If the vCPU is indeed halted, advance its state to match that of
   579		 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
   580		 * observe its next->locked value and advance itself.
   581		 *
   582		 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
   583		 *
   584		 * The write to next->locked in arch_mcs_spin_unlock_contended()
   585		 * must be ordered before the read of node->state in the cmpxchg()
   586		 * below for the code to work correctly. To guarantee full ordering
   587		 * irrespective of the success or failure of the cmpxchg(),
   588		 * a relaxed version with explicit barrier is used. The control
   589		 * dependency will order the reading of node->state before any
   590		 * subsequent writes.
   591		 */
   592		smp_mb__before_atomic();
   593		if (cmpxchg_relaxed(&node->state, vcpu_halted, vcpu_hashed)
   594		    != vcpu_halted)
   595			return;
   596	
   597		/*
   598		 * Put the lock into the hash table and set the _Q_SLOW_VAL.
   599		 *
   600		 * As this is the same vCPU that will check the _Q_SLOW_VAL value and
   601		 * the hash table later on at unlock time, no atomic instruction is
   602		 * needed.
   603		 */
   604		WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
   605		(void)pv_hash(lock, node);
   606	}
   607	
   608	/*
   609	 * Wait for l->locked to become clear and acquire the lock;
   610	 * halt the vcpu after a short spin.
   611	 * __pv_queued_spin_unlock() will wake us.
   612	 *
   613	 * The current value of the lock will be returned for additional processing.
   614	 */
   615	static u32
   616	pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
   617	{
   618		struct qspinlock **lp = NULL;
   619		int waitcnt = 0;
   620		int loop;
   621	
   622		/*
   623		 * If pv_kick_node() already advanced our state, we don't need to
   624		 * insert ourselves into the hash table anymore.
   625		 */
   626		if (READ_ONCE(node->state) == vcpu_hashed)
   627			lp = (struct qspinlock **)1;
   628	
   629		/*
   630		 * Tracking # of slowpath locking operations
   631		 */
   632		lockevent_inc(lock_slowpath);
   633	
   634		for (;; waitcnt++) {
   635			/*
   636			 * Set correct vCPU state to be used by queue node wait-early
   637			 * mechanism.
   638			 */
   639			WRITE_ONCE(node->state, vcpu_running);
   640	
   641			/*
   642			 * Set the pending bit in the active lock spinning loop to
   643			 * disable lock stealing before attempting to acquire the lock.
   644			 */
   645			set_pending(lock);
   646			for (loop = SPIN_THRESHOLD; loop; loop--) {
   647				if (trylock_clear_pending(lock))
   648					goto gotlock;
   649				cpu_relax();
   650			}
   651			clear_pending(lock);
   652	
   653	
   654			if (!lp) { /* ONCE */
   655				lp = pv_hash(lock, node);
   656	
   657				/*
   658				 * We must hash before setting _Q_SLOW_VAL, such that
   659				 * when we observe _Q_SLOW_VAL in __pv_queued_spin_unlock()
   660				 * we'll be sure to be able to observe our hash entry.
   661				 *
   662				 *   [S] <hash>                 [Rmw] l->locked == _Q_SLOW_VAL
   663				 *       MB                           RMB
   664				 * [RmW] l->locked = _Q_SLOW_VAL  [L] <unhash>
   665				 *
   666				 * Matches the smp_rmb() in __pv_queued_spin_unlock().
   667				 */
   668				if (xchg(&lock->locked, _Q_SLOW_VAL) == 0) {
   669					/*
   670					 * The lock was free and now we own the lock.
   671					 * Change the lock value back to _Q_LOCKED_VAL
   672					 * and unhash the table.
   673					 */
   674					WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
   675					WRITE_ONCE(*lp, NULL);
   676					goto gotlock;
   677				}
   678			}
   679			WRITE_ONCE(node->state, vcpu_hashed);
   680			lockevent_inc(pv_wait_head);
   681			lockevent_cond_inc(pv_wait_again, waitcnt);
   682			pv_wait(&lock->locked, _Q_SLOW_VAL);
   683	
   684			/*
   685			 * Because of lock stealing, the queue head vCPU may not be
   686			 * able to acquire the lock before it has to wait again.
   687			 */
   688		}
   689	
   690		/*
   691		 * The cmpxchg() or xchg() call before coming here provides the
   692		 * acquire semantics for locking. The dummy ORing of _Q_LOCKED_VAL
   693		 * here is to indicate to the compiler that the value will always
   694		 * be nozero to enable better code optimization.
   695		 */
   696	gotlock:
   697		return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
   698	}
   699	
   700	/*
   701	 * PV versions of the unlock fastpath and slowpath functions to be used
   702	 * instead of queued_spin_unlock().
   703	 */
   704	__visible void
 > 705	__pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
   706	{
   707		struct qnode *node;
   708	
   709		if (unlikely(locked != _Q_SLOW_VAL)) {
   710			WARN(!debug_locks_silent,
   711			     "pvqspinlock: lock 0x%lx has corrupted value 0x%x!\n",
   712			     (unsigned long)lock, atomic_read(&lock->val));
   713			return;
   714		}
   715	
   716		/*
   717		 * A failed cmpxchg doesn't provide any memory-ordering guarantees,
   718		 * so we need a barrier to order the read of the node data in
   719		 * pv_unhash *after* we've read the lock being _Q_SLOW_VAL.
   720		 *
   721		 * Matches the cmpxchg() in pv_wait_head_or_lock() setting _Q_SLOW_VAL.
   722		 */
   723		smp_rmb();
   724	
   725		/*
   726		 * Since the above failed to release, this must be the SLOW path.
   727		 * Therefore start by looking up the blocked node and unhashing it.
   728		 */
   729		node = pv_unhash(lock);
   730	
   731		/*
   732		 * Now that we have a reference to the (likely) blocked qnode,
   733		 * release the lock.
   734		 */
   735		smp_store_release(&lock->locked, 0);
   736	
   737		/*
   738		 * At this point the memory pointed at by lock can be freed/reused,
   739		 * however we can still use the qnode to kick the CPU.
   740		 * The other vCPU may not really be halted, but kicking an active
   741		 * vCPU is harmless other than the additional latency in completing
   742		 * the unlock.
   743		 */
   744		lockevent_inc(pv_kick_unlock);
   745		pv_kick(node->cpu);
   746	}
   747	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
