Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BCD54B85F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbiFNSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbiFNSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:15:12 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0A1A040
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:15:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3137316bb69so38041347b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8/2+wu+PsORoT0rrjFQwUQli114atWqejDxqt8afco=;
        b=BFx2nJFuweeoIaiSk88tCK+Zvw/48JIpbtu0DqX6f/hV+jNuutdiHEAglJEN3NBoDU
         t1VXH8kqiON/rit1qB1/lZ/zauzkEapcDmpRo6A/gozVX61yAIfYE8N7WeRDRT1ZTYEL
         LM7k4VXG88rZ21uChYEzNZphXMtmzUGZ/nMgAr+lvM00cgknWByKrHMEGd6QBptun3YW
         qmRPuBmHQqJW8ZARpdFifG4e2nEkENmFsELeBnylz/XzT+jkn+BZFNh+ujTONbSQI5pV
         xxP7nK7Fw3aZYfrdt2qEaQY3TRXip1WYtiYQKe3Qdo9qNBliA1j8ZaDPB1JgGfbA4GRD
         UOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8/2+wu+PsORoT0rrjFQwUQli114atWqejDxqt8afco=;
        b=MWxxFx9SV7J389lKsI3jfFVOQrsysbHe7luTkoDOKqh4r1L3ro+mLlsCJwoajdip8m
         TIlB5QG2MW4Ftr9GIJ+FM6ffb+0w9Hnn36cxkPVVbi1vVIqSNdAKEXmmEkiQPKF1ctWU
         FcVibO14iw1TUOe+vXWNA59FD/okHP9/6jMKbgIE2QzbPjq6sk4XoRxE2ds8KjHmoZkZ
         dtpWOYmp/+Mnk4tLhcm4bDB6PM2MuXmcpVRjbc7AKwNbUTYm0C5uiyB1enYbUybiLmzC
         ldh/PiWuUnNiT9CeqAnZpDXn7nWPWQGfYc1/aNmw/ADpQT44c6XXOHAUciDKtB51TEgU
         +AhA==
X-Gm-Message-State: AJIora9c4lH3E5EUfxi/U8KiWUohNwOkUW9aQDmRojp8x3vs0JhqjtJ1
        /v4HYcVT7dh7leU66kbQh9i3H9FMlPuvVkUkvmT2MA==
X-Google-Smtp-Source: AGRyM1tCLsG24HvArA2qQ8N8ID4VHNuExsG9weA5PfeXAdVigd9V2muc6YeDqSqskiWnDsCe6UppeJ+sTve5pmlxZQw=
X-Received: by 2002:a81:1294:0:b0:313:f850:53b1 with SMTP id
 142-20020a811294000000b00313f85053b1mr6960671yws.181.1655230510732; Tue, 14
 Jun 2022 11:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651774250.git.isaku.yamahata@intel.com> <98939c0ec83a109c8f49045e82096d6cdd5dafa3.1651774251.git.isaku.yamahata@intel.com>
In-Reply-To: <98939c0ec83a109c8f49045e82096d6cdd5dafa3.1651774251.git.isaku.yamahata@intel.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Tue, 14 Jun 2022 11:15:00 -0700
Message-ID: <CAAhR5DHPk2no0PVFX6P1NnZdwtVccjmdn4RLg4wKSmfpjD6Qkg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 090/104] KVM: TDX: Handle TDX PV CPUID hypercall
To:     "Yamahata, Isaku" <isaku.yamahata@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sean Christopherson <seanjc@google.com>
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

On Thu, May 5, 2022 at 11:16 AM <isaku.yamahata@intel.com> wrote:
>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Wire up TDX PV CPUID hypercall to the KVM backend function.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 9c712f661a7c..c7cdfee397ec 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -946,12 +946,34 @@ static int tdx_emulate_vmcall(struct kvm_vcpu *vcpu)
>         return 1;
>  }
>
> +static int tdx_emulate_cpuid(struct kvm_vcpu *vcpu)
> +{
> +       u32 eax, ebx, ecx, edx;
> +
> +       /* EAX and ECX for cpuid is stored in R12 and R13. */
> +       eax = tdvmcall_a0_read(vcpu);
> +       ecx = tdvmcall_a1_read(vcpu);
> +
> +       kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx, true);

According to the GHCI spec section 3.6
(TDG.VP.VMCALL<Instruction.CPUID>) we should return
VMCALL_INVALID_OPERAND if an invalid CPUID is requested.

kvm_cpuid already returns false in this case so we should use that
return value to set the tdvmcall return code in case of invalid leaf.
> +
> +       tdvmcall_a0_write(vcpu, eax);
> +       tdvmcall_a1_write(vcpu, ebx);
> +       tdvmcall_a2_write(vcpu, ecx);
> +       tdvmcall_a3_write(vcpu, edx);
> +
> +       tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_SUCCESS);
> +
> +       return 1;
> +}
> +
>  static int handle_tdvmcall(struct kvm_vcpu *vcpu)
>  {
>         if (tdvmcall_exit_type(vcpu))
>                 return tdx_emulate_vmcall(vcpu);
>
>         switch (tdvmcall_leaf(vcpu)) {
> +       case EXIT_REASON_CPUID:
> +               return tdx_emulate_cpuid(vcpu);
>         default:
>                 break;
>         }
> --
> 2.25.1
>

Sagi
