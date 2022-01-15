Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD548F800
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiAOQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:48:20 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35452
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232164AbiAOQsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:48:19 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F00143F17B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642265297;
        bh=wXZQtYz/zmTQVY9iXUZsB5pG1NlM0ICurM4DUB53KaU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=R3B+d06acHiOudmDqy/V0iun3PewKB8fUQDmoxT6hzIHnE0lPQ9djfumYUYpcGGur
         OwsUHMP5OTYIzGBALE5lr3EzUa8uvxUOHtDy42/NCX6i6tDe1OGWTMK0bbVfQ+gUjf
         WKR2ljS//5v3N5EiuI0ksgnpTqq7k/QkdJ4GDdAnQwcdJZ5u1v4EhcBxecYCmvCd1j
         FlXDptRZKEZf0SCgDJ2YfNhEpoq3Ay74Dbr5bva1H0Agz2at/E2JWemx5vyffQdwuJ
         PZwZ8Nrp1TdLWWMYr3u5cF5ubfKUAEJCuM3ygTxmvHyGv6ySqHaCyayL18JjWsPmL9
         kSNo17qan8umA==
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso10719436edw.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wXZQtYz/zmTQVY9iXUZsB5pG1NlM0ICurM4DUB53KaU=;
        b=2FzlvTFjmaJJTVPAisc3YYWc2qjmSzCPuCDbp6WdxYqyBEfQoEYEtMm1cgNJCY87ho
         5CCxCeXkvzupv5dgJPMCO3ymPXx88iTloRnDU2vrvSTslUt09FUxgzT+/gNTHbkcoqQS
         8FN6g3iI/Zp1OO+6fxzpspDjnEct0gvwb7Nrod6I59lk/npzdv0BWTq9d5cSp1BdMqvj
         6eeRBWe++gNXKCgNMZ3snJmqQAjarD4U6uls6yL+6Dy2KWh/Y/lrr8IG1LybnEKfpYZz
         R1hGkICu7mtEgwh57NCemhP6Guzo7CSLpS2GTYKdJxeaNTn5kASTsMacZ2y4Uow4KXK0
         hmOQ==
X-Gm-Message-State: AOAM532XQIJLqndB3JMQKFayS0sSVAgif19o7Wcc8FeUrXH9qFxpDPL1
        vXflMV2CPTwrhBeFW9ceG+ZteLJb6u0RGOTwENMmMZiea7JwFOxkbAE6gCgBEdi4vF8XJ58vK4I
        OpnyRChAWkY/VKfORBjKW616WWFUm5VteEJL4OiCLVA==
X-Received: by 2002:a17:906:4fd2:: with SMTP id i18mr10996967ejw.406.1642265297655;
        Sat, 15 Jan 2022 08:48:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvR9FTP4xTagoN3p21k94Rc9CvxzjPOJz+AS+KyzhZSM11mqtDPmngAfVR4GFzsjILW/S6mw==
X-Received: by 2002:a17:906:4fd2:: with SMTP id i18mr10996956ejw.406.1642265297518;
        Sat, 15 Jan 2022 08:48:17 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t10sm3556767edt.83.2022.01.15.08.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 08:48:17 -0800 (PST)
Message-ID: <030de58b-e2c8-b0f2-9756-df21eccf52ff@canonical.com>
Date:   Sat, 15 Jan 2022 17:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 09/11] arm64: defconfig: enable verdin-imx8mm relevant
 drivers as modules
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220114141507.395271-1-marcel@ziswiler.com>
 <20220114141507.395271-10-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220114141507.395271-10-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 15:15, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable various drivers which support peripherals as found on the
> Verdin iMX8M Mini et al. computer/system on modules:
> 
> - CONFIG_CAN_MCP251XFD
> At least one Microchip MCP2518FDT SPI CAN controller which this driver
> also supports may be found on the Verdin iMX8M Mini computer/system on
> module.
> 
> - CONFIG_BT_HCIUART_MRVL, CONFIG_BT_MRVL, CONFIG_BT_MRVL_SDIO and
>   CONFIG_MWIFIEX_SDIO
> The AzureWave AW-CM276NF which these Bluetooth and Wi-Fi drivers also
> support may be found on the Verdin iMX8M Mini (as well as the Apalis
> iMX8, Colibri iMX8X and Verdin iMX8M Plus for that matter) computer/
> system on module.
> 
> - CONFIG_SENSORS_LM75
> The TI TMP75C temperature sensor which this driver also supports may be
> found on the Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for
> that matter) computer/system on module.
> 
> - CONFIG_SND_SOC_NAU8822
> The Nuvoton Technology Corporation (NTC) NAU88C22YG which this driver
> also supports may be found on the Verdin Development Board a carrier
> board for the Verdin family of computer/system on module which the
> Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for that matter)
> may be mated in.
> 
> - CONFIG_TI_ADS1015
> The TLA2024 ADC which this driver also supports may be found on the
> Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for that matter)
> computer/system on module.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Explain why enabling these may make sense and squash them relevant
>   changes as requested by Krzysztof.
> 

Thanks, this is a nice explanation.
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
