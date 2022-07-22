Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BDE57DDE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiGVJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiGVJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:20:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE0FBB8CC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:13:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3708295pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OFu95XsV5rEYBt/DoXMJzDAz5PRwolc7OS134C8DnKc=;
        b=0fFghdJIPyc8ja/Ja4cKlCxsHImbwt+x6cqArGd1WjVLRO4xLsTp5Ca04dFVCKuBNy
         Ta+da7cU7Xo+M+dPdbyJDLrM5tL+bKeXEp3EcjbveyUQCvoKhmEVRi93T35xYtim1vv+
         GSzumERbIJEqvSZ5EW9yMhkKCP8l/8QVrL8/DMr3lYL0Rd7KamuMNvpZ3iLlt5nFNDKL
         RfTayBaT+0CLhFuTN8dWH0NxsH0JbbpqgBHNgBx2p5qeUZzS4esMo94tI7Cu+0Kv6oiY
         Jn5cvW95wnOV/W8+XQk1skB9V70mIOsQdccwk69ISskNQCyRWGc+E/bJeEaHSwE9jTnU
         IeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OFu95XsV5rEYBt/DoXMJzDAz5PRwolc7OS134C8DnKc=;
        b=HaAOHSot6MPDZlD51rB/HilcwSPFRUpldUxyns37J6zIvve2X5d4/bkMh9cx6b+UA1
         5k+5TJubk+A8dFBrWjF91USuNEz5RfhDN++xA1OAMHbtQv4qmOd7EKTF3CCZQ32aIhno
         oxgM+/7g2E5OBO4lWQ/sVqr68xfKQcNgqgmruNU+W4GpyPYedlOkt7wakJQ53WDTa/m3
         6NW/MnQuT9LTFqfGPPTInlhiQl+vhA3I9h/GDwa69BZiwtmrxMktigInAP55X/gLrmNu
         cMCZSqhaih3xZ3kbhDh8a87YUmAw9u0ysnlWIoA/k8Q9BOLaLmy6gQAXeFIHrwQfevpu
         ZkEA==
X-Gm-Message-State: AJIora89UKuVY8Mt79kIMxTBWe3xVnOKBYoDClx1kxuHDbCerQ7QqROr
        d7BQjHz0icwfkdvKvTQSYzySUA==
X-Google-Smtp-Source: AGRyM1v6F78+NCt09f2hsDWr95VGuj60HNdNaZDsiSJ72K0JCl0CYXqR5FUuwfkIkofOdUs4kEv6kw==
X-Received: by 2002:a17:902:c94b:b0:16c:7289:b402 with SMTP id i11-20020a170902c94b00b0016c7289b402mr2486506pla.66.1658481224853;
        Fri, 22 Jul 2022 02:13:44 -0700 (PDT)
Received: from [10.4.231.121] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902778c00b0016d1f474653sm2923403pll.52.2022.07.22.02.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:13:44 -0700 (PDT)
Message-ID: <d540aaff-ec6a-3f25-dd79-b27b4ad81b36@bytedance.com>
Date:   Fri, 22 Jul 2022 17:13:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH v1 1/2] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     arnd@arndb.de, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
 <20220708094950.41944-2-zhengqi.arch@bytedance.com>
 <20220722090440.GB18125@willie-the-truck>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220722090440.GB18125@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/22 17:04, Will Deacon wrote:
> On Fri, Jul 08, 2022 at 05:49:49PM +0800, Qi Zheng wrote:
>> Currently arm64 supports per-CPU IRQ stack, but softirqs
>> are still handled in the task context.
>>
>> Since any call to local_bh_enable() at any level in the task's
>> call stack may trigger a softirq processing run, which could
>> potentially cause a task stack overflow if the combined stack
>> footprints exceed the stack's size, let's run these softirqs
>> on the IRQ stack as well.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/arm64/Kconfig      |  1 +
>>   arch/arm64/kernel/irq.c | 13 +++++++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4c1e1d2d2f8b..be0a9f0052ee 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -230,6 +230,7 @@ config ARM64
>>   	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
>>   	select TRACE_IRQFLAGS_SUPPORT
>>   	select TRACE_IRQFLAGS_NMI_SUPPORT
>> +	select HAVE_SOFTIRQ_ON_OWN_STACK
>>   	help
>>   	  ARM 64-bit (AArch64) Linux support.
>>   
>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>> index bda49430c9ea..c36ad20a52f3 100644
>> --- a/arch/arm64/kernel/irq.c
>> +++ b/arch/arm64/kernel/irq.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/vmalloc.h>
>>   #include <asm/daifflags.h>
>>   #include <asm/vmap_stack.h>
>> +#include <asm/exception.h>
>>   
>>   /* Only access this in an NMI enter/exit */
>>   DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
>> @@ -71,6 +72,18 @@ static void init_irq_stacks(void)
>>   }
>>   #endif
>>   
>> +#ifndef CONFIG_PREEMPT_RT
>> +static void ____do_softirq(struct pt_regs *regs)
>> +{
>> +	__do_softirq();
>> +}
>> +
>> +void do_softirq_own_stack(void)
>> +{
>> +	call_on_irq_stack(NULL, ____do_softirq);
>> +}
>> +#endif
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Please can you repost this at -rc1 and we can queue it up for 5.21?

Sure, will do.

Thanks,
Qi

> 
> Thanks,
> 
> Will

-- 
Thanks,
Qi
