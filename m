Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66D8513321
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbiD1MAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345849AbiD1L7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD788B23;
        Thu, 28 Apr 2022 04:56:33 -0700 (PDT)
X-UUID: 4ad3d244cfcf445095ef12b2a68b6505-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b092f1ca-2cc8-4769-bd9a-6277ed243885,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:8565d4c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 4ad3d244cfcf445095ef12b2a68b6505-20220428
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1459100091; Thu, 28 Apr 2022 19:56:24 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 19:56:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 19:56:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 19:56:23 +0800
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
Subject: [PATCH V5 12/16] dt-bindings: reset: mediatek: Add infra_ao reset bit for MT8195
Date:   Thu, 28 Apr 2022 19:56:15 +0800
Message-ID: <20220428115620.13512-13-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support reset of infra_ao, add the bit definitions for MT8195.
The infra_ao reset includes 5 banks and 32 bits for each bank.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 include/dt-bindings/reset/mt8195-resets.h | 170 ++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
index a26bccc8b957..463114014483 100644
--- a/include/dt-bindings/reset/mt8195-resets.h
+++ b/include/dt-bindings/reset/mt8195-resets.h
@@ -7,6 +7,7 @@
 #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8195
 #define _DT_BINDINGS_RESET_CONTROLLER_MT8195
 
+/* TOPRGU resets */
 #define MT8195_TOPRGU_CONN_MCU_SW_RST          0
 #define MT8195_TOPRGU_INFRA_GRST_SW_RST        1
 #define MT8195_TOPRGU_APU_SW_RST               2
@@ -26,4 +27,173 @@
 
 #define MT8195_TOPRGU_SW_RST_NUM               16
 
+/* INFRA RST0 */
+#define MT8195_INFRA_RST0_THERM_CTRL_SWRST	0
+#define MT8195_INFRA_RST0_RSV0			1
+#define MT8195_INFRA_RST0_DISP_PWM1_SWRST	2
+#define MT8195_INFRA_RST0_RSV1			3
+#define MT8195_INFRA_RST0_MSDC3_SWRST		4
+#define MT8195_INFRA_RST0_MSDC2_SWRST		5
+#define MT8195_INFRA_RST0_MSDC1_SWRST		6
+#define MT8195_INFRA_RST0_MSDC0_SWRST		7
+#define MT8195_INFRA_RST0_RSV2			8
+#define MT8195_INFRA_RST0_AP_DMA_SWRST		9
+#define MT8195_INFRA_RST0_MIPI_D_SWRST		10
+#define MT8195_INFRA_RST0_RSV3			11
+#define MT8195_INFRA_RST0_RSV4			12
+#define MT8195_INFRA_RST0_SSUSB_TOP_SWRST	13
+#define MT8195_INFRA_RST0_DISP_PWM_SWRST	14
+#define MT8195_INFRA_RST0_AUXADC_SWRST		15
+#define MT8195_INFRA_RST0_RSV5			16
+#define MT8195_INFRA_RST0_RSV6			17
+#define MT8195_INFRA_RST0_RSV7			18
+#define MT8195_INFRA_RST0_RSV8			19
+#define MT8195_INFRA_RST0_RSV9			20
+#define MT8195_INFRA_RST0_RSV10			21
+#define MT8195_INFRA_RST0_RSV11			22
+#define MT8195_INFRA_RST0_RSV12			23
+#define MT8195_INFRA_RST0_RSV13			24
+#define MT8195_INFRA_RST0_RSV14			25
+#define MT8195_INFRA_RST0_RSV15			26
+#define MT8195_INFRA_RST0_RSV16			27
+#define MT8195_INFRA_RST0_RSV17			28
+#define MT8195_INFRA_RST0_RSV18			29
+#define MT8195_INFRA_RST0_RSV19			30
+#define MT8195_INFRA_RST0_RSV20			31
+
+/* INFRA RST1 */
+#define MT8195_INFRA_RST1_IRTX_SWRST	32
+#define MT8195_INFRA_RST1_SPI0_SWRST	33
+#define MT8195_INFRA_RST1_I2C0_SWRST	34
+#define MT8195_INFRA_RST1_RSV0		35
+#define MT8195_INFRA_RST1_RSV1		36
+#define MT8195_INFRA_RST1_RSV2		37
+#define MT8195_INFRA_RST1_UART0_SWRST	38
+#define MT8195_INFRA_RST1_UART1_SWRST	39
+#define MT8195_INFRA_RST1_UART2_SWRST	40
+#define MT8195_INFRA_RST1_RSV3		41
+#define MT8195_INFRA_RST1_SPI1_SWRST	42
+#define MT8195_INFRA_RST1_RSV4		43
+#define MT8195_INFRA_RST1_RSV5		44
+#define MT8195_INFRA_RST1_SPI2_SWRST	45
+#define MT8195_INFRA_RST1_SPI3_SWRST	46
+#define MT8195_INFRA_RST1_UFSHCI_SWRST	47
+#define MT8195_INFRA_RST1_RSV6		48
+#define MT8195_INFRA_RST1_RSV7		49
+#define MT8195_INFRA_RST1_RSV8		50
+#define MT8195_INFRA_RST1_RSV9		51
+#define MT8195_INFRA_RST1_RSV10		52
+#define MT8195_INFRA_RST1_RSV11		53
+#define MT8195_INFRA_RST1_RSV12		54
+#define MT8195_INFRA_RST1_RSV13		55
+#define MT8195_INFRA_RST1_RSV14		56
+#define MT8195_INFRA_RST1_RSV15		57
+#define MT8195_INFRA_RST1_RSV16		58
+#define MT8195_INFRA_RST1_RSV17		59
+#define MT8195_INFRA_RST1_RSV18		60
+#define MT8195_INFRA_RST1_RSV19		61
+#define MT8195_INFRA_RST1_RSV20		62
+#define MT8195_INFRA_RST1_RSV21		63
+
+/* INFRA RST2 */
+#define MT8195_INFRA_RST2_PMIF_SPI_SWRST	64
+#define MT8195_INFRA_RST2_SPM_SWRST		65
+#define MT8195_INFRA_RST2_USBSIF_SWRST		66
+#define MT8195_INFRA_RST2_RSV0			67
+#define MT8195_INFRA_RST2_KP_SWRST		68
+#define MT8195_INFRA_RST2_APXGPT_SWRST		69
+#define MT8195_INFRA_RST2_RSV1			70
+#define MT8195_INFRA_RST2_UNIPRO_UFS_AO_SWRST	71
+#define MT8195_INFRA_RST2_DX_CC_AO_SWRST	72
+#define MT8195_INFRA_RST2_UFSPHY_AO_SWRST	73
+#define MT8195_INFRA_RST2_RSV2			74
+#define MT8195_INFRA_RST2_INFRACFG_AO_MEM_SWRST	75
+#define MT8195_INFRA_RST2_PWM_AO_SWRST		76
+#define MT8195_INFRA_RST2_TIA_AO_SWRST		77
+#define MT8195_INFRA_RST2_PMIF_SPMI_SWRST	78
+#define MT8195_INFRA_RST2_SSUSB_TOP_P1_SWRST	79
+#define MT8195_INFRA_RST2_SSUSB_TOP_P2_SWRST	80
+#define MT8195_INFRA_RST2_SSUSB_TOP_P3_SWRST	81
+#define MT8195_INFRA_RST2_USBSIF_P1_SWRST	82
+#define MT8195_INFRA_RST2_USBSIF_P2_SWRST	83
+#define MT8195_INFRA_RST2_USBSIF_P3_SWRST	84
+#define MT8195_INFRA_RST2_RX_HDMI_SCDC_AO_SWRST	85
+#define MT8195_INFRA_RST2_EDID_TOP_SWRST	86
+#define MT8195_INFRA_RST2_CEC_AO_SWRST		87
+#define MT8195_INFRA_RST2_IRRX_AO_SWRST		88
+#define MT8195_INFRA_RST2_ETHERNET_QOS_SWRST	89
+#define MT8195_INFRA_RST2_PCIE_P0_SWRST		90
+#define MT8195_INFRA_RST2_PCIE_P1_SWRST		91
+#define MT8195_INFRA_RST2_RSV3			92
+#define MT8195_INFRA_RST2_RSV4			93
+#define MT8195_INFRA_RST2_RSV5			94
+#define MT8195_INFRA_RST2_RSV6			95
+
+/* INFRA RST3 */
+#define MT8195_INFRA_RST3_RSV0					96
+#define MT8195_INFRA_RST3_GCE_SWRST				97
+#define MT8195_INFRA_RST3_RSV1					98
+#define MT8195_INFRA_RST3_RSV2					99
+#define MT8195_INFRA_RST3_RSV3					100
+#define MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST			101
+#define MT8195_INFRA_RST3_RSV4					102
+#define MT8195_INFRA_RST3_RSV5					103
+#define MT8195_INFRA_RST3_RSV6					104
+#define MT8195_INFRA_RST3_RSV7					105
+#define MT8195_INFRA_RST3_RSV8					106
+#define MT8195_INFRA_RST3_RSV9					107
+#define MT8195_INFRA_RST3_RSV10					108
+#define MT8195_INFRA_RST3_TRNG_SWRST				109
+#define MT8195_INFRA_RST3_ECC_SWRST				110
+#define MT8195_INFRA_RST3_GCPU_SWRST				111
+#define MT8195_INFRA_RST3_SPI4_SWRST				112
+#define MT8195_INFRA_RST3_SPI5_SWRST				113
+#define MT8195_INFRA_RST3_INFRA2MFGAXI_GALS_IN_SWRST		114
+#define MT8195_INFRA_RST3_MFGAXI2INFRA_M0_GALS_OUT_SWRST	115
+#define MT8195_INFRA_RST3_MFGAXI2INFRA_M1_GALS_OUT_SWRST	116
+#define MT8195_INFRA_RST3_UFS_AES_SWRST				117
+#define MT8195_INFRA_RST3_RSV11					118
+#define MT8195_INFRA_RST3_RSV12					119
+#define MT8195_INFRA_RST3_RSV13					120
+#define MT8195_INFRA_RST3_CCU_GALS_SWRST			121
+#define MT8195_INFRA_RST3_RSV14					122
+#define MT8195_INFRA_RST3_RSV15					123
+#define MT8195_INFRA_RST3_INFRA2NNA1_SWRST			124
+#define MT8195_INFRA_RST3_INFRA2NNA0_SWRST			125
+#define MT8195_INFRA_RST3_RSV16					126
+#define MT8195_INFRA_RST3_RSV17					127
+
+/* INFRA RST4 */
+#define MT8195_INFRA_RST4_RSV0				128
+#define MT8195_INFRA_RST4_RSV1				129
+#define MT8195_INFRA_RST4_FLASHIF_SWRST			130
+#define MT8195_INFRA_RST4_NFI_SWRST			131
+#define MT8195_INFRA_RST4_APU0_CBIP_GALS_S_SWRST	132
+#define MT8195_INFRA_RST4_APU1_CBIP_GALS_S_SWRST	133
+#define MT8195_INFRA_RST4_INFRA2MMSRAM_GALS_M_SWRST	134
+#define MT8195_INFRA_RST4_RSV2				135
+#define MT8195_INFRA_RST4_SPIS0_SWRST			136
+#define MT8195_INFRA_RST4_THERM_CTRL_PTP_MCU_SWRST	137
+#define MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST		138
+#define MT8195_INFRA_RST4_RSV3				139
+#define MT8195_INFRA_RST4_RSV4				140
+#define MT8195_INFRA_RST4_RSV5				141
+#define MT8195_INFRA_RST4_RSV6				142
+#define MT8195_INFRA_RST4_SPIS1_SWRST			143
+#define MT8195_INFRA_RST4_INFRA2APU_APB_TX_SWRST	144
+#define MT8195_INFRA_RST4_APU2INFRA_APB_RX_SWRST	145
+#define MT8195_INFRA_RST4_INFRA2DRAMC_APB_TX_SWRST	146
+#define MT8195_INFRA_RST4_INFRA2SUBINFRA_APB_TX_SWRST	147
+#define MT8195_INFRA_RST4_GCE1_SWRST			148
+#define MT8195_INFRA_RST4_RSV7				149
+#define MT8195_INFRA_RST4_RSV8				150
+#define MT8195_INFRA_RST4_RSV9				151
+#define MT8195_INFRA_RST4_UART3_SWRST			152
+#define MT8195_INFRA_RST4_UART4_SWRST			153
+#define MT8195_INFRA_RST4_UART5_SWRST			154
+#define MT8195_INFRA_RST4_I2S_DMA_SWRST			155
+#define MT8195_INFRA_RST4_INFRA2NNA_APB_TX_SWRST	156
+#define MT8195_INFRA_RST4_NNA0AXI2INFRA_GALS_S_SWRST	157
+#define MT8195_INFRA_RST4_NNA1AXI2INFRA_GALS_S_SWRST	158
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8195 */
-- 
2.18.0

