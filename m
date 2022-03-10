Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41584D3EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiCJBpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiCJBpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:45:00 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E075C366
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:43:59 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KDWyy1n01zfYqd;
        Thu, 10 Mar 2022 09:42:34 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 09:43:57 +0800
Received: from [10.174.179.19] (10.174.179.19) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 09:43:56 +0800
Message-ID: <385d153f-b3e7-5b2f-a1b1-e777d0b8fd2f@huawei.com>
Date:   Thu, 10 Mar 2022 09:43:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/2] kfence: Alloc kfence_pool after system startup
Content-Language: en-US
To:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220307074516.6920-1-dtcccc@linux.alibaba.com>
 <20220307074516.6920-3-dtcccc@linux.alibaba.com>
From:   "liupeng (DM)" <liupeng256@huawei.com>
In-Reply-To: <20220307074516.6920-3-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/7 15:45, Tianchen Ding wrote:
> Allow enabling KFENCE after system startup by allocating its pool via the
> page allocator. This provides the flexibility to enable KFENCE even if it
> wasn't enabled at boot time.
>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Tested-by: Peng Liu <liupeng256@huawei.com>
> ---
>   mm/kfence/core.c | 111 ++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 90 insertions(+), 21 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index caa4e84c8b79..f126b53b9b85 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -96,7 +96,7 @@ static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
>   module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
>   
>   /* The pool of pages used for guard pages and objects. */
> -char *__kfence_pool __ro_after_init;
> +char *__kfence_pool __read_mostly;
>   EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
>   
>   /*
> @@ -537,17 +537,19 @@ static void rcu_guarded_free(struct rcu_head *h)
>   	kfence_guarded_free((void *)meta->addr, meta, false);
>   }
>   
> -static bool __init kfence_init_pool(void)
> +/*
> + * Initialization of the KFENCE pool after its allocation.
> + * Returns 0 on success; otherwise returns the address up to
> + * which partial initialization succeeded.
> + */
> +static unsigned long kfence_init_pool(void)
>   {
>   	unsigned long addr = (unsigned long)__kfence_pool;
>   	struct page *pages;
>   	int i;
>   
> -	if (!__kfence_pool)
> -		return false;
> -
>   	if (!arch_kfence_init_pool())
> -		goto err;
> +		return addr;
>   
>   	pages = virt_to_page(addr);
>   
> @@ -565,7 +567,7 @@ static bool __init kfence_init_pool(void)
>   
>   		/* Verify we do not have a compound head page. */
>   		if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
> -			goto err;
> +			return addr;
>   
>   		__SetPageSlab(&pages[i]);
>   	}
> @@ -578,7 +580,7 @@ static bool __init kfence_init_pool(void)
>   	 */
>   	for (i = 0; i < 2; i++) {
>   		if (unlikely(!kfence_protect(addr)))
> -			goto err;
> +			return addr;
>   
>   		addr += PAGE_SIZE;
>   	}
> @@ -595,7 +597,7 @@ static bool __init kfence_init_pool(void)
>   
>   		/* Protect the right redzone. */
>   		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
> -			goto err;
> +			return addr;
>   
>   		addr += 2 * PAGE_SIZE;
>   	}
> @@ -608,9 +610,21 @@ static bool __init kfence_init_pool(void)
>   	 */
>   	kmemleak_free(__kfence_pool);
>   
> -	return true;
> +	return 0;
> +}
> +
> +static bool __init kfence_init_pool_early(void)
> +{
> +	unsigned long addr;
> +
> +	if (!__kfence_pool)
> +		return false;
> +
> +	addr = kfence_init_pool();
> +
> +	if (!addr)
> +		return true;
>   
> -err:
>   	/*
>   	 * Only release unprotected pages, and do not try to go back and change
>   	 * page attributes due to risk of failing to do so as well. If changing
> @@ -623,6 +637,26 @@ static bool __init kfence_init_pool(void)
>   	return false;
>   }
>   
> +static bool kfence_init_pool_late(void)
> +{
> +	unsigned long addr, free_size;
> +
> +	addr = kfence_init_pool();
> +
> +	if (!addr)
> +		return true;
> +
> +	/* Same as above. */
> +	free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
> +#ifdef CONFIG_CONTIG_ALLOC
> +	free_contig_range(page_to_pfn(virt_to_page(addr)), free_size / PAGE_SIZE);
> +#else
> +	free_pages_exact((void *)addr, free_size);
> +#endif
> +	__kfence_pool = NULL;
> +	return false;
> +}
> +
>   /* === DebugFS Interface ==================================================== */
>   
>   static int stats_show(struct seq_file *seq, void *v)
> @@ -771,31 +805,66 @@ void __init kfence_alloc_pool(void)
>   		pr_err("failed to allocate pool\n");
>   }
>   
> +static void kfence_init_enable(void)
> +{
> +	if (!IS_ENABLED(CONFIG_KFENCE_STATIC_KEYS))
> +		static_branch_enable(&kfence_allocation_key);
> +	WRITE_ONCE(kfence_enabled, true);
> +	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> +	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
> +		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
> +		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
> +}
> +
>   void __init kfence_init(void)
>   {
> +	stack_hash_seed = (u32)random_get_entropy();
> +
>   	/* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
>   	if (!kfence_sample_interval)
>   		return;
>   
> -	stack_hash_seed = (u32)random_get_entropy();
> -	if (!kfence_init_pool()) {
> +	if (!kfence_init_pool_early()) {
>   		pr_err("%s failed\n", __func__);
>   		return;
>   	}
>   
> -	if (!IS_ENABLED(CONFIG_KFENCE_STATIC_KEYS))
> -		static_branch_enable(&kfence_allocation_key);
> -	WRITE_ONCE(kfence_enabled, true);
> -	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> -	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
> -		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
> -		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
> +	kfence_init_enable();
> +}
> +
> +static int kfence_init_late(void)
> +{
> +	const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
> +#ifdef CONFIG_CONTIG_ALLOC
> +	struct page *pages;
> +
> +	pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
> +	if (!pages)
> +		return -ENOMEM;
> +	__kfence_pool = page_to_virt(pages);
> +#else
> +	if (nr_pages > MAX_ORDER_NR_PAGES) {
> +		pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
> +		return -EINVAL;
> +	}
> +	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
> +	if (!__kfence_pool)
> +		return -ENOMEM;
> +#endif
> +
> +	if (!kfence_init_pool_late()) {
> +		pr_err("%s failed\n", __func__);
> +		return -EBUSY;
> +	}
> +
> +	kfence_init_enable();
> +	return 0;
>   }
>   
>   static int kfence_enable_late(void)
>   {
>   	if (!__kfence_pool)
> -		return -EINVAL;
> +		return kfence_init_late();
>   
>   	WRITE_ONCE(kfence_enabled, true);
>   	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
