Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB97B50AFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386990AbiDVGE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354293AbiDVGEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541A4F9FA;
        Thu, 21 Apr 2022 23:02:00 -0700 (PDT)
X-UUID: 4e4b7db46a96418abde3912f459a4f2c-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:5fffbfdd-e38e-4fa0-bbcd-8d67254881e4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:5fffbfdd-e38e-4fa0-bbcd-8d67254881e4,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:4c1593f0-da02-41b4-b6df-58f4ccd36682,C
        OID:1044512e2bc6,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 4e4b7db46a96418abde3912f459a4f2c-20220422
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1584171524; Fri, 22 Apr 2022 14:01:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 22 Apr 2022 14:01:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 14:01:53 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V3 00/17] Cleanup MediaTek clk reset drivers and support MT8192/MT8195
Date:   Fri, 22 Apr 2022 14:01:35 +0800
Message-ID: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this series, we cleanup MediaTek clock reset drivers in clk/mediatek
folder. MediaTek clock reset driver is used to provide reset control
of modules controlled in clk, like infra_ao.

Changes for V3:
1. Modify drivers for reviewers' comments.
2. Add dt-binding patch for MT8192/MT8195 infra.
3. Add reset property of infra node for MT8192.
4. Use original function for simple operation.

Changes for V2:
1. Modify drivers for reviewers' comments.
2. Use simple reset to replace v1.
3. Recover v2 to set_clr.
4. Separate error handling to another patch.
5. Add support for input offset and bit from DT.
6. Add support for MT8192 and MT8195.

Rex-BC Chen (17):
  clk: mediatek: reset: Add reset.h
  clk: mediatek: reset: Fix written reset bit offset
  clk: mediatek: reset: Refine and reorder functions in reset.c
  clk: mediatek: reset: Extract common drivers to update function
  clk: mediatek: reset: Merge and revise reset register function
  clk: mediatek: reset: Revise structure to control reset register
  clk: mediatek: reset: Add return for clock reset register function
  clk: mediatek: reset: Add new register reset function with device
  clk: mediatek: reset: Add support for input offset and bit from DT
  clk: mediatek: reset: Add reset support for simple probe
  dt-bindings: arm: mediatek: Add #reset-cells property for MT8192-sys-clock
  dt-binding: mt8192: Add infra_ao reset bit
  dt-bindings: arm: mediatek: Add #reset-cells property for MT8195-sys-clock
  dt-binding: mt8195: Add infra_ao reset bit
  clk: mediatek: reset: Add infra_ao reset support for MT8192
  clk: mediatek: reset: Add infra_ao reset support for MT8195
  arm64: dts: mediatek: Add infra #reset-cells property for MT8192

 .../mediatek/mediatek,mt8192-sys-clock.yaml   |   3 +
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |   3 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   1 +
 drivers/clk/mediatek/clk-mt2701-eth.c         |   8 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c         |   8 +-
 drivers/clk/mediatek/clk-mt2701-hif.c         |   8 +-
 drivers/clk/mediatek/clk-mt2701.c             |  19 +-
 drivers/clk/mediatek/clk-mt2712.c             |  19 +-
 drivers/clk/mediatek/clk-mt7622-eth.c         |   8 +-
 drivers/clk/mediatek/clk-mt7622-hif.c         |  10 +-
 drivers/clk/mediatek/clk-mt7622.c             |  19 +-
 drivers/clk/mediatek/clk-mt7629-eth.c         |   8 +-
 drivers/clk/mediatek/clk-mt7629-hif.c         |  10 +-
 drivers/clk/mediatek/clk-mt8135.c             |  19 +-
 drivers/clk/mediatek/clk-mt8173.c             |  19 +-
 drivers/clk/mediatek/clk-mt8183.c             |   8 +-
 drivers/clk/mediatek/clk-mt8192.c             |  11 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |   8 +
 drivers/clk/mediatek/clk-mtk.c                |   7 +
 drivers/clk/mediatek/clk-mtk.h                |   9 +-
 drivers/clk/mediatek/reset.c                  | 202 +++++++++++++-----
 drivers/clk/mediatek/reset.h                  |  36 ++++
 include/dt-bindings/reset/mt8192-resets.h     |  10 +
 include/dt-bindings/reset/mt8195-resets.h     |   7 +
 24 files changed, 381 insertions(+), 79 deletions(-)
 create mode 100644 drivers/clk/mediatek/reset.h

-- 
2.18.0

