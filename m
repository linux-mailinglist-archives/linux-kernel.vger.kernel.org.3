Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4754D4E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiCJQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbiCJQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:13:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7129636156
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646928777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNeYsGy5GEH7Mbra8ROUB5xsBSJSvMr9PkuEfPzANXY=;
        b=BGeNzsA+ZV/TSj1kaQrmJyLHF2DOc4eCxhvaHc9Qw4PKXP9SSSaeOsNiit6Rquhbjhf5d0
        PKVcQWwXSgp/BWn8cwhXFx2UZ3gSE3uMqVkrXM1k3O5oCE3kn6g4Y8D9roS4Rargrw8+OT
        fjYcNY7me3ND+NKVMUt+MeaoGIfArSE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-g6C_gYelMcmPVNX_UNsLNw-1; Thu, 10 Mar 2022 11:12:55 -0500
X-MC-Unique: g6C_gYelMcmPVNX_UNsLNw-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020a056402344e00b0041593c729adso3373623edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NNeYsGy5GEH7Mbra8ROUB5xsBSJSvMr9PkuEfPzANXY=;
        b=RWmV6ombYfTIvNEZ4ExHg4q+hoa9mvUsNK7raMUUVFINDvJFXislwI12SLgG7H2Iir
         kGcvkTvRipA2SDiqwlM7EGokdR33mYDCkpObtB8YDYujaedFVhfP/xEUNgUkQE/Io1fU
         0at4scp4Qzcon7uTte2mtkvlP7ZAWor+vXGnwPgxlEcZiNGkjP3QaVlI7rDtyUeDtqff
         gTtPU4aHlUPJSplwqSeJC5TMjtUu+0+wcTM9L2EAX00gYnHh/0uyWLjW2DrXGJahT5WV
         WpeixzZzK8oh1uSZ5rfKN8AK2PPOaOYu4nraCbxjfcF0O32d8JL852IF7sA+1kSD7KDB
         2HRA==
X-Gm-Message-State: AOAM532/40UOyK4PjPxZlrCPPtsOjomRACDWd3xoj5V8nfD7kjmNE5o6
        fo0yoUacCLPuqIYJqYBVzWvakrYCcwXVSKWJM8Op6yh7NdGRW/DVDwgbh7AgmzDjHJFNKLucyWx
        3dz5d4PeMkVQjdRnQbKJROJi1
X-Received: by 2002:a17:906:2991:b0:6cf:6b24:e92f with SMTP id x17-20020a170906299100b006cf6b24e92fmr4854751eje.748.1646928774016;
        Thu, 10 Mar 2022 08:12:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEBvACUyWY3XMB+zE7GVAa/esjBxPyDo1dWf95GVSSD81s8zhmS4RJG3YwDEPH6w7bYVgt3g==
X-Received: by 2002:a17:906:2991:b0:6cf:6b24:e92f with SMTP id x17-20020a170906299100b006cf6b24e92fmr4854735eje.748.1646928773787;
        Thu, 10 Mar 2022 08:12:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm1949560ejb.194.2022.03.10.08.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:12:53 -0800 (PST)
Message-ID: <d93d7fe7-ab60-9202-9b35-e8c8371ddefd@redhat.com>
Date:   Thu, 10 Mar 2022 17:12:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] x86/platform/uv: Remove Obsolete Scratch5 NMI handler
Content-Language: en-US
To:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220308010537.70150-1-mike.travis@hpe.com>
 <20220308010537.70150-2-mike.travis@hpe.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220308010537.70150-2-mike.travis@hpe.com>
Content-Type: text/plain; charset=UTF-8
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

Hi,

I just noticed this series only touches files under arch/x86,
so reviewing + merging this really is up to the x86 maintainers,
but I was already looking at it anyways so here is a review
from me too.

On 3/8/22 02:05, Mike Travis wrote:
> Removes obsolete scratch5 NMI handler only used in UV1 and early UV2
> systems.
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  arch/x86/include/asm/uv/uv_hub.h | 6 ------
>  arch/x86/platform/uv/uv_nmi.c    | 5 +----
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
> index d3e3197917be..958c18f94146 100644
> --- a/arch/x86/include/asm/uv/uv_hub.h
> +++ b/arch/x86/include/asm/uv/uv_hub.h
> @@ -729,12 +729,6 @@ extern void uv_nmi_setup_hubless(void);
>  #define UVH_TSC_SYNC_VALID	3	/* 0011 */
>  #define UVH_TSC_SYNC_UNKNOWN	0	/* 0000 */
>  
> -/* BMC sets a bit this MMR non-zero before sending an NMI */
> -#define UVH_NMI_MMR		UVH_BIOS_KERNEL_MMR
> -#define UVH_NMI_MMR_CLEAR	UVH_BIOS_KERNEL_MMR_ALIAS
> -#define UVH_NMI_MMR_SHIFT	63
> -#define UVH_NMI_MMR_TYPE	"SCRATCH5"
> -
>  struct uv_hub_nmi_s {
>  	raw_spinlock_t	nmi_lock;
>  	atomic_t	in_nmi;		/* flag this node in UV NMI IRQ */
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> index 1e9ff28bc2e0..926a4e006e5a 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -280,10 +280,7 @@ static void uv_nmi_setup_mmrs(void)
>  		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
>  		pr_info("UV: SMI NMI support: %s\n", uvh_nmi_mmrx_type);
>  	} else {
> -		nmi_mmr = UVH_NMI_MMR;
> -		nmi_mmr_clear = UVH_NMI_MMR_CLEAR;
> -		nmi_mmr_pending = 1UL << UVH_NMI_MMR_SHIFT;
> -		pr_info("UV: SMI NMI support: %s\n", UVH_NMI_MMR_TYPE);
> +		pr_warn("UV: NMI handler not present or not supported\n");
>  	}
>  }
>  

This seems like a bad idea, just because HPE is no longer actively maintaining
these older UV versions does not mean that they are automatically without
users and we usually don't go around and start dropping support for hw
which is still in active use.

So NACK from me on this one.

Regards,

Hans

