Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88C46BA72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhLGL50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:57:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:19735 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhLGL50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:57:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298355150"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="298355150"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 03:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="611646323"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2021 03:53:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muZ2f-000MWe-NC; Tue, 07 Dec 2021 11:53:53 +0000
Date:   Tue, 7 Dec 2021 19:53:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: include/linux/compiler_types.h:328:45: error: call to
 '__compiletime_assert_202' declared with attribute error: BUILD_BUG failed
Message-ID: <202112071925.61r0Z8V1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cd8c917a56f20f48748dd43d9ae3caff51d5b987
commit: 4775bc63f880001ee4fbd6456b12ab04674149e3 clocksource/arm_arch_timer: Add build-time guards for unhandled register accesses
date:   7 weeks ago
config: arm64-randconfig-r003-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071925.61r0Z8V1-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4775bc63f880001ee4fbd6456b12ab04674149e3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4775bc63f880001ee4fbd6456b12ab04674149e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'arch_timer_reg_read_cp15',
       inlined from 'arch_timer_reg_read' at drivers/clocksource/arm_arch_timer.c:166:9,
       inlined from 'erratum_set_next_event_tval_generic' at drivers/clocksource/arm_arch_timer.c:414:9:
>> include/linux/compiler_types.h:328:45: error: call to '__compiletime_assert_202' declared with attribute error: BUILD_BUG failed
     328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:309:25: note: in definition of macro '__compiletime_assert'
     309 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:328:9: note: in expansion of macro '_compiletime_assert'
     328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/arch_timer.h:159:9: note: in expansion of macro 'BUILD_BUG'
     159 |         BUILD_BUG();
         |         ^~~~~~~~~
   In function 'arch_timer_reg_write_cp15',
       inlined from 'arch_timer_reg_write' at drivers/clocksource/arm_arch_timer.c:131:3,
       inlined from 'erratum_set_next_event_tval_generic' at drivers/clocksource/arm_arch_timer.c:426:2:
   include/linux/compiler_types.h:328:45: error: call to '__compiletime_assert_199' declared with attribute error: BUILD_BUG failed
     328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:309:25: note: in definition of macro '__compiletime_assert'
     309 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:328:9: note: in expansion of macro '_compiletime_assert'
     328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/arch_timer.h:130:17: note: in expansion of macro 'BUILD_BUG'
     130 |                 BUILD_BUG();
         |                 ^~~~~~~~~


vim +/__compiletime_assert_202 +328 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  315  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  316  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  317  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  318  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  319   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  320   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  321   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  322   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  323   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  324   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  325   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  326   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  327  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @328  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  329  

:::::: The code at line 328 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
