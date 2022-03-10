Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA04D4F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiCJQZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbiCJQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 909C7194ABF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646929342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fp0mk3rYAtIXdsAQnr/qEO23/c/Up/5gPdqVWQP3YIs=;
        b=dbH/m4z0ZUbvT4tz6NXr5G1XQJ4PP0gSr4NncO4Zb4K91A/Ilfytb2LErsq+iYdoAZDMwc
        bXZQFyYcQKEmHx8RV7pV1ygHEcyq2GSpU4RaJVZtvNWjnasmbKzIlRRLwxZ7MP7Vy6u5Ye
        jZ9eoZQJlSHUWlCVxS43oTssTa1zQ1Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-hnoHNS7IMBmfmvL1lUrxAg-1; Thu, 10 Mar 2022 11:22:20 -0500
X-MC-Unique: hnoHNS7IMBmfmvL1lUrxAg-1
Received: by mail-ej1-f69.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so3390281ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fp0mk3rYAtIXdsAQnr/qEO23/c/Up/5gPdqVWQP3YIs=;
        b=ZWcGAw2+jjmZeG3geQPl8QinSA4Q6NhDndUIVf0DxoRACtqakzOdlQ1xnrhsDkhlYY
         Cc77vsOpZtbbaM80MwnWIYvGL19xrTpF09+52wKqOfYcaFe2fWuRYLIIqLIFqMaWAJtW
         Ja3oh9FxdS2NuHS5RWrZgtADiPvnqoX2C8DOaakHE9xdywUYS5xPv6xBB7oQAMi6SNKH
         PhDgZ4FSiZ5KgyOXQbcRlfsxptgWo0OGm0zL58Z1s+cQ5CZNzBAqggq0Fri0b/tOA7be
         RMfPzRE6DwyQlpaZN2q9S23QiJeV2BiQGetgdP2GBOs/aTrpJ5+IBIK3VWT3exP8Cujs
         2QKg==
X-Gm-Message-State: AOAM532ZwJ/Q9Ls/UTIs5phmb+QT8VXxA3oWeKt7LLKusRGIHWkPe4T4
        zplhXOVezuvDBXWZhfGhI/kmY+Mc8V70wwAOy01VWpLH+86C+cCD20SnuFP3eKuTlykNJ1r39vL
        7ny7iUER9A+6ASGy7AjasVVjs
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id f11-20020a0564021e8b00b003da58e69a09mr5016931edf.155.1646929339279;
        Thu, 10 Mar 2022 08:22:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0ZiP25dlQ+7gpi13teOQ4wgTPllfSkhgRlANTM9345OmzXJMBfHsTldr+3G/ZIm29MXjEyw==
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id f11-20020a0564021e8b00b003da58e69a09mr5016911edf.155.1646929339017;
        Thu, 10 Mar 2022 08:22:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090631c700b006b293ddbca1sm1935258ejf.35.2022.03.10.08.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:22:18 -0800 (PST)
Message-ID: <61705187-a0a5-f76c-a006-93494def255d@redhat.com>
Date:   Thu, 10 Mar 2022 17:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/4] x86/platform/uv: Update NMI Handler for UV5
Content-Language: en-US
To:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220308010537.70150-1-mike.travis@hpe.com>
 <20220308010537.70150-3-mike.travis@hpe.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220308010537.70150-3-mike.travis@hpe.com>
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

On 3/8/22 02:05, Mike Travis wrote:
> Update NMI handler to interface with UV5 hardware. This involves
> changing the EVENT_OCCURRED MMR used by the hardware and removes
> the check for the newer NMI function supported by UV BIOS.
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  arch/x86/platform/uv/uv_nmi.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> index 926a4e006e5a..38f4beae9fab 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -245,7 +245,7 @@ static inline bool uv_nmi_action_is(const char *action)
>  static void uv_nmi_setup_mmrs(void)
>  {
>  	/* First determine arch specific MMRs to handshake with BIOS */
> -	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {
> +	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {	/* UV2,3,4 setup */
>  		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
>  		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
>  		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
> @@ -255,26 +255,26 @@ static void uv_nmi_setup_mmrs(void)
>  		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
>  		uvh_nmi_mmrx_req_shift = 62;
>  
> -	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) {
> +	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) { /* UV5 setup */
>  		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
>  		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
>  		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
>  		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
>  
> -		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
> -		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
> -		uvh_nmi_mmrx_req_shift = 62;

The dropping of setting uvh_nmi_mmrx_req and uvh_nmi_mmrx_req_shift here
looks weird, this seems like it might break things.

A closer look shows that that is not the case because these 2 *global*
variables are only used inside this 1 function and the added if for
uvh_nmi_mmrx_req being set causes them to now no longer be used in
this code path.

And before this change these 2 global variables where always set to:
UVH_BIOS_KERNEL_MMR_ALIAS_2 resp 62. This is even mentioned in
a comment where they are declared.

IMHO this really should be replaced with a preparation patch
which just adds a #define for the 62 and uses UVH_BIOS_KERNEL_MMR_ALIAS_2
directly, which it seems they really should have been from the start...

> +		uvh_nmi_mmrx_supported = 1;

So now your abusing a value used to store a register address/offset
as bool as well, using a special value for it being a bool rather
then a register offset and just hoping that the offset never is 1.

This is not the way to write maintainable code if you need both
a variable to store a register address (*) and a bool, please
use 2 separate variables for this.

*) Note you don't seem to need a variable for the register
address, this seems to be another case where you should just be
better of directly using the UVH_EXTIO_INT0_BROADCAST #define,
you could even change things to a #define in the same preparation
patch.



> +		uvh_nmi_mmrx_req = 0;>  
>  	} else {
> -		pr_err("UV:%s:cannot find EVENT_OCCURRED*_EXTIO_INT0\n",
> -			__func__);
> +		pr_err("UV:%s:NMI support not available on this system\n", __func__);
>  		return;
>  	}
>  
> -	/* Then find out if new NMI is supported */
> -	if (likely(uv_read_local_mmr(uvh_nmi_mmrx_supported))) {
> -		uv_write_local_mmr(uvh_nmi_mmrx_req,
> -					1UL << uvh_nmi_mmrx_req_shift);
> +	/* Then find out if new NMI is supported (assumed on UV5) */
> +	if (likely(uvh_nmi_mmrx_supported == 1) ||
> +	   (uv_read_local_mmr(uvh_nmi_mmrx_supported) & 1UL << uvh_nmi_mmrx_req_shift)) {
> +		if (uvh_nmi_mmrx_req)
> +			uv_write_local_mmr(uvh_nmi_mmrx_req,
> +						1UL << uvh_nmi_mmrx_req_shift);

The whole switch of just assuming "new NMI" support in one case and
of no longer writing the mmr seems like something which should be
much more clearly described in the commit message.

>  		nmi_mmr = uvh_nmi_mmrx;
>  		nmi_mmr_clear = uvh_nmi_mmrx_clear;
>  		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;


Regards,

Hans

