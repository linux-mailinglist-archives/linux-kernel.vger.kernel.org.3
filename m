Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C64F09C2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357417AbiDCNOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiDCNOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:14:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111A0E45;
        Sun,  3 Apr 2022 06:12:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bx5so6309810pjb.3;
        Sun, 03 Apr 2022 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jxz5zWvm2g9eSY2ODGL8ove3tyAWCdoJG2idJFSxyD8=;
        b=XRJ6YJ9vdPpPa6TXlJFJxQGQeLPpk74MPpPWZ5pMZSuZfi2E0jGyTJ4wtvpnslPTi1
         77FmR0bZ/iGqrzcoszYTMBg7Pn/hbh7hqU7ZaR0lU5E7Tmb0KUivvCzotlGf31cSINEN
         zh2J89pAtJEMbCiYHSkSaIzv/Dtftx29GUl4hFhk++bjUVRlLJLH7xwbEBd6P8uh698g
         zSsNZxN3NVGMMLV0M70MYuti2rc3fuTzlVsJVDMRbLq+1MxVxVh43MkAd9hzrMGXpl3c
         BbTT1dosqQGjSjR1uUNatmE43fbNHOf968n3jK3OdSPjUp9vjG1e3zhcKVICGGso+395
         +Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jxz5zWvm2g9eSY2ODGL8ove3tyAWCdoJG2idJFSxyD8=;
        b=aKCiTb2rSEP0Vjz7Rxu4azA9U6jeWZyW6UQLWo+TubmUvsCgXZCXNL83XMXpSfg/xx
         JZPTBdlUSdsxd/J2DbpFR1qIcnL+ajLNEoaaLSuUoA8bnr8oMO8cF/g/NMw5/MvFqIr4
         8jckJis6COaby5AcC9EvJwhL01PQ9fbGoSkgrtfWvvkRUuGVly+pDYC21GYo+fuT4D9i
         XCaK9QKiB98+UsLbVZIfvXJP7qCIDgVE7Pxujp3ZSgC3xOG56La9V4cQeDCisxsMzTNc
         DOcCoUyEUXYXJ237NmvYNQS74v6xfi78Gal97GHJr5WS5QRP2f9gvCPx1r81Sy88wlUk
         zBlQ==
X-Gm-Message-State: AOAM5316770U8zzbuj9WJ5oIulUlpMuT0v3/+23Ur95ML2lM2Gq8voS1
        5/z9H4FUxh9bj6BvNF7Ua2I=
X-Google-Smtp-Source: ABdhPJz4ktVUPNppjfKX08ecvx5yuvB1psaY3bDDN0bXA48PEm7jKzKza3v5JFQBEkaWP/eZ2kgIJQ==
X-Received: by 2002:a17:90b:3b91:b0:1ca:5f81:da1e with SMTP id pc17-20020a17090b3b9100b001ca5f81da1emr6897040pjb.182.1648991563494;
        Sun, 03 Apr 2022 06:12:43 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id x123-20020a623181000000b004fdf99d25f6sm1554857pfx.80.2022.04.03.06.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:12:42 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@lists.infradead.org
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
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH 0/4] spi: add support for Mediatek SPI-NAND controller
Date:   Sun,  3 Apr 2022 21:11:50 +0800
Message-Id: <20220403131154.1267887-1-gch981213@gmail.com>
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

