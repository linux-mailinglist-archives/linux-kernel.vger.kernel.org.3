Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D994550FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiFTFQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:16:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E896DEDE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:16:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04A21042;
        Sun, 19 Jun 2022 22:16:35 -0700 (PDT)
Received: from [10.163.42.162] (unknown [10.163.42.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2D23F7D7;
        Sun, 19 Jun 2022 22:16:32 -0700 (PDT)
Message-ID: <cecd8c0c-ebd8-91f1-bfe4-cc5da02b4223@arm.com>
Date:   Mon, 20 Jun 2022 10:46:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 1/2] mm/mmap: Restrict generic protection_map[] array
 visibility
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-2-anshuman.khandual@arm.com>
 <4830e415-cdbb-7050-ebd6-7480493655ef@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <4830e415-cdbb-7050-ebd6-7480493655ef@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 11:05, Christophe Leroy wrote:
> 
> Le 16/06/2022 à 06:09, Anshuman Khandual a écrit :
>> Restrict generic protection_map[] array visibility only for platforms which
>> do not enable ARCH_HAS_VM_GET_PAGE_PROT. For other platforms that do define
>> their own vm_get_page_prot() enabling ARCH_HAS_VM_GET_PAGE_PROT, could have
>> their private static protection_map[] still implementing an array look up.
>> These private protection_map[] array could do without __PXXX/__SXXX macros,
>> making them redundant and dropping them off as well.
>>
>> But platforms which do not define their custom vm_get_page_prot() enabling
>> ARCH_HAS_VM_GET_PAGE_PROT, will still have to provide __PXXX/__SXXX macros.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/include/asm/pgtable-prot.h | 18 ------------------
>>   arch/arm64/mm/mmap.c                  | 21 +++++++++++++++++++++
>>   arch/powerpc/include/asm/pgtable.h    |  2 ++
>>   arch/powerpc/mm/book3s64/pgtable.c    | 20 ++++++++++++++++++++
>>   arch/sparc/include/asm/pgtable_64.h   | 19 -------------------
>>   arch/sparc/mm/init_64.c               |  3 +++
>>   arch/x86/include/asm/pgtable_types.h  | 19 -------------------
>>   arch/x86/mm/pgprot.c                  | 19 +++++++++++++++++++
>>   include/linux/mm.h                    |  2 ++
>>   mm/mmap.c                             |  2 +-
>>   10 files changed, 68 insertions(+), 57 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
>> index d564d0ecd4cd..8ed2a80c896e 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -21,6 +21,7 @@ struct mm_struct;
>>   #endif /* !CONFIG_PPC_BOOK3S */
>>   
>>   /* Note due to the way vm flags are laid out, the bits are XWR */
>> +#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
> This ifdef if not necessary for now, it doesn't matter if __P000 etc 
> still exist thought not used.
> 
>>   #define __P000	PAGE_NONE
>>   #define __P001	PAGE_READONLY
>>   #define __P010	PAGE_COPY
>> @@ -38,6 +39,7 @@ struct mm_struct;
>>   #define __S101	PAGE_READONLY_X
>>   #define __S110	PAGE_SHARED_X
>>   #define __S111	PAGE_SHARED_X
>> +#endif
>>   
>>   #ifndef __ASSEMBLY__
>>   
>> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
>> index 7b9966402b25..d3b019b95c1d 100644
>> --- a/arch/powerpc/mm/book3s64/pgtable.c
>> +++ b/arch/powerpc/mm/book3s64/pgtable.c
>> @@ -551,6 +551,26 @@ unsigned long memremap_compat_align(void)
>>   EXPORT_SYMBOL_GPL(memremap_compat_align);
>>   #endif
>>   
>> +/* Note due to the way vm flags are laid out, the bits are XWR */
>> +static const pgprot_t protection_map[16] = {
>> +	[VM_NONE]					= PAGE_NONE,
>> +	[VM_READ]					= PAGE_READONLY,
>> +	[VM_WRITE]					= PAGE_COPY,
>> +	[VM_WRITE | VM_READ]				= PAGE_COPY,
>> +	[VM_EXEC]					= PAGE_READONLY_X,
>> +	[VM_EXEC | VM_READ]				= PAGE_READONLY_X,
>> +	[VM_EXEC | VM_WRITE]				= PAGE_COPY_X,
>> +	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_X,
>> +	[VM_SHARED]					= PAGE_NONE,
>> +	[VM_SHARED | VM_READ]				= PAGE_READONLY,
>> +	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
>> +	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
>> +	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_X,
>> +	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_X,
>> +	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_X,
>> +	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_X
>> +};
>> +
> There is not much point is first additing that here and then move it 
> elsewhere in the second patch.
> 
> I think with my suggestion to use #ifdef __P000 as a guard, the powerpc 
> changes could go in a single patch.
> 
>>   pgprot_t vm_get_page_prot(unsigned long vm_flags)
>>   {
>>   	unsigned long prot = pgprot_val(protection_map[vm_flags &
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 61e6135c54ef..e66920414945 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -101,6 +101,7 @@ static void unmap_region(struct mm_struct *mm,
>>    *								w: (no) no
>>    *								x: (yes) yes
>>    */
>> +#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
> You should use #ifdef __P000 instead, that way you could migrate 
> architectures one by one.

If vm_get_page_prot() gets moved into all platforms, wondering what would be
the preferred method to organize this patch series ?

1. Move protection_map[] inside platforms with ARCH_HAS_VM_PAGE_PROT (current patch 1)
2. Convert remaining platforms to use ARCH_HAS_VM_PAGE_PROT one after the other
3. Drop ARCH_HAS_VM_PAGE_PROT completely

Using "#ifdef __P000" for wrapping protection_map[] will leave two different #ifdefs
in flight i.e __P000, ARCH_HAS_VM_PAGE_PROT in the generic mmap code, until both gets
dropped eventually. But using "#ifdef __P000" does enable splitting the first patch
into multiple changes for each individual platforms.
