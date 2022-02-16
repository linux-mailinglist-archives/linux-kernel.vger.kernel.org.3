Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD54B815D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiBPHVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:21:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiBPHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:21:36 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E43205FC;
        Tue, 15 Feb 2022 23:21:16 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s1so1282528qtw.9;
        Tue, 15 Feb 2022 23:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pOcJAEz2qU41PX9tifsFjG0wojUZW1SvJzugMZiYuC0=;
        b=nqq/1QEdzD/5W/nv2zTp9XXZj9GEXhlgKtfxNAWzCJpuPUnCuJDSykqaLEkUu73Eee
         bpXiXJ2uphU0Cix+zo+9i2ba1WtVKzy4o7JqsKHE9ClIbqu0kFBMDG+Q5jLFF5yisf+P
         DgWLheZ+6e0nB1COWgkhri2ulmv9D5ph51brU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pOcJAEz2qU41PX9tifsFjG0wojUZW1SvJzugMZiYuC0=;
        b=b3DuuDw7rAfzLypkZTQ9E8Ziy8CX8Cy9lMZQUWibDXR1g7+sodh68U5eB9mS/yVdT9
         UwqTWQtaOm/xqIpuoF/XYPOx/Sn0qdM73U/KFYDgoWvp8fXuKMVzaXWHmVnJZ731+JzE
         uvxLAEDhE7WEuYXvPFeEdxYweXKCLOCgybMV/++2rAvYM0WI8Sb4qzcLRmAGU4Fzmpns
         P08Y7b+mLmk+4+BLa2u/i2uVeKoajISw6X+ob++m2IYN2XEc8UldRTI2rUz9MhNh5Tnv
         UgFcpWkAorDKiLZWmLstyceSNW/ts7TUNME6lpQja6wzN7fVo4OgZW/0IJYpwkC+yBgY
         XmpA==
X-Gm-Message-State: AOAM5327nLVOYUmuUj9W2hsR+btNLFxGI+kKkcP7ZTxHDVz8w+PnvTTf
        3sTB/d/vmqTQrT3plpYon64EJzbUFLM423Wk0Ss=
X-Google-Smtp-Source: ABdhPJzW11flgp0zEGjBDsbZmQaNh3HD4dBznYiqY29J473H7ttZH/tN26OSjf6pOvHePn5DcqbqrSr9Ss1Ny09UdS4=
X-Received: by 2002:ac8:5b91:0:b0:2db:acb7:2412 with SMTP id
 a17-20020ac85b91000000b002dbacb72412mr1055351qta.475.1644996075867; Tue, 15
 Feb 2022 23:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20220214094231.3753686-1-clg@kaod.org>
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Feb 2022 07:21:04 +0000
Message-ID: <CACPK8Xe5_opc8W-00DZF1URcb2-OYSU6acjJg+c+aAoDxGBboA@mail.gmail.com>
Subject: Re: [PATCH 00/10] spi: spi-mem: Add driver for Aspeed SMC controllers
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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

On Mon, 14 Feb 2022 at 09:42, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hi,
>
> This series adds a new SPI driver using the spi-mem interface for the
> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> SoCs.
>
>  * AST2600 Firmware SPI Memory Controller (FMC)
>  * AST2600 SPI Flash Controller (SPI1 and SPI2)
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
> This needs more tests.
>
> The series does not remove the current Aspeed SMC driver but prepares
> ground for its removal by changing its CONFIG option. This last step
> can be addressed as a followup when the new driver using the spi-mem
> interface has been sufficiently exposed.
>
> Tested on:
>
>  * OpenPOWER Palmetto (AST2400)
>  * Evaluation board (AST2500)
>  * OpenPOWER Witherspoon (AST2500)
>  * Evaluation board (AST2600 A0)
>  * Rainier board (AST2600)

Looks great! Thanks for doing this work C=C3=A9dric.

I reviewed all of the patches. The device tree and defconfig ones,
which we will send via my aspeed tree, are good to go.

The others look good too, to the best of my knowledge.

I'll do some more testing of your v2 when you send it out.

Cheers,

Joel

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
> C=C3=A9dric Le Goater (10):
>   mtd: spi-nor: aspeed: Rename Kconfig option
>   dt-bindings: spi: Add Aspeed SMC controllers device tree binding
>   spi: spi-mem: Add driver for Aspeed SMC controllers
>   spi: aspeed: Add support for direct mapping
>   spi: aspeed: Adjust direct mapping to device size
>   spi: aspeed: Workaround AST2500 limitations
>   spi: aspeed: Add support for the AST2400 SPI controller
>   spi: aspeed: Calibrate read timings
>   ARM: dts: aspeed: Enable Dual SPI RX transfers
>   spi: aspeed: Activate new spi-mem driver
>
>  drivers/spi/spi-aspeed-smc.c                  | 1241 +++++++++++++++++
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |   92 ++
>  arch/arm/boot/dts/aspeed-g4.dtsi              |    6 +
>  arch/arm/boot/dts/aspeed-g5.dtsi              |    7 +
>  arch/arm/boot/dts/aspeed-g6.dtsi              |    8 +
>  drivers/mtd/spi-nor/controllers/Kconfig       |    4 +-
>  drivers/mtd/spi-nor/controllers/Makefile      |    2 +-
>  drivers/spi/Kconfig                           |   11 +
>  drivers/spi/Makefile                          |    1 +
>  9 files changed, 1369 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/spi/spi-aspeed-smc.c
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-=
fmc.yaml
>
> --
> 2.34.1
>
