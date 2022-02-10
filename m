Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E06A4B1350
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbiBJQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:43:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbiBJQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:42:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 025BCEB6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYrtoAjfH9TWpwEYLvzJDdywJWU9b7QnIIQHiQGQztM=;
        b=VQNY3c2TUQvKrQRGunHhfqnzz6JkZSyIF/edIM7HIgOjaSZSCcXpKQEVpq9soMm8swfUcm
        OLBOj9cxBBRUnEvBvdy6I6e1HG+MBH6TRoj7XPzFa6K553+4ithOJGlx2X+g6ARuc6MZm5
        6gHl5Sj9l9nSIJ/zeLTtHI5uaBwa3N4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-HXJryP83MZeCZIx_8gtawA-1; Thu, 10 Feb 2022 11:42:25 -0500
X-MC-Unique: HXJryP83MZeCZIx_8gtawA-1
Received: by mail-ej1-f72.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so2986037ejk.16
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GYrtoAjfH9TWpwEYLvzJDdywJWU9b7QnIIQHiQGQztM=;
        b=Cn4zqXxUEUF/QCc80/nob9q76DDAFjWgIMoLWNAlGKmqH7r1ySObAqygPH7scENQM6
         JM+DeUZ9NO4VL2qnoFtBoWO8iJ5PdQf7oM48ODHdiZm03Xa0ZBgWgik0yuODXdDbzR+2
         eV8s9X2bnPn4/PuDbpgAKPzKAyOyOp7VonOumcaipprx2sEbuPjsKfp8Oe2duzJgaE0c
         rRaLadpBqDcZdQsMaZrFvLN3+py8mCAw9mWrusupILD6yMA4TXV46DRyhQf6S7BFCUFv
         kK+9rOyQSxcAhLJDhkpcoCWnduZXnm5VGVKgnvz2n4bKq7n6jMNu3BYlFLS4GSMuLHD4
         nQIw==
X-Gm-Message-State: AOAM532p4XFV+h58Qjs3LKyjoTinjrhJOWV0E6kAp8FH+hxjrQaCMm58
        BjDsP2/p0zPhJx1CwkfQoNcLFMZjwXSAcpHK8lHUIKRJxfwyzeha8rZpVxTJRo49gDJnae6JTE+
        FoYd9J2sRD1BihWA7ui9Enzf9
X-Received: by 2002:a50:e701:: with SMTP id a1mr9130579edn.110.1644511344251;
        Thu, 10 Feb 2022 08:42:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxl1HCOR1GQW8ptvL34wfWqIQQvxidnniyiZo5rnQiYNTjgkAWVn6Z+VMIXPN/nVqdPNe8hRQ==
X-Received: by 2002:a50:e701:: with SMTP id a1mr9130562edn.110.1644511344025;
        Thu, 10 Feb 2022 08:42:24 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id da9sm6736003edb.1.2022.02.10.08.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:42:23 -0800 (PST)
Message-ID: <1d8e2504-8e45-41af-c63a-87037b04f407@redhat.com>
Date:   Thu, 10 Feb 2022 17:42:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.15 6/8] KVM: SVM: Explicitly require
 DECODEASSISTS to enable SEV support
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Liam Merwick <liam.merwick@oracle.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220209185653.48833-1-sashal@kernel.org>
 <20220209185653.48833-6-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220209185653.48833-6-sashal@kernel.org>
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
> index 134c4ea5e6ad8..d006eeb1d0321 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1887,8 +1887,13 @@ void __init sev_hardware_setup(void)
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

