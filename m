Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68079535BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbiE0Ilz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiE0Ilv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:41:51 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCD26AF1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:41:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VEWfF7V_1653640904;
Received: from 30.32.82.202(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEWfF7V_1653640904)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 16:41:45 +0800
Message-ID: <a7322d0d-ea60-d2e5-4ac2-df0077b25671@linux.alibaba.com>
Date:   Fri, 27 May 2022 16:42:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] arm64/hugetlb: Fix building errors in
 huge_ptep_clear_flush()
To:     Gavin Shan <gshan@redhat.com>, torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        naresh.kamboju@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <814e20c19b110209ee12ecae7cb05f8a78d021c8.1653625820.git.baolin.wang@linux.alibaba.com>
 <4707e621-c167-8fff-b210-9babb6a3f2df@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <4707e621-c167-8fff-b210-9babb6a3f2df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2022 3:12 PM, Gavin Shan wrote:
> Hi Baolin,
> 
> On 5/27/22 12:51 PM, Baolin Wang wrote:
>> Fix below building errors which was caused by commit ae07562909f3
>> ("mm: change huge_ptep_clear_flush() to return the original pte")
>> interacting with commit fb396bb459c1 ("arm64/hugetlb: Drop TLB flush
>> from get_clear_flush()").
>>
>> Due to the new get_clear_contig() has dropped TLB flush, we should
>> add an explicit TLB flush in huge_ptep_clear_flush() to keep original
>> semantics when changing to use new get_clear_contig().
>>
>> "
>> arch/arm64/mm/hugetlbpage.c: In function ‘huge_ptep_clear_flush’:
>> arch/arm64/mm/hugetlbpage.c:515:9: error: implicit declaration of
>> function ‘get_clear_flush’; did you mean ‘ptep_clear_flush’?
>> [-Werror=implicit-function-declaration]
>>    515 |  return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, 
>> ncontig);
>>        |         ^~~~~~~~~~~~~~~
>>        |         ptep_clear_flush
>> "
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>   arch/arm64/mm/hugetlbpage.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
> 
> I ran to the compiling failure either and it would be caused by
> commit fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from 
> get_clear_flush()").
> It's worthy to have a "Fixes" tag. With those fixed:

Thanks for reminding. IMHO, better to add 2 related commits' fix tag. 
Linus, could you help to add them when applying this patch, or need a 
resend? Thanks.

Fixes: ae07562909f3 ("mm: change huge_ptep_clear_flush() to return the 
original pte")
Fixes: fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from 
get_clear_flush()").

> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
> 
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 0f0c17dfeb9c..e2a5ec9fdc0d 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -507,12 +507,15 @@ pte_t huge_ptep_clear_flush(struct 
>> vm_area_struct *vma,
>>   {
>>       size_t pgsize;
>>       int ncontig;
>> +    pte_t orig_pte;
>>       if (!pte_cont(READ_ONCE(*ptep)))
>>           return ptep_clear_flush(vma, addr, ptep);
>>       ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
>> -    return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>> +    orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, 
>> ncontig);
>> +    flush_tlb_range(vma, addr, addr + pgsize * ncontig);
>> +    return orig_pte;
>>   }
>>   static int __init hugetlbpage_init(void)
>>
> 
> Thanks,
> Gavin
