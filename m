Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD5530D27
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiEWJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiEWJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:34:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137B1400E;
        Mon, 23 May 2022 02:33:55 -0700 (PDT)
X-UUID: 8235a3c4be3e4a90a58bdb8ce66ad027-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:6f71e884-c326-400d-ab95-ec6aecc74d8e,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:90
X-CID-INFO: VERSION:1.1.5,REQID:6f71e884-c326-400d-ab95-ec6aecc74d8e,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:90
X-CID-META: VersionHash:2a19b09,CLOUDID:10f6477a-5ef6-470b-96c9-bdb8ced32786,C
        OID:1e2456b5e79c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 8235a3c4be3e4a90a58bdb8ce66ad027-20220523
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 97796261; Mon, 23 May 2022 17:33:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 17:33:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 17:33:48 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>, <chun-jie.chen@mediatek.com>,
        <wenst@chromium.org>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND v8 00/19] Cleanup MediaTek clk reset drivers and support SoCs
Date:   Mon, 23 May 2022 17:33:27 +0800
Message-ID: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this series, we cleanup MediaTek clock reset drivers in clk/mediatek
folder. MediaTek clock reset driver is used to provide reset control
of modules controlled in clk, like infra_ao.

Changes for v8 resend:
1. Remove tested-by tag from Nícolas for MT8195/MT8186 patches.
2. Add reviewed-by tag from AngeloGioacchino.

Changes for v8:
1. Use 'enum mtk_reset_version' to replace u8 in patch 5 and 6.
2. Use lowercase '0xc' in patch 7.
3. Drop "simple-mfd" in patch 16 because it's for original reset controller.
4. v8 is based on linux-next next-20220520 and Chen-Yu's series[1].

Changes for v7:
1. v7 is based on linux-next next-20220519 and Chen-Yu's series[1].
2. Add support for MT8186.

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=643003

Changes for v6:
1. Add a new patch to support inuput argument index mode.
2. Revise definition in reset.h to index.

Rex-BC Chen (19):
  clk: mediatek: reset: Add reset.h
  clk: mediatek: reset: Fix written reset bit offset
  clk: mediatek: reset: Refine and reorder functions in reset.c
  clk: mediatek: reset: Extract common drivers to update function
  clk: mediatek: reset: Merge and revise reset register function
  clk: mediatek: reset: Revise structure to control reset register
  clk: mediatek: reset: Support nonsequence base offsets of reset
    registers
  clk: mediatek: reset: Support inuput argument index mode
  clk: mediatek: reset: Change return type for clock reset register
    function
  clk: mediatek: reset: Add new register reset function with device
  clk: mediatek: reset: Add reset support for simple probe
  dt-bindings: arm: mediatek: Add #reset-cells property for
    MT8192/MT8195
  dt-bindings: reset: mediatek: Add infra_ao reset index for
    MT8192/MT8195
  clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
  arm64: dts: mediatek: Add infra #reset-cells property for MT8192
  arm64: dts: mediatek: Add infra #reset-cells property for MT8195
  dt-bindings: reset: mediatek: Add infra_ao reset index for MT8186
  dt-bindings: arm: mediatek: Add #reset-cells property for MT8186
  clk: mediatek: reset: Add infra_ao reset support for MT8186

 .../mediatek/mediatek,mt8186-sys-clock.yaml   |   3 +
 .../mediatek/mediatek,mt8192-sys-clock.yaml   |   3 +
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |   3 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  15 +-
 drivers/clk/mediatek/clk-mt2701-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-hif.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701.c             |  22 +-
 drivers/clk/mediatek/clk-mt2712.c             |  22 +-
 drivers/clk/mediatek/clk-mt7622-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7622-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt7622.c             |  22 +-
 drivers/clk/mediatek/clk-mt7629-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7629-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt8135.c             |  22 +-
 drivers/clk/mediatek/clk-mt8173.c             |  22 +-
 drivers/clk/mediatek/clk-mt8183.c             |  18 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c    |  23 ++
 drivers/clk/mediatek/clk-mt8192.c             |  29 +++
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  24 +++
 drivers/clk/mediatek/clk-mtk.c                |   7 +
 drivers/clk/mediatek/clk-mtk.h                |   9 +-
 drivers/clk/mediatek/reset.c                  | 198 +++++++++++++-----
 drivers/clk/mediatek/reset.h                  |  82 ++++++++
 include/dt-bindings/reset/mt8186-resets.h     |   5 +
 include/dt-bindings/reset/mt8192-resets.h     |   8 +
 include/dt-bindings/reset/mt8195-resets.h     |   6 +
 28 files changed, 523 insertions(+), 95 deletions(-)
 create mode 100644 drivers/clk/mediatek/reset.h

-- 
2.18.0

