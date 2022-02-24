Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC48F4C2BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiBXM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiBXM1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:27:40 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6EDBBE10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:27:10 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id j2so2258088oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwPQWibcxWFMgXyN9ojVzSP3LzP6lHj2lJ3iUxgMjZo=;
        b=UBXR2MWYL/s+kIoqgRGAYAptEH4Pc/nZimkfWIwawk2UW5OrLBRBIriDI+z5GgP8K2
         oN5Rh18Lml+7Bn+qfKh11yqwH8Xr6ium0CITxUAYF/VtkBUn9F9Naa3DN24atWoDEirn
         Iw6npN0oSb16EtzPL1tg8TP9yNcT4GoI3MkBnWQIXGsXW/fTT92AKS/5+ewrtpAjJyKv
         YtouZoIqplRqkGT7FlRhU5i+rEslOCdT5HNqp3Np7DGOoy+X0sKaBN7fUyyYNOSwLw12
         Jfcr/RVp8xnyU7eAq6n92RFOWtamJgnHZTa9bsP/dNcGunwXcAF2ZN/cUb44hwFZREoz
         hbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwPQWibcxWFMgXyN9ojVzSP3LzP6lHj2lJ3iUxgMjZo=;
        b=velMIMxpH0hRpiaD87oqLSm4kGKjylPFcRXvRSovBN7yYzab3pETNecHHUb7Mw/Qzr
         1DyK/InedgO5L1j01L+L/YWiisk5sD1/GukJM42U3QPmjKiu6RmJr3P5OBHjcKAfEq56
         HNMnDh4cZEVpX171P9OeZECtEdWVjeSyxXbOvdd6uI7b1MvDEqQ0bY8d8IR/VfBGibH/
         nqmid5RnP8uTAwUQl5n+UaAeOWXG5kmwSdy9L5QTVB2x5dTiOPjQHy+rYLlnWDdGw/Y9
         8i10eqNUeRDSTsQ+JMA8nlNK+pOsYgSBy0RlyYKvQbReUvPFPo5jBXC8S17A29DfamW5
         OaOQ==
X-Gm-Message-State: AOAM531U/ZOWjZteNiyj6dSpOmj1ukDJIw5LSI5BeLThnLIP9Rad93X/
        BGADoZwOCgV3q2mZ0o5onyJdTiVB92N5uK/iP1/aZw==
X-Google-Smtp-Source: ABdhPJyrrakVNa5pcRaScIuNmvHmY+CpOg3ZbilxQyabTPfLuKc9DpV3Splz80s2X3grapbHSv8hLTMNiuCNYtZoQl4=
X-Received: by 2002:a05:6808:ec1:b0:2d6:52f:6405 with SMTP id
 q1-20020a0568080ec100b002d6052f6405mr5741674oiv.124.1645705629835; Thu, 24
 Feb 2022 04:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com> <20220224051439.640768-7-kaleshsingh@google.com>
In-Reply-To: <20220224051439.640768-7-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 24 Feb 2022 12:26:33 +0000
Message-ID: <CA+EHjTwhpjDDnKRU3QrJysgMhYH7eTi2_LrWpxCArLoP-1-BrQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] KVM: arm64: Add hypervisor overflow stack
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        surenb@google.com, kernel-team@android.com,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Thu, Feb 24, 2022 at 5:21 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Allocate and switch to 16-byte aligned secondary stack on overflow. This
> provides us stack space to better handle overflows; and is used in
> a subsequent patch to dump the hypervisor stacktrace. The overflow stack
> is only allocated if CONFIG_NVHE_EL2_DEBUG is enabled, as hypervisor
> stacktraces is a debug feature dependent on CONFIG_NVHE_EL2_DEBUG.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/host.S   | 5 +++++
>  arch/arm64/kvm/hyp/nvhe/switch.c | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index 749961bfa5ba..367a01e8abed 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -179,6 +179,10 @@ SYM_FUNC_END(__host_hvc)
>         b       hyp_panic
>
>  .L__hyp_sp_overflow\@:
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +       /* Switch to the overflow stack */
> +       adr_this_cpu sp, hyp_overflow_stack + PAGE_SIZE, x0
> +#else
>         /*
>          * Reset SP to the top of the stack, to allow handling the hyp_panic.
>          * This corrupts the stack but is ok, since we won't be attempting
> @@ -186,6 +190,7 @@ SYM_FUNC_END(__host_hvc)
>          */

Nit: Maybe you should update this comment as well, since whether it
corrupts the stack or not depends on what happens above with
CONFIG_NVHE_EL2_DEBUG.

Thanks,
/fuad

>         ldr_this_cpu    x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
>         mov     sp, x0
> +#endif
>
>         bl      hyp_panic_bad_stack
>         ASM_BUG()
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 703a5d3f611b..efc20273a352 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -34,6 +34,11 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
>  DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
>  DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
>
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
> +       __aligned(16);
> +#endif
> +
>  static void __activate_traps(struct kvm_vcpu *vcpu)
>  {
>         u64 val;
> --
> 2.35.1.473.g83b2b277ed-goog
>
