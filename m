Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFF2584985
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiG2CCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG2CCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:02:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A362E78DF3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:02:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lv9gt3dSqz1M8Yb;
        Fri, 29 Jul 2022 09:59:54 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 10:02:48 +0800
Subject: Re: [RFC PATCH v4 7/8] hugetlb: create hugetlb_unmap_file_folio to
 unmap single file folio
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-8-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3557d5a9-231c-4007-3e7e-5a7bf34ecaa8@huawei.com>
Date:   Fri, 29 Jul 2022 10:02:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220706202347.95150-8-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 4:23, Mike Kravetz wrote:
> Create the new routine hugetlb_unmap_file_folio that will unmap a single
> file folio.  This is refactored code from hugetlb_vmdelete_list.  It is
> modified to do locking within the routine itself and check whether the
> page is mapped within a specific vma before unmapping.
> 
> This refactoring will be put to use and expanded upon in a subsequent
> patch adding vma specific locking.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 124 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 95 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 31bd4325fce5..0eac0ea2a245 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -396,6 +396,94 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
>  	return -EINVAL;
>  }
>  
> +/*
> + * Called with i_mmap_rwsem held for inode based vma maps.  This makes
> + * sure vma (and vm_mm) will not go away.  We also hold the hugetlb fault
> + * mutex for the page in the mapping.  So, we can not race with page being
> + * faulted into the vma.
> + */
> +static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
> +				unsigned long addr, struct page *page)
> +{
> +	pte_t *ptep, pte;
> +
> +	ptep = huge_pte_offset(vma->vm_mm, addr,
> +			huge_page_size(hstate_vma(vma)));
> +
> +	if (!ptep)
> +		return false;
> +
> +	pte = huge_ptep_get(ptep);
> +	if (huge_pte_none(pte) || !pte_present(pte))
> +		return false;
> +
> +	if (pte_page(pte) == page)
> +		return true;
> +
> +	return false;	/* WTH??? */

I'm sorry but what does WTH means? IIUC, this could happen if pte_page is a COW-ed private page?
vma_interval_tree_foreach doesn't exclude the private mapping even after cow?

Except from above (trivial one), this patch looks good to me.

Thanks.
