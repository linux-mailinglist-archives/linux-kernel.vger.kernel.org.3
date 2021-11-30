Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56414633B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhK3MDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:03:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:46885 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235058AbhK3MDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:03:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="297002692"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="297002692"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 03:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="458805958"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Nov 2021 03:59:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ms1nW-000DF3-G5; Tue, 30 Nov 2021 11:59:46 +0000
Date:   Tue, 30 Nov 2021 19:59:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:sched/core 3/8] kernel/sched/core_sched.c:278:37: sparse:
 sparse: incompatible types in conditional expression (different address
 spaces):
Message-ID: <202111301958.OvjPxCJ2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   8c92606ab81086db00cbb73347d124b4eb169b7e
commit: 4feee7d12603deca8775f9f9ae5e121093837444 [3/8] sched/core: Forced idle accounting
config: i386-randconfig-s001-20211128 (https://download.01.org/0day-ci/archive/20211130/202111301958.OvjPxCJ2-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=4feee7d12603deca8775f9f9ae5e121093837444
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip sched/core
        git checkout 4feee7d12603deca8775f9f9ae5e121093837444
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/sched/core_sched.c:278:37: sparse: sparse: incompatible types in conditional expression (different address spaces):
>> kernel/sched/core_sched.c:278:37: sparse:    struct task_struct *
>> kernel/sched/core_sched.c:278:37: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core_sched.c: note: in included file:
   kernel/sched/sched.h:1185:30: sparse: sparse: context imbalance in 'sched_core_update_cookie' - wrong count at exit

vim +278 kernel/sched/core_sched.c

   240	
   241	/* REQUIRES: rq->core's clock recently updated. */
   242	void __sched_core_account_forceidle(struct rq *rq)
   243	{
   244		const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
   245		u64 delta, now = rq_clock(rq->core);
   246		struct rq *rq_i;
   247		struct task_struct *p;
   248		int i;
   249	
   250		lockdep_assert_rq_held(rq);
   251	
   252		WARN_ON_ONCE(!rq->core->core_forceidle_count);
   253	
   254		if (rq->core->core_forceidle_start == 0)
   255			return;
   256	
   257		delta = now - rq->core->core_forceidle_start;
   258		if (unlikely((s64)delta <= 0))
   259			return;
   260	
   261		rq->core->core_forceidle_start = now;
   262	
   263		if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
   264			/* can't be forced idle without a running task */
   265		} else if (rq->core->core_forceidle_count > 1 ||
   266			   rq->core->core_forceidle_occupation > 1) {
   267			/*
   268			 * For larger SMT configurations, we need to scale the charged
   269			 * forced idle amount since there can be more than one forced
   270			 * idle sibling and more than one running cookied task.
   271			 */
   272			delta *= rq->core->core_forceidle_count;
   273			delta = div_u64(delta, rq->core->core_forceidle_occupation);
   274		}
   275	
   276		for_each_cpu(i, smt_mask) {
   277			rq_i = cpu_rq(i);
 > 278			p = rq_i->core_pick ?: rq_i->curr;
   279	
   280			if (!p->core_cookie)
   281				continue;
   282	
   283			__schedstat_add(p->stats.core_forceidle_sum, delta);
   284		}
   285	}
   286	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
