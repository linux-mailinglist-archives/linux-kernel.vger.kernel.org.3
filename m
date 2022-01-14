Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEA448E2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbiAND3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:29:39 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34907 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiAND3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:29:37 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZmx32pjVzccXN;
        Fri, 14 Jan 2022 11:28:55 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 11:29:35 +0800
Received: from [10.174.185.129] (10.174.185.129) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 11:29:35 +0800
Message-ID: <879998b7-d711-895f-935a-9c6654484b6e@huawei.com>
Date:   Fri, 14 Jan 2022 11:29:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "zhangliang (AG)" <zhangliang5@huawei.com>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangzhigang17@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, <zhangliang5@huawei.com>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <YeA5oP/iaxtVPHb3@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your reply, Matthew Wilcox.

On 2022/1/13 22:39, Matthew Wilcox wrote:
> On Thu, Jan 13, 2022 at 10:03:18PM +0800, Liang Zhang wrote:
>> In current implementation, process's read requestions will fault in pages
>> with WP flags in PTEs. Next, if process emit a write requestion will go
>> into do_wp_page() and copy data to a new allocated page from the old one
>> due to refcount > 1 (page table mapped and swapcache), which could be
>> result in performance degradation. In fact, this page is exclusively owned
>> by this process and the duplication from old to a new allocated page is
>> really unnecessary.
>>
>> So In this situation, these unshared pages can be reused by its process.
> 
> Let's bring Linus in on this, but I think this reintroduces all of the
> mapcount problems that we've been discussing recently.
> 
> How about this as an alternative?
> 
> +++ b/mm/memory.c
> @@ -3291,11 +3291,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>                 struct page *page = vmf->page;
> 
>                 /* PageKsm() doesn't necessarily raise the page refcount */
> -               if (PageKsm(page) || page_count(page) != 1)
> +               if (PageKsm(page) || page_count(page) != 1 + PageSwapCache(page))

I don't think the only PageSwapCache() check can replace reuse_swap_page(), since 
the latter also includes a very important check -- stable page requirement, 
see Fixes: f05714293a59 (mm: support anonymous stable page) . Without this additional check, 
e.g. page is writebacking by zram under us, at this moment we make this page R/W to its 
process which may change memory content right now will trigger BUG.

>                         goto copy;
>                 if (!trylock_page(page))
>                         goto copy;
> -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1 + PageSwapCache(page)) {
>                         unlock_page(page);
>                         goto copy;
>                 }
> 
> 
>> Signed-off-by: Liang Zhang <zhangliang5@huawei.com>
>> ---
>> This patch has been tested with redis benchmark. Here is the test
>> result.
>>
>> Hardware
>> ========
>> Memory (GB): 512G
>> CPU (total #): 88
>> NVMe SSD (GB): 1024
>>
>> OS
>> ==
>> kernel 5.10.0
>>
>> Testcase
>> ========
>> step 1:
>>   Run 16 VMs (4U8G), each running with redis-server, in a cgroup 
>>   limiting memory.limit_in_bytes to 100G. 
>> step 2:
>>   Run memtier_bemchmark in host with params "--threads=1 --clients=1 \
>> --pipeline=256 --data-size=2048 --requests=allkeys --key-minimum=1 \
>> --key-maximum=30000000 --key-prefix=memtier-benchmark-prefix-redistests"
>>   to test every VM concurrently.
>>
>> Workset size
>> ============
>> cat memory.memsw.usage_in_bytes
>> 125403303936
>>
>> Result
>> ======
>> Comparing with Baseline, this patch can achieved 41% more Ops/sec, 
>> 41% more Hits/sec, 41% more Misses/sec, 30% less Latency and 
>> 41% more KB/sec. 
>>
>>   Index(average)        Baseline kernel        Patched kernel
>>   Ops/sec               109497                 155428
>>   Hits/sec              8653                   12283
>>   Misses/sec            90889                  129014
>>   Latency               2.297                  1.603
>>   KB/sec                44569                  63186
>>
>>
>>  mm/memory.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 23f2f1300d42..fd4d868b1c2d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3291,10 +3291,16 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>  		struct page *page = vmf->page;
>>  
>>  		/* PageKsm() doesn't necessarily raise the page refcount */
>> -		if (PageKsm(page) || page_count(page) != 1)
>> +		if (PageKsm(page))
>>  			goto copy;
>>  		if (!trylock_page(page))
>>  			goto copy;
>> +
>> +		/* reuse the unshared swapcache page */
>> +		if (PageSwapCache(page) && reuse_swap_page(page, NULL)) {
>> +			goto reuse;
>> +		}
>> >>  		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
>>  			unlock_page(page);
>>  			goto copy;
>> @@ -3304,6 +3310,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>  		 * page count reference, and the page is locked,
>>  		 * it's dark out, and we're wearing sunglasses. Hit it.
>>  		 */
>> +reuse:
>>  		unlock_page(page);
>>  		wp_page_reuse(vmf);
>>  		return VM_FAULT_WRITE;
>> -- 
>> 2.30.0
>>
>>
> .

-- 
Best Regards,
Liang Zhang
