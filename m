Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945004707BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbhLJR4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50234 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244823AbhLJR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:16 -0500
X-UUID: 30e710115af7425f83d47c728c0077b9-20211211
X-UUID: 30e710115af7425f83d47c728c0077b9-20211211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 504518008; Sat, 11 Dec 2021 01:52:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:52:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:37 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        JB Tsai <jb.tsai@mediatek.com>
Subject: [PATCH 09/12] arm64: dts: mt8195: Add apu tinysys node
Date:   Sat, 11 Dec 2021 01:52:20 +0800
Message-ID: <20211210175223.31131-10-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for APU tinysys.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2f14e3326a2c..8f4f56e2f08c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1368,6 +1368,41 @@
 			#mbox-cells = <1>;
 		};
 
+		apusys_rv: apusys_rv@19001000 {
+			compatible = "mediatek,mt8195-apusys-rv", "simple-mfd";
+			reg = <0 0x19000000 0 0x1000>,
+			      <0 0x19001000 0 0x1000>,
+			      <0 0x19002000 0 0x10>;
+			reg-names = "apu_mbox",
+				    "md32_sysctrl",
+				    "apu_wdt";
+			power-domains = <&apuspm 0>;
+			iommus = <&iommu_apu0 IOMMU_PORT_APU_DATA>;
+			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "apu_wdt";
+			mboxes = <&apu_mailbox 0>;
+
+			apu_ctrl {
+				compatible = "mediatek,apu-ctrl-rpmsg";
+				mediatek,rpmsg-name = "apu-ctrl-rpmsg";
+			};
+
+			apu_pwr_tx {
+				compatible = "mediatek,apupwr-tx-rpmsg";
+				mediatek,rpmsg-name = "apupwr-tx-rpmsg";
+			};
+
+			apu_pwr_rx {
+				compatible = "mediatek,apupwr-rx-rpmsg";
+				mediatek,rpmsg-name = "apupwr-rx-rpmsg";
+			};
+
+			apu_mdw_rpmsg {
+				compatible = "mediatek,apu-mdw-rpmsg";
+				mediatek,rpmsg-name = "apu-mdw-rpmsg";
+			};
+		};
+
 		iommu_apu0: iommu@19010000 {
 			compatible = "mediatek,mt8195-iommu-apu";
 			reg = <0 0x19010000 0 0x1000>;
-- 
2.18.0

