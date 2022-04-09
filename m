Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59AA4FA776
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbiDIMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiDIMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:11:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A3F26565;
        Sat,  9 Apr 2022 05:08:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r66so10068669pgr.3;
        Sat, 09 Apr 2022 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1j0gO9uErjvVk6RFrnXJ0zAPni0/cjOQMUjki6bRDRg=;
        b=mCSJBLn4hULqdHwXSIn5cP9LqjNa2EQaAWPHDXyuE/W5KN/qe9UZ8gHmIu5GOVhTsy
         m3JP12oNdzMTZ1H1J+Nz2QxCRy9Z4faoeMefncI2RN/BQmzLKekRz8jwNaGh25PfQcqO
         nZValEQj20WCFkP9dU5FRzjDwrXthMLFrsxmuLMACSToOXfXuRpIBjwkq0N8RZd2OB7q
         KMuslyp//ga4sGAJOMWbqU4rebSj+HhA2vfCHG7KPqwpHitCvc3QGCO4/gB85Xg1I+2j
         R0ZN64N7TMIm4eUpuomUlk/aKFWtUPlnlmydmCKUULDaLLxho3M/k8HREp0jBGJj4+4v
         B5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1j0gO9uErjvVk6RFrnXJ0zAPni0/cjOQMUjki6bRDRg=;
        b=Tatca7HmjdYnkuQhnUgkqUt4LOWPE8fbpn6CfAHftNoFqRDabJ2EIgjh53fiemfo8q
         t8x489iga7eRAndV04YS2wIdqm+0GFGyjF1R4urbDdr7Ef36iCV+iWEZz7CCDWpSY+ws
         EUxQaoFp6cEKOi3ZhzJFiIP5mMx4mRo+YQ/9bgPvIc3tV6obw88a/+DXTAYvC/S+daLV
         AUoqveFKnQMbgvvPG+KgydM87HD8IPK6KUGIq07BwnREMCsaxNMi4rKrSOXZUgvWXwKn
         qIPnMI6+fabQTR+Kr7A3EzgPhor24JZZQigATvFJEdPf/i75OrONnYkWomjvefh4xCbm
         iBeQ==
X-Gm-Message-State: AOAM533wtycA3VDxwxw3sIt1vEmTDkharxsVVZ9OZNBqLg1COao2I4/s
        oYG99I2Jy+W5/rF1yHTQY2DZ5ZgB1o3CdJMJ+DDxSw==
X-Google-Smtp-Source: ABdhPJwCZw8vGM09uQH5mJqKTLKRtwCEU2MBeZ0r24DF3GM09731Jt5dyH3YhCVUk1ohUfhdih4umw==
X-Received: by 2002:a63:3e0c:0:b0:398:2829:58cd with SMTP id l12-20020a633e0c000000b00398282958cdmr19434793pga.464.1649506131992;
        Sat, 09 Apr 2022 05:08:51 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id a85-20020a621a58000000b0050569a135besm8307357pfa.201.2022.04.09.05.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 05:08:51 -0700 (PDT)
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
Subject: [PATCH v5 0/5] spi: add support for Mediatek SPI-NAND controller
Date:   Sat,  9 Apr 2022 20:08:14 +0800
Message-Id: <20220409120819.3124209-1-gch981213@gmail.com>
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
 drivers/spi/spi-mtk-snfi.c                    | 1467 +++++++++++++++++
 .../linux/mtd/nand-ecc-mtk.h                  |    0
 12 files changed, 1594 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
 rename drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} (98%)
 create mode 100644 drivers/spi/spi-mtk-snfi.c
 rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)

-- 
2.35.1

