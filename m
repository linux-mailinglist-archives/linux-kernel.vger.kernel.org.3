Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE23B480EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 03:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhL2CCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 21:02:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:46080 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238285AbhL2CCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 21:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640743355; x=1672279355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BdVhmTkiGfjCTka06ojdzziUJXH+69n4D5sD653s1uw=;
  b=jOA3XYy8090DdU0AFeZZNBJbjKHthI4jCg91f+c0HnmSY3iMDWBVCtcm
   /nqW/t4/+sxDodgpQZXs8XyKxVzuIgN4xE6xAHY4UZcsUld3a0szH7nHh
   ytd2XV237wvh0K4mE18Mw0bmNuABiucLlJyAN8KnFwmqXGpWCkvLbzvoN
   kigyJBuz2q1/aqw82nJCrHUi2qCswohnBxhpGfgjk3DpP4lOzRdH3DJNT
   LppZiTpZ9lX6eeG1Er9czNMhjxGoSIORr/7i9p0xLA2tVbekDp2goV7dD
   1xeE2QY3L6pghtDo4khdKAP6n1om3aZreGpzcTYTH1Lc0Cwu4sQyi4bjw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="327774863"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="327774863"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 18:02:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="761246006"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Dec 2021 18:02:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2OIS-0008Ha-SU; Wed, 29 Dec 2021 02:02:32 +0000
Date:   Wed, 29 Dec 2021 10:01:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [luto:sched/lazymm 14/17] kernel/sched/core.c:4982:15: warning:
 variable 'old_active_mm' is uninitialized when used here
Message-ID: <202112290930.hCel1twi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git sched/lazymm
head:   fbea7977edc16ae85f8e2255b084bc2403801327
commit: 8f99be3b9978a71358e03a2bcfd4b230f32714cb [14/17] sched, exec: Factor current mm changes out from exec
config: hexagon-randconfig-r041-20211229 (https://download.01.org/0day-ci/archive/20211229/202112290930.hCel1twi-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?id=8f99be3b9978a71358e03a2bcfd4b230f32714cb
        git remote add luto https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git
        git fetch --no-tags luto sched/lazymm
        git checkout 8f99be3b9978a71358e03a2bcfd4b230f32714cb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/core.c:3417:6: warning: no previous prototype for function 'sched_set_stop_task' [-Wmissing-prototypes]
   void sched_set_stop_task(int cpu, struct task_struct *stop)
        ^
   kernel/sched/core.c:3417:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void sched_set_stop_task(int cpu, struct task_struct *stop)
   ^
   static 
>> kernel/sched/core.c:4982:15: warning: variable 'old_active_mm' is uninitialized when used here [-Wuninitialized]
                   activate_mm(old_active_mm, mm);
                               ^~~~~~~~~~~~~
   kernel/sched/core.c:4941:33: note: initialize the variable 'old_active_mm' to silence this warning
           struct mm_struct *old_active_mm, *mm_to_drop = NULL;
                                          ^
                                           = NULL
   kernel/sched/core.c:2173:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
   static inline bool rq_has_pinned_tasks(struct rq *rq)
                      ^
   kernel/sched/core.c:5474:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
   static inline void sched_tick_stop(int cpu) { }
                      ^
   kernel/sched/core.c:6202:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
   static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
                      ^
   kernel/sched/core.c:6203:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
   static inline void sched_core_cpu_dying(unsigned int cpu) {}
                      ^
   kernel/sched/core.c:9046:20: warning: unused function 'balance_hotplug_wait' [-Wunused-function]
   static inline void balance_hotplug_wait(void)
                      ^
   7 warnings generated.


vim +/old_active_mm +4982 kernel/sched/core.c

  4937	
  4938	void __change_current_mm(struct mm_struct *mm, bool mm_is_brand_new)
  4939	{
  4940		struct task_struct *tsk = current;
  4941		struct mm_struct *old_active_mm, *mm_to_drop = NULL;
  4942	
  4943		BUG_ON(!mm);	/* likely to cause corruption if we continue */
  4944	
  4945		/*
  4946		 * We do not want to schedule, nor should procfs peek at current->mm
  4947		 * while we're modifying it.  task_lock() disables preemption and
  4948		 * locks against procfs.
  4949		 */
  4950		task_lock(tsk);
  4951		/*
  4952		 * membarrier() requires a full barrier before switching mm.
  4953		 */
  4954		smp_mb__after_spinlock();
  4955	
  4956		local_irq_disable();
  4957	
  4958		if (tsk->mm) {
  4959			/* We're detaching from an old mm.  Sync stats. */
  4960			sync_mm_rss(tsk->mm);
  4961		} else {
  4962			/*
  4963			 * Switching from kernel mm to user.  Drop the old lazy
  4964			 * mm reference.
  4965			 */
  4966			mm_to_drop = tsk->active_mm;
  4967		}
  4968	
  4969		tsk->active_mm = mm;
  4970		WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
  4971		membarrier_update_current_mm(mm);
  4972	
  4973		if (mm_is_brand_new) {
  4974			/*
  4975			 * For historical reasons, some architectures want IRQs on
  4976			 * when activate_mm() is called.  If we're going to call
  4977			 * activate_mm(), turn on IRQs but leave preemption
  4978			 * disabled.
  4979			 */
  4980			if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
  4981				local_irq_enable();
> 4982			activate_mm(old_active_mm, mm);
  4983			if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
  4984				local_irq_enable();
  4985		} else {
  4986			switch_mm_irqs_off(old_active_mm, mm, tsk);
  4987			local_irq_enable();
  4988		}
  4989	
  4990		/* IRQs are on now.  Preemption is still disabled by task_lock(). */
  4991	
  4992		membarrier_finish_switch_mm(mm);
  4993		vmacache_flush(tsk);
  4994		task_unlock(tsk);
  4995	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
