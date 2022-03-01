Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1846A4C912F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiCARLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbiCARLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22FE738BC3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646154624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6OVPwau7zPuBrnhuyil6g0ckI5gS9g78XDUATSITBI=;
        b=J0xk11LTlmgxsoxECD/P9z6RBbWKqgyTkvMky1Rv7H28X6vx4BVPB3DqKYxc5loJlIf/SL
        ScFN+dqekUklhP/hmr9vwQpQCSGeGmCDD/Eg949AoUyk815+8rJy3N86VTDn7hzzjvMU5W
        xLrhnKEjwv1RQnYq7NxuGZcpRfxkIKw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-bDW6wnjKOTKPpELFYEl35w-1; Tue, 01 Mar 2022 12:10:22 -0500
X-MC-Unique: bDW6wnjKOTKPpELFYEl35w-1
Received: by mail-wm1-f70.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso1092397wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H6OVPwau7zPuBrnhuyil6g0ckI5gS9g78XDUATSITBI=;
        b=KrNDHCaslViykR5Vihl2c6MJ2EKN3xN6Qn8d6/FAjJ84hYOOrVlMU2fF/WX4KM345R
         DRZIkA5rqYG+7rT1zRqtA+btu38dwg3QemlnC4V1vwao64uhp4VhLtUEscLLCSbB/s5+
         cxgz8KtQPb4CpYsZuC+eWx5VqFpRHeEcFxzEH5xW3oC9pyfH3kcrdlhFzEcb7w13Inz+
         pO5I177yb/z6eOU2eN3tLq798S/KLh/NbI0E60OSyEZ7VBiwLGW42VGkohXoZTJH75PI
         +ajRm96oNDXQyHp6eti1pWIVkd+C7Jtz3rYz3wXoM3SYujNVtvDZnT0enw/vnDCqmB2D
         G+1g==
X-Gm-Message-State: AOAM530IaRhEkXOUOmc5Qe6QquBDBNtfK3KuHBke5i3MZuLk5KXf1wQp
        577kXNY5nPfe7s3xEQ0P3kKW3DZPeA0ghA02AGnDwvIkeaPxnuP5rSJt5SfNbGh2UWqv6m8/wNY
        Mxo39kKXV73oMkF+Y56Hc1Vmf
X-Received: by 2002:adf:8122:0:b0:1e7:b111:3b92 with SMTP id 31-20020adf8122000000b001e7b1113b92mr20781848wrm.695.1646154618939;
        Tue, 01 Mar 2022 09:10:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg50/4ZvZz/ZbBkmosaJf3RLfhi3TzLdubulWZ5a3osAmD1uixEVLZ3aEzT0qC7zT8+nz+JA==
X-Received: by 2002:adf:8122:0:b0:1e7:b111:3b92 with SMTP id 31-20020adf8122000000b001e7b1113b92mr20781837wrm.695.1646154618719;
        Tue, 01 Mar 2022 09:10:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm3999162wmj.18.2022.03.01.09.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 09:10:17 -0800 (PST)
Message-ID: <939b9cb1-2b1d-05e8-90dd-827f8325ce80@redhat.com>
Date:   Tue, 1 Mar 2022 18:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.15 1/2] KVM: x86: lapic: don't touch
 irr_pending in kvm_apic_update_apicv when inhibiting it
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220222140527.211584-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220222140527.211584-1-sashal@kernel.org>
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

On 2/22/22 15:05, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 755c2bf878607dbddb1423df9abf16b82205896f ]
> 
> kvm_apic_update_apicv is called when AVIC is still active, thus IRR bits
> can be set by the CPU after it is called, and don't cause the irr_pending
> to be set to true.
> 
> Also logic in avic_kick_target_vcpu doesn't expect a race with this
> function so to make it simple, just keep irr_pending set to true and
> let the next interrupt injection to the guest clear it.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Message-Id: <20220207155447.840194-9-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/lapic.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 91c2dc9f198df..5f935e7a09566 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2306,7 +2306,12 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
>   		apic->irr_pending = true;
>   		apic->isr_count = 1;
>   	} else {
> -		apic->irr_pending = (apic_search_irr(apic) != -1);
> +		/*
> +		 * Don't clear irr_pending, searching the IRR can race with
> +		 * updates from the CPU as APICv is still active from hardware's
> +		 * perspective.  The flag will be cleared as appropriate when
> +		 * KVM injects the interrupt.
> +		 */
>   		apic->isr_count = count_vectors(apic->regs + APIC_ISR);
>   	}
>   }


Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

