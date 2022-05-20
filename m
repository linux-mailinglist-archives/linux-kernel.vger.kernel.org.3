Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7C52EB67
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbiETMBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348989AbiETMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F98ACE29
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653048068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1/te+4Y4ho6udDKU3FETTF4lh1tRvJCKy5k3ZgQWfQ=;
        b=AL4dmpBKKemWZ4CDuUF9HuSS+UgSq4kmW6Ts+qYtIO+WokdSMQF6twv40EhNXRr2jbiTd2
        20kII64PW5R0PbyqFBhrBKSxhJDRID9jASoeBfPePp4G+c2OmkmoqnO750WeaWZgHeWM9S
        8x8zr6bvoQ2KuD4lX5yJFI7tr7/j1ec=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-rhRALjMXPIy48QzO1eRCQg-1; Fri, 20 May 2022 08:01:07 -0400
X-MC-Unique: rhRALjMXPIy48QzO1eRCQg-1
Received: by mail-pl1-f199.google.com with SMTP id p16-20020a170902e75000b00161d96620c4so2739265plf.14
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T1/te+4Y4ho6udDKU3FETTF4lh1tRvJCKy5k3ZgQWfQ=;
        b=SdDS7OLKX+PB2jt+q0THcJv7V0GKeDmgiqTFeuUML6yBY2eBPHeAzvn2FfIMboCeS7
         KCi9hfF+crwEUirjuTGRqZzlrHXva5AWOtyswbuAdGSD2puZLne++cflgyQAmuTborlh
         bN+VjIQWvokddjTk+EgjXDIKHANqzv6OxXAD2d/Kd+bUnnCi6jotuXmZXdQh1CA/xFMZ
         PkCG2khcdVVCYAdIp+lxY1HYvIv0Wb0MKzYE4u5brGxh8a0DjtbFRiJ8mw+rPfeAKfK1
         GMG1eUJGLfaV3alFDK1N9D6p0Ati3I1zT0gLYuUCcuEFx1mQo33khJuWJpqIted7TaHQ
         46sw==
X-Gm-Message-State: AOAM532S8zSEtTfuKOrUywpTbJbrQ8jG6qVEfSBFZR9kt49fdBomEGaC
        7EKdfARCXlEcqwFq8wBx7i1BQB3yavcXWzqGZu8uDiKGmO9m32toqx1FXkh2WUjyWm+0OsBI4SO
        IO/jpkwZh9NbFxVm65SoSfMAgZQ4sViffxqKjG1aW
X-Received: by 2002:a05:6a00:174a:b0:4fd:ac35:6731 with SMTP id j10-20020a056a00174a00b004fdac356731mr9599124pfc.71.1653048066249;
        Fri, 20 May 2022 05:01:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw8odYerMJXPa7j+8qH+HKggUd27IfpqiiBb6TBD0oWyj+epTj2Yq+QIkthft/bauWj3S2LYpOoYBUKf2zvHM=
X-Received: by 2002:a05:6a00:174a:b0:4fd:ac35:6731 with SMTP id
 j10-20020a056a00174a00b004fdac356731mr9599093pfc.71.1653048065938; Fri, 20
 May 2022 05:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220518170118.66263-1-likexu@tencent.com>
In-Reply-To: <20220518170118.66263-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 20 May 2022 14:00:54 +0200
Message-ID: <CABgObfaNZqE+z5WA8VRPco9c_Swa15qyom7ieHGFRWzw39kU=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: x86/pmu: Move the vmx_icl_pebs_cpu[] definition
 out of the header file
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued all three, thanks.

Paolo

On Wed, May 18, 2022 at 7:01 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> Defining a static const array in a header file would introduce redundant
> definitions to the point of confusing semantics, and such a use case woul=
d
> only bring complaints from the compiler:
>
> arch/x86/kvm/pmu.h:20:32: warning: =E2=80=98vmx_icl_pebs_cpu=E2=80=99 def=
ined but not used [-Wunused-const-variable=3D]
>    20 | static const struct x86_cpu_id vmx_icl_pebs_cpu[] =3D {
>       |                                ^~~~~~~~~~~~~~~~
>
> Fixes: a095df2c5f48 ("KVM: x86/pmu: Adjust precise_ip to emulate Ice Lake=
 guest PDIR counter")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/pmu.c | 7 +++++++
>  arch/x86/kvm/pmu.h | 8 --------
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index b5d0c36b869b..a2eaae85d97b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -16,6 +16,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/sort.h>
>  #include <asm/perf_event.h>
> +#include <asm/cpu_device_id.h>
>  #include "x86.h"
>  #include "cpuid.h"
>  #include "lapic.h"
> @@ -27,6 +28,12 @@
>  struct x86_pmu_capability __read_mostly kvm_pmu_cap;
>  EXPORT_SYMBOL_GPL(kvm_pmu_cap);
>
> +static const struct x86_cpu_id vmx_icl_pebs_cpu[] =3D {
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, NULL),
> +       {}
> +};
> +
>  /* NOTE:
>   * - Each perf counter is defined as "struct kvm_pmc";
>   * - There are two types of perf counters: general purpose (gp) and fixe=
d.
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index dbf4c83519a4..ecf2962510e4 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -4,8 +4,6 @@
>
>  #include <linux/nospec.h>
>
> -#include <asm/cpu_device_id.h>
> -
>  #define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu)
>  #define pmu_to_vcpu(pmu)  (container_of((pmu), struct kvm_vcpu, arch.pmu=
))
>  #define pmc_to_pmu(pmc)   (&(pmc)->vcpu->arch.pmu)
> @@ -17,12 +15,6 @@
>  #define VMWARE_BACKDOOR_PMC_REAL_TIME          0x10001
>  #define VMWARE_BACKDOOR_PMC_APPARENT_TIME      0x10002
>
> -static const struct x86_cpu_id vmx_icl_pebs_cpu[] =3D {
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, NULL),
> -       {}
> -};
> -
>  struct kvm_event_hw_type_mapping {
>         u8 eventsel;
>         u8 unit_mask;
> --
> 2.36.1
>

