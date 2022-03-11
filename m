Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA014D5E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347352AbiCKJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347301AbiCKJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:19:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8B71BBF7F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:18:32 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6B8613F1AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646990309;
        bh=IxdbcL7k69aeR5PAgcBMvpQeQoS7r//O6hQJcwASqCA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oRJl62yIxnAqlW3Pfe8iUM7YjHKH0G+Tg9V5Iu6HsXFxrHeGfjx0JLXs+X5iQQ2m0
         WBhEQGJjb2ITi3Uu4CTvc1Jfm7/uQuL/k14fa9vvhsEgk4xeDKyjV04qRDNG/bz4Qu
         uuqEQKt5WaV5Is2FMx+4lsnE6NfW8aAM7DzpBS/bETco8EB92QTxIvT6V2D1WtXdTA
         lj02D8jCHrXMraW1VZDxQiLDneknQ/coQXR0pPKpg0AyYGzHpFHSDDF5aHW4xzaBOs
         G5olOHKLdarZjAUDiaHcVdRvQ7s4bfxRWfHwBjrGjK7TRBkHlyaL04ZniOi8x8879i
         jtOk3K3Fgut6A==
Received: by mail-ej1-f72.google.com with SMTP id og24-20020a1709071dd800b006dab87bec4fso4643998ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IxdbcL7k69aeR5PAgcBMvpQeQoS7r//O6hQJcwASqCA=;
        b=xNolzEZxK2XnBgeRvjvE253I6CXhmE3ur9g3AdJ6eBtwH8k5ixZM5bFWl0XzaW6dr1
         LdbHvEengxZ4qZTgmrSS6cojLb+tGCZLwrN+POjisewy0awHc0oN+aOu3OL7uAdmC+h1
         iYvNzGCeg484+SsJ2/PK3bwBGnSfp1XDJFAR5eMDW4nsF+f3zGaDwgcvmufB76AlSmsQ
         RBnB8XJ4f3GxMXgea9pGaxdjyE1762DYsR5SxcfDS4p8TLW8R5brlDg65kLjmW7zZmqQ
         4urh3CU5jrFZavkwuG4rTtNvEooMETWOucoNXvMA8nXRxMZbeUvKmFILcmmNzeRVGjx9
         8+ig==
X-Gm-Message-State: AOAM531CnGaTi3TBf4Sd1Bv/sflvJ16DiD6+x+IHxFaWqR6+iKv++A97
        66jUt5X74dFUiRI+/0JRc2tgfC6j4A0nf3foio2wi94sVoqM0ItcrA7l0k79qcm1OKFgoOTku28
        dsQiKbehWYqs2W9H7EZE/YQMfwK5mO4IH5BHCoK9Olg==
X-Received: by 2002:a05:6402:10d5:b0:408:f881:f0f3 with SMTP id p21-20020a05640210d500b00408f881f0f3mr7969320edu.112.1646990309096;
        Fri, 11 Mar 2022 01:18:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJx30zZcpXpgPnCtN4/x64kV31WgzQQ1W7CmqqYo9CyZbalXQfJsGU39fnHARIBZSBH2iX0Q==
X-Received: by 2002:a05:6402:10d5:b0:408:f881:f0f3 with SMTP id p21-20020a05640210d500b00408f881f0f3mr7969298edu.112.1646990308915;
        Fri, 11 Mar 2022 01:18:28 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906078900b006dac5f336f8sm2712366ejc.124.2022.03.11.01.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:18:28 -0800 (PST)
Message-ID: <3f77c8c8-4bba-007b-fae9-5fb47f44719c@canonical.com>
Date:   Fri, 11 Mar 2022 10:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/3] dts: add Nuvoton sgpio feature
Content-Language: en-US
To:     jimliu2 <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        KWLIU@nuvoton.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, CTCCHIEN@nuvoton.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20220311060936.10663-1-JJLIU0@nuvoton.com>
 <20220311060936.10663-2-JJLIU0@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311060936.10663-2-JJLIU0@nuvoton.com>
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

On 11/03/2022 07:09, jimliu2 wrote:
> add Nuvoton sgpio feature
> 
> Signed-off-by: jimliu2 <JJLIU0@nuvoton.com>
> ---
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> index 3696980a3da1..58f4b463c745 100644
> --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> @@ -329,6 +329,36 @@
>  				status = "disabled";
>  			};
>  
> +			sgpio1: sgpio@101000 {

Generic node name.

> +				clocks = <&clk NPCM7XX_CLK_APB3>;
> +				compatible = "nuvoton,npcm750-sgpio";
> +				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&iox1_pins>;
> +				bus-frequency = <16000000>;
> +				nin_gpios = <64>;
> +				nout_gpios = <64>;
> +				reg = <0x101000 0x200>;

In each node first goes compatible, then reg.

Best regards,
Krzysztof
