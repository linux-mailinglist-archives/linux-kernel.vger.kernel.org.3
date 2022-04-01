Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E64EE812
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbiDAGQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiDAGQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:16:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021271350B7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:14:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KV8yZ2xRnz1HBL5;
        Fri,  1 Apr 2022 14:14:30 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 14:14:49 +0800
Subject: Re: [PATCH 5/8] mm/vmscan: use helper folio_is_file_lru()
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Wu Fengguang <wfg@mail.ustc.edu.cn>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-6-linmiaohe@huawei.com>
 <87y20pa3r6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <191fa86c-2548-d136-19f5-3e0a744b6da9@huawei.com>
Date:   Fri, 1 Apr 2022 14:14:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87y20pa3r6.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/1 11:20, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> Use helper folio_is_file_lru() to check whether folio is file lru. Minor
>> readability improvement.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index ebd8ffb63673..31e95d627448 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1411,14 +1411,14 @@ static enum page_references folio_check_references(struct folio *folio,
>>  		/*
>>  		 * Activate file-backed executable folios after first usage.
>>  		 */
>> -		if ((vm_flags & VM_EXEC) && !folio_test_swapbacked(folio))
>> +		if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio))
> 
> I think that this should be converted to
> 
> 		if ((vm_flags & VM_EXEC)))
> 
> We should activate swap-backed executable folios (e.g. tmpfs) after
> first usage too.
> 

Dig into the git history, we can found that commit c909e99364c8 ("vmscan: activate executable pages after first usage")
activate swap-backed executable folios after first usage too. But later swap-backed executable folios is not activated
via commit b518154e59aa ("mm/vmscan: protect the workingset on anonymous LRU") to pretect the workingset from anonymous
LRU. So above change might not be wanted. Or am I miss something?

Many thanks.

> Best Regards,
> Huang, Ying
> 
>>  			return PAGEREF_ACTIVATE;
>>  
>>  		return PAGEREF_KEEP;
>>  	}
>>  
>>  	/* Reclaim if clean, defer dirty folios to writeback */
>> -	if (referenced_folio && !folio_test_swapbacked(folio))
>> +	if (referenced_folio && folio_is_file_lru(folio))
>>  		return PAGEREF_RECLAIM_CLEAN;
>>  
>>  	return PAGEREF_RECLAIM;
> .
> 

