Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C13C4D372F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiCIRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiCIRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD0A71045B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646844427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipYouFZiDbGHky53FeVZHKDK4SIGwfG+XTgGSHDhMCM=;
        b=dhMnYI/1dEQnA4V60Eji275p2xDmmFLE3wfbcCXixlhjYZDp0sX3Ag63PnLFKH6zizvpzP
        o54pLWZP7DO48MlADbz/fWrpomDjbkjASusrq8c9bbz2JQ9HFXaXgYqJjp0O4B5qXjTmNf
        WbQfco5TZwowSFh78Jm2ECZYfQxR3dE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-YVKXldqiNvCyc5Qr3YffIQ-1; Wed, 09 Mar 2022 11:47:06 -0500
X-MC-Unique: YVKXldqiNvCyc5Qr3YffIQ-1
Received: by mail-ej1-f72.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso1579876ejc.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ipYouFZiDbGHky53FeVZHKDK4SIGwfG+XTgGSHDhMCM=;
        b=kDsWFHkpdN+QIThY5R9U6ABcHZKG4gdAa0yePIOu3D+kvVsGqi6qpWv832YU6FFmqS
         6jK/0C/n0UBPBMcPvXb5dISnPKHKKsgCnIaj1Fr0Q8Qf2WDPWXBRtGvM16UagFEdfnXk
         KcR90TvqV6DSTsI9bA1qsrkbqvFlx4hCvyWaUs0zu0aR6T0wEIjhlmnCIwZk4KUEN9V1
         yKfq3Sqp1D24d3KUWQFnpqWCn+Dt4xqMpFg7zTFfMnnbBMOZKQvdANlLDnyKmA//AFsn
         TAjBRHiGpBry7OsvVN6MX43Br+qHkEx9CnWUUyh0JLZaPXJ9Kk9jPabJtSQcszgczaS0
         GHFQ==
X-Gm-Message-State: AOAM530UNQJCjMDLMmoYIW4rdEbXhFLD4G+g75mBUMa/YhOTxDtEf5bh
        msJMKIKkelow+/YG49+CUKbM/MPYKdjDeP/oLQfUbUcc4gAqIWEGi/ye+3e4bisFH90lRjhEiv3
        yt+s3fI6j74VzCOyDx9s+u6DC
X-Received: by 2002:a05:6402:3489:b0:416:9121:6936 with SMTP id v9-20020a056402348900b0041691216936mr310688edc.249.1646844425022;
        Wed, 09 Mar 2022 08:47:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzH84i/kZ3vII5SpLkdFUh2hPiQt7AxMY/YMw3liCSc3DymOHCpIJ4tZh9EtCphaVdzBD/ZZQ==
X-Received: by 2002:a05:6402:3489:b0:416:9121:6936 with SMTP id v9-20020a056402348900b0041691216936mr310666edc.249.1646844424802;
        Wed, 09 Mar 2022 08:47:04 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm1046807edm.90.2022.03.09.08.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 08:47:04 -0800 (PST)
Message-ID: <c7e4a000-9e76-266a-7cb3-4ccdaf54bf6b@redhat.com>
Date:   Wed, 9 Mar 2022 17:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.16] KVM: x86: Yield to IPI target vCPU only if
 it is busy
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220309164618.137930-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220309164618.137930-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 17:46, Sasha Levin wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> [ Upstream commit 9ee83635d872812f3920209c606c6ea9e412ffcc ]
> 
> When sending a call-function IPI-many to vCPUs, yield to the
> IPI target vCPU which is marked as preempted.
> 
> but when emulating HLT, an idling vCPU will be voluntarily
> scheduled out and mark as preempted from the guest kernel
> perspective. yielding to idle vCPU is pointless and increase
> unnecessary vmexit, maybe miss the true preempted vCPU
> 
> so yield to IPI target vCPU only if vCPU is busy and preempted
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Message-Id: <1644380201-29423-1-git-send-email-lirongqing@baidu.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kernel/kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 59abbdad7729..2121c20e877f 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -619,7 +619,7 @@ static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
>   
>   	/* Make sure other vCPUs get a chance to run if they need to. */
>   	for_each_cpu(cpu, mask) {
> -		if (vcpu_is_preempted(cpu)) {
> +		if (!idle_cpu(cpu) && vcpu_is_preempted(cpu)) {
>   			kvm_hypercall1(KVM_HC_SCHED_YIELD, per_cpu(x86_cpu_to_apicid, cpu));
>   			break;
>   		}

NACK, just an optimization.

Paolo

