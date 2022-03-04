Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC524CD6AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbiCDOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbiCDOoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:44:54 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDC61BD075
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:44:06 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2CAFE3F618
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646405045;
        bh=gSSf/oFGcND5LFz2K7Y2Hc6MnvHoRe40iy4ZtWWVreU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vlfvc+2HV2skxVKXrB5iiu8z0hPXLZwV+DvX3fOsVuNBRVPk1BPS79c1poLK2F5fM
         /Iu6S0MU/U7UkXA82dbNmvIh6FbUbhotNMP6NsdqB5pojX/3vutspDyGgvKXXz38m8
         J1XceyTDx7T24D4rD05KM9b6T4Rc9fPkdiZRK1mX7Fod4N2OAGdapU5PTGiNZ7U5+L
         ZtD0xX4rWfH0YlbJ4UDsLSxvkGE379q65osEZF+R76o438txpAl4dLDB0b1juZZYXq
         /DUfdv2ogtlduKCt1s6P1aLxRs3ckw0tT+B6ni0SY1cPvHjkFK5AY5Lzzn9em9swy8
         QTmjfEvm+4BlQ==
Received: by mail-ej1-f70.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so4509527ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 06:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gSSf/oFGcND5LFz2K7Y2Hc6MnvHoRe40iy4ZtWWVreU=;
        b=A7OGIRHc8LJYvWdvVTp4LkRupYbN00ppyn3WesrC41W5GNatyTgsCryGQhRbypyqN9
         8oU9aV6Zc/Rp4P0lO3o2gwqlQPyA0EHHdO7CEP9FGza4aI0AWMOC0whJK++FM6SNrhPa
         w8AuBMIfTyzN6xRbXLJfTgH5DUA5dACzIJk8u99JE4h+oAXx/yhYITeQCfZFQfkfIPxh
         MHDjmcoZ69oiAHHyI4FdiV6D0oxDQIMFEV/tnhbgeAvVgzenMryO05WxVh7CLxeFtmRs
         DEJ2S6uo//w/zt7oEXu3O5iFl2HbOPsDKmV8qInQoR73qIxjytJ3jkWz+bZJCCevkqi+
         A2gw==
X-Gm-Message-State: AOAM532PHlz2i98rcHLfVkpYKCb2D63wjDMzpUJXP/gUp+E87y/GoSBA
        iQxui+NAB0yrAV8rWfonkwXu+AdlR7Dk3QYi+5jlcYXXvHeBvqtM86nL7UTp2VaNxAAoadR2YoM
        lr14oEIkeb0Io/TWpPkSSpP5MoqZbUfpPFrIyRGx5Eg==
X-Received: by 2002:a17:906:32d0:b0:6ce:e1cf:3f2e with SMTP id k16-20020a17090632d000b006cee1cf3f2emr30484870ejk.214.1646405044639;
        Fri, 04 Mar 2022 06:44:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9+otEuho6Pdcwo/wfGl1pcYpW5/3K6MleLdh+2KoSkgGl4V3ktzs2YBifoCwSJYV6fHucfg==
X-Received: by 2002:a17:906:32d0:b0:6ce:e1cf:3f2e with SMTP id k16-20020a17090632d000b006cee1cf3f2emr30484851ejk.214.1646405044405;
        Fri, 04 Mar 2022 06:44:04 -0800 (PST)
Received: from [192.168.0.139] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906490700b006b2512921b2sm1835912ejq.48.2022.03.04.06.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 06:44:03 -0800 (PST)
Message-ID: <e97cf184-4e38-c540-da5a-28c762d8d21a@canonical.com>
Date:   Fri, 4 Mar 2022 15:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/5] dt-bindings: rtc: at91: Use macros for the IRQ
 type
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220304142746.121947-1-sergiu.moga@microchip.com>
 <20220304142746.121947-5-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220304142746.121947-5-sergiu.moga@microchip.com>
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

On 04/03/2022 15:27, Sergiu Moga wrote:
> Prefer using macros for the IRQ type of the example node's
> interrupt property.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> index af25cc275356..d2452067bfe4 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> @@ -54,10 +54,12 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
>      rtc@fffffd20 {
>          compatible = "atmel,at91sam9260-rtt";
>          reg = <0xfffffd20 0x10>;
> -        interrupts = <1 4 7>;
> +        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;

Ah, I see the change now. This should be squashed with previous patch.
There is no point to add imperfect DTS code which is being changed a
commit later. Example is not bindings.

Best regards,
Krzysztof
