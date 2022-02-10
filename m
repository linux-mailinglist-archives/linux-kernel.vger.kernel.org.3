Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9898D4B12F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbiBJQhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:37:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiBJQg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:36:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBB4D1A8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/F8usK/+OWwDrS2Mysaltt+CBSk5zwPQAlyY9XUelc=;
        b=enVV39vcTf/HPRxWPI9XWwNkAhA4HPcqOj0uFgQG6Ebg2Cz4CikAFRn6fracv0cCZiqCa7
        CzZI+yzyK8uoPaO+6rGmnD14UHgFZ2PXslFyU4OBZfFxEjJzRJJGMMcsdLrkx8bqGDX+fq
        ldXxGatXjDnyY3G9PyfPCbm2h3QCdCo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-7w-Pyi-nO5S4lTiaOqmoZw-1; Thu, 10 Feb 2022 11:36:56 -0500
X-MC-Unique: 7w-Pyi-nO5S4lTiaOqmoZw-1
Received: by mail-ej1-f72.google.com with SMTP id z26-20020a1709067e5a00b006cbe0628826so2993985ejr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f/F8usK/+OWwDrS2Mysaltt+CBSk5zwPQAlyY9XUelc=;
        b=vLfcJ3R8R//m7oMb0zQPPB4ET+rR9sxRiTcNhOv5CpdVlWfBzvPuBtq3y40uosTAHt
         IZSmpu8nL3Q233VjWbg09xtJAW2HbGHCXCnwX1C0epPgau2S6k8gRQVCp2j16f3SNqD3
         59D1NqYsw3pMq31tJ6n2oTbO4ZlNhfeRQalgJc2JbDVayg3Sws8OgqCn25ImmPubbRrN
         Jzd1mSBZyp453id6r40AHsk5CJF2/OdlmGinIbsDPLcrnfCMba+0PpfEanRGRFC4LGeL
         oKiVo2XH/7a+8H77EwyvYU0J1rgombG8HL9RcaWlC38LvpTA7OgzuG03jvq7uEoucOjo
         nOaA==
X-Gm-Message-State: AOAM532G51MGwz1LX5RcnidVKz99SHGfYOOaHwAW3JS3eIVEdcGu5KmB
        K/tnP9sKHD6CgvURwY5T1h/bMyQhLk2PqXNmq5r53bIZjYrUupqFPuAuoSfiJTe+JSORIibqFj/
        s6qmUQmTrAuwfKy1ZfCMB0bBu
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr7342462eji.174.1644511015574;
        Thu, 10 Feb 2022 08:36:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC0ul3dl+hcrAmDYZTPnQFJaDZrWBZxFPAbbw2BCoE9Jfu0NVY0ZSkzikKjxBe05mTUn5T4A==
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr7342447eji.174.1644511015370;
        Thu, 10 Feb 2022 08:36:55 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.240])
        by smtp.googlemail.com with ESMTPSA id b17sm5678470ejd.34.2022.02.10.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:36:54 -0800 (PST)
Message-ID: <52ec7622-efcf-dfd6-2560-3114f90f7618@redhat.com>
Date:   Thu, 10 Feb 2022 17:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.10 4/6] KVM: nVMX: WARN on any attempt to
 allocate shadow VMCS for vmcs02
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220209185714.48936-1-sashal@kernel.org>
 <20220209185714.48936-4-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220209185714.48936-4-sashal@kernel.org>
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
> [ Upstream commit d6e656cd266cdcc95abd372c7faef05bee271d1a ]
> 
> WARN if KVM attempts to allocate a shadow VMCS for vmcs02.  KVM emulates
> VMCS shadowing but doesn't virtualize it, i.e. KVM should never allocate
> a "real" shadow VMCS for L2.
> 
> The previous code WARNed but continued anyway with the allocation,
> presumably in an attempt to avoid NULL pointer dereference.
> However, alloc_vmcs (and hence alloc_shadow_vmcs) can fail, and
> indeed the sole caller does:
> 
> 	if (enable_shadow_vmcs && !alloc_shadow_vmcs(vcpu))
> 		goto out_shadow_vmcs;
> 
> which makes it not a useful attempt.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20220125220527.2093146-1-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/vmx/nested.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0c2389d0fdafe..0734a98eaaad1 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4786,18 +4786,20 @@ static struct vmcs *alloc_shadow_vmcs(struct kvm_vcpu *vcpu)
>   	struct loaded_vmcs *loaded_vmcs = vmx->loaded_vmcs;
>   
>   	/*
> -	 * We should allocate a shadow vmcs for vmcs01 only when L1
> -	 * executes VMXON and free it when L1 executes VMXOFF.
> -	 * As it is invalid to execute VMXON twice, we shouldn't reach
> -	 * here when vmcs01 already have an allocated shadow vmcs.
> +	 * KVM allocates a shadow VMCS only when L1 executes VMXON and frees it
> +	 * when L1 executes VMXOFF or the vCPU is forced out of nested
> +	 * operation.  VMXON faults if the CPU is already post-VMXON, so it
> +	 * should be impossible to already have an allocated shadow VMCS.  KVM
> +	 * doesn't support virtualization of VMCS shadowing, so vmcs01 should
> +	 * always be the loaded VMCS.
>   	 */
> -	WARN_ON(loaded_vmcs == &vmx->vmcs01 && loaded_vmcs->shadow_vmcs);
> +	if (WARN_ON(loaded_vmcs != &vmx->vmcs01 || loaded_vmcs->shadow_vmcs))
> +		return loaded_vmcs->shadow_vmcs;
> +
> +	loaded_vmcs->shadow_vmcs = alloc_vmcs(true);
> +	if (loaded_vmcs->shadow_vmcs)
> +		vmcs_clear(loaded_vmcs->shadow_vmcs);
>   
> -	if (!loaded_vmcs->shadow_vmcs) {
> -		loaded_vmcs->shadow_vmcs = alloc_vmcs(true);
> -		if (loaded_vmcs->shadow_vmcs)
> -			vmcs_clear(loaded_vmcs->shadow_vmcs);
> -	}
>   	return loaded_vmcs->shadow_vmcs;
>   }
>   

NACK

