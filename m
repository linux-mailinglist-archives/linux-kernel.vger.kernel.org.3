Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A014B12EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbiBJQg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:36:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244291AbiBJQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:36:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 875381A8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+SJ/8jiWh1yqA7v50jSrldDjAEMOLgFk+1GemkI9co=;
        b=OjKQjdvqI66HIhFDk+UAt1Ynn64KThZp7Ni3mzqrJz7J18HxnNw45kSFYey1i2Ah+ZrQnn
        h1FVFcobbqqV/eu9SDF3LihzchklrUTuhB3Zrm/G5k0AGUGJ2mKKLwqJ+3pnBXzkcEoPog
        TBTJEwe1VX79vdnz0l2UQRdgfWEFdr8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-oDRzzYN-PNKXA5SN5BlJOg-1; Thu, 10 Feb 2022 11:36:51 -0500
X-MC-Unique: oDRzzYN-PNKXA5SN5BlJOg-1
Received: by mail-ej1-f71.google.com with SMTP id hq19-20020a1709073f1300b006cdd7712c2cso333321ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H+SJ/8jiWh1yqA7v50jSrldDjAEMOLgFk+1GemkI9co=;
        b=IISwYk53RCiF6QYqlsZTpZTea7JLxW393f3jwtr26mphmlhqicVW7izE2idABZq0Zg
         bVL28q6Dpr0zhasW/rRYq0ktdPy7ER2QnK8u6Q6wVcVnQBY7JMm255R1PLUEh9zEda+i
         Orn9pH6zpNlXbKcErYv+iXBlsXNV2Ms2hLRQyoK8Rnc76kN/+Zej0k+eAhQvZ3LwH9cj
         okkri2RFztK9gg7CgR4+GENBzQUvE/6W9i9rno57XDs2uIGpvjRY6N8ogolSBF9HZ1aV
         ldFBkQscG2WfbXHsnukPCIDGL5NnhpkipH3PNmAmcFkjzm/VVYiaiYc138KDhG1BRT6o
         Yxew==
X-Gm-Message-State: AOAM532jAHxJglYhEcehRK7MwWt5vSbuzny22YEtWzBThSFJA/1Kh4GG
        bvLD3AHCu8XtPVYsvEjQisC5u2ql1SltDWCvFtWR+Rt93JWay47Ke0PZ2P7qYQLVZqx3JbKfhrN
        4ewlJ0Q54hSCUMqdfGn7FEraP
X-Received: by 2002:a17:907:7e92:: with SMTP id qb18mr7386257ejc.555.1644511010332;
        Thu, 10 Feb 2022 08:36:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxj9sY5pMOYIOBuRdGDDcyfQz6bxkiuJax77x8qRDfWDnHYKBW8dd3yXbZ6EKAQ5L3qvK4moA==
X-Received: by 2002:a17:907:7e92:: with SMTP id qb18mr7386243ejc.555.1644511010094;
        Thu, 10 Feb 2022 08:36:50 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.240])
        by smtp.googlemail.com with ESMTPSA id cz12sm4919441edb.30.2022.02.10.08.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:36:49 -0800 (PST)
Message-ID: <7d142721-bdbc-1d82-64b5-9df4368f1c67@redhat.com>
Date:   Thu, 10 Feb 2022 17:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.16 6/8] KVM: SVM: Explicitly require
 DECODEASSISTS to enable SEV support
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Liam Merwick <liam.merwick@oracle.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220209185635.48730-1-sashal@kernel.org>
 <20220209185635.48730-6-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220209185635.48730-6-sashal@kernel.org>
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

On 2/9/22 19:56, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit c532f2903b69b775d27016511fbe29a14a098f95 ]
> 
> Add a sanity check on DECODEASSIST being support if SEV is supported, as
> KVM cannot read guest private memory and thus relies on the CPU to
> provide the instruction byte stream on #NPF for emulation.  The intent of
> the check is to document the dependency, it should never fail in practice
> as producing hardware that supports SEV but not DECODEASSISTS would be
> non-sensical.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Message-Id: <20220120010719.711476-5-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/svm/sev.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index be28831412209..932afd713a02c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2099,8 +2099,13 @@ void __init sev_hardware_setup(void)
>   	if (!sev_enabled || !npt_enabled)
>   		goto out;
>   
> -	/* Does the CPU support SEV? */
> -	if (!boot_cpu_has(X86_FEATURE_SEV))
> +	/*
> +	 * SEV must obviously be supported in hardware.  Sanity check that the
> +	 * CPU supports decode assists, which is mandatory for SEV guests to
> +	 * support instruction emulation.
> +	 */
> +	if (!boot_cpu_has(X86_FEATURE_SEV) ||
> +	    WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_DECODEASSISTS)))
>   		goto out;
>   
>   	/* Retrieve SEV CPUID information */

NACK

