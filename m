Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB794B1334
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbiBJQk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:40:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbiBJQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:40:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35DCED44
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30EUFe9ZMAk2o8E42dYwy3LHUtkFtK7cdn4oOH+aiTc=;
        b=DeaeIRyMVb4mRSZFRQOerGdutbeSlgUpoRYm+Ha6l/6o2f5Rg8Eernc0eBt8W6Ytz95QLa
        T78/EZijMj+pdfuYRjiq8AFm3iNwy6APf1+HjYkcKrSyYi70GPkiGDYGFTavK1wLG/iuXV
        EG5SKvrShJbuYWDb4fd6r4BZdH+8m8Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-sVr30EqWPgqAXO5aewkjgw-1; Thu, 10 Feb 2022 11:40:48 -0500
X-MC-Unique: sVr30EqWPgqAXO5aewkjgw-1
Received: by mail-ed1-f72.google.com with SMTP id x6-20020a05640226c600b0040fe1993eebso2955919edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=30EUFe9ZMAk2o8E42dYwy3LHUtkFtK7cdn4oOH+aiTc=;
        b=7EoLMT6vpk1GWcIAYqnGPtgaOSEZdBUNj5mS2j9nNgv4s4lyUQmoudOBA/dgVwQZwB
         2XGW8xF8tyGMSdOc+VM5es5Y2cwuX71jHnPojkxLy9s3+uU/R64zkfmDix6e53lZiMqF
         zB08NJF3IU/27sxMRpRm6UbMyK5UYNUTBsflK70ksAZpFfY6DRSmGxtayqdeNc+pOE34
         DbwS0s/2Vec0u4gvMeZVbBdSmpsl/SOFrfbr62/PZrxOmcl42AbNTNA4mDBuwHwX7GQN
         mKzxx1fGoxUaHI0ISC3QPAG/s6FI+w/Gczh/kQgwrvkqiZ1aJV4OukQhKoILZs5FD563
         xx+w==
X-Gm-Message-State: AOAM533jOYpgvdLe6sNeBWOqxQqUMZxGjzwA+vb7Vcno/9w8Y/ZrzXME
        RLs+AvSMdTqlwVbsOhxHpwclrSj8YxEETsBo6SR0GBa2a196FbFZx8HRX0pwx26ihYEm50mDcLi
        Ku08GFimPMZ9dZFohx6IREfcu
X-Received: by 2002:a17:906:99c6:: with SMTP id s6mr7547455ejn.522.1644511246916;
        Thu, 10 Feb 2022 08:40:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYRgarg4MQSjsf/6d2XAuFlbPg+lsO2UEU8IjFLj5NbFvJtES92CmW7ZnePV8UnC/mde0BEg==
X-Received: by 2002:a17:906:99c6:: with SMTP id s6mr7547437ejn.522.1644511246686;
        Thu, 10 Feb 2022 08:40:46 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id i9sm8367958eda.35.2022.02.10.08.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:40:46 -0800 (PST)
Message-ID: <98254cb1-cb10-ddfe-7ea7-ae71d9f63316@redhat.com>
Date:   Thu, 10 Feb 2022 17:40:43 +0100
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

> 
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

