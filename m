Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5B857565A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiGNU2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbiGNU2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:28:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83865ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657830520; x=1689366520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RmsJ85zaQ6SLdTrbC7HU94sH2GH/ck7+Z2JTgwkKajs=;
  b=Znj6WxYADU+ExYHEsLkvbkqT0bnqsK7tEtGArFmgRcT9LuLfgyc2LKQ+
   a51HlMp/YFq1rWCFUCzwHaqK845UuPq3f0rM4DkWPTuL2ommLAVYbHeuM
   XlCr4OcM5p55k8KGFXDEz0CV8s6Ti046iOartiIyPi+uYVfp7SaTwswjx
   qM0mxhjz1ZTVbJ76hyBe6HI6iYEcD3drQW2h+BFE2ghYO3aSpBFEgJGwB
   +OppplWsPobg5PVNFU3JFc3WruR8T9VSoWdaUW/+S3A3uPOcGiHhwrZbI
   Z1ICUQiRbFLjuvhI0lYApvPk610WpAGRPKUK/17zB2KyJ+nZ5RpeKpRf2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268649332"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="268649332"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663923875"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 13:28:38 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC5Rt-00017t-IE;
        Thu, 14 Jul 2022 20:28:37 +0000
Date:   Fri, 15 Jul 2022 04:28:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/12] locking/qspinlock: merge qspinlock_paravirt.h
 into qspinlock.c
Message-ID: <202207150452.zk1w58X4-lkp@intel.com>
References: <20220713070704.308394-7-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713070704.308394-7-npiggin@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220715/202207150452.zk1w58X4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/91668ee1ed703d7ea84e314136dc732da05ec9e7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nicholas-Piggin/locking-qspinlock-simplify-code-generation/20220713-151009
        git checkout 91668ee1ed703d7ea84e314136dc732da05ec9e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/locking/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/locking/qspinlock.c:513:7: warning: variable 'wait_early' set but not used [-Wunused-but-set-variable]
           bool wait_early;
                ^
>> kernel/locking/qspinlock.c:619:6: warning: variable 'waitcnt' set but not used [-Wunused-but-set-variable]
           int waitcnt = 0;
               ^
>> kernel/locking/qspinlock.c:705:1: warning: no previous prototype for function '__pv_queued_spin_unlock_slowpath' [-Wmissing-prototypes]
   __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
   ^
   kernel/locking/qspinlock.c:704:11: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible void
             ^
             static 
   3 warnings generated.


vim +/waitcnt +619 kernel/locking/qspinlock.c

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
 > 619		int waitcnt = 0;
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
