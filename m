Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4656374B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGAQBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiGAQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:01:48 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A91D30B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:01:47 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so2203151otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHKjS2hX5qBuSevK018Q0TVoONckTzwODc2zQK9vjyQ=;
        b=aVwAlVX4fKbZdP/EKT3dzLHmALrXN8O3FO1/AUQriNS28v22Nn+K/O2w9wrCeXH5qi
         AXC65wcOqGFnNJXQP/sO2NEX2EO98w7iWl4GtGJpw9GMa5WtFfdiJuWB1xec8aZmLnwD
         TFMTS7BAVjRYYnjKM8y65NSgUnzGyA4DjHJiegb3HrEql909j3nCoI3W8w+AlN49o5k4
         JT9UcfafdfaqI+2tPjbanL6R8+TAbrOmF1c8qpbpDmSPeM/4pAyaBLhKoVFqpEXKze7p
         9dctBXgoPMozD3gHYIZG3wevOSovfhGJbqHG4iykmvzMf7O3MmW2Ic+kbaa9KBFV2UKI
         0kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHKjS2hX5qBuSevK018Q0TVoONckTzwODc2zQK9vjyQ=;
        b=gjNrf03tgFK+9Dia5UCkpBqLUHKc+EQa8X5pZRwm6ZVuPrkeCmizwrWzaYPk9kXlv9
         lWR/KhPePfoI4itJHs+c+HN5BXrzGtR8Ew0DhpJugwu+dgKK1UztMwgsf76Or6wamDGI
         uGp4++8mjGlRMW3nFWsOd7gPn45ewCxh6KZn6G/VyTwb8fvAL/805M3PeyK5ypgVnC/K
         ez8tFZ/ZD9kyznSmhgv2sQK4Or7oNAq3e4hMIOroHLgUjhl3CkjQpSr9ejdSCvOXv7km
         f/yBXIJvYRPHOthDMb5LoskgdG6luM3kxKdD8drLe2hvjNv32J/DsdYJb8AeFnxHZBR0
         7+wA==
X-Gm-Message-State: AJIora+EGLxRKyDYXx3UGrmspjxbDPMzjhTuGjxRXEe87PZ93ypcb6aQ
        S5yu8CG4wYz8jbUxHIPV7Ys4HE8rExA1qitqVb2qCg==
X-Google-Smtp-Source: AGRyM1sYv/9MPLC4DdfRBlT3X+vlDLtvMlHsgI/OE8H/Uvz85QXs+Bry0pQdAoVDgjsjXg+EgUBCYocqS3mrH8MIzkc=
X-Received: by 2002:a05:6830:14:b0:616:dcbd:e53e with SMTP id
 c20-20020a056830001400b00616dcbde53emr6534039otp.267.1656691306392; Fri, 01
 Jul 2022 09:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-21-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-21-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 1 Jul 2022 09:01:35 -0700
Message-ID: <CALMp9eTVAOCvWQ-3A6VmwhJk6skES9phMPC3O-za7Rk05SfVTg@mail.gmail.com>
Subject: Re: [PATCH v2 20/28] KVM: VMX: Add missing VMENTRY controls to vmcs_config
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, add the VMENTRY controls which KVM doesn't
> use but supports for nVMX to KVM_OPT_VMX_VM_ENTRY_CONTROLS and
> filter them out in vmx_vmentry_ctrl().
>
> No functional change intended.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 +++
>  arch/x86/kvm/vmx/vmx.h | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e5ab77ed37e4..b774b6391e0e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4179,6 +4179,9 @@ static u32 vmx_vmentry_ctrl(void)
>  {
>         u32 vmentry_ctrl = vmcs_config.vmentry_ctrl;
>
> +       /* Not used by KVM but supported for nesting. */
> +       vmentry_ctrl &= ~(VM_ENTRY_SMM | VM_ENTRY_DEACT_DUAL_MONITOR);
> +

LOL! KVM does not emulate the dual-monitor treatment of SMIs and SMM.
Do we actually claim to support these VM-entry controls today?!?

>         if (vmx_pt_mode_is_system())
>                 vmentry_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP |
>                                   VM_ENTRY_LOAD_IA32_RTIT_CTL);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index d4503a38735b..7ada8410a037 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -479,7 +479,9 @@ static inline u8 vmx_get_rvi(void)
>                 __KVM_REQ_VMX_VM_ENTRY_CONTROLS
>  #endif
>  #define KVM_OPT_VMX_VM_ENTRY_CONTROLS                          \
> -       (VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |                  \
> +       (VM_ENTRY_SMM |                                         \
> +       VM_ENTRY_DEACT_DUAL_MONITOR |                           \
> +       VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |                   \
>         VM_ENTRY_LOAD_IA32_PAT |                                \
>         VM_ENTRY_LOAD_IA32_EFER |                               \
>         VM_ENTRY_LOAD_BNDCFGS |                                 \
> --
> 2.35.3
>
