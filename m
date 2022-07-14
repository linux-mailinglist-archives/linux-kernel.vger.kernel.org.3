Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C6574A28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiGNKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiGNKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:09:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C34E854
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:09:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lk9DG6ThlzlVlr;
        Thu, 14 Jul 2022 18:08:14 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 18:09:50 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <Ys2xyCUnqpJt0eIo@monkey> <Ys7ViSsOxLaQJIfy@xz-m1.local>
 <Ys7uXHdzzFezUub5@xz-m1.local>
 <CAJHvVcgqb6R6ePMbgmA8LpMpMgrGWie9ZCTuR4MA77GTvi4XAw@mail.gmail.com>
 <Ys9XAbuxkDUlnmv0@monkey>
 <CAJHvVci9iij+eDV-EWDOtjmWFYo0H+1LkzKBp6=XOpwDA4Jh-g@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1a27f20c-ed69-398a-5e6d-bb7ec5f14f5f@huawei.com>
Date:   Thu, 14 Jul 2022 18:09:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJHvVci9iij+eDV-EWDOtjmWFYo0H+1LkzKBp6=XOpwDA4Jh-g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/7/14 8:20, Axel Rasmussen wrote:
> On Wed, Jul 13, 2022 at 4:36 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 07/13/22 15:46, Axel Rasmussen wrote:
>>> I think there is a small mistake in this patch.
>>>
>>> Consider the non-minor-fault case. We have this block:
>>>
>>> /* Add shared, newly allocated pages to the page cache. */
>>> if (vm_shared && !is_continue) {
>>>         /* ... */
>>> }
>>>
>>> In here, we've added the newly allocated page to the page cache, and
>>> we've set this page_in_pagecache flag to true. But we *do not* setup
>>> rmap for this page in this block. I think in this case, the patch will
>>> cause us to do the wrong thing: we should hugepage_add_new_anon_rmap()
>>> further down, but with this patch we dup instead.
>>
>> I am not sure I follow.  The patch from Miaohe Lin would not change any
>> behavior in the 'if (vm_shared && !is_continue)' case.  In this case
>> both vm_shared and page_in_pagecache are true.
>>
>> IIUC, the patch would address the case where !vm_shared && is_continue.
> 
> Ah, you're right, my interpretation of the various flags got mixed up
> somewhere along the way.
> 
> page_in_pagecache is equivalent to vm_shared in this function,
> *except* when we have is_continue. Given that, I think this patch is
> correct in the vm_shared case (no behavior change). In case of
> !vm_shared && is_continue, I agree the patch is a correction to the
> previous behavior.
> 
>>
>> On 07/12/22 21:05, Miaohe Lin wrote:
>>> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
>>> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
>>> for them mistakenly because they're not vm_shared. This will corrupt the
>>> page->mapping used by page cache code.
>>>
>>> Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/hugetlb.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 8d379e03f672..b232e1508e49 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -6038,7 +6038,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>>       if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
>>>               goto out_release_unlock;
>>>
>>> -     if (vm_shared) {
>>> +     if (page_in_pagecache) {
>>>               page_dup_file_rmap(page, true);

Many thanks for your comments.

As discussed in another thread, we might call page_dup_file_rmap for newly
allocated page (regardless of this patch). So should we come up a seperate
patch to call page_add_file_rmap here instead?

Thanks.

>>>       } else {
>>>               ClearHPageRestoreReserve(page);
>>
>> --
>> Mike Kravetz
> .
> 

