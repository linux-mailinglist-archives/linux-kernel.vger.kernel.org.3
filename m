Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3450B5AF9C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIGCUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGCUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:20:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F353FA0E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:20:10 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMm8N2vTyzkYCZ;
        Wed,  7 Sep 2022 10:16:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 10:20:08 +0800
Subject: Re: [PATCH v2 2/4] mm/hwpoison: move definitions of
 num_poisoned_pages_* to memory-failure.c
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
 <20220905062137.1455537-3-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7f5a74ba-fc6d-2bb1-c886-8dcf4cbdf0e3@huawei.com>
Date:   Wed, 7 Sep 2022 10:20:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220905062137.1455537-3-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/5 14:21, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> These interfaces will be used by drivers/base/core.c by later patch, so as a
> preparatory work move them to more common header file visible to the file.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  arch/parisc/kernel/pdt.c |  3 +--
>  include/linux/mm.h       |  4 ++++
>  include/linux/swapops.h  | 25 -------------------------
>  mm/memory-failure.c      | 15 +++++++++++++++
>  4 files changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
> index e391b175f5ec..fdc880e2575a 100644
> --- a/arch/parisc/kernel/pdt.c
> +++ b/arch/parisc/kernel/pdt.c
> @@ -18,8 +18,7 @@
>  #include <linux/kthread.h>
>  #include <linux/initrd.h>
>  #include <linux/pgtable.h>
> -#include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/mm.h>
>  
>  #include <asm/pdc.h>
>  #include <asm/pdcpat.h>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 21f8b27bd9fd..b81dd600e51a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

It seems declaration of num_poisoned_pages_inc() is missing when CONFIG_MEMORY_FAILURE is defined?
Otherwise this patch looks good to me.

Thanks,
Miaohe Lin


> @@ -3202,6 +3202,10 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  {
>  	return 0;
>  }
> +
> +static inline void num_poisoned_pages_inc()
> +{
> +}
>  #endif
>  
>  #ifndef arch_memory_failure
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index ddc98f96ad2c..55afc2aaba6b 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -459,8 +459,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  
> -extern atomic_long_t num_poisoned_pages __read_mostly;
> -
>  /*
>   * Support for hardware poisoned pages
>   */
> @@ -488,21 +486,6 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
>  	return p;
>  }
>  
> -static inline void num_poisoned_pages_inc(void)
> -{
> -	atomic_long_inc(&num_poisoned_pages);
> -}
> -
> -static inline void num_poisoned_pages_dec(void)
> -{
> -	atomic_long_dec(&num_poisoned_pages);
> -}
> -
> -static inline void num_poisoned_pages_sub(long i)
> -{
> -	atomic_long_sub(i, &num_poisoned_pages);
> -}
> -
>  #else
>  
>  static inline swp_entry_t make_hwpoison_entry(struct page *page)
> @@ -519,14 +502,6 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
>  {
>  	return NULL;
>  }
> -
> -static inline void num_poisoned_pages_inc(void)
> -{
> -}
> -
> -static inline void num_poisoned_pages_sub(long i)
> -{
> -}
>  #endif
>  
>  static inline int non_swap_entry(swp_entry_t entry)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7b077da568ff..b6236c721f54 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -74,6 +74,21 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
>  static bool hw_memory_failure __read_mostly = false;
>  
> +static inline void num_poisoned_pages_inc(void)
> +{
> +	atomic_long_inc(&num_poisoned_pages);
> +}
> +
> +static inline void num_poisoned_pages_dec(void)
> +{
> +	atomic_long_dec(&num_poisoned_pages);
> +}
> +
> +static inline void num_poisoned_pages_sub(long i)
> +{
> +	atomic_long_sub(i, &num_poisoned_pages);
> +}
> +
>  /*
>   * Return values:
>   *   1:   the page is dissolved (if needed) and taken off from buddy,
> 

