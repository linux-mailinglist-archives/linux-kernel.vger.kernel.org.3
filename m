Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B084F42CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383210AbiDEU3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457224AbiDEQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C4082BCD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649172836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGOKDprACpATycXmJsJYt0TllS34C5LvZmKh+gyonAQ=;
        b=KNRGDcoIJYi0FhWh3t4fufY2bBzPXVj39HwY5PCXVBARvBsaJrnQuYDTQ/G+VXEEme4QbV
        FugiiNjzKEmcloI9egT9Wyc278dwwIH+nusp6w8u0bpTeh2R6mSTdj0jZXVm5KpHri4MG6
        DYeT5exSveoXrfrgT1t4iP+raWJxLMM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-7V-XLK6eOv6CE4gvfAzzWQ-1; Tue, 05 Apr 2022 11:33:55 -0400
X-MC-Unique: 7V-XLK6eOv6CE4gvfAzzWQ-1
Received: by mail-wm1-f70.google.com with SMTP id a16-20020a05600c349000b0038e6392a346so1399750wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iGOKDprACpATycXmJsJYt0TllS34C5LvZmKh+gyonAQ=;
        b=2xIcGUZpmI1M22c490Y6LtKb0DoKk0Hk03P3c/4FyIcLPw7ysX8rfgzrTJ0PpenuJq
         Oa82qRGyTtccsUnXt6puoPFhN4wxBgp5+XHL/YZzvJOh5jR8BszaznKBtDJy2sJW5gBI
         ssstCb/YmYmvX5EFk7NR1Rbcjq62gOISx1G5n+hiKZ2a1O38pEBB65eTQFXlD5fcCxPj
         wggFQR5Czxn4CNBnC3+G09THKIfVXaYA0AU8ICg+AI8iLsY/YTbyhwRE0tl6yrrv//+B
         6Aglqbnc//ipUR+KsD5ajRzFUHV6YkpZh+jmxG++BPdN8pZNI5Saii1ORlF5hVpdi+Tg
         t2Bg==
X-Gm-Message-State: AOAM5321CVky8nVt7ecITnaOsnMC5K2e2EvSVvpoKsy4pBSzg5iEnYDc
        I9Ctp3NUsDP0ixZG/pAdsxo+HODJudv0+XrZgbV21bVZ7uvclBEPCmqX4ueu/FlWp4VUuS0KMRd
        j/yF/2SxlUs0Y9pq2D6ASz/Tt
X-Received: by 2002:adf:9062:0:b0:206:b5e:e934 with SMTP id h89-20020adf9062000000b002060b5ee934mr3260392wrh.434.1649172833799;
        Tue, 05 Apr 2022 08:33:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZlE3/xOwZtXTofjeLu7evIxwxLrhbxXRly/qWwB4adoa71jNtkNARlrTJNIUNiWWNVyFiPw==
X-Received: by 2002:adf:9062:0:b0:206:b5e:e934 with SMTP id h89-20020adf9062000000b002060b5ee934mr3260366wrh.434.1649172833544;
        Tue, 05 Apr 2022 08:33:53 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id e12-20020a5d6d0c000000b001a65e479d20sm14953605wrq.83.2022.04.05.08.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 08:33:52 -0700 (PDT)
Message-ID: <ad71b70b-34da-c14b-5cca-cf8a0b544050@redhat.com>
Date:   Tue, 5 Apr 2022 17:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 076/104] KVM: x86: Add option to force LAPIC
 expiration wait
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <52b0451a4ffba54455acf710b443715ac16effd4.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <52b0451a4ffba54455acf710b443715ac16effd4.1646422845.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 20:49, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add an option to skip the IRR check-in kvm_wait_lapic_expire().  This
> will be used by TDX to wait if there is an outstanding notification for
> a TD, i.e. a virtual interrupt is being triggered via posted interrupt
> processing.  KVM TDX doesn't emulate PI processing, i.e. there will
> never be a bit set in IRR/ISR, so the default behavior for APICv of
> querying the IRR doesn't work as intended.

Would be better to explain "doesn't work as intended" more verbosely. 
Otherwise,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/lapic.c   | 4 ++--
>   arch/x86/kvm/lapic.h   | 2 +-
>   arch/x86/kvm/svm/svm.c | 2 +-
>   arch/x86/kvm/vmx/vmx.c | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 9322e6340a74..d49f029ef0e3 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1620,12 +1620,12 @@ static void __kvm_wait_lapic_expire(struct kvm_vcpu *vcpu)
>   		__wait_lapic_expire(vcpu, tsc_deadline - guest_tsc);
>   }
>   
> -void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu)
> +void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu, bool force_wait)
>   {
>   	if (lapic_in_kernel(vcpu) &&
>   	    vcpu->arch.apic->lapic_timer.expired_tscdeadline &&
>   	    vcpu->arch.apic->lapic_timer.timer_advance_ns &&
> -	    lapic_timer_int_injected(vcpu))
> +	    (force_wait || lapic_timer_int_injected(vcpu)))
>   		__kvm_wait_lapic_expire(vcpu);
>   }
>   EXPORT_SYMBOL_GPL(kvm_wait_lapic_expire);
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 2b44e533fc8d..2a0119ef9e96 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -233,7 +233,7 @@ static inline int kvm_lapic_latched_init(struct kvm_vcpu *vcpu)
>   
>   bool kvm_apic_pending_eoi(struct kvm_vcpu *vcpu, int vector);
>   
> -void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu);
> +void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu, bool force_wait);
>   
>   void kvm_bitmap_or_dest_vcpus(struct kvm *kvm, struct kvm_lapic_irq *irq,
>   			      unsigned long *vcpu_bitmap);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index c7eec23e9ebe..a46415845f48 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3766,7 +3766,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>   	clgi();
>   	kvm_load_guest_xsave_state(vcpu);
>   
> -	kvm_wait_lapic_expire(vcpu);
> +	kvm_wait_lapic_expire(vcpu, false);
>   
>   	/*
>   	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 00f88aa25047..9b7bd52d19a9 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6838,7 +6838,7 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>   	if (enable_preemption_timer)
>   		vmx_update_hv_timer(vcpu);
>   
> -	kvm_wait_lapic_expire(vcpu);
> +	kvm_wait_lapic_expire(vcpu, false);
>   
>   	/*
>   	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if

