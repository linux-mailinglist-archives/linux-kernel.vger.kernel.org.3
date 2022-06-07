Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB51953FFB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbiFGNLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242776AbiFGNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E1BC965E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654607461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrJwm8T5DvogQq3qGE1YzCHcNoGlw7V9YLEBa7HEgK0=;
        b=gqGuHqEpTtLon2RwRW4iRdw8xnTELIFJsDq++oH6lnxTIrKiglvooPVYWqIsTOukpyPqSq
        x8YxAfnxX4tsOvrE6SKzRfVJiPTeJDQ3Y7zpcquopWLLe0rpWKu4qOPwsVjeU20s6iXsSe
        XH0kJEbgg94O0IugJwf4wkMI+XJ3aV4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-QN-FdnFBNOieVXYef1Yv2g-1; Tue, 07 Jun 2022 09:11:00 -0400
X-MC-Unique: QN-FdnFBNOieVXYef1Yv2g-1
Received: by mail-qt1-f199.google.com with SMTP id c16-20020a05622a059000b002f93304d0d8so13899190qtb.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IrJwm8T5DvogQq3qGE1YzCHcNoGlw7V9YLEBa7HEgK0=;
        b=rVfNxXxgrSVl5YXsLxg1UdgfSfKWW1CoMmYcOlqkxyPSF0AnSZIWuJkUuSG+LsB/1+
         7l7LKi7mxPLUEcNp203Ied9sOwk5d7tID0kOSeJUriNZbBMi6Fi6RT2BqyfFTb3fw9E7
         ELgKNaBtoLAPOuQGWOEGWBPqKRqPc9Cu5y4ruNgSD9fiDVTfK7UCSr278DyTTyODcSo2
         VbHauMDu8VAOCqElq98GSUOUw5XifmuTXpoCagilzjfMg6DVtOT7R++qvgczY8+M7AHL
         A53P0XYUgzsrL8l6Zu2bdXRwHgHO3V61k7lAY2F7wfQx980s5Ri61GT+wjpbMb88baHP
         XpaA==
X-Gm-Message-State: AOAM531l7km0JJ/u5KmXq86fkAyaUPW6EB7czivMCWVqq5FaeCOiDWo/
        deFMAPemeeGXg6ue1LZ8R9TldiWh0bvE7aAYDYXASScZ/zCksmkZL8dFDO722cXpabuqh6Pzvp1
        VWnPHWk8mirtGoyo6Jcmsk4o6
X-Received: by 2002:a05:622a:4c9:b0:304:b650:683d with SMTP id q9-20020a05622a04c900b00304b650683dmr22444853qtx.229.1654607459531;
        Tue, 07 Jun 2022 06:10:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxdcSuo9jWSr8rR30I1ntGPvlw+ktHmPXrMzWfguHVwa3IdyBpX/2QI/Q+nUa4GGASUXJk7A==
X-Received: by 2002:a05:622a:4c9:b0:304:b650:683d with SMTP id q9-20020a05622a04c900b00304b650683dmr22444806qtx.229.1654607459161;
        Tue, 07 Jun 2022 06:10:59 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a424d00b006a69ee117b6sm10435671qko.97.2022.06.07.06.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:10:58 -0700 (PDT)
Message-ID: <da6e0e9375d1286d3d9d4b6ab669d234850261eb.camel@redhat.com>
Subject: Re: [PATCH 4/7] KVM: SVM: Report NMI not allowed when Guest busy
 handling VNMI
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Santosh Shukla <santosh.shukla@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 16:10:54 +0300
In-Reply-To: <20220602142620.3196-5-santosh.shukla@amd.com>
References: <20220602142620.3196-1-santosh.shukla@amd.com>
         <20220602142620.3196-5-santosh.shukla@amd.com>
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
> In the VNMI case, Report NMI is not allowed when the processor set the
> V_NMI_MASK to 1 which means the Guest is busy handling VNMI.
> 
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index d67a54517d95..a405e414cae4 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3483,6 +3483,9 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
>         struct vmcb *vmcb = svm->vmcb;
>         bool ret;
>  
> +       if (is_vnmi_enabled(vmcb) && is_vnmi_mask_set(vmcb))
> +               return true;

How does this interact with GIF? if the guest does clgi, will the
CPU update the V_NMI_MASK on its own If vGIF is enabled?

What happens if vGIF is disabled and vNMI is enabled? KVM then intercepts
the stgi/clgi, and it should then update the V_NMI_MASK?




> +
>         if (!gif_set(svm))
>                 return true;
>  
> @@ -3618,6 +3621,9 @@ static void svm_enable_nmi_window(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
>  
> +       if (is_vnmi_enabled(svm->vmcb) && is_vnmi_mask_set(svm->vmcb))
> +               return;

This might have hidden assumption that we will only enable NMI window when vNMI is masked.



> +
>         if ((vcpu->arch.hflags & (HF_NMI_MASK | HF_IRET_MASK)) == HF_NMI_MASK)
>                 return; /* IRET will cause a vm exit */
>  


Best regards,
	Maxim Levitsky

