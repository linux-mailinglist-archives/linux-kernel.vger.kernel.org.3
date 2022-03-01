Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C92A4C9125
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiCARKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiCARKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C76A340907
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646154597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZUMnyvqR6wCb4IOQc4AjR2UMdvh6J4gOvtFiHLptac=;
        b=fjPAoitSkT9DhADby6N49wm7aPQbcnNFetHOj4uOgLaiVw/1WE/gusYOfZWe0HuQjrR9CP
        56BvaiORbWkjvy2kBD7OpM2i83G0NLz5WbDxi++YzjNR99Hc9tnv54OFJl5xy+v/NSYQtq
        JwmNdr/XYmNdugS9zdJ5YwSatKweLmA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-72t2FoPLNDGItjDorhYB4A-1; Tue, 01 Mar 2022 12:09:55 -0500
X-MC-Unique: 72t2FoPLNDGItjDorhYB4A-1
Received: by mail-wm1-f69.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso1092060wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NZUMnyvqR6wCb4IOQc4AjR2UMdvh6J4gOvtFiHLptac=;
        b=BQu9TOCs7oFw5NhpkErvaha44sMTnvZteZ2K5IV34RoqY0we3C2or6KuC08gmpN9ER
         rqs0KNBYkPBW77q2XB/VxKjJTXTiBLDQcdoXV8QYtcBzVzJ+7U78BcPZPHZrAesRndbn
         bfaZb/bxWs+RftH2XuBYD6sg9jNoBQ98Etr+1iDBGavnyckyXZZl2+JrBgmuV/vEa/yd
         tp47YATrgO3oD4yZd98M43cLGynu6LKKmrc8spCaU+scuL07PQv4G8s2B6lFFaVA/exL
         m2/x42pqSi6qdkKIcF+20CwGgKHaGdzmxzeASWcIXMm8TcdgWFF2610LYdF+jqlzDQHJ
         Aw1A==
X-Gm-Message-State: AOAM531eMQgE1pAUnfWMU0/UWmlrN0EHrPXWEWLk/uNFaxUIhw5vj9du
        I9uXCrqomOKIu4SdEYLU9H+z3632LY8XCi3DY3/oTeKujmauBP1+pt8jqvpQa/Sr4P3pxD0WbTp
        IP3fRutCGcG/MX7SOd6BpjUKp
X-Received: by 2002:a05:6000:18a1:b0:1ef:8e17:e82c with SMTP id b1-20020a05600018a100b001ef8e17e82cmr11966000wri.254.1646154593038;
        Tue, 01 Mar 2022 09:09:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylMCDoPBFWrk9UBp13BlbJntex79zo8tb9uzzaaTzQ9nZhnDGchYhtkFScJKPXwMhtlbDtpQ==
X-Received: by 2002:a05:6000:18a1:b0:1ef:8e17:e82c with SMTP id b1-20020a05600018a100b001ef8e17e82cmr11965991wri.254.1646154592831;
        Tue, 01 Mar 2022 09:09:52 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id r1-20020a5d4941000000b001ed89dcacbbsm14008863wrs.23.2022.03.01.09.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 09:09:52 -0800 (PST)
Message-ID: <51a6e2a5-57d4-5f6d-79fa-13daa544266d@redhat.com>
Date:   Tue, 1 Mar 2022 18:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.16 1/2] KVM: x86: lapic: don't touch
 irr_pending in kvm_apic_update_apicv when inhibiting it
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220222140522.211548-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220222140522.211548-1-sashal@kernel.org>
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
> index e8e383fbe8868..bfac6d0933c39 100644
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

