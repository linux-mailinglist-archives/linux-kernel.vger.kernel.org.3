Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6A51E6A4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384739AbiEGLd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 07:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiEGLd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 07:33:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB74992A
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651922981; x=1683458981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gZs87zfasrjwwNRalafBnDgJKHoPJaGErNWYZAsFcEA=;
  b=X8ZZ8VuBfnYRiJhIOGpgQGr3ZBTSWA4F3Uh4bwmBbUt3G1CVhztgbSA1
   aqWTKYHSfTuV6k9XMipa0WyPBYWPUMnGQYKQbOlF4Zu867tYVnnifyn/G
   G555iVEcC7Ev+1TJgyXxFt93edMU2GvpwrKTEUNhkcdJ/bQp8tDw7Df1F
   mUMg43KcJsrM3t3LRUHAUaqdV1okaZ1IokuGEtS0J9YvxaPGs5NRutdW6
   JVmq8K2+qRl4beHAnjewQ7kg6KpCm8b+/M9tKtC1EbmtBahMUzXnx2Aed
   5JOEQygUkd5Pdb9hsq7R8A7DKgn2ktwa9HOTF+P02IXHHPAyn+E4NPg0v
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="266289024"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="266289024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 04:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="709846771"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2022 04:29:38 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnId0-000EVv-7P;
        Sat, 07 May 2022 11:29:38 +0000
Date:   Sat, 7 May 2022 19:29:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     kbuild-all@lists.01.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 21/25] powerpc/ftrace: Don't use
 copy_from_kernel_nofault() in module_trampoline_target()
Message-ID: <202205071900.opHsWE8v-lkp@intel.com>
References: <921e8d60c847d42f7309feae1936fa0117b7f0d1.1651905939.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921e8d60c847d42f7309feae1936fa0117b7f0d1.1651905939.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/topic/ppc-kvm v5.18-rc5 next-20220506]
[cannot apply to rostedt-trace/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/powerpc-ftrace-optimisation-and-cleanup-and-more-v2/20220507-145034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-randconfig-s031-20220506 (https://download.01.org/0day-ci/archive/20220507/202205071900.opHsWE8v-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/1c6a385ed330a6ed959cad02f89306fb84e4334c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christophe-Leroy/powerpc-ftrace-optimisation-and-cleanup-and-more-v2/20220507-145034
        git checkout 1c6a385ed330a6ed959cad02f89306fb84e4334c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kernel/module_32.c:298:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected struct ppc_inst_t [usertype] *inst @@     got unsigned int * @@
   arch/powerpc/kernel/module_32.c:298:43: sparse:     expected struct ppc_inst_t [usertype] *inst
   arch/powerpc/kernel/module_32.c:298:43: sparse:     got unsigned int *
   arch/powerpc/kernel/module_32.c:300:49: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected struct ppc_inst_t [usertype] *inst @@     got unsigned int * @@
   arch/powerpc/kernel/module_32.c:300:49: sparse:     expected struct ppc_inst_t [usertype] *inst
   arch/powerpc/kernel/module_32.c:300:49: sparse:     got unsigned int *
   arch/powerpc/kernel/module_32.c:302:49: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected struct ppc_inst_t [usertype] *inst @@     got unsigned int * @@
   arch/powerpc/kernel/module_32.c:302:49: sparse:     expected struct ppc_inst_t [usertype] *inst
   arch/powerpc/kernel/module_32.c:302:49: sparse:     got unsigned int *
   arch/powerpc/kernel/module_32.c:304:49: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected struct ppc_inst_t [usertype] *inst @@     got unsigned int * @@
   arch/powerpc/kernel/module_32.c:304:49: sparse:     expected struct ppc_inst_t [usertype] *inst
   arch/powerpc/kernel/module_32.c:304:49: sparse:     got unsigned int *

vim +298 arch/powerpc/kernel/module_32.c

   290	
   291	#ifdef CONFIG_DYNAMIC_FTRACE
   292	notrace int module_trampoline_target(struct module *mod, unsigned long addr,
   293					     unsigned long *target)
   294	{
   295		unsigned int jmp[4];
   296	
   297		/* Find where the trampoline jumps to */
 > 298		if (copy_inst_from_kernel_nofault(jmp, (void *)addr))
   299			return -EFAULT;
   300		if (__copy_inst_from_kernel_nofault(jmp + 1, (void *)addr + 4))
   301			return -EFAULT;
   302		if (__copy_inst_from_kernel_nofault(jmp + 2, (void *)addr + 8))
   303			return -EFAULT;
   304		if (__copy_inst_from_kernel_nofault(jmp + 3, (void *)addr + 12))
   305			return -EFAULT;
   306	
   307		/* verify that this is what we expect it to be */
   308		if ((jmp[0] & 0xffff0000) != PPC_RAW_LIS(_R12, 0) ||
   309		    (jmp[1] & 0xffff0000) != PPC_RAW_ADDI(_R12, _R12, 0) ||
   310		    jmp[2] != PPC_RAW_MTCTR(_R12) ||
   311		    jmp[3] != PPC_RAW_BCTR())
   312			return -EINVAL;
   313	
   314		addr = (jmp[1] & 0xffff) | ((jmp[0] & 0xffff) << 16);
   315		if (addr & 0x8000)
   316			addr -= 0x10000;
   317	
   318		*target = addr;
   319	
   320		return 0;
   321	}
   322	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
