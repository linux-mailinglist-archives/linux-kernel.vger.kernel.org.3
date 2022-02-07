Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7744AB6A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbiBGIb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243691AbiBGIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:30:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F9C043184;
        Mon,  7 Feb 2022 00:30:47 -0800 (PST)
X-UUID: 30dbd83bb10a4cb2acca31aa59954778-20220207
X-UUID: 30dbd83bb10a4cb2acca31aa59954778-20220207
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 923001334; Mon, 07 Feb 2022 16:30:43 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Feb 2022 16:30:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Feb
 2022 16:30:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Feb 2022 16:30:42 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH v3 1/2] soc: mediatek: pwrap: add pwrap driver for MT8186 SoC
Date:   Mon, 7 Feb 2022 16:30:33 +0800
Message-ID: <20220207083034.15327-2-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220207083034.15327-1-johnson.wang@mediatek.com>
References: <20220207083034.15327-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8186 are highly integrated SoC and use PMIC_MT6366 for
power management. This patch adds pwrap master driver to
access PMIC_MT6366.

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 71 ++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 952bc554f443..bf39a64f3ecc 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -30,6 +30,7 @@
 #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) & 0x00000001)
 #define PWRAP_STATE_SYNC_IDLE0		BIT(20)
 #define PWRAP_STATE_INIT_DONE0		BIT(21)
+#define PWRAP_STATE_INIT_DONE0_MT8186	BIT(22)
 #define PWRAP_STATE_INIT_DONE1		BIT(15)
 
 /* macro for WACS FSM */
@@ -77,6 +78,7 @@
 #define PWRAP_CAP_INT1_EN	BIT(3)
 #define PWRAP_CAP_WDT_SRC1	BIT(4)
 #define PWRAP_CAP_ARB		BIT(5)
+#define PWRAP_CAP_ARB_MT8186	BIT(8)
 
 /* defines for slave device wrapper registers */
 enum dew_regs {
@@ -1063,6 +1065,55 @@ static int mt8516_regs[] = {
 	[PWRAP_MSB_FIRST] =		0x170,
 };
 
+static int mt8186_regs[] = {
+	[PWRAP_MUX_SEL] =		0x0,
+	[PWRAP_WRAP_EN] =		0x4,
+	[PWRAP_DIO_EN] =		0x8,
+	[PWRAP_RDDMY] =			0x20,
+	[PWRAP_CSHEXT_WRITE] =		0x24,
+	[PWRAP_CSHEXT_READ] =		0x28,
+	[PWRAP_CSLEXT_WRITE] =		0x2C,
+	[PWRAP_CSLEXT_READ] =		0x30,
+	[PWRAP_EXT_CK_WRITE] =		0x34,
+	[PWRAP_STAUPD_CTRL] =		0x3C,
+	[PWRAP_STAUPD_GRPEN] =		0x40,
+	[PWRAP_EINT_STA0_ADR] =		0x44,
+	[PWRAP_EINT_STA1_ADR] =		0x48,
+	[PWRAP_INT_CLR] =		0xC8,
+	[PWRAP_INT_FLG] =		0xC4,
+	[PWRAP_MAN_EN] =		0x7C,
+	[PWRAP_MAN_CMD] =		0x80,
+	[PWRAP_WACS0_EN] =		0x8C,
+	[PWRAP_WACS1_EN] =		0x94,
+	[PWRAP_WACS2_EN] =		0x9C,
+	[PWRAP_INIT_DONE0] =		0x90,
+	[PWRAP_INIT_DONE1] =		0x98,
+	[PWRAP_INIT_DONE2] =		0xA0,
+	[PWRAP_INT_EN] =		0xBC,
+	[PWRAP_INT1_EN] =		0xCC,
+	[PWRAP_INT1_FLG] =		0xD4,
+	[PWRAP_INT1_CLR] =		0xD8,
+	[PWRAP_TIMER_EN] =		0xF0,
+	[PWRAP_WDT_UNIT] =		0xF8,
+	[PWRAP_WDT_SRC_EN] =		0xFC,
+	[PWRAP_WDT_SRC_EN_1] =		0x100,
+	[PWRAP_WDT_FLG] =		0x104,
+	[PWRAP_SPMINF_STA] =		0x1B4,
+	[PWRAP_DCM_EN] =		0x1EC,
+	[PWRAP_DCM_DBC_PRD] =		0x1F0,
+	[PWRAP_GPSINF_0_STA] =		0x204,
+	[PWRAP_GPSINF_1_STA] =		0x208,
+	[PWRAP_WACS0_CMD] =		0xC00,
+	[PWRAP_WACS0_RDATA] =		0xC04,
+	[PWRAP_WACS0_VLDCLR] =		0xC08,
+	[PWRAP_WACS1_CMD] =		0xC10,
+	[PWRAP_WACS1_RDATA] =		0xC14,
+	[PWRAP_WACS1_VLDCLR] =		0xC18,
+	[PWRAP_WACS2_CMD] =		0xC20,
+	[PWRAP_WACS2_RDATA] =		0xC24,
+	[PWRAP_WACS2_VLDCLR] =		0xC28,
+};
+
 enum pmic_type {
 	PMIC_MT6323,
 	PMIC_MT6351,
@@ -1083,6 +1134,7 @@ enum pwrap_type {
 	PWRAP_MT8135,
 	PWRAP_MT8173,
 	PWRAP_MT8183,
+	PWRAP_MT8186,
 	PWRAP_MT8195,
 	PWRAP_MT8516,
 };
@@ -1535,6 +1587,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT6779:
 	case PWRAP_MT6797:
 	case PWRAP_MT8173:
+	case PWRAP_MT8186:
 	case PWRAP_MT8516:
 		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
 		break;
@@ -2069,6 +2122,19 @@ static struct pmic_wrapper_type pwrap_mt8516 = {
 	.init_soc_specific = NULL,
 };
 
+static struct pmic_wrapper_type pwrap_mt8186 = {
+	.regs = mt8186_regs,
+	.type = PWRAP_MT8186,
+	.arb_en_all = 0xfb27f,
+	.int_en_all = 0xfffffffe, /* disable WatchDog Timeout for bit 1 */
+	.int1_en_all =  0x000017ff, /* disable Matching interrupt for bit 13 */
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB_MT8186,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct of_device_id of_pwrap_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt2701-pwrap",
@@ -2097,6 +2163,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt8183-pwrap",
 		.data = &pwrap_mt8183,
+	}, {
+		.compatible = "mediatek,mt8186-pwrap",
+		.data = &pwrap_mt8186,
 	}, {
 		.compatible = "mediatek,mt8195-pwrap",
 		.data = &pwrap_mt8195,
@@ -2209,6 +2278,8 @@ static int pwrap_probe(struct platform_device *pdev)
 
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
 		mask_done = PWRAP_STATE_INIT_DONE1;
+	else if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB_MT8186))
+		mask_done = PWRAP_STATE_INIT_DONE0_MT8186;
 	else
 		mask_done = PWRAP_STATE_INIT_DONE0;
 
-- 
2.18.0

