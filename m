Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921A854EFCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbiFQDnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiFQDnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:43:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1387764D3E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:43:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E8712FC;
        Thu, 16 Jun 2022 20:43:47 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 874E23F73B;
        Thu, 16 Jun 2022 20:43:45 -0700 (PDT)
Message-ID: <ed58c478-e245-63e7-b48a-ab54b221e4fa@arm.com>
Date:   Fri, 17 Jun 2022 09:13:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-3-anshuman.khandual@arm.com>
 <7cf922f4-2367-e173-0280-cb498391d9f7@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <7cf922f4-2367-e173-0280-cb498391d9f7@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 11:15, Christophe Leroy wrote:
> 
> Le 16/06/2022 à 06:09, Anshuman Khandual a écrit :
>> Move the protection_array[] array inside the arch for those platforms which
>> do not enable ARCH_HAS_VM_GET_PAGE_PROT. Afterwards __SXXX/__PXX macros can
>> be dropped completely which are now redundant.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Reported-by: kernel test robot <lkp@intel.com>
>> Acked-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/alpha/include/asm/pgtable.h          | 17 -------
>>   arch/alpha/mm/init.c                      | 21 +++++++++
>>   arch/arc/include/asm/pgtable-bits-arcv2.h | 18 --------
>>   arch/arc/mm/mmap.c                        | 19 ++++++++
>>   arch/arm/include/asm/pgtable.h            | 17 -------
>>   arch/arm/lib/uaccess_with_memcpy.c        |  2 +-
>>   arch/arm/mm/mmu.c                         | 19 ++++++++
>>   arch/csky/include/asm/pgtable.h           | 18 --------
>>   arch/csky/mm/init.c                       | 19 ++++++++
>>   arch/hexagon/include/asm/pgtable.h        | 27 ------------
>>   arch/hexagon/mm/init.c                    | 41 +++++++++++++++++
>>   arch/ia64/include/asm/pgtable.h           | 18 --------
>>   arch/ia64/mm/init.c                       | 27 +++++++++++-
>>   arch/loongarch/include/asm/pgtable-bits.h | 19 --------
>>   arch/loongarch/mm/cache.c                 | 45 +++++++++++++++++++
>>   arch/m68k/include/asm/mcf_pgtable.h       | 54 -----------------------
>>   arch/m68k/include/asm/motorola_pgtable.h  | 22 ---------
>>   arch/m68k/include/asm/sun3_pgtable.h      | 17 -------
>>   arch/m68k/mm/mcfmmu.c                     | 54 +++++++++++++++++++++++
>>   arch/m68k/mm/motorola.c                   | 19 ++++++++
>>   arch/m68k/mm/sun3mmu.c                    | 19 ++++++++
>>   arch/microblaze/include/asm/pgtable.h     | 17 -------
>>   arch/microblaze/mm/init.c                 | 19 ++++++++
>>   arch/mips/include/asm/pgtable.h           | 22 ---------
>>   arch/mips/mm/cache.c                      |  2 +
>>   arch/nios2/include/asm/pgtable.h          | 16 -------
>>   arch/nios2/mm/init.c                      | 19 ++++++++
>>   arch/openrisc/include/asm/pgtable.h       | 18 --------
>>   arch/openrisc/mm/init.c                   | 19 ++++++++
>>   arch/parisc/include/asm/pgtable.h         | 18 --------
>>   arch/parisc/mm/init.c                     | 19 ++++++++
>>   arch/powerpc/include/asm/pgtable.h        | 20 ---------
>>   arch/powerpc/mm/book3s64/pgtable.c        | 24 +++-------
>>   arch/powerpc/mm/pgtable.c                 | 20 +++++++++
>>   arch/riscv/include/asm/pgtable.h          | 20 ---------
>>   arch/riscv/mm/init.c                      | 19 ++++++++
>>   arch/s390/include/asm/pgtable.h           | 17 -------
>>   arch/s390/mm/mmap.c                       | 19 ++++++++
>>   arch/sh/include/asm/pgtable.h             | 17 -------
>>   arch/sh/mm/mmap.c                         | 19 ++++++++
>>   arch/sparc/include/asm/pgtable_32.h       | 19 --------
>>   arch/sparc/mm/init_32.c                   | 19 ++++++++
>>   arch/sparc/mm/init_64.c                   |  2 +-
>>   arch/um/include/asm/pgtable.h             | 17 -------
>>   arch/um/kernel/mem.c                      | 19 ++++++++
>>   arch/x86/um/mem_32.c                      |  2 +-
>>   arch/xtensa/include/asm/pgtable.h         | 18 --------
>>   arch/xtensa/mm/init.c                     | 19 ++++++++
>>   include/linux/mm.h                        |  2 +-
>>   mm/mmap.c                                 | 19 --------
>>   50 files changed, 503 insertions(+), 489 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
>> index 8ed2a80c896e..bd636295a794 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -21,26 +21,6 @@ struct mm_struct;
>>   #endif /* !CONFIG_PPC_BOOK3S */
>>   
>>   /* Note due to the way vm flags are laid out, the bits are XWR */
>> -#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
>> -#define __P000	PAGE_NONE
>> -#define __P001	PAGE_READONLY
>> -#define __P010	PAGE_COPY
>> -#define __P011	PAGE_COPY
>> -#define __P100	PAGE_READONLY_X
>> -#define __P101	PAGE_READONLY_X
>> -#define __P110	PAGE_COPY_X
>> -#define __P111	PAGE_COPY_X
>> -
>> -#define __S000	PAGE_NONE
>> -#define __S001	PAGE_READONLY
>> -#define __S010	PAGE_SHARED
>> -#define __S011	PAGE_SHARED
>> -#define __S100	PAGE_READONLY_X
>> -#define __S101	PAGE_READONLY_X
>> -#define __S110	PAGE_SHARED_X
>> -#define __S111	PAGE_SHARED_X
>> -#endif
>> -
>>   #ifndef __ASSEMBLY__
>>   
>>   #ifndef MAX_PTRS_PER_PGD
>> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
>> index d3b019b95c1d..de76dd4d447c 100644
>> --- a/arch/powerpc/mm/book3s64/pgtable.c
>> +++ b/arch/powerpc/mm/book3s64/pgtable.c
>> @@ -551,25 +551,11 @@ unsigned long memremap_compat_align(void)
>>   EXPORT_SYMBOL_GPL(memremap_compat_align);
>>   #endif
>>   
>> -/* Note due to the way vm flags are laid out, the bits are XWR */
>> -static const pgprot_t protection_map[16] = {
>> -	[VM_NONE]					= PAGE_NONE,
>> -	[VM_READ]					= PAGE_READONLY,
>> -	[VM_WRITE]					= PAGE_COPY,
>> -	[VM_WRITE | VM_READ]				= PAGE_COPY,
>> -	[VM_EXEC]					= PAGE_READONLY_X,
>> -	[VM_EXEC | VM_READ]				= PAGE_READONLY_X,
>> -	[VM_EXEC | VM_WRITE]				= PAGE_COPY_X,
>> -	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_X,
>> -	[VM_SHARED]					= PAGE_NONE,
>> -	[VM_SHARED | VM_READ]				= PAGE_READONLY,
>> -	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
>> -	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
>> -	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_X,
>> -	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_X,
>> -	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_X,
>> -	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_X
>> -};
>> +/*
>> + * Generic declaration in (include/linux/mm.h) is not available
>> + * here as the platform enables ARCH_HAS_VM_GET_PAGE_PROT.
>> + */
>> +extern pgprot_t protection_map[16];
>>   
>>   pgprot_t vm_get_page_prot(unsigned long vm_flags)
>>   {
>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index e6166b71d36d..780fbecd7bf6 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -472,3 +472,23 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
>>   	return ret_pte;
>>   }
>>   EXPORT_SYMBOL_GPL(__find_linux_pte);
>> +
>> +/* Note due to the way vm flags are laid out, the bits are XWR */
>> +pgprot_t protection_map[16] = {
>
> Was const previously, now back to non const ? Maybe due to a conflict 
> with linux/mm.h ? At least it should be __ro_after_init.
> 

Right, the generic declaration in linux/mm.h prevents different types 
for protection_map[] on different platforms. As mentioned before, may
be we should move generic vm_get_page_prot() inside the platforms ?
