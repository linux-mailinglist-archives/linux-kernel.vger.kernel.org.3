Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3631053F9F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbiFGJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiFGJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AF96E7303
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654594604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TMMeeMzg716+0kOPZ1kJNvGjEZ2CaNLxMnft4GZfeHg=;
        b=LyTGbruzfIMPJ0Wr8bsONkXhgYqIZjKrEOCT6p4+xHn+PvkigTff440SSf4m520DZhQvSX
        PMKLLf8WiVtfcw9WBdK3jHYssCH+4a3eyfk8yzPdFnm6QQFLA+sulvSjq0Wm9eO6TdZpiM
        PNkaZ3eANqi7tcz5OSwW1zncMG0FF/E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-_eitluRsNH2XWF-hbyOrzg-1; Tue, 07 Jun 2022 05:36:43 -0400
X-MC-Unique: _eitluRsNH2XWF-hbyOrzg-1
Received: by mail-qt1-f199.google.com with SMTP id s7-20020ac85cc7000000b00304e11cb41fso8553110qta.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TMMeeMzg716+0kOPZ1kJNvGjEZ2CaNLxMnft4GZfeHg=;
        b=z0V6++8dCCYquPkaozlhpY2Abe9UEp08RHnSCCtDhjTagCFuNKVlASXiM0tCryYtlc
         7ck/JMVyo+/3my3fcjyW93xBBhqJX/HXc94O3iYt8YJyG+uuG4sJO9HcFtYDgMIJ9S2G
         ro3Tto9Q7cz45ymbN9geDJ9HZlU2Rv+wjHg60TX3P4pl9gAwLWon0p1V7z1XKca3pYoF
         vB6UzqbbCa2qsYhgSAIH4xGfQRdS56FMGmxePx1dxZBQ2XKHy24izXTMbLMOisnndBKF
         3IoztgbBxp4XVg1J4Bx9eS/9YSc7iX2n7okjTDiHMGOrYXGvT1nW5bw4tax4nauhcKl/
         seDA==
X-Gm-Message-State: AOAM532f2mf3PQ80NrZFEsu8f+vKmh3fcDOlwLBODC4Nzsu0KnCcclVu
        W+bm9LJdenUB3oPXFy1rSA1425fUNEWrGIJjPlBIDjlRECmAgWZEFqUR7CLLrInHgDijEet9J/S
        azU8uX5YF7PMRVM5yks0xs1RA
X-Received: by 2002:a05:6214:27cc:b0:46b:bc28:7d4f with SMTP id ge12-20020a05621427cc00b0046bbc287d4fmr846708qvb.80.1654594603148;
        Tue, 07 Jun 2022 02:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxCcLZX3ofJobo0dvjnhTkv9nwj9+XltzUdXK0HEeglyTnAe0VqZK4gyQ2MmA2ovb/JOXvEg==
X-Received: by 2002:a05:6214:27cc:b0:46b:bc28:7d4f with SMTP id ge12-20020a05621427cc00b0046bbc287d4fmr846702qvb.80.1654594602958;
        Tue, 07 Jun 2022 02:36:42 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id bm13-20020a05620a198d00b006a6d83fc9efsm1031130qkb.21.2022.06.07.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:36:42 -0700 (PDT)
Message-ID: <c89186f11fa1eb3563b791ba68cca4a533aa537f.camel@redhat.com>
Subject: Re: [PATCH v6 14/38] KVM: nSVM: Keep track of Hyper-V
 hv_vm_id/hv_vp_id
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
Date:   Tue, 07 Jun 2022 12:36:38 +0300
In-Reply-To: <20220606083655.2014609-15-vkuznets@redhat.com>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
         <20220606083655.2014609-15-vkuznets@redhat.com>
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
> Similar to nSVM, KVM needs to know L2's VM_ID/VP_ID and Partition
> assist page address to handle L2 TLB flush requests.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/svm/hyperv.h | 16 ++++++++++++++++
>  arch/x86/kvm/svm/nested.c |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
> index 7d6d97968fb9..8cf702fed7e5 100644
> --- a/arch/x86/kvm/svm/hyperv.h
> +++ b/arch/x86/kvm/svm/hyperv.h
> @@ -9,6 +9,7 @@
>  #include <asm/mshyperv.h>
>  
>  #include "../hyperv.h"
> +#include "svm.h"
>  
>  /*
>   * Hyper-V uses the software reserved 32 bytes in VMCB
> @@ -32,4 +33,19 @@ struct hv_enlightenments {
>   */
>  #define VMCB_HV_NESTED_ENLIGHTENMENTS VMCB_SW
>  
> +static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_svm *svm = to_svm(vcpu);
> +       struct hv_enlightenments *hve =
> +               (struct hv_enlightenments *)svm->nested.ctl.reserved_sw;
> +       struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +
> +       if (!hv_vcpu)
> +               return;
> +
> +       hv_vcpu->nested.pa_page_gpa = hve->partition_assist_page;
> +       hv_vcpu->nested.vm_id = hve->hv_vm_id;
> +       hv_vcpu->nested.vp_id = hve->hv_vp_id;
> +}
> +
>  #endif /* __ARCH_X86_KVM_SVM_HYPERV_H__ */
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 88da8edbe1e1..e8908cc56e22 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -811,6 +811,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
>         if (kvm_vcpu_apicv_active(vcpu))
>                 kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
>  
> +       nested_svm_hv_update_vm_vp_ids(vcpu);
> +
>         return 0;
>  }
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

