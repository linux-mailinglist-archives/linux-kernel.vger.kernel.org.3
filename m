Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E504F5B16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444040AbiDFJhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452377AbiDFJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:34:46 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9F5141D8D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649225875; x=1680761875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Naa24ktxw2UZOhiet3D4DF5IbUq9hEaWxUtScFptzPY=;
  b=DGf9OXtxc/WxSGEdS6xLhbotf65nT+15UVcRc04kMWUZl61DABDhXI1g
   zHBahDf8ObS5bPUpxWJf84Epon17Yy35jkeg+ZYi2fP2Xmk/LQkB0qddW
   NzuxPpz1NVNpsT5R2/0y5hxaI87eJAWqwytv55ZV32t8MdyB2pIy6BXLP
   mD9yosuss3HXY6VBthCh+HqaXnEoSAtcmmjDsRtH3Gnyq0MSkYK2blbD7
   cuzofn1JjJPDmy1bopjbCK4+tKRgIGW3DjE0TzdtCtWVfawdKSOgBqBkH
   9NnVx4B/QUUvE3Ur9AhDJBJYoXuQhDJeC8KQx1GQMO5H73U7CmfTp9eW9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="321657139"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="321657139"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 23:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="505601654"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2022 23:17:50 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbyzF-00048D-V8;
        Wed, 06 Apr 2022 06:17:49 +0000
Date:   Wed, 6 Apr 2022 14:16:56 +0800
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
Subject: Re: [PATCH v8 10/23] mm/shmem: Handle uffd-wp during fork()
Message-ID: <202204061453.OXOxSh6e-lkp@intel.com>
References: <20220405014855.14468-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405014855.14468-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[cannot apply to arnd-asm-generic/master linus/master linux/master v5.18-rc1 next-20220405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20220405-100136
base:   https://github.com/hnaz/linux-mm master
config: ia64-buildonly-randconfig-r005-20220405 (https://download.01.org/0day-ci/archive/20220406/202204061453.OXOxSh6e-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/49e56558a1f453907d2813e1ba94d91f9d102e73
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20220405-100136
        git checkout 49e56558a1f453907d2813e1ba94d91f9d102e73
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from arch/ia64/include/asm/sections.h:11,
                    from include/linux/interrupt.h:21,
                    from include/linux/kernel_stat.h:9,
                    from mm/memory.c:42:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from include/linux/mm_inline.h:9,
                    from mm/memory.c:44:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
   include/linux/userfaultfd_k.h:260:16: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
     260 |         return is_pte_marker_entry(entry) &&
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:261:14: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
     261 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |              ^~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:261:38: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
     261 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |                                      ^~~~~~~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:261:38: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/mm_inline.h:10,
                    from mm/memory.c:44:
   include/linux/swapops.h: At top level:
   include/linux/swapops.h:289:20: error: conflicting types for 'is_pte_marker_entry'; have 'bool(swp_entry_t)' {aka '_Bool(swp_entry_t)'}
     289 | static inline bool is_pte_marker_entry(swp_entry_t entry)
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:9,
                    from mm/memory.c:44:
   include/linux/userfaultfd_k.h:260:16: note: previous implicit declaration of 'is_pte_marker_entry' with type 'int()'
     260 |         return is_pte_marker_entry(entry) &&
         |                ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:10,
                    from mm/memory.c:44:
   include/linux/swapops.h:294:26: error: conflicting types for 'pte_marker_get'; have 'pte_marker(swp_entry_t)' {aka 'long unsigned int(swp_entry_t)'}
     294 | static inline pte_marker pte_marker_get(swp_entry_t entry)
         |                          ^~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:9,
                    from mm/memory.c:44:
   include/linux/userfaultfd_k.h:261:14: note: previous implicit declaration of 'pte_marker_get' with type 'int()'
     261 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
         |              ^~~~~~~~~~~~~~
>> mm/memory.c:1238:1: warning: no previous prototype for 'vma_needs_copy' [-Wmissing-prototypes]
    1238 | vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
         | ^~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:9,
                    from mm/memory.c:44:
   include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
   include/linux/userfaultfd_k.h:262:1: error: control reaches end of non-void function [-Werror=return-type]
     262 | }
         | ^
   cc1: some warnings being treated as errors


vim +/vma_needs_copy +1238 mm/memory.c

  1231	
  1232	/*
  1233	 * Return true if the vma needs to copy the pgtable during this fork().  Return
  1234	 * false when we can speed up fork() by allowing lazy page faults later until
  1235	 * when the child accesses the memory range.
  1236	 */
  1237	bool
> 1238	vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
  1239	{
  1240		/*
  1241		 * Always copy pgtables when dst_vma has uffd-wp enabled even if it's
  1242		 * file-backed (e.g. shmem). Because when uffd-wp is enabled, pgtable
  1243		 * contains uffd-wp protection information, that's something we can't
  1244		 * retrieve from page cache, and skip copying will lose those info.
  1245		 */
  1246		if (userfaultfd_wp(dst_vma))
  1247			return true;
  1248	
  1249		if (src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP))
  1250			return true;
  1251	
  1252		if (src_vma->anon_vma)
  1253			return true;
  1254	
  1255		/*
  1256		 * Don't copy ptes where a page fault will fill them correctly.  Fork
  1257		 * becomes much lighter when there are big shared or private readonly
  1258		 * mappings. The tradeoff is that copy_page_range is more efficient
  1259		 * than faulting.
  1260		 */
  1261		return false;
  1262	}
  1263	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
