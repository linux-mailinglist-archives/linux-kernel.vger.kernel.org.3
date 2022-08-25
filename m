Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3BC5A073E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiHYC1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiHYC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:27:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266382FB5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 19:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661394431; x=1692930431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m2NShgQpSZYJtyh/PISIzWJuAQu2oaO8T2wMyOtGoI8=;
  b=XKfcm+lrOHHDmM58GrVFhZFBXxAbTyaw/ptGEpYqc2P63Q7SQDQ8je57
   u8nxj8C5mUdRMFKuOxMmv7Sw/FJrkkmA1HqYrx2/JD69U4fr9oIAsPou4
   nnNJLu8BVHFYqZevV2bsT53ET4eqGZpNyzxq3kEBo8SChfcDi55L5lXYH
   2JXxVMlLamqlrRBBbRNKB514Fqkf/vK+WQ/0CVF7xiToM7bxYMMqKFaBk
   9hZNEfzvbUEYWzRu4RR/So/FoIJyTyesUfPrGLWJ7Z53xDWo3mulV1I4T
   vBe0/ZBmK+0MLEKe3b9ldN9dsv198eVt/AxAHmD7kbyJiTgWvmZtfzHkq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="320198995"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="320198995"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 19:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="639389118"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2022 19:27:08 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR2aJ-0001df-1d;
        Thu, 25 Aug 2022 02:27:07 +0000
Date:   Thu, 25 Aug 2022 10:26:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:akpm/mm/mm-unstable 272/276]
 fs/hugetlbfs/inode.c:562:16: warning: variable 'm_index' is uninitialized
 when used here
Message-ID: <202208251012.g1mOhhxy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
head:   73129b786c0eca5be67491a5e893e13b75133a62
commit: fcc0d3d00d74b012c36d52128687ab9d197d3f0d [272/276] hugetlb: handle truncate racing with page faults
config: arm64-randconfig-r014-20220823 (https://download.01.org/0day-ci/archive/20220825/202208251012.g1mOhhxy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project d00e97df0fe8c67f694c4d027297f4382ce72b38)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/fcc0d3d00d74b012c36d52128687ab9d197d3f0d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block akpm/mm/mm-unstable
        git checkout fcc0d3d00d74b012c36d52128687ab9d197d3f0d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash fs/hugetlbfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/hugetlbfs/inode.c:562:16: warning: variable 'm_index' is uninitialized when used here [-Wuninitialized]
                                                   m_start, m_index, truncate_op);
                                                            ^~~~~~~
   fs/hugetlbfs/inode.c:540:26: note: initialize the variable 'm_index' to silence this warning
           pgoff_t m_start, m_index;
                                   ^
                                    = 0
   1 warning generated.


vim +/m_index +562 fs/hugetlbfs/inode.c

   502	
   503	/*
   504	 * remove_inode_hugepages handles two distinct cases: truncation and hole
   505	 * punch.  There are subtle differences in operation for each case.
   506	 *
   507	 * truncation is indicated by end of range being LLONG_MAX
   508	 *	In this case, we first scan the range and release found pages.
   509	 *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
   510	 *	maps and global counts.  Page faults can race with truncation.
   511	 *	During faults, hugetlb_no_page() checks i_size before page allocation,
   512	 *	and again after	obtaining page table lock.  It will 'back out'
   513	 *	allocations in the truncated range.
   514	 * hole punch is indicated if end is not LLONG_MAX
   515	 *	In the hole punch case we scan the range and release found pages.
   516	 *	Only when releasing a page is the associated region/reserve map
   517	 *	deleted.  The region/reserve map for ranges without associated
   518	 *	pages are not modified.  Page faults can race with hole punch.
   519	 *	This is indicated if we find a mapped page.
   520	 * Note: If the passed end of range value is beyond the end of file, but
   521	 * not LLONG_MAX this routine still performs a hole punch operation.
   522	 *
   523	 * Since page faults can race with this routine, care must be taken as both
   524	 * modify huge page reservation data.  To somewhat synchronize these operations
   525	 * the hugetlb fault mutex is taken for EVERY index in the range to be hole
   526	 * punched or truncated.  In this way, we KNOW either:
   527	 * - fault code has added a page beyond i_size, and we will remove here
   528	 * - fault code will see updated i_size and not add a page beyond
   529	 * The parameter 'lm__end' indicates the offset of the end of hole or file
   530	 * before truncation.  For hole punch lm_end == lend.
   531	 */
   532	static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
   533					   loff_t lend, loff_t lm_end)
   534	{
   535		struct hstate *h = hstate_inode(inode);
   536		struct address_space *mapping = &inode->i_data;
   537		const pgoff_t start = lstart >> huge_page_shift(h);
   538		const pgoff_t end = lend >> huge_page_shift(h);
   539		pgoff_t m_end = lm_end >> huge_page_shift(h);
   540		pgoff_t m_start, m_index;
   541		struct folio_batch fbatch;
   542		struct folio *folio;
   543		pgoff_t next, index;
   544		unsigned int i;
   545		long freed = 0;
   546		u32 hash;
   547		bool truncate_op = (lend == LLONG_MAX);
   548	
   549		folio_batch_init(&fbatch);
   550		next = m_start = start;
   551		while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
   552			for (i = 0; i < folio_batch_count(&fbatch); ++i) {
   553				folio = fbatch.folios[i];
   554	
   555				index = folio->index;
   556				/*
   557				 * Take fault mutex for missing folios before index,
   558				 * while checking folios that might have been added
   559				 * due to a race with fault code.
   560				 */
   561				freed += fault_lock_inode_indicies(h, inode, mapping,
 > 562							m_start, m_index, truncate_op);
   563	
   564				/*
   565				 * Remove folio that was part of folio_batch.
   566				 */
   567				hash = hugetlb_fault_mutex_hash(mapping, index);
   568				mutex_lock(&hugetlb_fault_mutex_table[hash]);
   569				if (remove_inode_single_folio(h, inode, mapping, folio,
   570								index, truncate_op))
   571					freed++;
   572				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
   573			}
   574			folio_batch_release(&fbatch);
   575			cond_resched();
   576		}
   577	
   578		/*
   579		 * Take fault mutex for missing folios at end of range while checking
   580		 * for folios that might have been added due to a race with fault code.
   581		 */
   582		freed += fault_lock_inode_indicies(h, inode, mapping, m_start, m_end,
   583							truncate_op);
   584	
   585		if (truncate_op)
   586			(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
   587	}
   588	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
