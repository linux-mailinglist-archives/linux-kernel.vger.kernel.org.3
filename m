Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8654C9636
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiCAUUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbiCAUSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:18:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD3503ED36
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646165884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQZrtVuy9kKKsyT+8Y9jp+2u0Tvvpcn4qKJuYdqXs+k=;
        b=VUGXGtK7MojqNmFYEmKvyIaJeD/RjaxsY6zmP9ZVTYhuDwmrsaDKeKSjNqJTPFuYxVyE1X
        KNxhUN7dKN1qrc3w6NrLpXiWrS5/2wuQFCfJE/RSgWZxBr6hDv17mpBnuC4Ap8ApLMpkJQ
        IPe08H6cGnI05Zyn06TIlhPjtc5zvII=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-FB0fb_oNNIKQZgCaX0zaEQ-1; Tue, 01 Mar 2022 15:18:01 -0500
X-MC-Unique: FB0fb_oNNIKQZgCaX0zaEQ-1
Received: by mail-wm1-f69.google.com with SMTP id i20-20020a05600c051400b00380d5eb51a7so1728497wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZQZrtVuy9kKKsyT+8Y9jp+2u0Tvvpcn4qKJuYdqXs+k=;
        b=smnSa0C4HAOBqJDHAOU0fSM+G5OHmQYlC6098m6rRNeQIvlf7AmQ+X+fLhac6Oth42
         8axP+Iw6kBPtQYa1n8CC2YosbWSYGnCJSw1Rxy3Ffe9rYOeAIIfkNKdysJb9M7ezImor
         NO10D5v+y41Y20AziCQV0eoEdq6hD2uESpWs+RSlR9DGs40rtqU7Fr2PuzVbnOS0AJkm
         v7n95IjHd24DOGmFIYfdxErjdAVCD3CMc0LxrhYfdWXs0TvpxO9u/eBc/dgkLOugukjL
         Cv4olhjCzt8Icj0HOO+LhROFKDcnZArSEwoQdSPigawSdyr0qmjW9dciKYywEOeGRPVM
         P2gw==
X-Gm-Message-State: AOAM530+B0kKkdTSHDz/XmM8iuFw5xTmrE8h7cq6+/98yX54+KRKt5ho
        KMamCFTYckL0Bvj7y/xpo4pg9fQvGjsjiXySLq2p4mq2i3RVyYJj4QWJsBh0tbCN2U4YxVAo1RE
        RKDGHBvIcmt6i670PlUtKWBHy
X-Received: by 2002:adf:e751:0:b0:1f0:2139:2489 with SMTP id c17-20020adfe751000000b001f021392489mr2670919wrn.319.1646165880604;
        Tue, 01 Mar 2022 12:18:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSGFT/AiTOTVDsPN9t4qCs3g6teuVwBPhl3eBpDFuJTK7Dxs8z9mp2S00EWTLHlAwjOYoweQ==
X-Received: by 2002:adf:e751:0:b0:1f0:2139:2489 with SMTP id c17-20020adfe751000000b001f021392489mr2670909wrn.319.1646165880336;
        Tue, 01 Mar 2022 12:18:00 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id b13-20020a05600c4e0d00b003816cb4892csm6799721wmq.0.2022.03.01.12.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 12:17:59 -0800 (PST)
Message-ID: <815a7008-b8b0-d745-e1c3-96092e887772@redhat.com>
Date:   Tue, 1 Mar 2022 21:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH AUTOSEL 5.15 10/23] x86/kvm: Don't use pv
 tlb/ipi/sched_yield if on 1 vCPU
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220301201629.18547-1-sashal@kernel.org>
 <20220301201629.18547-10-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220301201629.18547-10-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 21:16, Sasha Levin wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> [ Upstream commit ec756e40e271866f951d77c5e923d8deb6002b15 ]
> 
> Inspired by commit 3553ae5690a (x86/kvm: Don't use pvqspinlock code if
> only 1 vCPU), on a VM with only 1 vCPU, there is no need to enable
> pv tlb/ipi/sched_yield and we can save the memory for __pv_cpu_mask.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> Message-Id: <1645171838-2855-1-git-send-email-wanpengli@tencent.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kernel/kvm.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index b656456c3a944..811c7aaf23aac 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -457,19 +457,22 @@ static bool pv_tlb_flush_supported(void)
>   {
>   	return (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
>   		!kvm_para_has_hint(KVM_HINTS_REALTIME) &&
> -		kvm_para_has_feature(KVM_FEATURE_STEAL_TIME));
> +		kvm_para_has_feature(KVM_FEATURE_STEAL_TIME) &&
> +		(num_possible_cpus() != 1));
>   }
>   
>   static bool pv_ipi_supported(void)
>   {
> -	return kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI);
> +	return (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
> +	       (num_possible_cpus() != 1));
>   }
>   
>   static bool pv_sched_yield_supported(void)
>   {
>   	return (kvm_para_has_feature(KVM_FEATURE_PV_SCHED_YIELD) &&
>   		!kvm_para_has_hint(KVM_HINTS_REALTIME) &&
> -	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME));
> +	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME) &&
> +	    (num_possible_cpus() != 1));
>   }
>   
>   #define KVM_IPI_CLUSTER_SIZE	(2 * BITS_PER_LONG)


NACK

Not really necessary.

Paolo

