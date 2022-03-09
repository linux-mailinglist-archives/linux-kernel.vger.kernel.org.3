Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516454D3575
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbiCIRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiCIRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:01:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC4FB1052AF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646844461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtHZAmMaUYAx0LRBNry1Z8g5yS/lTA9TMVV6Zdqr9HI=;
        b=BYfrRTalkZ7ByBaYceTjXgQMZ8rw5k4wRj7NlM4FQOrjeGqY9eTRUhlBjPvn+A89TpShO2
        OtOC3QX8nXF6dzvFPF7aNxzGr3+fXj3/XSmFumX02tdMHzgJPQGe1EDmGuMDYOP6Nuc+zT
        q97VgYpSiuPSEqYgdO5pz3pjA9Mfmi0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274--FDnHRUINxOZlu-W9BcJUQ-1; Wed, 09 Mar 2022 11:47:39 -0500
X-MC-Unique: -FDnHRUINxOZlu-W9BcJUQ-1
Received: by mail-ej1-f69.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so1594057ejw.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GtHZAmMaUYAx0LRBNry1Z8g5yS/lTA9TMVV6Zdqr9HI=;
        b=SakN3tsyfF85tuaBhLLOFrn3E+bFbi8J1Yy6+wC5+K0eC5Q05cVRiVGAa0BoIJr7Zu
         53M8SIeCbNhYhyiitDqPn54xJOJ7y1rG88CPRsl2rWQ1V91p42tjHY38Twq7p6akQUWW
         88Ruzcmr3DFEH6xzRm4bZDygtxmuEAPLOlccZkcPETcST82VzYYp+Bji97ohDrxO0Vas
         //6yPNdjSPT03BAesBG6hG6jkCni9iNPpzFNQMM25DPXdSMTTD9qCK/AHYxCYSTYQw96
         o5EymtjYqEgzMC+ExAd/quqrgV/Ekb953q2F5P9RMcADfJ1mPxily4jXLxTJvmeZ1KI2
         d26w==
X-Gm-Message-State: AOAM533CAPcuFFgKMwSBV3iKwSGeWij9a6jk9jm/6UiLMv0kw5/jg3ut
        oIbTCIxTVWrRhHwlFWc2h1RvgG6w992Ooi+H9GWvnK50Y+7NvAHc/C2xmk+3ZMG1a6HaErnqz75
        y4ddoP0g3BxrjOaHIWSwyJgAT
X-Received: by 2002:a17:907:60ca:b0:6da:8f25:7983 with SMTP id hv10-20020a17090760ca00b006da8f257983mr631820ejc.106.1646844457789;
        Wed, 09 Mar 2022 08:47:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7W66bmqFbu8gYAU5N0gz7/+fCQJtGeEoAcf1WlMCvUxsd/Rx1EWoj8m+ZeeL+r81lz05NDA==
X-Received: by 2002:a17:907:60ca:b0:6da:8f25:7983 with SMTP id hv10-20020a17090760ca00b006da8f257983mr631795ejc.106.1646844457559;
        Wed, 09 Mar 2022 08:47:37 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm908648ejj.74.2022.03.09.08.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 08:47:36 -0800 (PST)
Message-ID: <63493d06-0b6c-9993-2315-64033dd041d6@redhat.com>
Date:   Wed, 9 Mar 2022 17:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.15] KVM: x86: Yield to IPI target vCPU only if
 it is busy
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220309164632.137995-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220309164632.137995-1-sashal@kernel.org>
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
> index b656456c3a94..49f19e572a25 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -565,7 +565,7 @@ static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
>   
>   	/* Make sure other vCPUs get a chance to run if they need to. */
>   	for_each_cpu(cpu, mask) {
> -		if (vcpu_is_preempted(cpu)) {
> +		if (!idle_cpu(cpu) && vcpu_is_preempted(cpu)) {
>   			kvm_hypercall1(KVM_HC_SCHED_YIELD, per_cpu(x86_cpu_to_apicid, cpu));
>   			break;
>   		}

NACK

