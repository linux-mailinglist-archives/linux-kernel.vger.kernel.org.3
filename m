Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55854DAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359250AbiFPGkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359228AbiFPGkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:40:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509C557159
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:40:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNsvm3gwwzjY8v;
        Thu, 16 Jun 2022 14:39:00 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 14:40:31 +0800
Subject: Re: [PATCH 2/7] mm/khugepaged: stop swapping in page when
 VM_FAULT_RETRY occurs
To:     Yang Shi <shy828301@gmail.com>
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
 <20220611084731.55155-3-linmiaohe@huawei.com>
 <CAHbLzkpc8ag7MkY_D17U1B7SjZFO2Bss8rVVj-scMOC8ttqxEg@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c5b8f0c3-de35-9f0e-a3a8-6e132ac398cc@huawei.com>
Date:   Thu, 16 Jun 2022 14:40:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkpc8ag7MkY_D17U1B7SjZFO2Bss8rVVj-scMOC8ttqxEg@mail.gmail.com>
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

On 2022/6/16 1:49, Yang Shi wrote:
> On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> When do_swap_page returns VM_FAULT_RETRY, we do not retry here and thus
>> swap entry will remain in pagetable. This will result in later failure.
>> So stop swapping in pages in this case to save cpu cycles.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/khugepaged.c | 19 ++++++++-----------
>>  1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 73570dfffcec..a8adb2d1e9c6 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1003,19 +1003,16 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>>                 swapped_in++;
>>                 ret = do_swap_page(&vmf);
>>
>> -               /* do_swap_page returns VM_FAULT_RETRY with released mmap_lock */
>> +               /*
>> +                * do_swap_page returns VM_FAULT_RETRY with released mmap_lock.
>> +                * Note we treat VM_FAULT_RETRY as VM_FAULT_ERROR here because
>> +                * we do not retry here and swap entry will remain in pagetable
>> +                * resulting in later failure.
> 
> Yeah, it makes sense.
> 
>> +                */
>>                 if (ret & VM_FAULT_RETRY) {
>>                         mmap_read_lock(mm);
> 
> A further optimization, you should not need to relock mmap_lock. You
> may consider returning a different value or passing in *locked and
> setting it to false, then check this value in the caller to skip
> unlock.

Could we just keep the mmap_sem unlocked when __collapse_huge_page_swapin() fails due to the caller
always doing mmap_read_unlock when __collapse_huge_page_swapin() returns false and add some comments
about this behavior? This looks like a simple way for me.

> 
>> -                       if (hugepage_vma_revalidate(mm, haddr, &vma)) {
>> -                               /* vma is no longer available, don't continue to swapin */
>> -                               trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
>> -                               return false;
>> -                       }
>> -                       /* check if the pmd is still valid */
>> -                       if (mm_find_pmd(mm, haddr) != pmd) {
>> -                               trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
>> -                               return false;
>> -                       }
>> +                       trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
>> +                       return false;
>>                 }
>>                 if (ret & VM_FAULT_ERROR) {
>>                         trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> 
> And I think "swapped_in++" needs to be moved after error handling.

Do you mean do "swapped_in++" only after pages are swapped in successfully?

Thanks!

> 
>> --
>> 2.23.0
>>
>>
> .
> 

