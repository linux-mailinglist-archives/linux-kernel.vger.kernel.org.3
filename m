Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF85340EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbiEYP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245361AbiEYP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:59:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B756AA65
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:59:02 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 520A13FBC8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653494340;
        bh=ceTyIPuj0mdwf7qJM6JGPSBEklD8LtuaTMx0pA8AGQY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=c8Js8xHkJ4fKB3A/KehTCyEvJf2V87eptFJkfui6XZiwXaeZ3HmeP2xY7H8W4alKX
         cZwNztJTdFITrUJU5rZnkVNjFqfEwSpgqdC52V0s7mcsVmyaJxwVStr6vRSIhsNpB+
         VKsyNZAdToWpmoysVo/Mxny80eI5NGX+qIIGE3m1Mp+e+EvxlupnCUZJdQ7SqO4ntE
         gnZ9NdlGmiJSpu4ZvsfxiqTQFK5/cGwCGnCuhKVGpSFaG/IhJwJRCjUmgQxUpHbLMk
         KVDqZF7Vni7e/oXk054DhRBuUhDZ9JfN97QMFWiAErsmVlkOrULpOrv7jhIYsLLeoh
         I8zIWhRJKwxMA==
Received: by mail-ed1-f72.google.com with SMTP id w23-20020aa7da57000000b0042acd76347bso15134574eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ceTyIPuj0mdwf7qJM6JGPSBEklD8LtuaTMx0pA8AGQY=;
        b=S85pX7qWPxGNrO6DSqSuOKz8qRYTOJ3heMpidv4SYi2Rym0YXR8XwBYZjVFl0KYWz6
         dmFf4n1StAEXam6Xq5MC1G9s981lQvTaMd2JMXBFiI7TxBMJrGwdOxQNm8gTYMlIl3YS
         0n/OBJx2TuZzrdlf/HPul1Xmz4VuOjhd2sHxQG/JEkQhRzL7jraOd1u67dBBJIubwTKp
         y2i/Z1q95DE1eXXLjDVLmkfZ4OC9MhJ3esBsGUaa06uNbnduEY0SFfApXJH9/XOUzFjd
         9nRnrtyEps6IfaU2PlSNB4RSdCse8DuVbUOphJSxUD5WhiEGoXuYJAJRnmwuxO741oxa
         VMsw==
X-Gm-Message-State: AOAM530Jcwayw2puTEK65JtQXFdAQsH6DvEjCi808B3YEvb+XbixxPF7
        ZGlqYOGyAHrIvjKTyQcwleglJKRWPPBa5sljUuixH6N7nAep4DEauBj7JjHt3KuGetLYhhLcjR5
        jB7psPUWxnK9wPVe6qgzjkaoZs751aRtghUjvsB5ACg==
X-Received: by 2002:aa7:c615:0:b0:42b:cdcc:5844 with SMTP id h21-20020aa7c615000000b0042bcdcc5844mr2769930edq.312.1653494339816;
        Wed, 25 May 2022 08:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx94oaHZAUQqbKeS616bkQPP3+D2aG2FQiBBhy3mgd3CzCggc7oTgSKb95EHir2Xerc0gQJxg==
X-Received: by 2002:aa7:c615:0:b0:42b:cdcc:5844 with SMTP id h21-20020aa7c615000000b0042bcdcc5844mr2769909edq.312.1653494339621;
        Wed, 25 May 2022 08:58:59 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id my44-20020a1709065a6c00b006f3ef214de4sm7747900ejc.74.2022.05.25.08.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:58:59 -0700 (PDT)
Message-ID: <fff02688-e272-3462-d950-427ebe4ad862@canonical.com>
Date:   Wed, 25 May 2022 17:58:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/5] riscv: smp: Support for 64bit hartid
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-4-sunilvl@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220525151106.2176147-4-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 17:11, Sunil V L wrote:
> The hartid can be a 64bit value on RV64 platforms. This patch
> modifies the hartid parameter in riscv_hartid_to_cpuid() as
> unsigned long so that it can hold 64bit value on RV64 platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   arch/riscv/include/asm/smp.h | 4 ++--
>   arch/riscv/kernel/smp.c      | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 23170c933d73..d3443be7eedc 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -42,7 +42,7 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
>   /* Hook for the generic smp_call_function_single() routine. */
>   void arch_send_call_function_single_ipi(int cpu);
>   
> -int riscv_hartid_to_cpuid(int hartid);
> +int riscv_hartid_to_cpuid(unsigned long hartid);
>   
>   /* Set custom IPI operations */
>   void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
> @@ -70,7 +70,7 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
>   {
>   }
>   
> -static inline int riscv_hartid_to_cpuid(int hartid)
> +static inline int riscv_hartid_to_cpuid(unsigned long hartid)
>   {
>   	if (hartid == boot_cpu_hartid)
>   		return 0;
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index b5d30ea92292..018e7dc45df6 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -47,7 +47,7 @@ static struct {
>   	unsigned long bits ____cacheline_aligned;
>   } ipi_data[NR_CPUS] __cacheline_aligned;
>   
> -int riscv_hartid_to_cpuid(int hartid)
> +int riscv_hartid_to_cpuid(unsigned long hartid)
>   {
>   	int i;
>   
> @@ -55,7 +55,7 @@ int riscv_hartid_to_cpuid(int hartid)
>   		if (cpuid_to_hartid_map(i) == hartid)
>   			return i;
>   
> -	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
> +	pr_err("Couldn't find cpu id for hartid [%lu]\n", hartid);
>   	return -ENOENT;
>   }
>   

