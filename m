Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C444A5A1FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbiHZEQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHZEQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:16:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E4BB01B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 21:16:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so590620plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 21:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qWMrLWTIFlNOH6VHT62t3klsgdHgFqNGp3rL1eTyrqQ=;
        b=ku1WlQzHvJZ0JCLdD7/3TLs6RatHXczjzuLYdmBI7Z/b3797hkABiY33LMH00rytQM
         uHtMoD7cgnH9al8c5pFUo7Em7w6BUw6UZ6WP14svaC5n6k0YztcMp21iFP8u8VZtDY+g
         G6dYfje5YB13lviPrpQb3kP3PbrYSD8TIrUjUYrTa4bumEL+ZZcpiWUm6J4I6tBcw7jV
         Qizy2E81nVFCfRE3dHwpM5Ra3WQwOAbKgpYFgEmOLYcyqt2FXy5Yf4Mt/6k1rN1Xg3O4
         ZNpRfn+gyYY09AtFdPBZUCQSctaczl7kagHEbZu092nEDW+BAh7BnkKD/00lRNRRVHc2
         rNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qWMrLWTIFlNOH6VHT62t3klsgdHgFqNGp3rL1eTyrqQ=;
        b=aJ9qnZGpMNMAPuPU/bvfe5qkOK6Qq/ddBoaSIZsVHJNrC4KV6x3rgwMsyVVITi7Yxl
         E6cUkzCMMzO19+e15rQWoTv8SbYNXbigAewFVL25oFRsUX4hdU6o3/oI3caibuXh4MOV
         2qZAc61IVMhnGa6D6WiyHbkTijmcLSbhLxkfVHabDfnTsx/yL82W5AjzOrtzUBMe1R1i
         NYewl/Af7cxbtmdcUmJK4af08quENjoGbtZcwlZajJkSGCNxLCIu2+qVG12130Mjmxwj
         XD117x1EyAVCxw3eNIZDxHu9OZhvo2FFKtKMJwB7EYW2ZyP71jXKJzFwuS+w3Jz743wM
         z2dQ==
X-Gm-Message-State: ACgBeo0NwKTW3OklOYcTQi/vLFIenR15D8tXzThoUugCLa/oIWT+OYxX
        Naylr0yHffRGWgaVB3PU+F2McTJqDF414A==
X-Google-Smtp-Source: AA6agR69UWzt6OIytVHHZ6KMxyKtTwl29Xi/yE85vs1SZzfOlWZ+XwL2wzUSyk2/5zP49d8EntUpiw==
X-Received: by 2002:a17:903:11c7:b0:170:a74e:3803 with SMTP id q7-20020a17090311c700b00170a74e3803mr1981530plh.156.1661487371650;
        Thu, 25 Aug 2022 21:16:11 -0700 (PDT)
Received: from [10.4.107.53] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709027c1600b0016f1319d2a7sm363703pll.297.2022.08.25.21.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 21:16:10 -0700 (PDT)
Message-ID: <595c912a-1503-d420-f32f-297b824decae@bytedance.com>
Date:   Fri, 26 Aug 2022 12:16:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v3] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
To:     will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220815124739.15948-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220815124739.15948-1-zhengqi.arch@bytedance.com>
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



On 2022/8/15 20:47, Qi Zheng wrote:
> Currently arm64 supports per-CPU IRQ stack, but softirqs
> are still handled in the task context.
> 
> Since any call to local_bh_enable() at any level in the task's
> call stack may trigger a softirq processing run, which could
> potentially cause a task stack overflow if the combined stack
> footprints exceed the stack's size, let's run these softirqs
> on the IRQ stack as well.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Will Deacon <will@kernel.org>
> ---
> v2: https://lore.kernel.org/lkml/20220802065325.39740-1-zhengqi.arch@bytedance.com/
> v1: https://lore.kernel.org/lkml/20220708094950.41944-1-zhengqi.arch@bytedance.com/
> RFC: https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/
> 
> Changelog in v2 -> v3:
>   - rebase onto the v6.0-rc1

Gentle ping.

Thanks,
Qi

> 
> Changelog in v1 -> v2:
>   - temporarily discard [PATCH v1 2/2] to allow this patch to be merged first
>   - rebase onto the v5.19
>   - collect Reviewed-by and Acked-by
> 
> Changelog in RFC -> v1:
>   - fix conflicts with commit f2c5092190f2 ("arch/*: Disable softirq stacks on PREEMPT_RT.")
> 
>   arch/arm64/Kconfig      |  1 +
>   arch/arm64/kernel/irq.c | 13 +++++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 571cc234d0b3..ee92f5887cf6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -230,6 +230,7 @@ config ARM64
>   	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
>   	select TRACE_IRQFLAGS_SUPPORT
>   	select TRACE_IRQFLAGS_NMI_SUPPORT
> +	select HAVE_SOFTIRQ_ON_OWN_STACK
>   	help
>   	  ARM 64-bit (AArch64) Linux support.
>   
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index bda49430c9ea..c36ad20a52f3 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -22,6 +22,7 @@
>   #include <linux/vmalloc.h>
>   #include <asm/daifflags.h>
>   #include <asm/vmap_stack.h>
> +#include <asm/exception.h>
>   
>   /* Only access this in an NMI enter/exit */
>   DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
> @@ -71,6 +72,18 @@ static void init_irq_stacks(void)
>   }
>   #endif
>   
> +#ifndef CONFIG_PREEMPT_RT
> +static void ____do_softirq(struct pt_regs *regs)
> +{
> +	__do_softirq();
> +}
> +
> +void do_softirq_own_stack(void)
> +{
> +	call_on_irq_stack(NULL, ____do_softirq);
> +}
> +#endif
> +
>   static void default_handle_irq(struct pt_regs *regs)
>   {
>   	panic("IRQ taken without a root IRQ handler\n");

-- 
Thanks,
Qi
