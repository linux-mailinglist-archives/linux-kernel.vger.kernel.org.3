Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CFE4EC5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbiC3Nb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbiC3Nby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:31:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C454D15A10;
        Wed, 30 Mar 2022 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648647008; x=1680183008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tW1fLo6jCq3/8fTF55IDRQFyF2oxcC5H24BleOxUSr4=;
  b=gSIqUX2sSZqq1vC5f74ZnH80n1qgxPSe3ueZYd1YC4gsGvR20VnAyiRs
   fdd0YFPp4Y9j1JaVwSx9KwabGGJmzwiS/4GlQdFx9ibOT8X+DrIdGbHl5
   FVZM6wPIrBiup3cdwStch6AHXNOjKObai5Ux96/jtkUyvkH2M5Zrw3PGi
   s73BCBaHhfxAtA5FgC3fBc9qXuVggpjvlbC7qck7EUVbkgnytXKT1/NiR
   mMt//HOUPQcntgfd8N3UBOJ3UbXk50DdXoLY24Nkxg3A1/lN3Eo1N276V
   OJW8cNpl0z+rSwK/z8nvSUCkZDka1EUSK4pNrujEcwzzIwDkbkgxFnawz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="257121281"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="257121281"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 06:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="521891558"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Mar 2022 06:30:04 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZYOh-00001W-Hs;
        Wed, 30 Mar 2022 13:30:03 +0000
Date:   Wed, 30 Mar 2022 21:29:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org, david@redhat.com,
        willy@infradead.org
Cc:     kbuild-all@lists.01.org, corbet@lwn.net, yang.yang29@zte.com.cn,
        yang.shi@linux.alibaba.com, dave.hansen@linux.intel.com,
        jhubbard@nvidia.com, saravanand@fb.com, minchan@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH v4] mm/vmstat: add events for ksm cow
Message-ID: <202203302122.cFR0tu2M-lkp@intel.com>
References: <20220330082640.2381401-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330082640.2381401-1-yang.yang29@zte.com.cn>
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

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/mm-vmstat-add-events-for-ksm-cow/20220330-162859
base:   https://github.com/hnaz/linux-mm master
config: nios2-buildonly-randconfig-r001-20220330 (https://download.01.org/0day-ci/archive/20220330/202203302122.cFR0tu2M-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/48bd13bff24d30af750dd9429638a2563b758611
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-vmstat-add-events-for-ksm-cow/20220330-162859
        git checkout 48bd13bff24d30af750dd9429638a2563b758611
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/memory.c: In function 'do_wp_page':
>> mm/memory.c:3336:32: error: 'COW_KSM' undeclared (first use in this function)
    3336 |                 count_vm_event(COW_KSM);
         |                                ^~~~~~~
   mm/memory.c:3336:32: note: each undeclared identifier is reported only once for each function it appears in


vim +/COW_KSM +3336 mm/memory.c

  3229	
  3230	/*
  3231	 * This routine handles present pages, when users try to write
  3232	 * to a shared page. It is done by copying the page to a new address
  3233	 * and decrementing the shared-page counter for the old page.
  3234	 *
  3235	 * Note that this routine assumes that the protection checks have been
  3236	 * done by the caller (the low-level page fault routine in most cases).
  3237	 * Thus we can safely just mark it writable once we've done any necessary
  3238	 * COW.
  3239	 *
  3240	 * We also mark the page dirty at this point even though the page will
  3241	 * change only once the write actually happens. This avoids a few races,
  3242	 * and potentially makes it more efficient.
  3243	 *
  3244	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  3245	 * but allow concurrent faults), with pte both mapped and locked.
  3246	 * We return with mmap_lock still held, but pte unmapped and unlocked.
  3247	 */
  3248	static vm_fault_t do_wp_page(struct vm_fault *vmf)
  3249		__releases(vmf->ptl)
  3250	{
  3251		struct vm_area_struct *vma = vmf->vma;
  3252	
  3253		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
  3254			pte_unmap_unlock(vmf->pte, vmf->ptl);
  3255			return handle_userfault(vmf, VM_UFFD_WP);
  3256		}
  3257	
  3258		/*
  3259		 * Userfaultfd write-protect can defer flushes. Ensure the TLB
  3260		 * is flushed in this case before copying.
  3261		 */
  3262		if (unlikely(userfaultfd_wp(vmf->vma) &&
  3263			     mm_tlb_flush_pending(vmf->vma->vm_mm)))
  3264			flush_tlb_page(vmf->vma, vmf->address);
  3265	
  3266		vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
  3267		if (!vmf->page) {
  3268			/*
  3269			 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
  3270			 * VM_PFNMAP VMA.
  3271			 *
  3272			 * We should not cow pages in a shared writeable mapping.
  3273			 * Just mark the pages writable and/or call ops->pfn_mkwrite.
  3274			 */
  3275			if ((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
  3276					     (VM_WRITE|VM_SHARED))
  3277				return wp_pfn_shared(vmf);
  3278	
  3279			pte_unmap_unlock(vmf->pte, vmf->ptl);
  3280			return wp_page_copy(vmf);
  3281		}
  3282	
  3283		/*
  3284		 * Take out anonymous pages first, anonymous shared vmas are
  3285		 * not dirty accountable.
  3286		 */
  3287		if (PageAnon(vmf->page)) {
  3288			struct page *page = vmf->page;
  3289	
  3290			/*
  3291			 * We have to verify under page lock: these early checks are
  3292			 * just an optimization to avoid locking the page and freeing
  3293			 * the swapcache if there is little hope that we can reuse.
  3294			 *
  3295			 * PageKsm() doesn't necessarily raise the page refcount.
  3296			 */
  3297			if (PageKsm(page) || page_count(page) > 3)
  3298				goto copy;
  3299			if (!PageLRU(page))
  3300				/*
  3301				 * Note: We cannot easily detect+handle references from
  3302				 * remote LRU pagevecs or references to PageLRU() pages.
  3303				 */
  3304				lru_add_drain();
  3305			if (page_count(page) > 1 + PageSwapCache(page))
  3306				goto copy;
  3307			if (!trylock_page(page))
  3308				goto copy;
  3309			if (PageSwapCache(page))
  3310				try_to_free_swap(page);
  3311			if (PageKsm(page) || page_count(page) != 1) {
  3312				unlock_page(page);
  3313				goto copy;
  3314			}
  3315			/*
  3316			 * Ok, we've got the only page reference from our mapping
  3317			 * and the page is locked, it's dark out, and we're wearing
  3318			 * sunglasses. Hit it.
  3319			 */
  3320			unlock_page(page);
  3321			wp_page_reuse(vmf);
  3322			return VM_FAULT_WRITE;
  3323		} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
  3324						(VM_WRITE|VM_SHARED))) {
  3325			return wp_page_shared(vmf);
  3326		}
  3327	copy:
  3328		/*
  3329		 * Ok, we need to copy. Oh, well..
  3330		 */
  3331		get_page(vmf->page);
  3332	
  3333		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3334	#ifdef CONFIG_KSM
  3335		if (PageKsm(vmf->page))
> 3336			count_vm_event(COW_KSM);
  3337	#endif
  3338		return wp_page_copy(vmf);
  3339	}
  3340	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
