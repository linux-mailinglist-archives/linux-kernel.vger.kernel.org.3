Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1733513312
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbiD1L74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbiD1L7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8188B0A;
        Thu, 28 Apr 2022 04:56:29 -0700 (PDT)
X-UUID: 04ac1cfa536d41f2a8db36c268c09267-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:4789b727-6664-4b2b-bce4-c797dc9d9db8,OB:20,L
        OB:40,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:4789b727-6664-4b2b-bce4-c797dc9d9db8,OB:20,LOB
        :40,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:d5590c2f-6199-437e-8ab4-9920b4bc5b76,C
        OID:d7c54ea7e6a2,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 04ac1cfa536d41f2a8db36c268c09267-20220428
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1427020110; Thu, 28 Apr 2022 19:56:23 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 19:56:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 19:56:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 19:56:21 +0800
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
Subject: [PATCH V5 00/16] Cleanup MediaTek clk reset drivers and support MT8192/MT8195
Date:   Thu, 28 Apr 2022 19:56:03 +0800
Message-ID: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
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

Changes for V5:
1. Add all infra reset bits for MT8192 and MT8195.
2. Fix reviewers' comments.

Changes for V4:
1. Abandon the implementation of reset-cell = 2, and use reset index to
   determine which reset bit is used.
2. Add documentation for enum/structure/function in reset.h.
3. Combine binding/drvier support patch for MT8192 and MT8195.
4. The MT8195 DTS is accepted by Matthias, and I add new DTS patch to
   support infracfg_ao reset for MT8195. The DTS of MT8195 is still
   not merged into mainline. Please refer to [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=for-next&id=37f2582883be7218dc69f9af135959a8e93de223

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

Rex-BC Chen (16):
  clk: mediatek: reset: Add reset.h
  clk: mediatek: reset: Fix written reset bit offset
  clk: mediatek: reset: Refine and reorder functions in reset.c
  clk: mediatek: reset: Extract common drivers to update function
  clk: mediatek: reset: Merge and revise reset register function
  clk: mediatek: reset: Revise structure to control reset register
  clk: mediatek: reset: Support nonsequence base offsets of reset registers
  clk: mediatek: reset: Change return type for clock reset register function
  clk: mediatek: reset: Add new register reset function with device
  clk: mediatek: reset: Add reset support for simple probe
  dt-bindings: arm: mediatek: Add #reset-cells property for MT8192/MT8195
  dt-bindings: reset: mediatek: Add infra_ao reset bit for MT8195
  dt-bindings: reset: mediatek: Add infra_ao reset bit for MT8192
  clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
  arm64: dts: mediatek: Add infra #reset-cells property for MT8192
  arm64: dts: mediatek: Add infra #reset-cells property for MT8195

 .../mediatek/mediatek,mt8192-sys-clock.yaml   |   3 +
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |   3 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  13 +-
 drivers/clk/mediatek/clk-mt2701-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-hif.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701.c             |  22 ++-
 drivers/clk/mediatek/clk-mt2712.c             |  22 ++-
 drivers/clk/mediatek/clk-mt7622-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7622-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt7622.c             |  22 ++-
 drivers/clk/mediatek/clk-mt7629-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7629-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt8135.c             |  22 ++-
 drivers/clk/mediatek/clk-mt8173.c             |  22 ++-
 drivers/clk/mediatek/clk-mt8183.c             |  18 +-
 drivers/clk/mediatek/clk-mt8192.c             |  18 ++
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  15 ++
 drivers/clk/mediatek/clk-mtk.c                |   7 +
 drivers/clk/mediatek/clk-mtk.h                |   9 +-
 drivers/clk/mediatek/reset.c                  | 172 ++++++++++++------
 drivers/clk/mediatek/reset.h                  |  77 ++++++++
 include/dt-bindings/reset/mt8192-resets.h     | 163 +++++++++++++++++
 include/dt-bindings/reset/mt8195-resets.h     | 170 +++++++++++++++++
 25 files changed, 759 insertions(+), 94 deletions(-)
 create mode 100644 drivers/clk/mediatek/reset.h

-- 
2.18.0

