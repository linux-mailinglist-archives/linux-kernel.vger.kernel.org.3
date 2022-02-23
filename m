Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80374C139A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiBWNKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBWNKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:10:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9906D939B2;
        Wed, 23 Feb 2022 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645621774; x=1677157774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AwjJpWYCTPQeVuVVgEdKhStdiV5l6kXXN/ua0XFu1JM=;
  b=eXJ4XVjO/NPd+2c0wuMCElSZUXq9Na1p1/xY87VvStwMXN3PoEL55Q0E
   v5q8iF6IJCvnUSBghEol71Q6D5zmTQJdGZxhsdRblzFVZ/NLqHeIDpRbi
   tf9THrHr0QhsbHaKKNY43gOTTjbANqjlXkPWX9oFla6RoDkZGbcC3hKSC
   RMoJvpQ3TX97D9g/qunzPES1amRCh03YFQdM6jgamUg4JM0XOIKSF7NkI
   4lb1GM7G6VVvl4L/TqUQJ5izl7dq0KZbx9jieeA3qFPZWEtioNX7Xf6/4
   Udy6S61/XzT+laa9w0t/FD9k6kIMyBNkz+WiZAJof4rZMgGcZrvKrpS/r
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231931111"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="231931111"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 05:09:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="781925466"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2022 05:09:31 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMrOc-0001T2-Tx; Wed, 23 Feb 2022 13:09:30 +0000
Date:   Wed, 23 Feb 2022 21:08:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Message-ID: <202202232114.VBMtKcTj-lkp@intel.com>
References: <20220223023245.uicyzttakfq3k5zf@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223023245.uicyzttakfq3k5zf@revolver>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on next-20220222]
[cannot apply to linux/master linus/master v5.17-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Liam-Howlett/arm64-Change-elfcore-for_each_mte_vma-to-use-VMA-iterator/20220223-104149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-p001-20220221 (https://download.01.org/0day-ci/archive/20220223/202202232114.VBMtKcTj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e416e64fe4e04c43daa48131e564c9f2f64ec333
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Liam-Howlett/arm64-Change-elfcore-for_each_mte_vma-to-use-VMA-iterator/20220223-104149
        git checkout e416e64fe4e04c43daa48131e564c9f2f64ec333
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_phdrs':
>> arch/arm64/kernel/elfcore.c:68:9: error: implicit declaration of function 'VMA_ITERATOR' [-Werror=implicit-function-declaration]
      68 |         VMA_ITERATOR(vmi, current->mm, 0);
         |         ^~~~~~~~~~~~
>> arch/arm64/kernel/elfcore.c:68:22: error: 'vmi' undeclared (first use in this function); did you mean 'vma'?
      68 |         VMA_ITERATOR(vmi, current->mm, 0);
         |                      ^~~
         |                      vma
   arch/arm64/kernel/elfcore.c:68:22: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm64/kernel/elfcore.c:13:17: error: implicit declaration of function 'for_each_vma'; did you mean 'for_each_cpu'? [-Werror=implicit-function-declaration]
      13 |                 for_each_vma(vmi, vma)                                  \
         |                 ^~~~~~~~~~~~
   arch/arm64/kernel/elfcore.c:70:9: note: in expansion of macro 'for_each_mte_vma'
      70 |         for_each_mte_vma(vmi, vma)
         |         ^~~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/coredump.h:6,
                    from arch/arm64/kernel/elfcore.c:3:
>> include/linux/compiler.h:56:23: error: expected ';' before 'if'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^~
   arch/arm64/kernel/elfcore.c:14:25: note: in expansion of macro 'if'
      14 |                         if (vma->vm_flags & VM_MTE)
         |                         ^~
   arch/arm64/kernel/elfcore.c:70:9: note: in expansion of macro 'for_each_mte_vma'
      70 |         for_each_mte_vma(vmi, vma)
         |         ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_phdrs':
   arch/arm64/kernel/elfcore.c:79:22: error: 'vmi' undeclared (first use in this function); did you mean 'vma'?
      79 |         VMA_ITERATOR(vmi, current->mm, 0);
         |                      ^~~
         |                      vma
   In file included from include/asm-generic/bug.h:5,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/coredump.h:6,
                    from arch/arm64/kernel/elfcore.c:3:
>> include/linux/compiler.h:56:23: error: expected ';' before 'if'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^~
   arch/arm64/kernel/elfcore.c:14:25: note: in expansion of macro 'if'
      14 |                         if (vma->vm_flags & VM_MTE)
         |                         ^~
   arch/arm64/kernel/elfcore.c:81:9: note: in expansion of macro 'for_each_mte_vma'
      81 |         for_each_mte_vma(vmi, vma) {
         |         ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_data_size':
   arch/arm64/kernel/elfcore.c:105:22: error: 'vmi' undeclared (first use in this function); did you mean 'vma'?
     105 |         VMA_ITERATOR(vmi, current->mm, 0);
         |                      ^~~
         |                      vma
   In file included from include/asm-generic/bug.h:5,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/coredump.h:6,
                    from arch/arm64/kernel/elfcore.c:3:
>> include/linux/compiler.h:56:23: error: expected ';' before 'if'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^~
   arch/arm64/kernel/elfcore.c:14:25: note: in expansion of macro 'if'
      14 |                         if (vma->vm_flags & VM_MTE)
         |                         ^~
   arch/arm64/kernel/elfcore.c:107:9: note: in expansion of macro 'for_each_mte_vma'
     107 |         for_each_mte_vma(vmi, vma)
         |         ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_data':
   arch/arm64/kernel/elfcore.c:116:22: error: 'vmi' undeclared (first use in this function); did you mean 'vma'?
     116 |         VMA_ITERATOR(vmi, current->mm, 0);
         |                      ^~~
         |                      vma
   In file included from include/asm-generic/bug.h:5,
                    from arch/arm64/include/asm/bug.h:26,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from include/linux/coredump.h:6,
                    from arch/arm64/kernel/elfcore.c:3:
>> include/linux/compiler.h:56:23: error: expected ';' before 'if'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^~
   arch/arm64/kernel/elfcore.c:14:25: note: in expansion of macro 'if'
      14 |                         if (vma->vm_flags & VM_MTE)
         |                         ^~
   arch/arm64/kernel/elfcore.c:118:9: note: in expansion of macro 'for_each_mte_vma'
     118 |         for_each_mte_vma(vmi, vma) {
         |         ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_phdrs':
   arch/arm64/kernel/elfcore.c:99:1: error: control reaches end of non-void function [-Werror=return-type]
      99 | }
         | ^
   arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_data':
   arch/arm64/kernel/elfcore.c:127:1: error: control reaches end of non-void function [-Werror=return-type]
     127 | }
         | ^
   At top level:
   arch/arm64/kernel/elfcore.c:25:12: warning: 'mte_dump_tag_range' defined but not used [-Wunused-function]
      25 | static int mte_dump_tag_range(struct coredump_params *cprm,
         |            ^~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/elfcore.c:16:22: warning: 'mte_vma_tag_dump_size' defined but not used [-Wunused-function]
      16 | static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
         |                      ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/VMA_ITERATOR +68 arch/arm64/kernel/elfcore.c

    10	
    11	#define for_each_mte_vma(vmi, vma)					\
    12		if (system_supports_mte())					\
  > 13			for_each_vma(vmi, vma)					\
    14				if (vma->vm_flags & VM_MTE)
    15	
    16	static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
    17	{
    18		if (vma->vm_flags & VM_DONTDUMP)
    19			return 0;
    20	
    21		return vma_pages(vma) * MTE_PAGE_TAG_STORAGE;
    22	}
    23	
    24	/* Derived from dump_user_range(); start/end must be page-aligned */
    25	static int mte_dump_tag_range(struct coredump_params *cprm,
    26				      unsigned long start, unsigned long end)
    27	{
    28		unsigned long addr;
    29	
    30		for (addr = start; addr < end; addr += PAGE_SIZE) {
    31			char tags[MTE_PAGE_TAG_STORAGE];
    32			struct page *page = get_dump_page(addr);
    33	
    34			/*
    35			 * get_dump_page() returns NULL when encountering an empty
    36			 * page table entry that would otherwise have been filled with
    37			 * the zero page. Skip the equivalent tag dump which would
    38			 * have been all zeros.
    39			 */
    40			if (!page) {
    41				dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
    42				continue;
    43			}
    44	
    45			/*
    46			 * Pages mapped in user space as !pte_access_permitted() (e.g.
    47			 * PROT_EXEC only) may not have the PG_mte_tagged flag set.
    48			 */
    49			if (!test_bit(PG_mte_tagged, &page->flags)) {
    50				put_page(page);
    51				dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
    52				continue;
    53			}
    54	
    55			mte_save_page_tags(page_address(page), tags);
    56			put_page(page);
    57			if (!dump_emit(cprm, tags, MTE_PAGE_TAG_STORAGE))
    58				return 0;
    59		}
    60	
    61		return 1;
    62	}
    63	
    64	Elf_Half elf_core_extra_phdrs(void)
    65	{
    66		struct vm_area_struct *vma;
    67		int vma_count = 0;
  > 68		VMA_ITERATOR(vmi, current->mm, 0);
    69	
    70		for_each_mte_vma(vmi, vma)
    71			vma_count++;
    72	
    73		return vma_count;
    74	}
    75	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
