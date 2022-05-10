Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FE520AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiEJCHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiEJCHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:07:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB30282452
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:03:21 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ky1X30h4dzhYxZ;
        Tue, 10 May 2022 10:02:43 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 10:03:19 +0800
Subject: Re: [PATCH 11/15] mm/swap: add helper swap_offset_available()
To:     NeilBrown <neilb@suse.de>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-12-linmiaohe@huawei.com>
 <165214355418.14782.13896859043718755300@noble.neil.brown.name>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9319a62b-f43d-8ee9-77b9-a1afee7dbc10@huawei.com>
Date:   Tue, 10 May 2022 10:03:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <165214355418.14782.13896859043718755300@noble.neil.brown.name>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/10 8:45, NeilBrown wrote:
> On Mon, 09 May 2022, Miaohe Lin wrote:
>> Add helper swap_offset_available() to remove some duplicated codes.
>> Minor readability improvement.
> 
> I don't think that putting the spin_lock() inside the inline helper is
> good for readability.
> If the function was called
>    swap_offset_available_and_locked()

Yes, swap_offset_available_and_locked should be more suitable as we do the spin_lock
inside it. Will do this in next version.

Thanks!

> 
> it might be ok.  Otherwise I would rather the spin_lock() was called
> when the function returned true.
> 
> Thanks,
> NeilBrown
> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/swapfile.c | 33 +++++++++++++++++----------------
>>  1 file changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index c90298a0561a..d5d3e2d03d28 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -776,6 +776,21 @@ static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
>>  	this_cpu_write(*si->cluster_next_cpu, next);
>>  }
>>  
>> +static inline bool swap_offset_available(struct swap_info_struct *si, unsigned long offset)
>> +{
>> +	if (data_race(!si->swap_map[offset])) {
>> +		spin_lock(&si->lock);
>> +		return true;
>> +	}
>> +
>> +	if (vm_swap_full() && READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
>> +		spin_lock(&si->lock);
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  static int scan_swap_map_slots(struct swap_info_struct *si,
>>  			       unsigned char usage, int nr,
>>  			       swp_entry_t slots[])
>> @@ -953,15 +968,8 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>  scan:
>>  	spin_unlock(&si->lock);
>>  	while (++offset <= READ_ONCE(si->highest_bit)) {
>> -		if (data_race(!si->swap_map[offset])) {
>> -			spin_lock(&si->lock);
>> +		if (swap_offset_available(si, offset))
>>  			goto checks;
>> -		}
>> -		if (vm_swap_full() &&
>> -		    READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
>> -			spin_lock(&si->lock);
>> -			goto checks;
>> -		}
>>  		if (unlikely(--latency_ration < 0)) {
>>  			cond_resched();
>>  			latency_ration = LATENCY_LIMIT;
>> @@ -970,15 +978,8 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>  	}
>>  	offset = si->lowest_bit;
>>  	while (offset < scan_base) {
>> -		if (data_race(!si->swap_map[offset])) {
>> -			spin_lock(&si->lock);
>> +		if (swap_offset_available(si, offset))
>>  			goto checks;
>> -		}
>> -		if (vm_swap_full() &&
>> -		    READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
>> -			spin_lock(&si->lock);
>> -			goto checks;
>> -		}
>>  		if (unlikely(--latency_ration < 0)) {
>>  			cond_resched();
>>  			latency_ration = LATENCY_LIMIT;
>> -- 
>> 2.23.0
>>
>>
> .
> 

