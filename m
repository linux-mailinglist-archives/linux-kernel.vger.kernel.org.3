Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7746543016
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiFHMRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbiFHMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:17:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5456420
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:17:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LJ5m24yFhzgYBN;
        Wed,  8 Jun 2022 20:15:46 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 20:17:35 +0800
Subject: Re: [PATCH] mm/page_alloc: make calling prep_compound_head more
 reliable
To:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20220607144157.36411-1-linmiaohe@huawei.com>
 <20220607113257.84b1bdd993f19be26b8c4944@linux-foundation.org>
 <65e5da9c-32d1-17d7-d8c6-96cbfac23fec@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4a30f026-789a-9235-2fbd-f553e4d7b45d@huawei.com>
Date:   Wed, 8 Jun 2022 20:17:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <65e5da9c-32d1-17d7-d8c6-96cbfac23fec@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/8 3:17, Joao Martins wrote:
> On 6/7/22 19:32, Andrew Morton wrote:
>>
>> Let's cc Joao.
>>
>> On Tue, 7 Jun 2022 22:41:57 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>>> compound_pincount_ptr is stored at first tail page instead of second tail
>>> page now.
>>
>> "now"?  Some identifiable commit did this?
>>
> 
> I think this was in:
> 
> commit5232c63f46fd ("mm: Make compound_pincount always available")

Thanks for identifying it.

> 
>>> And if it or some other field changes again in the future, data
>>> overwritten might happen. Calling prep_compound_head() outside the loop
>>> to prevent such possible issue. No functional change intended.
>>>
>>> ...
>>>
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -6772,17 +6772,8 @@ static void __ref memmap_init_compound(struct page *head,
>>>  		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>>  		prep_compound_tail(head, pfn - head_pfn);
>>>  		set_page_count(page, 0);
>>> -
>>> -		/*
>>> -		 * The first tail page stores compound_mapcount_ptr() and
>>> -		 * compound_order() and the second tail page stores
>>> -		 * compound_pincount_ptr(). Call prep_compound_head() after
>>> -		 * the first and second tail pages have been initialized to
>>> -		 * not have the data overwritten.
>>> -		 */
>>> -		if (pfn == head_pfn + 2)
>>> -			prep_compound_head(head, order);
>>>  	}
>>> +	prep_compound_head(head, order);
>>>  }
>>>  
>>>  void __ref memmap_init_zone_device(struct zone *zone,
>>
> 
> memmap_init_compound() is only called in pmem case.
> 
> The idea to make this /right after/ we initialize the offending tail pages has
> to do with @altmap case wheere struct pages are placed in PMEM and thus taking
> advantage of the likelyhood of those tail struct pages being cached given that
> we will read them right after in prep_compound_head().
> 
> I agree with the general sentiment of making this 'more resilient' to compound
> pages structure changes by moving prep_compound_head() after all tail pages are
> initialized, although I need to express a concern about this making altmap possibly
> being affected or regressed. Considering on 2M compound pages we will access first and
> second tail pages /after/ initializing 32768 struct pages, or after touching/initializing
> 256K struct pages.

Many thanks for your explanation. IIUC, the below change should be preferred?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4c7d99ee58b4..048df5d78add 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6771,13 +6771,18 @@ static void __ref memmap_init_compound(struct page *head,
                set_page_count(page, 0);

                /*
-                * The first tail page stores compound_mapcount_ptr() and
-                * compound_order() and the second tail page stores
-                * compound_pincount_ptr(). Call prep_compound_head() after
-                * the first and second tail pages have been initialized to
-                * not have the data overwritten.
+                * The first tail page stores compound_mapcount_ptr(),
+                * compound_order() and compound_pincount_ptr(). Call
+                * prep_compound_head() after the first tail page have
+                * been initialized to not have the data overwritten.
+                *
+                * Note the idea to make this right after we initialize
+                * the offending tail pages is trying to take advantage
+                * of the likelihood of those tail struct pages being
+                * cached given that we will read them right after in
+                * prep_compound_head().
                 */
-               if (pfn == head_pfn + 2)
+               if (unlikely(pfn == head_pfn + 1))
                        prep_compound_head(head, order);
        }
 }

Or am I miss something?

Thanks!

> .
> 
