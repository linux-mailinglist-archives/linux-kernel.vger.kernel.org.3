Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4233E49BDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiAYVa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:30:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:37737 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbiAYVa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643146227; x=1674682227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XowxNXgoa7qTiYGMsiGyGW3OfOAW78GHgwKP30yaINQ=;
  b=KqaHwA1wRe/jZEePdWYbQBzM0U4pW7/HUR/U1M+ThcBF/hXc/vggiY3F
   gIbsHPfPRFcTSnA5nER/5VBCGurNycPgeu+uTZvXel/+sI9YwYhczsDPW
   X3FtcpSH95nZNOL4Kp8wyf5DvtRCAb3ta5d1h6J7qo5Gjkz6nCe3QQmNx
   3UIWRr1xWxzmE6jDgU98GevYIgTJWygOWmGdzg8q1ltbfjXN1Hg4+wmN0
   DxvkV79fIzSW0362kOWYjpkjGkt5MtrdDsRxLhrvM0KxO7XLX7g+bz7VB
   3WqGURCPsNP0JrQ1PS+rZD2ovGVJlrK8U0s963HW/LsqQ1kOjpy4aC1Kw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="229995213"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="229995213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 13:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="617760902"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2022 13:30:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCTOP-000KS4-P7; Tue, 25 Jan 2022 21:30:21 +0000
Date:   Wed, 26 Jan 2022 05:30:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: convert pgtable_l4_enabled to static key
Message-ID: <202201260555.SwYGWcoq-lkp@intel.com>
References: <20220125165036.987-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125165036.987-4-jszhang@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/unified-way-to-use-static-key-and-optimize-pgtable_l4_enabled/20220126-010230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a08b41ab9e2e468647f78eb17c28e29b93006394
config: riscv-randconfig-r012-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260555.SwYGWcoq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/6822380e5bcac6d3edfa5d0723d829db8ec28405
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jisheng-Zhang/unified-way-to-use-static-key-and-optimize-pgtable_l4_enabled/20220126-010230
        git checkout 6822380e5bcac6d3edfa5d0723d829db8ec28405
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/mm/init.c:691:6: error: implicit declaration of function 'system_supports_sv48' [-Werror,-Wimplicit-function-declaration]
           if (system_supports_sv48()) {
               ^
   arch/riscv/mm/init.c:721:13: warning: no previous prototype for function 'pt_ops_set_early' [-Wmissing-prototypes]
   void __init pt_ops_set_early(void)
               ^
   arch/riscv/mm/init.c:721:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_early(void)
   ^
   static 
   arch/riscv/mm/init.c:741:13: warning: no previous prototype for function 'pt_ops_set_fixmap' [-Wmissing-prototypes]
   void __init pt_ops_set_fixmap(void)
               ^
   arch/riscv/mm/init.c:741:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_fixmap(void)
   ^
   static 
   arch/riscv/mm/init.c:757:13: warning: no previous prototype for function 'pt_ops_set_late' [-Wmissing-prototypes]
   void __init pt_ops_set_late(void)
               ^
   arch/riscv/mm/init.c:757:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_late(void)
   ^
   static 
   3 warnings and 1 error generated.


vim +/system_supports_sv48 +691 arch/riscv/mm/init.c

   675	
   676	/*
   677	 * Setup a 4MB mapping that encompasses the device tree: for 64-bit kernel,
   678	 * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
   679	 * entry.
   680	 */
   681	static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
   682	{
   683	#ifndef CONFIG_BUILTIN_DTB
   684		uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
   685	
   686		create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
   687				   IS_ENABLED(CONFIG_64BIT) ? early_dtb_pgd_next : pa,
   688				   PGDIR_SIZE,
   689				   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
   690	
 > 691		if (system_supports_sv48()) {
   692			create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
   693					   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
   694		}
   695	
   696		if (IS_ENABLED(CONFIG_64BIT)) {
   697			create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
   698					   pa, PMD_SIZE, PAGE_KERNEL);
   699			create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
   700					   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
   701		}
   702	
   703		dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
   704	#else
   705		/*
   706		 * For 64-bit kernel, __va can't be used since it would return a linear
   707		 * mapping address whereas dtb_early_va will be used before
   708		 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
   709		 * kernel is mapped in the linear mapping, that makes no difference.
   710		 */
   711		dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
   712	#endif
   713	
   714		dtb_early_pa = dtb_pa;
   715	}
   716	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
