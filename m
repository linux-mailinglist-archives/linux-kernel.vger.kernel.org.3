Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D548F808
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiAOQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:50:34 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35498
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232334AbiAOQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:50:33 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 55F8C3F175
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642265432;
        bh=Bx9uLSJo5l3JJeDZs91+co32u9UjuiQG91WGogmNU6Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MtnvNRIudjO+5jAE8wxALjsdcKYlMohjcZlOVOYrlGQl91nQaZKhS1FHkU9kVjEiL
         FSxHkxvA7Ags0QNW2oyhG32vcGnqjPA84ytf+Jh6yqLMfvD7vyp9l+DMAxz0WBxvdm
         /WUTWn8FJT9Ss5WyneiS9gAC/Ej+eWLbdCPmv7Bei6h8cRH6UDW0tixQwzbidw/Yxr
         9hxD7CiCWs1fH1tUPcQB0vrHWhteVbnnrU8noHTnWpcWWW4WgcZMCN3OWhsAl9mdHP
         G03rCXHYd27v2jbQVYPX3hckxJJ34eOtET6iraIGdnyTNFJN4qJA84pBbSAx6gKoew
         FBtLI6l6R69lQ==
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so10679758edb.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bx9uLSJo5l3JJeDZs91+co32u9UjuiQG91WGogmNU6Q=;
        b=6Ysx93AJq/pF/7IsaXX/WBgbsrdPrtnBkdQgz9pF1BswJw9kiGzBeZzDN4KcteCIrb
         xJfx+eNiyLLbdGVsA9LfGrJlEUSy5HHXK1q403bRd3R+YKI3DxlBT0u6w/ecFGZcrFdI
         /eDszCATCBNjvF7/1rP0rUuyVJK7ku1glGFxObRsbkyE+vEogiCGoSrauQb3TwYhK//H
         bvN46nBTz5Yu4o3BzkKJehSJENM/CawTEvUkOvrlaJCQ/5zAQi4WqXU4tOAuLZ4+oOTc
         wypgRx+X09ww2pJEKLC9+Cr6i1kGROir/dSuQquhm0yKB7YJ9X6g9Nxqah7Oan4Lu94f
         Syyw==
X-Gm-Message-State: AOAM531Y7lNZp0ng4ApTjCfzjH2Srtcy7A1ZvbP0RgGPLIYvbmfNjv/A
        Zts3R8gXm0/PPrR4Zt6nrcXnIfdUvLJKxZRgD3LolOsFdV//9t7f0anKlQhxNYNgtZZErud6VrP
        dho7sh7mxf6HBWeASZvGkzWylixVgpcZdJxupZ7kXZQ==
X-Received: by 2002:a05:6402:274e:: with SMTP id z14mr13630440edd.242.1642265431970;
        Sat, 15 Jan 2022 08:50:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRLa3GxKNNLPh4BLAvTX7vywOhl+rcpBmhKj4yXRpgSX3ph0nQ8ZGU37WZXch190wkFfTr4g==
X-Received: by 2002:a05:6402:274e:: with SMTP id z14mr13630429edd.242.1642265431793;
        Sat, 15 Jan 2022 08:50:31 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id u12sm2741591eda.56.2022.01.15.08.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 08:50:31 -0800 (PST)
Message-ID: <da5c9727-45c6-f2be-5a31-2214d0d1e9c0@canonical.com>
Date:   Sat, 15 Jan 2022 17:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 11/11] arm64: dts: freescale: add initial support for
 verdin imx8m mini
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>, Chester Lin <clin@suse.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220114141507.395271-1-marcel@ziswiler.com>
 <20220114141507.395271-12-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220114141507.395271-12-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 15:15, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This patch adds the device tree to support Toradex Verdin iMX8M Mini a
> computer on module which can be used on different carrier boards.
> 
> The module consists of an NXP i.MX 8M Mini family SoC (either i.MX 8M
> Mini Quad or 8M Mini DualLite), a PCA9450A PMIC, a Gigabit Ethernet PHY,
> 1 or 2 GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC, an I2C EEPROM, an
> RX8130 RTC, an optional SPI CAN controller plus an optional Bluetooth/
> Wi-Fi module.
> 
> Anything that is not self-contained on the module is disabled by
> default.
> 
> The device tree for the Dahlia includes the module's device tree and
> enables the supported peripherals of the carrier board.
> 
> The device tree for the Verdin Development Board includes the module's
> device tree as well as the Dahlia one as it is a superset and supports
> almost all peripherals available.
> 
> So far there is no display functionality supported at all but basic
> console UART, USB host, eMMC and Ethernet and PCIe functionality work
> fine.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Remove bootargs which will be filled in by the bootloader as requested
>   by Krzysztof.
> - Remove the previously #ifdefed-out spi-nor as requested by Krzysztof.
> - Fix capitalisation in cover-letter.
> 

Thanks for the changes.

Looks, good but I did not perform review thorough enough to give a
Reviewed-by tag, so let it be just:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
