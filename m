Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F24CF433
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiCGJFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiCGJFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:05:33 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99F144747
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:04:38 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B4A1B3F60F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646643877;
        bh=bCGKnBRm9v2sKeJoewgF99EVSOj1eSTH2ia4hbNzqfc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=I0h56zhE/VsyJCNOvhSi4Yq4KsPB3ExPWkf91UojSiA5sn4VaiuxS7gFipiu5BPp2
         GNK8DaYnfFoIMicVZTy+8+nZV95DWbogA0KcL1BYr8+8J3kNgENE7GRCwWCJ+uyNlI
         JXCkCYcvXVFM+9UQ5y1OSHXNZHjuyTGrBMmgZY//JPjq4wqcW70b4JXSvepghlLtKS
         E8XIhoL5djU4gpnrYqrK2mfQR7i42kITOUB/p34Q81zNUzlHpc8M42VDEzdQFwPM+W
         t+I+L1iYC9NOuAU8pCRwss9ydcJMXFbBx+WEYs/o4fTWi85BxZPI8QwijMWADyHHjG
         nTrHfFqycsl3w==
Received: by mail-ed1-f70.google.com with SMTP id l14-20020a056402344e00b0041593c729adso8249108edc.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bCGKnBRm9v2sKeJoewgF99EVSOj1eSTH2ia4hbNzqfc=;
        b=sEC0CPGYvyF0AtaRHthH9aB/OMvhomq311lh5HRxqQEsHsxXOiTFerwxYjQtPxqx+Q
         Q9TF4cIqPrHg9NbzsskStVnEzlmvIl0V2Ns2CmYYMJ/nnU1WvZeDGsJtwkox3MWu6+Un
         Kc0Cbp2zic0bT2dcQo+eGcfv+JVztnSZ8vQPAXm2m4RyPtWQwEBFw42YOXJpf1jJzdyH
         UaxoIP6UcjHB8TueMIa4WNaTpvwhFTYk/1wJuqf8VsWnSSj0aur/GOrZZvjRrkY2pnW5
         JsNtce+EAj+EJx4DOKDTi6whKyqJj2kKKlG+ZziBUEIVJnhnZGjV0Rack9fW3B8TfPyD
         DM2Q==
X-Gm-Message-State: AOAM530xrj1Cr1Rn9Mv+5tneTR+AT/K6e+AtwSkGpNKPLQHonmFrUbc9
        231CiU8nsV3dRZUbXMH4/Up4F8AmUFyv1d1TXkFDHy2PjmvWzbl+v4pAhAHF6B2T8vDwtuRct3y
        I/NYjU05sdkgGRilLTS2DQ69JX1dgRkZYBjXyWl3zkw==
X-Received: by 2002:a17:906:3803:b0:6cf:56b9:60a9 with SMTP id v3-20020a170906380300b006cf56b960a9mr7974963ejc.716.1646643877064;
        Mon, 07 Mar 2022 01:04:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznp/n2u6f3ACuFsi3tn3Y52SEoSIz1Qz9ikaklDE2Cdic0VgHikeNWUnubx67cDnGPPuwgvQ==
X-Received: by 2002:a17:906:3803:b0:6cf:56b9:60a9 with SMTP id v3-20020a170906380300b006cf56b960a9mr7974939ejc.716.1646643876806;
        Mon, 07 Mar 2022 01:04:36 -0800 (PST)
Received: from [192.168.0.141] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id et3-20020a170907294300b006d6534ef273sm4435569ejc.156.2022.03.07.01.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 01:04:36 -0800 (PST)
Message-ID: <30db9e75-5176-e8e2-6a2c-1ef4022ba9f7@canonical.com>
Date:   Mon, 7 Mar 2022 10:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] tty: serial: samsung: Add ARTPEC-8 support
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        alim.akhtar@samsung.com
References: <20220307085053.1636475-1-vincent.whitchurch@axis.com>
 <20220307085053.1636475-3-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307085053.1636475-3-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 09:50, Vincent Whitchurch wrote:
> Add support for the UART on the ARTPEC-8 SoC.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/tty/serial/Kconfig       |  2 +-
>  drivers/tty/serial/samsung_tty.c | 38 ++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index e952ec5c7a7c..ae120d3d933a 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -237,7 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
>  
>  config SERIAL_SAMSUNG
>  	tristate "Samsung SoC serial support"
> -	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || COMPILE_TEST
> +	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || ARCH_ARTPEC || COMPILE_TEST
>  	select SERIAL_CORE
>  	help
>  	  Support for the on-chip UARTs on the Samsung
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d002a4e48ed9..4f9e74c6bcef 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2837,6 +2837,36 @@ static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
>  #define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
>  #endif
>  
> +#if defined(CONFIG_ARCH_ARTPEC)
> +static struct s3c24xx_serial_drv_data artpec8_serial_drv_data = {

This will conflict with my constifying patches:
https://lore.kernel.org/all/20220307080810.53847-1-krzysztof.kozlowski@canonical.com/T/#t

The code itself looks good.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
