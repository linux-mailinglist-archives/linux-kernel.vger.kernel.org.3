Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A145752AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiGNQWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiGNQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:22:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91962494
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657815750; x=1689351750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=chXGxij14yz9RDImAqjuwivX5bwn03mJi+ZsjScjEuo=;
  b=JUkKilsJeeLrjux3WZExCCw4htLRTYZ/W2nVPSz6Q3gkX3oiMnXc8hRr
   /qUs9ueYzORxOHycdDxD8DqIOG7WQQgsWpQYfmYXSg71j+laLVtpvVP1Z
   B8vCT/KmmRiUUC7s3SbwDPXC8LfKOLhp+FubZ0yPK7tS6GOmxxz9zcMn0
   m90xXZxqvawRKfAYps4rHRKhFeDz7cAwS7abGtbYs088u4wr5GK6JIOVL
   8oOPqQGA85yA+Ze0WTc0JrjOV5Alr4m5H62F3S1gakwos3INjL+ewIf6D
   0w/NEAgZybon0HLQjkzg0WhrGrMV6T5i4ICP+T8PTCxEfvDxN58gFdjSd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283119225"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="283119225"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:22:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="593424634"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2022 09:22:27 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC1be-0000rA-NX;
        Thu, 14 Jul 2022 16:22:26 +0000
Date:   Fri, 15 Jul 2022 00:21:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/12] locking/qspinlock: remove arch
 qspinlock_paravirt.h includes
Message-ID: <202207150003.29YhgBtE-lkp@intel.com>
References: <20220713070704.308394-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713070704.308394-8-npiggin@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220715/202207150003.29YhgBtE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/87679eeea9f1939c252d16df3ac6a01bf9daaa60
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nicholas-Piggin/locking-qspinlock-simplify-code-generation/20220713-151009
        git checkout 87679eeea9f1939c252d16df3ac6a01bf9daaa60
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/locking/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/locking/qspinlock.c:29:
   kernel/locking/qspinlock_stat.h:36:9: warning: no previous prototype for function 'lockevent_read' [-Wmissing-prototypes]
   ssize_t lockevent_read(struct file *file, char __user *user_buf,
           ^
   kernel/locking/qspinlock_stat.h:36:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   ssize_t lockevent_read(struct file *file, char __user *user_buf,
   ^
   static 
   kernel/locking/qspinlock.c:705:1: warning: no previous prototype for function '__pv_queued_spin_unlock_slowpath' [-Wmissing-prototypes]
   __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
   ^
   kernel/locking/qspinlock.c:704:11: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible void
             ^
             static 
>> kernel/locking/qspinlock.c:749:16: warning: no previous prototype for function '__pv_queued_spin_unlock' [-Wmissing-prototypes]
   __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
                  ^
   kernel/locking/qspinlock.c:749:11: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
             ^
             static 
   3 warnings generated.


vim +/__pv_queued_spin_unlock +749 kernel/locking/qspinlock.c

91668ee1ed703d7 Nicholas Piggin 2022-07-13  699  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  700  /*
91668ee1ed703d7 Nicholas Piggin 2022-07-13  701   * PV versions of the unlock fastpath and slowpath functions to be used
91668ee1ed703d7 Nicholas Piggin 2022-07-13  702   * instead of queued_spin_unlock().
91668ee1ed703d7 Nicholas Piggin 2022-07-13  703   */
91668ee1ed703d7 Nicholas Piggin 2022-07-13  704  __visible void
91668ee1ed703d7 Nicholas Piggin 2022-07-13 @705  __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
91668ee1ed703d7 Nicholas Piggin 2022-07-13  706  {
91668ee1ed703d7 Nicholas Piggin 2022-07-13  707  	struct qnode *node;
91668ee1ed703d7 Nicholas Piggin 2022-07-13  708  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  709  	if (unlikely(locked != _Q_SLOW_VAL)) {
91668ee1ed703d7 Nicholas Piggin 2022-07-13  710  		WARN(!debug_locks_silent,
91668ee1ed703d7 Nicholas Piggin 2022-07-13  711  		     "pvqspinlock: lock 0x%lx has corrupted value 0x%x!\n",
91668ee1ed703d7 Nicholas Piggin 2022-07-13  712  		     (unsigned long)lock, atomic_read(&lock->val));
91668ee1ed703d7 Nicholas Piggin 2022-07-13  713  		return;
91668ee1ed703d7 Nicholas Piggin 2022-07-13  714  	}
91668ee1ed703d7 Nicholas Piggin 2022-07-13  715  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  716  	/*
91668ee1ed703d7 Nicholas Piggin 2022-07-13  717  	 * A failed cmpxchg doesn't provide any memory-ordering guarantees,
91668ee1ed703d7 Nicholas Piggin 2022-07-13  718  	 * so we need a barrier to order the read of the node data in
91668ee1ed703d7 Nicholas Piggin 2022-07-13  719  	 * pv_unhash *after* we've read the lock being _Q_SLOW_VAL.
91668ee1ed703d7 Nicholas Piggin 2022-07-13  720  	 *
91668ee1ed703d7 Nicholas Piggin 2022-07-13  721  	 * Matches the cmpxchg() in pv_wait_head_or_lock() setting _Q_SLOW_VAL.
91668ee1ed703d7 Nicholas Piggin 2022-07-13  722  	 */
91668ee1ed703d7 Nicholas Piggin 2022-07-13  723  	smp_rmb();
91668ee1ed703d7 Nicholas Piggin 2022-07-13  724  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  725  	/*
91668ee1ed703d7 Nicholas Piggin 2022-07-13  726  	 * Since the above failed to release, this must be the SLOW path.
91668ee1ed703d7 Nicholas Piggin 2022-07-13  727  	 * Therefore start by looking up the blocked node and unhashing it.
91668ee1ed703d7 Nicholas Piggin 2022-07-13  728  	 */
91668ee1ed703d7 Nicholas Piggin 2022-07-13  729  	node = pv_unhash(lock);
91668ee1ed703d7 Nicholas Piggin 2022-07-13  730  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  731  	/*
91668ee1ed703d7 Nicholas Piggin 2022-07-13  732  	 * Now that we have a reference to the (likely) blocked qnode,
91668ee1ed703d7 Nicholas Piggin 2022-07-13  733  	 * release the lock.
91668ee1ed703d7 Nicholas Piggin 2022-07-13  734  	 */
91668ee1ed703d7 Nicholas Piggin 2022-07-13  735  	smp_store_release(&lock->locked, 0);
91668ee1ed703d7 Nicholas Piggin 2022-07-13  736  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  737  	/*
91668ee1ed703d7 Nicholas Piggin 2022-07-13  738  	 * At this point the memory pointed at by lock can be freed/reused,
91668ee1ed703d7 Nicholas Piggin 2022-07-13  739  	 * however we can still use the qnode to kick the CPU.
91668ee1ed703d7 Nicholas Piggin 2022-07-13  740  	 * The other vCPU may not really be halted, but kicking an active
91668ee1ed703d7 Nicholas Piggin 2022-07-13  741  	 * vCPU is harmless other than the additional latency in completing
91668ee1ed703d7 Nicholas Piggin 2022-07-13  742  	 * the unlock.
91668ee1ed703d7 Nicholas Piggin 2022-07-13  743  	 */
91668ee1ed703d7 Nicholas Piggin 2022-07-13  744  	lockevent_inc(pv_kick_unlock);
91668ee1ed703d7 Nicholas Piggin 2022-07-13  745  	pv_kick(node->cpu);
91668ee1ed703d7 Nicholas Piggin 2022-07-13  746  }
91668ee1ed703d7 Nicholas Piggin 2022-07-13  747  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  748  #ifndef __pv_queued_spin_unlock
91668ee1ed703d7 Nicholas Piggin 2022-07-13 @749  __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
91668ee1ed703d7 Nicholas Piggin 2022-07-13  750  {
91668ee1ed703d7 Nicholas Piggin 2022-07-13  751  	u8 locked;
91668ee1ed703d7 Nicholas Piggin 2022-07-13  752  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  753  	/*
91668ee1ed703d7 Nicholas Piggin 2022-07-13  754  	 * We must not unlock if SLOW, because in that case we must first
91668ee1ed703d7 Nicholas Piggin 2022-07-13  755  	 * unhash. Otherwise it would be possible to have multiple @lock
91668ee1ed703d7 Nicholas Piggin 2022-07-13  756  	 * entries, which would be BAD.
91668ee1ed703d7 Nicholas Piggin 2022-07-13  757  	 */
91668ee1ed703d7 Nicholas Piggin 2022-07-13  758  	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
91668ee1ed703d7 Nicholas Piggin 2022-07-13  759  	if (likely(locked == _Q_LOCKED_VAL))
91668ee1ed703d7 Nicholas Piggin 2022-07-13  760  		return;
91668ee1ed703d7 Nicholas Piggin 2022-07-13  761  
91668ee1ed703d7 Nicholas Piggin 2022-07-13  762  	__pv_queued_spin_unlock_slowpath(lock, locked);
91668ee1ed703d7 Nicholas Piggin 2022-07-13  763  }
87679eeea9f1939 Nicholas Piggin 2022-07-13  764  EXPORT_SYMBOL(__pv_queued_spin_unlock);
91668ee1ed703d7 Nicholas Piggin 2022-07-13  765  #endif
91668ee1ed703d7 Nicholas Piggin 2022-07-13  766  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
