Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B79485116
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiAEKWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:22:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:29050 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235429AbiAEKWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641378166; x=1672914166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f2iFG3BqkYAnvmhxv+xouGNe19Jk1X/H4/C92rX/Skw=;
  b=GGB68A0fGcWPq8TBoxKpCd62N1NW86DwRxKqtyuRx46H2FNBgkEnqqT4
   XwFvtvPc2Dqod2ZRzTGab4vkYQNXZVLYbkFjagt63rGKjbRO6MOeEHEuI
   ie9aFAyP7muUQJXU1vmobVMYEe8jc0TNPRks0jBeRw/lT3XTZwYNTfUvk
   gTtkJgjU2NgBR8SoMOjLhVshTlQqXBHFK+OMNupYJHbnoBaVKi0ynpRuG
   OnOT3F99EBtL6ss05daZk0D98tnG4/IMWmtlTkm8W1PFGHkgM0r4JQt71
   21DtKICqfsGi4K+PNw0CH2i0J/1vG6hpeSOV4EOWSLcIa+Vf/n36h0KWS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="328757756"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="328757756"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 02:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="760754798"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jan 2022 02:22:36 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n53RD-000GVK-Rf; Wed, 05 Jan 2022 10:22:35 +0000
Date:   Wed, 5 Jan 2022 18:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     AliOS system security <alios_sys_security@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AliOS system security <alios_sys_security@linux.alibaba.com>
Subject: Re: [PATCH] arm64: fix build error when use rodata_enabled
Message-ID: <202201051817.4KPMZJag-lkp@intel.com>
References: <1641352075-25200-1-git-send-email-alios_sys_security@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641352075-25200-1-git-send-email-alios_sys_security@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AliOS,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/AliOS-system-security/arm64-fix-build-error-when-use-rodata_enabled/20220105-110838
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-s032-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051817.4KPMZJag-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/6af4245e93d33d4f4a79a560a707539be994f73e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review AliOS-system-security/arm64-fix-build-error-when-use-rodata_enabled/20220105-110838
        git checkout 6af4245e93d33d4f4a79a560a707539be994f73e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/mm/mmu.c: In function 'map_entry_trampoline':
>> arch/arm64/mm/mmu.c:627:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     627 |         phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
         |         ^~~~~~~~~~~


vim +627 arch/arm64/mm/mmu.c

28b066da69b937 Ard Biesheuvel        2017-03-09  618  
51a0048beb4496 Will Deacon           2017-11-14  619  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
51a0048beb4496 Will Deacon           2017-11-14  620  static int __init map_entry_trampoline(void)
51a0048beb4496 Will Deacon           2017-11-14  621  {
6af4245e93d33d AliOS system security 2022-01-05  622  	pgprot_t prot = PAGE_KERNEL_EXEC;
6af4245e93d33d AliOS system security 2022-01-05  623  #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
6af4245e93d33d AliOS system security 2022-01-05  624  	if (rodata_enabled)
6af4245e93d33d AliOS system security 2022-01-05  625  		prot = PAGE_KERNEL_ROX;
6af4245e93d33d AliOS system security 2022-01-05  626  #endif
51a0048beb4496 Will Deacon           2017-11-14 @627  	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
51a0048beb4496 Will Deacon           2017-11-14  628  
51a0048beb4496 Will Deacon           2017-11-14  629  	/* The trampoline is always mapped and can therefore be global */
51a0048beb4496 Will Deacon           2017-11-14  630  	pgprot_val(prot) &= ~PTE_NG;
51a0048beb4496 Will Deacon           2017-11-14  631  
51a0048beb4496 Will Deacon           2017-11-14  632  	/* Map only the text into the trampoline page table */
51a0048beb4496 Will Deacon           2017-11-14  633  	memset(tramp_pg_dir, 0, PGD_SIZE);
51a0048beb4496 Will Deacon           2017-11-14  634  	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
475ba3fc194b64 Will Deacon           2019-04-08  635  			     prot, __pgd_pgtable_alloc, 0);
51a0048beb4496 Will Deacon           2017-11-14  636  
6c27c4082f4f70 Will Deacon           2017-12-06  637  	/* Map both the text and data into the kernel page table */
51a0048beb4496 Will Deacon           2017-11-14  638  	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
6c27c4082f4f70 Will Deacon           2017-12-06  639  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
6c27c4082f4f70 Will Deacon           2017-12-06  640  		extern char __entry_tramp_data_start[];
6c27c4082f4f70 Will Deacon           2017-12-06  641  
6c27c4082f4f70 Will Deacon           2017-12-06  642  		__set_fixmap(FIX_ENTRY_TRAMP_DATA,
6c27c4082f4f70 Will Deacon           2017-12-06  643  			     __pa_symbol(__entry_tramp_data_start),
6c27c4082f4f70 Will Deacon           2017-12-06  644  			     PAGE_KERNEL_RO);
6c27c4082f4f70 Will Deacon           2017-12-06  645  	}
6c27c4082f4f70 Will Deacon           2017-12-06  646  
51a0048beb4496 Will Deacon           2017-11-14  647  	return 0;
51a0048beb4496 Will Deacon           2017-11-14  648  }
51a0048beb4496 Will Deacon           2017-11-14  649  core_initcall(map_entry_trampoline);
51a0048beb4496 Will Deacon           2017-11-14  650  #endif
51a0048beb4496 Will Deacon           2017-11-14  651  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
