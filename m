Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5A4C3A28
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiBYAKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiBYAKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:10:38 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690E3214F9F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:10:07 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id n185so3264606qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q3CZZYtJeP2l+fxZkQ3EE8z5FRZjqoAzMgZD2lUMhaY=;
        b=NRkreSDDXeHNVpp+KFf6lQSzOPpT9NHg2GR/fPCDbm1eCzU+Rtdpor+JhP6a8uqIzb
         Fw4y5Ob2v1bb3nMN8dpAxK5Ohmovip3TND9+tPlBksVABsi4v53UNL1Xi+iV29Hsklff
         yq4PN5BAs7KUjz06ZWKols8vMwffplq/2UKgEXFa0V3dYxxfJzdc606AdoUjLzIzLLNo
         +/DRiE/zLlBIHyW/rK2x/x+u0wTVNc01Pd8N1aDuR7pXGpn4r6IBR26h09NS9hArRB46
         Xy3jZZ9ZYcq5IJ/g2bBUKJtEti3kQv6v7a6idW3cHcGUbSc6uDC+dz5ZdBtdsOXe9EUO
         EEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q3CZZYtJeP2l+fxZkQ3EE8z5FRZjqoAzMgZD2lUMhaY=;
        b=phA3bKzL/MR11vK0IngjBiK7OOm+T2cus7vNykOag4CdNDCd223lafoFrcf6JHnZJS
         2mcE+FuN3FfdDfxAn/rWqNC/qXZC3+045NCfSnjDk8rbabzPBtYVweSZ2X87oTvmwtbb
         EHlrQf87lxDdz1mVT3z+HXh5AUVmgyM6e1k+9d+qJyplw92UGDcwIG50gbf48aygTVKE
         oeA5xlBRr1kFREMYLCsbfHFOL5+vdyHXetn3JWVZtiR2P8qATIeIyple6/xYHj6XM89i
         QBHYOQwDZs4jZIujob/mdtMvc1X7ENUaEBtbQzcYmly1jBFps5sktqdlk0EyqprFUtmn
         1xdA==
X-Gm-Message-State: AOAM532fb3aapcnuN+CW5ilCyTSvEKkp30wkZhnn/V+MdRskLnwOfpw8
        6HKverzGAADrJPTSrK0laAo=
X-Google-Smtp-Source: ABdhPJyspLle6NbiBmylr3EspweP3JKDTgqfBvWF9lLpytXvapkdzq4IJrEMzXuwpUS7dqZh8blbLw==
X-Received: by 2002:a05:620a:1124:b0:62c:eb56:d7a9 with SMTP id p4-20020a05620a112400b0062ceb56d7a9mr3439793qkk.353.1645747806474;
        Thu, 24 Feb 2022 16:10:06 -0800 (PST)
Received: from mail.google.com ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id p22-20020a37a616000000b00547b8839339sm523743qke.77.2022.02.24.16.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:10:06 -0800 (PST)
Date:   Fri, 25 Feb 2022 08:10:00 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: fix oops caused by irqsoff latency tracer
Message-ID: <20220225001000.ccxaotz6v64ldlap@mail.google.com>
References: <20220213081845.9864-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213081845.9864-1-changbin.du@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello, kindly ping for review status. :)

On Sun, Feb 13, 2022 at 04:18:45PM +0800, Changbin Du wrote:
> The trace_hardirqs_{on,off}() require the caller to setup frame pointer
> properly. This because these two functions use macro 'CALLER_ADDR1' (aka.
> __builtin_return_address(1)) to acquire caller info. If the $fp is used
> for other purpose, the code generated this macro (as below) could trigger
> memory access fault.
> 
>    0xffffffff8011510e <+80>:    ld      a1,-16(s0)
>    0xffffffff80115112 <+84>:    ld      s2,-8(a1)  # <-- paging fault here
> 
> The oops message during booting if compiled with 'irqoff' tracer enabled:
> [    0.039615][    T0] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000f8
> [    0.041925][    T0] Oops [#1]
> [    0.042063][    T0] Modules linked in:
> [    0.042864][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc1-00233-g9a20c48d1ed2 #29
> [    0.043568][    T0] Hardware name: riscv-virtio,qemu (DT)
> [    0.044343][    T0] epc : trace_hardirqs_on+0x56/0xe2
> [    0.044601][    T0]  ra : restore_all+0x12/0x6e
> [    0.044721][    T0] epc : ffffffff80126a5c ra : ffffffff80003b94 sp : ffffffff81403db0
> [    0.044801][    T0]  gp : ffffffff8163acd8 tp : ffffffff81414880 t0 : 0000000000000020
> [    0.044882][    T0]  t1 : 0098968000000000 t2 : 0000000000000000 s0 : ffffffff81403de0
> [    0.044967][    T0]  s1 : 0000000000000000 a0 : 0000000000000001 a1 : 0000000000000100
> [    0.045046][    T0]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.045124][    T0]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000054494d45
> [    0.045210][    T0]  s2 : ffffffff80003b94 s3 : ffffffff81a8f1b0 s4 : ffffffff80e27b50
> [    0.045289][    T0]  s5 : ffffffff81414880 s6 : ffffffff8160fa00 s7 : 00000000800120e8
> [    0.045389][    T0]  s8 : 0000000080013100 s9 : 000000000000007f s10: 0000000000000000
> [    0.045474][    T0]  s11: 0000000000000000 t3 : 7fffffffffffffff t4 : 0000000000000000
> [    0.045548][    T0]  t5 : 0000000000000000 t6 : ffffffff814aa368
> [    0.045620][    T0] status: 0000000200000100 badaddr: 00000000000000f8 cause: 000000000000000d
> [    0.046402][    T0] [<ffffffff80003b94>] restore_all+0x12/0x6e
> 
> This because the $fp(aka. $s0) register is not used as frame pointer in the
> assembly entry code.
> 
> 	resume_kernel:
> 		REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
> 		bnez s0, restore_all
> 		REG_L s0, TASK_TI_FLAGS(tp)
>                 andi s0, s0, _TIF_NEED_RESCHED
>                 beqz s0, restore_all
>                 call preempt_schedule_irq
>                 j restore_all
> 
> To fix above issue, here we add one extra level wrapper for function
> trace_hardirqs_{on,off}() so they can be safely called by low level entry
> code.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v4: update explanation.
> v3: fix warning reported by documentation system.
> v2: fix compile warning.
> ---
>  arch/riscv/kernel/Makefile    |  2 ++
>  arch/riscv/kernel/entry.S     | 10 +++++-----
>  arch/riscv/kernel/trace_irq.c | 27 +++++++++++++++++++++++++++
>  arch/riscv/kernel/trace_irq.h | 11 +++++++++++
>  4 files changed, 45 insertions(+), 5 deletions(-)
>  create mode 100644 arch/riscv/kernel/trace_irq.c
>  create mode 100644 arch/riscv/kernel/trace_irq.h
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 612556faa527..ffc87e76b1dd 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -51,6 +51,8 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
>  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>  
> +obj-$(CONFIG_TRACE_IRQFLAGS)	+= trace_irq.o
> +
>  obj-$(CONFIG_RISCV_BASE_PMU)	+= perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index ed29e9c8f660..d6a46ed0bf05 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -108,7 +108,7 @@ _save_context:
>  .option pop
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
> -	call trace_hardirqs_off
> +	call __trace_hardirqs_off
>  #endif
>  
>  #ifdef CONFIG_CONTEXT_TRACKING
> @@ -143,7 +143,7 @@ skip_context_tracking:
>  	li t0, EXC_BREAKPOINT
>  	beq s4, t0, 1f
>  #ifdef CONFIG_TRACE_IRQFLAGS
> -	call trace_hardirqs_on
> +	call __trace_hardirqs_on
>  #endif
>  	csrs CSR_STATUS, SR_IE
>  
> @@ -234,7 +234,7 @@ ret_from_exception:
>  	REG_L s0, PT_STATUS(sp)
>  	csrc CSR_STATUS, SR_IE
>  #ifdef CONFIG_TRACE_IRQFLAGS
> -	call trace_hardirqs_off
> +	call __trace_hardirqs_off
>  #endif
>  #ifdef CONFIG_RISCV_M_MODE
>  	/* the MPP value is too large to be used as an immediate arg for addi */
> @@ -270,10 +270,10 @@ restore_all:
>  	REG_L s1, PT_STATUS(sp)
>  	andi t0, s1, SR_PIE
>  	beqz t0, 1f
> -	call trace_hardirqs_on
> +	call __trace_hardirqs_on
>  	j 2f
>  1:
> -	call trace_hardirqs_off
> +	call __trace_hardirqs_off
>  2:
>  #endif
>  	REG_L a0, PT_STATUS(sp)
> diff --git a/arch/riscv/kernel/trace_irq.c b/arch/riscv/kernel/trace_irq.c
> new file mode 100644
> index 000000000000..095ac976d7da
> --- /dev/null
> +++ b/arch/riscv/kernel/trace_irq.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
> + */
> +
> +#include <linux/irqflags.h>
> +#include <linux/kprobes.h>
> +#include "trace_irq.h"
> +
> +/*
> + * trace_hardirqs_on/off require the caller to setup frame pointer properly.
> + * Otherwise, CALLER_ADDR1 might trigger an pagging exception in kernel.
> + * Here we add one extra level so they can be safely called by low
> + * level entry code which $fp is used for other purpose.
> + */
> +
> +void __trace_hardirqs_on(void)
> +{
> +	trace_hardirqs_on();
> +}
> +NOKPROBE_SYMBOL(__trace_hardirqs_on);
> +
> +void __trace_hardirqs_off(void)
> +{
> +	trace_hardirqs_off();
> +}
> +NOKPROBE_SYMBOL(__trace_hardirqs_off);
> diff --git a/arch/riscv/kernel/trace_irq.h b/arch/riscv/kernel/trace_irq.h
> new file mode 100644
> index 000000000000..99fe67377e5e
> --- /dev/null
> +++ b/arch/riscv/kernel/trace_irq.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
> + */
> +#ifndef __TRACE_IRQ_H
> +#define __TRACE_IRQ_H
> +
> +void __trace_hardirqs_on(void);
> +void __trace_hardirqs_off(void);
> +
> +#endif /* __TRACE_IRQ_H */
> -- 
> 2.32.0
> 

-- 
Cheers,
Changbin Du
