Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4D4E3530
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiCUX7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiCUX7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:59:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCEF6C92C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647907018; x=1679443018;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rJEfyOReNJQTGn+tVBm2YXQgWt5h+CMA1eKwF0napew=;
  b=bSee/7ha5ZYcYl4ckq5lEqtEiK552jndf1pxRAGeGDKHBhPl5JunJ8pV
   Yc8E0piQFkkL+o8osk2WBop6shLwDDbwOAJyWP4laC8R+J2StFUgVrhyG
   YSkZHBV5kirJKcpuOwvMi/hhsjHKeGgLyYM31ivl8rKbenoPkhnYmkZGX
   GMVZeG73KMpUzz8ry6mJyoUorIIUcf5TOxPiGMjeMGDyKcu6q+UK8d+eR
   A16l9t8yE9BPoIpGRb1U/Oq1L+uF4Y2o3xmTMB0u3ECvhY8SYi9CM8XKf
   hWdyHwvwtkQ9+kVU0GQsQlp49XxWYbWdM6eEF2DlvlEXslgLXXV8NZHyo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344106687"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="344106687"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 16:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="515120209"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2022 16:55:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWRrk-000IIN-Sg; Mon, 21 Mar 2022 23:55:12 +0000
Date:   Tue, 22 Mar 2022 07:54:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: kernel/time/hrtimer.c:650:19: warning: unused function
 'hrtimer_hres_active'
Message-ID: <202203220741.Ez9nK7eG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f443e374ae131c168a065ea1748feac6b2e76613
commit: 9482fd71dbb8f0d1a61821a83e467dc0a9d7b429 hrtimer: Use raw_cpu_ptr() in clock_was_set()
date:   7 months ago
config: mips-randconfig-r022-20220319 (https://download.01.org/0day-ci/archive/20220322/202203220741.Ez9nK7eG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 217f267efe3082438e698e2f08566b9df8c530fa)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9482fd71dbb8f0d1a61821a83e467dc0a9d7b429
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9482fd71dbb8f0d1a61821a83e467dc0a9d7b429
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
   kernel/time/hrtimer.c:276:20: warning: unused function 'is_migration_base'
   static inline bool is_migration_base(struct hrtimer_clock_base
   ^
>> kernel/time/hrtimer.c:650:19: warning: unused function 'hrtimer_hres_active'
   static inline int hrtimer_hres_active(void)
   ^
   kernel/time/hrtimer.c:1887:20: warning: unused function '__hrtimer_peek_ahead_timers'
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


vim +/hrtimer_hres_active +650 kernel/time/hrtimer.c

28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  649  
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21 @650  static inline int hrtimer_hres_active(void)
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  651  {
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  652  	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  653  }
28bfd18bf3daa5 Anna-Maria Gleixner 2017-12-21  654  

:::::: The code at line 650 was first introduced by commit
:::::: 28bfd18bf3daa5db8bb3422ea7138c8b7d2444ac hrtimer: Make the hrtimer_cpu_base::hres_active field unconditional, to simplify the code

:::::: TO: Anna-Maria Gleixner <anna-maria@linutronix.de>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
