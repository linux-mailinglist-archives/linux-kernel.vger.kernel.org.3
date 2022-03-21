Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233C34E3008
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352196AbiCUSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352188AbiCUSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:33:58 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC6188A3F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:32:32 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d07ae0b1c4so165300677b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyGzY8l76MsegSAn4xQxjQPLkZzO2340czzi6D4Ior8=;
        b=Ej2kjVjfZTFuj5I2XgPtiMJGOUTZa2UlGmehWn+6/bXjwFlLt3vvGW6qp/Za/xN9fH
         v4Hk1/ip8lasFXz+5aL0B0M4VJKXF4qVcUb8276ltduclc2KWaFsTGi0zr9B/RraDkhA
         fD8Czx/aQABtevWJt4MhO+ulvmAvvgEWsYNu8CEdVK4z2gSYbB1y+P6/TTIzQ9nMvewJ
         NSf7sxvzM2YrA+iNNLQk0A3q6U2Y3HMlG3dOjFEtwnRc8eszCrWcScnCMTHDNIjjlrc7
         wZEsROJjcoKd7liyPjdKYFNXAYGT6OgRr62kuQd1sp6xXzufWYlAjm0Uom1qisVS4QRg
         Cc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyGzY8l76MsegSAn4xQxjQPLkZzO2340czzi6D4Ior8=;
        b=WfEXIDCzRfcuwWw8Z/634Ni9ms8WkQMr6RUspNiUzRLezkSG98gQ43QoD7pZ8t0FtJ
         CR7X9tb8hF1zum8hR1gYGkYkuWo68GAir+QeDvGrjiBu+oQU6P2z4Oymn/Vn+WEvqiOe
         y0HC3Pudr7vFDDyDbVRYH3HESavaezyeT6dNeg6qHbe6VJmX/IoAMKfHVOxDrfwVcZEi
         m6zNwXN3O3E8hxpPbkLDWMciFMj0bcUiOotGGUMv6EsVkTQkZMo4XF6kM041X99Mqwix
         zTmn1P7G/I3ZG0FeKnOiFybEJoA7BsqwNxXRGxjSYfEdb+48NMDIcsDP6Ys7jojpgCoX
         Q7iQ==
X-Gm-Message-State: AOAM530bKZC358Y2noyZHBqD3LdZ6J9qyAKPPaz10P+r9eicJitjghNE
        Av3oESD44n0BRTsf6wKuaEpzHQr+OetJL8vhX8y1IA==
X-Google-Smtp-Source: ABdhPJxA6zr4oETTteNTPmtvHbM8zDj8C+zMYhYAnSX9zKGVMbUu+sWYmd4DjTXO2SwQH+b//ZyEGy15S2jfvqLpPYo=
X-Received: by 2002:a81:351:0:b0:2e5:9cb9:8c44 with SMTP id
 78-20020a810351000000b002e59cb98c44mr26060988ywd.250.1647887551971; Mon, 21
 Mar 2022 11:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646422845.git.isaku.yamahata@intel.com> <f3293bd872a916bf33165a2ec0d6fc50533b817f.1646422845.git.isaku.yamahata@intel.com>
In-Reply-To: <f3293bd872a916bf33165a2ec0d6fc50533b817f.1646422845.git.isaku.yamahata@intel.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Mon, 21 Mar 2022 11:32:21 -0700
Message-ID: <CAAhR5DFPsmxYXXXZ9WNW=MDWRRz5jrntPvsnKw7VTrRh5CbohQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 083/104] KVM: x86: Split core of hypercall
 emulation to helper function
To:     "Yamahata, Isaku" <isaku.yamahata@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Connor Kuehl <ckuehl@redhat.com>,
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

On Fri, Mar 4, 2022 at 12:00 PM <isaku.yamahata@intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> By necessity, TDX will use a different register ABI for hypercalls.
> Break out the core functionality so that it may be reused for TDX.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 +++
>  arch/x86/kvm/x86.c              | 54 ++++++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 8dab9f16f559..33b75b0e3de1 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1818,6 +1818,10 @@ void kvm_request_apicv_update(struct kvm *kvm, bool activate,
>  void __kvm_request_apicv_update(struct kvm *kvm, bool activate,
>                                 unsigned long bit);
>
> +unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> +                                     unsigned long a0, unsigned long a1,
> +                                     unsigned long a2, unsigned long a3,
> +                                     int op_64_bit);
>  int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
>
>  int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 314ae43e07bf..9acb33a17445 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9090,26 +9090,15 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
>         return kvm_skip_emulated_instruction(vcpu);
>  }
>
> -int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
> +unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> +                                     unsigned long a0, unsigned long a1,
> +                                     unsigned long a2, unsigned long a3,
> +                                     int op_64_bit)
>  {
> -       unsigned long nr, a0, a1, a2, a3, ret;
> -       int op_64_bit;
> -
> -       if (kvm_xen_hypercall_enabled(vcpu->kvm))
> -               return kvm_xen_hypercall(vcpu);
> -
> -       if (kvm_hv_hypercall_enabled(vcpu))
> -               return kvm_hv_hypercall(vcpu);
> -
> -       nr = kvm_rax_read(vcpu);
> -       a0 = kvm_rbx_read(vcpu);
> -       a1 = kvm_rcx_read(vcpu);
> -       a2 = kvm_rdx_read(vcpu);
> -       a3 = kvm_rsi_read(vcpu);
> +       unsigned long ret;
>
>         trace_kvm_hypercall(nr, a0, a1, a2, a3);
>
> -       op_64_bit = is_64_bit_hypercall(vcpu);
>         if (!op_64_bit) {
>                 nr &= 0xFFFFFFFF;
>                 a0 &= 0xFFFFFFFF;
> @@ -9118,11 +9107,6 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>                 a3 &= 0xFFFFFFFF;
>         }
>
> -       if (static_call(kvm_x86_get_cpl)(vcpu) != 0) {
> -               ret = -KVM_EPERM;
> -               goto out;
> -       }
> -
>         ret = -KVM_ENOSYS;
>
>         switch (nr) {
> @@ -9181,6 +9165,34 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>                 ret = -KVM_ENOSYS;
>                 break;
>         }
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(__kvm_emulate_hypercall);
> +
> +int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
> +{
> +       unsigned long nr, a0, a1, a2, a3, ret;
> +       int op_64_bit;
> +
> +       if (kvm_xen_hypercall_enabled(vcpu->kvm))
> +               return kvm_xen_hypercall(vcpu);
> +
> +       if (kvm_hv_hypercall_enabled(vcpu))
> +               return kvm_hv_hypercall(vcpu);
> +
> +       nr = kvm_rax_read(vcpu);
> +       a0 = kvm_rbx_read(vcpu);
> +       a1 = kvm_rcx_read(vcpu);
> +       a2 = kvm_rdx_read(vcpu);
> +       a3 = kvm_rsi_read(vcpu);
> +       op_64_bit = is_64_bit_mode(vcpu);

I think this should be "op_64_bit = is_64_bit_hypercall(vcpu);"
is_64_bit_mode was replaced with is_64_bit_hypercall to support
protected guests here:
https://lore.kernel.org/all/87cztf8h43.fsf@vitty.brq.redhat.com/T/

Without it, op_64_bit will be set to 0 for TD VMs which will cause the
upper 32 bit of the registers to be cleared in __kvm_emulate_hypercall

> +
> +       if (static_call(kvm_x86_get_cpl)(vcpu) != 0) {
> +               ret = -KVM_EPERM;
> +               goto out;
> +       }
> +
> +       ret = __kvm_emulate_hypercall(vcpu, nr, a0, a1, a2, a3, op_64_bit);
>  out:
>         if (!op_64_bit)
>                 ret = (u32)ret;
> --
> 2.25.1
>

Sagi
