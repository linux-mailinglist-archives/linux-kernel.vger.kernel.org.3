Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19214F0DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiDDEEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiDDEEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:04:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAA393FC;
        Sun,  3 Apr 2022 21:02:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s8so7763394pfk.12;
        Sun, 03 Apr 2022 21:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gApwyK6UJMIHFi8j3HHI6lVYvVDscNhbn/b45ZD8vYw=;
        b=PpAMX76Z/yH5s5E86XWDfdb0tshq5E8aUG6vKlOuwz+RxiadMZC6gwVk8hp/IvSKdy
         pWDbVcIvhaAzCuy6MyDBJG2dxgKFmd2PUF157wQmlFwd1dygPQr7kpgfjuJPSZpZeV8W
         KJ8XB6IA9wYH8pFUDUrggUJW7xHL4Z3Jfto/zT/xPYv3oFpJgBXB6AOYoiNplFnNBxhi
         QjnpR9G8KK2BCcUi5zT0OooJ64wrDp1LHF79wrS/9T9wiMGZ5Lrpbk8fcfgAtt+rvBGB
         f/JIRwKjXsgZbcHHbbAEl/MMqr5KGQN35kxhWJzqNfO2wjz9Wqyu3wTfB+BG6AbwBbg9
         CU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gApwyK6UJMIHFi8j3HHI6lVYvVDscNhbn/b45ZD8vYw=;
        b=YtwCYkmCJjnhBamtZ+HjiXz6yVUc3JrjGDJ6kSRaH4zBKfH70a4NgOYbkhC+uUltMW
         wAYsFRmGCGfEFSi26dgmIcFNU5Cjybf2b3MSkJAc2+QcWuqVA8t69Z4YJ9sF7viD2s4c
         0UFogWRbhMvYCdYpbMS8WvLXMz1WaXXoW5EJwSmG2nmZlD0gsE38D5v49tXpM0dGkQOh
         86DjsKJhsj3bfNmVSrFBGwGdtk/M+2te8dZ++CsxDNO0QobHWJSToh7ClWGVtCytGzJX
         YDNafHx9iyc9NWMkQdgK+AXchJDF/TwgNuAe0ZGRoBia4yiefoxFlviyF0262WcznLEU
         ilqA==
X-Gm-Message-State: AOAM530/4kzd+gh/+4M5wjfg4gDmNBqzqvjZVk96zvwMT21dKE65Bed7
        FT9IQNGfJkNwc9JmzEvRfbKwryZ7SjtVrmUfpZLhIw==
X-Google-Smtp-Source: ABdhPJzYjDiKmixeywLrVGsyvmxU0FRdWO7nMbcfY2jZXT0DudGOSkM6UFaGrSEgSvmTt6mXFmBOzQ==
X-Received: by 2002:aa7:88c2:0:b0:4fa:ba98:4f6f with SMTP id k2-20020aa788c2000000b004faba984f6fmr22013214pff.41.1649044928130;
        Sun, 03 Apr 2022 21:02:08 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id j70-20020a638b49000000b003985b5ddaa1sm8756191pge.49.2022.04.03.21.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 21:02:07 -0700 (PDT)
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
Subject: [PATCH v2 0/5] spi: add support for Mediatek SPI-NAND controller
Date:   Mon,  4 Apr 2022 12:01:48 +0800
Message-Id: <20220404040153.1509966-1-gch981213@gmail.com>
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

Chuanhong Guo (5):
  mtd: nand: make mtk_ecc.c a separated module
  spi: add driver for MTK SPI NAND Flash Interface
  mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
  dt-bindings: spi: add binding doc for spi-mtk-snfi
  arm64: dts: mediatek: add mtk-snfi for mt7622

 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   |   88 ++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   12 +
 drivers/mtd/nand/Kconfig                      |    7 +
 drivers/mtd/nand/Makefile                     |    1 +
 drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} |    8 +-
 drivers/mtd/nand/raw/Kconfig                  |    1 +
 drivers/mtd/nand/raw/Makefile                 |    2 +-
 drivers/mtd/nand/raw/mtk_nand.c               |    2 +-
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-mtk-snfi.c                    | 1351 +++++++++++++++++
 .../linux/mtd/nand-ecc-mtk.h                  |    0
 12 files changed, 1478 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
 rename drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} (98%)
 create mode 100644 drivers/spi/spi-mtk-snfi.c
 rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)

-- 
2.35.1

