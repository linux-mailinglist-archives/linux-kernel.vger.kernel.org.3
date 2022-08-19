Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67885995A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346888AbiHSG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbiHSG7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:59:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF11F2EB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:58:57 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8CDK6D5pzXdtL;
        Fri, 19 Aug 2022 14:54:41 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 14:58:54 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 14:58:53 +0800
Subject: Re: [PATCH -next] bootmem: remove the vmemmap pages from kmemleak in
 free_bootmem_page
To:     Muchun Song <muchun.song@linux.dev>
References: <20220818132104.2144770-1-liushixin2@huawei.com>
 <8EC06FE1-3963-4F22-83DF-48B3EFAA62CA@linux.dev>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <688c930c-57aa-800b-57a5-fe7c8aacdbda@huawei.com>
Date:   Fri, 19 Aug 2022 14:58:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <8EC06FE1-3963-4F22-83DF-48B3EFAA62CA@linux.dev>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/19 11:31, Muchun Song wrote:
>
>> On Aug 18, 2022, at 21:21, Liu Shixin <liushixin2@huawei.com> wrote:
>>
>> The vmemmap pages is marked by kmemleak when allocated from memblock.
>> Remove it from kmemleak when free the page. Otherwise, when we reuse the
>> page, kmemleak may report such an error and then stop working.
>>
>> kmemleak: Cannot insert 0xffff98fb6eab3d40 into the object search tree (overlaps existing)
>> kmemleak: Kernel memory leak detector disabled
>> kmemleak: Object 0xffff98fb6be00000 (size 335544320):
>> kmemleak:   comm "swapper", pid 0, jiffies 4294892296
>> kmemleak:   min_count = 0
>> kmemleak:   count = 0
>> kmemleak:   flags = 0x1
>> kmemleak:   checksum = 0
>> kmemleak:   backtrace:
>>
>> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>> include/linux/bootmem_info.h | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
>> index cc35d010fa94..899bc56948f7 100644
>> --- a/include/linux/bootmem_info.h
>> +++ b/include/linux/bootmem_info.h
>> @@ -3,6 +3,7 @@
>> #define __LINUX_BOOTMEM_INFO_H
>>
>> #include <linux/mm.h>
>> +#include <linux/kmemleak.h>
>>
>> /*
>>  * Types for free bootmem stored in page->lru.next. These have to be in
>> @@ -38,9 +39,10 @@ static inline void free_bootmem_page(struct page *page)
>> 	 */
>> 	VM_BUG_ON_PAGE(page_ref_count(page) != 2, page);
> I am wondering if we should fix put_page_bootmem() instead of
> free_bootmem_page() since there are some users of put_page_bootmem()
> to free a page allocated from memblock which also can be reused
> afterwards.
>
> Thanks.
Thanks for your advise, it looks like that this problem may be occurs in memory hotremove too.
So it's more appropriate to fix put_page_bootmem()

Thanks,

>
>> -	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
>> +	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
>> +		kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
>> 		put_page_bootmem(page);
>> -	else
>> +	} else
>> 		VM_BUG_ON_PAGE(1, page);
>> }
>> #else
>> -- 
>> 2.25.1
>>
>>
> .
>

