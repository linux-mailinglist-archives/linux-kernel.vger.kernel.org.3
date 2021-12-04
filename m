Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E839D468830
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhLDXMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:12:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:31713 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232720AbhLDXMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:12:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="235885617"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="235885617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 15:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="610830526"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2021 15:09:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mte9Q-000JXj-JV; Sat, 04 Dec 2021 23:09:04 +0000
Date:   Sun, 5 Dec 2021 07:08:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:dev.2021.12.02a 30/43] kernel/kcsan/selftest.c:172:34:
 error: implicit declaration of function 'clear_bit_unlock_is_negative_byte'
Message-ID: <202112050757.x67rHnFU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.12.02a
head:   d157b802f05bd12cf40bef7a73ca6914b85c865e
commit: 510b49b8d4c91d32e946e9949e46aca42e709744 [30/43] kcsan: selftest: Add test case to check memory barrier instrumentation
config: s390-randconfig-r031-20211205 (https://download.01.org/0day-ci/archive/20211205/202112050757.x67rHnFU-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=510b49b8d4c91d32e946e9949e46aca42e709744
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2021.12.02a
        git checkout 510b49b8d4c91d32e946e9949e46aca42e709744
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash kernel/kcsan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/kcsan/selftest.c: In function 'test_barrier':
>> kernel/kcsan/selftest.c:172:34: error: implicit declaration of function 'clear_bit_unlock_is_negative_byte' [-Werror=implicit-function-declaration]
     172 |         KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/selftest.c:136:17: note: in definition of macro '__KCSAN_CHECK_BARRIER'
     136 |                 barrier;                                                                        \
         |                 ^~~~~~~
   kernel/kcsan/selftest.c:172:9: note: in expansion of macro 'KCSAN_CHECK_READ_BARRIER'
     172 |         KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/clear_bit_unlock_is_negative_byte +172 kernel/kcsan/selftest.c

   145	
   146		kcsan_nestable_atomic_begin(); /* No watchpoints in called functions. */
   147	
   148		KCSAN_CHECK_READ_BARRIER(mb());
   149		KCSAN_CHECK_READ_BARRIER(rmb());
   150		KCSAN_CHECK_READ_BARRIER(smp_mb());
   151		KCSAN_CHECK_READ_BARRIER(smp_rmb());
   152		KCSAN_CHECK_READ_BARRIER(dma_rmb());
   153		KCSAN_CHECK_READ_BARRIER(smp_mb__before_atomic());
   154		KCSAN_CHECK_READ_BARRIER(smp_mb__after_atomic());
   155		KCSAN_CHECK_READ_BARRIER(smp_mb__after_spinlock());
   156		KCSAN_CHECK_READ_BARRIER(smp_store_mb(test_var, 0));
   157		KCSAN_CHECK_READ_BARRIER(smp_store_release(&test_var, 0));
   158		KCSAN_CHECK_READ_BARRIER(xchg(&test_var, 0));
   159		KCSAN_CHECK_READ_BARRIER(xchg_release(&test_var, 0));
   160		KCSAN_CHECK_READ_BARRIER(cmpxchg(&test_var, 0,  0));
   161		KCSAN_CHECK_READ_BARRIER(cmpxchg_release(&test_var, 0,  0));
   162		KCSAN_CHECK_READ_BARRIER(atomic_set_release(&dummy, 0));
   163		KCSAN_CHECK_READ_BARRIER(atomic_add_return(1, &dummy));
   164		KCSAN_CHECK_READ_BARRIER(atomic_add_return_release(1, &dummy));
   165		KCSAN_CHECK_READ_BARRIER(atomic_fetch_add(1, &dummy));
   166		KCSAN_CHECK_READ_BARRIER(atomic_fetch_add_release(1, &dummy));
   167		KCSAN_CHECK_READ_BARRIER(test_and_set_bit(0, &test_var));
   168		KCSAN_CHECK_READ_BARRIER(test_and_clear_bit(0, &test_var));
   169		KCSAN_CHECK_READ_BARRIER(test_and_change_bit(0, &test_var));
   170		KCSAN_CHECK_READ_BARRIER(clear_bit_unlock(0, &test_var));
   171		KCSAN_CHECK_READ_BARRIER(__clear_bit_unlock(0, &test_var));
 > 172		KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
   173		arch_spin_lock(&arch_spinlock);
   174		KCSAN_CHECK_READ_BARRIER(arch_spin_unlock(&arch_spinlock));
   175		spin_lock(&spinlock);
   176		KCSAN_CHECK_READ_BARRIER(spin_unlock(&spinlock));
   177	
   178		KCSAN_CHECK_WRITE_BARRIER(mb());
   179		KCSAN_CHECK_WRITE_BARRIER(wmb());
   180		KCSAN_CHECK_WRITE_BARRIER(smp_mb());
   181		KCSAN_CHECK_WRITE_BARRIER(smp_wmb());
   182		KCSAN_CHECK_WRITE_BARRIER(dma_wmb());
   183		KCSAN_CHECK_WRITE_BARRIER(smp_mb__before_atomic());
   184		KCSAN_CHECK_WRITE_BARRIER(smp_mb__after_atomic());
   185		KCSAN_CHECK_WRITE_BARRIER(smp_mb__after_spinlock());
   186		KCSAN_CHECK_WRITE_BARRIER(smp_store_mb(test_var, 0));
   187		KCSAN_CHECK_WRITE_BARRIER(smp_store_release(&test_var, 0));
   188		KCSAN_CHECK_WRITE_BARRIER(xchg(&test_var, 0));
   189		KCSAN_CHECK_WRITE_BARRIER(xchg_release(&test_var, 0));
   190		KCSAN_CHECK_WRITE_BARRIER(cmpxchg(&test_var, 0,  0));
   191		KCSAN_CHECK_WRITE_BARRIER(cmpxchg_release(&test_var, 0,  0));
   192		KCSAN_CHECK_WRITE_BARRIER(atomic_set_release(&dummy, 0));
   193		KCSAN_CHECK_WRITE_BARRIER(atomic_add_return(1, &dummy));
   194		KCSAN_CHECK_WRITE_BARRIER(atomic_add_return_release(1, &dummy));
   195		KCSAN_CHECK_WRITE_BARRIER(atomic_fetch_add(1, &dummy));
   196		KCSAN_CHECK_WRITE_BARRIER(atomic_fetch_add_release(1, &dummy));
   197		KCSAN_CHECK_WRITE_BARRIER(test_and_set_bit(0, &test_var));
   198		KCSAN_CHECK_WRITE_BARRIER(test_and_clear_bit(0, &test_var));
   199		KCSAN_CHECK_WRITE_BARRIER(test_and_change_bit(0, &test_var));
   200		KCSAN_CHECK_WRITE_BARRIER(clear_bit_unlock(0, &test_var));
   201		KCSAN_CHECK_WRITE_BARRIER(__clear_bit_unlock(0, &test_var));
   202		KCSAN_CHECK_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
   203		arch_spin_lock(&arch_spinlock);
   204		KCSAN_CHECK_WRITE_BARRIER(arch_spin_unlock(&arch_spinlock));
   205		spin_lock(&spinlock);
   206		KCSAN_CHECK_WRITE_BARRIER(spin_unlock(&spinlock));
   207	
   208		KCSAN_CHECK_RW_BARRIER(mb());
   209		KCSAN_CHECK_RW_BARRIER(wmb());
   210		KCSAN_CHECK_RW_BARRIER(rmb());
   211		KCSAN_CHECK_RW_BARRIER(smp_mb());
   212		KCSAN_CHECK_RW_BARRIER(smp_wmb());
   213		KCSAN_CHECK_RW_BARRIER(smp_rmb());
   214		KCSAN_CHECK_RW_BARRIER(dma_wmb());
   215		KCSAN_CHECK_RW_BARRIER(dma_rmb());
   216		KCSAN_CHECK_RW_BARRIER(smp_mb__before_atomic());
   217		KCSAN_CHECK_RW_BARRIER(smp_mb__after_atomic());
   218		KCSAN_CHECK_RW_BARRIER(smp_mb__after_spinlock());
   219		KCSAN_CHECK_RW_BARRIER(smp_store_mb(test_var, 0));
   220		KCSAN_CHECK_RW_BARRIER(smp_store_release(&test_var, 0));
   221		KCSAN_CHECK_RW_BARRIER(xchg(&test_var, 0));
   222		KCSAN_CHECK_RW_BARRIER(xchg_release(&test_var, 0));
   223		KCSAN_CHECK_RW_BARRIER(cmpxchg(&test_var, 0,  0));
   224		KCSAN_CHECK_RW_BARRIER(cmpxchg_release(&test_var, 0,  0));
   225		KCSAN_CHECK_RW_BARRIER(atomic_set_release(&dummy, 0));
   226		KCSAN_CHECK_RW_BARRIER(atomic_add_return(1, &dummy));
   227		KCSAN_CHECK_RW_BARRIER(atomic_add_return_release(1, &dummy));
   228		KCSAN_CHECK_RW_BARRIER(atomic_fetch_add(1, &dummy));
   229		KCSAN_CHECK_RW_BARRIER(atomic_fetch_add_release(1, &dummy));
   230		KCSAN_CHECK_RW_BARRIER(test_and_set_bit(0, &test_var));
   231		KCSAN_CHECK_RW_BARRIER(test_and_clear_bit(0, &test_var));
   232		KCSAN_CHECK_RW_BARRIER(test_and_change_bit(0, &test_var));
   233		KCSAN_CHECK_RW_BARRIER(clear_bit_unlock(0, &test_var));
   234		KCSAN_CHECK_RW_BARRIER(__clear_bit_unlock(0, &test_var));
   235		KCSAN_CHECK_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
   236		arch_spin_lock(&arch_spinlock);
   237		KCSAN_CHECK_RW_BARRIER(arch_spin_unlock(&arch_spinlock));
   238		spin_lock(&spinlock);
   239		KCSAN_CHECK_RW_BARRIER(spin_unlock(&spinlock));
   240	
   241		kcsan_nestable_atomic_end();
   242	
   243		return ret;
   244	}
   245	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
