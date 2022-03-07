Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1714CF427
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiCGI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiCGI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:59:22 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1992180D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:58:28 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6AB303F614
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646643506;
        bh=tXVanxy7+7Oc5O3WLbsohtPsqU2ukLOIpjIWEofC+MQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bBOrvOLfG9019V6oJZkPLllCzqkQGBuAMuWwJ/Qedsgo3I9uMF0fu+gd8ziA/TzVX
         axzMSkG/3KMQZhxS1Y8Tja+3PuzPXUWlaG7Ro31TdiYUPANc17HLhGpxzRyPUwz+rG
         ZImxCMX3e7933YX6z5KT86rMwg7x4jRTob00E6cUa0ZuemUXh7DSzm8aJHVw0XAYs9
         8Y0e1MnOruqZ6ABghLRh8b4pPIuVu2YpnmGcMJYIABXnMVrAc6pBo79LzxDc+Ibi+I
         4CiTs0Ca+NgLNeYLo0r93FOiF4OeRHuA/rJELTzw1a5jMCmL9YvrUY/UXG1/DEiZqv
         WzxUQtkU9Ew4w==
Received: by mail-ed1-f72.google.com with SMTP id l24-20020a056402231800b00410f19a3103so8227119eda.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tXVanxy7+7Oc5O3WLbsohtPsqU2ukLOIpjIWEofC+MQ=;
        b=Yh+fWgRVRnPN48HmgfAyD7X8ipq3VkryxJaVEuYscGFYFgfy+2mlqtBb7b17RMkygR
         HMH9nBCQTkQKDGpc5w20EVrqXuPb71XfLPdgcdWT5O/nJulPgkf4Sz/L9KTBFTtEhSrb
         90Fylh7ai78b1pFpRDYwPA+WlB+Ox9vd7uKOhuuYqrA/5AwX5bm++6y3U1a7UQZKc6Gr
         y9EcgrnbrdeszLx6KpCTI6OD15ZMgciZYsZukooWJcjoYDTOFNbfKhVon8CPrwqPo7qZ
         A4mnCRbEjPv3Yuk+zZnURFbrAB9zMBEFSUOqs5IlCW/JnjEyE3ieDx1+7t9hNwWwwsXw
         NakA==
X-Gm-Message-State: AOAM530ZGYwj3dIZoJW3yTu+fZYWcjBpKeaAF65Q+XhMM5zK6bh412jR
        ungqEX6JNfUA9+W0/YZMtZamWuS0S7jQ+U+f2INuAF6aFWLMs9o62wCfDEM0dFB5JTsRmC+xgqV
        /4Ah5dwasaKbO85zKcv48OyodFvVqmY9ia45q4br3nA==
X-Received: by 2002:a05:6402:27cb:b0:412:124:e0db with SMTP id c11-20020a05640227cb00b004120124e0dbmr10188611ede.72.1646643505348;
        Mon, 07 Mar 2022 00:58:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3ZMJrDKrVAyAS7Dzh3dQbNGgwVfhPijtSj0p1tH4keGdzqgbfHCWsGgoYJFegl75f4/Ns8g==
X-Received: by 2002:a05:6402:27cb:b0:412:124:e0db with SMTP id c11-20020a05640227cb00b004120124e0dbmr10188597ede.72.1646643505198;
        Mon, 07 Mar 2022 00:58:25 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fs6-20020a170907600600b006da8ec6e4a6sm4485847ejc.26.2022.03.07.00.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:58:24 -0800 (PST)
Message-ID: <3b4b5fd3-6642-baf4-2c21-930b70ab0d63@canonical.com>
Date:   Mon, 7 Mar 2022 09:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: serial: samsung: Add ARTPEC-8 UART
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        alim.akhtar@samsung.com
References: <20220307085053.1636475-1-vincent.whitchurch@axis.com>
 <20220307085053.1636475-2-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307085053.1636475-2-vincent.whitchurch@axis.com>
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
> Add a compatible for the UART on the ARTPEC-8 SoC.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 6aceba4a5f79..6f11f2c92f64 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -20,6 +20,7 @@ properties:
>      items:
>        - enum:
>            - apple,s5l-uart
> +          - axis,artpec8-uart
>            - samsung,s3c2410-uart
>            - samsung,s3c2412-uart
>            - samsung,s3c2440-uart

You need to define clocks - see the allOf part.

Best regards,
Krzysztof
