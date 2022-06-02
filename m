Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EC753C076
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiFBVow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbiFBVot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:44:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BE2DAAF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:44:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id d129so5779892pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=eLN+ke3JsL0Xd2DCVVNgs4G/KL9kR0VkzhMvOSNdBiU=;
        b=qyHmhrgGpprS10yTebhwQIMEc6i0RRskunHGge31sJN4WIwdYxf0MqSqu9J1tpyJoU
         ytuHMXfFD0aXbpEUmSsQR4ShCFabWrBfLKQeSNoRUjkzbSe6kXHJ54hrA+X9ZpqwcjIj
         bsyfKF89QY0HrxR8Od1zgREXJAqDahBqfP+apOV5BAHkZJKyXosUuX87nAmd+qp+ym21
         hneO+qwgc+jXgVbFB+VaXXuB/W8cMxZbyKAtYhgYTLA6BPgOO76GkTe1gvEcoRCwsQCj
         QlsKUtTSCZJpeomzE+NxIvBGoBr4jyGGelMnZMSGpgQmhAzz7JWjrjVRfq2L4IRPp7e5
         5Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=eLN+ke3JsL0Xd2DCVVNgs4G/KL9kR0VkzhMvOSNdBiU=;
        b=Szx2sx6Kfidm60liVAiUgc7y8nCw/mQKPeVx1jSUGEGXKp0t3XX2uQJs2YYppwpoHg
         DGSsMChKXpNMV7XGqnSY3BVcSRQSRb7qP+W7mBEl/qh5QYStQSdzoP5WdjAUftfqhbJJ
         tqCmZuKU7NvLiCNHdw+qdYd5GuApuNLcLh8sxTJ50hb5ytB9PGkg/csb743W+zOgw+Kj
         Qr5Xp4kgfOBFBmBRQ0t9rwpfelY4dPo9b3FdPqgx0tboyn+DMZ2x2ObzQO3G5tbzwn13
         SsQmDN8ywRben8FxykeGmfYsJw68eN7MZa9wCW0z2UJTVjscHbbR/E/ssJPI+Qr7Vk31
         hlug==
X-Gm-Message-State: AOAM532lK92p8nuSub26JHTSH0W386ZoTLUii0zMQbhYoQleRJ5t/X1d
        fvADYQTMo73JTxi95XzDvioCGFEx1cWIKQ==
X-Google-Smtp-Source: ABdhPJwf1y1I2gnoOQkQjZ4lTOi15pUVt+PBvqa3Oes1ITFqGqFM3nAkz2WpTDRrGq8LkLR/Kim9pQ==
X-Received: by 2002:a65:6ccd:0:b0:3c6:2ba2:5f9a with SMTP id g13-20020a656ccd000000b003c62ba25f9amr6075181pgw.216.1654206286689;
        Thu, 02 Jun 2022 14:44:46 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79119000000b00518424f8922sm3961851pfh.77.2022.06.02.14.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 14:44:46 -0700 (PDT)
Date:   Thu, 02 Jun 2022 14:44:46 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Jun 2022 14:44:35 PDT (-0700)
Subject:     Re: [PATCH v3] riscv: add irq stack support
In-Reply-To: <20220515050336.1023-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-9935842d-867d-4fc0-a3bd-e3ee86225798@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022 22:03:36 PDT (-0700), jszhang@kernel.org wrote:
> Currently, IRQs are still handled on the kernel stack of the current
> task on riscv platforms. If the task has a deep call stack at the time
> of interrupt, and handling the interrupt also requires a deep stack,
> it's possible to see stack overflow.
>
> Before this patch, the stack_max_size of a v5.17-rc1 kernel running on
> a lichee RV board gave:
> ~ # cat /sys/kernel/debug/tracing/stack_max_size
> 3736
>
> After this patch,
> ~ # cat /sys/kernel/debug/tracing/stack_max_size
> 3176
>
> We reduce the max kernel stack usage by 560 bytes!
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> since v2:
>  - rebase on v5.18-rcN
>  - update commit msg, I.E remove the "it's possible to reduce the
> THREAD_SIZE to 8KB for RV64 platforms..."
>
> since v1:
>  - add __ro_after_init to the irq_stack[] array.
>
>  arch/riscv/include/asm/thread_info.h |  1 +
>  arch/riscv/kernel/asm-offsets.c      |  2 ++
>  arch/riscv/kernel/entry.S            | 33 +++++++++++++++++++++++++---
>  arch/riscv/kernel/irq.c              | 16 ++++++++++++++
>  4 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 74d888c8d631..98ea73721a0b 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -25,6 +25,7 @@
>  #endif
>  #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
>
> +#define IRQ_STACK_SIZE		THREAD_SIZE
>  /*
>   * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
>   * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index df9444397908..9e32748af0e8 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -37,6 +37,8 @@ void asm_offsets(void)
>  	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
> +	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
> +	OFFSET(TASK_STACK, task_struct, stack);
>
>  	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>  	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index c8b9ce274b9a..e91cae183ef4 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -126,12 +126,39 @@ skip_context_tracking:
>  	 */
>  	bge s4, zero, 1f
>
> -	la ra, ret_from_exception
> +	/* preserve the sp */
> +	move s0, sp
>
> -	/* Handle interrupts */
>  	move a0, sp /* pt_regs */
> +
> +	/*
> +	 * Compare sp with the base of the task stack.
> +	 * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
> +	 * and should switch to the irq stack.
> +	 */
> +	REG_L t0, TASK_STACK(tp)

This fails to build on some configurations, as TASK_STACK doesn't fit 
within the load immediate.  IIRC we added a macro for this at some 
point (to select the short/long addressing sequence), but there's a 
trivial fix

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 99bc411d12f4..095fef82e910 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -136,7 +136,9 @@ skip_context_tracking:
 	 * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
 	 * and should switch to the irq stack.
 	 */
-	REG_L t0, TASK_STACK(tp)
+	li t0, TASK_STACK
+	add t0, t0, tp
+	REG_L t0, 0(t0)
 	xor t0, t0, s0
 	li t1, ~(THREAD_SIZE - 1)
 	and t0, t0, t1

Unfortunatly even with that fix this still blows up early in boot on 
some of my test configs.  Looks like pretty much anything with kasan is 
failing.  Nothing is jumping out at me and it's pretty late so I won't 
have time to debug it myself, sorry.

> +	xor t0, t0, s0
> +	li t1, ~(THREAD_SIZE - 1)
> +	and t0, t0, t1
> +	bnez t0, 2f
> +
> +	la t1, irq_stack
> +	REG_L t2, TASK_TI_CPU(tp)
> +	slli t2, t2, RISCV_LGPTR
> +	add t1, t1, t2
> +	REG_L t2, 0(t1)
> +	li t1, IRQ_STACK_SIZE
> +	/* switch to the irq stack */
> +	add sp, t2, t1
> +
> +2:
> +	/* Handle interrupts */
>  	la a1, generic_handle_arch_irq
> -	jr a1
> +	jalr a1
> +
> +	/* Restore sp */
> +	move sp, s0
> +	j ret_from_exception
>  1:
>  	/*
>  	 * Exceptions run with interrupts enabled or disabled depending on the
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 7207fa08d78f..f20cbfd42e82 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -10,6 +10,8 @@
>  #include <linux/seq_file.h>
>  #include <asm/smp.h>
>
> +void *irq_stack[NR_CPUS] __ro_after_init;
> +
>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
>  	show_ipi_stats(p, prec);
> @@ -18,7 +20,21 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>
>  void __init init_IRQ(void)
>  {
> +	int cpu;
> +
>  	irqchip_init();
>  	if (!handle_arch_irq)
>  		panic("No interrupt controller found.");
> +
> +	for_each_possible_cpu(cpu) {
> +#ifdef CONFIG_VMAP_STACK
> +		void *s = __vmalloc_node(IRQ_STACK_SIZE, THREAD_ALIGN,
> +					 THREADINFO_GFP, cpu_to_node(cpu),
> +					 __builtin_return_address(0));
> +#else
> +		void *s = (void *)__get_free_pages(GFP_KERNEL, get_order(IRQ_STACK_SIZE));
> +#endif
> +
> +		irq_stack[cpu] = s;
> +	}
>  }
