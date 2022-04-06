Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C84F6495
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiDFQJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiDFQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:07:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD03354285
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649252287; x=1680788287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UeFC7fpDZnXplz+DIDUQq9eJtolg3YQ0MG069H0UONk=;
  b=QdHpBTtsnqiquRY7dsJ91JY5CrISk8D2RMbyKodEBvEb2J+D58SxEb/C
   zAm1OqUjR0qY8cJZQvWXsK4HkBefggg5tOsiaT75LLwULr4OclSGviQq4
   ZEMcOy+X2d72nOdkZqiE2uyQfNAX9A0ivc0qpX27ZkLWyqnyDYmlxls7J
   RXKUdK6uv5AwmrJFW8Y8yanlCxy/K5JfdeIFTJjXzON+H5AErnDLjekCO
   JhJWQo7LDvm8AwUFA5aO3PonWEVjEiSSJZNbbR6bb7i2k59/fPgKyJnOT
   lwHqOTRWC1uXw3kKBNwnKwkYlhBpkeXBrjWESpzcJaeRxoSLp2/fxELTQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="248567249"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="248567249"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="588372196"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2022 06:38:03 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nc5rG-0004RV-EO;
        Wed, 06 Apr 2022 13:38:02 +0000
Date:   Wed, 6 Apr 2022 21:37:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: Re: [PATCH v8 15/23] mm/hugetlb: Handle pte markers in page faults
Message-ID: <202204062154.2txNJyaf-lkp@intel.com>
References: <20220405014909.14761-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405014909.14761-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[cannot apply to arnd-asm-generic/master linus/master linux/master v5.18-rc1 next-20220406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20220405-100136
base:   https://github.com/hnaz/linux-mm master
config: s390-randconfig-r044-20220406 (https://download.01.org/0day-ci/archive/20220406/202204062154.2txNJyaf-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e7e7aaec811e2817cd169f0cc1d8f81bdf1f05c3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20220405-100136
        git checkout e7e7aaec811e2817cd169f0cc1d8f81bdf1f05c3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/hugetlb.c: In function 'hugetlb_fault':
>> mm/hugetlb.c:5678:13: error: implicit declaration of function 'huge_pte_none_mostly'; did you mean 'pte_none_mostly'? [-Werror=implicit-function-declaration]
    5678 |         if (huge_pte_none_mostly(entry)) {
         |             ^~~~~~~~~~~~~~~~~~~~
         |             pte_none_mostly
   cc1: some warnings being treated as errors


vim +5678 mm/hugetlb.c

  5616	
  5617	vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  5618				unsigned long address, unsigned int flags)
  5619	{
  5620		pte_t *ptep, entry;
  5621		spinlock_t *ptl;
  5622		vm_fault_t ret;
  5623		u32 hash;
  5624		pgoff_t idx;
  5625		struct page *page = NULL;
  5626		struct page *pagecache_page = NULL;
  5627		struct hstate *h = hstate_vma(vma);
  5628		struct address_space *mapping;
  5629		int need_wait_lock = 0;
  5630		unsigned long haddr = address & huge_page_mask(h);
  5631	
  5632		ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
  5633		if (ptep) {
  5634			/*
  5635			 * Since we hold no locks, ptep could be stale.  That is
  5636			 * OK as we are only making decisions based on content and
  5637			 * not actually modifying content here.
  5638			 */
  5639			entry = huge_ptep_get(ptep);
  5640			if (unlikely(is_hugetlb_entry_migration(entry))) {
  5641				migration_entry_wait_huge(vma, mm, ptep);
  5642				return 0;
  5643			} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
  5644				return VM_FAULT_HWPOISON_LARGE |
  5645					VM_FAULT_SET_HINDEX(hstate_index(h));
  5646		}
  5647	
  5648		/*
  5649		 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
  5650		 * until finished with ptep.  This serves two purposes:
  5651		 * 1) It prevents huge_pmd_unshare from being called elsewhere
  5652		 *    and making the ptep no longer valid.
  5653		 * 2) It synchronizes us with i_size modifications during truncation.
  5654		 *
  5655		 * ptep could have already be assigned via huge_pte_offset.  That
  5656		 * is OK, as huge_pte_alloc will return the same value unless
  5657		 * something has changed.
  5658		 */
  5659		mapping = vma->vm_file->f_mapping;
  5660		i_mmap_lock_read(mapping);
  5661		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
  5662		if (!ptep) {
  5663			i_mmap_unlock_read(mapping);
  5664			return VM_FAULT_OOM;
  5665		}
  5666	
  5667		/*
  5668		 * Serialize hugepage allocation and instantiation, so that we don't
  5669		 * get spurious allocation failures if two CPUs race to instantiate
  5670		 * the same page in the page cache.
  5671		 */
  5672		idx = vma_hugecache_offset(h, vma, haddr);
  5673		hash = hugetlb_fault_mutex_hash(mapping, idx);
  5674		mutex_lock(&hugetlb_fault_mutex_table[hash]);
  5675	
  5676		entry = huge_ptep_get(ptep);
  5677		/* PTE markers should be handled the same way as none pte */
> 5678		if (huge_pte_none_mostly(entry)) {
  5679			ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
  5680					      entry, flags);
  5681			goto out_mutex;
  5682		}
  5683	
  5684		ret = 0;
  5685	
  5686		/*
  5687		 * entry could be a migration/hwpoison entry at this point, so this
  5688		 * check prevents the kernel from going below assuming that we have
  5689		 * an active hugepage in pagecache. This goto expects the 2nd page
  5690		 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
  5691		 * properly handle it.
  5692		 */
  5693		if (!pte_present(entry))
  5694			goto out_mutex;
  5695	
  5696		/*
  5697		 * If we are going to COW/unshare the mapping later, we examine the
  5698		 * pending reservations for this page now. This will ensure that any
  5699		 * allocations necessary to record that reservation occur outside the
  5700		 * spinlock. For private mappings, we also lookup the pagecache
  5701		 * page now as it is used to determine if a reservation has been
  5702		 * consumed.
  5703		 */
  5704		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
  5705		    !huge_pte_write(entry)) {
  5706			if (vma_needs_reservation(h, vma, haddr) < 0) {
  5707				ret = VM_FAULT_OOM;
  5708				goto out_mutex;
  5709			}
  5710			/* Just decrements count, does not deallocate */
  5711			vma_end_reservation(h, vma, haddr);
  5712	
  5713			if (!(vma->vm_flags & VM_MAYSHARE))
  5714				pagecache_page = hugetlbfs_pagecache_page(h,
  5715									vma, haddr);
  5716		}
  5717	
  5718		ptl = huge_pte_lock(h, mm, ptep);
  5719	
  5720		/* Check for a racing update before calling hugetlb_wp() */
  5721		if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
  5722			goto out_ptl;
  5723	
  5724		/* Handle userfault-wp first, before trying to lock more pages */
  5725		if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
  5726		    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
  5727			struct vm_fault vmf = {
  5728				.vma = vma,
  5729				.address = haddr,
  5730				.real_address = address,
  5731				.flags = flags,
  5732			};
  5733	
  5734			spin_unlock(ptl);
  5735			if (pagecache_page) {
  5736				unlock_page(pagecache_page);
  5737				put_page(pagecache_page);
  5738			}
  5739			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
  5740			i_mmap_unlock_read(mapping);
  5741			return handle_userfault(&vmf, VM_UFFD_WP);
  5742		}
  5743	
  5744		/*
  5745		 * hugetlb_wp() requires page locks of pte_page(entry) and
  5746		 * pagecache_page, so here we need take the former one
  5747		 * when page != pagecache_page or !pagecache_page.
  5748		 */
  5749		page = pte_page(entry);
  5750		if (page != pagecache_page)
  5751			if (!trylock_page(page)) {
  5752				need_wait_lock = 1;
  5753				goto out_ptl;
  5754			}
  5755	
  5756		get_page(page);
  5757	
  5758		if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
  5759			if (!huge_pte_write(entry)) {
  5760				ret = hugetlb_wp(mm, vma, address, ptep, flags,
  5761						 pagecache_page, ptl);
  5762				goto out_put_page;
  5763			} else if (likely(flags & FAULT_FLAG_WRITE)) {
  5764				entry = huge_pte_mkdirty(entry);
  5765			}
  5766		}
  5767		entry = pte_mkyoung(entry);
  5768		if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
  5769							flags & FAULT_FLAG_WRITE))
  5770			update_mmu_cache(vma, haddr, ptep);
  5771	out_put_page:
  5772		if (page != pagecache_page)
  5773			unlock_page(page);
  5774		put_page(page);
  5775	out_ptl:
  5776		spin_unlock(ptl);
  5777	
  5778		if (pagecache_page) {
  5779			unlock_page(pagecache_page);
  5780			put_page(pagecache_page);
  5781		}
  5782	out_mutex:
  5783		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
  5784		i_mmap_unlock_read(mapping);
  5785		/*
  5786		 * Generally it's safe to hold refcount during waiting page lock. But
  5787		 * here we just wait to defer the next page fault to avoid busy loop and
  5788		 * the page is not used after unlocked before returning from the current
  5789		 * page fault. So we are safe from accessing freed page, even if we wait
  5790		 * here without taking refcount.
  5791		 */
  5792		if (need_wait_lock)
  5793			wait_on_page_locked(page);
  5794		return ret;
  5795	}
  5796	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
