Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2552D521147
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiEJJsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiEJJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:48:36 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D829B81C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:44:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w130so6081937oig.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYmmaSjEQ0DAQ3hg78JmoXw7IWzTfCf5R6XNgYIbQdw=;
        b=jCnsf3hK1Pir0MXvc5uMjsEDPJnUI43QrFH+brw/Jo2vC6JSYoNSPTUX2qfDOJZQvf
         HUWB+IHA3rcd9mhQPx6R/EXneddFLEbJeYWjrRiGFPrgVvQnLOSEC+Xmh5brb/vcOqYj
         SNj66hg7iLoRFudTYvCzNI3qm5tMvIQ5pgrEWeK38YkYHMDDuMT/6BSbHrqdVWO+2HJR
         TLF2DKCb/iU6Wt1bZBpEhNA71HvYwYqmNyFreQULZ3U362tk6ARL/I1Cw9kjbWWopUbC
         fusK9b2Q7CQuUuPMnQTUcnoszsTym+W4jqOu/GBwu4egVLuEheEp8Sdm8ERqeZgd/nio
         Tclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYmmaSjEQ0DAQ3hg78JmoXw7IWzTfCf5R6XNgYIbQdw=;
        b=tXSTkUAM3Jcz54LEMkqbTQJ4vWLhaGLuaF9WBgeq3bj3ycrDb66JRsTrl3X0/B798/
         tPQ4xdsKn3bdaFAnxiYoEbT8zkr1iYSuK04nXK5CBs7zl7Tcgo0T7VuaTigjRf5OQmeq
         FNCt/+wb3jfO+HQBC2Kari1PYzkMBcMpp1JviGd5MfrKAvSXmYeoPb0Y96Flu3Ze7Soe
         KdZmPsB5khaO/6GNkVA0jly3ygZz2drL/7zjt5iKVQA4F1kCq+FcxY4QXUSUJg6zSWOt
         WQ5Sv9r6IJVxg1ESDouimQIPI8hs+0rwMWogC7BTxTm1Wkzxc14OcwHNOx4rXimauiiK
         WLhQ==
X-Gm-Message-State: AOAM533KisDLj4XCZVbNkz8y6rTOcdyHZVQ2GqOhzwdaz9WOKEzrKjx2
        6Ke7HZ+Nf7t1+7/wpbuVFrheFjSk9aajcJe3yvfljQ==
X-Google-Smtp-Source: ABdhPJwi2uvaLL5WnzUOVGJ8SKVlBEr9x64tGdRwKs5uPLqPlRBlIPuG/lgPmYNqeBIi9V5qKOAF0+eR3XEjjvTNyWo=
X-Received: by 2002:aca:180b:0:b0:2f7:23ae:8cd1 with SMTP id
 h11-20020aca180b000000b002f723ae8cd1mr13432825oih.146.1652175878175; Tue, 10
 May 2022 02:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220509162559.2387784-1-oupton@google.com> <20220509162559.2387784-2-oupton@google.com>
In-Reply-To: <20220509162559.2387784-2-oupton@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 May 2022 10:44:01 +0100
Message-ID: <CA+EHjTz3J4aJ3MximOc1ybZQV8yNG7Z9gyQPFrm2XtrF-zUAxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: pkvm: Drop unnecessary FP/SIMD trap handler
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, qperret@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Mon, May 9, 2022 at 5:26 PM Oliver Upton <oupton@google.com> wrote:
>
> The pVM-specific FP/SIMD trap handler just calls straight into the
> generic trap handler. Avoid the indirection and just call the hyp
> handler directly.
>
> Note that the BUILD_BUG_ON() pattern is repeated in
> pvm_init_traps_aa64pfr0(), which is likely a better home for it.
>
> No functional change intended.

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>
> Signed-off-by: Oliver Upton <oupton@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/switch.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 6410d21d8695..3dee2ad96e10 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -175,23 +175,6 @@ static bool kvm_handle_pvm_sys64(struct kvm_vcpu *vcpu, u64 *exit_code)
>                 kvm_handle_pvm_sysreg(vcpu, exit_code));
>  }
>
> -/**
> - * Handler for protected floating-point and Advanced SIMD accesses.
> - *
> - * Returns true if the hypervisor has handled the exit, and control should go
> - * back to the guest, or false if it hasn't.
> - */
> -static bool kvm_handle_pvm_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
> -{
> -       /* Linux guests assume support for floating-point and Advanced SIMD. */
> -       BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_FP),
> -                               PVM_ID_AA64PFR0_ALLOW));
> -       BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_ASIMD),
> -                               PVM_ID_AA64PFR0_ALLOW));
> -
> -       return kvm_hyp_handle_fpsimd(vcpu, exit_code);
> -}
> -
>  static const exit_handler_fn hyp_exit_handlers[] = {
>         [0 ... ESR_ELx_EC_MAX]          = NULL,
>         [ESR_ELx_EC_CP15_32]            = kvm_hyp_handle_cp15_32,
> @@ -207,7 +190,7 @@ static const exit_handler_fn pvm_exit_handlers[] = {
>         [0 ... ESR_ELx_EC_MAX]          = NULL,
>         [ESR_ELx_EC_SYS64]              = kvm_handle_pvm_sys64,
>         [ESR_ELx_EC_SVE]                = kvm_handle_pvm_restricted,
> -       [ESR_ELx_EC_FP_ASIMD]           = kvm_handle_pvm_fpsimd,
> +       [ESR_ELx_EC_FP_ASIMD]           = kvm_hyp_handle_fpsimd,
>         [ESR_ELx_EC_IABT_LOW]           = kvm_hyp_handle_iabt_low,
>         [ESR_ELx_EC_DABT_LOW]           = kvm_hyp_handle_dabt_low,
>         [ESR_ELx_EC_PAC]                = kvm_hyp_handle_ptrauth,
> --
> 2.36.0.512.ge40c2bad7a-goog
>
