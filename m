Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F8A4A6DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbiBBJjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:39:00 -0500
Received: from foss.arm.com ([217.140.110.172]:47022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244735AbiBBJi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:38:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7BA61FB;
        Wed,  2 Feb 2022 01:38:56 -0800 (PST)
Received: from [10.163.43.221] (unknown [10.163.43.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202483F40C;
        Wed,  2 Feb 2022 01:38:52 -0800 (PST)
Subject: Re: [PATCH] mm: Merge pte_mkhuge() call into arch_make_huge_pte()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <1643780286-18798-1-git-send-email-anshuman.khandual@arm.com>
 <a969f100-02fb-63f7-4469-b3c8e23d8cfb@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <59ec5352-77eb-4c95-731e-100bcfa7003a@arm.com>
Date:   Wed, 2 Feb 2022 15:08:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a969f100-02fb-63f7-4469-b3c8e23d8cfb@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/22 11:50 AM, Christophe Leroy wrote:
> 
> Le 02/02/2022 à 06:38, Anshuman Khandual a écrit :
>> Each call into pte_mkhuge() is invariably followed by arch_make_huge_pte().
>> Instead arch_make_huge_pte() can accommodate pte_mkhuge() at the beginning.
>> This updates generic fallback stub for arch_make_huge_pte() and available
>> platforms definitions. This makes huge pte creation much cleaner and easier
>> to follow.
> I think it is a good cleanup. I always wonder why commit d9ed9faac283 
> ("mm: add new arch_make_huge_pte() method for tile support") didn't move 
> the pte_mkhuge() into arch_make_huge_pte().

+1

> 
> When I implemented arch_make_huge_pte() for powerpc 8xx, in one case 
> arch_make_huge_pte() have to undo the things done by pte_mkhuge(), see below
> 
> As a second step we could probably try to get rid of pte_mkhuge() 
> completely, at least in the core.

Sure.

> 
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: sparclinux@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
>> ---
>>   arch/arm64/mm/hugetlbpage.c                      | 1 +
>>   arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h | 1 +
>>   arch/sparc/mm/hugetlbpage.c                      | 1 +
>>   include/linux/hugetlb.h                          | 2 +-
>>   mm/hugetlb.c                                     | 3 +--
>>   mm/vmalloc.c                                     | 1 -
>>   6 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index ffb9c229610a..228226c5fa80 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -347,6 +347,7 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
>>   {
>>   	size_t pagesize = 1UL << shift;
>>   
>> +	entry = pte_mkhuge(entry);
>>   	if (pagesize == CONT_PTE_SIZE) {
>>   		entry = pte_mkcont(entry);
>>   	} else if (pagesize == CONT_PMD_SIZE) {
>> diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
>> index 64b6c608eca4..e41e095158c7 100644
>> --- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
>> +++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
>> @@ -70,6 +70,7 @@ static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags
>>   {
>>   	size_t size = 1UL << shift;
>>   
>> +	entry = pte_mkhuge(entry);
> Could drop that and replace the below by:
> 
> 	if (size == SZ_16K)
> 		return __pte(pte_val(entry) | _PAGE_SPS);
> 	else
> 		return __pte(pte_val(entry) | _PAGE_SPS | _PAGE_HUGE);
> 	
> 

Sure, will change as stated above.
