Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9949F3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346533AbiA1G3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:29:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43534 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346488AbiA1G3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:29:11 -0500
X-UUID: b5d5a2e7869b468ca7c68449549ffa59-20220128
X-UUID: b5d5a2e7869b468ca7c68449549ffa59-20220128
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1531445026; Fri, 28 Jan 2022 14:29:06 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 Jan 2022 14:29:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 Jan
 2022 14:29:05 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 14:29:04 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/4] usb: xhci-mtk: add support ip-sleep wakeup for mt8195
Date:   Fri, 28 Jan 2022 14:29:00 +0800
Message-ID: <20220128062902.26273-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support ip-sleep wakeup for mt8195, it's a specific revision for
each USB controller, and not following IPM rule.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add reviewed-by Matthias & AngeloGioacchino
---
 drivers/usb/host/xhci-mtk.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 91738af0ab14..96a0ff0bb11e 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -95,6 +95,19 @@
 #define WC0_SSUSB0_CDEN		BIT(6)
 #define WC0_IS_SPM_EN		BIT(1)
 
+/* mt8195 */
+#define PERI_WK_CTRL0_8195	0x04
+#define WC0_IS_P_95		BIT(30)	/* polarity */
+#define WC0_IS_C_95(x)		((u32)(((x) & 0x7) << 27))
+#define WC0_IS_EN_P3_95		BIT(26)
+#define WC0_IS_EN_P2_95		BIT(25)
+#define WC0_IS_EN_P1_95		BIT(24)
+
+#define PERI_WK_CTRL1_8195	0x20
+#define WC1_IS_C_95(x)		((u32)(((x) & 0xf) << 28))
+#define WC1_IS_P_95		BIT(12)
+#define WC1_IS_EN_P0_95		BIT(6)
+
 /* mt2712 etc */
 #define PERI_SSUSB_SPM_CTRL	0x0
 #define SSC_IP_SLEEP_EN	BIT(4)
@@ -105,6 +118,10 @@ enum ssusb_uwk_vers {
 	SSUSB_UWK_V2,
 	SSUSB_UWK_V1_1 = 101,	/* specific revision 1.01 */
 	SSUSB_UWK_V1_2,		/* specific revision 1.2 */
+	SSUSB_UWK_V1_3,		/* mt8195 IP0 */
+	SSUSB_UWK_V1_4,		/* mt8195 IP1 */
+	SSUSB_UWK_V1_5,		/* mt8195 IP2 */
+	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
 };
 
 /*
@@ -308,6 +325,26 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
 		msk = WC0_SSUSB0_CDEN | WC0_IS_SPM_EN;
 		val = enable ? msk : 0;
 		break;
+	case SSUSB_UWK_V1_3:
+		reg = mtk->uwk_reg_base + PERI_WK_CTRL1_8195;
+		msk = WC1_IS_EN_P0_95 | WC1_IS_C_95(0xf) | WC1_IS_P_95;
+		val = enable ? (WC1_IS_EN_P0_95 | WC1_IS_C_95(0x1)) : 0;
+		break;
+	case SSUSB_UWK_V1_4:
+		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8195;
+		msk = WC0_IS_EN_P1_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
+		val = enable ? (WC0_IS_EN_P1_95 | WC0_IS_C_95(0x1)) : 0;
+		break;
+	case SSUSB_UWK_V1_5:
+		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8195;
+		msk = WC0_IS_EN_P2_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
+		val = enable ? (WC0_IS_EN_P2_95 | WC0_IS_C_95(0x1)) : 0;
+		break;
+	case SSUSB_UWK_V1_6:
+		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8195;
+		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
+		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
+		break;
 	case SSUSB_UWK_V2:
 		reg = mtk->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
 		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
-- 
2.18.0

