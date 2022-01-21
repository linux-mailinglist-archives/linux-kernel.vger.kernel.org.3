Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D92449624F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381676AbiAUPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:48:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:42505 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351414AbiAUPs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642780137; x=1674316137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tZavJmFJlah88SPz7oAby0xWFiz/iTrYXQFuYXy77jU=;
  b=dMkc7O9WVBzQFh2l9aY6zlvy8vo9x/AIakgUbOkg+i3b8zqxGYQ9Npc5
   qGbGko4IFfQHt/wO9PErDKPKHE8WAWLI5uj5PO2Hk+8/J7r5axy+iYlVq
   r4AvDKmIcQGzqToPsLWjPYjh1cFahXyFIlLzuXFHTrzgJgiy14Ua6k4Eo
   U8KGP2vLpp9biYPmrjW6GDcsPMyCqHKPzcZgVc84qywTvQDPOzFecj/3o
   EwL8x58goo5owRwxjCclRlEpDX6NFrXzxi4a2XPkX1lzrJ9s7Fn1qSbwp
   gIYYPXGGeoDz76TNJS9BIFRFJwhf5ve1hZoBrgeZaaoqWcSZKYIa1Uf/V
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="243273435"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="243273435"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 07:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="694674504"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 07:48:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAw9m-000FRD-Co; Fri, 21 Jan 2022 15:48:54 +0000
Date:   Fri, 21 Jan 2022 23:47:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 4/5] powerpc/vdso: Remove cvdso_call_time macro
Message-ID: <202201212332.oy8FMnno-lkp@intel.com>
References: <2ddc46d3a6d2996c56547039709e171b0ed2ec46.1642759506.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ddc46d3a6d2996c56547039709e171b0ed2ec46.1642759506.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc-vdso-augment-VDSO32-functions-to-support-64-bits-build/20220121-180748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220121/202201212332.oy8FMnno-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/09651dc41aab619a025925ace9f5b81e478e7334
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/powerpc-vdso-augment-VDSO32-functions-to-support-64-bits-build/20220121-180748
        git checkout 09651dc41aab619a025925ace9f5b81e478e7334
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/vdso/gettimeofday.S: Assembler messages:
>> arch/powerpc/kernel/vdso/gettimeofday.S:68: Error: unrecognized opcode: `cvdso_call_time'
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:71: arch/powerpc/kernel/vdso/gettimeofday-32.o] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:423: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +68 arch/powerpc/kernel/vdso/gettimeofday.S

a7f290dad32ee3 arch/powerpc/kernel/vdso32/gettimeofday.S Benjamin Herrenschmidt 2005-11-11  59  
a7f290dad32ee3 arch/powerpc/kernel/vdso32/gettimeofday.S Benjamin Herrenschmidt 2005-11-11  60  
fcb41a2030abe0 arch/powerpc/kernel/vdso32/gettimeofday.S Adhemerval Zanella     2013-04-22  61  /*
fcb41a2030abe0 arch/powerpc/kernel/vdso32/gettimeofday.S Adhemerval Zanella     2013-04-22  62   * Exact prototype of time()
fcb41a2030abe0 arch/powerpc/kernel/vdso32/gettimeofday.S Adhemerval Zanella     2013-04-22  63   *
fcb41a2030abe0 arch/powerpc/kernel/vdso32/gettimeofday.S Adhemerval Zanella     2013-04-22  64   * time_t time(time *t);
fcb41a2030abe0 arch/powerpc/kernel/vdso32/gettimeofday.S Adhemerval Zanella     2013-04-22  65   *
fcb41a2030abe0 arch/powerpc/kernel/vdso32/gettimeofday.S Adhemerval Zanella     2013-04-22  66   */
fcb41a2030abe0 arch/powerpc/kernel/vdso32/gettimeofday.S Adhemerval Zanella     2013-04-22  67  V_FUNCTION_BEGIN(__kernel_time)
ab037dd87a2f94 arch/powerpc/kernel/vdso32/gettimeofday.S Christophe Leroy       2020-11-27 @68  	cvdso_call_time __c_kernel_time
fcb41a2030abe0 arch/powerpc/kernel/vdso32/gettimeofday.S Adhemerval Zanella     2013-04-22  69  V_FUNCTION_END(__kernel_time)
08c18b63d9656e arch/powerpc/kernel/vdso32/gettimeofday.S Christophe Leroy       2021-03-09  70  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
