Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2E4F873C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346916AbiDGSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346910AbiDGSoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:44:10 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8901C71CF;
        Thu,  7 Apr 2022 11:42:08 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ncX4w-0001rM-SW; Thu, 07 Apr 2022 20:41:59 +0200
Date:   Thu, 7 Apr 2022 19:41:54 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v4 0/5] spi: add support for Mediatek SPI-NAND controller
Message-ID: <Yk8wctUzF7eWYOZD@makrotopia.org>
References: <20220407150652.21885-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407150652.21885-1-gch981213@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:06:47PM +0800, Chuanhong Guo wrote:
> Mediatek has an extended version of their NAND Flash Interface which
> has a SPI-NAND mode. In this mode, the controller can perform 1-bit
> spi-mem ops for up-to 0xa0 bytes and typical SPI-NAND single, dual
> and quad IO page cache ops with 2-byte address. Additionally, the
> page cache ops can be performed with ECC and auto data formatting
> using the ECC engine of the controller.
> 
> This patchset implements support of this mode as a separated SPI-MEM
> driver with piplined ECC engine.
              ^^^^^^^^
missing 'e':  pipelined

For the whole series:
Tested-by: Daniel Golle <daniel@makrotopia.org>

> 
> Changes since v1:
>  add a blank line between properties in dt binding doc
>  rename ecc-engine to nand-ecc-engine for the generic properties
>  fix warnings/errors from the CI
> 
> Changes since v2:
>  use streamed DMA api to avoid an extra memory copy during read
>  make ECC engine config a per-nand context
>  take user-requested ECC strength into account
> 
> Change since v3:
>  fix a missed ecc-engine rename in doc from v1
> 
> Chuanhong Guo (5):
>   mtd: nand: make mtk_ecc.c a separated module
>   spi: add driver for MTK SPI NAND Flash Interface
>   mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
>   dt-bindings: spi: add binding doc for spi-mtk-snfi
>   arm64: dts: mediatek: add mtk-snfi for mt7622
> 
>  .../bindings/spi/mediatek,spi-mtk-snfi.yaml   |   88 +
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   12 +
>  drivers/mtd/nand/Kconfig                      |    7 +
>  drivers/mtd/nand/Makefile                     |    1 +
>  drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} |    8 +-
>  drivers/mtd/nand/raw/Kconfig                  |    1 +
>  drivers/mtd/nand/raw/Makefile                 |    2 +-
>  drivers/mtd/nand/raw/mtk_nand.c               |    2 +-
>  drivers/spi/Kconfig                           |   10 +
>  drivers/spi/Makefile                          |    1 +
>  drivers/spi/spi-mtk-snfi.c                    | 1442 +++++++++++++++++
>  .../linux/mtd/nand-ecc-mtk.h                  |    0
>  12 files changed, 1569 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
>  rename drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} (98%)
>  create mode 100644 drivers/spi/spi-mtk-snfi.c
>  rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)
> 
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
