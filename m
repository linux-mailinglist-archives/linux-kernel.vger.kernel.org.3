Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3599E4B1319
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244470AbiBJQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:40:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244451AbiBJQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DF631A8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYbtrys6O/G8myu/5FfO900MqezhEujmkQ1qd2Z++7E=;
        b=d4zkNxT3nYex74RG8BGZxFkBeRYyh+CcyhGOjahPxn4o0fjh+85YY0mL8ObClDS0WXUVK8
        axg/t6sisFF++knE7j726cAIJniAAYegKPedSihSK/IWh27LaOGuuDGMQps7BMrpjBL0d3
        HPO0J96rGLe60CPIO8XFB55PXKegMRI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-YRkQval4MQyS8Obg871rRw-1; Thu, 10 Feb 2022 11:40:18 -0500
X-MC-Unique: YRkQval4MQyS8Obg871rRw-1
Received: by mail-ed1-f72.google.com with SMTP id m4-20020a50cc04000000b0040edb9d147cso3661522edi.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kYbtrys6O/G8myu/5FfO900MqezhEujmkQ1qd2Z++7E=;
        b=4xjgnI8o7OYTGlu+gM19pIikIssqHWVfjv4DsM808MVvasjoQLqO7bt96zRkVsBopU
         bzQ3nvg8GdkCTSFo8JF1ox/MYyEds8ceixli+1dywwuxtzcgu3NYWqv8/dF+NBZ06Hlo
         7mjp8mqWSTZe9HwkZFfxyS3nMuArv6eSvDa1D5PKnk3bvVfv7XZNEokScTKvwjejh0OW
         q8iqQnClTiQxDzzwD97BZnlFoaAAf7Y43FPILyCcsZ2VzrSApLaqX7daNfOHkb8+eYli
         J9+4FS/g3DA/mLFfwnk+Heva8Z8Oze/VnnxesOhGa7zj8dD7fqhntK90p2jqGu1jt7PW
         WGlQ==
X-Gm-Message-State: AOAM533dAqCWx0hkd/ZSVLaY/YTsWnkn4gj1krkjNSaKGoM8f6wZ0RmT
        TXv3w6oAXL+bPhM0MuRXRQPpA+dr5gB+76Vzjg91zkWY2w4UFi6petwLVme551sADIW+wMXVIZk
        HacYziHBEgTfDNFyedU7x6SGD
X-Received: by 2002:a05:6402:1e92:: with SMTP id f18mr9091381edf.347.1644511216915;
        Thu, 10 Feb 2022 08:40:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTFOTCswQjhyOzYxQBHk4nDjaeCftIyJxXIZQ0G+0kIFDYPeXBEraXDJjtTI3TpPMCy9j4BQ==
X-Received: by 2002:a05:6402:1e92:: with SMTP id f18mr9091348edf.347.1644511216536;
        Thu, 10 Feb 2022 08:40:16 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id p1sm7135746edy.69.2022.02.10.08.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:40:15 -0800 (PST)
Message-ID: <87b783e6-2bc7-636d-334e-1b09e05724d4@redhat.com>
Date:   Thu, 10 Feb 2022 17:40:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.15 3/8] KVM: nVMX: Also filter
 MSR_IA32_VMX_TRUE_PINBASED_CTLS when eVMCS
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220209185653.48833-1-sashal@kernel.org>
 <20220209185653.48833-3-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220209185653.48833-3-sashal@kernel.org>
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

On 2/9/22 19:56, Sasha Levin wrote:
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
> index ba6f99f584ac3..a7ed30d5647af 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -362,6 +362,7 @@ void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
>   	case MSR_IA32_VMX_PROCBASED_CTLS2:
>   		ctl_high &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
>   		break;
> +	case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
>   	case MSR_IA32_VMX_PINBASED_CTLS:
>   		ctl_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
>   		break;

