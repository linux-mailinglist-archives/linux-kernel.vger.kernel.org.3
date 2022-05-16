Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FBE527BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbiEPCAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiEPCAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:00:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA32D12768
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:00:46 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L1j5N2m5zzCsmV;
        Mon, 16 May 2022 09:55:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 10:00:44 +0800
Subject: Re: [PATCH 06/15] mm/swap: remove buggy cache->nr check in
 refill_swap_slots_cache
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <surenb@google.com>,
        <peterx@redhat.com>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-7-linmiaohe@huawei.com>
 <fd5c6a00-ea0e-b5d8-999f-d7b65c193ae4@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8b03aa8a-5023-6915-64c6-f6f298f19f36@huawei.com>
Date:   Mon, 16 May 2022 10:00:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <fd5c6a00-ea0e-b5d8-999f-d7b65c193ae4@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 21:37, David Hildenbrand wrote:
> On 09.05.22 15:14, Miaohe Lin wrote:
>> refill_swap_slots_cache is always called when cache->nr is 0. And if
>> cache->nr != 0, we should return cache->nr instead of 0. So remove
>> such buggy and confusing check.
> 
> Not sure about the "cache->nr != 0, we should return cache->nr instead
> of 0" part, I'd just drop that from the patch description. We'd actually
> end up overwriting cache->nr after your change, which doesn't sound
> right and also different to what you describe here.

Will do.

> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/swap_slots.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
>> index 2f877e6f87d7..2a65a89b5b4d 100644
>> --- a/mm/swap_slots.c
>> +++ b/mm/swap_slots.c
>> @@ -258,7 +258,7 @@ void enable_swap_slots_cache(void)
>>  /* called with swap slot cache's alloc lock held */
>>  static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>>  {
>> -	if (!use_swap_slot_cache || cache->nr)
>> +	if (!use_swap_slot_cache)
>>  		return 0;
>>  
>>  	cache->cur = 0;
> 
> I feel like if this function would be called with cache->nr, it would be
> a BUG. So I'm fine with removing it, but we could also think about
> turning it into some sort of WARN/BG to make it clearer that this is
> unexpected.

Since refill_swap_slots_cache is only called by folio_alloc_swap when cache->nr == 0. I think
it might be too overkill to add a WARN/BG.

> 
> 
> Anyhow,
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Many thanks for comment and Acked-by tag!

> 

