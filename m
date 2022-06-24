Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12090559F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiFXRFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiFXRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4EF547AFA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656090299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KK62XKGyEa6E4YYT4ZJYLjFwXtc5WXwxUo2tARPfqUM=;
        b=fZ+/A07dY8HbTeTNHe/Uuz5M3qMLyQPZSr9gqAv09Lqpj07UVAaAC+t4lLJFAj7mhSVg3D
        qxu/3jfIrzJ7yA00jmqGXWSd3tEiwt/WVEMsv/d91Iqj5w0/oBplbX0QDtOLXH16DY+kPy
        I4axpUnlUcKz6QwmBw5cNlvMoXL36gE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-hAtk3rsfNuaA6wFHKd4S6Q-1; Fri, 24 Jun 2022 13:04:57 -0400
X-MC-Unique: hAtk3rsfNuaA6wFHKd4S6Q-1
Received: by mail-ed1-f69.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so2263616edc.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KK62XKGyEa6E4YYT4ZJYLjFwXtc5WXwxUo2tARPfqUM=;
        b=wmnT8Qdzc1P3t3Vzuf+OFE8S3k2pUltuZsmEbWU5nDeYFNuxXBo0lHnj3G0MRdJCWK
         C/dxY6CFd6VxOmgMgbjnWh3D//9HhpFtunoULpakOO+R5pWnBEuND70Si39LHWAuiTAA
         0lRBP143cEk4g2QQiw2fuFM8HocpXfDEXrNsL6wioVS5oXO45hbvPwrtP7aT9gfDV7oP
         pyFe+3Z47+RSNGIIhT20spugP+/VUyUD+QqST4jisesrzr2njKIwBWljWDCpuCw78qBP
         Je6F9crVXXQmtS47hPJJjn6euAGE++ZlDcJL0bjnOyc6H5Kx+qB/HXA9WIm3vA6GCRF/
         hNgw==
X-Gm-Message-State: AJIora8o3zaEx9HzBv0IStQQomv8i/FpDyeF3p52MU/7cPMHwhfniKMU
        m25lid7nM/DR2QvilaMHhGnuogKyfd3DOjj8wTkBeA9vt9fNtwM/dw7yxhfBLjNzgL3mpbgzaD7
        24SXdAoZ4Xc+be9BE9C+6F5Wa
X-Received: by 2002:a17:906:73c2:b0:722:e8d7:38c8 with SMTP id n2-20020a17090673c200b00722e8d738c8mr3396ejl.38.1656090296601;
        Fri, 24 Jun 2022 10:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tU/4t3ngZCmdsa1sj30mGxFm1VpjcBlpSYFtcYCmv1VB/fUuahvt96DdG3sR3So8n8+ckVJQ==
X-Received: by 2002:a17:906:73c2:b0:722:e8d7:38c8 with SMTP id n2-20020a17090673c200b00722e8d738c8mr3373ejl.38.1656090296355;
        Fri, 24 Jun 2022 10:04:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n7-20020a05640205c700b0043575ae2051sm2322613edx.62.2022.06.24.10.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:04:55 -0700 (PDT)
Message-ID: <d1891527-1d22-f1c3-a1f6-b4a1a3f42051@redhat.com>
Date:   Fri, 24 Jun 2022 19:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 00/17] Introducing AMD x2AVIC and hybrid-AVIC modes
Content-Language: en-US
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     mlevitsk@redhat.com, seanjc@google.com, joro@8bytes.org,
        jon.grimm@amd.com, wei.huang2@amd.com, terry.bowman@amd.com
References: <20220519102709.24125-1-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220519102709.24125-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 12:26, Suravee Suthikulpanit wrote:
> Introducing support for AMD x2APIC virtualization. This feature is
> indicated by the CPUID Fn8000_000A EDX[14], and it can be activated
> by setting bit 31 (enable AVIC) and bit 30 (x2APIC mode) of VMCB
> offset 60h.
> 
> With x2AVIC support, the guest local APIC can be fully virtualized in
> both xAPIC and x2APIC modes, and the mode can be changed during runtime.
> For example, when AVIC is enabled, the hypervisor set VMCB bit 31
> to activate AVIC for each vCPU. Then, it keeps track of each vCPU's
> APIC mode, and updates VMCB bit 30 to enable/disable x2APIC
> virtualization mode accordingly.
> 
> Besides setting bit VMCB bit 30 and 31, for x2AVIC, kvm_amd driver needs
> to disable interception for the x2APIC MSR range to allow AVIC hardware
> to virtualize register accesses.
> 
> This series also introduce a partial APIC virtualization (hybrid-AVIC)
> mode, where APIC register accesses are trapped (i.e. not virtualized
> by hardware), but leverage AVIC doorbell for interrupt injection.
> This eliminates need to disable x2APIC in the guest on system without
> x2AVIC support. (Note: suggested by Maxim)
> 
> Testing for v5:
>    * Test partial AVIC mode by launching a VM with x2APIC mode
>    * Tested booting a Linux VM with x2APIC physical and logical modes upto 512 vCPUs.
>    * Test the following nested SVM test use cases:
> 
>               L0     |    L1   |   L2
>         ----------------------------------
>                 AVIC |    APIC |    APIC
>                 AVIC |    APIC |  x2APIC
>          hybrid-AVIC |  x2APIC |    APIC
>          hybrid-AVIC |  x2APIC |  x2APIC
>               x2AVIC |    APIC |    APIC
>               x2AVIC |    APIC |  x2APIC
>               x2AVIC |  x2APIC |    APIC
>               x2AVIC |  x2APIC |  x2APIC
> 
> Changes from v5:
> (https://lore.kernel.org/lkml/20220518162652.100493-1-suravee.suthikulpanit@amd.com/T/#t)
>    * Re-order patch 16 to 10
>    * Patch 11: Update commit message
> 
> Changes from v4:
> (https://lore.kernel.org/lkml/20220508023930.12881-5-suravee.suthikulpanit@amd.com/T/)
>    * Patch  3: Move enum_avic_modes definition to svm.h
>    * Patch 10: Rename avic_set_x2apic_msr_interception to
>                svm_set_x2apic_msr_interception and move it to svm.c
>                to simplify the struct svm_direct_access_msrs declaration.
>    * Patch 16: New from Maxim
>    * Patch 17: New from Maxim
> 
> Best Regards,
> Suravee
> 
> Maxim Levitsky (2):
>    KVM: x86: nSVM: always intercept x2apic msrs
>    KVM: x86: nSVM: optimize svm_set_x2apic_msr_interception
> 
> Suravee Suthikulpanit (15):
>    x86/cpufeatures: Introduce x2AVIC CPUID bit
>    KVM: x86: lapic: Rename [GET/SET]_APIC_DEST_FIELD to
>      [GET/SET]_XAPIC_DEST_FIELD
>    KVM: SVM: Detect X2APIC virtualization (x2AVIC) support
>    KVM: SVM: Update max number of vCPUs supported for x2AVIC mode
>    KVM: SVM: Update avic_kick_target_vcpus to support 32-bit APIC ID
>    KVM: SVM: Do not support updating APIC ID when in x2APIC mode
>    KVM: SVM: Adding support for configuring x2APIC MSRs interception
>    KVM: x86: Deactivate APICv on vCPU with APIC disabled
>    KVM: SVM: Refresh AVIC configuration when changing APIC mode
>    KVM: SVM: Introduce logic to (de)activate x2AVIC mode
>    KVM: SVM: Do not throw warning when calling avic_vcpu_load on a
>      running vcpu
>    KVM: SVM: Introduce hybrid-AVIC mode
>    KVM: x86: Warning APICv inconsistency only when vcpu APIC mode is
>      valid
>    KVM: SVM: Use target APIC ID to complete x2AVIC IRQs when possible
>    KVM: SVM: Add AVIC doorbell tracepoint
> 
>   arch/x86/hyperv/hv_apic.c          |   2 +-
>   arch/x86/include/asm/apicdef.h     |   4 +-
>   arch/x86/include/asm/cpufeatures.h |   1 +
>   arch/x86/include/asm/kvm_host.h    |   1 -
>   arch/x86/include/asm/svm.h         |  16 ++-
>   arch/x86/kernel/apic/apic.c        |   2 +-
>   arch/x86/kernel/apic/ipi.c         |   2 +-
>   arch/x86/kvm/lapic.c               |   6 +-
>   arch/x86/kvm/svm/avic.c            | 178 ++++++++++++++++++++++++++---
>   arch/x86/kvm/svm/nested.c          |   5 +
>   arch/x86/kvm/svm/svm.c             |  75 ++++++++----
>   arch/x86/kvm/svm/svm.h             |  25 +++-
>   arch/x86/kvm/trace.h               |  18 +++
>   arch/x86/kvm/x86.c                 |   8 +-
>   14 files changed, 291 insertions(+), 52 deletions(-)
> 

I haven't quite finished reviewing this, but it passes both 
kvm-unit-tests and selftests so I pushed it to kvm/queue.

Paolo

