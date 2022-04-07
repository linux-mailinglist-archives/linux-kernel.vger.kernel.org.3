Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9224F8276
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344440AbiDGPJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbiDGPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:09:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D461F0803;
        Thu,  7 Apr 2022 08:07:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so9120413pjn.3;
        Thu, 07 Apr 2022 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=anaG2wq1Mp5aVsWCwB1yCAYKxx6n0K0dy0ebU/z/BNk=;
        b=JgdZwO6NbBVu0IQ1x8A0jVZWbvOBz/Afh33B9DvsLPLU1TFE8+CMSfpfLWTij4cJe2
         mk0TtAyKoo763iB5mZioA47at4pkFgZejD9Z54MXj5VD8oIqJdfQcyINnfJxHksySq8H
         Inr6qRsJ4B7gZ51Arnf4z0tHKFOZwbqCf7AGSWY3Bx8GosVH8uMFE3/5x3rECq/i2GN6
         DDW+78MGH/VdChM+8HqIn5OyWNlWKUHcaLiAhsi4jHlzwNKYZQ3UzACBP47G+CJxFINe
         yCFX/TotmccasIHPz76zQATG5nqfoJrgfOnOwY8Ge8qNQNHv0ve9YsIM0QJ4mrbar05X
         zYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=anaG2wq1Mp5aVsWCwB1yCAYKxx6n0K0dy0ebU/z/BNk=;
        b=2iFGIsKQGbtrgMZmJeYM5m2b0F+anLc7z21StZNJ+jIrLIDXIueo0JzfTOljdQGkwj
         PAx3PKjMAJr3AvOR+yf/ZpvUfeCI6HmkJhITLrogcV99h35BAaHSCmWcUMyUB9w3OHqA
         pveS4hgtFVGkPYUI7pB156A8b6CfEJ1fXFgNHL8fQ0uIL1e+GCiGJK8hwqZLvpFGhOjp
         aX9yBAUrKgo6evGrJgmoZx3uX5HJyKur9rG2lXyEjcNNmGTmibQ2ZD35cogZvGbwylrq
         yhM/d3xDLk9fFaiqNcmpjts28D8s+NaL+vGwcMVbsVisivj1IjK20+gGtwRC5OGq/Q4S
         gO3g==
X-Gm-Message-State: AOAM5306/WLHQus2bh1AnwioYNNu/RrR1/fLulQD9R0YmhUo1Sp+KQA8
        WOHqLYgYW0IS0HMpr/L5u20no0wqKMBudwWbpSY=
X-Google-Smtp-Source: ABdhPJwonYPNnAMHSdSDX0TId9Tx03BErob+nv16vmF8mvYrT2IaMbND4jBqskaAVWnZGcA09z3Kww==
X-Received: by 2002:a17:90b:4a02:b0:1c6:c1a1:d65c with SMTP id kk2-20020a17090b4a0200b001c6c1a1d65cmr16454475pjb.97.1649344028136;
        Thu, 07 Apr 2022 08:07:08 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id x2-20020a63aa42000000b0038265eb2495sm19329908pgo.88.2022.04.07.08.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 08:07:07 -0700 (PDT)
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
Subject: [PATCH v4 0/5] spi: add support for Mediatek SPI-NAND controller
Date:   Thu,  7 Apr 2022 23:06:47 +0800
Message-Id: <20220407150652.21885-1-gch981213@gmail.com>
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

Change since v3:
 fix a missed ecc-engine rename in doc from v1

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

