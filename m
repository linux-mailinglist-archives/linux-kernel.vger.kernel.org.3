Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA64CD4CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiCDNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbiCDNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:09:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59646D393;
        Fri,  4 Mar 2022 05:08:25 -0800 (PST)
X-UUID: a030dbcb76764b93ba923df41b4a9524-20220304
X-UUID: a030dbcb76764b93ba923df41b4a9524-20220304
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 104143303; Fri, 04 Mar 2022 21:08:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 4 Mar 2022 21:08:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Mar 2022 21:08:19 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 08/21] arm64: dts: mt8192: Add infracfg_rst node
Date:   Fri, 4 Mar 2022 21:07:56 +0800
Message-ID: <20220304130809.12924-9-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220304130809.12924-1-allen-kh.cheng@mediatek.com>
References: <20220304130809.12924-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add infracfg_rst node for mt8192 SoC.
 - Add simple-mfd to allow probing the ti,syscon-reset node.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 40cf6dacca3e..82de1af3f6aa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8192-power.h>
+#include <dt-bindings/reset/ti-syscon.h>
 
 / {
 	compatible = "mediatek,mt8192";
@@ -267,10 +268,23 @@
 			#clock-cells = <1>;
 		};
 
-		infracfg: syscon@10001000 {
-			compatible = "mediatek,mt8192-infracfg", "syscon";
+		infracfg: infracfg@10001000 {
+			compatible = "mediatek,mt8192-infracfg", "syscon", "simple-mfd";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+
+			infracfg_rst: reset-controller {
+				compatible = "ti,syscon-reset";
+				#reset-cells = <1>;
+
+				ti,reset-bits = <
+					0x120 0 0x124 0 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: lvts_ap */
+					0x730 12 0x734 12 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 1: lvts_mcu */
+					0x140 15 0x144 15 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 2: pcie phy */
+					0x730 1 0x734 1 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 3: pcie top */
+					0x150 5 0x154 5 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 4: svs */
+				>;
+			};
 		};
 
 		pericfg: syscon@10003000 {
-- 
2.18.0

