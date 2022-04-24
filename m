Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C915250CEE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiDXD3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiDXD3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:29:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7439AE1265;
        Sat, 23 Apr 2022 20:26:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h5so10589280pgc.7;
        Sat, 23 Apr 2022 20:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UCURloz2C/UUp8MZeMALDjrLA/KFc0+/kp+RUMTv8A=;
        b=e7dAhUbHWqmf05a424ZswtbRuWjNN+/xYyMq5h+QxYl4Pjy56rkIT0zIBKYtRZn7+Z
         t3cLpI6DrZd5jkAPSMf0ij261PrMwzcF66oAjRNekuTjK+Csrbb0OpuWFRY+HZH2hubv
         bgdUzno7JQ0XvqYW678vHTvJ9iQ1AgrZwP/iBTSb08QaYaiNu1324YZw3pLpGK70fVDz
         pvOIkxnSXap261IGlPKmDiiVxfJgUPh8QVf/F0D+EIHGeUTESeByXY+DdTodmli94wLg
         05cELBcqz5aBYTC+mTii7nMvffQpyvpvhX/oV6I2j8gYG0lKViuCPyvJ8pXFnz0xjDPB
         pbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UCURloz2C/UUp8MZeMALDjrLA/KFc0+/kp+RUMTv8A=;
        b=nS+OrAb14NqXytYS91mqelTTPOiY9xEXhkfzTqv9C1n9V1jtQNC5SUNOw5vsxjqeKt
         JVMBQRihj3qXv9QIRzBwtUoGeGonArVyekZjcbYl/342dQYFnf0WZNHlDjnDlyqI9xox
         p75K0xu0EsyWYK1h99nabutjWjReOkI0UgG641EvqfXWsi/L1fFakvrv5RBeEszlOGwI
         N4tu7mQVu4gmNCTrGHcQuk3qHGms0RQYtokks5Qc4acSc6MNYPqsLyVsbQuzUPNaCdN7
         sX06QIC7r/IS+DFZQ/0rh9yS1fyNsLwuBFFrTPuVUONX2fcafkhCX8O1spf5NH2/BDiq
         5vxg==
X-Gm-Message-State: AOAM5315mtrpJk/VENlTOnaCb+IjLjy06IViLGiFCSuwYX75Nm/2fMI8
        NgbBD9i084zEd9dMzDBGtjfpMvkA8oBcAquR
X-Google-Smtp-Source: ABdhPJyjn3Vf81pjC8G66QDGXMDoAagvOs7RtZY0GfZrvLQRHAUWc6aOH2nuqQzVXk3hrGFLMo14LQ==
X-Received: by 2002:a63:e146:0:b0:39d:1b00:e475 with SMTP id h6-20020a63e146000000b0039d1b00e475mr10071390pgk.537.1650770763795;
        Sat, 23 Apr 2022 20:26:03 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id r76-20020a632b4f000000b003820643e1c2sm5790724pgr.59.2022.04.23.20.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 20:26:02 -0700 (PDT)
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
Subject: [PATCH v6 0/5] spi: add support for Mediatek SPI-NAND controller
Date:   Sun, 24 Apr 2022 11:25:22 +0800
Message-Id: <20220424032527.673605-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
driver with pipelined ECC engine.

Changes since v1:
 add a blank line between properties in dt binding doc
 rename ecc-engine to nand-ecc-engine for the generic properties
 fix warnings/errors from the CI

Changes since v2:
 use streamed DMA api to avoid an extra memory copy during read
 make ECC engine config a per-nand context
 take user-requested ECC strength into account

Change since v3:
 fix a missed ecc-engine rename in doc from v1

Changes since v4:
 fix typo: piplined -> pipelined
 fix missing OOB write in snfi driver
 print page format with dev_dbg instead
 replace uint*_t copied from vendor driver with u*

Changes since v5:
 add missing nfi mode register configuration in probe
 fix an off-by-one bug in mtk_snand_mac_io

Chuanhong Guo (5):
  mtd: nand: make mtk_ecc.c a separated module
  spi: add driver for MTK SPI NAND Flash Interface
  mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
  spi: dt-bindings: add binding doc for spi-mtk-snfi
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
 drivers/spi/spi-mtk-snfi.c                    | 1470 +++++++++++++++++
 .../linux/mtd/nand-ecc-mtk.h                  |    0
 12 files changed, 1597 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
 rename drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} (98%)
 create mode 100644 drivers/spi/spi-mtk-snfi.c
 rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)

-- 
2.35.1

