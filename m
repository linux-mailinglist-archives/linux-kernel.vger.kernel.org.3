Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F29254AA76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353922AbiFNHWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352454AbiFNHWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:22:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A0A828E0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:22:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABBC3D6E;
        Tue, 14 Jun 2022 00:22:43 -0700 (PDT)
Received: from [192.168.4.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29E43F66F;
        Tue, 14 Jun 2022 00:22:41 -0700 (PDT)
Message-ID: <b35a1a9a-9dfc-27f6-8e82-791414454b48@arm.com>
Date:   Tue, 14 Jun 2022 08:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mte: Initialize tag storage to KASAN_TAG_INVALID
Content-Language: en-US
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20220607113150.55140-1-vincenzo.frascino@arm.com>
 <CA+fCnZcZcoOz+SVXdVOsrC_pR_PJUoCQnJe3B2u=D_K7=J79+Q@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <CA+fCnZcZcoOz+SVXdVOsrC_pR_PJUoCQnJe3B2u=D_K7=J79+Q@mail.gmail.com>
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

Hy Andrey,

On 6/9/22 19:34, Andrey Konovalov wrote:
> On Tue, Jun 7, 2022 at 1:32 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> When the kernel is entered on aarch64, the MTE allocation tags are in an
>> UNKNOWN state.
>>
>> With MTE enabled, the tags are initialized:
>>  - When a page is allocated and the user maps it with PROT_MTE.
>>  - On allocation, with in-kernel MTE enabled (KHWASAN).
> 
> Hi Vincenzo,
> 
> I think we should move away from the KHWASAN name - it was used during
> the early prototyping days for SW_TAGS KASAN. What you mean here is
> HW_TAGS KASAN.
> 

You are right, I will fix this in v2. Before re-posting I will wait and see if
there are more comments.

> Thanks!
> 
> 
>>
>> If the tag pool is zeroed by the hardware at reset, it makes it
>> difficult to track potential places where the initialization of the
>> tags was missed.
>>
>> This can be observed under QEMU for aarch64, which initializes the MTE
>> allocation tags to zero.
>>
>> Initialize to tag storage to KASAN_TAG_INVALID to catch potential
>> places where the initialization of the tags was missed.
>>
>> This is done introducing a new kernel command line parameter
>> "mte.tags_init" that enables the debug option.
>>
>> Note: The proposed solution should be considered a debug option because
>> it might have performance impact on large machines at boot.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/kernel/mte.c | 47 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 57b30bcf9f21..259a826363f1 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/cpu.h>
>>  #include <linux/kernel.h>
>> +#include <linux/memblock.h>
>>  #include <linux/mm.h>
>>  #include <linux/prctl.h>
>>  #include <linux/sched.h>
>> @@ -35,6 +36,8 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
>>  EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
>>  #endif
>>
>> +static bool mte_tags_init __ro_after_init;
>> +
>>  static void mte_sync_page_tags(struct page *page, pte_t old_pte,
>>                                bool check_swap, bool pte_is_tagged)
>>  {
>> @@ -107,6 +110,48 @@ int memcmp_pages(struct page *page1, struct page *page2)
>>         return ret;
>>  }
>>
>> +/* mte.tags_init=off/on */
>> +static int __init early_mte_tags_init(char *arg)
>> +{
>> +       if (!arg)
>> +               return -EINVAL;
>> +
>> +       if (!strcmp(arg, "off"))
>> +               mte_tags_init = false;
>> +       else if (!strcmp(arg, "on"))
>> +               mte_tags_init = true;
>> +       else
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +early_param("mte.tags_init", early_mte_tags_init);
>> +
>> +static inline void __mte_tag_storage_init(void)
>> +{
>> +       static bool mte_tags_uninitialized = true;
>> +       phys_addr_t pa_start, pa_end;
>> +       u64 index;
>> +
>> +       if (mte_tags_init && !mte_tags_uninitialized)
>> +               return;
>> +
>> +       for_each_mem_range(index, &pa_start, &pa_end) {
>> +               void *va_start = (void *)__phys_to_virt(pa_start);
>> +               void *va_end = (void *)__phys_to_virt(pa_end);
>> +               size_t va_size = (u64)va_end - (u64)va_start;
>> +
>> +               if (va_start >= va_end)
>> +                       break;
>> +
>> +               mte_set_mem_tag_range(va_start, va_size, KASAN_TAG_INVALID, false);
>> +       }
>> +
>> +       /* Tags are now initialized to KASAN_TAG_INVALID */
>> +       mte_tags_uninitialized = false;
>> +       pr_info("MTE: Tag Storage Initialized\n");
>> +}
>> +
>>  static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>>  {
>>         /* Enable MTE Sync Mode for EL1. */
>> @@ -114,6 +159,8 @@ static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>>                          SYS_FIELD_PREP(SCTLR_EL1, TCF, tcf));
>>         isb();
>>
>> +       __mte_tag_storage_init();
>> +
>>         pr_info_once("MTE: enabled in %s mode at EL1\n", mode);
>>  }
>>
>> --
>> 2.36.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220607113150.55140-1-vincenzo.frascino%40arm.com.

-- 
Regards,
Vincenzo
