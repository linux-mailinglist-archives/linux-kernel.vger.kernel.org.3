Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B73488C94
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiAIViz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbiAIViy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:38:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F4C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:38:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n16so10418199plc.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 13:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rXdw2GcIBdIhjQSHYqX/xAztXUoROrQNXwxR+5wqtUc=;
        b=AgCkFBOYRL6wzgk9rUUtc87/SGNgoOCSNZvxIiEmHu8N65NJ73I7/1fkgcdCabpBya
         sez0kaMYbpf3hBENHp/9iJ6/1NJjScfXXRLN2BIqNQ9z/UnkrwPE4JtAQm+4Ry/NcsZV
         xqBYwshVDlri3NFFMasZ8qU7nPR97cKsDyWa0IyTbTuJ76O6MUG6E11F34sNugcleyWd
         /ekK5I8Kb+3dVeXqBzdBYSAJCMIJkGMDw4VpBT1KjU6Lsls6gecbzPRI1cU3sLNRqIb5
         UTbE+8X4M0Nn8Fsn4MZlKuZKtZKSjZCjqZ0r6TiMddVqeRFkJlQscHOxOl+qoH4H6Y0W
         K6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rXdw2GcIBdIhjQSHYqX/xAztXUoROrQNXwxR+5wqtUc=;
        b=oWsrlvcE+GTHHMifnQL7GIZUYRPOdKEpcW68WxjXTnkqfYxDcgIkcAdDEzBYYjt8y6
         5lqbsYGdjb2rg20MjKjR0jawty6HPo0CbGGzmZzzJfFDhjRLeoVxFyYShN1Fuu41/m5j
         v2cZBWolZxbIBDGgLHDZyXWHxztbVOW4hRFmGpz5OgkhM8T9BbIVvcSQAb1sS+yVznm/
         bGSEgDVmvsrNSjN6GJaUntUEKkbWO3AiMoYUfP9Gz2nxcJSilbVvauRVaXHbXkLCwpRA
         wRGaElCqb7PUOmMt1tF+lmLbAcwgz7YthaiZ2E+PIXGxbfACRP7GgK4Khhfoe2WxJzSR
         pEKw==
X-Gm-Message-State: AOAM531VdcTm1r/rBfVAViZH00Yo5jyh8vqD5N7bhCJQVf7mx9rtENR1
        LuJigrNq7zzURiNjbgqIEYiRUg==
X-Google-Smtp-Source: ABdhPJysUToxCp9VCbTEcOIlt7PoOfuYKVF87cmkQs4e3XpzZEZnM/BsMXSiAxW8rrA31HyQHk8FOw==
X-Received: by 2002:a17:902:7483:b0:14a:2a1e:468d with SMTP id h3-20020a170902748300b0014a2a1e468dmr4301218pll.97.1641764333346;
        Sun, 09 Jan 2022 13:38:53 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id lw5sm6965662pjb.13.2022.01.09.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:38:52 -0800 (PST)
Date:   Sun, 09 Jan 2022 13:38:52 -0800 (PST)
X-Google-Original-Date: Sun, 09 Jan 2022 13:38:18 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Use common riscv_cpuid_to_hartid_mask() for both SMP=y and SMP=n
In-Reply-To: <20211129214342.1221766-1-seanjc@google.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kilobyte@angband.pl, anup@brainfault.org, seanjc@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     seanjc@google.com
Message-ID: <mhng-e5835f2e-6232-4a53-bb14-091d2a07b2aa@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 13:43:42 PST (-0800), seanjc@google.com wrote:
> Use what is currently the SMP=y version of riscv_cpuid_to_hartid_mask()
> for both SMP=y and SMP=n to fix a build failure with KVM=m and SMP=n due
> to boot_cpu_hartid not being exported.  This also fixes a second bug
> where the SMP=n version assumes the sole CPU in the system is in the
> incoming mask, which may not hold true in kvm_riscv_vcpu_sbi_ecall() if
> the KVM guest VM has multiple vCPUs (on a SMP=n system).
>
> Fixes: 1ef46c231df4 ("RISC-V: Implement new SBI v0.2 extensions")
> Reported-by: Adam Borowski <kilobyte@angband.pl>
> Cc: stable@vger.kernel.org
> Reviewed-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

This is on for-next, thanks!

> ---
>  arch/riscv/include/asm/smp.h | 10 ++--------
>  arch/riscv/kernel/setup.c    | 10 ++++++++++
>  arch/riscv/kernel/smp.c      | 10 ----------
>  3 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index a7d2811f3536..62d0e6e61da8 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -43,7 +43,6 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
>  void arch_send_call_function_single_ipi(int cpu);
>
>  int riscv_hartid_to_cpuid(int hartid);
> -void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>
>  /* Set custom IPI operations */
>  void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
> @@ -85,13 +84,6 @@ static inline unsigned long cpuid_to_hartid_map(int cpu)
>  	return boot_cpu_hartid;
>  }
>
> -static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
> -					      struct cpumask *out)
> -{
> -	cpumask_clear(out);
> -	cpumask_set_cpu(boot_cpu_hartid, out);
> -}
> -
>  static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
>  {
>  }
> @@ -102,6 +94,8 @@ static inline void riscv_clear_ipi(void)
>
>  #endif /* CONFIG_SMP */
>
> +void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
> +
>  #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
>  bool cpu_has_hotplug(unsigned int cpu);
>  #else
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index b42bfdc67482..63241abe84eb 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -59,6 +59,16 @@ atomic_t hart_lottery __section(".sdata")
>  unsigned long boot_cpu_hartid;
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>
> +void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
> +{
> +	int cpu;
> +
> +	cpumask_clear(out);
> +	for_each_cpu(cpu, in)
> +		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
> +}
> +EXPORT_SYMBOL_GPL(riscv_cpuid_to_hartid_mask);
> +
>  /*
>   * Place kernel memory regions on the resource tree so that
>   * kexec-tools can retrieve them from /proc/iomem. While there
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 2f6da845c9ae..b5d30ea92292 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -59,16 +59,6 @@ int riscv_hartid_to_cpuid(int hartid)
>  	return -ENOENT;
>  }
>
> -void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
> -{
> -	int cpu;
> -
> -	cpumask_clear(out);
> -	for_each_cpu(cpu, in)
> -		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
> -}
> -EXPORT_SYMBOL_GPL(riscv_cpuid_to_hartid_mask);
> -
>  bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>  {
>  	return phys_id == cpuid_to_hartid_map(cpu);
