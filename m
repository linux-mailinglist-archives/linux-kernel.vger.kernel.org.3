Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286024FB18D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbiDKB5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244340AbiDKB5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:57:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A363DE038
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 18:54:45 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KcBh72rkYzgYbN;
        Mon, 11 Apr 2022 09:52:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 09:54:42 +0800
Subject: Re: [PATCH 4/4] mm/migration: fix potential pte_unmap on an not
 mapped pte
To:     kernel test robot <lkp@intel.com>, <akpm@linux-foundation.org>
CC:     <kbuild-all@lists.01.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>,
        <ying.huang@intel.com>, <ziy@nvidia.com>, <minchan@kernel.org>,
        <apopple@nvidia.com>, <dave.hansen@linux.intel.com>,
        <o451686892@gmail.com>, <jhubbard@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <osalvador@suse.de>, <david@redhat.com>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220409073846.22286-5-linmiaohe@huawei.com>
 <202204091914.psVO4TrI-lkp@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <66caf56c-e966-9905-84b8-2072d93dd27b@huawei.com>
Date:   Mon, 11 Apr 2022 09:54:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202204091914.psVO4TrI-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/9 19:38, kernel test robot wrote:
> Hi Miaohe,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on hnaz-mm/master]
> [also build test ERROR on linus/master v5.18-rc1 next-20220408]
> [cannot apply to linux/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/A-few-cleanup-and-fixup-patches-for-migration/20220409-154028
> base:   https://github.com/hnaz/linux-mm master
> config: powerpc64-randconfig-r015-20220408 (https://download.01.org/0day-ci/archive/20220409/202204091914.psVO4TrI-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/73a982570cc62313c55cc5cbc2dd7acf40601474
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Miaohe-Lin/A-few-cleanup-and-fixup-patches-for-migration/20220409-154028
>         git checkout 73a982570cc62313c55cc5cbc2dd7acf40601474
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Oh, powerpc variant is left undone. Will fix it. Thanks!

> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/mm/hugetlbpage.c: In function 'follow_huge_pd':
>>> arch/powerpc/mm/hugetlbpage.c:537:25: error: too few arguments to function '__migration_entry_wait'
>      537 |                         __migration_entry_wait(mm, ptep, ptl);
>          |                         ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from arch/powerpc/mm/hugetlbpage.c:20:
>    include/linux/swapops.h:233:13: note: declared here
>      233 | extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>          |             ^~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/__migration_entry_wait +537 arch/powerpc/mm/hugetlbpage.c
> 
> ^1da177e4c3f41 arch/ppc64/mm/hugetlbpage.c   Linus Torvalds   2005-04-16  507  
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  508  struct page *follow_huge_pd(struct vm_area_struct *vma,
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  509  			    unsigned long address, hugepd_t hpd,
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  510  			    int flags, int pdshift)
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  511  {
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  512  	pte_t *ptep;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  513  	spinlock_t *ptl;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  514  	struct page *page = NULL;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  515  	unsigned long mask;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  516  	int shift = hugepd_shift(hpd);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  517  	struct mm_struct *mm = vma->vm_mm;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  518  
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  519  retry:
> ed515b6898c367 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2018-06-01  520  	/*
> ed515b6898c367 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2018-06-01  521  	 * hugepage directory entries are protected by mm->page_table_lock
> ed515b6898c367 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2018-06-01  522  	 * Use this instead of huge_pte_lockptr
> ed515b6898c367 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2018-06-01  523  	 */
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  524  	ptl = &mm->page_table_lock;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  525  	spin_lock(ptl);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  526  
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  527  	ptep = hugepte_offset(hpd, address, pdshift);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  528  	if (pte_present(*ptep)) {
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  529  		mask = (1UL << shift) - 1;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  530  		page = pte_page(*ptep);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  531  		page += ((address & mask) >> PAGE_SHIFT);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  532  		if (flags & FOLL_GET)
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  533  			get_page(page);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  534  	} else {
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  535  		if (is_hugetlb_entry_migration(*ptep)) {
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  536  			spin_unlock(ptl);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06 @537  			__migration_entry_wait(mm, ptep, ptl);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  538  			goto retry;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  539  		}
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  540  	}
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  541  	spin_unlock(ptl);
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  542  	return page;
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  543  }
> 50791e6de0b5f2 arch/powerpc/mm/hugetlbpage.c Aneesh Kumar K.V 2017-07-06  544  
> 

