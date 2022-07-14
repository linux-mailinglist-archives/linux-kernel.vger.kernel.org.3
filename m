Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D91574C83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiGNLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiGNLyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:54:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FB5B7BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:54:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e132so1334738pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Lw6dnWKKf4qYinOk7C7qoIKvJa0rmL56nHVIzziCEDI=;
        b=LIrXPCC8wiHlukGZGVzI7u9C86bEcSuRxsq9P6/WWy40nR5ozfBg1vYRS9g6LqZMiL
         tYKXth80mnKIVrrg9Sj+iQWEM80ciFVFTqdxi0pHtS2gq1TkEOae1K5CRWE22bHdAYCE
         /vLE87kwEJEblkmittiPWzQ9Fgq8k4SpwMpUbZb4WfOqd3eblhgOsmxa6y5EMoy0MbC7
         vtwJlmGjyOY/EOAdudS0V8l9LC7qfpf0IXvezSC+jFjzciYJH2WoK2a5lzJMcpkgpeOG
         vXTT4Wru143zHM2R/S/pvKytEqucLL8d8t9Y1+AIb22ZkOU9fRwHbrUShSRwEHhEIxRv
         nvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lw6dnWKKf4qYinOk7C7qoIKvJa0rmL56nHVIzziCEDI=;
        b=sKxs1AvPEiiIFd+3FOAzsCYG/u8PrztLgwnj6AHdKa8KlQeCzK/4uu7PZwX1JCWFjF
         /gXhL1LpFfb8X8WSbio3UrcX4EHRQtIUQM2yj9KDbRduFwkqI1dVncYtxHb7vrotnnmy
         1tHhl51pRuFonyHdRLqdNmdQo27oAndPMNAg1/SlOZ2xPPcUze/IdTlKJKSSEfyoWAnE
         gPERYU4yBLkjlFpQq4sa83RqaqY+qnsBkL07I+5SeUvye/aTMqpOPVn/rUz/HMvig0a8
         24R87shnuDXheIqgvc2tmzN5Sd7Rab2CVPfM3UWYTvRYSWj/YuCLVSjP7Dier051gFsy
         zFfg==
X-Gm-Message-State: AJIora/VNzDO+aT43bdryVBJxoVZJXVb5STdSNFhOQUMWmiLHfb8z+38
        +vWLpSjpfROUFLsxILLn432HsQ==
X-Google-Smtp-Source: AGRyM1v7WqNekkji8fncoQyJjBPV5eBEMePg10c+cAzpKj2TVT3H27OevIw7VvL6kM9a7cMZPEj5rw==
X-Received: by 2002:a63:6d5:0:b0:412:ac9d:814e with SMTP id 204-20020a6306d5000000b00412ac9d814emr7650867pgg.90.1657799691567;
        Thu, 14 Jul 2022 04:54:51 -0700 (PDT)
Received: from [10.4.227.66] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s67-20020a625e46000000b005258df7615bsm1481113pfb.0.2022.07.14.04.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:54:51 -0700 (PDT)
Message-ID: <3afacff7-e559-b7b5-c65b-414ff988e696@bytedance.com>
Date:   Thu, 14 Jul 2022 19:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH v1 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
 <20220708094950.41944-3-zhengqi.arch@bytedance.com>
 <CAK8P3a3rp6R1kWNHBxgDf5xrECj-F5AVn++qR9_Y7GiRrDBpDw@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a3rp6R1kWNHBxgDf5xrECj-F5AVn++qR9_Y7GiRrDBpDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/14 19:37, Arnd Bergmann wrote:
> On Fri, Jul 8, 2022 at 11:49 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Since softirqs are handled on the per-CPU IRQ stack,
>> let's support HAVE_IRQ_EXIT_ON_IRQ_STACK which causes
>> the core code to invoke __do_softirq() directly without
>> going through do_softirq_own_stack().
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Adding Mark Rutland to Cc, he's the one that worked on this area the most in the
> past and should probably review your patch. I still feel like there
> should be a way
> to improve readability of the IRQ entry path rather than just adding another

Got it. And looking forward to reviews and suggestions from Mark or
anyone else.

> level of indirection, but the ideas I had so far have not led to
> anything useful.
> 
> Overall I suppose your version is an improvement over the extra double stack
> switch when entering softirq.
> 
>          Arnd

Thanks,
Qi

> 
>> ---
>>   arch/arm64/Kconfig                 |  1 +
>>   arch/arm64/include/asm/exception.h |  4 +++-
>>   arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
>>   arch/arm64/kernel/entry.S          |  6 ++++--
>>   arch/arm64/kernel/irq.c            |  5 +++--
>>   5 files changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index be0a9f0052ee..d2cc7daecce3 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -231,6 +231,7 @@ config ARM64
>>          select TRACE_IRQFLAGS_SUPPORT
>>          select TRACE_IRQFLAGS_NMI_SUPPORT
>>          select HAVE_SOFTIRQ_ON_OWN_STACK
>> +       select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>          help
>>            ARM 64-bit (AArch64) Linux support.
>>
>> diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
>> index d94aecff9690..8bff0aa7ab50 100644
>> --- a/arch/arm64/include/asm/exception.h
>> +++ b/arch/arm64/include/asm/exception.h
>> @@ -54,7 +54,9 @@ asmlinkage void el0t_32_fiq_handler(struct pt_regs *regs);
>>   asmlinkage void el0t_32_error_handler(struct pt_regs *regs);
>>
>>   asmlinkage void call_on_irq_stack(struct pt_regs *regs,
>> -                                 void (*func)(struct pt_regs *));
>> +                                 void (*func)(struct pt_regs *),
>> +                                 void (*do_func)(struct pt_regs *,
>> +                                                 void (*)(struct pt_regs *)));
>>   asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
>>
>>   void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index c75ca36b4a49..935d1ab150b5 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -266,14 +266,16 @@ static void __sched arm64_preempt_schedule_irq(void)
>>   }
>>
>>   static void do_interrupt_handler(struct pt_regs *regs,
>> -                                void (*handler)(struct pt_regs *))
>> +                                void (*handler)(struct pt_regs *),
>> +                                void (*do_handler)(struct pt_regs *,
>> +                                                   void (*)(struct pt_regs *)))
>>   {
>>          struct pt_regs *old_regs = set_irq_regs(regs);
>>
>>          if (on_thread_stack())
>> -               call_on_irq_stack(regs, handler);
>> +               call_on_irq_stack(regs, handler, do_handler);
>>          else
>> -               handler(regs);
>> +               do_handler(regs, handler);
>>
>>          set_irq_regs(old_regs);
>>   }
>> @@ -441,22 +443,32 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
>>          }
>>   }
>>
>> +static void nmi_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
>> +{
>> +       handler(regs);
>> +}
>> +
>>   static __always_inline void __el1_pnmi(struct pt_regs *regs,
>>                                         void (*handler)(struct pt_regs *))
>>   {
>>          arm64_enter_nmi(regs);
>> -       do_interrupt_handler(regs, handler);
>> +       do_interrupt_handler(regs, handler, nmi_handler);
>>          arm64_exit_nmi(regs);
>>   }
>>
>> +static void irq_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
>> +{
>> +       irq_enter_rcu();
>> +       handler(regs);
>> +       irq_exit_rcu();
>> +}
>> +
>>   static __always_inline void __el1_irq(struct pt_regs *regs,
>>                                        void (*handler)(struct pt_regs *))
>>   {
>>          enter_from_kernel_mode(regs);
>>
>> -       irq_enter_rcu();
>> -       do_interrupt_handler(regs, handler);
>> -       irq_exit_rcu();
>> +       do_interrupt_handler(regs, handler, irq_handler);
>>
>>          arm64_preempt_schedule_irq();
>>
>> @@ -699,9 +711,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
>>          if (regs->pc & BIT(55))
>>                  arm64_apply_bp_hardening();
>>
>> -       irq_enter_rcu();
>> -       do_interrupt_handler(regs, handler);
>> -       irq_exit_rcu();
>> +       do_interrupt_handler(regs, handler, irq_handler);
>>
>>          exit_to_user_mode(regs);
>>   }
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 254fe31c03a0..1c351391f6bd 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -867,7 +867,9 @@ NOKPROBE(ret_from_fork)
>>
>>   /*
>>    * void call_on_irq_stack(struct pt_regs *regs,
>> - *                       void (*func)(struct pt_regs *));
>> + *                       void (*func)(struct pt_regs *)
>> + *                       void (*do_func)(struct pt_regs *,
>> + *                                       void (*)(struct pt_regs *)));
>>    *
>>    * Calls func(regs) using this CPU's irq stack and shadow irq stack.
>>    */
>> @@ -886,7 +888,7 @@ SYM_FUNC_START(call_on_irq_stack)
>>
>>          /* Move to the new stack and call the function there */
>>          mov     sp, x16
>> -       blr     x1
>> +       blr     x2
>>
>>          /*
>>           * Restore the SP from the FP, and restore the FP and LR from the frame
>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>> index c36ad20a52f3..003db605bc4f 100644
>> --- a/arch/arm64/kernel/irq.c
>> +++ b/arch/arm64/kernel/irq.c
>> @@ -73,14 +73,15 @@ static void init_irq_stacks(void)
>>   #endif
>>
>>   #ifndef CONFIG_PREEMPT_RT
>> -static void ____do_softirq(struct pt_regs *regs)
>> +static void ____do_softirq(struct pt_regs *regs,
>> +                          void (*handler)(struct pt_regs *))
>>   {
>>          __do_softirq();
>>   }
>>
>>   void do_softirq_own_stack(void)
>>   {
>> -       call_on_irq_stack(NULL, ____do_softirq);
>> +       call_on_irq_stack(NULL, NULL, ____do_softirq);
>>   }
>>   #endif
>>
>> --
>> 2.20.1
>>

-- 
Thanks,
Qi
