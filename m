Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671904B1342
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbiBJQmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:42:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbiBJQmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:42:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 174FEF23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFYbvPlaBCYjn1T1X1uUdnxkO0hSwtQKlrbztUTQuqo=;
        b=i+zXwASYR5Y+bsiGdfnB+wwxX/+PcLLHkfpTaE0XVXKbSmvuOwQK3hXtvMFOMkOynnr7u8
        hYcgb6vO+tMuNmn0aEYUKSm8Hwb6r0g4XVqN9ifO4iNeIyBf//ACzJVInwbe9GAZzMIfs9
        JJOYoD2yg7aRhB8XSt6Ki2JiYTzRdYI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-0UPdBH3wPMS_Is7CfWkHWQ-1; Thu, 10 Feb 2022 11:42:10 -0500
X-MC-Unique: 0UPdBH3wPMS_Is7CfWkHWQ-1
Received: by mail-ej1-f72.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so3021625ejf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RFYbvPlaBCYjn1T1X1uUdnxkO0hSwtQKlrbztUTQuqo=;
        b=oX+G/uWr+1dGMODaKodh0R9Pcx5di0hcvTGlv5sD5CtJ1BJyRRcImMwngsZBhGl/r0
         LqAa1AnJiQWs4b/laQtePIZST7U/pDy9YqDT1JCBPAfqTyE7yxe+++Vq2oK6qlJflfUH
         dg9s8GWw/GFbnXwownLwidYwbIs+VAv5F1KEvVXgEN9oIToZjpjkqg2t5YOl54aBB4Y1
         Xqp9KyRNpZJ7xJxymULv12f76KOvNuICliBeAqCnjY+nvPyXSR9qBy1pjiLkOtYe7Njf
         ZV4KZO4dv9pSE/Wh5KVn4EVjb8r4YPOJ8nl4pvSend3XIncll91NYiqhShAdrhKIeMBB
         UBqg==
X-Gm-Message-State: AOAM533uAHEJ82VJrT6Dot+80cCYmAahItRkZCpv2mdcxGNArYtikMlo
        h2PWSFxSZoqdmmBp7vDs2d0ndiIeIdrWtr1w3MKEYsoBy/NN8hVQ1780JaMMhQr9HXhZNOoUDfK
        Ibf3dhetbvhEjwZbWNQBFc9ue
X-Received: by 2002:a05:6402:1488:: with SMTP id e8mr9445734edv.456.1644511327595;
        Thu, 10 Feb 2022 08:42:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxci+g4KdlhQJdPQsHLDQyganMyA0JZJT4R8y9CBHPnperKe1p+kKa70UagPWCt1bMc0BN2Q==
X-Received: by 2002:a05:6402:1488:: with SMTP id e8mr9445705edv.456.1644511327370;
        Thu, 10 Feb 2022 08:42:07 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id j2sm7138173ejc.223.2022.02.10.08.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:42:06 -0800 (PST)
Message-ID: <0ed5a95c-39d7-1139-4234-83b1857504b4@redhat.com>
Date:   Thu, 10 Feb 2022 17:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.10 5/6] KVM: SVM: Don't kill SEV guest if SMAP
 erratum triggers in usermode
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Liam Merwick <liam.merwick@oracle.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220209185714.48936-1-sashal@kernel.org>
 <20220209185714.48936-5-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220209185714.48936-5-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 19:57, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit cdf85e0c5dc766fc7fc779466280e454a6d04f87 ]

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Inject a #GP instead of synthesizing triple fault to try to avoid killing
> the guest if emulation of an SEV guest fails due to encountering the SMAP
> erratum.  The injected #GP may still be fatal to the guest, e.g. if the
> userspace process is providing critical functionality, but KVM should
> make every attempt to keep the guest alive.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Message-Id: <20220120010719.711476-10-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/svm/svm.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index fa543c355fbdb..d515c8e68314c 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4155,7 +4155,21 @@ static bool svm_can_emulate_instruction(struct kvm_vcpu *vcpu, void *insn, int i
>   			return true;
>   
>   		pr_err_ratelimited("KVM: SEV Guest triggered AMD Erratum 1096\n");
> -		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> +
> +		/*
> +		 * If the fault occurred in userspace, arbitrarily inject #GP
> +		 * to avoid killing the guest and to hopefully avoid confusing
> +		 * the guest kernel too much, e.g. injecting #PF would not be
> +		 * coherent with respect to the guest's page tables.  Request
> +		 * triple fault if the fault occurred in the kernel as there's
> +		 * no fault that KVM can inject without confusing the guest.
> +		 * In practice, the triple fault is moot as no sane SEV kernel
> +		 * will execute from user memory while also running with SMAP=1.
> +		 */
> +		if (is_user)
> +			kvm_inject_gp(vcpu, 0);
> +		else
> +			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
>   	}
>   
>   	return false;

