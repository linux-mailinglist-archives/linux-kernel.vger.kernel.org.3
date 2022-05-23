Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75C3530FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiEWLYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiEWLX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:23:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8C15FC6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:23:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L6FLn11zRzhZ8b;
        Mon, 23 May 2022 19:23:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 19:23:53 +0800
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hughd@google.com" <hughd@google.com>,
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
 <970aee34-c377-2b8c-c6bb-45e2a96e84b9@huawei.com>
 <20220522235326.GA713751@hori.linux.bs1.fc.nec.co.jp>
 <7269c0c4-7648-a9dc-10fa-3645da5be441@huawei.com>
Message-ID: <139b521b-f477-d108-79ed-4ea2bd76bdf3@huawei.com>
Date:   Mon, 23 May 2022 19:23:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7269c0c4-7648-a9dc-10fa-3645da5be441@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/5/23 11:01, Miaohe Lin wrote:
> On 2022/5/23 7:53, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Fri, May 20, 2022 at 04:17:45PM +0800, Miaohe Lin wrote:
>>> On 2022/5/20 14:34, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>> On Thu, May 19, 2022 at 08:50:29PM +0800, Miaohe Lin wrote:
>>>>> When swap in shmem error at swapoff time, there would be a infinite loop
>>>>> in the while loop in shmem_unuse_inode(). It's because swapin error is
>>>>> deliberately ignored now and thus info->swapped will never reach 0. So
>>>>> we can't escape the loop in shmem_unuse().
>>>>>
>>>>> In order to fix the issue, swapin_error entry is stored in the mapping
>>>>> when swapin error occurs. So the swapcache page can be freed and the
>>>>> user won't end up with a permanently mounted swap because a sector is
>>>>> bad. If the page is accessed later, the user process will be killed
>>>>> so that corrupted data is never consumed. On the other hand, if the
>>>>> page is never accessed, the user won't even notice it.
>>>>>
>>>>> Reported-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>
>>>> Hi Miaohe,
>>>>
>>>> Thank you for the update.  I might miss something, but I still see the same
>>>> problem (I checked it on mm-everything-2022-05-19-00-03 + this patchset).
>>>
>>> I was testing this patch on my 5.10 kernel. I reproduced the problem in my env and
>>> fixed it. It seems there might be some critical difference though I checked that by
>>> reviewing the code... Sorry. :(
>>>
>>>>
>>>> This patch has the effect to change the return value of shmem_swapin_folio(),
>>>> -EIO (without this patch) to -EEXIST (with this patch).
>>>
>>> In fact, I didn't change the return value from -EIO to -EEXIST:
>>>
>>> @@ -1762,6 +1799,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>  failed:
>>>  	if (!shmem_confirm_swap(mapping, index, swap))
>>>  		error = -EEXIST;
>>> +	if (error == -EIO)
>>> +		shmem_set_folio_swapin_error(inode, index, folio, swap)
>>>
>>>> But shmem_unuse_swap_entries() checks neither, so no change from caller's view point.
>>>> Maybe breaking in errors (rather than ENOMEM) in for loop in shmem_unuse_swap_entries()
>>>> solves the issue?  I briefly checked with the below change, then swapoff can return
>>>> with failure.
>>>>
>>>> @@ -1222,7 +1222,7 @@ static int shmem_unuse_swap_entries(struct inode *inode,
>>>>                         folio_put(folio);
>>>>                         ret++;
>>>>                 }
>>>> -               if (error == -ENOMEM)
>>>> +               if (error < 0)
>>>>                         break;
>>>>                 error = 0;
>>>>         }
>>>
>>> Yes, this is the simplest and straightforward way to fix the issue. But it has the side effect
>>> that user will end up with a permanently mounted swap just because a sector is bad. That might
>>> be somewhat unacceptable?
>>
>> Ah, you're right, swapoff should return with success instead of with
>> failure.  I tried the fix in your another email, and that makes swapoff
>> return with success, so your fix looks better than mine.
> 
> I reproduced the deadloop issues when swapin error occurs at swapoff time in my linux-next-next-20220520 env,
> and I found this patch could solve the issue now with the fix in my another email.
> 
> BTW: When I use dm-dust to inject the swapin IO error, I don't see non-uptodate folio when shmem_swapin_folio
> and swapoff succeeds. There might be some issues around that module (so I resort to the another way to inject
> the swapin error), but the patch itself works anyway. ;)

Sorry, the reason I don't see non-uptodate folio when shmem_swapin_folio is that all the shmem pages are still
in the swapcache. They're not read from disk so there is no really IO error. :) When they're indeed freed, the
deadloop issue occurs.

I am thinking about extending the function of MADV_PAGEOUT to free the swapcache page. The page resides in the
swapcache does not save the system memory anyway. And this could help test the swapin behavior. But I'm not
sure whether it's needed.

Thanks! ;)

> 
>>
>> Thanks,
> 
> Thanks a lot!
> 
>> Naoya Horiguchi
>>
> 

