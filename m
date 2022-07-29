Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0015849F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiG2CzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG2CzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:55:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2ACDF56
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:55:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvBsd0nvlzmVNx;
        Fri, 29 Jul 2022 10:53:25 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 10:55:15 +0800
Subject: Re: [RFC PATCH v4 6/8] hugetlb: add vma based lock for pmd sharing
 synchronization
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
 <20220706202347.95150-7-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5b8c6b49-e17a-2c0b-4440-ccf3c5493cb2@huawei.com>
Date:   Fri, 29 Jul 2022 10:55:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220706202347.95150-7-mike.kravetz@oracle.com>
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
> Allocate a rw semaphore and hang off vm_private_data for
> synchronization use by vmas that could be involved in pmd sharing.  Only
> add infrastructure for the new lock here.  Actual use will be added in
> subsequent patch.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/hugetlb.h |  36 +++++++++-
>  kernel/fork.c           |   6 +-
>  mm/hugetlb.c            | 150 ++++++++++++++++++++++++++++++++++++----
>  mm/rmap.c               |   8 ++-
>  4 files changed, 178 insertions(+), 22 deletions(-)
> 

<snip>

>  
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
> +static bool vma_pmd_shareable(struct vm_area_struct *vma);
>  
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
> @@ -904,6 +905,89 @@ resv_map_set_hugetlb_cgroup_uncharge_info(struct resv_map *resv_map,
>  #endif
>  }
>  
> +static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&

Should me make __vma_aligned_range_pmd_shareable check (VM_MAYSHARE | VM_SHARED) like above
instead of VM_MAYSHARE to make code more consistent?

> +		vma->vm_private_data;
> +}
> +
> +void hugetlb_vma_lock_read(struct vm_area_struct *vma)
> +{
> +	if (__vma_shareable_flags_pmd(vma))
> +		down_read((struct rw_semaphore *)vma->vm_private_data);
> +}
> +
> +void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
> +{
> +	if (__vma_shareable_flags_pmd(vma))
> +		up_read((struct rw_semaphore *)vma->vm_private_data);
> +}
> +
> +void hugetlb_vma_lock_write(struct vm_area_struct *vma)
> +{
> +	if (__vma_shareable_flags_pmd(vma))
> +		down_write((struct rw_semaphore *)vma->vm_private_data);
> +}
> +
> +void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
> +{
> +	if (__vma_shareable_flags_pmd(vma))
> +		up_write((struct rw_semaphore *)vma->vm_private_data);
> +}
> +
> +int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
> +{
> +	if (!__vma_shareable_flags_pmd(vma))
> +		return 1;
> +
> +	return down_write_trylock((struct rw_semaphore *)vma->vm_private_data);
> +}
> +
> +void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
> +{
> +	if (__vma_shareable_flags_pmd(vma))
> +		lockdep_assert_held((struct rw_semaphore *)
> +				vma->vm_private_data);
> +}
> +
> +static void hugetlb_free_vma_lock(struct vm_area_struct *vma)
> +{
> +	/* Only present in sharable vmas */
> +	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
> +		return;
> +
> +	if (vma->vm_private_data) {
> +		kfree(vma->vm_private_data);
> +		vma->vm_private_data = NULL;
> +	}
> +}
> +
> +static void hugetlb_alloc_vma_lock(struct vm_area_struct *vma)
> +{
> +	struct rw_semaphore *vma_sema;
> +
> +	/* Only establish in (flags) sharable vmas */
> +	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
> +		return;
> +> +	if (!vma_pmd_shareable(vma)) {
> +		vma->vm_private_data = NULL;
> +		return;
> +	}
> +
> +	vma_sema = kmalloc(sizeof(*vma_sema), GFP_KERNEL);
> +	if (!vma_sema) {
> +		/*
> +		 * If we can not allocate semaphore, then vma can not
> +		 * participate in pmd sharing.
> +		 */
> +		vma->vm_private_data = NULL;
> +	} else {
> +		init_rwsem(vma_sema);
> +		vma->vm_private_data = vma_sema;
> +	}

This code is really subtle. If it's called from hugetlb_vm_op_open during fork after
hugetlb_dup_vma_private is done, there should already be a kmalloc-ed vma_sema for this
vma (because hugetlb_alloc_vma_lock is also called by hugetlb_dup_vma_private). So we
can't simply change the value of vm_private_data here or vma_sema will be leaked ? But
when hugetlb_alloc_vma_lock is called from hugetlb_reserve_pages, it should work fine.
Or am I miss something?

Thanks.
