Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD447B6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhLUBnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:43:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:43196 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhLUBnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640051020; x=1671587020;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y2r13LSehJuyWi3VUyYlT3eBWB8znWZRHuXXRToy74E=;
  b=JtYRS4RqM2D90vRRCVuvOfJVeW+C3dVMq7P1ANiYRX431/1nqdwg7wX9
   J/hnhaejr8rAMeiqQYYFEC4RJ49PlrCsfzA2MZlqtAJNa4sWZ3Iu9d/g8
   JMYv3Yf2oPJFw77HsOvN7alVd5pSJi0soVDGtvx3YsbzHfPQax6L0xwW5
   bLwSK85Y7JpUoyecg5A7wGfSLi22IMwVmoZCiOWQqnidW4O22ppcrpA4x
   nc8ZGdqLK8gaE8nad6N9NSruuRrqZOXS9Zgikr3D1TCJaLzGKhBoulFP3
   W6pCP9CVDgdOV4gFVBByiHoAi0BMajvNSfpzZyeuIJKjXdL9jNMpTfF1D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="237842490"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="237842490"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 17:43:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="570050947"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2021 17:43:38 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzUBl-0008Vi-EF; Tue, 21 Dec 2021 01:43:37 +0000
Date:   Tue, 21 Dec 2021 09:42:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangrui Song <maskray@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [linux-stable-rc:queue/4.19 3414/9999]
 arch/powerpc/kernel/process.c:1285:6: error: no previous prototype for
 function 'show_user_instructions'
Message-ID: <202112210926.fs7sutsS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangrui,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.19
head:   9f6406625bbb07737566962028df57ed2e9e7bc0
commit: 69c122751164c3c343eea205fd5c3e1d5132f967 [3414/9999] Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation
config: powerpc64-randconfig-r015-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210926.fs7sutsS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 683cbc12b33e5c8dc8d29bf5ed79fbf45763aadd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=69c122751164c3c343eea205fd5c3e1d5132f967
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.19
        git checkout 69c122751164c3c343eea205fd5c3e1d5132f967
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/process.c:18:
   In file included from include/linux/sched.h:12:
   In file included from arch/powerpc/include/asm/current.h:16:
   In file included from arch/powerpc/include/asm/paca.h:19:
   In file included from include/linux/string.h:6:
   In file included from include/linux/compiler.h:250:
   arch/powerpc/include/asm/barrier.h:47:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:311:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
   In file included from arch/powerpc/kernel/process.c:18:
   In file included from include/linux/sched.h:12:
   In file included from arch/powerpc/include/asm/current.h:16:
   In file included from arch/powerpc/include/asm/paca.h:21:
   In file included from arch/powerpc/include/asm/lppaca.h:36:
   In file included from arch/powerpc/include/asm/mmu.h:313:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:30:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1292:15: error: 'const' type qualifier on return type has no effect [-Werror,-Wignored-qualifiers]
   static inline const int pud_pfn(pud_t pud)
                 ^~~~~~
   arch/powerpc/kernel/process.c:216:16: error: variable 'cpumsr' set but not used [-Werror,-Wunused-but-set-variable]
           unsigned long cpumsr;
                         ^
>> arch/powerpc/kernel/process.c:1285:6: error: no previous prototype for function 'show_user_instructions' [-Werror,-Wmissing-prototypes]
   void show_user_instructions(struct pt_regs *regs)
        ^
   arch/powerpc/kernel/process.c:1285:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void show_user_instructions(struct pt_regs *regs)
   ^
   static 
   4 errors generated.
--
   In file included from arch/powerpc/kernel/mce_power.c:26:
   In file included from include/linux/ptrace.h:5:
   In file included from include/linux/compiler.h:250:
   arch/powerpc/include/asm/barrier.h:47:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:311:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
   In file included from arch/powerpc/kernel/mce_power.c:26:
   In file included from include/linux/ptrace.h:6:
   In file included from include/linux/sched.h:12:
   In file included from arch/powerpc/include/asm/current.h:16:
   In file included from arch/powerpc/include/asm/paca.h:21:
   In file included from arch/powerpc/include/asm/lppaca.h:36:
   In file included from arch/powerpc/include/asm/mmu.h:313:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:30:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1292:15: error: 'const' type qualifier on return type has no effect [-Werror,-Wignored-qualifiers]
   static inline const int pud_pfn(pud_t pud)
                 ^~~~~~
>> arch/powerpc/kernel/mce_power.c:601:6: error: no previous prototype for function '__machine_check_early_realmode_p7' [-Werror,-Wmissing-prototypes]
   long __machine_check_early_realmode_p7(struct pt_regs *regs)
        ^
   arch/powerpc/kernel/mce_power.c:601:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   long __machine_check_early_realmode_p7(struct pt_regs *regs)
   ^
   static 
>> arch/powerpc/kernel/mce_power.c:609:6: error: no previous prototype for function '__machine_check_early_realmode_p8' [-Werror,-Wmissing-prototypes]
   long __machine_check_early_realmode_p8(struct pt_regs *regs)
        ^
   arch/powerpc/kernel/mce_power.c:609:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   long __machine_check_early_realmode_p8(struct pt_regs *regs)
   ^
   static 
   arch/powerpc/kernel/mce_power.c:614:6: error: no previous prototype for function '__machine_check_early_realmode_p9' [-Werror,-Wmissing-prototypes]
   long __machine_check_early_realmode_p9(struct pt_regs *regs)
        ^
   arch/powerpc/kernel/mce_power.c:614:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   long __machine_check_early_realmode_p9(struct pt_regs *regs)
   ^
   static 
   5 errors generated.
--
   In file included from arch/powerpc/mm/pgtable-book3s64.c:10:
   In file included from include/linux/sched.h:12:
   In file included from arch/powerpc/include/asm/current.h:16:
   In file included from arch/powerpc/include/asm/paca.h:19:
   In file included from include/linux/string.h:6:
   In file included from include/linux/compiler.h:250:
   arch/powerpc/include/asm/barrier.h:47:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:311:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
   In file included from arch/powerpc/mm/pgtable-book3s64.c:10:
   In file included from include/linux/sched.h:12:
   In file included from arch/powerpc/include/asm/current.h:16:
   In file included from arch/powerpc/include/asm/paca.h:21:
   In file included from arch/powerpc/include/asm/lppaca.h:36:
   In file included from arch/powerpc/include/asm/mmu.h:313:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:30:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1292:15: error: 'const' type qualifier on return type has no effect [-Werror,-Wignored-qualifiers]
   static inline const int pud_pfn(pud_t pud)
                 ^~~~~~
   arch/powerpc/mm/pgtable-book3s64.c:462:6: error: no previous prototype for function 'arch_report_meminfo' [-Werror,-Wmissing-prototypes]
   void arch_report_meminfo(struct seq_file *m)
        ^
   arch/powerpc/mm/pgtable-book3s64.c:462:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void arch_report_meminfo(struct seq_file *m)
   ^
   static 
>> arch/powerpc/mm/pgtable-book3s64.c:493:5: error: no previous prototype for function 'pmd_move_must_withdraw' [-Werror,-Wmissing-prototypes]
   int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
       ^
   arch/powerpc/mm/pgtable-book3s64.c:493:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
   ^
   static 
   4 errors generated.
--
   In file included from arch/powerpc/mm/pkeys.c:8:
   In file included from arch/powerpc/include/asm/mman.h:15:
   In file included from include/linux/mm.h:9:
   In file included from include/linux/mmdebug.h:5:
   In file included from include/linux/bug.h:5:
   In file included from arch/powerpc/include/asm/bug.h:128:
   In file included from include/asm-generic/bug.h:5:
   In file included from include/linux/compiler.h:250:
   arch/powerpc/include/asm/barrier.h:47:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:311:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
   In file included from arch/powerpc/mm/pkeys.c:8:
   In file included from arch/powerpc/include/asm/mman.h:15:
   In file included from include/linux/mm.h:10:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:54:
   In file included from include/linux/irqflags.h:16:
   In file included from arch/powerpc/include/asm/irqflags.h:12:
   In file included from arch/powerpc/include/asm/hw_irq.h:64:
   In file included from arch/powerpc/include/asm/paca.h:21:
   In file included from arch/powerpc/include/asm/lppaca.h:36:
   In file included from arch/powerpc/include/asm/mmu.h:313:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:30:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1292:15: error: 'const' type qualifier on return type has no effect [-Werror,-Wignored-qualifiers]
   static inline const int pud_pfn(pud_t pud)
                 ^~~~~~
>> arch/powerpc/mm/pkeys.c:60:5: error: no previous prototype for function 'pkey_initialize' [-Werror,-Wmissing-prototypes]
   int pkey_initialize(void)
       ^
   arch/powerpc/mm/pkeys.c:60:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int pkey_initialize(void)
   ^
   static 
>> arch/powerpc/mm/pkeys.c:406:6: error: no previous prototype for function 'arch_vma_access_permitted' [-Werror,-Wmissing-prototypes]
   bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
        ^
   arch/powerpc/mm/pkeys.c:406:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
   ^
   static 
>> arch/powerpc/mm/pkeys.c:420:6: error: no previous prototype for function 'arch_dup_pkeys' [-Werror,-Wmissing-prototypes]
   void arch_dup_pkeys(struct mm_struct *oldmm, struct mm_struct *mm)
        ^
   arch/powerpc/mm/pkeys.c:420:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void arch_dup_pkeys(struct mm_struct *oldmm, struct mm_struct *mm)
   ^
   static 
   5 errors generated.
--
   In file included from arch/powerpc/sysdev/udbg_memcons.c:21:
   In file included from include/linux/kernel.h:10:
   In file included from include/linux/compiler.h:250:
   arch/powerpc/include/asm/barrier.h:47:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:311:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
>> arch/powerpc/sysdev/udbg_memcons.c:48:6: error: no previous prototype for function 'memcons_putc' [-Werror,-Wmissing-prototypes]
   void memcons_putc(char c)
        ^
   arch/powerpc/sysdev/udbg_memcons.c:48:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void memcons_putc(char c)
   ^
   static 
>> arch/powerpc/sysdev/udbg_memcons.c:61:5: error: no previous prototype for function 'memcons_getc_poll' [-Werror,-Wmissing-prototypes]
   int memcons_getc_poll(void)
       ^
   arch/powerpc/sysdev/udbg_memcons.c:61:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int memcons_getc_poll(void)
   ^
   static 
>> arch/powerpc/sysdev/udbg_memcons.c:84:5: error: no previous prototype for function 'memcons_getc' [-Werror,-Wmissing-prototypes]
   int memcons_getc(void)
       ^
   arch/powerpc/sysdev/udbg_memcons.c:84:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int memcons_getc(void)
   ^
   static 
   4 errors generated.
--
   In file included from arch/powerpc/platforms/powermac/feature.c:20:
   In file included from include/linux/init.h:5:
   In file included from include/linux/compiler.h:250:
   arch/powerpc/include/asm/barrier.h:47:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:311:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
   In file included from arch/powerpc/platforms/powermac/feature.c:21:
   In file included from include/linux/delay.h:26:
   In file included from arch/powerpc/include/asm/delay.h:6:
   In file included from arch/powerpc/include/asm/time.h:18:
   In file included from include/linux/percpu.h:7:
   In file included from include/linux/smp.h:64:
   In file included from arch/powerpc/include/asm/smp.h:28:
   In file included from arch/powerpc/include/asm/paca.h:21:
   In file included from arch/powerpc/include/asm/lppaca.h:36:
   In file included from arch/powerpc/include/asm/mmu.h:313:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:30:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1292:15: error: 'const' type qualifier on return type has no effect [-Werror,-Wignored-qualifiers]
   static inline const int pud_pfn(pud_t pud)
                 ^~~~~~
>> arch/powerpc/platforms/powermac/feature.c:1548:6: error: no previous prototype for function 'g5_phy_disable_cpu1' [-Werror,-Wmissing-prototypes]
   void g5_phy_disable_cpu1(void)
        ^
   arch/powerpc/platforms/powermac/feature.c:1548:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void g5_phy_disable_cpu1(void)
   ^
   static 
   3 errors generated.
--
   In file included from arch/powerpc/platforms/powernv/pci-ioda.c:14:
   In file included from include/linux/kernel.h:10:
   In file included from include/linux/compiler.h:250:
   arch/powerpc/include/asm/barrier.h:47:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:311:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
   In file included from arch/powerpc/platforms/powernv/pci-ioda.c:15:
   In file included from include/linux/pci.h:29:
   In file included from include/linux/kobject.h:20:
   In file included from include/linux/sysfs.h:16:
   In file included from include/linux/kernfs.h:13:
   In file included from include/linux/mutex.h:14:
   In file included from arch/powerpc/include/asm/current.h:16:
   In file included from arch/powerpc/include/asm/paca.h:21:
   In file included from arch/powerpc/include/asm/lppaca.h:36:
   In file included from arch/powerpc/include/asm/mmu.h:313:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:30:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1292:15: error: 'const' type qualifier on return type has no effect [-Werror,-Wignored-qualifiers]
   static inline const int pud_pfn(pud_t pud)
                 ^~~~~~
>> arch/powerpc/platforms/powernv/pci-ioda.c:874:18: error: variable 'parent' set but not used [-Werror,-Wunused-but-set-variable]
           struct pci_dev *parent;
                           ^
   3 errors generated.
--
   In file included from arch/powerpc/platforms/pseries/ras.c:19:
   In file included from include/linux/sched.h:12:
   In file included from arch/powerpc/include/asm/current.h:16:
   In file included from arch/powerpc/include/asm/paca.h:19:
   In file included from include/linux/string.h:6:
   In file included from include/linux/compiler.h:250:
   arch/powerpc/include/asm/barrier.h:47:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:311:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
   In file included from arch/powerpc/platforms/pseries/ras.c:19:
   In file included from include/linux/sched.h:12:
   In file included from arch/powerpc/include/asm/current.h:16:
   In file included from arch/powerpc/include/asm/paca.h:21:
   In file included from arch/powerpc/include/asm/lppaca.h:36:
   In file included from arch/powerpc/include/asm/mmu.h:313:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:30:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:24:
   arch/powerpc/include/asm/book3s/64/pgtable.h:1292:15: error: 'const' type qualifier on return type has no effect [-Werror,-Wignored-qualifiers]
   static inline const int pud_pfn(pud_t pud)
                 ^~~~~~
   arch/powerpc/platforms/pseries/ras.c:59:12: error: no previous prototype for function 'init_ras_hotplug_IRQ' [-Werror,-Wmissing-prototypes]
   int __init init_ras_hotplug_IRQ(void)
              ^
   arch/powerpc/platforms/pseries/ras.c:59:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init init_ras_hotplug_IRQ(void)
   ^
   static 
>> arch/powerpc/platforms/pseries/ras.c:163:7: error: variable 'modifier' set but not used [-Werror,-Wunused-but-set-variable]
           char modifier;
                ^
   arch/powerpc/platforms/pseries/ras.c:252:6: error: variable 'status' set but not used [-Werror,-Wunused-but-set-variable]
           int status;
               ^
   5 errors generated.


vim +/show_user_instructions +1285 arch/powerpc/kernel/process.c

06d67d54741a5b Paul Mackerras          2005-10-10  1284  
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01 @1285  void show_user_instructions(struct pt_regs *regs)
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1286  {
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1287  	unsigned long pc;
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1288  	int i;
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1289  
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1290  	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1291  
a932ed3b718147 Michael Ellerman        2018-10-05  1292  	/*
a932ed3b718147 Michael Ellerman        2018-10-05  1293  	 * Make sure the NIP points at userspace, not kernel text/data or
a932ed3b718147 Michael Ellerman        2018-10-05  1294  	 * elsewhere.
a932ed3b718147 Michael Ellerman        2018-10-05  1295  	 */
a932ed3b718147 Michael Ellerman        2018-10-05  1296  	if (!__access_ok(pc, instructions_to_print * sizeof(int), USER_DS)) {
a932ed3b718147 Michael Ellerman        2018-10-05  1297  		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
a932ed3b718147 Michael Ellerman        2018-10-05  1298  			current->comm, current->pid);
a932ed3b718147 Michael Ellerman        2018-10-05  1299  		return;
a932ed3b718147 Michael Ellerman        2018-10-05  1300  	}
a932ed3b718147 Michael Ellerman        2018-10-05  1301  
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1302  	pr_info("%s[%d]: code: ", current->comm, current->pid);
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1303  
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1304  	for (i = 0; i < instructions_to_print; i++) {
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1305  		int instr;
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1306  
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1307  		if (!(i % 8) && (i > 0)) {
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1308  			pr_cont("\n");
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1309  			pr_info("%s[%d]: code: ", current->comm, current->pid);
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1310  		}
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1311  
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1312  		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1313  			pr_cont("XXXXXXXX ");
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1314  		} else {
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1315  			if (regs->nip == pc)
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1316  				pr_cont("<%08x> ", instr);
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1317  			else
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1318  				pr_cont("%08x ", instr);
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1319  		}
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1320  
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1321  		pc += sizeof(int);
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1322  	}
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1323  
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1324  	pr_cont("\n");
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1325  }
88b0fe17573592 Murilo Opsfelder Araujo 2018-08-01  1326  

:::::: The code at line 1285 was first introduced by commit
:::::: 88b0fe17573592a8e3196bf143f865da460178e7 powerpc: Add show_user_instructions()

:::::: TO: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
