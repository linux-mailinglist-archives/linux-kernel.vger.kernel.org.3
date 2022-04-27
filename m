Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E69511DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243296AbiD0Qbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbiD0Q2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A06AC3CFF3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651076582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJ4wAPj8Ho9F1Ue1RXAlHhGRCBLfJzK2cfRA2KGgk4Q=;
        b=DxVEFEjOs9W0Xwq9k8wIrpH9EWuCoew232Cr1axtSmRPOJdfaOJoGzeYBjzT3GPz4gwRPm
        Mz+MZpgDCYL0jYvwncfxr69NVf0lvQMhDYdvUNC9qRnUcjeeL4l5uHT2x8OtzphEz8r5UQ
        +ZsDO4uQSMP625kMWURuyZCxZTuUyfY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-S7QBKZW9MeC1RENIrcyCsQ-1; Wed, 27 Apr 2022 12:19:12 -0400
X-MC-Unique: S7QBKZW9MeC1RENIrcyCsQ-1
Received: by mail-ej1-f69.google.com with SMTP id sb36-20020a1709076da400b006f3d4b12d3aso328982ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vJ4wAPj8Ho9F1Ue1RXAlHhGRCBLfJzK2cfRA2KGgk4Q=;
        b=4aYg6pmQp5Wpm0zLkyTOD7Fim2VLRjYC3z7SNEdSn31bohVBTxIYG0I8ckihehx9Bk
         ZQ5y3V01TVodcL+egpqZ7UnAeeREdraqK6FlPRNm24VMgWPpxoCoyOfTeHkMcVnR3MN/
         Gz93uZuMrGvxV0N9X+0AsImS6dYdDb94HCeOdQ3qG9murB33hUjiDXr2+N9v+nObb3NN
         5vx0IQFC2zcF52/LFYduvAmlbqm3UJ54RWVz8mTAq9xKPJnMWcVJybqBeEdcceRW4a/+
         YINMf2i1J3rJmItgcDYx16tQmKzR+6EmStjL9bSDLV129yOJJiTBpjZbzkIoEgMUNZrO
         c3qg==
X-Gm-Message-State: AOAM530RceXbcQX9htH4VHRIlmRG5yPaciQKzFnZzkw1/KDkGwzuACei
        rJ01leUJASvPlFldD7VO8OkuiinlIuoNBGGqKXsnj3baP7LO+9IXlAe1+3UWipx6WnDjClcD46d
        S53o15ahavQahAChKUFnS+DWk
X-Received: by 2002:a05:6402:1d51:b0:41f:cf6c:35a5 with SMTP id dz17-20020a0564021d5100b0041fcf6c35a5mr31370550edb.25.1651076351005;
        Wed, 27 Apr 2022 09:19:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHUHDxQ9+2qIBaoLcdz/3ksJr5tgaS0nsKWd3kKPdVGWUJLj9DAEqv/3NFmIQNKEAv6vnpkA==
X-Received: by 2002:a05:6402:1d51:b0:41f:cf6c:35a5 with SMTP id dz17-20020a0564021d5100b0041fcf6c35a5mr31370529edb.25.1651076350810;
        Wed, 27 Apr 2022 09:19:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id 17-20020a508751000000b004260124ab84sm2596414edv.90.2022.04.27.09.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:19:09 -0700 (PDT)
Message-ID: <26c10626-b6a2-9be4-6565-c9fbaf1955d3@redhat.com>
Date:   Wed, 27 Apr 2022 18:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH MANUALSEL 5.10 2/4] KVM: x86: Do not change ICR on write
 to APIC_SELF_IPI
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Sean Christopherson <seanjc@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220427155435.19554-1-sashal@kernel.org>
 <20220427155435.19554-2-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220427155435.19554-2-sashal@kernel.org>
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
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> [ Upstream commit d22a81b304a27fca6124174a8e842e826c193466 ]
> 
> Emulating writes to SELF_IPI with a write to ICR has an unwanted side effect:
> the value of ICR in vAPIC page gets changed.  The lists SELF_IPI as write-only,
> with no associated MMIO offset, so any write should have no visible side
> effect in the vAPIC page.
> 
> Reported-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/lapic.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index de11149e28e0..e45ebf0870b6 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2106,10 +2106,9 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>   		break;
>   
>   	case APIC_SELF_IPI:
> -		if (apic_x2apic_mode(apic)) {
> -			kvm_lapic_reg_write(apic, APIC_ICR,
> -					    APIC_DEST_SELF | (val & APIC_VECTOR_MASK));
> -		} else
> +		if (apic_x2apic_mode(apic))
> +			kvm_apic_send_ipi(apic, APIC_DEST_SELF | (val & APIC_VECTOR_MASK), 0);
> +		else
>   			ret = 1;
>   		break;
>   	default:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

