Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15556A683
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiGGPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiGGPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:01:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9EC31DC6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:00:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j3so7280755pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2hZBVUu6vtCkIAAa0XFWh1kR5HWXI7azprojIq7FcUc=;
        b=ISRo2QpRA1s7r0DFMGm1vMBzRptkuXUFhDKyTg9XJXKn5b3BIcUQSXQzNlLISAyqDL
         GkMsA6qoleUzq5R8y+9dJyZvk35TdEn8rkdVR7SBnAkNkAf8a5bWlVs99ZuzBOx8GGeA
         TX7WUScz8cUmHw9jOXQ99Tqa1b7XAOB7uXdS4cOI5d3G6iQxMK+063EyqojL1BM+jagj
         /VaxrGZg/1Q1B+OlOhpM/0vS2a5h8TyuSQbO2znrgo4yyCq6iN4luc7BWujCd+rmW8LO
         CD2xW4Ssr/LRJk/pRsFYJAL/jQmKYvPKvf6RdcSoSIa/EVwWgimNQGXcfySH8Mv2KE4A
         y7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2hZBVUu6vtCkIAAa0XFWh1kR5HWXI7azprojIq7FcUc=;
        b=mKTyJyAsgHaM4JQGa54BYEr0/zKCMAKdRLuljTXvqaiCcbMSn2sBoK6c0RuX8L0FfS
         MXJ0PCtlCp5Umk8E3SlAadBBbnO1py1HRkkgQzEXqGUN+wfs/otOxltNSPLn8bVdxSsX
         fZnXdbdonraZ6KHwegkTlfV2UKRbIXlFBb93Xh72Yfx8OKkLmD86Z08owCrwrSvd0P37
         yyn0MTLD9cyESRziLAUkOG2HDaafCQqzRBGjdWHWovC8aVvo4uYwFvYEhplnjbGhIzz9
         X0mCqei46E/ODtw773scxMdlBOCEHB+0bIhXZKp7jGLvbC/eekBrEk0S8VHVRUaektBj
         f1Bw==
X-Gm-Message-State: AJIora9D8jhQFwc6euUcp1/asn+cPGfYbPCeItxhipPiM1Xvuah1K/no
        NZiwEJ6HBj1nezOxXO3+G6bLSbYzOarOOg==
X-Google-Smtp-Source: AGRyM1vCvOBb8PRO1bSS1k7cYd5WxX9hvQhGM19KUKgd4qc7ZqLCHBICNZWzJnX41+KKSzo2ZuduiA==
X-Received: by 2002:a17:902:ec8f:b0:16a:5327:467a with SMTP id x15-20020a170902ec8f00b0016a5327467amr53059445plg.40.1657206046159;
        Thu, 07 Jul 2022 08:00:46 -0700 (PDT)
Received: from [10.4.255.21] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f7ce00b0016be0d5483asm9622923plw.252.2022.07.07.08.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 08:00:45 -0700 (PDT)
Message-ID: <33a63e76-fb71-2b9e-3b3c-cc6f7a675cf3@bytedance.com>
Date:   Thu, 7 Jul 2022 23:00:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [RFC PATCH 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
 <20220707110511.52129-3-zhengqi.arch@bytedance.com>
 <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
 <42bfd82c-b3fb-c942-d6f2-ae5adec90a26@bytedance.com>
 <CAK8P3a17A1t=qkyToQNVnuVfGPp-7VpFx5qJ-gmpyrkJ3yRXTw@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a17A1t=qkyToQNVnuVfGPp-7VpFx5qJ-gmpyrkJ3yRXTw@mail.gmail.com>
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



On 2022/7/7 22:41, Arnd Bergmann wrote:
> On Thu, Jul 7, 2022 at 3:38 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> On 2022/7/7 20:49, Arnd Bergmann wrote:
>>> On Thu, Jul 7, 2022 at 1:05 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>            * Restore the SP from the FP, and restore the FP and LR from
>> the frame
>>            * record.
>>            */
>> -       mov     sp, x29
>> +999:   mov     sp, x29
>>           ldp     x29, x30, [sp], #16
>>    #ifdef CONFIG_SHADOW_CALL_STACK
>>           ldp     scs_sp, xzr, [sp], #16
>>
>> But this also requires a new parameter in do_interrupt_handler.
>>
>> I also considered implementing call_on_irq_stack() for nmi and irq
>> separately, but later think it's unnecessary.
> 
> What I had in mind was something along the lines of
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 56cefd33eb8e..432042b91588 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -270,10 +270,7 @@ static void do_interrupt_handler(struct pt_regs *regs,
>   {
>          struct pt_regs *old_regs = set_irq_regs(regs);
> 
> -       if (on_thread_stack())
> -               call_on_irq_stack(regs, handler);
> -       else
> -               handler(regs);
> +       handler(regs);
> 
>          set_irq_regs(old_regs);
>   }
> @@ -473,16 +470,31 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
>                  __el1_irq(regs, handler);
>   }
> 
> -asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> +static void noinstr el1_irq(struct pt_regs *regs)
>   {
>          el1_interrupt(regs, handle_arch_irq);
>   }
> 
> -asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
> +asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> +{
> +       if (on_thread_stack())
> +               call_on_irq_stack(regs, el1_irq);

IMO, this can't work. Because el1_interrupt() will invoke
arm64_preempt_schedule_irq(), which will cause scheduling on the
IRQ stack.

Thanks,
Qi

> +       else
> +               el1_irq(regs);
> +}
> +
> +static void noinstr el1_fiq(struct pt_regs *regs)
>   {
>          el1_interrupt(regs, handle_arch_fiq);
>   }
> 
> +asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
> +{
> +        if (on_thread_stack())
> +               call_on_irq_stack(regs, el1_fiq);
> +       else
> +               el1_fiq(regs);
> +}
> +
>   asmlinkage void noinstr el1h_64_error_handler(struct pt_regs *regs)
>   {
>          unsigned long esr = read_sysreg(esr_el1);
> @@ -713,7 +731,7 @@ static void noinstr
> __el0_irq_handler_common(struct pt_regs *regs)
> 
>   asmlinkage void noinstr el0t_64_irq_handler(struct pt_regs *regs)
>   {
> -       __el0_irq_handler_common(regs);
> +       call_on_irq_stack(regs, __el0_irq_handler_common);
>   }
> 
>   static void noinstr __el0_fiq_handler_common(struct pt_regs *regs)
> @@ -723,7 +741,7 @@ static void noinstr
> __el0_fiq_handler_common(struct pt_regs *regs)
> 
>   asmlinkage void noinstr el0t_64_fiq_handler(struct pt_regs *regs)
>   {
> -       __el0_fiq_handler_common(regs);
> +       call_on_irq_stack(regs, __el0_fiq_handler_common);
>   }
> 
>   static void noinstr __el0_error_handler_common(struct pt_regs *regs)
> @@ -807,12 +825,12 @@ asmlinkage void noinstr
> el0t_32_sync_handler(struct pt_regs *regs)
> 
>   asmlinkage void noinstr el0t_32_irq_handler(struct pt_regs *regs)
>   {
> -       __el0_irq_handler_common(regs);
> +       call_on_irq_stack(regs, __el0_irq_handler_common);
>   }
> 
>   asmlinkage void noinstr el0t_32_fiq_handler(struct pt_regs *regs)
>   {
> -       __el0_fiq_handler_common(regs);
> +       call_on_irq_stack(regs, __el0_fiq_handler_common);
>   }
> 
>   asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)
> 
> Not sure if that works.
> 
>          Arnd

-- 
Thanks,
Qi
