Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA4506984
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbiDSLRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350931AbiDSLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:17:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EAC2B244
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:14:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjLjl51M0zFq0x;
        Tue, 19 Apr 2022 19:12:11 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 19:14:41 +0800
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     Alistair Popple <apopple@nvidia.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <neilb@suse.de>,
        <surenb@google.com>, <minchan@kernel.org>, <peterx@redhat.com>,
        <sfr@canb.auug.org.au>, <rcampbell@nvidia.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal>
 <5a78dd68-343d-ac57-a698-2cfead8ee366@huawei.com>
 <72cfde7a-61d7-980c-4653-94ae83eb4257@redhat.com>
 <87pmldjxiq.fsf@nvdebian.thelocal>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <535ee4f9-d8da-f8f6-2622-286f89622cb4@huawei.com>
Date:   Tue, 19 Apr 2022 19:14:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87pmldjxiq.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/4/19 16:08, Alistair Popple wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 19.04.22 09:29, Miaohe Lin wrote:
>>> On 2022/4/19 11:51, Alistair Popple wrote:
>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>
>>>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>>>> page filled with random data is mapped into user address space. In case
>>>>> of error, a special swap entry indicating swap read fails is set to the
>>>>> page table. So the swapcache page can be freed and the user won't end up
>>>>> with a permanently mounted swap because a sector is bad. And if the page
>>>>> is accessed later, the user process will be killed so that corrupted data
>>>>> is never consumed. On the other hand, if the page is never accessed, the
>>>>> user won't even notice it.
>>>>
>>>> Hi Miaohe,
>>>>> It seems we're not actually using the pfn that gets stored in the special swap
>>>> entry here. Is my understanding correct? If so I think it would be better to use
>>>
>>> Yes, you're right. The pfn is not used now. What we need here is a special swap entry
>>> to do the right things. I think we can change to store some debugging information instead
>>> of pfn if needed in the future.
>>>
>>>> the new PTE markers Peter introduced[1] rather than adding another swap entry
>>>> type.
>>>
>>> IIUC, we should not reuse that swap entry here. From definition:
>>>
>>> PTE markers
>>> `========='
>>> ...
>>> PTE marker is a new type of swap entry that is ony applicable to file
>>> backed memories like shmem and hugetlbfs.  It's used to persist some
>>> pte-level information even if the original present ptes in pgtable are
>>> zapped.
>>>
>>> It's designed for file backed memories while swapin error entry is for anonymous
>>> memories. And there has some differences in processing. So it's not a good idea
>>> to reuse pte markers. Or am I miss something?
>>
>> I tend to agree. As raised in my other reply, maybe we can simply reuse
>> hwpoison entries and update the documentation of them accordingly.
> 
> Unless I've missed something I don't think PTE markers should be restricted
> solely to file backed memory. It's true that the only user of them at the moment
> is UFFD-WP for file backed memory, but PTE markers are just a special swap entry
> same as what is added here.
> 
> That said I don't think there has been any attempt to make PTE markers work for
> anything other than UFFD-WP because it was unclear if there ever would be
> another user.

If PTE markers can also handle the swapin error case, I will try to use it if
we can't reuse hwpoison entries.

> 
> But I agree re-using hwpoison entries is probably a better fit if possible.

Agree. As David said, "At least from a program POV it's similar "the previously well
defined content at this user space address is no longer readable/writable"."

> 
> - Alistair

Many thanks!

> 
