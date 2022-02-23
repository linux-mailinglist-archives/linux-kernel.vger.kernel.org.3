Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D740E4C1150
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbiBWLc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiBWLcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:32:55 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F67235DCD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:32:28 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 668FA3F1D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645615946;
        bh=rHG+vfkPnctmAtn+BXrH4H+8gRXose5yQLu+rWYptLY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pLCREwA7JA2J0U/pXSqs9IwS7vmTJg+yF/sWWN4DUf8ytsM+gwThqYuyh4n+d7jwS
         tvH8gW7RwXZkdpaVfat//gQIHSfzYj0wWxOJk3iIoVhiJa/KdHR349oQH3Az6GNoGJ
         79qCYQRHootfn0kiLsBSVcN7wVM7Yxg4AjZY712/CComDX1eBZshpbdFpKHgYjmGU9
         8xd44toB4ywLWiyBTsNF/2aXDCk6Lg/rsdAhcEwNDELOy8hvxpGYZLIAwSZ1jyYenk
         LEaq8/arXmPml4aPA2YoFAuz/sloYgCar0iJ5KmhcU2FFOCLKjgM1YNwYIC+xWAnAs
         lyKZiNOvWc/Pg==
Received: by mail-ed1-f70.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so13483535edz.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rHG+vfkPnctmAtn+BXrH4H+8gRXose5yQLu+rWYptLY=;
        b=P1tk6dIb1vsbAEKdGkzOV449m/2zLO5+UoMacTYB9DMPExvDDLLRFlqo0lqjxNhLs/
         HwViN85keuUwmhOtbTOkXlcQK2nFpkYyLWQj5RoZ8o+UFOfEuq7FDN3USI74T7wEUDn3
         5+hR+8ej/zYcJpmx57RQEcdGK8xuT6D9LXwBCMWA9U7zPohczfFXeiRGUYWpaE7U8cYx
         eXZHnG0lUH3qyLuP9dCstgK4d9S/OZbt1RgbGWhT0QN1om3zhS7b1NY1BGE/0D1i+Aln
         Y7C3EEc6Jgbyu6FBonQbDiOq4uiw0GoJi2Mc44sy75XHc5EARsX9IkaqhTzv/x2lvgMD
         2+7A==
X-Gm-Message-State: AOAM531yC864Ge1A+OcSpAt2Nn+NwGa7c0yMBTCxcUMelIOKpKxQRZgU
        J2m89Fx/EHTtTwRQSTmtX2VH9Kss5rPiHoawJvEKI6VMc5XdfMHVxFHUs0AOQ5OkikQdkgVkv+D
        AT11YxXX5h0rn+NM97Af5b3mNA4cHO7r3DjmjgJ3fjg==
X-Received: by 2002:a05:6402:5c9:b0:412:e7f8:81c3 with SMTP id n9-20020a05640205c900b00412e7f881c3mr19997672edx.386.1645615946003;
        Wed, 23 Feb 2022 03:32:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6S4sBvt3FBVGg7wH41ZDGhEOI/3APJRfTKFOVERInVX5l+0UyB25l+UO6lGLm6PNkjP0Ciw==
X-Received: by 2002:a05:6402:5c9:b0:412:e7f8:81c3 with SMTP id n9-20020a05640205c900b00412e7f881c3mr19997661edx.386.1645615945843;
        Wed, 23 Feb 2022 03:32:25 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id jz17sm7364998ejb.195.2022.02.23.03.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:32:24 -0800 (PST)
Message-ID: <96f7a28b-81b9-a05f-e8f5-a4fb377476fc@canonical.com>
Date:   Wed, 23 Feb 2022 12:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linux-kernel@vger.kernel.org, heiko.thiery@gmail.com
References: <20220222151357.1710503-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220222151357.1710503-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 16:13, Michael Walle wrote:
> Add a new compatible string for that eval board. It features an IMX8MN
> UltraLite and has DDR3L RAM. The product part number is 8MNANOD3L-EVK.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 23e678232451..e11ffaa8721e 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -834,6 +834,7 @@ properties:
>                - bsh,imx8mn-bsh-smm-s2     # i.MX8MN BSH SystemMaster S2
>                - bsh,imx8mn-bsh-smm-s2pro  # i.MX8MN BSH SystemMaster S2 PRO
>                - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
> +              - fsl,imx8mn-ddr3l-evk      # i.MX8MN DDR3L EVK Board

Looks good, just please put it in alphabetical order, so before ddr4,

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
