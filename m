Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21A4CBAE4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiCCKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiCCKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:02:18 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE6A17583E;
        Thu,  3 Mar 2022 02:01:33 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s6so771623qtc.4;
        Thu, 03 Mar 2022 02:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G9PHk5b8ybcVtwN7kEtMFnRB/ixoL3gdzwNYrWBekH4=;
        b=iGc3tjeRFO5Rq2XYTcdMye2mUJQXxEERvcn+LrCIDZkAydY6bGbK56wkpjUHFc0TjF
         LECSYDRcmRUtSG7JBAXl3WSRHANYn5S2QY+ktWPAjNaYVap0AlSjvhdAzmLMvzK1WlaJ
         zJRdPYVyaxF/ju9TGZyi8ifWNzfUbUVZusKPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G9PHk5b8ybcVtwN7kEtMFnRB/ixoL3gdzwNYrWBekH4=;
        b=XfbOEtK60N0hQBJGzdMORZEuKrm07xAS133scmVnuDTN+xZj/otZvXbwPnQPJ3k0HZ
         InAfVsq5COposvip71tx6ilJDbjLbi5hnd9M7MJpMCitPrjhZopt1cW065n2+5lM8U6c
         1/AZL21VXSo3MpbL4yj6HgeWmK/QWOXmpnHrj080tFzty7j68Udh8hXgzx/5LxR/gG2z
         /9gSEaYH60I8+tqoB+TMpmTi51v3g7ToiFz9acnczeHm0u2SVCDVlqF748EoS68h1S/2
         7o/GYnv5qodakgMZBACFvGF2pXP7gl0J2cic+pHlosNcA2ETG7F6wK4qOKQHQW0v2pIm
         JNEw==
X-Gm-Message-State: AOAM532vV5GS8KRf1ULWsMv5J8X3NIGtpYz0m6efyL6BLvFlEwcnweJF
        8DR6lldwZGXtDvYkJWgFXdakmtbXV78rHOK686E=
X-Google-Smtp-Source: ABdhPJwbyjMF4/+uKtidDmLm+UFMaRCJqygDuoveGbZrVmtjir51PTwiLHr0xfupuoRunq3CJSzt8npBsay+Od5Tn0Q=
X-Received: by 2002:ac8:5d89:0:b0:2df:f357:c681 with SMTP id
 d9-20020ac85d89000000b002dff357c681mr20144873qtx.475.1646301692215; Thu, 03
 Mar 2022 02:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org>
In-Reply-To: <20220302173114.927476-1-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 3 Mar 2022 10:01:20 +0000
Message-ID: <CACPK8Xdo=krCNVVs5=jiSnmyiPkNPd9Dxxyx0Tv8eUHKR5J3cQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] spi: spi-mem: Add driver for Aspeed SMC controllers
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        John Wang <wangzq.jn@gmail.com>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 17:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hi,
>
> This series adds a new SPI driver using the spi-mem interface for the
> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> SoCs.
>
>  * AST2600 Firmware SPI Memory Controller (FMC)
>  * AST2600 SPI Flash Controller (SPI1 and SPI2)

I've performed read and write tests on the 2600 controllers, and the
driver seems stable at the settings you have in the device tree.

Tested-by: Joel Stanley <joel@jms.id.au>

I've added Tao and John to cc as they have tested the 2400 and 2500,
and I'm sure will be able to provide some Tested-by.

Cheers,

Joel

>  * AST2500 Firmware SPI Memory Controller (FMC)
>  * AST2500 SPI Flash Controller (SPI1 and SPI2)
>  * AST2400 New Static Memory Controller (also referred as FMC)
>  * AST2400 SPI Flash Controller (SPI)
>
> It is based on the current OpenBMC kernel driver [1], using directly
> the MTD SPI-NOR interface and on a patchset [2] previously proposed
> adding support for the AST2600 only. This driver takes a slightly
> different approach to cover all 6 controllers.
>
> It does not make use of the controller register disabling Address and
> Data byte lanes because is not available on the AST2400 SoC. We could
> introduce a specific handler for new features available on recent SoCs
> if needed. As there is not much difference on performance, the driver
> chooses the common denominator: "User mode" which has been heavily
> tested in [1]. "User mode" is also used as a fall back method when
> flash device mapping window is too small.
>
> Problems to address with spi-mem were the configuration of the mapping
> windows and the calibration of the read timings. The driver handles
> them in the direct mapping handler when some knowledge on the size of
> the flash device is know. It is not perfect but not incorrect either.
> The algorithm is one from [1] because it doesn't require the DMA
> registers which are not available on all controllers.
>
> Direct mapping for writes is not supported (yet). I have seen some
> corruption with writes and I preferred to use the safer and proven
> method of the initial driver [1]. We can improve that later.
>
> The driver supports Quad SPI RX transfers on the AST2600 SoC but it
> didn't have the expected results. Therefore it is not activated yet.
> There are some issues on the pinctrl to investigate first.
>
> The series does not remove the current Aspeed SMC driver but prepares
> ground for its removal by changing its CONFIG option. This last step
> can be addressed as a followup when the new driver using the spi-mem
> interface has been sufficiently exposed.
>
> Tested on:
>
>  * OpenPOWER Palmetto (AST2400)
>  * Facebook Wedge 100 BMC (AST2400) by Tao Ren <rentao.bupt@gmail.com>
>  * Evaluation board (AST2500)
>  * Inspur FP5280G2 BMC  (AST2500) by John Wang <wangzq.jn@gmail.com>
>  * Facebook Backpack CMM BMC (AST2500) by Tao Ren <rentao.bupt@gmail.com>
>  * OpenPOWER Witherspoon (AST2500)
>  * Evaluation board (AST2600 A0 and A3)
>  * Rainier board (AST2600)
>
> [1] https://github.com/openbmc/linux/blob/dev-5.15/drivers/mtd/spi-nor/co=
ntrollers/aspeed-smc.c
> [2] https://patchwork.ozlabs.org/project/linux-aspeed/list/?series=3D2123=
94
>
> Thanks,
>
> C.
>
> Changes in v2:
>
>  - Fixed dt_binding_check warnings (Rob)
>  - New entry in MAINTAINERS
>  - Addressed Lukas comments regarding the SPI controller registration
>    and device removal. Checked with driver bind/unbind
>  - Introduced setup and cleanup handlers and removed routine looping
>    on the DT children properties (Pratyush)
>  - Clarified in commit log requirements for training.
>  - Removed defconfig changes of patch 1 since they were reverted in
>    the last patch (Joel)
>
> C=C3=A9dric Le Goater (10):
>   mtd: spi-nor: aspeed: Rename Kconfig option
>   ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
>   dt-bindings: spi: Add Aspeed SMC controllers device tree binding
>   spi: spi-mem: Add driver for Aspeed SMC controllers
>   spi: aspeed: Add support for direct mapping
>   spi: aspeed: Adjust direct mapping to device size
>   spi: aspeed: Workaround AST2500 limitations
>   spi: aspeed: Add support for the AST2400 SPI controller
>   spi: aspeed: Calibrate read timings
>   ARM: dts: aspeed: Enable Dual SPI RX transfers
>
>  drivers/spi/spi-aspeed-smc.c                  | 1186 +++++++++++++++++
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |   90 ++
>  MAINTAINERS                                   |   10 +
>  arch/arm/boot/dts/aspeed-g4.dtsi              |   12 +-
>  arch/arm/boot/dts/aspeed-g5.dtsi              |   16 +-
>  arch/arm/boot/dts/aspeed-g6.dtsi              |   17 +-
>  drivers/mtd/spi-nor/controllers/Kconfig       |    4 +-
>  drivers/mtd/spi-nor/controllers/Makefile      |    2 +-
>  drivers/spi/Kconfig                           |   11 +
>  drivers/spi/Makefile                          |    1 +
>  10 files changed, 1330 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/spi/spi-aspeed-smc.c
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-=
fmc.yaml
>
> --
> 2.34.1
>
