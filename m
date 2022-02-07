Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA064AC462
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384883AbiBGPvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386004AbiBGPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:45:32 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D3C0401CA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:45:28 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B2F2A3F1B4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644248727;
        bh=6Y+2dKF+oax8zT1A/qm081V7yzQIygshkjwkuuK0Jjs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=F5sdoN99jDXmL8UXS/ktdHtnrtFD4aUhV1WFbbu0gTrFu8CIJA7YQkYA+KSlyW7zD
         Eqj103CXyVKCGDjCFEchjVeQR/LNNk9F/Jgj+gNfV5eNq4ZQJJKv6H9EgMieX6p6Ic
         ICKoVWGym6a0+qTZP1dypHALE1eb/0mGQIBN4C/JjsklDDyV4sc4GZfnwoStwZFH7x
         ERBd5zTwqd6mgKcRem2PHgvaXl0plVSx+HNBy05yn6MVqeNdgxto1dYGCvnGxZoEnC
         OYO7k/3IcZLquftntssPG5ahaTrmtld5d4JO1sH3MbF/qt5mPbWhNOaIYxGZk1qVMA
         6MCDN9YvhCcNw==
Received: by mail-ed1-f69.google.com with SMTP id f6-20020a0564021e8600b0040f662b99ffso2106226edf.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 07:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Y+2dKF+oax8zT1A/qm081V7yzQIygshkjwkuuK0Jjs=;
        b=sDVdTjWqbrEmHF8qPmOSSLwKT9nlhBRlPrFpr2ESWmzzOPMEprFps78QK/rJGQXAXW
         Srzb5QcoQcnii7mXIgeS3fyHcGiOVkhjaxPNO43YNbmXMUAKhpIxxxCq7fgwV3uMPhh+
         LSSwEJ05Utt5ZzSuWg6GKTTP0CJXRCMk1gp5ICjn9ACDCOh+JtOHUDxVI9na6YWZ74Lt
         MdpG9dR6NmXv00ZNDKs32anqH0dKxhmzMkS/wP1MIQrZGOWBgV/KaiURR8iQnkrfpVjK
         VGKO7IxYoUx22vQ7Q4OwN9qSwwhSNng/QvCcXOpbWckExR/UOC5evh4LjwXQ1bXuD8fX
         532A==
X-Gm-Message-State: AOAM532MyEstFxfdXZGRK3zsAOIDjcpL42eDrR+J8HtDoMl5UGVbHk2a
        UO0JPTAZuw5JzQGAvePSn+w46GjTsPBs3C6AyFLUgbbiCEIZjcXfMctyG84fh43Dz6M2F5M3f5o
        YCgNQjcrSPmYh4PzLXVTIWEyGLY9x3j7gv0zl9hWW5A==
X-Received: by 2002:a17:907:7241:: with SMTP id ds1mr253304ejc.491.1644248727437;
        Mon, 07 Feb 2022 07:45:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWwLB3X8srR0F9tgq40qKr7ABY3oB3F7i+C8YvII4SCUp1VGjoXcEv3mNNgvu3qM4y28Q/Ww==
X-Received: by 2002:a17:907:7241:: with SMTP id ds1mr253275ejc.491.1644248727021;
        Mon, 07 Feb 2022 07:45:27 -0800 (PST)
Received: from [192.168.0.90] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h7sm1280103ejb.40.2022.02.07.07.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 07:45:26 -0800 (PST)
Message-ID: <a49f77c8-3d92-8c84-28fe-0e6735f09610@canonical.com>
Date:   Mon, 7 Feb 2022 16:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH next] dt-bindings:spi: Fix test error for sp7021.
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
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

On 07/02/2022 02:46, Li-hao Kuo wrote:
> Remove the include path and modify parameters for fix error for bt binding test

1. No trailing dots in commit title. Space after each ":".
2. s/bt/dt/
3. Wrap the commit msg:
https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L124

4. What is exactly the error you are fixing?

> 
> Fixes: a708078eeb99  ("spi: Add Sunplus SP7021 schema")

5. Only one space after SHA.

6. Wasn't it reported to you? Looks like it was, so you need to add
"Reported-by" tag:
https://lore.kernel.org/all/CAL_JsqKwg_bzJmehTG8tR2cpr+HwwvpF_cpoESidZouc_SpKcQ@mail.gmail.com/

> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> index 38589fd..298eac2 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> @@ -59,8 +59,6 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/sp-sp7021.h>
> -    #include <dt-bindings/reset/sp-sp7021.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>      spi@9C002D80 {
>          compatible = "sunplus,sp7021-spi";
> @@ -73,8 +71,8 @@ examples:
>          interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
>                       <146 IRQ_TYPE_LEVEL_HIGH>,
>                       <145 IRQ_TYPE_LEVEL_HIGH>;
> -        clocks = <&clkc SPI_COMBO_0>;
> -        resets = <&rstc RST_SPI_COMBO_0>;
> +        clocks = <&clkc 0x32>;
> +        resets = <&rstc 0x22>;
>          pinctrl-names = "default";
>          pinctrl-0 = <&pins_spi0>;
>      };


Best regards,
Krzysztof
