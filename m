Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8E462E38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhK3IJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:09:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:30851 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239444AbhK3IJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:09:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="296970954"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="296970954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 00:05:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="512072477"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Nov 2021 00:05:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mry8s-000CwX-GP; Tue, 30 Nov 2021 08:05:34 +0000
Date:   Tue, 30 Nov 2021 16:04:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/dev 120/125]
 kernel/time/clocksource-wdtest.c:149:12: error: use of undeclared identifier
 'max_cswd_coarse_reads'
Message-ID: <202111301537.pHj67CAh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/dev
head:   0a3f160b60a833f2ac5e68a0b3105005c69f185f
commit: 21285cc89332025a23fca4c50a9d132d1b4109b5 [120/125] squash! clocksource: Forgive repeated long-latency watchdog clocksource reads
config: x86_64-buildonly-randconfig-r001-20211128 (https://download.01.org/0day-ci/archive/20211130/202111301537.pHj67CAh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=21285cc89332025a23fca4c50a9d132d1b4109b5
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/dev
        git checkout 21285cc89332025a23fca4c50a9d132d1b4109b5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/time/clocksource-wdtest.c:149:12: error: use of undeclared identifier 'max_cswd_coarse_reads'
                   if (i != max_cswd_coarse_reads)
                            ^
   1 error generated.


vim +/max_cswd_coarse_reads +149 kernel/time/clocksource-wdtest.c

1253b9b87e42ab Paul E. McKenney 2021-05-27  102  
1253b9b87e42ab Paul E. McKenney 2021-05-27  103  /* Run the specified series of watchdog tests. */
1253b9b87e42ab Paul E. McKenney 2021-05-27  104  static int wdtest_func(void *arg)
1253b9b87e42ab Paul E. McKenney 2021-05-27  105  {
1253b9b87e42ab Paul E. McKenney 2021-05-27  106  	unsigned long j1, j2;
92b8b82aa04917 Paul E. McKenney 2021-10-22  107  	char *s1, *s2;
1253b9b87e42ab Paul E. McKenney 2021-05-27  108  	int i;
1253b9b87e42ab Paul E. McKenney 2021-05-27  109  
1253b9b87e42ab Paul E. McKenney 2021-05-27  110  	schedule_timeout_uninterruptible(holdoff * HZ);
1253b9b87e42ab Paul E. McKenney 2021-05-27  111  
1253b9b87e42ab Paul E. McKenney 2021-05-27  112  	/*
1253b9b87e42ab Paul E. McKenney 2021-05-27  113  	 * Verify that jiffies-like clocksources get the manually
1253b9b87e42ab Paul E. McKenney 2021-05-27  114  	 * specified uncertainty margin.
1253b9b87e42ab Paul E. McKenney 2021-05-27  115  	 */
1253b9b87e42ab Paul E. McKenney 2021-05-27  116  	pr_info("--- Verify jiffies-like uncertainty margin.\n");
1253b9b87e42ab Paul E. McKenney 2021-05-27  117  	__clocksource_register(&clocksource_wdtest_jiffies);
1253b9b87e42ab Paul E. McKenney 2021-05-27  118  	WARN_ON_ONCE(clocksource_wdtest_jiffies.uncertainty_margin != TICK_NSEC);
1253b9b87e42ab Paul E. McKenney 2021-05-27  119  
1253b9b87e42ab Paul E. McKenney 2021-05-27  120  	j1 = clocksource_wdtest_jiffies.read(&clocksource_wdtest_jiffies);
1253b9b87e42ab Paul E. McKenney 2021-05-27  121  	schedule_timeout_uninterruptible(HZ);
1253b9b87e42ab Paul E. McKenney 2021-05-27  122  	j2 = clocksource_wdtest_jiffies.read(&clocksource_wdtest_jiffies);
1253b9b87e42ab Paul E. McKenney 2021-05-27  123  	WARN_ON_ONCE(j1 == j2);
1253b9b87e42ab Paul E. McKenney 2021-05-27  124  
1253b9b87e42ab Paul E. McKenney 2021-05-27  125  	clocksource_unregister(&clocksource_wdtest_jiffies);
1253b9b87e42ab Paul E. McKenney 2021-05-27  126  
1253b9b87e42ab Paul E. McKenney 2021-05-27  127  	/*
1253b9b87e42ab Paul E. McKenney 2021-05-27  128  	 * Verify that tsc-like clocksources are assigned a reasonable
1253b9b87e42ab Paul E. McKenney 2021-05-27  129  	 * uncertainty margin.
1253b9b87e42ab Paul E. McKenney 2021-05-27  130  	 */
1253b9b87e42ab Paul E. McKenney 2021-05-27  131  	pr_info("--- Verify tsc-like uncertainty margin.\n");
1253b9b87e42ab Paul E. McKenney 2021-05-27  132  	clocksource_register_khz(&clocksource_wdtest_ktime, 1000 * 1000);
1253b9b87e42ab Paul E. McKenney 2021-05-27  133  	WARN_ON_ONCE(clocksource_wdtest_ktime.uncertainty_margin < NSEC_PER_USEC);
1253b9b87e42ab Paul E. McKenney 2021-05-27  134  
1253b9b87e42ab Paul E. McKenney 2021-05-27  135  	j1 = clocksource_wdtest_ktime.read(&clocksource_wdtest_ktime);
1253b9b87e42ab Paul E. McKenney 2021-05-27  136  	udelay(1);
1253b9b87e42ab Paul E. McKenney 2021-05-27  137  	j2 = clocksource_wdtest_ktime.read(&clocksource_wdtest_ktime);
1253b9b87e42ab Paul E. McKenney 2021-05-27  138  	pr_info("--- tsc-like times: %lu - %lu = %lu.\n", j2, j1, j2 - j1);
1253b9b87e42ab Paul E. McKenney 2021-05-27  139  	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
1253b9b87e42ab Paul E. McKenney 2021-05-27  140  
1253b9b87e42ab Paul E. McKenney 2021-05-27  141  	/* Verify tsc-like stability with various numbers of errors injected. */
1253b9b87e42ab Paul E. McKenney 2021-05-27  142  	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
1253b9b87e42ab Paul E. McKenney 2021-05-27  143  		if (i <= 1 && i < max_cswd_read_retries)
92b8b82aa04917 Paul E. McKenney 2021-10-22  144  			s1 = "";
1253b9b87e42ab Paul E. McKenney 2021-05-27  145  		else if (i <= max_cswd_read_retries)
92b8b82aa04917 Paul E. McKenney 2021-10-22  146  			s1 = ", expect message";
1253b9b87e42ab Paul E. McKenney 2021-05-27  147  		else
92b8b82aa04917 Paul E. McKenney 2021-10-22  148  			s1 = ", expect coarse-grained clock skew check and re-initialization";
92b8b82aa04917 Paul E. McKenney 2021-10-22 @149  		if (i != max_cswd_coarse_reads)
92b8b82aa04917 Paul E. McKenney 2021-10-22  150  			s2 = "";
92b8b82aa04917 Paul E. McKenney 2021-10-22  151  		else if (!s1[0])
92b8b82aa04917 Paul E. McKenney 2021-10-22  152  			s2 = ", expect splat";
92b8b82aa04917 Paul E. McKenney 2021-10-22  153  		else
92b8b82aa04917 Paul E. McKenney 2021-10-22  154  			s2 = " along with a splat";
92b8b82aa04917 Paul E. McKenney 2021-10-22  155  		pr_info("--- Watchdog with %dx error injection, %lu retries%s%s.\n", i, max_cswd_read_retries, s1, s2);
1253b9b87e42ab Paul E. McKenney 2021-05-27  156  		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
1253b9b87e42ab Paul E. McKenney 2021-05-27  157  		schedule_timeout_uninterruptible(2 * HZ);
1253b9b87e42ab Paul E. McKenney 2021-05-27  158  		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
83272afd00b829 Paul E. McKenney 2021-05-27  159  		WARN_ON_ONCE(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE);
1253b9b87e42ab Paul E. McKenney 2021-05-27  160  		wdtest_ktime_clocksource_reset();
1253b9b87e42ab Paul E. McKenney 2021-05-27  161  	}
1253b9b87e42ab Paul E. McKenney 2021-05-27  162  
1253b9b87e42ab Paul E. McKenney 2021-05-27  163  	/* Verify tsc-like stability with clock-value-fuzz error injection. */
1253b9b87e42ab Paul E. McKenney 2021-05-27  164  	pr_info("--- Watchdog clock-value-fuzz error injection, expect clock skew and per-CPU mismatches.\n");
1253b9b87e42ab Paul E. McKenney 2021-05-27  165  	WRITE_ONCE(wdtest_ktime_read_fuzz, true);
1253b9b87e42ab Paul E. McKenney 2021-05-27  166  	schedule_timeout_uninterruptible(2 * HZ);
1253b9b87e42ab Paul E. McKenney 2021-05-27  167  	WARN_ON_ONCE(!(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
1253b9b87e42ab Paul E. McKenney 2021-05-27  168  	clocksource_verify_percpu(&clocksource_wdtest_ktime);
1253b9b87e42ab Paul E. McKenney 2021-05-27  169  	WRITE_ONCE(wdtest_ktime_read_fuzz, false);
1253b9b87e42ab Paul E. McKenney 2021-05-27  170  
1253b9b87e42ab Paul E. McKenney 2021-05-27  171  	clocksource_unregister(&clocksource_wdtest_ktime);
1253b9b87e42ab Paul E. McKenney 2021-05-27  172  
1253b9b87e42ab Paul E. McKenney 2021-05-27  173  	pr_info("--- Done with test.\n");
1253b9b87e42ab Paul E. McKenney 2021-05-27  174  	return 0;
1253b9b87e42ab Paul E. McKenney 2021-05-27  175  }
1253b9b87e42ab Paul E. McKenney 2021-05-27  176  

:::::: The code at line 149 was first introduced by commit
:::::: 92b8b82aa04917537136ad3f8e23f908573c4b73 torture: Test splatting for delay-ridden clocksources

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
