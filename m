Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C93C5129E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbiD1DSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiD1DSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:18:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78DDD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:15:01 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kpggx0671z1JBfK;
        Thu, 28 Apr 2022 11:14:05 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 11:14:59 +0800
Subject: Re: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-2-naoya.horiguchi@linux.dev>
 <5b956156-887b-1d91-7831-28a66db53c6a@huawei.com>
 <20220427130342.GA3915117@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b321a771-1a49-4d4a-3108-fa713bede2e0@huawei.com>
Date:   Thu, 28 Apr 2022 11:14:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220427130342.GA3915117@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/27 21:03, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Apr 27, 2022 at 03:11:31PM +0800, Miaohe Lin wrote:
>> On 2022/4/27 12:28, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> When handling memory error on a hugetlb page, the error handler tries to
>>> dissolve and turn it into 4kB pages.  If it's successfully dissolved,
>>> PageHWPoison flag is moved to the raw error page, so but that's all
>>
>> s/so but/so/
> 
> Fixed, thank you.
> 
>>
>>> right.  However, dissolve sometimes fails, then the error page is left
>>> as hwpoisoned hugepage. It's useful if we can retry to dissolve it to
>>> save healthy pages, but that's not possible now because the information
>>> about where the raw error page is lost.
>>>
>>> Use the private field of a tail page to keep that information.  The code
>>
>> Only one raw error page is saved now. Should this be ok? I think so as memory
>> failure should be rare anyway?
> 
> This is a good point.  It might be rare, but maybe we need some consideration
> on it. Some ideas in my mind below ...
> 
> - using struct page of all subpages is not compatible with hugetlb_free_vmemmap,
>   so it's not desirable.

Yes, that is not compatible with hugetlb_free_vmemmap.

> - defining a linked list starting from hpage[SUBPAGE_INDEX_HWPOISON].private
>   might be a solution to save the multiple offsets.
> - hacking bits in hpage[SUBPAGE_INDEX_HWPOISON].private field to save offset
>   info in compressed format.  For example, for 2MB hugepage there could be
>   512 offset numbers, so we can save one offset with 9 bits subfield.
>   So we can save upto 7 offsets in the field.  This is not flexible and
>   still can't handle many errors.

If there are many errors inside one hugetlb page, there might be other serious problems.

> - maintaining global data structure to save the pfn of all hwpoison pages
>   in the system. This might sound overkilling for the current purpose,
>   but this data structure might be helpful for other purpose, so in the long
>   run someone might get interested in it.

The above ideas sound good. And last one might be more helpful in the memory re-online
case: We can restore the hwpoison info using this global data structure. :)

Thanks!

> 
>>
>>> path of shrinking hugepage pool used this info to try delayed dissolve.
>>>
>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> ---
>>>  include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
>>>  mm/hugetlb.c            |  9 +++++++++
>>>  mm/memory-failure.c     |  2 ++
>>>  3 files changed, 35 insertions(+)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index ac2a1d758a80..689e69cb556b 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -42,6 +42,9 @@ enum {
>>>  	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
>>>  	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
>>>  	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
>>> +#endif
>>> +#ifdef CONFIG_CGROUP_HUGETLB
>>> +	SUBPAGE_INDEX_HWPOISON,
>>>  #endif
>>
>> Do we rely on the CONFIG_CGROUP_HUGETLB to store the raw error page?
> 
> No. I meant CONFIG_MEMORY_FAILURE.
> # I just copied and pasted the #ifdef line just above, and forget to update
> # the CONFIG_* part :(
> 
> Thanks,
> Naoya Horiguchi
> 

