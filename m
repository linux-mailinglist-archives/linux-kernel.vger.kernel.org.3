Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1D462723
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhK2XBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:01:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:18548 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236824AbhK2XAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234819051"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="234819051"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:56:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511903144"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 29 Nov 2021 14:56:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrpZO-000CT1-TV; Mon, 29 Nov 2021 22:56:22 +0000
Date:   Tue, 30 Nov 2021 06:55:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] powerpc/inst: Optimise
 copy_inst_from_kernel_nofault()
Message-ID: <202111300652.0yDBNvyJ-lkp@intel.com>
References: <0d5b12183d5176dd702d29ad94c39c384e51c78f.1638208156.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d5b12183d5176dd702d29ad94c39c384e51c78f.1638208156.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on v5.16-rc3 next-20211129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc-inst-Refactor-___get_user_instr/20211130-015346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-randconfig-r023-20211129 (https://download.01.org/0day-ci/archive/20211130/202111300652.0yDBNvyJ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project df08b2fe8b35cb63dfb3b49738a3494b9b4e6f8e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/0day-ci/linux/commit/fb7bff30cc0efc7e4df1b48bb69de1f325eee826
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/powerpc-inst-Refactor-___get_user_instr/20211130-015346
        git checkout fb7bff30cc0efc7e4df1b48bb69de1f325eee826
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:71:
   In file included from arch/powerpc/kernel/../xmon/xmon_bpts.h:7:
>> arch/powerpc/include/asm/inst.h:165:20: warning: variable 'val' is uninitialized when used here [-Wuninitialized]
                   *inst = ppc_inst(val);
                                    ^~~
   arch/powerpc/include/asm/inst.h:53:22: note: expanded from macro 'ppc_inst'
   #define ppc_inst(x) (x)
                        ^
   arch/powerpc/include/asm/inst.h:155:18: note: initialize the variable 'val' to silence this warning
           unsigned int val, suffix;
                           ^
                            = 0
   1 warning generated.
   <stdin>:1559:2: warning: syscall futex_waitv not implemented [-W#warnings]
   #warning syscall futex_waitv not implemented
    ^
   1 warning generated.
   arch/powerpc/kernel/vdso32/gettimeofday.S:72:8: error: unsupported directive '.stabs'
   .stabs "_restgpr_31_x:F-1",36,0,0,_restgpr_31_x; .globl _restgpr_31_x; _restgpr_31_x:
          ^
   arch/powerpc/kernel/vdso32/gettimeofday.S:73:8: error: unsupported directive '.stabs'
   .stabs "_rest32gpr_31_x:F-1",36,0,0,_rest32gpr_31_x; .globl _rest32gpr_31_x; _rest32gpr_31_x:
          ^
   make[2]: *** [arch/powerpc/kernel/vdso32/Makefile:55: arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:421: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/val +165 arch/powerpc/include/asm/inst.h

   152	
   153	static inline int copy_inst_from_kernel_nofault(ppc_inst_t *inst, u32 *src)
   154	{
   155		unsigned int val, suffix;
   156	
   157		if (unlikely(!is_kernel_addr((unsigned long)src)))
   158			return -ERANGE;
   159	
   160		__get_kernel_nofault(&val, src, u32, Efault);
   161		if (IS_ENABLED(CONFIG_PPC64) && get_op(val) == OP_PREFIX) {
   162			__get_kernel_nofault(&suffix, src + 1, u32, Efault);
   163			*inst = ppc_inst_prefix(val, suffix);
   164		} else {
 > 165			*inst = ppc_inst(val);
   166		}
   167		return 0;
   168	Efault:
   169		return -EFAULT;
   170	}
   171	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
