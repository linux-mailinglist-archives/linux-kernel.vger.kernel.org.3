Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1FB50D6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbiDYCDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbiDYCCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:02:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A8C5DE67
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:59:40 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kmp6R2ShVzGpFF;
        Mon, 25 Apr 2022 09:57:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 09:59:37 +0800
Subject: Re: [PATCH v3 3/3] mm/madvise: free hwpoison and swapin error entry
 in madvise_free_pte_range
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "surenb@google.com" <surenb@google.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-4-linmiaohe@huawei.com>
 <20220424234128.GA3740950@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <66a3d738-9dcb-76d6-6507-abbb13569709@huawei.com>
Date:   Mon, 25 Apr 2022 09:59:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220424234128.GA3740950@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/25 7:41, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sun, Apr 24, 2022 at 05:11:05PM +0800, Miaohe Lin wrote:
>> Once the MADV_FREE operation has succeeded, callers can expect they might
>> get zero-fill pages if accessing the memory again. Therefore it should be
>> safe to delete the hwpoison entry and swapin error entry. There is no
>> reason to kill the process if it has called MADV_FREE on the range.
>>
>> Suggested-by: Alistair Popple <apopple@nvidia.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> I confirmed that hwpoison entry is properly removed with madvise(MADV_FREE)
> with this patch. This provides applications with the ability to recover from
> memory errors in simpler way (applications don't have to munmap then mmap again
> the error address). That's a good small improvement. Thank you.
> 
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Many thanks for your testing and review! :)

> 
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
>> -- 
>> 2.23.0

