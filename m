Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8A4B9D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiBQKo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:44:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiBQKoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:44:23 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE4293B76
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:44:08 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JzrtR3XpPz1FDJ3;
        Thu, 17 Feb 2022 18:39:43 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 18:44:05 +0800
Subject: Re: [PATCH] mm/slab_common: use helper function is_power_of_2()
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>
References: <20220217091609.8214-1-linmiaohe@huawei.com>
 <8f307e8a-5f97-cf5d-0a77-1c79b05abd60@suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5d904bee-3faf-374a-090c-ce7c99c84ea9@huawei.com>
Date:   Thu, 17 Feb 2022 18:44:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8f307e8a-5f97-cf5d-0a77-1c79b05abd60@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/17 17:23, Vlastimil Babka wrote:
> On 2/17/22 10:16, Miaohe Lin wrote:
>> Use helper function is_power_of_2() to check if KMALLOC_MIN_SIZE is power
>> of two. Minor readability improvement.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> We can try, but in case some compiler will no longer able to perform the
> check at build-time (although is_power_of_2() looks sufficiently trivial
> too), we'll have to revert it.

I see. I checked the compiler in my env but there might be some compilers can't
perform the check at build-time.

Many thanks for your reply.

> 
>> ---
>>  mm/slab_common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 23f2ab0713b7..6ee64d6208b3 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -807,7 +807,7 @@ void __init setup_kmalloc_cache_index_table(void)
>>  	unsigned int i;
>>  
>>  	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 256 ||
>> -		(KMALLOC_MIN_SIZE & (KMALLOC_MIN_SIZE - 1)));
>> +		!is_power_of_2(KMALLOC_MIN_SIZE));
>>  
>>  	for (i = 8; i < KMALLOC_MIN_SIZE; i += 8) {
>>  		unsigned int elem = size_index_elem(i);
> 
> .
> 

