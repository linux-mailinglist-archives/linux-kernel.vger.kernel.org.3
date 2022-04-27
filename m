Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF9C511D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiD0Q1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbiD0Q0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E1E2B1F7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651076451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVPmAljf4Rq+oNSJqgnV7vXLKD2O/E/5jwKdydcKC90=;
        b=jKzKaZ4SBfzrnDnmH2CYTwJja8DBmTWGXjOhECAQylOdhHnogMsezf/xD/K2XQknJ0uPcT
        RFl/dXWnpajFKkAu/QoS9rRUJ0Np/YvtPt5LFTxy7WuXW1KU68iFa3/fLlrij1UKxbWvZ2
        vkYoeYEyIXbZEvOcum+CJPQx/3WKpRM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-5DNzXWJVNKWXW2Bkq_43_A-1; Wed, 27 Apr 2022 12:20:49 -0400
X-MC-Unique: 5DNzXWJVNKWXW2Bkq_43_A-1
Received: by mail-ej1-f72.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so1433987ejw.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vVPmAljf4Rq+oNSJqgnV7vXLKD2O/E/5jwKdydcKC90=;
        b=Nw9l+xL6hTuejfdQqtjYiS35jGCvDkgLJvb+7wHGRq3d82nrDc0GBzzIEO8bPU+C+i
         xixB1v67g88WiWsIzxk1jW//I6+F8nISx1/IP8OlU4WtYXJhzD3mDTKzgZkKuOEKpPvZ
         /3Ft1E6yhJfv7hvnxFDBUmLFvvo1BwsrMGAhSRntoUvdE1SttuQTZSNDnLvenpKA1s3T
         tpetXPddWUdFiscf8i+1cvFhIrgm2ugEc8yrDvtvrdWA2heIopS1P3a2rkT2m+Q4OZhs
         4O0I4qRbQ8dvkoAa8/FItB728nXgIv23dRT3HK6tqb2UoR1L+FzSkd//KWHBruRmzyPa
         SxNQ==
X-Gm-Message-State: AOAM533O6Bl8AfDoNidfXqvq8OeDL/V1GJs6J/LejL2aflsLsslXuO+U
        MtTsrqMi//kOeeBCvy64KaUskvqmhprqPwlqez8naYlTvBhQ2BVoQLzv2jaqJt/hucQI9J9wB2M
        fPI+bPP3tdPniW1FnI56ETFJ/
X-Received: by 2002:a17:907:2d11:b0:6f0:f39:f647 with SMTP id gs17-20020a1709072d1100b006f00f39f647mr26641610ejc.694.1651076448693;
        Wed, 27 Apr 2022 09:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXmviWfjwPmeeCW7yQt3igdzgO0LD3hEcXQeDEytyOjaJsiyJkYY1xJLviJ6oRtfVvEVVy0A==
X-Received: by 2002:a17:907:2d11:b0:6f0:f39:f647 with SMTP id gs17-20020a1709072d1100b006f00f39f647mr26641584ejc.694.1651076448478;
        Wed, 27 Apr 2022 09:20:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id 17-20020a170906059100b006cee1bceddasm6870663ejn.130.2022.04.27.09.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:20:47 -0700 (PDT)
Message-ID: <9eaa82a4-3dba-1ab2-ca2c-8f59252c863b@redhat.com>
Date:   Wed, 27 Apr 2022 18:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH MANUALSEL 5.15 7/7] KVM: LAPIC: Enable timer
 posted-interrupt only when mwait/hlt is advertised
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Sean Christopherson <seanjc@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220427155431.19458-1-sashal@kernel.org>
 <20220427155431.19458-7-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220427155431.19458-7-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 17:54, Sasha Levin wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> [ Upstream commit 1714a4eb6fb0cb79f182873cd011a8ed60ac65e8 ]
> 
> As commit 0c5f81dad46 ("KVM: LAPIC: Inject timer interrupt via posted
> interrupt") mentioned that the host admin should well tune the guest
> setup, so that vCPUs are placed on isolated pCPUs, and with several pCPUs
> surplus for *busy* housekeeping.  In this setup, it is preferrable to
> disable mwait/hlt/pause vmexits to keep the vCPUs in non-root mode.
> 
> However, if only some guests isolated and others not, they would not
> have any benefit from posted timer interrupts, and at the same time lose
> VMX preemption timer fast paths because kvm_can_post_timer_interrupt()
> returns true and therefore forces kvm_can_use_hv_timer() to false.
> 
> By guaranteeing that posted-interrupt timer is only used if MWAIT or
> HLT are done without vmexit, KVM can make a better choice and use the
> VMX preemption timer and the corresponding fast paths.
> 
> Reported-by: Aili Yao <yaoaili@kingsoft.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Cc: Aili Yao <yaoaili@kingsoft.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> Message-Id: <1643112538-36743-1-git-send-email-wanpengli@tencent.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/lapic.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 83d1743a1dd0..493d636e6231 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -113,7 +113,8 @@ static inline u32 kvm_x2apic_id(struct kvm_lapic *apic)
>   
>   static bool kvm_can_post_timer_interrupt(struct kvm_vcpu *vcpu)
>   {
> -	return pi_inject_timer && kvm_vcpu_apicv_active(vcpu);
> +	return pi_inject_timer && kvm_vcpu_apicv_active(vcpu) &&
> +		(kvm_mwait_in_guest(vcpu->kvm) || kvm_hlt_in_guest(vcpu->kvm));
>   }
>   
>   bool kvm_can_use_hv_timer(struct kvm_vcpu *vcpu)

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

