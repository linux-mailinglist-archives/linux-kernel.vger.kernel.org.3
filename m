Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18C74D5E26
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbiCKJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiCKJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:16:36 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6F01BBF5F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:15:25 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 137393F4BE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646990124;
        bh=3MfF2oKCAD91dLAjcIPW4+1KpuK6qxbRKyhRZsrNxAc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gODACj0hIHnTMdVtoXa0k1jR9D9zOdpLHQ6R8ajzZus/owZCrEuwfcEFNPAnEbinZ
         ROHaTyIvUzksafn13Kr9xKprw3jQF0LDBrFXm7xcsUESwPobEvX0wW1Ph18+srNBg1
         55kwSgbwLmG5ERamdkc7aQS90/wddNCB+DHqfL3FjOUFdOlMQMCTyRSrEoR1lJDk9Q
         PD6IgwLVTaP0KSZHU5kNjrKyINqNvkT+TIwa1Zg5tPApnBFLUUciu+KVAltI7mK5Du
         Y2RXiFoa61ZdZLYSfbJstwYnpm9cSznYb0J4SPrX7L+vOf+JvoFKxj2MirS+8joxCj
         8oRvKLITQXnVQ==
Received: by mail-ed1-f71.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso4550760edh.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3MfF2oKCAD91dLAjcIPW4+1KpuK6qxbRKyhRZsrNxAc=;
        b=h0Jv8bdQ+2xHOY3tfjG10YRtRWvVT31CzXdP7Q7KBKHlvjiCwEeEeq+/2D6YX3TQsl
         bIc6o26YASyJQ3OVrCID57oHj0hmOB9o4B7Qm/HTSy/mBOKVO2ThJEEedlUaTbuirPs4
         QRFOSM+r+JjVICX8rYS2f/PlQdn4ZcLwQqmeZDZwnhrFRPleX7r4OUhbqE523eFbrkNW
         x72QxokvY/qgaCzfSQ07khu+eRo4e5a3RAxuYPEKV6BWrEOLesYbU2TFAmr1BYXXYszC
         aqcFTRTERkhzdgwAh+mCmBLjdt8LDPS4qKR6WltuoZd42OVhLW4HDUdh2+hkp6AixNaa
         Yzwg==
X-Gm-Message-State: AOAM530wKQ72IZC3C2xXtz5kaLw6KfhNTUI8O20VZv8AIYmI6D8Gb/RW
        Ew+JriiWG1Sa6mec+3x6+pbo0CKCA0AdrnsGOlbWPl17CLu6M8Y5+zMcMe9t7PUDVxaXRFBNZNq
        3/T7iMVRgRo6q0IWmedekery/9PfrXflHodR5FHB2YA==
X-Received: by 2002:a17:906:dc94:b0:6db:ad7b:9068 with SMTP id cs20-20020a170906dc9400b006dbad7b9068mr917624ejc.224.1646990123487;
        Fri, 11 Mar 2022 01:15:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyc3valO4s0TDo4cDXykhAMo8H6v3V0M4V74fs99LPFrNHprmdOLmDK1lYHTfG/oPV8ZkvWEw==
X-Received: by 2002:a17:906:dc94:b0:6db:ad7b:9068 with SMTP id cs20-20020a170906dc9400b006dbad7b9068mr917603ejc.224.1646990123277;
        Fri, 11 Mar 2022 01:15:23 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id y18-20020a170906471200b006da8a883b5fsm2684372ejq.54.2022.03.11.01.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:15:22 -0800 (PST)
Message-ID: <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com>
Date:   Fri, 11 Mar 2022 10:15:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, mchehab@kernel.org,
        bp@alien8.de, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
 <20220311014245.4612-4-ctcchien@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311014245.4612-4-ctcchien@nuvoton.com>
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

On 11/03/2022 02:42, Medad CChien wrote:
> Add support for Nuvoton NPCM SoC.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  drivers/edac/Kconfig     |   9 +
>  drivers/edac/Makefile    |   1 +
>  drivers/edac/npcm_edac.c | 714 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 724 insertions(+)
>  create mode 100644 drivers/edac/npcm_edac.c
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 58ab63642e72..757e1d160640 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -539,4 +539,13 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.
>  
> +config EDAC_NPCM
> +	tristate "Nuvoton NPCM DDR Memory Controller"
> +	depends on ARCH_NPCM

|| COMPILE_TEST
(and test if it compiles)

(...)

> +
> +MODULE_DEVICE_TABLE(of, npcm_edac_of_match);
> +
> +static int npcm_edac_mc_probe(struct platform_device *pdev)
> +{
> +	const struct npcm_edac_platform_data *npcm_chip;
> +	struct device *dev = &pdev->dev;
> +	struct edac_mc_layer layers[1];
> +	const struct of_device_id *id;
> +	struct priv_data *priv_data;
> +	struct mem_ctl_info *mci;
> +	struct resource *res;
> +	void __iomem *reg;
> +	int ret = -ENODEV;
> +	int irq;
> +
> +	id = of_match_device(npcm_edac_of_match, &pdev->dev);
> +	if (!id)
> +		return -ENODEV;

Why do you need it? How such case is even possible?

> +
> +	npcm_chip = of_device_get_match_data(&pdev->dev);
> +	if (!npcm_chip)
> +		return -ENODEV;

I wonder, how is it possible to have here NULL?

Best regards,
Krzysztof
