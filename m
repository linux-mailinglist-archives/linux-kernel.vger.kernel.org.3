Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83F55A35C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiH0IHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 04:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiH0IHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:07:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B984A55AA
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:07:40 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MF8Qp5dnWzGprB;
        Sat, 27 Aug 2022 16:05:54 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 16:07:31 +0800
Subject: Re: [PATCH 5/8] hugetlb: rename vma_shareable() and refactor code
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-6-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <98db8106-77cf-291d-9642-e429b8b33160@huawei.com>
Date:   Sat, 27 Aug 2022 16:07:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220824175757.20590-6-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/25 1:57, Mike Kravetz wrote:
> Rename the routine vma_shareable to vma_addr_pmd_shareable as it is
> checking a specific address within the vma.  Refactor code to check if
> an aligned range is shareable as this will be needed in a subsequent
> patch.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

> ---
>  mm/hugetlb.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a6eb46c64baf..758b6844d566 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6648,26 +6648,33 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
>  	return saddr;
>  }
>  
> -static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> +static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
> +				unsigned long start, unsigned long end)
>  {
> -	unsigned long base = addr & PUD_MASK;
> -	unsigned long end = base + PUD_SIZE;
> -
>  	/*
>  	 * check on proper vm_flags and page table alignment
>  	 */
> -	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
> +	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, start, end))
>  		return true;
>  	return false;
>  }
>  
> +static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
> +						unsigned long addr)
> +{
> +	unsigned long start = addr & PUD_MASK;
> +	unsigned long end = start + PUD_SIZE;
> +
> +	return __vma_aligned_range_pmd_shareable(vma, start, end);
> +}
> +
>  bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
>  {
>  #ifdef CONFIG_USERFAULTFD
>  	if (uffd_disable_huge_pmd_share(vma))
>  		return false;
>  #endif
> -	return vma_shareable(vma, addr);
> +	return vma_addr_pmd_shareable(vma, addr);
>  }
>  
>  /*
> 

