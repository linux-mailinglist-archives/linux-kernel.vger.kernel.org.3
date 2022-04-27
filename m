Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB4651148A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiD0Jl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiD0JlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:41:21 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80E32F852;
        Wed, 27 Apr 2022 02:37:00 -0700 (PDT)
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 77EF7C7DEC;
        Wed, 27 Apr 2022 09:29:43 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3AB4320003;
        Wed, 27 Apr 2022 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651051743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=soyn1rvA89oTJzAqYQLvMAQyhAlfHV3ANoWX+URBfFc=;
        b=M15ZabbSNpJFIBlKT7MK3/iZlLUSspEov+J6NATfLMRrUfJyy/n3kjIJiAjgaWHz7vdjvT
        Bu1TU3Btr5rX/GaGd9Y/hNHtjlzqNKE5vn+QLCG+yY0jle0LqTImz3oOWdPrZZdUT24F3T
        1ZTGrlCEBqAwD+916+F/0QStUomS+38e0Jt4OLn9kjknODOpoVrMOQvWagq7nagWTng5mt
        Scf7f4hYx2+tvrRNzlyLTlX3Y8nosZG/JGSS5f799m3AkhmogdLAcm1pkdDUDw+ZTZvyHP
        DvMN2vB3eZzzX+Epxb2bClixrg3e4BXhSPWHqJjM0hXjjFKxvCDPY4l/Om/NDg==
Date:   Wed, 27 Apr 2022 11:28:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: Re: [PATCH v6 0/5] spi: add support for Mediatek SPI-NAND
 controller
Message-ID: <20220427112857.7ddd7fc8@xps13>
In-Reply-To: <20220424032527.673605-1-gch981213@gmail.com>
References: <20220424032527.673605-1-gch981213@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

gch981213@gmail.com wrote on Sun, 24 Apr 2022 11:25:22 +0800:

> Mediatek has an extended version of their NAND Flash Interface which
> has a SPI-NAND mode. In this mode, the controller can perform 1-bit
> spi-mem ops for up-to 0xa0 bytes and typical SPI-NAND single, dual
> and quad IO page cache ops with 2-byte address. Additionally, the
> page cache ops can be performed with ECC and auto data formatting
> using the ECC engine of the controller.
>=20
> This patchset implements support of this mode as a separated SPI-MEM
> driver with pipelined ECC engine.


[...]

The patch actually look independent, so if it's fine for you I can take
the two mtd patches and let you merge the spi/binding changes.

Would this work for you?

> Chuanhong Guo (5):
>   mtd: nand: make mtk_ecc.c a separated module
>   spi: add driver for MTK SPI NAND Flash Interface
>   mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
>   spi: dt-bindings: add binding doc for spi-mtk-snfi
>   arm64: dts: mediatek: add mtk-snfi for mt7622
>=20
>  .../bindings/spi/mediatek,spi-mtk-snfi.yaml   |   88 +
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   12 +
>  drivers/mtd/nand/Kconfig                      |    7 +
>  drivers/mtd/nand/Makefile                     |    1 +
>  drivers/mtd/nand/{raw/mtk_ecc.c =3D> ecc-mtk.c} |    8 +-
>  drivers/mtd/nand/raw/Kconfig                  |    1 +
>  drivers/mtd/nand/raw/Makefile                 |    2 +-
>  drivers/mtd/nand/raw/mtk_nand.c               |    2 +-
>  drivers/spi/Kconfig                           |   10 +
>  drivers/spi/Makefile                          |    1 +
>  drivers/spi/spi-mtk-snfi.c                    | 1470 +++++++++++++++++
>  .../linux/mtd/nand-ecc-mtk.h                  |    0
>  12 files changed, 1597 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mt=
k-snfi.yaml
>  rename drivers/mtd/nand/{raw/mtk_ecc.c =3D> ecc-mtk.c} (98%)
>  create mode 100644 drivers/spi/spi-mtk-snfi.c
>  rename drivers/mtd/nand/raw/mtk_ecc.h =3D> include/linux/mtd/nand-ecc-mt=
k.h (100%)
>=20


Thanks,
Miqu=C3=A8l
