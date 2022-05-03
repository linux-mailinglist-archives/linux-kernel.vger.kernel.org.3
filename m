Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC2518118
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiECJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiECJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F7F624BD0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651570544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vm1AHL4rFcbvCeBzsVIadvhZvmSkslM9GulbqwY1CBg=;
        b=Ye0UwbQQfc8ZfPfoWSrtVIw0EOmOibkBaH6NemM2F9waLotiVQDUZoqaV2B/XmIda9bc9s
        EpgeC0to2vlAN95PFq+JRIst6+EkXCITW4Rpn1ynHeJ/hYsg59BI/7tJfU7GdNppeY6k7h
        VTQux/PQhiJf9XaozjHOEYxX4cWzIA0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-I7haL4UXPp-hZaMCPcnvbQ-1; Tue, 03 May 2022 05:35:38 -0400
X-MC-Unique: I7haL4UXPp-hZaMCPcnvbQ-1
Received: by mail-wm1-f72.google.com with SMTP id d6-20020a05600c34c600b0039296a2ac7cso542586wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vm1AHL4rFcbvCeBzsVIadvhZvmSkslM9GulbqwY1CBg=;
        b=xZp/OIJ0c6onL2qZAcfvLwQB9X67B1fot0duBuyTBnm1suwAyL4lnB2kdxnfrFHL9c
         Osr3z0PQbbM3k5BS94pZCV/9OTNi4lSDrfLWP0Ly4S1qQUeFIVP2xXCIczTT6PZPgD11
         8Ch7YdnfOCtIoTgd6X1vnABXCZSJ9P7uHgdaIlP9c4CmwNxsTS/9/wAw0kl3OAgmQRAw
         MoIFst3FmdVnOGHBnO0rt9bSO5dWzLQsJMl/M8itq4fCuTOHojoRNAQCRZGo9cXnaPi7
         ObH9svxuQgmIzsAovuiL29aayUSGCeV5RPC3PcY/9gqUyLIspyzPFiOAdJJlPTH1VhPY
         tmCg==
X-Gm-Message-State: AOAM531HNqH0dPDQwNn3t8Ru/oehRcFjzM4qw76fUQVDfCoWeGpWspi6
        EDGFKe1PKK1IzZk82G9JgctMardNfnN1oqy1J6NGDPI/Mu/pq0KUsjMrQDeTm2fXLdMIXB3EwAt
        v8Gc7UrSe3e0QsmwDK42MWfoS
X-Received: by 2002:adf:ded2:0:b0:20c:55cc:ab3e with SMTP id i18-20020adfded2000000b0020c55ccab3emr10945403wrn.376.1651570537660;
        Tue, 03 May 2022 02:35:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEmAquiSRy6OLItqDdXhrnPrw1k3bDoBoXFwZLlG+mHYAvbLpPmkSc5lN9GYwzWwQxdGRIwg==
X-Received: by 2002:adf:ded2:0:b0:20c:55cc:ab3e with SMTP id i18-20020adfded2000000b0020c55ccab3emr10945390wrn.376.1651570537412;
        Tue, 03 May 2022 02:35:37 -0700 (PDT)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id d15-20020adf9b8f000000b0020c5253d8c9sm8701504wrc.21.2022.05.03.02.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:35:36 -0700 (PDT)
Message-ID: <ae806798-b98e-c2d8-1926-32fa982a0a50@redhat.com>
Date:   Tue, 3 May 2022 11:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: VMX: Exit to userspace if vCPU has injected
 exception and invalid state
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+cfafed3bb76d3e37581b@syzkaller.appspotmail.com
References: <20220502221850.131873-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220502221850.131873-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 00:18, Sean Christopherson wrote:
> Exit to userspace with an emulation error if KVM encounters an injected
> exception with invalid guest state, in addition to the existing check of
> bailing if there's a pending exception (KVM doesn't support emulating
> exceptions except when emulating real mode via vm86).
> 
> In theory, KVM should never get to such a situation as KVM is supposed to
> exit to userspace before injecting an exception with invalid guest state.
> But in practice, userspace can intervene and manually inject an exception
> and/or stuff registers to force invalid guest state while a previously
> injected exception is awaiting reinjection.
> 
> Fixes: fc4fad79fc3d ("KVM: VMX: Reject KVM_RUN if emulation is required with pending exception")
> Reported-by: syzbot+cfafed3bb76d3e37581b@syzkaller.appspotmail.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index cf8581978bce..c41f0ac700c7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5465,7 +5465,7 @@ static bool vmx_emulation_required_with_pending_exception(struct kvm_vcpu *vcpu)
>   	struct vcpu_vmx *vmx = to_vmx(vcpu);
>   
>   	return vmx->emulation_required && !vmx->rmode.vm86_active &&
> -	       vcpu->arch.exception.pending;
> +	       (vcpu->arch.exception.pending || vcpu->arch.exception.injected);
>   }
>   
>   static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
> 
> base-commit: 84e5ffd045f33e4fa32370135436d987478d0bf7

Queued, thanks.

Paolo

