Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B984F09D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358758AbiDCNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbiDCNRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:17:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30D12A;
        Sun,  3 Apr 2022 06:15:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h24so2241046pfo.6;
        Sun, 03 Apr 2022 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jxz5zWvm2g9eSY2ODGL8ove3tyAWCdoJG2idJFSxyD8=;
        b=o2H/4QWzTk/zNdBkAUSDEK4pO6GMHLV//IJnAHYHpdyUybgQQZgi7qFJXyhyUR7+db
         Y9tddAp1MFrXWbS5WUOMSE7LJjuM9zcrEzKJXyEDheMTvDsTjUco0eKvkA0EPaWGz8TA
         B3DNmeG/YQLokQj2vHCib8QWXkJbw9eAQTg5/Db67tGhgAtwpO1gIcVPm2VOcyDa93C4
         ic+SVUVROHAk/DT8jLhwzRrs4S03HwhApTdLw7Bevc37BlAiAsHwjWCrx5bwEPlcJe5i
         O3fAhg0dJIZ/Pxwo8jrqjp6sZgSIMD3xN6JE+UTztaxvyBan+b+/ACEKWnkdwYBFpihg
         ndgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jxz5zWvm2g9eSY2ODGL8ove3tyAWCdoJG2idJFSxyD8=;
        b=JxSilJkF0uoA2nOUkKyWDg0DgqiktoLNl71lqT/xMjHj5zJMueJ7ihCryyUkRScXXS
         OzXvByStIMNeTvBRg3nzkfmRKEcr782yLvp9E4yNOD9TCKkomv0kOqvG/mRcHh4wbVKO
         n3VcBr3fVuiwCXwkS3HWouS1KRHhaB3mWpzR9vGv6FjQGR0WEddYWfPGOODl/1y0IWDC
         VRk2P0ah066n8H8qcbHTzfv6FeRyAScNUQpieFlzWA2GJ/mjcd3z4cMwgT4RLtKH20TJ
         +lUFMa+TVj83wG+dsvgcYu/BCfbBRfM4FX1oK2pRkfNvaSIjPTnjfjtmcLF7volGkDFe
         xWqg==
X-Gm-Message-State: AOAM530PTeqNwL2r7T50j7pDxKzeIcKX6D3utHpmpUyQSi9jk+gRVqTt
        gLp+l8KixNEkMulg11QtIS0SK0SgoaAF4ltP/Gc=
X-Google-Smtp-Source: ABdhPJzWXuOL0I4hTgBoXGcaIi+ysreVyogC03sWojHMYAn2qrmBGC1IWl1JiGOF2weJ4Zhz0DD9IA==
X-Received: by 2002:a05:6a00:10c8:b0:4fa:81cc:c86e with SMTP id d8-20020a056a0010c800b004fa81ccc86emr19028675pfu.23.1648991710505;
        Sun, 03 Apr 2022 06:15:10 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id w19-20020a056a0014d300b004fae5e3970csm9272416pfu.35.2022.04.03.06.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:15:10 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH resend 0/4] spi: add support for Mediatek SPI-NAND controller
Date:   Sun,  3 Apr 2022 21:14:49 +0800
Message-Id: <20220403131453.1269229-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek has an extended version of their NAND Flash Interface which
has a SPI-NAND mode. In this mode, the controller can perform 1-bit
spi-mem ops for up-to 0xa0 bytes and typical SPI-NAND single, dual
and quad IO page cache ops with 2-byte address. Additionally, the
page cache ops can be performed with ECC and auto data formatting
using the ECC engine of the controller.

This patchset implements support of this mode as a separated SPI-MEM
driver with piplined ECC engine.

Chuanhong Guo (4):
  mtd: nand: make mtk_ecc.c a separated module
  spi: add driver for MTK SPI NAND Flash Interface
  dt-bindings: spi: add binding doc for spi-mtk-snfi
  arm64: dts: mediatek: add dt node for MTK SNFI

 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   |   87 ++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   12 +
 drivers/mtd/nand/Kconfig                      |    7 +
 drivers/mtd/nand/Makefile                     |    1 +
 drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} |    3 +-
 drivers/mtd/nand/raw/Kconfig                  |    1 +
 drivers/mtd/nand/raw/Makefile                 |    2 +-
 drivers/mtd/nand/raw/mtk_nand.c               |    2 +-
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-mtk-snfi.c                    | 1356 +++++++++++++++++
 .../linux/mtd/nand-ecc-mtk.h                  |    0
 12 files changed, 1478 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
 rename drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} (99%)
 create mode 100644 drivers/spi/spi-mtk-snfi.c
 rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)

-- 
2.35.1

