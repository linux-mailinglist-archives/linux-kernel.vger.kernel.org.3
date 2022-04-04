Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029CA4F15B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350646AbiDDNUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiDDNUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:20:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F41FCE1;
        Mon,  4 Apr 2022 06:18:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i11so8099309plg.12;
        Mon, 04 Apr 2022 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6wcbV+qJGrMn7chZuaCccqMghdB+FEyb/f7TqVjzMk=;
        b=aPDmaa4VmUBVfevUhfa9oVsp9CXA/Q6oNxYCswggZjwUuiXHlNu7DGmtf7XOYLWAxQ
         IhJQvynczeaTU6zBL0v1laZwoZmc0eTwzyZ2QhygoS6m9dbyv/YcUbnHiexERAZo+1Qv
         x2tEavU50K9Aa8syMgokT8FH+h52wA4keUoyQiGa5eca60nICYYjpzMXKeD211DJTNaJ
         hgLEYypsvxYWPwCmMIMPYvo+qc/wtI9Snap09lbl6rSnSJi1b3s4uWSgBvEbECBr5tcb
         KyNtgDi7cYT47/nRtnwqxgz58M+jrlP4fTkYKw4gekrU1RHYf99BhxzNVWllCbGbyapY
         GxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6wcbV+qJGrMn7chZuaCccqMghdB+FEyb/f7TqVjzMk=;
        b=JSBkV8jX2XJidN4fzf0Ckaotk7RlWoDtlfO2PQrZV3rv6As8zb1aVGJd+DsuDBFPiG
         /YFQA51sw2I1w/Sr0+6rnE1SRDdk38ydeCh+ZYHE51W1R2gInSvG4u0Dz1NJy/8rezj4
         eQSgYcdCo3SV4BwDlOuA5uNuGsYAlnzn3N9g2MybM6vZ8fvdsU+7XY5SKL9hMS64UiwN
         TSvyvYtD+hEchwOZUssQ3kZutTyeXD8s5xaDP1hPnR+GFhOq1NybChpRnCls+6LWXUgi
         3x/lv1WBK2L4DigeYrWlOdJ8z18v/Jm3bFeioiTfXwLi5ZTzqOG0pkzVA2CdTFQsi7D6
         6i9A==
X-Gm-Message-State: AOAM532SJR289tw1nEq7pqV8HkwYBU5J1yi8a74K1XbZgyRFIL1m2Q/2
        6tkwWhUX2r7OJIgPc6JG5/vKcIuF1ISuJJ4E8gQ=
X-Google-Smtp-Source: ABdhPJyTtpgK1M4MzanXxpNHJL0/070QGds3fteDAO/EzkIiBE6QFiBT6V69ppxh8X3ZPaIktCqz+g==
X-Received: by 2002:a17:90a:5913:b0:1c7:2b71:65d8 with SMTP id k19-20020a17090a591300b001c72b7165d8mr26285607pji.87.1649078319326;
        Mon, 04 Apr 2022 06:18:39 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm12475705pfj.43.2022.04.04.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 06:18:38 -0700 (PDT)
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
Subject: [PATCH v3 0/5] spi: add support for Mediatek SPI-NAND controller
Date:   Mon,  4 Apr 2022 21:18:13 +0800
Message-Id: <20220404131818.1817794-1-gch981213@gmail.com>
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

Changes since v1:
 add a blank line between properties in dt binding doc
 rename ecc-engine to nand-ecc-engine for the generic properties
 fix warnings/errors from the CI

Changes since v2:
 use streamed DMA api to avoid an extra memory copy during read
 make ECC engine config a per-nand context
 take user-requested ECC strength into account

Chuanhong Guo (5):
  mtd: nand: make mtk_ecc.c a separated module
  spi: add driver for MTK SPI NAND Flash Interface
  mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
  dt-bindings: spi: add binding doc for spi-mtk-snfi
  arm64: dts: mediatek: add mtk-snfi for mt7622

 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   |   88 +
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   12 +
 drivers/mtd/nand/Kconfig                      |    7 +
 drivers/mtd/nand/Makefile                     |    1 +
 drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} |    8 +-
 drivers/mtd/nand/raw/Kconfig                  |    1 +
 drivers/mtd/nand/raw/Makefile                 |    2 +-
 drivers/mtd/nand/raw/mtk_nand.c               |    2 +-
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-mtk-snfi.c                    | 1442 +++++++++++++++++
 .../linux/mtd/nand-ecc-mtk.h                  |    0
 12 files changed, 1569 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
 rename drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} (98%)
 create mode 100644 drivers/spi/spi-mtk-snfi.c
 rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)

-- 
2.35.1

