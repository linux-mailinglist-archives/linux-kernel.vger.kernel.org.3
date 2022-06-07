Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154C253FFC8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiFGNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbiFGNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AE67EABBA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654607671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWbb5e6DINc80HZlfiRRtC5Qhh83jixUJLVThVqcPiI=;
        b=GxNvsVbI8DRmO/lOOZ8Nfl22lviDU7ANAP8/fyG3/oqekruTUnyxcJOQ0OBHqZt1Xy90ax
        gzsmn8HZnV97Pov7exAaxk5yjb3UkbkwHMO9O6722A0MNQwWACTepaj7UpAFCrXVSC7aIV
        mmAtg5El05HC3sW31SEtCFGZXKKunzM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-Wy3tFXrENo2FmR6KAzNWcA-1; Tue, 07 Jun 2022 09:14:30 -0400
X-MC-Unique: Wy3tFXrENo2FmR6KAzNWcA-1
Received: by mail-qk1-f197.google.com with SMTP id bp18-20020a05620a459200b006a6a7b1f0acso8186876qkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gWbb5e6DINc80HZlfiRRtC5Qhh83jixUJLVThVqcPiI=;
        b=KfLN0N/7gOZqqR59Jt6wCvtZmMvCA2fHp3umULii05UzeEKrA0y/ZcENPGVdi74TZr
         bl9OorKPeKIMuFbIqWnt8UWyzWs3ivUOQ6dwHEfshd1d320n798DwCWT7nUStIyl74cv
         fzeW6peIBx5XfRvmo0ybj4yIipSPTFa92zqrao80vfcxLVUr07SlSvS0Fr83JHd4ch/W
         T/ckVCDLFCDteuhjoIXjm423OGdqpdxUY6OBBqkjKmmibX1wn+HPHdB2uNvseNuMh13P
         EjRVnvybvHxs5yQCBb2xVJM9KAcFY1VRjQ5FQ/AWb8FZ+e5tEmanQXosrx4//5lgdRmx
         ouwA==
X-Gm-Message-State: AOAM531/GsDA783eLZp/DeTLqIvYYlApcnutkYGcevBVwa3qOHKQIfRJ
        70H3tmBwkAef0OAlNHJSjqJ393wNVXHcPxSqBe/m9ILVgYHwLrFnJcU+zthmMIsOeuOFa+z52Hv
        pB0+967dzjpsCNtz3hZ0yj8ds
X-Received: by 2002:a05:620a:2681:b0:67e:908f:b513 with SMTP id c1-20020a05620a268100b0067e908fb513mr19163275qkp.204.1654607669446;
        Tue, 07 Jun 2022 06:14:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7GyR9E1ooUC6ELZKjGzbfSFYLtfzFDD1HrOtAZ3FEraHGhNfOgxCk3LNhu8JSAf5glHVqKQ==
X-Received: by 2002:a05:620a:2681:b0:67e:908f:b513 with SMTP id c1-20020a05620a268100b0067e908fb513mr19163238qkp.204.1654607669115;
        Tue, 07 Jun 2022 06:14:29 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id z5-20020a05622a124500b00304efba3d84sm3204646qtx.25.2022.06.07.06.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:14:28 -0700 (PDT)
Message-ID: <dfc2ce68a10181b1ac6c07ca3927d474e13ca973.camel@redhat.com>
Subject: Re: [PATCH 5/7] KVM: SVM: Add VNMI support in inject_nmi
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Santosh Shukla <santosh.shukla@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 16:14:25 +0300
In-Reply-To: <20220602142620.3196-6-santosh.shukla@amd.com>
References: <20220602142620.3196-1-santosh.shukla@amd.com>
         <20220602142620.3196-6-santosh.shukla@amd.com>
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

On Thu, 2022-06-02 at 19:56 +0530, Santosh Shukla wrote:
> Inject the NMI by setting V_NMI in the VMCB interrupt control. processor
> will clear V_NMI to acknowledge processing has started and will keep the
> V_NMI_MASK set until the processor is done with processing the NMI event.
> 
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index a405e414cae4..200f979169e0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3385,11 +3385,16 @@ static void svm_inject_nmi(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
>  
> +       ++vcpu->stat.nmi_injections;
> +       if (is_vnmi_enabled(svm->vmcb)) {
> +               svm->vmcb->control.int_ctl |= V_NMI_PENDING;
> +               return;
> +       }
Here I would advice to have a warning to check if vNMI is already pending.

Also we need to check what happens if we make vNMI pending and get #SMI,
while in #NMI handler, or if #NMI is blocked due to interrupt window.

Best regards,
	Maxim Levitsky


> +
>         svm->vmcb->control.event_inj = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_NMI;
>         vcpu->arch.hflags |= HF_NMI_MASK;
>         if (!sev_es_guest(vcpu->kvm))
>                 svm_set_intercept(svm, INTERCEPT_IRET);
> -       ++vcpu->stat.nmi_injections;
>  }
>  
>  static void svm_inject_irq(struct kvm_vcpu *vcpu)


