Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7E4C9132
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiCARLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiCARLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F8E2527DA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646154637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IH9rb3VcjpDsFZ/YCYjhMltcnIub3IIrtIxtcluXcEI=;
        b=UsKcofaYwnGiqEd7PA9y4mVzTsgRluSmt/9lj+TcO6+FUwTTNkKxAEOdKcWaYGHiPm0jul
        AWduh3MRsTJ/jMLfRCikuM+rL7dLqKLEJZwWbZ3ZLrNKzmKPc7O7urBqPpGXmF/tX+Ps6d
        dXcWwbHD6uh7+f+ORRyxqzeVmC/upuc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-ajNhusWnOLeptjwyVcG0og-1; Tue, 01 Mar 2022 12:10:34 -0500
X-MC-Unique: ajNhusWnOLeptjwyVcG0og-1
Received: by mail-wm1-f72.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1500811wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IH9rb3VcjpDsFZ/YCYjhMltcnIub3IIrtIxtcluXcEI=;
        b=fd7RTvCYYn1olqm6zTzbXVUO+lGm3obIni8VpHYvjSoKmZ9omK0CeKLOdH8QJNFzgh
         mSFHsIsdfFwqyiyiXlmZ5AoyfdalRBypOHvBvQO7yIrmuVVdvVsnCwqkByPOsn9TglNS
         Gpsb6l++PkmZFh80LVhUJDZ0KCi8vf7OR8HoTMGfBg+Pd2CJMAyGP67F1OAaDOEuGCmB
         gvHJVzIkJIsr/dA0DMKEiFLc4978oFYrmRG6OacOw3ORQzBEKvDMF/kSLxVcyM292/6x
         N4HfsjbRdCini6v84h54UnfmaHnEGLEgDHGq+0eOUnGGVXhfeHWqswNhOhG8uZTTX6Oz
         y+2g==
X-Gm-Message-State: AOAM5327/2I3/HeY0HEPICkRhKhyZR7MiU/UO46pwBec/SuLYbLW6Jpu
        uX/H5tJ/6LKmAxvJFQ5S2DLg2VHqaGPw/JXk+Sy+9RCpdSWr0c56mQamtB62QrrbaGhbgfrpMCD
        2mMX4SGWVqynkjiJEIEeuqTTD
X-Received: by 2002:a1c:2604:0:b0:381:6736:6427 with SMTP id m4-20020a1c2604000000b0038167366427mr8600869wmm.141.1646154632579;
        Tue, 01 Mar 2022 09:10:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAFUzNCLJ60+uLIDCoKB+E2FzZPEyp7zjReUMAYsoMZO6bWb0ZTi2al0UllgHlTDEiDZvxfQ==
X-Received: by 2002:a1c:2604:0:b0:381:6736:6427 with SMTP id m4-20020a1c2604000000b0038167366427mr8600854wmm.141.1646154632349;
        Tue, 01 Mar 2022 09:10:32 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm4416735wmi.32.2022.03.01.09.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 09:10:31 -0800 (PST)
Message-ID: <e9e3f438-8699-abba-a1f8-d4d8bfbd63ed@redhat.com>
Date:   Tue, 1 Mar 2022 18:10:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.10 1/2] KVM: x86: lapic: don't touch
 irr_pending in kvm_apic_update_apicv when inhibiting it
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220222140532.211620-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220222140532.211620-1-sashal@kernel.org>
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
> index 677d21082454f..d484269a390bc 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2292,7 +2292,12 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
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

