Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028C3525979
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376379AbiEMBm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiEMBmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:42:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F056C0F1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652406144; x=1683942144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C9quc7HDpp8SxgNAR9F/otNx1bgmVczd4p2vzLfQVC8=;
  b=FOiKO78ZLBNC1+nAoQLxvFPs4jkXVFjdvkR1OiSlTyodMe1c68m4Omvc
   ZUBVSnrryveTTHkcxbaAkeKqq+PUimQ9HsXLHXgxTIVpJCr7YR5ert+FF
   vJKS7hDdZFDKV9QDG5jdHrSiX4DqsBK4ztO4tIxoJY9R8Q0CEihvJfYNE
   mqjLfwcwrRqWuoxUwxLXXAmKuWJtVMIb5mVw5GjRVBobih0X21ZEIppnz
   i3MqzxlITy97UkbCCyCoKZuydXEyJvwLguMQeTfqlaEPzePrndtkpncOD
   gzvH2/y65S+gOwlUXRvvcxnP8n1ENZYipMp4F6H0XfRAp+lskv6os5lgo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295443406"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="295443406"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="572772965"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2022 18:42:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npKJw-000L9z-H7;
        Fri, 13 May 2022 01:42:20 +0000
Date:   Fri, 13 May 2022 09:41:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yang Shi <shy828301@gmail.com>, willy@infradead.org,
        songmuchun@bytedance.com, akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, shy828301@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: pvmw: check possible huge PMD map by
 transhuge_vma_suitable()
Message-ID: <202205130928.ThdARQ6I-lkp@intel.com>
References: <20220512174551.81279-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512174551.81279-2-shy828301@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/mm-rmap-use-the-correct-parameter-name-for-DEFINE_PAGE_VMA_WALK/20220513-015301
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: mips-maltaup_defconfig (https://download.01.org/0day-ci/archive/20220513/202205130928.ThdARQ6I-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/66065a2fef73252d47341b46d9ea946b325da354
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yang-Shi/mm-rmap-use-the-correct-parameter-name-for-DEFINE_PAGE_VMA_WALK/20220513-015301
        git checkout 66065a2fef73252d47341b46d9ea946b325da354
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/page_vma_mapped.c:240:42: error: call to __compiletime_assert_345 declared with 'error' attribute: BUILD_BUG failed
                           unsigned long haddr = pvmw->address & HPAGE_PMD_MASK;
                                                                 ^
   include/linux/huge_mm.h:322:27: note: expanded from macro 'HPAGE_PMD_MASK'
   #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
                             ^
   include/linux/build_bug.h:59:21: note: expanded from macro 'BUILD_BUG'
   #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                       ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:19:1: note: expanded from here
   __compiletime_assert_345
   ^
   1 error generated.


vim +/error +240 mm/page_vma_mapped.c

   126	
   127	/**
   128	 * page_vma_mapped_walk - check if @pvmw->pfn is mapped in @pvmw->vma at
   129	 * @pvmw->address
   130	 * @pvmw: pointer to struct page_vma_mapped_walk. page, vma, address and flags
   131	 * must be set. pmd, pte and ptl must be NULL.
   132	 *
   133	 * Returns true if the page is mapped in the vma. @pvmw->pmd and @pvmw->pte point
   134	 * to relevant page table entries. @pvmw->ptl is locked. @pvmw->address is
   135	 * adjusted if needed (for PTE-mapped THPs).
   136	 *
   137	 * If @pvmw->pmd is set but @pvmw->pte is not, you have found PMD-mapped page
   138	 * (usually THP). For PTE-mapped THP, you should run page_vma_mapped_walk() in
   139	 * a loop to find all PTEs that map the THP.
   140	 *
   141	 * For HugeTLB pages, @pvmw->pte is set to the relevant page table entry
   142	 * regardless of which page table level the page is mapped at. @pvmw->pmd is
   143	 * NULL.
   144	 *
   145	 * Returns false if there are no more page table entries for the page in
   146	 * the vma. @pvmw->ptl is unlocked and @pvmw->pte is unmapped.
   147	 *
   148	 * If you need to stop the walk before page_vma_mapped_walk() returned false,
   149	 * use page_vma_mapped_walk_done(). It will do the housekeeping.
   150	 */
   151	bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
   152	{
   153		struct vm_area_struct *vma = pvmw->vma;
   154		struct mm_struct *mm = vma->vm_mm;
   155		unsigned long end;
   156		pgd_t *pgd;
   157		p4d_t *p4d;
   158		pud_t *pud;
   159		pmd_t pmde;
   160	
   161		/* The only possible pmd mapping has been handled on last iteration */
   162		if (pvmw->pmd && !pvmw->pte)
   163			return not_found(pvmw);
   164	
   165		if (unlikely(is_vm_hugetlb_page(vma))) {
   166			struct hstate *hstate = hstate_vma(vma);
   167			unsigned long size = huge_page_size(hstate);
   168			/* The only possible mapping was handled on last iteration */
   169			if (pvmw->pte)
   170				return not_found(pvmw);
   171	
   172			/* when pud is not present, pte will be NULL */
   173			pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
   174			if (!pvmw->pte)
   175				return false;
   176	
   177			pvmw->ptl = huge_pte_lockptr(hstate, mm, pvmw->pte);
   178			spin_lock(pvmw->ptl);
   179			if (!check_pte(pvmw))
   180				return not_found(pvmw);
   181			return true;
   182		}
   183	
   184		end = vma_address_end(pvmw);
   185		if (pvmw->pte)
   186			goto next_pte;
   187	restart:
   188		do {
   189			pgd = pgd_offset(mm, pvmw->address);
   190			if (!pgd_present(*pgd)) {
   191				step_forward(pvmw, PGDIR_SIZE);
   192				continue;
   193			}
   194			p4d = p4d_offset(pgd, pvmw->address);
   195			if (!p4d_present(*p4d)) {
   196				step_forward(pvmw, P4D_SIZE);
   197				continue;
   198			}
   199			pud = pud_offset(p4d, pvmw->address);
   200			if (!pud_present(*pud)) {
   201				step_forward(pvmw, PUD_SIZE);
   202				continue;
   203			}
   204	
   205			pvmw->pmd = pmd_offset(pud, pvmw->address);
   206			/*
   207			 * Make sure the pmd value isn't cached in a register by the
   208			 * compiler and used as a stale value after we've observed a
   209			 * subsequent update.
   210			 */
   211			pmde = READ_ONCE(*pvmw->pmd);
   212	
   213			if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
   214			    (pmd_present(pmde) && pmd_devmap(pmde))) {
   215				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
   216				pmde = *pvmw->pmd;
   217				if (!pmd_present(pmde)) {
   218					swp_entry_t entry;
   219	
   220					if (!thp_migration_supported() ||
   221					    !(pvmw->flags & PVMW_MIGRATION))
   222						return not_found(pvmw);
   223					entry = pmd_to_swp_entry(pmde);
   224					if (!is_migration_entry(entry) ||
   225					    !check_pmd(swp_offset(entry), pvmw))
   226						return not_found(pvmw);
   227					return true;
   228				}
   229				if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
   230					if (pvmw->flags & PVMW_MIGRATION)
   231						return not_found(pvmw);
   232					if (!check_pmd(pmd_pfn(pmde), pvmw))
   233						return not_found(pvmw);
   234					return true;
   235				}
   236				/* THP pmd was split under us: handle on pte level */
   237				spin_unlock(pvmw->ptl);
   238				pvmw->ptl = NULL;
   239			} else if (!pmd_present(pmde)) {
 > 240				unsigned long haddr = pvmw->address & HPAGE_PMD_MASK;
   241				/*
   242				 * If PVMW_SYNC, take and drop THP pmd lock so that we
   243				 * cannot return prematurely, while zap_huge_pmd() has
   244				 * cleared *pmd but not decremented compound_mapcount().
   245				 */
   246				if ((pvmw->flags & PVMW_SYNC) &&
   247				    transhuge_vma_suitable(vma, haddr) &&
   248				    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
   249					spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
   250	
   251					spin_unlock(ptl);
   252				}
   253				step_forward(pvmw, PMD_SIZE);
   254				continue;
   255			}
   256			if (!map_pte(pvmw))
   257				goto next_pte;
   258	this_pte:
   259			if (check_pte(pvmw))
   260				return true;
   261	next_pte:
   262			do {
   263				pvmw->address += PAGE_SIZE;
   264				if (pvmw->address >= end)
   265					return not_found(pvmw);
   266				/* Did we cross page table boundary? */
   267				if ((pvmw->address & (PMD_SIZE - PAGE_SIZE)) == 0) {
   268					if (pvmw->ptl) {
   269						spin_unlock(pvmw->ptl);
   270						pvmw->ptl = NULL;
   271					}
   272					pte_unmap(pvmw->pte);
   273					pvmw->pte = NULL;
   274					goto restart;
   275				}
   276				pvmw->pte++;
   277				if ((pvmw->flags & PVMW_SYNC) && !pvmw->ptl) {
   278					pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
   279					spin_lock(pvmw->ptl);
   280				}
   281			} while (pte_none(*pvmw->pte));
   282	
   283			if (!pvmw->ptl) {
   284				pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
   285				spin_lock(pvmw->ptl);
   286			}
   287			goto this_pte;
   288		} while (pvmw->address < end);
   289	
   290		return false;
   291	}
   292	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
