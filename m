Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221E59A354
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349976AbiHSSBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350512AbiHSSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:00:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF31EC6F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660931228; x=1692467228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FOynmcElN88ZHiDBBPM4LouI5ZrjwbxW2G62gb61PWQ=;
  b=ASQpoXFcNDreqcDf1F3qZ6rsPXUYxeladTM04ziV+sxcgIku7DjYQr8e
   gDATPLpRW+lR317tTAmgxLcNwVQn+neonB5Cy9Dtxdw36L/bzTNrY9E83
   olw82ScN+Zj/2eU4J85VV9SgfmP4uRf7r5DcmDElIBT8EwcwZdoH+jcCC
   KW5GwhkYcLeX55x+iRDdJRz7+RHoKqVw5p6BZ21MG0BAF6snNOLXR9mNK
   CqdysmgumhhIJLaXkizri43+FvWOnMkw3lfu6RGJ/cy1NDol0aMqslEp3
   ht59FrGw8sVhmYN5aOAk0nI9Ve5RSe1Sd9t9yPv/xn0YawAuhkFtCZTAr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="293064895"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="293064895"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 10:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="936300666"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2022 10:47:06 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP65J-0001gL-2b;
        Fri, 19 Aug 2022 17:47:05 +0000
Date:   Sat, 20 Aug 2022 01:46:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/gup: fix races when looking up a CONT-PTE size
 hugetlb page
Message-ID: <202208200109.XEXN0wPy-lkp@intel.com>
References: <0f3df6604059011bf78a286c2cf5da5c4b41ccb1.1660902741.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3df6604059011bf78a286c2cf5da5c4b41ccb1.1660902741.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.0-rc1 next-20220819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/Fix-some-issues-when-looking-up-hugetlb-page/20220819-182017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: riscv-randconfig-r042-20220819 (https://download.01.org/0day-ci/archive/20220820/202208200109.XEXN0wPy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/c0add09e9de4b39c58633c89ea25ba10ed12d134
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baolin-Wang/Fix-some-issues-when-looking-up-hugetlb-page/20220819-182017
        git checkout c0add09e9de4b39c58633c89ea25ba10ed12d134
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/gup.c:551:9: error: implicit declaration of function 'huge_ptep_get' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   pte = huge_ptep_get(ptep);
                         ^
>> mm/gup.c:551:7: error: assigning to 'pte_t' from incompatible type 'int'
                   pte = huge_ptep_get(ptep);
                       ^ ~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/huge_ptep_get +551 mm/gup.c

   518	
   519	static struct page *follow_page_pte(struct vm_area_struct *vma,
   520			unsigned long address, pmd_t *pmd, unsigned int flags,
   521			struct dev_pagemap **pgmap)
   522	{
   523		struct mm_struct *mm = vma->vm_mm;
   524		struct page *page;
   525		spinlock_t *ptl;
   526		pte_t *ptep, pte;
   527		int ret;
   528	
   529		/* FOLL_GET and FOLL_PIN are mutually exclusive. */
   530		if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
   531				 (FOLL_PIN | FOLL_GET)))
   532			return ERR_PTR(-EINVAL);
   533	retry:
   534		if (unlikely(pmd_bad(*pmd)))
   535			return no_page_table(vma, flags);
   536	
   537		/*
   538		 * Considering PTE level hugetlb, like continuous-PTE hugetlb on
   539		 * ARM64 architecture.
   540		 */
   541		if (is_vm_hugetlb_page(vma)) {
   542			struct hstate *hstate = hstate_vma(vma);
   543			unsigned long size = huge_page_size(hstate);
   544	
   545			ptep = huge_pte_offset(mm, address, size);
   546			if (!ptep)
   547				return no_page_table(vma, flags);
   548	
   549			ptl = huge_pte_lockptr(hstate, mm, ptep);
   550			spin_lock(ptl);
 > 551			pte = huge_ptep_get(ptep);
   552		} else {
   553			ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
   554			pte = *ptep;
   555		}
   556	
   557		if (!pte_present(pte)) {
   558			swp_entry_t entry;
   559			/*
   560			 * KSM's break_ksm() relies upon recognizing a ksm page
   561			 * even while it is being migrated, so for that case we
   562			 * need migration_entry_wait().
   563			 */
   564			if (likely(!(flags & FOLL_MIGRATION)))
   565				goto no_page;
   566			if (pte_none(pte))
   567				goto no_page;
   568			entry = pte_to_swp_entry(pte);
   569			if (!is_migration_entry(entry))
   570				goto no_page;
   571			pte_unmap_unlock(ptep, ptl);
   572			migration_entry_wait(mm, pmd, address);
   573			goto retry;
   574		}
   575		if ((flags & FOLL_NUMA) && pte_protnone(pte))
   576			goto no_page;
   577	
   578		page = vm_normal_page(vma, address, pte);
   579	
   580		/*
   581		 * We only care about anon pages in can_follow_write_pte() and don't
   582		 * have to worry about pte_devmap() because they are never anon.
   583		 */
   584		if ((flags & FOLL_WRITE) &&
   585		    !can_follow_write_pte(pte, page, vma, flags)) {
   586			page = NULL;
   587			goto out;
   588		}
   589	
   590		if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
   591			/*
   592			 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
   593			 * case since they are only valid while holding the pgmap
   594			 * reference.
   595			 */
   596			*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
   597			if (*pgmap)
   598				page = pte_page(pte);
   599			else
   600				goto no_page;
   601		} else if (unlikely(!page)) {
   602			if (flags & FOLL_DUMP) {
   603				/* Avoid special (like zero) pages in core dumps */
   604				page = ERR_PTR(-EFAULT);
   605				goto out;
   606			}
   607	
   608			if (is_zero_pfn(pte_pfn(pte))) {
   609				page = pte_page(pte);
   610			} else {
   611				ret = follow_pfn_pte(vma, address, ptep, flags);
   612				page = ERR_PTR(ret);
   613				goto out;
   614			}
   615		}
   616	
   617		if (!pte_write(pte) && gup_must_unshare(flags, page)) {
   618			page = ERR_PTR(-EMLINK);
   619			goto out;
   620		}
   621	
   622		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
   623			       !PageAnonExclusive(page), page);
   624	
   625		/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
   626		if (unlikely(!try_grab_page(page, flags))) {
   627			page = ERR_PTR(-ENOMEM);
   628			goto out;
   629		}
   630		/*
   631		 * We need to make the page accessible if and only if we are going
   632		 * to access its content (the FOLL_PIN case).  Please see
   633		 * Documentation/core-api/pin_user_pages.rst for details.
   634		 */
   635		if (flags & FOLL_PIN) {
   636			ret = arch_make_page_accessible(page);
   637			if (ret) {
   638				unpin_user_page(page);
   639				page = ERR_PTR(ret);
   640				goto out;
   641			}
   642		}
   643		if (flags & FOLL_TOUCH) {
   644			if ((flags & FOLL_WRITE) &&
   645			    !pte_dirty(pte) && !PageDirty(page))
   646				set_page_dirty(page);
   647			/*
   648			 * pte_mkyoung() would be more correct here, but atomic care
   649			 * is needed to avoid losing the dirty bit: it is easier to use
   650			 * mark_page_accessed().
   651			 */
   652			mark_page_accessed(page);
   653		}
   654	out:
   655		pte_unmap_unlock(ptep, ptl);
   656		return page;
   657	no_page:
   658		pte_unmap_unlock(ptep, ptl);
   659		if (!pte_none(pte))
   660			return NULL;
   661		return no_page_table(vma, flags);
   662	}
   663	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
