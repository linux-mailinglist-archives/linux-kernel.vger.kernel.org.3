Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1D4CE75A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 23:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiCEWHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 17:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCEWG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 17:06:59 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D75FF07
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 14:06:08 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6BBDF3F5FC
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646517967;
        bh=r8hK9O7GWDOrBuci3LT6A/3z57WQVywUK2jujxtgGEU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pXV2k9WycoiEsbBXj6aeiHbPfB09M7jhvPBmdzCKqFGFsBGpCYjpUbVsC0Anc/D0o
         J4pc7iRs0itOMmCAuhE6BpB4pdG8twCP5c6PczCqNo9qZaMGHq2+4JDuHxVmn//BZI
         KQI6HgVadLnz4dfTsVXeZgI3gVCscxP5qtfTA1bAtjKVP9pYiKsHW4pkibeRVW0fP5
         2xffyhC9RJY7zbpjuBVMmfUHIKgTAsfNCnoz1jEZ2d0x0WwFmLsPhZKoEaFy5R0I0x
         nqjFtms9kfguK8H+7tjYoK81fStSFQHfFuAzsQ2j3ofdwdpxQQDYIsNWjcVrky7c1c
         TF5UFIUw7tX0g==
Received: by mail-ed1-f72.google.com with SMTP id l8-20020a056402028800b0041636072ef0so25549edv.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 14:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r8hK9O7GWDOrBuci3LT6A/3z57WQVywUK2jujxtgGEU=;
        b=7uT5prg0InI4zivUVZGfxNLyAZuWmPOZvldyc0LXYShho+Xlt2ifeC4YCNGm3p4ln1
         BhYM6QTilD5IOjAUfqcWgjkh62irkqG3oRlY/9pDeyrclOrfJuc9ye6tBBZWl2TIigs+
         Bg/rz6X09mhuqB64ju2mhDV51M/UTe+GNSRsf7Y0gfPUlJW/pMR4D09TEYCQJcylkAKH
         LV0+BGJ20Yo7QZnc/6mrceWirNPzlEbBDFj9KQBZfgO7b5CkBtxOjnQq7wb43ZGe3+RL
         x/4CwTRqySgNhc+6yrEZModBinxNG/iw9w8H64nNStyBexbs0Xe7hEpYtwWTCh2OlmGQ
         jC+g==
X-Gm-Message-State: AOAM532bz47IDOQnwOqrfyOR4dkVRCGheOS6bi0hNzohXqu3zsVbUS7G
        iFwaoIHAPOwHSeR6zRxh5HcJOJiZN9wD9mRQRQVZzk2DUNLXBt1GULm86v/1NUyhFKYICFdfqLU
        4Bt1wMWkbvAQddE4GpuCIlMsbugO05MpCIgV5kC7J9g==
X-Received: by 2002:a17:906:c116:b0:6d6:f8b3:cd47 with SMTP id do22-20020a170906c11600b006d6f8b3cd47mr4092233ejc.501.1646517967070;
        Sat, 05 Mar 2022 14:06:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjslF+FUEkcRwcoMmxVUwk3J5/UIuEwE01ZQJAdNyMizt1aMsZPYM/4p28F52HYriTaxmKsw==
X-Received: by 2002:a17:906:c116:b0:6d6:f8b3:cd47 with SMTP id do22-20020a170906c11600b006d6f8b3cd47mr4092223ejc.501.1646517966857;
        Sat, 05 Mar 2022 14:06:06 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906395600b006cec40b9cf0sm3248038eje.92.2022.03.05.14.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 14:06:06 -0800 (PST)
Message-ID: <14fea5bb-cf9a-b2db-10d1-0015b97ae61b@canonical.com>
Date:   Sat, 5 Mar 2022 23:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/6] ARM: dts: at91: sama7g5: add nodes for PDMC
Content-Language: en-US
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     lars@metafoo.de, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, nicolas.ferre@microchip.com
References: <20220304181756.1894561-1-codrin.ciubotariu@microchip.com>
 <20220304181756.1894561-5-codrin.ciubotariu@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220304181756.1894561-5-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 19:17, Codrin Ciubotariu wrote:
> Microchip's SAMA7G5 embeds two PDMCs. The PDMCs can be used to connect 2x4
> PDM microphones.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  arch/arm/boot/dts/sama7g5.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index eddcfbf4d223..85a22c3a8e57 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -275,6 +275,30 @@ pwm: pwm@e1604000 {
>  			status = "disabled";
>  		};
>  
> +		pdmc0: pdmc@e1608000 {

Similarly to bindings - generic node name.

Best regards,
Krzysztof
