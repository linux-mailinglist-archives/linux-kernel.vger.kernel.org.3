Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47784F95D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiDHMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiDHMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:34:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2681FFFA9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:32:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5C04113E;
        Fri,  8 Apr 2022 05:32:31 -0700 (PDT)
Received: from [10.57.9.161] (unknown [10.57.9.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB9673F5A1;
        Fri,  8 Apr 2022 05:32:29 -0700 (PDT)
Message-ID: <08e480cf-90d4-8225-1af9-fe187fc622be@arm.com>
Date:   Fri, 8 Apr 2022 13:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] kasan: Fix hw tags enablement when KUNIT tests are
 disabled
Content-Language: en-US
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20220408100340.43620-1-vincenzo.frascino@arm.com>
 <CA+fCnZcoFWXyhjfKSxPh2djiTWjYCh2xmirPehyJS94DaoJC9w@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <CA+fCnZcoFWXyhjfKSxPh2djiTWjYCh2xmirPehyJS94DaoJC9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 4/8/22 1:26 PM, Andrey Konovalov wrote:
> On Fri, Apr 8, 2022 at 12:04 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Kasan enables hw tags via kasan_enable_tagging() which based on the mode
>> passed via kernel command line selects the correct hw backend.
>> kasan_enable_tagging() is meant to be invoked indirectly via the cpu features
>> framework of the architectures that support these backends.
>> Currently the invocation of this function is guarded by CONFIG_KASAN_KUNIT_TEST
>> which allows the enablement of the correct backend only when KUNIT tests are
>> enabled in the kernel.
> 
>> ... and prevents to enable MTE on arm64 when KUNIT tests for kasan hw_tags are
>> disabled.
> 
> Oh, indeed. Thanks for finding this!
> 
>> This inconsistency was introduced in commit:
>>
>>   f05842cfb9ae2 ("kasan, arm64: allow using KUnit tests with HW_TAGS mode")
> 
> No, that commit is fine. The issue was introduced recently in
> ed6d74446cbf ("kasan: test: support async (again) and asymm modes for
> HW_TAGS"), where I changed kasan_init_hw_tags_cpu() to call
> kasan_enable_tagging() instead of hw_enable_tagging_*().
>

Thanks for pointing this out, the commit message above is referring to when the
guard was introduced but I agree it is more correct to refer to when the logical
issue was introduced. I will update it in v2.

>> Fix the issue making sure that the CONFIG_KASAN_KUNIT_TEST guard does not
>> prevent the correct invocation of kasan_enable_tagging().
>>
>> Fixes: f05842cfb9ae2 ("kasan, arm64: allow using KUnit tests with HW_TAGS mode")
>> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>> Cc: Alexander Potapenko <glider@google.com>
>> Cc: Andrey Konovalov <andreyknvl@gmail.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  mm/kasan/hw_tags.c |  4 ++--
>>  mm/kasan/kasan.h   | 10 ++++++----
>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
>> index 07a76c46daa5..e2677501c36e 100644
>> --- a/mm/kasan/hw_tags.c
>> +++ b/mm/kasan/hw_tags.c
>> @@ -336,8 +336,6 @@ void __kasan_poison_vmalloc(const void *start, unsigned long size)
>>
>>  #endif
>>
>> -#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>> -
>>  void kasan_enable_tagging(void)
>>  {
>>         if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
>> @@ -349,6 +347,8 @@ void kasan_enable_tagging(void)
>>  }
>>  EXPORT_SYMBOL_GPL(kasan_enable_tagging);
> 
> Please keep this EXPORT_SYMBOL_GPL under CONFIG_KASAN_KUNIT_TEST.
> 

Will do. Thanks!

>>
>> +#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>> +
>>  void kasan_force_async_fault(void)
>>  {
>>         hw_force_async_tag_fault();
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index d79b83d673b1..b01b4bbe0409 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
>> @@ -355,25 +355,27 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>>  #define hw_set_mem_tag_range(addr, size, tag, init) \
>>                         arch_set_mem_tag_range((addr), (size), (tag), (init))
>>
>> +void kasan_enable_tagging(void);
>> +
>>  #else /* CONFIG_KASAN_HW_TAGS */
>>
>>  #define hw_enable_tagging_sync()
>>  #define hw_enable_tagging_async()
>>  #define hw_enable_tagging_asymm()
>>
>> +static inline void kasan_enable_tagging(void) { }
>> +
>>  #endif /* CONFIG_KASAN_HW_TAGS */
>>
>>  #if defined(CONFIG_KASAN_HW_TAGS) && IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>>
>> -void kasan_enable_tagging(void);
>>  void kasan_force_async_fault(void);
>>
>> -#else /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
>> +#else /* CONFIG_KASAN_HW_TAGS && CONFIG_KASAN_KUNIT_TEST */
>>
>> -static inline void kasan_enable_tagging(void) { }
>>  static inline void kasan_force_async_fault(void) { }
>>
>> -#endif /* CONFIG_KASAN_HW_TAGS || CONFIG_KASAN_KUNIT_TEST */
>> +#endif /* CONFIG_KASAN_HW_TAGS && CONFIG_KASAN_KUNIT_TEST */
>>
>>  #ifdef CONFIG_KASAN_SW_TAGS
>>  u8 kasan_random_tag(void);
>> --
>> 2.35.1
>>
> 
> Thank you, Vincenzo!

-- 
Regards,
Vincenzo
