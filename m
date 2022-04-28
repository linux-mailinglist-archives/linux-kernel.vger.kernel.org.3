Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9251331D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbiD1MAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbiD1L7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFD88B19;
        Thu, 28 Apr 2022 04:56:31 -0700 (PDT)
X-UUID: 0c6eb5e4237e439ea88b70c2c86104cb-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:5671ae64-bad8-44cf-9245-9c46768bf604,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:8365d4c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 0c6eb5e4237e439ea88b70c2c86104cb-20220428
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2134097992; Thu, 28 Apr 2022 19:56:24 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 19:56:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 19:56:24 +0800
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
Subject: [PATCH V5 13/16] dt-bindings: reset: mediatek: Add infra_ao reset bit for MT8192
Date:   Thu, 28 Apr 2022 19:56:16 +0800
Message-ID: <20220428115620.13512-14-rex-bc.chen@mediatek.com>
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

To support reset of infra_ao, add the bit definitions for MT8192.
There are 5 banks for infra reset and 32 bits for each bank.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 include/dt-bindings/reset/mt8192-resets.h | 163 ++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
index be9a7ca245b9..5863d138568a 100644
--- a/include/dt-bindings/reset/mt8192-resets.h
+++ b/include/dt-bindings/reset/mt8192-resets.h
@@ -7,6 +7,7 @@
 #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8192
 #define _DT_BINDINGS_RESET_CONTROLLER_MT8192
 
+/* TOPRGU resets */
 #define MT8192_TOPRGU_MM_SW_RST					1
 #define MT8192_TOPRGU_MFG_SW_RST				2
 #define MT8192_TOPRGU_VENC_SW_RST				3
@@ -27,4 +28,166 @@
 
 #define MT8192_TOPRGU_SW_RST_NUM				23
 
+/* INFRA RST0 */
+#define MT8192_INFRA_RST0_THERM_CTRL_SWRST	0
+#define MT8192_INFRA_RST0_USB_TOP_SWRST		1
+#define MT8192_INFRA_RST0_AP_MD_CCIF_4_SWRST	2
+#define MT8192_INFRA_RST0_MM_IOMMU_SWRST	3
+#define MT8192_INFRA_RST0_MSDC3_SWRST		4
+#define MT8192_INFRA_RST0_MSDC2_SWRST		5
+#define MT8192_INFRA_RST0_MSDC1_SWRST		6
+#define MT8192_INFRA_RST0_MSDC0_SWRST		7
+#define MT8192_INFRA_RST0_AP_DMA_SWRST		8
+#define MT8192_INFRA_RST0_MIPI_D_SWRST		9
+#define MT8192_INFRA_RST0_MIPI_C_SWRST		10
+#define MT8192_INFRA_RST0_BTIF_SWRST		11
+#define MT8192_INFRA_RST0_SSUSB_TOP_SWRST	12
+#define MT8192_INFRA_RST0_DISP_PWM_SWRST	13
+#define MT8192_INFRA_RST0_AUXADC_SWRST		14
+#define MT8192_INFRA_RST0_RSV0			15
+#define MT8192_INFRA_RST0_RSV1			16
+#define MT8192_INFRA_RST0_RSV2			17
+#define MT8192_INFRA_RST0_RSV3			18
+#define MT8192_INFRA_RST0_RSV4			19
+#define MT8192_INFRA_RST0_RSV5			20
+#define MT8192_INFRA_RST0_RSV6			21
+#define MT8192_INFRA_RST0_RSV7			22
+#define MT8192_INFRA_RST0_RSV8			23
+#define MT8192_INFRA_RST0_RSV9			24
+#define MT8192_INFRA_RST0_RSV10			25
+#define MT8192_INFRA_RST0_RSV11			26
+#define MT8192_INFRA_RST0_RSV12			27
+#define MT8192_INFRA_RST0_RSV13			28
+#define MT8192_INFRA_RST0_RSV14			29
+#define MT8192_INFRA_RST0_RSV15			30
+#define MT8192_INFRA_RST0_RSV16			31
+
+/* INFRA RST1 */
+#define MT8192_INFRA_RST1_IRTX_SWRST	32
+#define MT8192_INFRA_RST1_SPI0_SWRST	33
+#define MT8192_INFRA_RST1_I2C0_SWRST	34
+#define MT8192_INFRA_RST1_I2C1_SWRST	35
+#define MT8192_INFRA_RST1_I2C2_SWRST	36
+#define MT8192_INFRA_RST1_I2C3_SWRST	37
+#define MT8192_INFRA_RST1_UART0_SWRST	38
+#define MT8192_INFRA_RST1_UART1_SWRST	39
+#define MT8192_INFRA_RST1_UART2_SWRST	40
+#define MT8192_INFRA_RST1_PWM_SWRST	41
+#define MT8192_INFRA_RST1_SPI1_SWRST	42
+#define MT8192_INFRA_RST1_I2C4_SWRST	43
+#define MT8192_INFRA_RST1_DVFSP_SWRST	44
+#define MT8192_INFRA_RST1_SPI2_SWRST	45
+#define MT8192_INFRA_RST1_SPI3_SWRST	46
+#define MT8192_INFRA_RST1_UFSHCI_SWRST	47
+#define MT8192_INFRA_RST1_RSV0		48
+#define MT8192_INFRA_RST1_RSV1		49
+#define MT8192_INFRA_RST1_RSV2		50
+#define MT8192_INFRA_RST1_RSV3		51
+#define MT8192_INFRA_RST1_RSV4		52
+#define MT8192_INFRA_RST1_RSV5		53
+#define MT8192_INFRA_RST1_RSV6		54
+#define MT8192_INFRA_RST1_RSV7		55
+#define MT8192_INFRA_RST1_RSV8		56
+#define MT8192_INFRA_RST1_RSV9		57
+#define MT8192_INFRA_RST1_RSV10		58
+#define MT8192_INFRA_RST1_RSV11		59
+#define MT8192_INFRA_RST1_RSV12		60
+#define MT8192_INFRA_RST1_RSV13		61
+#define MT8192_INFRA_RST1_RSV14		62
+#define MT8192_INFRA_RST1_RSV15		63
+
+/* INFRA RST2 */
+#define MT8192_INFRA_RST2_PMIC_WRAP_SWRST	64
+#define MT8192_INFRA_RST2_SPM_SWRST		65
+#define MT8192_INFRA_RST2_USBSIF_SWRST		66
+#define MT8192_INFRA_RST2_RSV0			67
+#define MT8192_INFRA_RST2_KP_SWRST		68
+#define MT8192_INFRA_RST2_APXGPT_SWRST		69
+#define MT8192_INFRA_RST2_CLDMA_AO_SWRST	70
+#define MT8192_INFRA_RST2_UNIPRO_UFS_AO_SWRST	71
+#define MT8192_INFRA_RST2_DX_CC_AO_SWRST	72
+#define MT8192_INFRA_RST2_UFSPHY_AO_SWRST	73
+#define MT8192_INFRA_RST2_RSV1			74
+#define MT8192_INFRA_RST2_INFRACFG_AO_MEM_SWRST	75
+#define MT8192_INFRA_RST2_PWM_AO_SWRST		76
+#define MT8192_INFRA_RST2_TIA_AO_SWRST		77
+#define MT8192_INFRA_RST2_PMIFSPMI_SWRST	78
+#define MT8192_INFRA_RST2_PEXTP_PHY_SWRST	79
+#define MT8192_INFRA_RST2_RSV2			80
+#define MT8192_INFRA_RST2_RSV3			81
+#define MT8192_INFRA_RST2_RSV4			82
+#define MT8192_INFRA_RST2_RSV5			83
+#define MT8192_INFRA_RST2_RSV6			84
+#define MT8192_INFRA_RST2_RSV7			85
+#define MT8192_INFRA_RST2_RSV8			86
+#define MT8192_INFRA_RST2_RSV9			87
+#define MT8192_INFRA_RST2_RSV10			88
+#define MT8192_INFRA_RST2_RSV11			89
+#define MT8192_INFRA_RST2_RSV12			90
+#define MT8192_INFRA_RST2_RSV13			91
+#define MT8192_INFRA_RST2_RSV14			92
+#define MT8192_INFRA_RST2_RSV15			93
+#define MT8192_INFRA_RST2_RSV16			94
+#define MT8192_INFRA_RST2_RSV17			95
+
+/* INFRA RST3 */
+#define MT8192_INFRA_RST3_DX_CC_SEC_SWRST	96
+#define MT8192_INFRA_RST3_GCE_SWRST		97
+#define MT8192_INFRA_RST3_CLDMA_SWRST		98
+#define MT8192_INFRA_RST3_TRNG_SWRST		99
+#define MT8192_INFRA_RST3_MFG_CBIP_P2P_TX_SWRST	100
+#define MT8192_INFRA_RST3_THERM_CTRL_PTP_SWRST	101
+#define MT8192_INFRA_RST3_RSV0			102
+#define MT8192_INFRA_RST3_AP_MD_CCIF_1_SWRST	103
+#define MT8192_INFRA_RST3_AP_MD_CCIF_SWRST	104
+#define MT8192_INFRA_RST3_I2C1_IMM_SWRST	105
+#define MT8192_INFRA_RST3_I2C1_ARB_SWRST	106
+#define MT8192_INFRA_RST3_I2C2_IMM_SWRST	107
+#define MT8192_INFRA_RST3_I2C2_ARB_SWRST	108
+#define MT8192_INFRA_RST3_I2C5_SWRST		109
+#define MT8192_INFRA_RST3_I2C5_IMM_SWRST	110
+#define MT8192_INFRA_RST3_I2C5_ARB_SWRST	111
+#define MT8192_INFRA_RST3_SPI4_SWRST		112
+#define MT8192_INFRA_RST3_SPI5_SWRST		113
+#define MT8192_INFRA_RST3_INFRA2MFGAXI_CBIP_GLAS_IN_SWRST_B	114
+#define MT8192_INFRA_RST3_MFGAXI2INFRA_M0_CBIP_GLAS_OUT_SWRST_B	115
+#define MT8192_INFRA_RST3_MFGAXI2INFRA_M1_CBIP_GLAS_OUT_SWRST_B	116
+#define MT8192_INFRA_RST3_UFS_AES_SWRST		117
+#define MT8192_INFRA_RST3_CCU_I2C_IRQ_SWRST	118
+#define MT8192_INFRA_RST3_CCU_I2C_DMA_SWRST	119
+#define MT8192_INFRA_RST3_I2C6_SWRST		120
+#define MT8192_INFRA_RST3_CCU_GALS_SWRST	121
+#define MT8192_INFRA_RST3_IPU_GALS_SWRST	122
+#define MT8192_INFRA_RST3_CONN2AP_GALS_SWRST	123
+#define MT8192_INFRA_RST3_AP_MD_CCIF2_SWRST	124
+#define MT8192_INFRA_RST3_AP_MD_CCIF3_SWRST	125
+#define MT8192_INFRA_RST3_I2C7_SWRST		126
+#define MT8192_INFRA_RST3_I2C8_SWRST		127
+
+/* INFRA RST4 */
+#define MT8192_INFRA_RST4_FLASHIF_TOP_SWRST			128
+#define MT8192_INFRA_RST4_PCIE_TOP_SWRST			129
+#define MT8192_INFRA_RST4_AXI2ACP_SWRST				130
+#define MT8192_INFRA_RST4_VPU_IOMMU_SWRST			131
+#define MT8192_INFRA_RST4_SPI6_SWRST				132
+#define MT8192_INFRA_RST4_SPI7_SWRST				133
+#define MT8192_INFRA_RST4_APU0_GALS_SWRST			134
+#define MT8192_INFRA_RST4_APU1_GALS_SWRST			135
+#define MT8192_INFRA_RST4_XPU2APU_SWRST				136
+#define MT8192_INFRA_RST4_MCUPM_SWRST				137
+#define MT8192_INFRA_RST4_TIA_SWRST				138
+#define MT8192_INFRA_RST4_THERM_CTRL_PTP_MCU_SWRST		139
+#define MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST			140
+#define MT8192_INFRA_RST4_MD2AP_GALS_OUT_SWRST			141
+#define MT8192_INFRA_RST4_AP2MP_GALS_IN_SWRST			142
+#define MT8192_INFRA_RST4_MDHW2EMI_GALS_OUT_SWRST		143
+#define MT8192_INFRA_RST4_MDMCU2EMI_GALS_OUT_SWRST		144
+#define MT8192_INFRA_RST4_CCIF_MD2CONN_BGF_SWRST		145
+#define MT8192_INFRA_RST4_INFRA2APU_APB_TX_SWRST		146
+#define MT8192_INFRA_RST4_APU2INFRA_APB_RX_SWRST		147
+#define MT8192_INFRA_RST4_DFD_ISO1_INFRA2DRAMC_APB_TX_SWRST	148
+#define MT8192_INFRA_RST4_INFRA2SUBINFRA_APB_TX_SWRST		149
+#define MT8192_INFRA_RST4_MDP_GCE_SWRST				150
+#define MT8192_INFRA_RST4_MSDC2INFRA_CBIP_GALS_OUT_SWRST	151
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
-- 
2.18.0

