Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3509A47CF31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbhLVJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:26:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:44033 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243889AbhLVJ0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640165202; x=1671701202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BWSCNL8E8hvaZ2ldO5d2vDPYWr3g9rssV1h09w5DYN8=;
  b=bCL4PC2qkC7EOPuHoTvtdQUxxGtrlwsLiujix7aUHVM6ur5yO1eVEH1C
   YVQFy/2cYpcAEgagh/p4jzNn/Qt3iak8wFwpcFOKk2huthSzsvwvNVuxJ
   tg6rKDor42cmtN1q+Cywqm/UoigE6UDwF+0ktk0cBtC3NINvcR/1POd/l
   2irMq0mCigpVOreP0vtgi9W3m538TAzJ1jshIoeQvjLJgSbdAc9AJy8Ax
   1XbmL5AOIutXmpXc7P07XVvXDvxNKVxJgoEp+6Cnz8G/hviyLIxrmOkss
   FzEHu3I90bSj1v01dvQsladwTTviHwqww7lZv9bFOrWiP+nUabZlPAcqn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="238121170"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="238121170"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="466610892"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2021 01:26:39 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzxtO-0000Jb-J9; Wed, 22 Dec 2021 09:26:38 +0000
Date:   Wed, 22 Dec 2021 17:25:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 3/3] powerpc/vdso: Merge vdso64 and vdso32 into a single
 directory
Message-ID: <202112221723.qyvrCJHe-lkp@intel.com>
References: <c4ff129869fa6b0c936ff7e388eee42bb5f46778.1640108961.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ff129869fa6b0c936ff7e388eee42bb5f46778.1640108961.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v5.16-rc6 next-20211221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc-vdso-augment-VDSO32-functions-to-support-64-bits-build/20211222-021033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-randconfig-r023-20211222 (https://download.01.org/0day-ci/archive/20211222/202112221723.qyvrCJHe-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/0day-ci/linux/commit/16137812dbb55d25ebe3962d5fb7486cb5b43311
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/powerpc-vdso-augment-VDSO32-functions-to-support-64-bits-build/20211222-021033
        git checkout 16137812dbb55d25ebe3962d5fb7486cb5b43311
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   <stdin>:1559:2: warning: syscall futex_waitv not implemented [-W#warnings]
   #warning syscall futex_waitv not implemented
    ^
   1 warning generated.
>> arch/powerpc/kernel/vdso/gettimeofday.S:75:8: error: unsupported directive '.stabs'
   .stabs "_restgpr_31_x:F-1",36,0,0,_restgpr_31_x; .globl _restgpr_31_x; _restgpr_31_x:
          ^
   arch/powerpc/kernel/vdso/gettimeofday.S:76:8: error: unsupported directive '.stabs'
   .stabs "_rest32gpr_31_x:F-1",36,0,0,_rest32gpr_31_x; .globl _rest32gpr_31_x; _rest32gpr_31_x:
          ^
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:71: arch/powerpc/kernel/vdso/gettimeofday-32.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:421: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +75 arch/powerpc/kernel/vdso/gettimeofday.S

08c18b63d9656e arch/powerpc/kernel/vdso32/gettimeofday.S Christophe Leroy 2021-03-09  70  
08c18b63d9656e arch/powerpc/kernel/vdso32/gettimeofday.S Christophe Leroy 2021-03-09  71  /* Routines for restoring integer registers, called by the compiler.  */
08c18b63d9656e arch/powerpc/kernel/vdso32/gettimeofday.S Christophe Leroy 2021-03-09  72  /* Called with r11 pointing to the stack header word of the caller of the */
08c18b63d9656e arch/powerpc/kernel/vdso32/gettimeofday.S Christophe Leroy 2021-03-09  73  /* function, just beyond the end of the integer restore area.  */
11f0a078a8b6be arch/powerpc/kernel/vdso32/gettimeofday.S Christophe Leroy 2021-12-21  74  #ifndef __powerpc64__
08c18b63d9656e arch/powerpc/kernel/vdso32/gettimeofday.S Christophe Leroy 2021-03-09 @75  _GLOBAL(_restgpr_31_x)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
