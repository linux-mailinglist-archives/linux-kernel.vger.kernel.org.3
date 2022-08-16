Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8465952A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiHPGiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiHPGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:37:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EBC2AA0B9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 20:27:11 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6Gjk5B9kzmVqk;
        Tue, 16 Aug 2022 11:24:58 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 11:27:09 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 11:27:08 +0800
Message-ID: <09129cd3-7363-3079-bd57-dde9c73684f1@huawei.com>
Date:   Tue, 16 Aug 2022 11:27:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <willy@infradead.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable 4.14,4.19 1/1] mm: Fix page counter mismatch in
 shmem_mfill_atomic_pte
Content-Language: en-US
To:     <rppt@linux.vnet.ibm.com>, <hughd@google.com>,
        <aarcange@redhat.com>, <hannes@cmpxchg.org>
References: <20220802013251.3022141-1-mawupeng1@huawei.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20220802013251.3022141-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Greg

On 2022/8/2 9:32, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> shmem_mfill_atomic_pte() wrongly called mem_cgroup_cancel_charge() in "success"
> path, it should mem_cgroup_uncharge() to dec memory counter instead.
> mem_cgroup_cancel_charge() should only be used if this transaction is
> unsuccessful and mem_cgroup_uncharge() is used to do this if this transaction
> succeed.
> 
> This will lead to page->memcg not null and will uncharge one more in put_page().
> The page counter will underflow to maximum value and trigger oom to kill all
> process include sshd and leave system unaccessible.
> 
> page->memcg is set in the following path:
> mem_cgroup_commit_charge
> 	commit_charge
> 		page->mem_cgroup = memcg;
> 
> extra uncharge will be done in the following path:
> put_page
> 	__put_page
> 		__put_single_page
> 			mem_cgroup_uncharge
> 				if (!page->mem_cgroup) <-- should return here
> 					return
> 				uncharge_page
> 				uncharge_batch
> 
> To fix this, call mem_cgroup_commit_charge() at the end of this transaction to
> make sure this transaction is really finished.
> 
> Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  mm/shmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0788616696dc..0b06724c189e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2339,8 +2339,6 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	if (ret)
>  		goto out_release_uncharge;
>  
> -	mem_cgroup_commit_charge(page, memcg, false, false);
> -
>  	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
>  	if (dst_vma->vm_flags & VM_WRITE)
>  		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
> @@ -2366,6 +2364,8 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	if (!pte_none(*dst_pte))
>  		goto out_release_uncharge_unlock;
>  
> +	mem_cgroup_commit_charge(page, memcg, false, false);
> +
>  	lru_cache_add_anon(page);
>  
>  	spin_lock_irq(&info->lock);
