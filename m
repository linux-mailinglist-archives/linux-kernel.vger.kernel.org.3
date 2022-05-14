Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A12526F36
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiENC6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiENC5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:57:10 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6F2E5D02
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:42:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VD5LTZy_1652492545;
Received: from 30.236.14.33(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VD5LTZy_1652492545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 14 May 2022 09:42:26 +0800
Message-ID: <b7b5fa19-1611-f357-e313-5ea4b82218a2@linux.alibaba.com>
Date:   Sat, 14 May 2022 09:43:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] arm64/hugetlb: Implement arm64 specific
 huge_ptep_get()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, willy@infradead.org,
        christophe.leroy@csgroup.eu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1652411252.git.baolin.wang@linux.alibaba.com>
 <de60e44dc6fa7991889320a7dfc9ee7ea38f01d8.1652411252.git.baolin.wang@linux.alibaba.com>
 <15c2d16e-4071-677b-5ca5-3b66e6af59d5@arm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <15c2d16e-4071-677b-5ca5-3b66e6af59d5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 5/13/2022 7:03 PM, Anshuman Khandual 写道:
> 
> 
> On 5/13/22 09:07, Baolin Wang wrote:
>> Now we use huge_ptep_get() to get the pte value of a hugetlb page,
>> however it will only return one specific pte value for the CONT-PTE
>> or CONT-PMD size hugetlb on ARM64 system, which can contain seravel
> 
> A small nit.
> 
> s/seravel/several

Will fix.

> 
>> continuous pte or pmd entries with same page table attributes. And it
>> will not take into account the subpages' dirty or young bits of a
>> CONT-PTE/PMD size hugetlb page.
>>
>> So the huge_ptep_get() is inconsistent with huge_ptep_get_and_clear(),
>> which already takes account the dirty or young bits for any subpages
>> in this CONT-PTE/PMD size hugetlb [1]. Meanwhile we can miss dirty or
>> young flags statistics for hugetlb pages with current huge_ptep_get(),
>> such as the gather_hugetlb_stats() function, and CONT-PTE/PMD hugetlb
>> monitoring with DAMON.
>>
>> Thus define an ARM64 specific  huge_ptep_get() implementation, that will
>> take into account any subpages' dirty or young bits for CONT-PTE/PMD size
>> hugetlb page, for those functions that want to check the dirty and young
>> flags of a hugetlb page.
>>
>> [1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/
> 
> Might be worth mentioning that arm64 now enables __HAVE_ARCH_HUGE_PTEP_GET.

Sure.

> 
>>
>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   arch/arm64/include/asm/hugetlb.h |  2 ++
>>   arch/arm64/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index 616b2ca..1fd2846 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -44,6 +44,8 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>   #define __HAVE_ARCH_HUGE_PTE_CLEAR
>>   extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>>   			   pte_t *ptep, unsigned long sz);
>> +#define __HAVE_ARCH_HUGE_PTEP_GET
>> +extern pte_t huge_ptep_get(pte_t *ptep);
>>   extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>>   				 pte_t *ptep, pte_t pte, unsigned long sz);
>>   #define set_huge_swap_pte_at set_huge_swap_pte_at
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 9553851..9a3f7f1 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -158,6 +158,30 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
>>   	return contig_ptes;
>>   }
>>   
>> +pte_t huge_ptep_get(pte_t *ptep)
>> +{
>> +	int ncontig, i;
>> +	size_t pgsize;
>> +	pte_t orig_pte = ptep_get(ptep);
>> +
>> +	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
>> +		return orig_pte;
>> +
>> +	ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
> 
> Hmm, I guess there is no better way of deriving page size here.
> 
> Please drop the extra line here.

OK.

> 
>> +
>> +	for (i = 0; i < ncontig; i++, ptep++) {
>> +		pte_t pte = ptep_get(ptep);
>> +
>> +		if (pte_dirty(pte))
>> +			orig_pte = pte_mkdirty(orig_pte);
>> +
>> +		if (pte_young(pte))
>> +			orig_pte = pte_mkyoung(orig_pte);
>> +	}
> 
> Please drop the extra line here.

Sure.

> 
>> +
>> +	return orig_pte;
>> +}
>> +
>>   /*
>>    * Changing some bits of contiguous entries requires us to follow a
>>    * Break-Before-Make approach, breaking the whole contiguous set
> Otherwise LGTM.
> 
> With those small changes accommodated,
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks for reviewing.
