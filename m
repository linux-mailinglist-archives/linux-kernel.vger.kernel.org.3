Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59D14EB7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbiC3Bsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiC3Bsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:48:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFF13DD4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:47:01 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSq4H1hfDzDq5k;
        Wed, 30 Mar 2022 09:44:47 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 09:46:59 +0800
Subject: Re: [PATCH 1/8] mm/vmscan: remove redundant folio_test_swapbacked
 check when folio is file lru
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-2-linmiaohe@huawei.com>
 <YkMNq0531jBomnkv@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a33f3634-0208-6c21-4930-a7f44148ed58@huawei.com>
Date:   Wed, 30 Mar 2022 09:46:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YkMNq0531jBomnkv@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/3/29 21:46, Matthew Wilcox wrote:
> On Tue, Mar 29, 2022 at 09:26:12PM +0800, Miaohe Lin wrote:
>> When folio is file lru, folio_test_swapbacked is guaranteed to be true. So
>> it's unnecessary to check it here again. No functional change intended.
> 
> ummm ... is your logic right here?  The condition is:
> 
> 	if (!a || (b && !c))
> 

Because a is !c, so c is !a. Then we have:

!a || (b && !c) ==> !a || (b && !!a) ==> !a || (b && a) ==> !a || b.

Or am I miss something?

Thanks.

> I don't see how it follows that a => c means we can do any
> simplification at all.
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 1678802e03e7..7c1a9713bfc9 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1434,8 +1434,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>>  	 * Anonymous pages are not handled by flushers and must be written
>>  	 * from reclaim context. Do not stall reclaim based on them
>>  	 */
>> -	if (!folio_is_file_lru(folio) ||
>> -	    (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
>> +	if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {
>>  		*dirty = false;
>>  		*writeback = false;
>>  		return;
>> -- 
>> 2.23.0
>>
>>
> 
> .
> 

