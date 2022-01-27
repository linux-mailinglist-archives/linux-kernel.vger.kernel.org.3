Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E3549D985
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiA0EGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:06:05 -0500
Received: from foss.arm.com ([217.140.110.172]:33258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235900AbiA0EGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:06:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B20D11FB;
        Wed, 26 Jan 2022 20:06:02 -0800 (PST)
Received: from [10.163.42.218] (unknown [10.163.42.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119263F7D8;
        Wed, 26 Jan 2022 20:05:59 -0800 (PST)
Subject: Re: [RFC V1 21/31] parisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-22-git-send-email-anshuman.khandual@arm.com>
 <11909976.O9o76ZdvQC@eto.sf-tec.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <db475121-e113-3287-c27e-e0c8d7ff74eb@arm.com>
Date:   Thu, 27 Jan 2022 09:36:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <11909976.O9o76ZdvQC@eto.sf-tec.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/22 10:23 PM, Rolf Eike Beer wrote:
> Anshuman Khandual wrote:
>> This defines and exports a platform specific custom vm_get_page_prot() via
>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>> macros can be dropped which are no longer needed.
>>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: linux-parisc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/parisc/Kconfig               |  1 +
>>  arch/parisc/include/asm/pgtable.h | 20 ---------------
>>  arch/parisc/mm/init.c             | 41 +++++++++++++++++++++++++++++++
>>  3 files changed, 42 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>> index 43c1c880def6..de512f120b50 100644
>> --- a/arch/parisc/Kconfig
>> +++ b/arch/parisc/Kconfig
>> @@ -10,6 +10,7 @@ config PARISC
>>  	select ARCH_HAS_ELF_RANDOMIZE
>>  	select ARCH_HAS_STRICT_KERNEL_RWX
>>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>> +	select ARCH_HAS_VM_GET_PAGE_PROT
>>  	select ARCH_NO_SG_CHAIN
>>  	select ARCH_SUPPORTS_HUGETLBFS if PA20
>>  	select ARCH_SUPPORTS_MEMORY_FAILURE
>> diff --git a/arch/parisc/include/asm/pgtable.h
>> b/arch/parisc/include/asm/pgtable.h index 3e7cf882639f..80d99b2b5913 100644
>> --- a/arch/parisc/include/asm/pgtable.h
>> +++ b/arch/parisc/include/asm/pgtable.h
>> @@ -269,26 +269,6 @@ extern void __update_cache(pte_t pte);
>>   * pages.
>>   */
>>
>> -	 /*xwr*/
>> -#define __P000  PAGE_NONE
>> -#define __P001  PAGE_READONLY
>> -#define __P010  __P000 /* copy on write */
>> -#define __P011  __P001 /* copy on write */
>> -#define __P100  PAGE_EXECREAD
>> -#define __P101  PAGE_EXECREAD
>> -#define __P110  __P100 /* copy on write */
>> -#define __P111  __P101 /* copy on write */
>> -
>> -#define __S000  PAGE_NONE
>> -#define __S001  PAGE_READONLY
>> -#define __S010  PAGE_WRITEONLY
>> -#define __S011  PAGE_SHARED
>> -#define __S100  PAGE_EXECREAD
>> -#define __S101  PAGE_EXECREAD
>> -#define __S110  PAGE_RWX
>> -#define __S111  PAGE_RWX
>> -
>> -
>>  extern pgd_t swapper_pg_dir[]; /* declared in init_task.c */
>>
>>  /* initial page tables for 0-8MB for kernel */
>> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
>> index 1ae31db9988f..c8316e97e1a2 100644
>> --- a/arch/parisc/mm/init.c
>> +++ b/arch/parisc/mm/init.c
>> @@ -866,3 +866,44 @@ void flush_tlb_all(void)
>>  	spin_unlock(&sid_lock);
>>  }
>>  #endif
>> +
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>> +	case VM_NONE:
>> +		return PAGE_NONE;
>> +	case VM_READ:
>> +		return PAGE_READONLY;
>> +	case VM_WRITE:
>> +		return PAGE_NONE;
>> +	case VM_READ | VM_WRITE:
>> +		return PAGE_READONLY;
> This looks extremely strange. It probably is correct when it comes to CoW, how 
> about including the comment that was in the original definitions for the cases 
> where CoW is expected?
> 

Assuming that you suggest the following four comments here, sure will add them.

-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  __P000 /* copy on write */
-#define __P011  __P001 /* copy on write */
-#define __P100  PAGE_EXECREAD
-#define __P101  PAGE_EXECREAD
-#define __P110  __P100 /* copy on write */
-#define __P111  __P101 /* copy on write */
