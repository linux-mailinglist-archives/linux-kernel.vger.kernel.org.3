Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919BA4EA9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiC2Ix5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiC2Ixr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:53:47 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553A9939CE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:52:04 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-df0940c4eeso4549865fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kH8pAcoNjQYCA55yLv6TluBaUgL1Exq9SVpfrTvzIs=;
        b=kUUtVsrr6KVp6A8595f2Bo8SPMTe4Qjtb8M/f8urx5pnp61iAD3SZtFDk2rtgzk1cY
         bGImPSiGarLOTjdf0TybWE5kPqNrr9oUCdVxTgwdid+NXKHPJ+G9YMs+WLUR3OYWIKjx
         T/W5lggd/VSq80SBJ09vtOvhA68ZxSBtDZpzi5gbHvcOj6TF1BOEwqjx46snk+7WfJFD
         1j81h8P5jGJu/dVQZ1fVwCgGFLRPKVrrk84XPasUNIAEHwLuDusCJTcOfXjCiDWdbI9y
         SVa3Gb7hmsd0fxWkqWn2lAGlJAfsiBv1uYIVbix+FofHiVGbHfIG9b+lO50md4mWBxTl
         E54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kH8pAcoNjQYCA55yLv6TluBaUgL1Exq9SVpfrTvzIs=;
        b=zpCeIldk+GP90EGyXPMgfd23eVlq4+MjopYoLx269ZbZTWchYaWpDHvtAMttLSasCi
         5zg+DBUaRPhmVY3/2pzeW88s39aNxG5jtP88W3UCOtCAfWd4CAoxvLJ5CRPQMRS/EsUr
         wv2S3nwxNx2lkMYOgeC+VfDIjJW6aQ5xFaU0JPHJfA2DJcG7g+TbKck28KlZwi0WYmPn
         i4Sx0H00NRtWCuZE+xU2lSp5xBt6ldszx1gKViknnx1vGm5HHOiJ6d4CIBKaQWlI3mXS
         5lX7qkb9QyGTykANravITCd/pAGTCdrn4qHu6ai6aQKXLMX8uGFa29DNseEFtly37Sc5
         1ROQ==
X-Gm-Message-State: AOAM532yq9JjL2nfxgR3WpVSdI4WdoDv6+HV2wIFJ7u3SahfsYPf6Zch
        +h6JjYbuXbZCsOxrS4GAoh/MeyVmfaii25wT1RD5lg==
X-Google-Smtp-Source: ABdhPJxQ1oyXEIRMc44EsRPCZYfsdeQM6GVz6j8ctOUgswgXBIGQRRbE++vTPKhM0h8E59gjqOQwaM2w22Hi8MC6yb0=
X-Received: by 2002:a05:6870:8196:b0:dd:e471:8bb5 with SMTP id
 k22-20020a056870819600b000dde4718bb5mr815646oae.294.1648543923470; Tue, 29
 Mar 2022 01:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com> <20220314200148.2695206-7-kaleshsingh@google.com>
In-Reply-To: <20220314200148.2695206-7-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 29 Mar 2022 09:51:27 +0100
Message-ID: <CA+EHjTw-A8qu924yGfjbhXLqoBssBz4iDb7WNMs3zej+Q==iWQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] KVM: arm64: Add hypervisor overflow stack
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
        Andrew Jones <drjones@redhat.com>,
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

On Mon, Mar 14, 2022 at 8:05 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Allocate and switch to 16-byte aligned secondary stack on overflow. This
> provides us stack space to better handle overflows; and is used in
> a subsequent patch to dump the hypervisor stacktrace. The overflow stack
> is only allocated if CONFIG_NVHE_EL2_DEBUG is enabled, as hypervisor
> stacktraces is a debug feature dependent on CONFIG_NVHE_EL2_DEBUG.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad



> ---
>
> Changes in v4:
>   - Update comment to clarify resetting the SP to the top of the stack
>     only happens if CONFIG_NVHE_EL2_DEBUG is disabled, per Fuad
>
>
>  arch/arm64/kvm/hyp/nvhe/host.S   | 11 ++++++++---
>  arch/arm64/kvm/hyp/nvhe/switch.c |  5 +++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index be6d844279b1..a0c4b4f1549f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -179,13 +179,18 @@ SYM_FUNC_END(__host_hvc)
>         b       hyp_panic
>
>  .L__hyp_sp_overflow\@:
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +       /* Switch to the overflow stack */
> +       adr_this_cpu sp, hyp_overflow_stack + PAGE_SIZE, x0
> +#else
>         /*
> -        * Reset SP to the top of the stack, to allow handling the hyp_panic.
> -        * This corrupts the stack but is ok, since we won't be attempting
> -        * any unwinding here.
> +        * If !CONFIG_NVHE_EL2_DEBUG, reset SP to the top of the stack, to
> +        * allow handling the hyp_panic. This corrupts the stack but is ok,
> +        * since we won't be attempting any unwinding here.
>          */
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
> 2.35.1.723.g4982287a31-goog
>
