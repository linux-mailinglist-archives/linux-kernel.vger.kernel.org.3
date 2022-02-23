Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED64C1325
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiBWMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiBWMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:49:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814EBA66EF;
        Wed, 23 Feb 2022 04:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645620513; x=1677156513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yu6PwEdVjrJZ74LB1ocxQTTeqK53d5t1O9sOf+Ll29Y=;
  b=MhgIR9sXaOKjWi1jjloPXeBhjjBvJlW7zvllojKpctH/g5x2/ssb5i+S
   tJZ472+pQ394dgzK6pLAYvIIlKFvRBMq31nN7A6jSBT8MduawTtwlVeoB
   /ZCtWUllv86bPsmafy5o1dBAxR/cqYBFsQssxx53s2qQKHt60pDEUckXF
   yGDtLubR2C5j+7MWT3Iva0WCrkrYD5kw4VRjoJ3W6mDXENYX4LQSmDeyg
   9H1Zp2ogNPqXbxtJjo82lw77bpFx7qeX1gTUAQXHgTZ7oQPbE29fyzuOY
   o/wO2feRVBxbf6fHe+ljlECJRJEW9wQN1p2SgrrhJmDymPdQpJJI+2/+o
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252146576"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="252146576"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:48:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="532669216"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 04:48:30 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMr4I-0001Pv-4o; Wed, 23 Feb 2022 12:48:30 +0000
Date:   Wed, 23 Feb 2022 20:47:53 +0800
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
Message-ID: <202202231935.aUY0YIgf-lkp@intel.com>
References: <20220223023245.uicyzttakfq3k5zf@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223023245.uicyzttakfq3k5zf@revolver>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: arm64-randconfig-r033-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231935.aUY0YIgf-lkp@intel.com/config)
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
   arch/arm64/kernel/elfcore.c:68:9: error: implicit declaration of function 'VMA_ITERATOR' [-Werror=implicit-function-declaration]
      68 |         VMA_ITERATOR(vmi, current->mm, 0);
         |         ^~~~~~~~~~~~
   arch/arm64/kernel/elfcore.c:68:22: error: 'vmi' undeclared (first use in this function); did you mean 'vma'?
      68 |         VMA_ITERATOR(vmi, current->mm, 0);
         |                      ^~~
         |                      vma
   arch/arm64/kernel/elfcore.c:68:22: note: each undeclared identifier is reported only once for each function it appears in
   arch/arm64/kernel/elfcore.c:13:17: error: implicit declaration of function 'for_each_vma'; did you mean 'for_each_cpu'? [-Werror=implicit-function-declaration]
      13 |                 for_each_vma(vmi, vma)                                  \
         |                 ^~~~~~~~~~~~
   arch/arm64/kernel/elfcore.c:70:9: note: in expansion of macro 'for_each_mte_vma'
      70 |         for_each_mte_vma(vmi, vma)
         |         ^~~~~~~~~~~~~~~~
>> arch/arm64/kernel/elfcore.c:14:25: error: expected ';' before 'if'
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
>> arch/arm64/kernel/elfcore.c:14:25: error: expected ';' before 'if'
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
>> arch/arm64/kernel/elfcore.c:14:25: error: expected ';' before 'if'
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
>> arch/arm64/kernel/elfcore.c:14:25: error: expected ';' before 'if'
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


vim +14 arch/arm64/kernel/elfcore.c

6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  10  
e416e64fe4e04c Liam Howlett    2022-02-23  11  #define for_each_mte_vma(vmi, vma)					\
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  12  	if (system_supports_mte())					\
e416e64fe4e04c Liam Howlett    2022-02-23  13  		for_each_vma(vmi, vma)					\
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31 @14  			if (vma->vm_flags & VM_MTE)
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  15  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  16  static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  17  {
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  18  	if (vma->vm_flags & VM_DONTDUMP)
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  19  		return 0;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  20  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  21  	return vma_pages(vma) * MTE_PAGE_TAG_STORAGE;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  22  }
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  23  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  24  /* Derived from dump_user_range(); start/end must be page-aligned */
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  25  static int mte_dump_tag_range(struct coredump_params *cprm,
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  26  			      unsigned long start, unsigned long end)
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  27  {
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  28  	unsigned long addr;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  29  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  30  	for (addr = start; addr < end; addr += PAGE_SIZE) {
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  31  		char tags[MTE_PAGE_TAG_STORAGE];
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  32  		struct page *page = get_dump_page(addr);
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  33  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  34  		/*
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  35  		 * get_dump_page() returns NULL when encountering an empty
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  36  		 * page table entry that would otherwise have been filled with
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  37  		 * the zero page. Skip the equivalent tag dump which would
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  38  		 * have been all zeros.
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  39  		 */
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  40  		if (!page) {
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  41  			dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  42  			continue;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  43  		}
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  44  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  45  		/*
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  46  		 * Pages mapped in user space as !pte_access_permitted() (e.g.
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  47  		 * PROT_EXEC only) may not have the PG_mte_tagged flag set.
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  48  		 */
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  49  		if (!test_bit(PG_mte_tagged, &page->flags)) {
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  50  			put_page(page);
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  51  			dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  52  			continue;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  53  		}
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  54  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  55  		mte_save_page_tags(page_address(page), tags);
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  56  		put_page(page);
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  57  		if (!dump_emit(cprm, tags, MTE_PAGE_TAG_STORAGE))
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  58  			return 0;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  59  	}
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  60  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  61  	return 1;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  62  }
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  63  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  64  Elf_Half elf_core_extra_phdrs(void)
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  65  {
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  66  	struct vm_area_struct *vma;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  67  	int vma_count = 0;
e416e64fe4e04c Liam Howlett    2022-02-23 @68  	VMA_ITERATOR(vmi, current->mm, 0);
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  69  
e416e64fe4e04c Liam Howlett    2022-02-23  70  	for_each_mte_vma(vmi, vma)
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  71  		vma_count++;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  72  
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  73  	return vma_count;
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  74  }
6dd8b1a0b6cb3e Catalin Marinas 2022-01-31  75  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
