Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9953FFAE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbiFGNHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244421AbiFGNHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E4EB289B5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654607247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dT4dXwV/JhpOmCLS9PchFBis6qJXMvk6Uxx+4D1f3pE=;
        b=EHe+L+0hYh6+8AXW1Po/ig1oUd2k902sD5KH7vi8ftI6ztyLv1pcDYHBM9caUm9FK3AmUS
        xYUtfJ49DHvtsglHibf6yWHuR46xzFoNfEVbH/5pJQJptjQyhrp7m+DUKx7in3l0Ba5xQ8
        MFTvKhz3U7iBYywveIG+Jxg09+FuUks=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-U1OXH0qTMm2okDgE-2yJrg-1; Tue, 07 Jun 2022 09:07:27 -0400
X-MC-Unique: U1OXH0qTMm2okDgE-2yJrg-1
Received: by mail-qt1-f197.google.com with SMTP id l20-20020ac81494000000b002f91203eeacso13868313qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dT4dXwV/JhpOmCLS9PchFBis6qJXMvk6Uxx+4D1f3pE=;
        b=ii6HGxa8ambIVotBJHV8gUPPx2mYAkIn2F0tWI45Ow4oj8N0/LIO3gyMKfXzalW4Qw
         9IXRdrmrRk+8ufvkCcxyJ/QbIk2+1Uh46sWvXWwdNr+QC1EahNJ9WIHjbFMh8n0/PrqC
         JAzsHrFxflZIidjoei4vLM5xHxo3mnEWtwT/k4KPnV1/0mnxTzqU/kubZAhf7ai2K0zg
         d84b7OYJQ5P/d0N1qCqNLGZrniQTQDHrjAeiD5H5U7KGBBvH3AtUV0Iv60+pcTbm9gNQ
         d/hoD6lNa28nDp4vM3yP3T0bWIcZg7tQ4jMhSc7OV722636Gnf9Lo29lceBqimd0l1ra
         Wnew==
X-Gm-Message-State: AOAM533DQk3hMFr42Q+Gs1QJinmPr9aR922hYzIyZussI1vG/Z7hrpYZ
        CBOAt0YKm6pGVl5p+MLnzFPzGb8xyWcwysnLbWygA7UCwGKPg4k9/J1tqVY/C8nXh7nXDQ8HNzw
        rfew/TtsUhBlaDBsEC5y5bdwA
X-Received: by 2002:a05:622a:64b:b0:304:c896:3473 with SMTP id a11-20020a05622a064b00b00304c8963473mr22554382qtb.457.1654607237840;
        Tue, 07 Jun 2022 06:07:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtO8Y0TPdwX1KmRcPW5zSOt9b4uoeWht2wLpW7fuOkuSrr5u+VNkTlvcweX3Vfb0sSftLLVA==
X-Received: by 2002:a05:622a:64b:b0:304:c896:3473 with SMTP id a11-20020a05622a064b00b00304c8963473mr22554317qtb.457.1654607237337;
        Tue, 07 Jun 2022 06:07:17 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id v10-20020a05620a440a00b0069fc13ce217sm1260715qkp.72.2022.06.07.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:07:16 -0700 (PDT)
Message-ID: <d3f2da59b5afd300531ae428174c1f91d731e655.camel@redhat.com>
Subject: Re: [PATCH 3/7] KVM: SVM: Add VNMI support in get/set_nmi_mask
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Santosh Shukla <santosh.shukla@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 16:07:13 +0300
In-Reply-To: <20220602142620.3196-4-santosh.shukla@amd.com>
References: <20220602142620.3196-1-santosh.shukla@amd.com>
         <20220602142620.3196-4-santosh.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 19:56 +0530, Santosh Shukla wrote:
> VMCB intr_ctrl bit12 (V_NMI_MASK) is set by the processor when handling
> NMI in guest and is cleared after the NMI is handled. Treat V_NMI_MASK as
> read-only in the hypervisor and do not populate set accessors.
> 
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 860f28c668bd..d67a54517d95 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -323,6 +323,16 @@ static int is_external_interrupt(u32 info)
>         return info == (SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_INTR);
>  }
>  
> +static bool is_vnmi_enabled(struct vmcb *vmcb)
> +{
> +       return vnmi && (vmcb->control.int_ctl & V_NMI_ENABLE);
> +}

Following Paolo's suggestion I recently removed vgif_enabled(),
based on the logic that vgif_enabled == vgif, because
we always enable vGIF for L1 as long as 'vgif' module param is set,
which is set unless either hardware or user cleared it.

Note that here vmcb is the current vmcb, which can be vmcb02,
and it might be wrong

> +
> +static bool is_vnmi_mask_set(struct vmcb *vmcb)
> +{
> +       return !!(vmcb->control.int_ctl & V_NMI_MASK);
> +}
> +
>  static u32 svm_get_interrupt_shadow(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
> @@ -3502,13 +3512,21 @@ static int svm_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
>  
>  static bool svm_get_nmi_mask(struct kvm_vcpu *vcpu)
>  {
> -       return !!(vcpu->arch.hflags & HF_NMI_MASK);
> +       struct vcpu_svm *svm = to_svm(vcpu);
> +
> +       if (is_vnmi_enabled(svm->vmcb))
> +               return is_vnmi_mask_set(svm->vmcb);
> +       else
> +               return !!(vcpu->arch.hflags & HF_NMI_MASK);
>  }
>  
>  static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
>  
> +       if (is_vnmi_enabled(svm->vmcb))
> +               return;

What if the KVM wants to mask NMI, shoudn't we update the 
V_NMI_MASK value in int_ctl instead of doing nothing?

Best regards,
	Maxim Levitsky


> +
>         if (masked) {
>                 vcpu->arch.hflags |= HF_NMI_MASK;
>                 if (!sev_es_guest(vcpu->kvm))


