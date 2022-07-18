Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E76E577EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiGRJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiGRJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:46:43 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ACC165B4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:46:42 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso22291074fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2yhmbyv01uOIjeRobhIVpb+L4tkyRO4O4gfBMzGBhI=;
        b=lfPfnFdCPXV+PYM/byQameMx4f1n+wR1U6kVW+W7ZXvueXuwHTda2POXkZBbNuTwra
         ZuHqWOD9twyWuEZd7kVrVCnDPgGzUXoSuqBlE2d8fGS6KrIssr2YGNi/2yhM8KYa2pr6
         uoTWw57eDXSVvJeTXdngK3KyeLFB/MDfzXXtqQuGKOsMu+q5QPH0r7DL+Igz+IGwzHap
         6vRXiCPKIQ0q8u3u/VA7ODLXI0jcxzEO2svrquiJEdfcinWaIu0XLoLgc9P+tgqvaBdi
         YTAWDt096eIfN/D0tDzu5UT4XfLMhDh1EsICVvzwDdnx+4vKZFYpomAIXjxJYqbfhUVS
         k+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2yhmbyv01uOIjeRobhIVpb+L4tkyRO4O4gfBMzGBhI=;
        b=eGfIRSAr3KZXHIooUoxv+5DSZ117GOdbglsWhk9hOL4Jr9G6byzCNL47cDDSVDv9AR
         RspA0tRmwu6bCPcdTadx9iRuiiZ4MC4NT+Eu9mi4otmxucGTPUrlhKkNGYzrm45cs15r
         DZkf2cM6ITZUNWQ9Np+OAukYLtzlq8QIqTr9rRyMR/XVjx0FEKIEojI2JlDnMnWr8OCo
         rTPw/oHUAYRuxgx8HV2bpzr4gk+Pj95IFxjzXd6KUETd8CAk0TPWTdlmkYbOultrh81U
         5CwAqqWjHj2s8LhHf4Yji5oWxVK6MSYFbShPjvCnBuKRYU7x4GkN3vD+ctmcgYsjrxRk
         vSOw==
X-Gm-Message-State: AJIora/uKQ3XfHkp+YMiDhelOiQvq0L/AMHXEFZ9M73W8Tm6f28zG37g
        Paw9St3+DMFiYLOEIb4XWpm0/yCHdX14SFIpc5xvoQ==
X-Google-Smtp-Source: AGRyM1tiyXNFK3NUMUmemwqQqPJMdNJcCB/etqOMbIVxms1eVnfZb8oK+DYQrOYHFVrFuXShXg9xgeZXf0UF/AlVWfQ=
X-Received: by 2002:a05:6808:1182:b0:32d:a9d3:4e0 with SMTP id
 j2-20020a056808118200b0032da9d304e0mr14930043oil.146.1658137602109; Mon, 18
 Jul 2022 02:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-8-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-8-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 18 Jul 2022 10:46:06 +0100
Message-ID: <CA+EHjTxrdacNE-kd2kUSHRZXdgtLZkzwZcamiHaAW4=yfGWtwQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/18] KVM: arm64: On stack overflow switch to hyp overflow_stack
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        drjones@redhat.com, wangkefeng.wang@huawei.com, elver@google.com,
        keirf@google.com, yuzenghui@huawei.com, ardb@kernel.org,
        oupton@google.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        android-mm@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Fri, Jul 15, 2022 at 7:11 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> On hyp stack overflow switch to 16-byte aligned secondary stack.
> This provides us stack space to better handle overflows; and is
> used in a subsequent patch to dump the hypervisor stacktrace.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


> ---
>  arch/arm64/kvm/hyp/nvhe/Makefile     |  2 +-
>  arch/arm64/kvm/hyp/nvhe/host.S       |  9 ++-------
>  arch/arm64/kvm/hyp/nvhe/stacktrace.c | 11 +++++++++++
>  3 files changed, 14 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/stacktrace.c
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index f9fe4dc21b1f..524e7dad5739 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -14,7 +14,7 @@ lib-objs := $(addprefix ../../../lib/, $(lib-objs))
>
>  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
>          hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
> -        cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o
> +        cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o
>  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>          ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
>  obj-$(CONFIG_DEBUG_LIST) += list_debug.o
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index ea6a397b64a6..b6c0188c4b35 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -177,13 +177,8 @@ SYM_FUNC_END(__host_hvc)
>         b       hyp_panic
>
>  .L__hyp_sp_overflow\@:
> -       /*
> -        * Reset SP to the top of the stack, to allow handling the hyp_panic.
> -        * This corrupts the stack but is ok, since we won't be attempting
> -        * any unwinding here.
> -        */
> -       ldr_this_cpu    x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
> -       mov     sp, x0
> +       /* Switch to the overflow stack */
> +       adr_this_cpu sp, overflow_stack + OVERFLOW_STACK_SIZE, x0
>
>         b       hyp_panic_bad_stack
>         ASM_BUG()
> diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> new file mode 100644
> index 000000000000..a3d5b34e1249
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KVM nVHE hypervisor stack tracing support.
> + *
> + * Copyright (C) 2022 Google LLC
> + */
> +#include <asm/memory.h>
> +#include <asm/percpu.h>
> +
> +DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
> +       __aligned(16);
> --
> 2.37.0.170.g444d1eabd0-goog
>
