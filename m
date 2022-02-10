Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8154B133A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiBJQlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:41:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244570AbiBJQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36E991A8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0l/m87uQUmT5CdzB+3f+eMwCEX3CAuEYEJDghPjLWUg=;
        b=eF8paujx6WLC/UXm2UsrQt/QJk02UIBm3lE2r6ABy3c3zVNlXzHWTe5ZDFOQktUwXErOHT
        E06tDDy2XIrY9wQNEp0eKIezwTg6BKU+xdjDBZO7CfzI0VaWCTMr0qUBc5o63ul+j18+yt
        lnbudSbuTVhVbPSz7VnZEWmidz6/4Pg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-zn2PGcbFMrWwV6cEoudXsA-1; Thu, 10 Feb 2022 11:41:00 -0500
X-MC-Unique: zn2PGcbFMrWwV6cEoudXsA-1
Received: by mail-ed1-f69.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso3627508edk.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0l/m87uQUmT5CdzB+3f+eMwCEX3CAuEYEJDghPjLWUg=;
        b=m55D3BVOvYb5/b6Bx0WOpAo2cqKkpIGXpNpRlKWDQ3kHkgmrXLI9Ist6kt0Pt4xAVW
         Qa1Ts49SYiRX55KdoUIgfma2ULZ9vMN4v8uZPI/dRNAZPYJFliO2/71p4Agme20TjU8j
         c6f+R5ht2jjMh+ZcyBXdTzpYOLpitM7+vqPJ4XvPrmlZZ7I5IP5YToIncHToOaAlV635
         aQQg+JrGK2Pz6c1PJGy0tqOvjudwfTX/ne7LKzfuHmvXFiCjGBwpZV5nqxxRXAjyD87J
         xCjvhLUsCGAMs8WzwqRy/aVOERKeh/RgmSlOGH25ftQ2XSdW7TySOytwklauhQBGrlQj
         QAag==
X-Gm-Message-State: AOAM53015lUSfx4grOxYFPrwV9hdzElW/KCkuTPU0+FeOf4ONayTYOCA
        GFMxQC4MWGceYyBPdSHhf0QLT63aJ9pxMrsPPsizX3Jqem+EnHWnTbuzBUFwjsPrv1P4I7TdLUt
        L5zTLvuCkPqE4sFt2KZ5k9h6C
X-Received: by 2002:a05:6402:4490:: with SMTP id er16mr9338799edb.453.1644511262947;
        Thu, 10 Feb 2022 08:41:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZECJ9IV0hUhjUbenMOOxBbaVN6c3Lw279B4RgPUaIqhBLIYpmJT4dWjQTktndy3A8BvGpTw==
X-Received: by 2002:a05:6402:4490:: with SMTP id er16mr9338778edb.453.1644511262720;
        Thu, 10 Feb 2022 08:41:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id f28sm2372477ejl.46.2022.02.10.08.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:41:02 -0800 (PST)
Message-ID: <14850b2d-f55f-712a-41fe-b6ee4a291de0@redhat.com>
Date:   Thu, 10 Feb 2022 17:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.10 3/6] KVM: nVMX: Also filter
 MSR_IA32_VMX_TRUE_PINBASED_CTLS when eVMCS
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220209185714.48936-1-sashal@kernel.org>
 <20220209185714.48936-3-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220209185714.48936-3-sashal@kernel.org>
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

On 2/9/22 19:57, Sasha Levin wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> [ Upstream commit f80ae0ef089a09e8c18da43a382c3caac9a424a7 ]

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Similar to MSR_IA32_VMX_EXIT_CTLS/MSR_IA32_VMX_TRUE_EXIT_CTLS,
> MSR_IA32_VMX_ENTRY_CTLS/MSR_IA32_VMX_TRUE_ENTRY_CTLS pair,
> MSR_IA32_VMX_TRUE_PINBASED_CTLS needs to be filtered the same way
> MSR_IA32_VMX_PINBASED_CTLS is currently filtered as guests may solely rely
> on 'true' MSR data.
> 
> Note, none of the currently existing Windows/Hyper-V versions are known
> to stumble upon the unfiltered MSR_IA32_VMX_TRUE_PINBASED_CTLS, the change
> is aimed at making the filtering future proof.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Message-Id: <20220112170134.1904308-2-vkuznets@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/vmx/evmcs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> index c0d6fee9225fe..5b68034ec5f9c 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -361,6 +361,7 @@ void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
>   	case MSR_IA32_VMX_PROCBASED_CTLS2:
>   		ctl_high &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
>   		break;
> +	case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
>   	case MSR_IA32_VMX_PINBASED_CTLS:
>   		ctl_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
>   		break;

