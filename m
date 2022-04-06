Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F604F5E00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiDFMmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiDFMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:41:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995E6579B9D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:44:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYJ1m4C47zgY7f;
        Wed,  6 Apr 2022 16:43:08 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:44:52 +0800
Subject: Re: [PATCH] mm/swapfile: unuse_pte can map random data if swap read
 fails
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20220401072926.45051-1-linmiaohe@huawei.com>
 <20220404155359.d4867fb8717fe40b5a11647c@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <90c87b53-42f4-875f-3be9-89c28eb4ade0@huawei.com>
Date:   Wed, 6 Apr 2022 16:44:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220404155359.d4867fb8717fe40b5a11647c@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/4/5 6:53, Andrew Morton wrote:
> On Fri, 1 Apr 2022 15:29:26 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>> page filled with random data is mapped into user address space. The fix
>> is to check for PageUptodate and fail swapoff in case of error.
>>
>> ...
>>
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1795,6 +1795,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>  		ret = 0;
>>  		goto out;
>>  	}
>> +	if (unlikely(!PageUptodate(page))) {
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>>  
>>  	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>  	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> 
> Failing the swapoff after -EIO seems a bit rude.  The user ends up with
> a permanently mounted swap because a sector was bad?
> 

This is really unfortunate. :(

> That would be like failing truncate() or close() or umount after -EIO
> on a regular file.  Somewhat.
> 
> Can we do something better?  Such as shooting down the page anyway and
> permitting the swapoff to proceed?  Worst case, just leak the dang page
> with an apologetic message.
> .
> 

We must have a way to prevent user from accessing the wrong data. One way
is kept the page in the swap cache and kill the user when page is accessed.
But this will end up with a permanently mounted swap.
Another way I can figure out now is that we could set the page table entry
to some special swap entry, such as SWP_EIO like SWP_HWPOISON, we can thus
kill the user when page is accessed while swapoff can proceed. But this makes
the code more complicated... Any suggestions?

Many thanks!
