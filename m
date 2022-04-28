Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C20512C45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244844AbiD1HJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244819AbiD1HIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:08:44 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B177C791
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:05:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VBYvof._1651129525;
Received: from 30.32.85.129(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VBYvof._1651129525)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Apr 2022 15:05:26 +0800
Message-ID: <09bf0a55-d66e-40ee-e9b3-d8b7be136ac9@linux.alibaba.com>
Date:   Thu, 28 Apr 2022 15:06:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] mm: rmap: Move the cache flushing to the correct
 place for hugetlb PMD sharing
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        almasrymina@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
 <4f7ae6dfdc838ab71e1655188b657c032ff1f28f.1651056365.git.baolin.wang@linux.alibaba.com>
 <YmosZpGwSoB8TlnK@FVFYT0MHHV2J.usts.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YmosZpGwSoB8TlnK@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/2022 1:55 PM, Muchun Song wrote:
> On Wed, Apr 27, 2022 at 06:52:06PM +0800, Baolin Wang wrote:
>> The cache level flush will always be first when changing an existing
>> virtual–>physical mapping to a new value, since this allows us to
>> properly handle systems whose caches are strict and require a
>> virtual–>physical translation to exist for a virtual address. So we
>> should move the cache flushing before huge_pmd_unshare().
>>
> 
> Right.
> 
>> As Muchun pointed out[1], now the architectures whose supporting hugetlb
>> PMD sharing have no cache flush issues in practice. But I think we
>> should still follow the cache/TLB flushing rules when changing a valid
>> virtual address mapping in case of potential issues in future.
> 
> Right. One point i need to clarify. I do not object this change but
> want you to clarify this (not an issue in practice) in commit log
> to let others know they do not need to bp this.
> 
>>
>> [1] https://lore.kernel.org/all/YmT%2F%2FhuUbFX+KHcy@FVFYT0MHHV2J.usts.net/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/rmap.c | 40 ++++++++++++++++++++++------------------
>>   1 file changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 61e63db..4f0d115 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1535,15 +1535,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   			 * do this outside rmap routines.
>>   			 */
>>   			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>> +			/*
>> +			 * huge_pmd_unshare may unmap an entire PMD page.
>> +			 * There is no way of knowing exactly which PMDs may
>> +			 * be cached for this mm, so we must flush them all.
>> +			 * start/end were already adjusted above to cover this
>> +			 * range.
>> +			 */
>> +			flush_cache_range(vma, range.start, range.end);
>> +
> 
> flush_cache_range() is always called even if we do not need to flush.

Right, this is intended. In the original code, if it is not a shared 
PMD, we will use flush_cache_page() to do cache flushing. However the 
flush_cache_page() can not cover the whole size of a hugetlb page on 
some architectures, which is fixed by patch 3.

> How about introducing a new helper like hugetlb_pmd_shared() which
> returns true for shared PMD? Then:
> 
> 	if (hugetlb_pmd_shared(mm, vma, pvmw.pte)) {
> 		flush_cache_range(vma, range.start, range.end);
> 		huge_pmd_unshare(mm, vma, &address, pvmw.pte);
> 		flush_tlb_range(vma, range.start, range.end);
> 	}
> 
> The code could be a little simpler. Right?

IMHO after patch 3, the code will be changed as below, so seems no need 
to separate the validation of the shared PMDs from huge_pmd_unshare() 
into a new function.

if (folio_test_hugetlb(folio)) {
	flush_cache_range(vma, range.start, range.end);

	if (!folio_test_anon(folio)) {
		VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));

		if (hugetlb_pmd_shared(mm, vma, pvmw.pte)) {
			huge_pmd_unshare(mm, vma, &address, pvmw.pte));
			flush_tlb_range(vma, range.start, range.end);
			......
			break;
		}
	}
} else {
	......
}
