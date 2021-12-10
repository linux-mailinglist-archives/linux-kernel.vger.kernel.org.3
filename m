Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8745470721
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244713AbhLJRaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:30:52 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43080 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244488AbhLJRac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:30:32 -0500
X-UUID: 0707d7ab912a42bb8c1c74b13a1f4f55-20211211
X-UUID: 0707d7ab912a42bb8c1c74b13a1f4f55-20211211
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1353861907; Sat, 11 Dec 2021 01:26:52 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 11 Dec 2021 01:26:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:26:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:26:50 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, Flora Fu <flora.fu@mediatek.com>,
        JB Tsai <jb.tsai@mediatek.com>
Subject: [PATCH 14/17] arm64: dts: mt8192: Add apu tinysys node
Date:   Sat, 11 Dec 2021 01:26:02 +0800
Message-ID: <20211210172605.30618-15-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210172605.30618-1-flora.fu@mediatek.com>
References: <20211210172605.30618-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for APU tinysys.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 62acaba7b033..de73fbf0cb90 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -914,6 +914,41 @@
 			#mbox-cells = <1>;
 		};
 
+		apusys_rv@19001000 {
+			compatible = "mediatek,mt8192-apusys-rv", "simple-mfd";
+			reg = <0 0x19000000 0 0x1000>,
+			      <0 0x19001000 0 0x1000>,
+			      <0 0x19002000 0 0x10>;
+			reg-names = "apu_mbox",
+				    "md32_sysctrl",
+				    "apu_wdt";
+			power-domains = <&apuspm 0>;
+			iommus = <&iommu_apu IOMMU_PORT_APU_DATA>;
+			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "apu_wdt";
+			mboxes = <&apu_mailbox 0>;
+
+			apu_ctrl {
+				compatible = "mediatek,apu-ctrl-rpmsg";
+				mtk,rpmsg-name = "apu-ctrl-rpmsg";
+			};
+
+			apu_pwr_tx {
+				compatible = "mediatek,apupwr-tx-rpmsg";
+				mtk,rpmsg-name = "apupwr-tx-rpmsg";
+			};
+
+			apu_pwr_rx {
+				compatible = "mediatek,apupwr-rx-rpmsg";
+				mtk,rpmsg-name = "apupwr-rx-rpmsg";
+			};
+
+			apu_mdw_rpmsg {
+				compatible = "mediatek,apu-mdw-rpmsg";
+				mtk,rpmsg-name = "apu-mdw-rpmsg";
+			};
+		};
+
 		iommu_apu: iommu@19010000 {
 			compatible = "mediatek,mt8192-iommu-apu";
 			reg = <0 0x19010000 0 0x1000>;
-- 
2.18.0

