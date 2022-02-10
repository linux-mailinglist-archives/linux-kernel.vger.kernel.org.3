Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9B4B0E12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbiBJNDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:03:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiBJNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:03:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA0C49
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:03:54 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 78C7540058
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644498233;
        bh=5FfJ2NtvqLFsepwzi4IPAGWZFIoEV7aP4U9Za7zH4ds=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=hng/UWWD6fHRIMvwQ/oIyUjz1VTNxO7Bkftyk6V9RaixwKG9p9TlX6XOeg09yOI8B
         bxSCNe7LMVT4o81LdUnaEuRUDjIqrixro6xARTVUZFt7OBmtH126+TOYLDBIdzYyyx
         Kn4+j6+8nEVcaCWRn1wQwx0ZtbJ2HwRIvcxntzjlSe7aM29J8ICil6QJrF8kiJ2GZ8
         dNVMUFkb2FIThBP31AHgNSTlem96toxm1ghneCamucU6oLrlB0z4J48M4wTwKO9lQI
         GwWH/ScwZxQN6rxiBUmqQGiCaxMSbud/X46zjRAxcCPemlqDBs3QEB4bk4Mkfe7Ope
         bHnxKW2GkFiSA==
Received: by mail-ej1-f69.google.com with SMTP id o4-20020a170906768400b006a981625756so2723799ejm.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5FfJ2NtvqLFsepwzi4IPAGWZFIoEV7aP4U9Za7zH4ds=;
        b=DTPP8G/WG5fufDpv8VWzPR9NU16Oqhpyy/6xiL8R+J5xXoGJRfLy8cjPaWFxOYMqa5
         OAp3roh8SF5P3unWs+3sdDok7ftM/IrGxnVB9d7fkRkhFh592Qlew3ksHIui3NzLWwEi
         DC1i+GVknSbe7rkK4KpZ23uhxDhs0WAUsfpj2aIxBPJ+3yaFQOKqpUrdK4mfw/e5WPji
         uG2xDBaumhV4XNacU32GOaZfq/BWGi1aJ4q91hQYEMzWgVZeDJK8V5S6raOVot11G8bW
         JvA0fzYMX4n8uR+1z7hkdsD2BjOM1gbDHciWV9rlf0H/BIY/2BOGIZxa6eVfuwZ6+lVf
         hh8g==
X-Gm-Message-State: AOAM532wiAGVImkr+olXopdawf24ic2eT8HYNS9NQ9/dMEst+W86n0+i
        +2fqaazlM8JQ4s0KUBq0xJmS0T5ahK+2suIUAQqVIadzjn85mUABo+9prRMQRvh8VqTvson2KIa
        Nc+vnx8jLCG4UBDXXcP8C5rRT+miO3GW5WJ4lQp8YQQ==
X-Received: by 2002:a17:907:7f1b:: with SMTP id qf27mr6127678ejc.114.1644498233032;
        Thu, 10 Feb 2022 05:03:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPoHOC7c7l+Xjj9Z8ku0QSW+tnUeMaYcZnl3p668SMScBa+pDLQfVvjpUPGWllIwp7YUoTLQ==
X-Received: by 2002:a17:907:7f1b:: with SMTP id qf27mr6127656ejc.114.1644498232798;
        Thu, 10 Feb 2022 05:03:52 -0800 (PST)
Received: from [192.168.0.98] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n14sm3322025eja.219.2022.02.10.05.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 05:03:52 -0800 (PST)
Message-ID: <e3cebd32-689d-f74e-f53a-b24e1bf71f6f@canonical.com>
Date:   Thu, 10 Feb 2022 14:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: arm: at91: add Kontron's new KSwitches
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20220210125705.481612-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220210125705.481612-1-michael@walle.cc>
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

On 10/02/2022 13:57, Michael Walle wrote:
> The Kontron KSwitch D10 MMT series ethernet switches features a LAN9668
> SoC with either 8 copper ports or 6 copper port and two SFP cages.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../devicetree/bindings/arm/atmel-at91.yaml        | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index c612e1f48dba..e019e79f9551 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -174,6 +174,20 @@ properties:
>            - const: microchip,lan9668
>            - const: microchip,lan966
>  
> +      - description: Kontron KSwitch D10 MMT 8G industrial ethernet switch
> +        items:
> +          - const: kontron,kswitch-d10-mmt-8g
> +          - const: kontron,s1921
> +          - const: microchip,lan9668
> +          - const: microchip,lan966
> +
> +      - description: Kontron KSwitch D10 MMT 6G-2GS industrial ethernet switch
> +        items:
> +          - const: kontron,kswitch-d10-mmt-6g-2gs
> +          - const: kontron,s1921
> +          - const: microchip,lan9668
> +          - const: microchip,lan966
> +

This should be just one entry with an enum.

>        - items:
>            - enum:
>                - atmel,sams70j19


Best regards,
Krzysztof
