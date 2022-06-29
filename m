Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA53560B03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiF2U2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiF2U2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:28:35 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675AC14D38
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:28:34 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i126so2737538oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KimsAoqWoBrckvrcWpjK4MOnhaDZP2RBKEz3EuP/iv0=;
        b=QHei7/5WL4hfbeuAzCg4LaoNAqlQ2HGQMzjAP0kBgkQJ5H5joM7A64WoPajiwd+Nx+
         s8o6ZDbyUw3coAAFdaWkwagdkTSSy1V8gYj4lxaqO5xIl/hMMi+/fHzAC9NonvcY3W1f
         2gqs9vB5JhKGTIuVKeWbwQZm+OsR+mz+BNOj2QNi1zChQxJmCUPTSe8nuZ2yQMuVFm1o
         +0/vMxfMP4wnXc8B7vxMS7GzZ9xZyhUZGsX9znUXgHwJ2xuNicMKx/yljOJGxVFX2rl3
         0r6zYQ2nC6gKwjNIGKM2m2qvFc3EVDsP6dvht4lpI0Z1w9EcKX74Huo1hSapRM2+8xFX
         7sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KimsAoqWoBrckvrcWpjK4MOnhaDZP2RBKEz3EuP/iv0=;
        b=1jYPsLbJgCHOXPErSq0qzGd2sz5CaHVj4u3Gk82JFad2QIPgOkxdfar2ONDWAU1soG
         s13ZVRiMYyPElt6LCPiUpoWbTl+ev2Zptncf+1H+3Yd378I6wzFyYVBshEU0eznndBKt
         rd3A2GhS0dB80dCz2ImwsFAgrRNgVfjdwRjCUi0cDLnNLTk8jfp14Sc6BD2IA2H/2N59
         Yr1CD3ez2FG8Twn/eSnqpYeIPD04vtQz2b/69W34Ic5jZlriCAgM9ofIQUep0ciHDKMe
         +w4fQiM8jpsqsCpO7IdnxWtyT4OSSCy3AHaijUMTZ2RIvEfsNSr8SRW6VnD+RsoSlJM8
         3/dA==
X-Gm-Message-State: AJIora90lvdxXXRr8KOAAHY1KSl3RQ42UBigMiGY3aDnhNrtGIX2HZiQ
        4nomyBhSzqfyQzWzQH4tmd4e2UU6dGJ1RTv9A/V4YA==
X-Google-Smtp-Source: AGRyM1u0hjO1hiivU9zp5lyMVFAHT9bs3enwDIbNjIaz38j/SCm8ezqQYsGur2WDnSfxG9bJLrv+n90SrLQNKQ6uMrQ=
X-Received: by 2002:a05:6808:2124:b0:335:7483:f62d with SMTP id
 r36-20020a056808212400b003357483f62dmr4297123oiw.112.1656534513612; Wed, 29
 Jun 2022 13:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-15-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-15-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jun 2022 13:28:22 -0700
Message-ID: <CALMp9eRZAJ3srAtEXFy2nZ4ms9xPz=Zqi6B=tXo9_kHRLvoAMg@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] KVM: VMX: Check VM_ENTRY_IA32E_MODE in setup_vmcs_config()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> VM_ENTRY_IA32E_MODE control is toggled dynamically by vmx_set_efer()
> and setup_vmcs_config() doesn't check its existence. On the contrary,
> nested_vmx_setup_ctls_msrs() doesn set it on x86_64. Add the missing
> check and filter the bit out in vmx_vmentry_ctrl().
>
> No (real) functional change intended as all existing CPUs supporting
> long mode and VMX are supposed to have it.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 83feb70d44a9..da8bbba38d0e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2610,6 +2610,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>                 _pin_based_exec_control &= ~PIN_BASED_POSTED_INTR;
>
>         min = VM_ENTRY_LOAD_DEBUG_CONTROLS;
> +#ifdef CONFIG_X86_64
> +       min |= VM_ENTRY_IA32E_MODE;
> +#endif
>         opt = VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
>               VM_ENTRY_LOAD_IA32_PAT |
>               VM_ENTRY_LOAD_IA32_EFER |
> @@ -4242,9 +4245,15 @@ static u32 vmx_vmentry_ctrl(void)
>         if (vmx_pt_mode_is_system())
>                 vmentry_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP |
>                                   VM_ENTRY_LOAD_IA32_RTIT_CTL);
> -       /* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
> -       return vmentry_ctrl &
> -               ~(VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VM_ENTRY_LOAD_IA32_EFER);
> +       /*
> +        * Loading of EFER, VM_ENTRY_IA32E_MODE, and PERF_GLOBAL_CTRL
> +        * are toggled dynamically.
> +        */
Nit: Previously, this could be read as "loading of (EFER and
PERF_GLOBAL_CTRL)." Since "loading" doesn't apply to IA32e mode,
you've lost "loading" of PERF_GLOBAL_CONTROL. Also, why drop the
VM_ENTRY prefix from the MSRs and not from IA32e mode?
Perhaps:

/*
 * IA32e mode, and loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically.
 */

> +       vmentry_ctrl &= ~(VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +                         VM_ENTRY_LOAD_IA32_EFER |
> +                         VM_ENTRY_IA32E_MODE);
> +
> +       return vmentry_ctrl;
>  }
>
>  static u32 vmx_vmexit_ctrl(void)
> --
> 2.35.3
>
Reviewed-by: Jim Mattson <jmattson@google.com>
