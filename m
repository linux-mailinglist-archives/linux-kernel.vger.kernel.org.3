Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85759A40B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350225AbiHSRPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350057AbiHSRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:15:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D4F144811
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660926908; x=1692462908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KkwFW11steEWoLkD1PVAr39WffncDuzUspBKgRzDtkg=;
  b=L0EvMn8okD57G2uNMdkegjj3MUKVmXqAzucsYE5qo+HtY24HWT7JaiJU
   DKARI+IeoT2vKEuEHR8qTNeZFJ/vgeLicOT7Rb5yAptH1ox21aHOscojd
   YNYhzwlw16RIldIS8C8clb9+waYuvPNbjO5l7Z2gRXXlcGf0dMjBAfWjU
   RGz4odNi/RFnptrgHtnTk2xZY/juiTyTw4lkA+BHXJ6gynxTMtaP8mp0D
   KnawAmo4zt2lCoq9XLi5tR8KkpX34+yTtox3Y2gc8uS0o0bfyHrrdlQ+b
   NVi2Qe6uvdfVp20FV3Fd/5IRCZMdt99K7iUYCuwEs5EpkGkiK9TZjMNn1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="291804501"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="291804501"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 09:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="559003150"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Aug 2022 09:35:04 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP4xc-0001dH-09;
        Fri, 19 Aug 2022 16:35:04 +0000
Date:   Sat, 20 Aug 2022 00:34:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     kbuild-all@lists.01.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/gup: fix races when looking up a CONT-PTE size
 hugetlb page
Message-ID: <202208200030.9j5HjdtZ-lkp@intel.com>
References: <0f3df6604059011bf78a286c2cf5da5c4b41ccb1.1660902741.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3df6604059011bf78a286c2cf5da5c4b41ccb1.1660902741.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: microblaze-randconfig-r003-20220819 (https://download.01.org/0day-ci/archive/20220820/202208200030.9j5HjdtZ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c0add09e9de4b39c58633c89ea25ba10ed12d134
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baolin-Wang/Fix-some-issues-when-looking-up-hugetlb-page/20220819-182017
        git checkout c0add09e9de4b39c58633c89ea25ba10ed12d134
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/gup.c: In function 'follow_page_pte':
>> mm/gup.c:551:23: error: implicit declaration of function 'huge_ptep_get' [-Werror=implicit-function-declaration]
     551 |                 pte = huge_ptep_get(ptep);
         |                       ^~~~~~~~~~~~~
>> mm/gup.c:551:23: error: incompatible types when assigning to type 'pte_t' from type 'int'
   cc1: some warnings being treated as errors


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
