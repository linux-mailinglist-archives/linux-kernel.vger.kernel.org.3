Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964E746470D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346863AbhLAGSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:18:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:39231 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235759AbhLAGSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:18:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="297195853"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="297195853"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 22:15:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="540695352"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2021 22:15:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msItX-000EML-45; Wed, 01 Dec 2021 06:15:07 +0000
Date:   Wed, 1 Dec 2021 14:14:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Subject: Re: [PATCH v3 08/13] ACPI: add perf low power callback
Message-ID: <202112011412.acnD0wZ5-lkp@intel.com>
References: <20211201010217.886919-9-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201010217.886919-9-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on tip/x86/core v5.16-rc3]
[cannot apply to rafael-pm/linux-next next-20211130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stephane-Eranian/perf-x86-amd-Add-AMD-Fam19h-Branch-Sampling-support/20211201-090506
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a9f4a6e92b3b319296fb078da2615f618f6cd80c
config: x86_64-randconfig-a015-20211130 (https://download.01.org/0day-ci/archive/20211201/202112011412.acnD0wZ5-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a31c16e71754213d4b773816a5871b0df6945510
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephane-Eranian/perf-x86-amd-Add-AMD-Fam19h-Branch-Sampling-support/20211201-090506
        git checkout a31c16e71754213d4b773816a5871b0df6945510
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/acpi/acpi_pad.c:168:4: error: implicit declaration of function 'perf_lopwr_cb' [-Werror,-Wimplicit-function-declaration]
                           perf_lopwr_cb(true);
                           ^
   1 error generated.


vim +/perf_lopwr_cb +168 drivers/acpi/acpi_pad.c

   135	
   136	static unsigned int idle_pct = 5; /* percentage */
   137	static unsigned int round_robin_time = 1; /* second */
   138	static int power_saving_thread(void *data)
   139	{
   140		int do_sleep;
   141		unsigned int tsk_index = (unsigned long)data;
   142		u64 last_jiffies = 0;
   143	
   144		sched_set_fifo_low(current);
   145	
   146		while (!kthread_should_stop()) {
   147			unsigned long expire_time;
   148	
   149			/* round robin to cpus */
   150			expire_time = last_jiffies + round_robin_time * HZ;
   151			if (time_before(expire_time, jiffies)) {
   152				last_jiffies = jiffies;
   153				round_robin_cpu(tsk_index);
   154			}
   155	
   156			do_sleep = 0;
   157	
   158			expire_time = jiffies + HZ * (100 - idle_pct) / 100;
   159	
   160			while (!need_resched()) {
   161				if (tsc_detected_unstable && !tsc_marked_unstable) {
   162					/* TSC could halt in idle, so notify users */
   163					mark_tsc_unstable("TSC halts in idle");
   164					tsc_marked_unstable = 1;
   165				}
   166				local_irq_disable();
   167	
 > 168				perf_lopwr_cb(true);
   169	
   170				tick_broadcast_enable();
   171				tick_broadcast_enter();
   172				stop_critical_timings();
   173	
   174				mwait_idle_with_hints(power_saving_mwait_eax, 1);
   175	
   176				start_critical_timings();
   177				tick_broadcast_exit();
   178	
   179				perf_lopwr_cb(false);
   180	
   181				local_irq_enable();
   182	
   183				if (time_before(expire_time, jiffies)) {
   184					do_sleep = 1;
   185					break;
   186				}
   187			}
   188	
   189			/*
   190			 * current sched_rt has threshold for rt task running time.
   191			 * When a rt task uses 95% CPU time, the rt thread will be
   192			 * scheduled out for 5% CPU time to not starve other tasks. But
   193			 * the mechanism only works when all CPUs have RT task running,
   194			 * as if one CPU hasn't RT task, RT task from other CPUs will
   195			 * borrow CPU time from this CPU and cause RT task use > 95%
   196			 * CPU time. To make 'avoid starvation' work, takes a nap here.
   197			 */
   198			if (unlikely(do_sleep))
   199				schedule_timeout_killable(HZ * idle_pct / 100);
   200	
   201			/* If an external event has set the need_resched flag, then
   202			 * we need to deal with it, or this loop will continue to
   203			 * spin without calling __mwait().
   204			 */
   205			if (unlikely(need_resched()))
   206				schedule();
   207		}
   208	
   209		exit_round_robin(tsk_index);
   210		return 0;
   211	}
   212	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
