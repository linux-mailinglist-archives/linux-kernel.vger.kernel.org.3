Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF417545ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiFJD5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiFJD5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:57:49 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BB3B284
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 20:57:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VFxf77o_1654833464;
Received: from 30.0.143.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VFxf77o_1654833464)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 11:57:45 +0800
Message-ID: <927ab454-f25d-06d2-5861-a57033f28e00@linux.alibaba.com>
Date:   Fri, 10 Jun 2022 11:57:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64/hugetlb: Simplify the huge_ptep_set_access_flags()
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <d81f1c3215000d0f238900dbfa0a0976d8d00cd3.1653470369.git.baolin.wang@linux.alibaba.com>
 <20220609154438.GA3444@willie-the-truck>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220609154438.GA3444@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2022 11:44 PM, Will Deacon wrote:
> On Wed, May 25, 2022 at 06:31:09PM +0800, Baolin Wang wrote:
>> After commit bc5dfb4fd7bd ("arm64/hugetlb: Implement arm64 specific
>> huge_ptep_get()"), the arm64 specific huge_ptep_get() will always
>> consider the subpages' dirty and young state for CONT-PTE/PMD hugetlb,
>> so there is no need to check them again when setting the access flags
>> for CONT-PTE/PMD hugetlb in huge_ptep_set_access_flags().
>>
>> Meanwhile this also fixes an issue when users want to make the CONT-PTE/PMD
>> hugetlb's pte entry old, which will be failed to make the pte entry old
>> since the original code will always consider the subpages' young state
>> if the subpages' young state is set. For example, we will make the
>> CONT-PTE/PMD hugetlb pte entry old in DAMON to monitoring the accesses,
>> but we'll failed to monitoring the actual accesses of the CONT-PTE/PMD
>> hugetlb page, due to we can not make its pte old.
>>
>> Thus remove the code considering the subpages' dirty and young state in
>> huge_ptep_set_access_flags() to fix this issue and simplify the function.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   arch/arm64/mm/hugetlbpage.c | 10 +---------
>>   1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index e2a5ec9..5c703aa 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -448,7 +448,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>   	size_t pgsize = 0;
>>   	unsigned long pfn = pte_pfn(pte), dpfn;
>>   	pgprot_t hugeprot;
>> -	pte_t orig_pte;
>>   
>>   	if (!pte_cont(pte))
>>   		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
>> @@ -459,14 +458,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>   	if (!__cont_access_flags_changed(ptep, pte, ncontig))
>>   		return 0;
>>   
>> -	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
>> -
>> -	/* Make sure we don't lose the dirty or young state */
>> -	if (pte_dirty(orig_pte))
>> -		pte = pte_mkdirty(pte);
>> -
>> -	if (pte_young(orig_pte))
>> -		pte = pte_mkyoung(pte);
>> +	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> 
> I don't understand what this clear_flush() call is doing here; notably, it
> includes TLB invalidation which we don't have for the non-cont case.

OK. I can just call a loop of pte_clear() to clear cont-pte to avoid TLB 
flush.

> 
> Why isn't huge_ptep_set_access_flags() just a loop around
> ptep_set_access_flags() if huge_ptep_get() is taking care of collapsing the
> dirty/young state?

IIUC, according to the comments "Changing some bits of contiguous 
entries requires us to follow a Break-Before-Make approach, breaking the 
whole contiguous set before we can change any entries". So we should 
clear the cont-ptes firstly, then re-set them. Then a loop of 
ptep_set_access_flags() is not suitable for the cont-pte case, right? 
Please correct me if I missed something else. Thanks.
