Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404855365DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349351AbiE0QUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbiE0QUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:20:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA769549A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653668445; x=1685204445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7YKW6/mONoRF3m+7A6/kC+CS6TOLVXAiF5s00qaXmZE=;
  b=bR7wq8aLnvZtkEDLmeohHpe9vB/+Q7Cl58UWcesALHeJvDze0lRBty6M
   xr5v0xhoS2FAkhDo8l+1IweR2ZAlhGmHsgEK7VeUPrMg0ox3DrkKr7jMo
   Biw4RurW7baVHMKynPoqYkz5MGLBFx2vsnlhdtk7GP7nehuLCvCDJM68u
   /nBEQor+vSGwoSrDAo4Wkv2lss0QYoNMRwGRDtfvS6+z9U5nFgrwVYaA3
   vpO5J3EEeVN/4xSB7bUfBtg+z3ILbINo5cb7a3UglNupJ+MHwfAiaiJRr
   uFAY+/5azckE2+Yyd6SfhI73NEDG6JXsvhSYnJ8Zf3cH4G+wfwSrk/Sge
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="272089892"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="272089892"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 09:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="560838084"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2022 09:20:39 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nucha-0004tj-Lp;
        Fri, 27 May 2022 16:20:38 +0000
Date:   Sat, 28 May 2022 00:19:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>,
        akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: Re: [PATCH 2/2] [PATCH 2/2] mm: add merging after mremap resize
Message-ID: <202205272341.dFRSUlfS-lkp@intel.com>
References: <20220527104810.24736-3-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527104810.24736-3-matenajakub@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Jakub,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.18]
[cannot apply to akpm-mm/mm-everything linus/master next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Mat-na/Refactor-of-vma_merge-and-new-merge-call/20220527-184844
base:    4b0986a3613c92f4ec1bdc7f60ec66fea135991f
config: mips-pic32mzda_defconfig (https://download.01.org/0day-ci/archive/20220527/202205272341.dFRSUlfS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/fae2b6e81c73c0517e3be864608d069a2d4fb8b3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jakub-Mat-na/Refactor-of-vma_merge-and-new-merge-call/20220527-184844
        git checkout fae2b6e81c73c0517e3be864608d069a2d4fb8b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/mremap.c:1028:47: error: call to undeclared function 'vma_policy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                           vma->vm_pgoff + (old_len >> PAGE_SHIFT), vma_policy(vma),
                                                                                    ^
   mm/mremap.c:1028:47: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct mempolicy *' [-Wint-conversion]
                                           vma->vm_pgoff + (old_len >> PAGE_SHIFT), vma_policy(vma),
                                                                                    ^~~~~~~~~~~~~~~
   include/linux/mm.h:2628:20: note: passing argument to parameter here
           struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
                             ^
   1 warning and 1 error generated.


vim +/vma_policy +1028 mm/mremap.c

   885	
   886	/*
   887	 * Expand (or shrink) an existing mapping, potentially moving it at the
   888	 * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
   889	 *
   890	 * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
   891	 * This option implies MREMAP_MAYMOVE.
   892	 */
   893	SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
   894			unsigned long, new_len, unsigned long, flags,
   895			unsigned long, new_addr)
   896	{
   897		struct mm_struct *mm = current->mm;
   898		struct vm_area_struct *vma;
   899		unsigned long ret = -EINVAL;
   900		bool locked = false;
   901		bool downgraded = false;
   902		struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
   903		LIST_HEAD(uf_unmap_early);
   904		LIST_HEAD(uf_unmap);
   905	
   906		/*
   907		 * There is a deliberate asymmetry here: we strip the pointer tag
   908		 * from the old address but leave the new address alone. This is
   909		 * for consistency with mmap(), where we prevent the creation of
   910		 * aliasing mappings in userspace by leaving the tag bits of the
   911		 * mapping address intact. A non-zero tag will cause the subsequent
   912		 * range checks to reject the address as invalid.
   913		 *
   914		 * See Documentation/arm64/tagged-address-abi.rst for more information.
   915		 */
   916		addr = untagged_addr(addr);
   917	
   918		if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
   919			return ret;
   920	
   921		if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
   922			return ret;
   923	
   924		/*
   925		 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
   926		 * in the process.
   927		 */
   928		if (flags & MREMAP_DONTUNMAP &&
   929				(!(flags & MREMAP_MAYMOVE) || old_len != new_len))
   930			return ret;
   931	
   932	
   933		if (offset_in_page(addr))
   934			return ret;
   935	
   936		old_len = PAGE_ALIGN(old_len);
   937		new_len = PAGE_ALIGN(new_len);
   938	
   939		/*
   940		 * We allow a zero old-len as a special case
   941		 * for DOS-emu "duplicate shm area" thing. But
   942		 * a zero new-len is nonsensical.
   943		 */
   944		if (!new_len)
   945			return ret;
   946	
   947		if (mmap_write_lock_killable(current->mm))
   948			return -EINTR;
   949		vma = vma_lookup(mm, addr);
   950		if (!vma) {
   951			ret = -EFAULT;
   952			goto out;
   953		}
   954	
   955		if (is_vm_hugetlb_page(vma)) {
   956			struct hstate *h __maybe_unused = hstate_vma(vma);
   957	
   958			old_len = ALIGN(old_len, huge_page_size(h));
   959			new_len = ALIGN(new_len, huge_page_size(h));
   960	
   961			/* addrs must be huge page aligned */
   962			if (addr & ~huge_page_mask(h))
   963				goto out;
   964			if (new_addr & ~huge_page_mask(h))
   965				goto out;
   966	
   967			/*
   968			 * Don't allow remap expansion, because the underlying hugetlb
   969			 * reservation is not yet capable to handle split reservation.
   970			 */
   971			if (new_len > old_len)
   972				goto out;
   973		}
   974	
   975		if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
   976			ret = mremap_to(addr, old_len, new_addr, new_len,
   977					&locked, flags, &uf, &uf_unmap_early,
   978					&uf_unmap);
   979			goto out;
   980		}
   981	
   982		/*
   983		 * Always allow a shrinking remap: that just unmaps
   984		 * the unnecessary pages..
   985		 * __do_munmap does all the needed commit accounting, and
   986		 * downgrades mmap_lock to read if so directed.
   987		 */
   988		if (old_len >= new_len) {
   989			int retval;
   990	
   991			retval = __do_munmap(mm, addr+new_len, old_len - new_len,
   992					  &uf_unmap, true);
   993			if (retval < 0 && old_len != new_len) {
   994				ret = retval;
   995				goto out;
   996			/* Returning 1 indicates mmap_lock is downgraded to read. */
   997			} else if (retval == 1)
   998				downgraded = true;
   999			ret = addr;
  1000			goto out;
  1001		}
  1002	
  1003		/*
  1004		 * Ok, we need to grow..
  1005		 */
  1006		vma = vma_to_resize(addr, old_len, new_len, flags);
  1007		if (IS_ERR(vma)) {
  1008			ret = PTR_ERR(vma);
  1009			goto out;
  1010		}
  1011	
  1012		/* old_len exactly to the end of the area..
  1013		 */
  1014		if (old_len == vma->vm_end - addr) {
  1015			/* can we just expand the current mapping? */
  1016			if (vma_expandable(vma, new_len - old_len)) {
  1017				long pages = (new_len - old_len) >> PAGE_SHIFT;
  1018	
  1019				if (vma->vm_flags & VM_ACCOUNT) {
  1020					if (security_vm_enough_memory_mm(mm, pages)) {
  1021						ret = -ENOMEM;
  1022						goto out;
  1023					}
  1024				}
  1025	
  1026				vma = vma_merge(mm, vma, addr + old_len, addr + new_len,
  1027						vma->vm_flags, vma->anon_vma, vma->vm_file,
> 1028						vma->vm_pgoff + (old_len >> PAGE_SHIFT), vma_policy(vma),

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
