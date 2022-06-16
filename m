Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F754DA56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359086AbiFPGLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359062AbiFPGKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:10:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2585B29824
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:10:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNsFT1qy1zjYCb;
        Thu, 16 Jun 2022 14:09:17 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 14:10:48 +0800
Subject: Re: [PATCH 4/7] mm/khugepaged: minor cleanup for collapse_file
To:     Yang Shi <shy828301@gmail.com>, Zach O'Keefe <zokeefe@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-5-linmiaohe@huawei.com> <YqoAydWk/IcMp5d2@google.com>
 <CAHbLzkr6AFy_b2SzG0DoLQZt8JAckEhLR_v7SkC=O-4LecaYFQ@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a341f938-200e-27a3-aa6e-9a22c5959461@huawei.com>
Date:   Thu, 16 Jun 2022 14:10:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkr6AFy_b2SzG0DoLQZt8JAckEhLR_v7SkC=O-4LecaYFQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/16 2:18, Yang Shi wrote:
> On Wed, Jun 15, 2022 at 8:55 AM Zach O'Keefe <zokeefe@google.com> wrote:
>>
>> On 11 Jun 16:47, Miaohe Lin wrote:
>>> nr_none is always 0 for non-shmem case because the page can be read from
>>> the backend store. So when nr_none ! = 0, it must be in is_shmem case.
>>> Also only adjust the nrpages and uncharge shmem when nr_none != 0 to save
>>> cpu cycles.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/khugepaged.c | 9 ++++-----
>>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 1b5dd3820eac..8e6fad7c7bd9 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1885,8 +1885,7 @@ static void collapse_file(struct mm_struct *mm,
>>>
>>>       if (nr_none) {
>>>               __mod_lruvec_page_state(new_page, NR_FILE_PAGES, nr_none);
>>> -             if (is_shmem)
>>> -                     __mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
>>> +             __mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
>>>       }
>>
>>
>> Might be worth a small comment here - even though folks can see in above code
>> that this is only incremented in shmem path, might be nice to say why it's
>> always 0 for non-shmem (or conversely, why it's only possible to be non 0 on
>> shmem).
> 
> Agreed, better to have some comments in the code.

Will try to add comments in next version. Thanks both!

> 
>>
>>>
>>>       /* Join all the small entries into a single multi-index entry */
>>> @@ -1950,10 +1949,10 @@ static void collapse_file(struct mm_struct *mm,
>>>
>>>               /* Something went wrong: roll back page cache changes */
>>>               xas_lock_irq(&xas);
>>> -             mapping->nrpages -= nr_none;
>>> -
>>> -             if (is_shmem)
>>> +             if (nr_none) {
>>> +                     mapping->nrpages -= nr_none;
>>>                       shmem_uncharge(mapping->host, nr_none);
>>> +             }
>>>
>>>               xas_set(&xas, start);
>>>               xas_for_each(&xas, page, end - 1) {
>>> --
>>> 2.23.0
>>>
>>>
>>
>> Otherwise,
>>
>> Reviewed-by: Zach O'Keefe <zokeefe@google.com>
>>
> .
> 

