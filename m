Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600B4E30CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352667AbiCUTcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiCUTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:31:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118EE4C7AF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647891032; x=1679427032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0TYd6gMz9/UO7N5xndFl7v9dU6morw42GxdVe8VECUw=;
  b=cxL5bvAy78y94HsTkNLqUKoF+Gh6ifpkeofwN5O4VTzIaIUYtL9p2d0/
   BUwN9ZuICWjQwmbe72FqFfqPYkSE9YzvxeJiWuwOSwTcWOJk3acoTUGKX
   p3kPFYo2Z43mAnskbcsOzJj1Uyhf1wIkkdAwEAitlrAA3H76QD7rokLWE
   a6l51YVbAE7rdScBwTaJ8nVKW90rJRfXGThrpSIUI80+kCSbSwp4lMo5c
   WO21q1wQE4oo4sdMvobBY7iwlZCSug6HFOBHZoTjgk6fzxeTFJQDTWpgt
   oRAuptf6F+14y0b5LCllsJyZ5Mz/bKlkVCIvwzNDOH48cA3G+fEVFQmPh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282461877"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="282461877"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 12:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="716616948"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2022 12:30:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWNjZ-000I5t-1Y; Mon, 21 Mar 2022 19:30:29 +0000
Date:   Tue, 22 Mar 2022 03:30:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/time/hrtimer.c:276:20: warning: unused function
 'is_migration_base'
Message-ID: <202203220318.lF1LF4vW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f443e374ae131c168a065ea1748feac6b2e76613
commit: 81d741d3460ca422843ce0ec8351083f259c6166 hrtimer: Avoid unnecessary SMP function calls in clock_was_set()
date:   7 months ago
config: mips-randconfig-r022-20220319 (https://download.01.org/0day-ci/archive/20220322/202203220318.lF1LF4vW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 217f267efe3082438e698e2f08566b9df8c530fa)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81d741d3460ca422843ce0ec8351083f259c6166
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 81d741d3460ca422843ce0ec8351083f259c6166
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/iommu/ fs/ kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/time/hrtimer.c:120:21: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_REALTIME,
   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:22: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_MONOTONIC,
   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:21: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_BOOTTIME,
   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:17: warning: initializer overrides prior initialization of this subobject
   = HRTIMER_BASE_TAI,
   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
   [0 ... MAX_CLOCKS - 1] = HRTIMER_MAX_CLOCK_BASES,
   ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/time/hrtimer.c:276:20: warning: unused function 'is_migration_base'
   static inline bool is_migration_base(struct hrtimer_clock_base
   ^
>> kernel/time/hrtimer.c:1830:20: warning: unused function '__hrtimer_peek_ahead_timers'
   static inline void __hrtimer_peek_ahead_timers(void) { }
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 105, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   or $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-85e9b2687a/bin
   clang-15: note: diagnostic msg:
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm scripts security sound source usr virt


vim +/is_migration_base +276 kernel/time/hrtimer.c

c0a3132963db68 kernel/hrtimer.c      Thomas Gleixner           2006-01-09  275  
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04 @276  static inline bool is_migration_base(struct hrtimer_clock_base *base)
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  277  {
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  278  	return false;
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  279  }
5d2295f3a93b04 kernel/time/hrtimer.c Sebastian Andrzej Siewior 2019-09-04  280  

:::::: The code at line 276 was first introduced by commit
:::::: 5d2295f3a93b04986d069ebeaf5b07725f9096c1 hrtimer: Add a missing bracket and hide `migration_base' on !SMP

:::::: TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
