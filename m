Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4704453DB22
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348945AbiFEJvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiFEJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:50:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DD254D636;
        Sun,  5 Jun 2022 02:50:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AEC0D6E;
        Sun,  5 Jun 2022 02:50:56 -0700 (PDT)
Received: from [10.163.37.253] (unknown [10.163.37.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BD7E3F73D;
        Sun,  5 Jun 2022 02:50:47 -0700 (PDT)
Message-ID: <03fb0343-25ec-0356-211f-edbea7541429@arm.com>
Date:   Sun, 5 Jun 2022 15:20:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/6] csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-csky@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220603101411.488970-1-anshuman.khandual@arm.com>
 <20220603101411.488970-5-anshuman.khandual@arm.com>
 <CAJF2gTQOKUfCyaU7gqkejvoJWeSnqc5QyyzWQCw1RJ8PEB2zKg@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAJF2gTQOKUfCyaU7gqkejvoJWeSnqc5QyyzWQCw1RJ8PEB2zKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/22 17:43, Guo Ren wrote:
> Acked-by: Guo Ren <guoren@kernel.org>

I will resend this series with suggested changes.

> 
> On Fri, Jun 3, 2022 at 6:15 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> This defines and exports a platform specific custom vm_get_page_prot() via
>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>> macros can be dropped which are no longer needed.
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: linux-csky@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Guo Ren <guoren@kernel.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/csky/Kconfig               |  1 +
>>  arch/csky/include/asm/pgtable.h | 18 ------------------
>>  arch/csky/mm/init.c             | 32 ++++++++++++++++++++++++++++++++
>>  3 files changed, 33 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
>> index 21d72b078eef..588b8a9c68ed 100644
>> --- a/arch/csky/Kconfig
>> +++ b/arch/csky/Kconfig
>> @@ -6,6 +6,7 @@ config CSKY
>>         select ARCH_HAS_GCOV_PROFILE_ALL
>>         select ARCH_HAS_SYNC_DMA_FOR_CPU
>>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>> +       select ARCH_HAS_VM_GET_PAGE_PROT
>>         select ARCH_USE_BUILTIN_BSWAP
>>         select ARCH_USE_QUEUED_RWLOCKS
>>         select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
>> diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
>> index bbe245117777..229a5f4ad7fc 100644
>> --- a/arch/csky/include/asm/pgtable.h
>> +++ b/arch/csky/include/asm/pgtable.h
>> @@ -77,24 +77,6 @@
>>  #define MAX_SWAPFILES_CHECK() \
>>                 BUILD_BUG_ON(MAX_SWAPFILES_SHIFT != 5)
>>
>> -#define __P000 PAGE_NONE
>> -#define __P001 PAGE_READ
>> -#define __P010 PAGE_READ
>> -#define __P011 PAGE_READ
>> -#define __P100 PAGE_READ
>> -#define __P101 PAGE_READ
>> -#define __P110 PAGE_READ
>> -#define __P111 PAGE_READ
>> -
>> -#define __S000 PAGE_NONE
>> -#define __S001 PAGE_READ
>> -#define __S010 PAGE_WRITE
>> -#define __S011 PAGE_WRITE
>> -#define __S100 PAGE_READ
>> -#define __S101 PAGE_READ
>> -#define __S110 PAGE_WRITE
>> -#define __S111 PAGE_WRITE
>> -
>>  extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>>  #define ZERO_PAGE(vaddr)       (virt_to_page(empty_zero_page))
>>
>> diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
>> index bf2004aa811a..f9babbed17d4 100644
>> --- a/arch/csky/mm/init.c
>> +++ b/arch/csky/mm/init.c
>> @@ -197,3 +197,35 @@ void __init fixaddr_init(void)
>>         vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
>>         fixrange_init(vaddr, vaddr + PMD_SIZE, swapper_pg_dir);
>>  }
>> +
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
>> +       case VM_NONE:
>> +               return PAGE_NONE;
>> +       case VM_READ:
>> +       case VM_WRITE:
>> +       case VM_WRITE | VM_READ:
>> +       case VM_EXEC:
>> +       case VM_EXEC | VM_READ:
>> +       case VM_EXEC | VM_WRITE:
>> +       case VM_EXEC | VM_WRITE | VM_READ:
>> +               return PAGE_READ;
>> +       case VM_SHARED:
>> +               return PAGE_NONE;
>> +       case VM_SHARED | VM_READ:
>> +               return PAGE_READ;
>> +       case VM_SHARED | VM_WRITE:
>> +       case VM_SHARED | VM_WRITE | VM_READ:
>> +               return PAGE_WRITE;
>> +       case VM_SHARED | VM_EXEC:
>> +       case VM_SHARED | VM_EXEC | VM_READ:
>> +               return PAGE_READ;
>> +       case VM_SHARED | VM_EXEC | VM_WRITE:
>> +       case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
>> +               return PAGE_WRITE;
>> +       default:
>> +               BUILD_BUG();
>> +       }
>> +}
>> +EXPORT_SYMBOL(vm_get_page_prot);
>> --
>> 2.25.1
>>
> 
> 
