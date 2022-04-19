Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AB5069CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348317AbiDSLXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiDSLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:23:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFAC2657
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:21:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjLpt61nYzCr6X;
        Tue, 19 Apr 2022 19:16:38 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 19:21:02 +0800
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <surenb@google.com>,
        <minchan@kernel.org>, <peterx@redhat.com>, <sfr@canb.auug.org.au>,
        <rcampbell@nvidia.com>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <b57fea1e-5c9b-f47e-f565-16b54f1e8782@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1b614ac3-02c0-ec66-b51a-e9b7e1a375ad@huawei.com>
Date:   Tue, 19 Apr 2022 19:21:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b57fea1e-5c9b-f47e-f565-16b54f1e8782@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/19 15:37, David Hildenbrand wrote:
> On 16.04.22 05:05, Miaohe Lin wrote:
>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>> page filled with random data is mapped into user address space. In case
>> of error, a special swap entry indicating swap read fails is set to the
>> page table. So the swapcache page can be freed and the user won't end up
>> with a permanently mounted swap because a sector is bad. And if the page
>> is accessed later, the user process will be killed so that corrupted data
>> is never consumed. On the other hand, if the page is never accessed, the
>> user won't even notice it.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>> v2:
>>   use special swap entry to avoid permanently mounted swap
>>   free the bad page in swapcache
>> ---
>>  include/linux/swap.h    |  7 ++++++-
>>  include/linux/swapops.h | 10 ++++++++++
>>  mm/memory.c             |  5 ++++-
>>  mm/swapfile.c           | 11 +++++++++++
>>  4 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index d112434f85df..03c576111737 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>>   * actions on faults.
>>   */
>>  
>> +#define SWAP_READ_ERROR_NUM 1
>> +#define SWAP_READ_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
>> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
>> +			     SWP_PTE_MARKER_NUM)
> 
> Does anything speak against reusing the hwpoison marker? At least from a
> program POV it's similar "the previously well defined content at this
> user space address is no longer readable/writable".

Looks like a good idea. :)

> 
> I recall that we can just set the pfn to 0 for the hwpoison marker.
> 
> There is e.g., check_hwpoisoned_entry() and it just stops if it finds
> "pfn=0".

Do you mean that we should set the pfn to 0 for the hwpoison marker so that we can
distinguish swapin error case from real hwpoison case?

> 
> 

Will try to do this in next version. Thanks a lot!
