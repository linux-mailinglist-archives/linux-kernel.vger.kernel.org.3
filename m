Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7F51959F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbiEDCxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiEDCx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:53:29 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7254120BFE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 19:49:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VC9zWyy_1651632588;
Received: from 30.32.81.226(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VC9zWyy_1651632588)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 May 2022 10:49:49 +0800
Message-ID: <33af56f6-3ab9-0859-013a-598e46dd8da2@linux.alibaba.com>
Date:   Wed, 4 May 2022 10:50:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] mm: rmap: Move the cache flushing to the correct
 place for hugetlb PMD sharing
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, almasrymina@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
 <4f7ae6dfdc838ab71e1655188b657c032ff1f28f.1651056365.git.baolin.wang@linux.alibaba.com>
 <YmosZpGwSoB8TlnK@FVFYT0MHHV2J.usts.net>
 <16644a23-e7df-a330-fba0-a9cd5da4800e@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <16644a23-e7df-a330-fba0-a9cd5da4800e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2022 2:42 AM, Mike Kravetz wrote:
> On 4/27/22 22:55, Muchun Song wrote:
>> On Wed, Apr 27, 2022 at 06:52:06PM +0800, Baolin Wang wrote:
>>> The cache level flush will always be first when changing an existing
>>> virtual–>physical mapping to a new value, since this allows us to
>>> properly handle systems whose caches are strict and require a
>>> virtual–>physical translation to exist for a virtual address. So we
>>> should move the cache flushing before huge_pmd_unshare().
>>>
>>
>> Right.
>>
>>> As Muchun pointed out[1], now the architectures whose supporting hugetlb
>>> PMD sharing have no cache flush issues in practice. But I think we
>>> should still follow the cache/TLB flushing rules when changing a valid
>>> virtual address mapping in case of potential issues in future.
>>
>> Right. One point i need to clarify. I do not object this change but
>> want you to clarify this (not an issue in practice) in commit log
>> to let others know they do not need to bp this.
>>
>>>
>>> [1] https://lore.kernel.org/all/YmT%2F%2FhuUbFX+KHcy@FVFYT0MHHV2J.usts.net/
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   mm/rmap.c | 40 ++++++++++++++++++++++------------------
>>>   1 file changed, 22 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 61e63db..4f0d115 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1535,15 +1535,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>   			 * do this outside rmap routines.
>>>   			 */
>>>   			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>>> +			/*
>>> +			 * huge_pmd_unshare may unmap an entire PMD page.
>>> +			 * There is no way of knowing exactly which PMDs may
>>> +			 * be cached for this mm, so we must flush them all.
>>> +			 * start/end were already adjusted above to cover this
>>> +			 * range.
>>> +			 */
>>> +			flush_cache_range(vma, range.start, range.end);
>>> +
>>
>> flush_cache_range() is always called even if we do not need to flush.
>> How about introducing a new helper like hugetlb_pmd_shared() which
>> returns true for shared PMD? Then:
>>
>> 	if (hugetlb_pmd_shared(mm, vma, pvmw.pte)) {
>> 		flush_cache_range(vma, range.start, range.end);
>> 		huge_pmd_unshare(mm, vma, &address, pvmw.pte);
>> 		flush_tlb_range(vma, range.start, range.end);
>> 	}
>>
>> The code could be a little simpler. Right?
>>
>> Thanks.
>>
> 
> I thought about adding a 'hugetlb_pmd_shared()' interface for another use.
> I believe it could even be used earlier in this call sequence.  Since we
> hold i_mmap_rwsem, we would even test for shared BEFORE calling
> adjust_range_if_pmd_sharing_possible.  We can not make an authoritative test
> in adjust range... because not all callers will be holding i_mmap_rwsem.
> 
> I think we COULD optimize to minimize the flush range.  However, I think
> that would complicate this code even more, and it is difficult enough to
> follow.
> 
> My preference would be to over flush as is done here for correctness and
> simplification.  We can optimize later if desired.

OK. Agree.

> 
> With Muchun's comment that this is not an issue in practice today,
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks.
