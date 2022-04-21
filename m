Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057F550A10A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiDUNre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386738AbiDUNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:47:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69837377ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:44:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kkdvd4yMdzCrZJ;
        Thu, 21 Apr 2022 21:40:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 21:44:39 +0800
Subject: Re: [PATCH v2 3/3] mm/madvise: free hwpoison and swapin error entry
 in madvise_free_pte_range
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <surenb@google.com>,
        <minchan@kernel.org>, <peterx@redhat.com>, <sfr@canb.auug.org.au>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220421125348.62483-1-linmiaohe@huawei.com>
 <20220421125348.62483-4-linmiaohe@huawei.com>
 <0a793d7c-0591-28bc-5c36-a908c9d4900d@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ce220429-48bb-d1fd-05bd-223c6d4a2084@huawei.com>
Date:   Thu, 21 Apr 2022 21:44:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0a793d7c-0591-28bc-5c36-a908c9d4900d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/21 21:25, David Hildenbrand wrote:
> On 21.04.22 14:53, Miaohe Lin wrote:
>> Once the MADV_FREE operation has succeeded, callers can expect they might
>> get zero-fill pages if accessing the memory again. Therefore it should be
>> safe to delete the hwpoison entry and swapin error entry. There is no
>> reason to kill the process if it has called MADV_FREE on the range.
>>
>> Suggested-by: Alistair Popple <apopple@nvidia.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/madvise.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 4d6592488b51..5f4537511532 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -624,11 +624,14 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>  			swp_entry_t entry;
>>  
>>  			entry = pte_to_swp_entry(ptent);
>> -			if (non_swap_entry(entry))
>> -				continue;
>> -			nr_swap--;
>> -			free_swap_and_cache(entry);
>> -			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>> +			if (!non_swap_entry(entry)) {
>> +				nr_swap--;
>> +				free_swap_and_cache(entry);
>> +				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>> +			} else if (is_hwpoison_entry(entry) ||
>> +				   is_swapin_error_entry(entry)) {
>> +				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>> +			}
>>  			continue;
>>  		}
>>  
> 
> Reading the man page that should be fine, but might not be required.
> 
> "[...] the kernel can free the pages at any time. Once pages in the
> range have been freed, the caller will see zero-fill-on-demand pages
> upon subsequent page references."

Yes, this part is not mentioned in the man page.

> 
> 
> LGTM
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Many thanks for your quick respond and review!
