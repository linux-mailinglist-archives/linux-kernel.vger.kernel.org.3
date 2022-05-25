Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603075334D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbiEYBm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbiEYBmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:42:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E456FB0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:42:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L7DJm2Lx5zQkJM;
        Wed, 25 May 2022 09:39:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 09:42:51 +0800
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBICjloIDlj6Mg55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
 <20220519125030.21486-5-linmiaohe@huawei.com>
 <20220520063433.GA584983@hori.linux.bs1.fc.nec.co.jp>
 <0f6dc98b-88f4-c0c9-eb7b-5356ad0e08b1@huawei.com>
 <20220524151014.4d16f01cbd1c04ef74e4db5e@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4475e184-0eea-a47b-9d7b-f90a14f08048@huawei.com>
Date:   Wed, 25 May 2022 09:42:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220524151014.4d16f01cbd1c04ef74e4db5e@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 6:10, Andrew Morton wrote:
> On Sat, 21 May 2022 17:34:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2022/5/20 14:34, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> On Thu, May 19, 2022 at 08:50:29PM +0800, Miaohe Lin wrote:
>>>> When swap in shmem error at swapoff time, there would be a infinite loop
>>>> in the while loop in shmem_unuse_inode(). It's because swapin error is
>>>> deliberately ignored now and thus info->swapped will never reach 0. So
>>>> we can't escape the loop in shmem_unuse().
>>>>
>>>> In order to fix the issue, swapin_error entry is stored in the mapping
>>>> when swapin error occurs. So the swapcache page can be freed and the
>>>> user won't end up with a permanently mounted swap because a sector is
>>>> bad. If the page is accessed later, the user process will be killed
>>>> so that corrupted data is never consumed. On the other hand, if the
>>>> page is never accessed, the user won't even notice it.
>>>>
>>>> Reported-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>> Hi Miaohe,
>>>
>>> Thank you for the update.  I might miss something, but I still see the same
>>> problem (I checked it on mm-everything-2022-05-19-00-03 + this patchset).
>>
>> Hi Naoya,
>> I reproduce the issue in the linux-next-next-20220520 version. And I found even if
>> I *do not inject the swapin error*, the deadloop still occurs. After investigating the
>> code for a long while, I found the root cause:
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index d55dd972023a..6d23ed4d23cb 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1182,7 +1182,7 @@ static int shmem_find_swap_entries(struct address_space *mapping,
>>                 if (swp_type(entry) != type)
>>                         continue;
>>
>> -               indices[ret] = xas.xa_index;
>> +               indices[ret++] = xas.xa_index;
>>                 if (!folio_batch_add(fbatch, folio))
>>                         break;
>>
>> The origin code does not increment the ret value when a folio is found. I will send a patch
>> to fix this next week. Thanks! :)
> 
> So I'm thinking that with Hugh's "mm/shmem: fix shmem folio swapoff
> hang", this patchset is now looking OK, so
> 
> mm-swapfile-unuse_pte-can-map-random-data-if-swap-read-fails.patch
> mm-swapfile-fix-lost-swap-bits-in-unuse_pte.patch
> mm-madvise-free-hwpoison-and-swapin-error-entry-in-madvise_free_pte_range.patch
> mm-shmem-fix-infinite-loop-when-swap-in-shmem-error-at-swapoff-time.patch
> mm-filter-out-swapin-error-entry-in-shmem-mapping.patch
> #
> 
> are OK for merging into mainline?

I think so. But it might be better to have Acked-by or Reviewed-by tag for [PATCH v4 4/5] first. :)

Thanks!

> .
> 

