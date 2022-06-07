Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104BD53FA09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiFGJmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiFGJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DED8CEBA8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654594919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zweN8LucgHJC5syhL/lhUr6sNIf8Y50bsT2NkXAMh5Y=;
        b=A2hxZyXDh0f70qAzBBoetVqwmhTqzvzD8gjcLv9+iQlvf4p8XX1MrQzAYvwJ0fBnkXHYUl
        Fb/ka5hr+t0jeUQOBpvqKjCvD+F0wLW0CUVM2bFr5YLWzygcAiXMgIczwqIMRI22oSPgCO
        v3+j34aY5f2EwqT7tuWMX/l12fqYMa4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-gRYqIdZRNr6gt8SiuQG8Rg-1; Tue, 07 Jun 2022 05:41:58 -0400
X-MC-Unique: gRYqIdZRNr6gt8SiuQG8Rg-1
Received: by mail-qt1-f200.google.com with SMTP id m18-20020a05622a119200b00304b4e57cbfso13484011qtk.18
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zweN8LucgHJC5syhL/lhUr6sNIf8Y50bsT2NkXAMh5Y=;
        b=WM1BIw/+AW15C3HbQnrbMikbmoGntgSFbDeTye1CkhFbpUY+Nq8UwDikmBBS8Tvn+K
         0V04/IifO66oRkDQNtN5VV1tKSUtpxJTmTutvpoPFddlg0Hv/EFQ0OU4x2k9PGWCrNlB
         KAfweB1F0De0FUiMDL1cS+psa6qf9zRjTx0faiy/VUplLmv+fgtE+blSIGYpzmPEHn4u
         tz2FeqcZdu2l24oY7hdwKnApyQcceoS8u6yqbPZ39VmoaZ1s1KnwKNX7CnP5OGKRSdVa
         ne41camldCaU+yJjXuywuebvIN4hCrRlFGf22EhnRy+bKejTUaINUfof/c61gRJs5uIh
         3Peg==
X-Gm-Message-State: AOAM533qgLOVNeXg6c7UcTylD9xEwhhaqRFnsP+xmwfljebaYYboyPPB
        slH1xwbDYbCpMaD24nJc6amn642DCDAM7zIc6kzdF4uYH9pG8dzl46bCrXPndjlKs6drNKhGM0x
        EeofUTXa1GxohFIAEAx9WfyuP
X-Received: by 2002:a05:622a:4ca:b0:304:f29e:7cc5 with SMTP id q10-20020a05622a04ca00b00304f29e7cc5mr4417731qtx.156.1654594917871;
        Tue, 07 Jun 2022 02:41:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS8ENofBwhm9+sO6u9ancI/MshCzw85Rak6eH2dgsYdPs0OS27gDo4y+uBGYHjGZ0XnBCghg==
X-Received: by 2002:a05:622a:4ca:b0:304:f29e:7cc5 with SMTP id q10-20020a05622a04ca00b00304f29e7cc5mr4417720qtx.156.1654594917457;
        Tue, 07 Jun 2022 02:41:57 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a0f0500b006a6a1bae173sm9332733qkl.7.2022.06.07.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:41:56 -0700 (PDT)
Message-ID: <8d78566457a9e46dc63eacb36387a85a793dc97a.camel@redhat.com>
Subject: Re: [PATCH v6 15/38] KVM: x86: Introduce
 .hv_inject_synthetic_vmexit_post_tlb_flush() nested hook
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 12:41:53 +0300
In-Reply-To: <20220606083655.2014609-16-vkuznets@redhat.com>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
         <20220606083655.2014609-16-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 10:36 +0200, Vitaly Kuznetsov wrote:
> Hyper-V supports injecting synthetic L2->L1 exit after performing
> L2 TLB flush operation but the procedure is vendor specific. Introduce
> .hv_inject_synthetic_vmexit_post_tlb_flush nested hook for it.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/Makefile           |  3 ++-
>  arch/x86/kvm/svm/hyperv.c       | 11 +++++++++++
>  arch/x86/kvm/svm/hyperv.h       |  2 ++
>  arch/x86/kvm/svm/nested.c       |  1 +
>  arch/x86/kvm/vmx/evmcs.c        |  4 ++++
>  arch/x86/kvm/vmx/evmcs.h        |  1 +
>  arch/x86/kvm/vmx/nested.c       |  1 +
>  8 files changed, 23 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kvm/svm/hyperv.c
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 02bef551dafb..5d60c66ee0de 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1603,6 +1603,7 @@ struct kvm_x86_nested_ops {
>         int (*enable_evmcs)(struct kvm_vcpu *vcpu,
>                             uint16_t *vmcs_version);
>         uint16_t (*get_evmcs_version)(struct kvm_vcpu *vcpu);
> +       void (*hv_inject_synthetic_vmexit_post_tlb_flush)(struct kvm_vcpu *vcpu);
>  };
>  
>  struct kvm_x86_init_ops {
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 30f244b64523..b6d53b045692 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -25,7 +25,8 @@ kvm-intel-y           += vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
>                            vmx/evmcs.o vmx/nested.o vmx/posted_intr.o
>  kvm-intel-$(CONFIG_X86_SGX_KVM)        += vmx/sgx.o
>  
> -kvm-amd-y              += svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o svm/sev.o
> +kvm-amd-y              += svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o \
> +                          svm/sev.o svm/hyperv.o
>  
>  ifdef CONFIG_HYPERV
>  kvm-amd-y              += svm/svm_onhyperv.o
> diff --git a/arch/x86/kvm/svm/hyperv.c b/arch/x86/kvm/svm/hyperv.c
> new file mode 100644
> index 000000000000..911f51021af1
> --- /dev/null
> +++ b/arch/x86/kvm/svm/hyperv.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD SVM specific code for Hyper-V on KVM.
> + *
> + * Copyright 2022 Red Hat, Inc. and/or its affiliates.
> + */
> +#include "hyperv.h"
> +
> +void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
> +{
> +}
> diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
> index 8cf702fed7e5..dd2e393f84a0 100644
> --- a/arch/x86/kvm/svm/hyperv.h
> +++ b/arch/x86/kvm/svm/hyperv.h
> @@ -48,4 +48,6 @@ static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
>         hv_vcpu->nested.vp_id = hve->hv_vp_id;
>  }
>  
> +void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu);
> +
>  #endif /* __ARCH_X86_KVM_SVM_HYPERV_H__ */
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index e8908cc56e22..28b63663e1d9 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1721,4 +1721,5 @@ struct kvm_x86_nested_ops svm_nested_ops = {
>         .get_nested_state_pages = svm_get_nested_state_pages,
>         .get_state = svm_get_nested_state,
>         .set_state = svm_set_nested_state,
> +       .hv_inject_synthetic_vmexit_post_tlb_flush = svm_hv_inject_synthetic_vmexit_post_tlb_flush,
>  };
> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> index 6a61b1ae7942..805afc170b5b 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -439,3 +439,7 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
>  
>         return 0;
>  }
> +
> +void vmx_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
> +{
> +}
> diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
> index f886a8ff0342..584741b85eb6 100644
> --- a/arch/x86/kvm/vmx/evmcs.h
> +++ b/arch/x86/kvm/vmx/evmcs.h
> @@ -245,5 +245,6 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
>                         uint16_t *vmcs_version);
>  void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata);
>  int nested_evmcs_check_controls(struct vmcs12 *vmcs12);
> +void vmx_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu);
>  
>  #endif /* __KVM_X86_VMX_EVMCS_H */
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 6e264a7f205b..4a827b3d929a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -6863,4 +6863,5 @@ struct kvm_x86_nested_ops vmx_nested_ops = {
>         .write_log_dirty = nested_vmx_write_pml_buffer,
>         .enable_evmcs = nested_enable_evmcs,
>         .get_evmcs_version = nested_get_evmcs_version,
> +       .hv_inject_synthetic_vmexit_post_tlb_flush = vmx_hv_inject_synthetic_vmexit_post_tlb_flush,
>  };


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

