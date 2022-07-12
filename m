Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65B4571955
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGLL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiGLL73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E12A4A0262
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVuJ9iCn8/D55c6OppydfZXtppgPfcJG75iTvGfWoFM=;
        b=PkguLkCEbEcc9KhlRKkB6VX8zGv9hNmo4ttQeE+csIVRKP4cOfO500USogxN/CqzXytjHX
        0vl+40XqXyxMMUrmHupECwtDrMEUMWcNF8zYZR7M01WLG7YZtdO3+J3Y7EhvsGpU1Pz3lz
        4BZGZNM8R3lLQvALdz8zTxmBsCp1uJQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-5gGVPOWyOTe1_Vd3fycXNQ-1; Tue, 12 Jul 2022 07:59:19 -0400
X-MC-Unique: 5gGVPOWyOTe1_Vd3fycXNQ-1
Received: by mail-qt1-f197.google.com with SMTP id w19-20020a05622a135300b0031ea6ab7ab9so6770317qtk.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rVuJ9iCn8/D55c6OppydfZXtppgPfcJG75iTvGfWoFM=;
        b=zuDRBHERH4szZU0Xz5HoE8caz6OJr9Non23s0KQ7OoDjEXswSAER9W5nJ863MAlKWR
         i776NJu6EYvI6YQaAIW94yaP/ArgaVdeksMZbnD1QOM56UDt7H7wSJfCohXEJ/8o78By
         m+m2egxt/PAOPFz/0f5mMStnkUfULHBfylumX7YojK8k+DqDshxrQuZJpq6oT6XWuPB/
         Opvjn3ag3rDe06iO7TUdmxGB0W3kghvTCtJi9gXfHZitTwsaqDQrXeMMkdKxMPJGy0q1
         /nv4P5s2o3kXiEycBujyKljxhOhh68RNVGKh53DOpuT+vsbEZjG8HQUqisf6SpzDcKjk
         td1w==
X-Gm-Message-State: AJIora/knMFr+QXWy0zoM4OwewCrqvkCHdt64A40Ut4gRauX5kuFGJMU
        MIWa+0ACrq4YIOGKuk0I1nrHiDxdgjPIiLDPRx5BXZL9KAFnn5SpMmW8s+ZSLmydziFAibwtmB7
        y6GD+JyCsZy1karjUhcuR5CCr
X-Received: by 2002:a05:620a:220e:b0:6b5:a4c2:1641 with SMTP id m14-20020a05620a220e00b006b5a4c21641mr1233828qkh.100.1657627159426;
        Tue, 12 Jul 2022 04:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tQIpbsQC4LYPY8vXlrUg1hfX0xrB3o2k6SxRTRx0EUYUcTBJwe1OoFp+eagth6ugJC+7MVjQ==
X-Received: by 2002:a05:620a:220e:b0:6b5:a4c2:1641 with SMTP id m14-20020a05620a220e00b006b5a4c21641mr1233817qkh.100.1657627159209;
        Tue, 12 Jul 2022 04:59:19 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006a793bde241sm8786006qko.63.2022.07.12.04.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:59:18 -0700 (PDT)
Message-ID: <16dfc8c5585ca77bf16e8d9b7f560fc471a61338.camel@redhat.com>
Subject: Re: [PATCH v3 21/25] KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL
 errata handling out of setup_vmcs_config()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:59:15 +0300
In-Reply-To: <20220708144223.610080-22-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-22-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> As a preparation to reusing the result of setup_vmcs_config() for setting
> up nested VMX control MSRs, move LOAD_IA32_PERF_GLOBAL_CTRL errata handling
> to vmx_vmexit_ctrl()/vmx_vmentry_ctrl() and print the warning from
> hardware_setup(). While it seems reasonable to not expose
> LOAD_IA32_PERF_GLOBAL_CTRL controls to L1 hypervisor on buggy CPUs,
> such change would inevitably break live migration from older KVMs
> where the controls are exposed. Keep the status quo for know, L1 hypervisor
> itself is supposed to take care of the errata.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 62 ++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2dff5b94c535..e462e5b9c0a1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2416,6 +2416,31 @@ static bool cpu_has_sgx(void)
>         return cpuid_eax(0) >= 0x12 && (cpuid_eax(0x12) & BIT(0));
>  }
>  
> +/*
> + * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
> + * can't be used due to errata where VM Exit may incorrectly clear
> + * IA32_PERF_GLOBAL_CTRL[34:32]. Work around the errata by using the
> + * MSR load mechanism to switch IA32_PERF_GLOBAL_CTRL.
> + */
> +static bool cpu_has_perf_global_ctrl_bug(void)
> +{
> +       if (boot_cpu_data.x86 == 0x6) {
> +               switch (boot_cpu_data.x86_model) {
> +               case INTEL_FAM6_NEHALEM_EP:     /* AAK155 */
> +               case INTEL_FAM6_NEHALEM:        /* AAP115 */
> +               case INTEL_FAM6_WESTMERE:       /* AAT100 */
> +               case INTEL_FAM6_WESTMERE_EP:    /* BC86,AAY89,BD102 */
> +               case INTEL_FAM6_NEHALEM_EX:     /* BA97 */
> +                       return true;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       return false;
> +}
> +
> +
>  static __init int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt,
>                                       u32 msr, u32 *result)
Nitpick: Indention is incorrect
>  {
> @@ -2572,30 +2597,6 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>                 _vmexit_control &= ~x_ctrl;
>         }
>  
> -       /*
> -        * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
> -        * can't be used due to an errata where VM Exit may incorrectly clear
> -        * IA32_PERF_GLOBAL_CTRL[34:32].  Workaround the errata by using the
> -        * MSR load mechanism to switch IA32_PERF_GLOBAL_CTRL.
> -        */
> -       if (boot_cpu_data.x86 == 0x6) {
> -               switch (boot_cpu_data.x86_model) {
> -               case INTEL_FAM6_NEHALEM_EP:     /* AAK155 */
> -               case INTEL_FAM6_NEHALEM:        /* AAP115 */
> -               case INTEL_FAM6_WESTMERE:       /* AAT100 */
> -               case INTEL_FAM6_WESTMERE_EP:    /* BC86,AAY89,BD102 */
> -               case INTEL_FAM6_NEHALEM_EX:     /* BA97 */
> -                       _vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> -                       _vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> -                       pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
> -                                       "does not work properly. Using workaround\n");
> -                       break;
> -               default:
> -                       break;
> -               }
> -       }
> -
> -
>         rdmsr(MSR_IA32_VMX_BASIC, vmx_msr_low, vmx_msr_high);
>  
>         /* IA-32 SDM Vol 3B: VMCS size is never greater than 4kB. */
> @@ -4184,6 +4185,10 @@ static u32 vmx_vmentry_ctrl(void)
>                           VM_ENTRY_LOAD_IA32_EFER |
>                           VM_ENTRY_IA32E_MODE);
>  
> +
> +       if (cpu_has_perf_global_ctrl_bug())
> +               vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> +
>         return vmentry_ctrl;
>  }
>  
> @@ -4198,6 +4203,10 @@ static u32 vmx_vmexit_ctrl(void)
>         if (vmx_pt_mode_is_system())
>                 vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
>                                  VM_EXIT_CLEAR_IA32_RTIT_CTL);
> +
> +       if (cpu_has_perf_global_ctrl_bug())
> +               vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> +
>         /* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
>         return vmexit_ctrl &
>                 ~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
> @@ -8113,6 +8122,11 @@ static __init int hardware_setup(void)
>         if (setup_vmcs_config(&vmcs_config, &vmx_capability) < 0)
>                 return -EIO;
>  
> +       if (cpu_has_perf_global_ctrl_bug()) {
> +               pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
> +                            "does not work properly. Using workaround\n");
> +       }
> +
>         if (boot_cpu_has(X86_FEATURE_NX))
>                 kvm_enable_efer_bits(EFER_NX);
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

