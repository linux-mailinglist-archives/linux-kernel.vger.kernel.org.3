Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189D4520B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiEJCZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiEJCZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:25:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BC590BB
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:21:24 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ky1x33jL3zhYym;
        Tue, 10 May 2022 10:20:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 10:21:21 +0800
Subject: Re: [PATCH 09/15] mm/swap: avoid calling swp_swap_info when try to
 check SWP_STABLE_WRITES
To:     NeilBrown <neilb@suse.de>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-10-linmiaohe@huawei.com>
 <165214248406.14782.6536817483979050668@noble.neil.brown.name>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d674bc33-fcf2-ebc1-b252-1e7232b3bd1c@huawei.com>
Date:   Tue, 10 May 2022 10:21:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <165214248406.14782.6536817483979050668@noble.neil.brown.name>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/5/10 8:28, NeilBrown wrote:
> On Mon, 09 May 2022, Miaohe Lin wrote:
>> Use flags of si directly to check SWP_STABLE_WRITES to avoid possible
>> READ_ONCE and thus save some cpu cycles.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 9c3e7e6ac202..89dd15504f3d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3892,7 +3892,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>  			 */
>>  			exclusive = true;
>>  		} else if (exclusive && PageWriteback(page) &&
>> -			  (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
>> +			  (si->flags & SWP_STABLE_WRITES)) {
> 
> Should this have a data_race() annotation.  Other bit-tests of si->flags
> do because scan_swap_map_slots can update it asynchronously, but we know
> that won't matter in practice.

Yes, you're right. scan_swap_map_slots can update si->flags asynchronously while
do_swap_page tests SWP_STABLE_WRITES here. We know this is harmless because
SWP_STABLE_WRITES is only changed at swapon/swapoff.

Will add data_race() annotation in next version to avoid possible KCSAN data-race complaint.

Many thanks for pointing this out! :)

> 
> Thanks,
> NeilBrown
> 
> 
>>  			/*
>>  			 * This is tricky: not all swap backends support
>>  			 * concurrent page modifications while under writeback.
>> -- 
>> 2.23.0
>>
>>
> .
> 

