Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F6759F399
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiHXG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiHXG1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:27:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410C8792EE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:27:29 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MCGHc2KljzXdxj;
        Wed, 24 Aug 2022 14:23:08 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 14:27:26 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 14:27:25 +0800
Subject: Re: [PATCH -next] bootmem: remove the vmemmap pages from kmemleak in
 free_bootmem_page
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20220818132104.2144770-1-liushixin2@huawei.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <ad8ddde7-6828-3af3-f162-cab29f38d044@huawei.com>
Date:   Wed, 24 Aug 2022 14:27:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220818132104.2144770-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch is superseded by latter patch so don't merge it in next. Just the latter is fine.

Thanks,

https://lore.kernel.org/all/20220819094005.2928241-1-liushixin2@huawei.com/T/#u


On 2022/8/18 21:21, Liu Shixin wrote:
> The vmemmap pages is marked by kmemleak when allocated from memblock.
> Remove it from kmemleak when free the page. Otherwise, when we reuse the
> page, kmemleak may report such an error and then stop working.
>
>  kmemleak: Cannot insert 0xffff98fb6eab3d40 into the object search tree (overlaps existing)
>  kmemleak: Kernel memory leak detector disabled
>  kmemleak: Object 0xffff98fb6be00000 (size 335544320):
>  kmemleak:   comm "swapper", pid 0, jiffies 4294892296
>  kmemleak:   min_count = 0
>  kmemleak:   count = 0
>  kmemleak:   flags = 0x1
>  kmemleak:   checksum = 0
>  kmemleak:   backtrace:
>
> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  include/linux/bootmem_info.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> index cc35d010fa94..899bc56948f7 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_BOOTMEM_INFO_H
>  
>  #include <linux/mm.h>
> +#include <linux/kmemleak.h>
>  
>  /*
>   * Types for free bootmem stored in page->lru.next. These have to be in
> @@ -38,9 +39,10 @@ static inline void free_bootmem_page(struct page *page)
>  	 */
>  	VM_BUG_ON_PAGE(page_ref_count(page) != 2, page);
>  
> -	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> +	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
> +		kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
>  		put_page_bootmem(page);
> -	else
> +	} else
>  		VM_BUG_ON_PAGE(1, page);
>  }
>  #else

