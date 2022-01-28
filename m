Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC54A0285
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351356AbiA1VEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:04:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:37506 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344460AbiA1VEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403847; x=1674939847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1MpFDH2tR9CzgNBEpXqj9qPA8gF4hMP/CVmDSAQKQjQ=;
  b=XaOcnlekMpcOVXRZyoC5kVoTvnxCwvJUtLUspfRL5cgsAtZUH4tvNa1Z
   2qREhiEwkc3CiLYSrFKL4/cVE3LNTgaxI91kXCwTf6K+hkqLM//icPcMO
   uCs5e5Z+nRv91Kg7oGTVxK8ajUQnhjQXGxwijBMBELhBMikWUVuEUlwQO
   WlRn1t4Zxz3Eybp6Z5n/THbaBT1Kn+FpF7vDTcOwUlo4zCD6b3vUJGWny
   9SfbukDhIoZHm++OnGk8eknslgdqRt8ZewPDIfXmOJFRthFFi+DxvRjRI
   Cw237eB4w6U0FjcTTh7EofT73zy2mcG34Ez1fJig1ZCLQ2BJcTq3DExun
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="310510056"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="310510056"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="598316993"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2022 13:04:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDYPa-000OJo-4h; Fri, 28 Jan 2022 21:04:02 +0000
Date:   Sat, 29 Jan 2022 05:03:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 18/35] mm: implement speculative handling in
 do_anonymous_page()
Message-ID: <202201290445.uKuWeLmf-lkp@intel.com>
References: <20220128131006.67712-19-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128131006.67712-19-michel@lespinasse.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc1 next-20220128]
[cannot apply to tip/x86/mm arm64/for-next/core powerpc/next hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michel-Lespinasse/Speculative-page-faults/20220128-212122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 145d9b498fc827b79c1260b4caa29a8e59d4c2b9
config: arm-vt8500_v6_v7_defconfig (https://download.01.org/0day-ci/archive/20220129/202201290445.uKuWeLmf-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/fa5331bae2e49ce86eff959390b451b7401f9156
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michel-Lespinasse/Speculative-page-faults/20220128-212122
        git checkout fa5331bae2e49ce86eff959390b451b7401f9156
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/memory.c:3876:20: warning: variable 'vmf' is uninitialized when used within its own initialization [-Wuninitialized]
           if (!pte_map_lock(vmf)) {
                ~~~~~~~~~~~~~^~~~
   include/linux/mm.h:3418:25: note: expanded from macro 'pte_map_lock'
           struct vm_fault *vmf = __vmf;                                   \
                            ~~~   ^~~~~
   1 warning generated.


vim +/vmf +3876 mm/memory.c

  3808	
  3809	/*
  3810	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  3811	 * but allow concurrent faults), and pte mapped but not yet locked.
  3812	 * We return with mmap_lock still held, but pte unmapped and unlocked.
  3813	 */
  3814	static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
  3815	{
  3816		struct vm_area_struct *vma = vmf->vma;
  3817		struct page *page = NULL;
  3818		vm_fault_t ret = 0;
  3819		pte_t entry;
  3820	
  3821		/* File mapping without ->vm_ops ? */
  3822		if (vma->vm_flags & VM_SHARED)
  3823			return VM_FAULT_SIGBUS;
  3824	
  3825		/*
  3826		 * Use pte_alloc() instead of pte_alloc_map().  We can't run
  3827		 * pte_offset_map() on pmds where a huge pmd might be created
  3828		 * from a different thread.
  3829		 *
  3830		 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
  3831		 * parallel threads are excluded by other means.
  3832		 *
  3833		 * Here we only have mmap_read_lock(mm).
  3834		 */
  3835		if (pte_alloc(vma->vm_mm, vmf->pmd))
  3836			return VM_FAULT_OOM;
  3837	
  3838		/* See comment in __handle_mm_fault() */
  3839		if (unlikely(pmd_trans_unstable(vmf->pmd)))
  3840			return 0;
  3841	
  3842		/* Use the zero-page for reads */
  3843		if (!(vmf->flags & FAULT_FLAG_WRITE) &&
  3844				!mm_forbids_zeropage(vma->vm_mm)) {
  3845			entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
  3846							vma->vm_page_prot));
  3847		} else {
  3848			/* Allocate our own private page. */
  3849			if (unlikely(!vma->anon_vma)) {
  3850				if (vmf->flags & FAULT_FLAG_SPECULATIVE)
  3851					return VM_FAULT_RETRY;
  3852				if (__anon_vma_prepare(vma))
  3853					goto oom;
  3854			}
  3855			page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
  3856			if (!page)
  3857				goto oom;
  3858	
  3859			if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
  3860				goto oom_free_page;
  3861			cgroup_throttle_swaprate(page, GFP_KERNEL);
  3862	
  3863			/*
  3864			 * The memory barrier inside __SetPageUptodate makes sure that
  3865			 * preceding stores to the page contents become visible before
  3866			 * the set_pte_at() write.
  3867			 */
  3868			__SetPageUptodate(page);
  3869	
  3870			entry = mk_pte(page, vma->vm_page_prot);
  3871			entry = pte_sw_mkyoung(entry);
  3872			if (vma->vm_flags & VM_WRITE)
  3873				entry = pte_mkwrite(pte_mkdirty(entry));
  3874		}
  3875	
> 3876		if (!pte_map_lock(vmf)) {
  3877			ret = VM_FAULT_RETRY;
  3878			goto release;
  3879		}
  3880		if (!pte_none(*vmf->pte)) {
  3881			update_mmu_tlb(vma, vmf->address, vmf->pte);
  3882			goto unlock;
  3883		}
  3884	
  3885		ret = check_stable_address_space(vma->vm_mm);
  3886		if (ret)
  3887			goto unlock;
  3888	
  3889		/* Deliver the page fault to userland, check inside PT lock */
  3890		if (userfaultfd_missing(vma)) {
  3891			pte_unmap_unlock(vmf->pte, vmf->ptl);
  3892			if (page)
  3893				put_page(page);
  3894			if (vmf->flags & FAULT_FLAG_SPECULATIVE)
  3895				return VM_FAULT_RETRY;
  3896			return handle_userfault(vmf, VM_UFFD_MISSING);
  3897		}
  3898	
  3899		if (page) {
  3900			inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
  3901			page_add_new_anon_rmap(page, vma, vmf->address, false);
  3902			lru_cache_add_inactive_or_unevictable(page, vma);
  3903		}
  3904	
  3905		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
  3906	
  3907		/* No need to invalidate - it was non-present before */
  3908		update_mmu_cache(vma, vmf->address, vmf->pte);
  3909		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3910		return 0;
  3911	unlock:
  3912		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3913	release:
  3914		if (page)
  3915			put_page(page);
  3916		return ret;
  3917	oom_free_page:
  3918		put_page(page);
  3919	oom:
  3920		return VM_FAULT_OOM;
  3921	}
  3922	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
