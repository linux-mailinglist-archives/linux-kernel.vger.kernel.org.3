Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A624F5E09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiDFMp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiDFMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:44:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7304F58967D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:47:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYJ5F57xNzgYR6;
        Wed,  6 Apr 2022 16:46:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:47:53 +0800
Subject: Re: [PATCH] mm/swapfile: unuse_pte can map random data if swap read
 fails
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220401072926.45051-1-linmiaohe@huawei.com>
 <ac13a529-5000-19c9-bbd8-3ee634a923cc@redhat.com>
 <Ykr8l0sUOtAa3yUY@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <23943d63-1fc4-68ce-938f-0f9b53950710@huawei.com>
Date:   Wed, 6 Apr 2022 16:47:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Ykr8l0sUOtAa3yUY@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/4 22:11, Matthew Wilcox wrote:
> On Mon, Apr 04, 2022 at 03:37:36PM +0200, David Hildenbrand wrote:
>> On 01.04.22 09:29, Miaohe Lin wrote:
>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>> page filled with random data is mapped into user address space. The fix
>>> is to check for PageUptodate and fail swapoff in case of error.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/swapfile.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 63c61f8b2611..e72a35de7a0f 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -1795,6 +1795,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>>  		ret = 0;
>>>  		goto out;
>>>  	}
>>> +	if (unlikely(!PageUptodate(page))) {
>>> +		ret = -EIO;
>>> +		goto out;
>>> +	}
>>
>> Yeah, we have the same handling in do_swap_page(), whereby we send a
>> SIGBUS because we're dealing with an actual access.
>>
>> Interestingly, folio_test_uptodate() states:
>>
>> "Anonymous and CoW folios are always uptodate."
>>
>> @Willy, is that true or is the swapin case not documented there?
> 
> Why do we keep a !Uptodate page in the swap cache?  If it can't be
> read in from swap, I thought we just freed the page.  Since Miaohe

We could free the bad page. But we still need a way to prevent user from
accessing the wrong data.

> has observed that not happening, I guess it doesn't work that way,
> but why not make it work that way?

How could we make it work that way? Could you please tell me in more detail?
Or any suggestions?

Many thanks!

> 
> .
> 

