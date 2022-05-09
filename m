Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C57D51F5C5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiEIHd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbiEIHdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:33:10 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03on0601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe09::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C4C03;
        Mon,  9 May 2022 00:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEn1RMsF22juwXbQVC625Q6DIKcLQh03VewF9IHnBugUev2t+rZTB3dwaz4T9+aXG4pPMlv7+L9SR1k5LaTJXjAoFjG2yH1Ay22Hnh0vg5VnmMi429/cjCOAE1NOko9/KzbQFFYT7ECEX5o02SeZ7xzaJCgPSJ8owXA8XqDmTkxUrBi2pNSbUlUhCT1y1BYCPUwHqk6PeFNbz+EMGaNS9jMEMFuZ0XicLXp3CSG8d4gBSeaRem8v8g4FEbK9flfA1ILBC1WPfZVEVFDS/V9BEl9knjpB2K+SVaCvNqnBhVRuypKoGOXB6vJqu1yPcea+Nyzuexj99gWGoECIyW2laA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2p9zoNEWY14Sb+dZIjGP+B2sjZnnKlAirnmIobxoKA=;
 b=LO3AQVOoLcjOZHvZgOUYB6h1n3mCL9MeWHhQr9Ci/2RYr5QneBDqTqD/e2GmOIMR5IOM/yWRMsDWJxZEs5f3c4NAvKrmym4DHl9qbU9Cjuz5CJq68GAx4w7hSl4Ck+/32Js4D11A5I+ke5xXKlXGIwW75F1AXGrTRP2KPK08R0s5WwexQjibnun21v9Ef66KJtgIdCLesGPqu14an/290qRCugUM7iL7KSALmTNU9biJVQoV2QR0e73pTpTxiCHfeY/K5e+JEyNmyFw0F1vP/z1OWXACDlhBP1bjIZ4N40mj9d36wREgoOYwM7XRV7FtG8puCD48ZP+wrGQ2Ih2Biw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2p9zoNEWY14Sb+dZIjGP+B2sjZnnKlAirnmIobxoKA=;
 b=Id0+rLWbJu/HeBGAKu5UiZZyNMik5hjAYMVjuIqi9kmgPruafzHhmJeVh1AHga7NjSpRNzvTtfZKbhm9Flr61gkxqhSWy+t2y+GdA0xkOwMjto8nqJorZxAUZtypGrFJN1TKwUjDCEcUejoIkqjiq/5E7TlTrjTxyD6PNoFtWFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3330.eurprd04.prod.outlook.com (2603:10a6:208:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 07:27:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Mon, 9 May 2022
 07:27:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V4 2/4] arm64: dts: freescale: Add i.MX93 dtsi support
Date:   Mon,  9 May 2022 15:29:09 +0800
Message-Id: <20220509072911.3268668-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
References: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce4f60d-80cc-4919-76ad-08da318d6114
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3330:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB33307C4FE6489FCAC865CD6EC9C69@AM0PR0402MB3330.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNWFsWeR/D33iYhDT+DSb/nwry9ubVe10Lm7gx/LUJJCw7s1j5FfB4oTeMfuvcrVWWP4Z6A0lhaliM+xlMpn0NM5pk2uMSU3+PKFR3Auxn4RnYq+a5mhWgg4t0bDrrLghPFpk/7Hv3yi3vDS7JDGd1Mif8YcDC/DPnjezuthEf1L9tnbfboOoWqsQczqeRwQXCEohnD+7b/rGRUXjIwqrUYOW2eJkQ9sb6cJYw6EIxxdDKscIGJr9e9hBKUEm3dde3RSKUP/aJPXiGXd5XVmhY26DYqC/U+yaoV/25quBUdZg87wS5Npoc3Fwa4SA+nLCKooH5OrsA/nJrEf6YOAJBnyJ8aAfraQ1V0MJrrurNMfLOuhiuuwhvAmYu0p4fapHGHvGqcmlFCmjVMaS2MPEQ38KMeaGMn5/p/89GtdZLeueWqwwxEE2VbX/VvChHKBMkFEBrowE5pfi1LhvjX/2RY4Kwqt0lcz3aFuFQ3GIUkLiGWFmcOXPIXiWjfPppsVkX2Dw4UOgVCeuvjPX3Tu+tEb9P5xNcWEGnOYCF3U7R5TBC3RVBYFwbGRv/XcWdaDMY/ks9tyO2X736YgxaBB2ToAWk2/QOCrj5btHBejk50ID8mHjZZ76S3My0fNoUpRMZsgerN3FYANbBr+JZ8dSGzS85PcTCPL/Qs8YNOIfOo5N045qnNhmQAUivEN+L4jnnO/wCZL/VEGKFJE35GkhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(2906002)(6512007)(8676002)(4326008)(52116002)(8936002)(86362001)(5660300002)(7416002)(66556008)(66476007)(26005)(30864003)(2616005)(66946007)(316002)(6486002)(508600001)(38350700002)(1076003)(38100700002)(54906003)(186003)(83380400001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TxRCFrKNzDbuSQBeWL1DIrXa6F7q9GKqk4iT3QtgLzwSEyB3nexLvaNsq4i+?=
 =?us-ascii?Q?Y6A3c5M4rdj5tDyt0flqHoT6Bpc2AhZ7twCBefd6wjgTIuQf67D7ycmetaKr?=
 =?us-ascii?Q?n9YHSncPLPPN7Zbx3K9MhJ8xFQ3TCLmZozdPObwhJNC93XlA1Aj+QvOjsiMn?=
 =?us-ascii?Q?i3o8wUf3vvtsm8uF4go2A89UXzrR8oHb0ye2WpmQ4n/EwPysDOeY8lIW68Vr?=
 =?us-ascii?Q?2SXGvcOvHhFhRHUXRRvQ7oRqQTde71p054m50viDDchHfbpYm8xr7pigK58A?=
 =?us-ascii?Q?97A2vVhNZBoV1HIbr1BquCQyFF8tnvB1mWqaY0HiqjvpsgUoDnLYb7SEP1tl?=
 =?us-ascii?Q?Unty8AnH79CC969dr4ID1jQFTyTItnup6RE37PLUdViZ1XeTqBcBXb1OQ1Km?=
 =?us-ascii?Q?63xw1RORMd9B1tNTC0I3JdVfn6juW0+jKWn5It0pLrTny5qJMTvEf9ci4CP/?=
 =?us-ascii?Q?c2kWaqSZFGRYBhInlAbhnPzbNCn+up1DEWlCChZCqxLbo2cNGATH4lCXAdEU?=
 =?us-ascii?Q?AO59kcWHQwaQ51nSlFQZEPy8aHC7UfKh/fR4Zac+2Uyt04c+08VNfSag87R6?=
 =?us-ascii?Q?ZmEUPqRxSEyXffUAIZCEsW0/T/c9JVXyxWiJtZx3d1qHm5GBEeIKSb4k9wfc?=
 =?us-ascii?Q?aGS/xFOUIy64F1YhhKGdyKou+zO1mE3MPpplZbInX0nv2VqQHCxw36aCcU0w?=
 =?us-ascii?Q?OcalAKlyq5A6ql5LsIqKqGaRTt47RjBZYebRKZ5DtMqY5GSw99/K7SlVmaj2?=
 =?us-ascii?Q?7yt49ghjNKE0zyOV5pRRph/e/Vb1wai8kb/99PYZ5esqSeP/hixkKaEbjiXC?=
 =?us-ascii?Q?0KnChbjEX4C1FYrn46VZFfmFKMGz8QzQcuIYsJzHv53oTGQWohc83VaJjfnl?=
 =?us-ascii?Q?i48LLFN5EfnanfjvU2pwyPbmMFMxFBkltn0F1NG8ymxmB4tDx1Njv8T42lIa?=
 =?us-ascii?Q?noHF1XifFviBpzuVkELANlhwe+U368b9+8498tq8LwFILEwx48BOyviw4jSD?=
 =?us-ascii?Q?fEEGqWwjXnOybTDkvhFIfkY0cfKUbMGKVkwpI0W6VdeJWdVXjCdYMt8S8dpF?=
 =?us-ascii?Q?Iqgs96YoDgwcxV8XRWzlSMn2vbhl7/1c0q3xd8t5LdYR3J/HokASj+625J/e?=
 =?us-ascii?Q?ROfN/eSCmkjoyqH/kdvdUsSOEx55Yab2/0Yr8Z3Kle8cNaRf5+5ANFoCiM73?=
 =?us-ascii?Q?cxBQCMLFhtCn5p6TRy4fRvi/d5Y0bTPiS8zayVBovKstn9tsWS58e+35TcWz?=
 =?us-ascii?Q?muETMkjJJ87TpvGuaviSMtJguGGz32Lew3oIWMSHqVphlAUkZ9pdyKZTJT5d?=
 =?us-ascii?Q?rohWbTC8j5FNU3cojgbc4g9jwHBwtfNGer1Hb8iwcy4zNt3cBKH5Hhie370B?=
 =?us-ascii?Q?YBizwJGRx2NpnbcjtH92Af+EfxKATHbAfi6nt3azKrY428KzXU2nLY4/snKy?=
 =?us-ascii?Q?DKELr8FNQYvTQpvmkECdlnIiQDqJeUNyNEuFOD5DJih7WzwZwh/FvZB8vb9m?=
 =?us-ascii?Q?7tel0Gnn4xiqL2AZ1Ef3uhdQA8cC8Xf1g1iv0L6XExdloxbIExooD42NLipo?=
 =?us-ascii?Q?g4WBwCQWmw0Lw3G4KuGC274WW+Mioepq1tZq/5vIjz48el8VCkyY5Csogs9O?=
 =?us-ascii?Q?FxLPFs7537K8Y7mN0beGyqTDKt5hEzgptV77Ykn6ZL8FCc7p8W0AFMMFAJ8d?=
 =?us-ascii?Q?zF2MV4gE8I+1UeE3/ub6f4GAz5BIkBUUo1L0NEx8SFt74I5AvFcqvRC53Sl8?=
 =?us-ascii?Q?aUJVvadWFQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce4f60d-80cc-4919-76ad-08da318d6114
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:27:32.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zHkFloXDNJGM/Yc4OF+mjlgMFBSysXdAKvbpmpOqoFeAcTfwmFJ5zfHh0O4aqJB7qjdweSP4NTcksu5U2TN3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3330
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX 93 applications processors are the first in the i.MX portfolio
to integrate the scalable Arm Cortex-A55 core, bringing performance
and energy efficiency to Linux-based edge applications and the
Arm Ethos-U65 microNPU, enabling developers to create more capable,
cost-effective and energy-efficient ML applications.

Add the basic dtsi support for i.MX93.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 333 ++++++++++
 2 files changed, 956 insertions(+)
 create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx93-pinfunc.h b/arch/arm64/boot/dts/freescale/imx93-pinfunc.h
new file mode 100755
index 000000000000..4298a145f8a9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-pinfunc.h
@@ -0,0 +1,623 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright 2022 NXP
+ */
+
+#ifndef __DTS_IMX93_PINFUNC_H
+#define __DTS_IMX93_PINFUNC_H
+
+/*
+ * The pin function ID is a tuple of
+ * <mux_reg conf_reg input_reg mux_mode input_val>
+ */
+#define MX93_PAD_DAP_TDI__JTAG_MUX_TDI                            0x0000 0x01B0 0x03D8 0x0 0x0
+#define MX93_PAD_DAP_TDI__MQS2_LEFT                               0x0000 0x01B0 0x0000 0x1 0x0
+#define MX93_PAD_DAP_TDI__CAN2_TX                                 0x0000 0x01B0 0x0000 0x3 0x0
+#define MX93_PAD_DAP_TDI__FLEXIO2_FLEXIO30                        0x0000 0x01B0 0x0000 0x4 0x0
+#define MX93_PAD_DAP_TDI__GPIO3_IO28                              0x0000 0x01B0 0x0000 0x5 0x0
+#define MX93_PAD_DAP_TDI__LPUART5_RX                              0x0000 0x01B0 0x0430 0x6 0x0
+#define MX93_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS                      0x0004 0x01B4 0x03DC 0x0 0x0
+#define MX93_PAD_DAP_TMS_SWDIO__FLEXIO2_FLEXIO31                  0x0004 0x01B4 0x0000 0x4 0x0
+#define MX93_PAD_DAP_TMS_SWDIO__GPIO3_IO29                        0x0004 0x01B4 0x0000 0x5 0x0
+#define MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                     0x0004 0x01B4 0x0000 0x6 0x0
+#define MX93_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK                     0x0008 0x01B8 0x03D4 0x0 0x0
+#define MX93_PAD_DAP_TCLK_SWCLK__FLEXIO1_FLEXIO30                 0x0008 0x01B8 0x0000 0x4 0x0
+#define MX93_PAD_DAP_TCLK_SWCLK__GPIO3_IO30                       0x0008 0x01B8 0x0000 0x5 0x0
+#define MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                    0x0008 0x01B8 0x042C 0x6 0x0
+#define MX93_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO                   0x000C 0x01BC 0x0000 0x0 0x0
+#define MX93_PAD_DAP_TDO_TRACESWO__MQS2_RIGHT                     0x000C 0x01BC 0x0000 0x1 0x0
+#define MX93_PAD_DAP_TDO_TRACESWO__CAN2_RX                        0x000C 0x01BC 0x0364 0x3 0x0
+#define MX93_PAD_DAP_TDO_TRACESWO__FLEXIO1_FLEXIO31               0x000C 0x01BC 0x0000 0x4 0x0
+#define MX93_PAD_DAP_TDO_TRACESWO__GPIO3_IO31                     0x000C 0x01BC 0x0000 0x5 0x0
+#define MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX                     0x000C 0x01BC 0x0434 0x6 0x0
+#define MX93_PAD_GPIO_IO00__GPIO2_IO00                            0x0010 0x01C0 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO00__LPI2C3_SDA                            0x0010 0x01C0 0x03E4 0x11 0x0
+#define MX93_PAD_GPIO_IO00__MEDIAMIX_CAM_CLK                      0x0010 0x01C0 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK                     0x0010 0x01C0 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO00__LPSPI6_PCS0                           0x0010 0x01C0 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO00__LPUART5_TX                            0x0010 0x01C0 0x0434 0x5 0x1
+#define MX93_PAD_GPIO_IO00__LPI2C5_SDA                            0x0010 0x01C0 0x03EC 0x16 0x0
+#define MX93_PAD_GPIO_IO00__FLEXIO1_FLEXIO00                      0x0010 0x01C0 0x036C 0x7 0x0
+#define MX93_PAD_GPIO_IO01__GPIO2_IO01                            0x0014 0x01C4 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO01__LPI2C3_SCL                            0x0014 0x01C4 0x03E0 0x11 0x0
+#define MX93_PAD_GPIO_IO01__MEDIAMIX_CAM_DATA00                   0x0014 0x01C4 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO01__MEDIAMIX_DISP_DE                      0x0014 0x01C4 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO01__LPSPI6_SIN                            0x0014 0x01C4 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO01__LPUART5_RX                            0x0014 0x01C4 0x0430 0x5 0x1
+#define MX93_PAD_GPIO_IO01__LPI2C5_SCL                            0x0014 0x01C4 0x03E8 0x16 0x0
+#define MX93_PAD_GPIO_IO01__FLEXIO1_FLEXIO01                      0x0014 0x01C4 0x0370 0x7 0x0
+#define MX93_PAD_GPIO_IO02__GPIO2_IO02                            0x0018 0x01C8 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO02__LPI2C4_SDA                            0x0018 0x01C8 0x0000 0x11 0x0
+#define MX93_PAD_GPIO_IO02__MEDIAMIX_CAM_VSYNC                    0x0018 0x01C8 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC                   0x0018 0x01C8 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO02__LPSPI6_SOUT                           0x0018 0x01C8 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO02__LPUART5_CTS_B                         0x0018 0x01C8 0x042C 0x5 0x1
+#define MX93_PAD_GPIO_IO02__LPI2C6_SDA                            0x0018 0x01C8 0x03F4 0x16 0x0
+#define MX93_PAD_GPIO_IO02__FLEXIO1_FLEXIO02                      0x0018 0x01C8 0x0374 0x7 0x0
+#define MX93_PAD_GPIO_IO03__GPIO2_IO03                            0x001C 0x01CC 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO03__LPI2C4_SCL                            0x001C 0x01CC 0x0000 0x11 0x0
+#define MX93_PAD_GPIO_IO03__MEDIAMIX_CAM_HSYNC                    0x001C 0x01CC 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC                   0x001C 0x01CC 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO03__LPSPI6_SCK                            0x001C 0x01CC 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO03__LPUART5_RTS_B                         0x001C 0x01CC 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO03__LPI2C6_SCL                            0x001C 0x01CC 0x03F0 0x16 0x0
+#define MX93_PAD_GPIO_IO03__FLEXIO1_FLEXIO03                      0x001C 0x01CC 0x0378 0x7 0x0
+#define MX93_PAD_GPIO_IO04__GPIO2_IO04                            0x0020 0x01D0 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO04__TPM3_CH0                              0x0020 0x01D0 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO04__PDM_CLK                               0x0020 0x01D0 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA00                  0x0020 0x01D0 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO04__LPSPI7_PCS0                           0x0020 0x01D0 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO04__LPUART6_TX                            0x0020 0x01D0 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO04__LPI2C6_SDA                            0x0020 0x01D0 0x03F4 0x16 0x1
+#define MX93_PAD_GPIO_IO04__FLEXIO1_FLEXIO04                      0x0020 0x01D0 0x037C 0x7 0x0
+#define MX93_PAD_GPIO_IO05__GPIO2_IO05                            0x0024 0x01D4 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO05__TPM4_CH0                              0x0024 0x01D4 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO05__PDM_BIT_STREAM00                      0x0024 0x01D4 0x0438 0x2 0x0
+#define MX93_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA01                  0x0024 0x01D4 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO05__LPSPI7_SIN                            0x0024 0x01D4 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO05__LPUART6_RX                            0x0024 0x01D4 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO05__LPI2C6_SCL                            0x0024 0x01D4 0x03F0 0x16 0x1
+#define MX93_PAD_GPIO_IO05__FLEXIO1_FLEXIO05                      0x0024 0x01D4 0x0380 0x7 0x0
+#define MX93_PAD_GPIO_IO06__GPIO2_IO06                            0x0028 0x01D8 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO06__TPM5_CH0                              0x0028 0x01D8 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO06__PDM_BIT_STREAM01                      0x0028 0x01D8 0x043C 0x2 0x0
+#define MX93_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA02                  0x0028 0x01D8 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO06__LPSPI7_SOUT                           0x0028 0x01D8 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO06__LPUART6_CTS_B                         0x0028 0x01D8 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO06__LPI2C7_SDA                            0x0028 0x01D8 0x03FC 0x16 0x0
+#define MX93_PAD_GPIO_IO06__FLEXIO1_FLEXIO06                      0x0028 0x01D8 0x0384 0x7 0x0
+#define MX93_PAD_GPIO_IO07__GPIO2_IO07                            0x002C 0x01DC 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO07__LPSPI3_PCS1                           0x002C 0x01DC 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO07__MEDIAMIX_CAM_DATA01                   0x002C 0x01DC 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA03                  0x002C 0x01DC 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO07__LPSPI7_SCK                            0x002C 0x01DC 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO07__LPUART6_RTS_B                         0x002C 0x01DC 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO07__LPI2C7_SCL                            0x002C 0x01DC 0x03F8 0x16 0x0
+#define MX93_PAD_GPIO_IO07__FLEXIO1_FLEXIO07                      0x002C 0x01DC 0x0388 0x7 0x0
+#define MX93_PAD_GPIO_IO08__GPIO2_IO08                            0x0030 0x01E0 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO08__LPSPI3_PCS0                           0x0030 0x01E0 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO08__MEDIAMIX_CAM_DATA02                   0x0030 0x01E0 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA04                  0x0030 0x01E0 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO08__TPM6_CH0                              0x0030 0x01E0 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO08__LPUART7_TX                            0x0030 0x01E0 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO08__LPI2C7_SDA                            0x0030 0x01E0 0x03FC 0x16 0x1
+#define MX93_PAD_GPIO_IO08__FLEXIO1_FLEXIO08                      0x0030 0x01E0 0x038C 0x7 0x0
+#define MX93_PAD_GPIO_IO09__GPIO2_IO09                            0x0034 0x01E4 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO09__LPSPI3_SIN                            0x0034 0x01E4 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO09__MEDIAMIX_CAM_DATA03                   0x0034 0x01E4 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA05                  0x0034 0x01E4 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO09__TPM3_EXTCLK                           0x0034 0x01E4 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO09__LPUART7_RX                            0x0034 0x01E4 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO09__LPI2C7_SCL                            0x0034 0x01E4 0x03F8 0x16 0x1
+#define MX93_PAD_GPIO_IO09__FLEXIO1_FLEXIO09                      0x0034 0x01E4 0x0390 0x7 0x0
+#define MX93_PAD_GPIO_IO10__GPIO2_IO10                            0x0038 0x01E8 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO10__LPSPI3_SOUT                           0x0038 0x01E8 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO10__MEDIAMIX_CAM_DATA04                   0x0038 0x01E8 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA06                  0x0038 0x01E8 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO10__TPM4_EXTCLK                           0x0038 0x01E8 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO10__LPUART7_CTS_B                         0x0038 0x01E8 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO10__LPI2C8_SDA                            0x0038 0x01E8 0x0404 0x16 0x0
+#define MX93_PAD_GPIO_IO10__FLEXIO1_FLEXIO10                      0x0038 0x01E8 0x0394 0x7 0x0
+#define MX93_PAD_GPIO_IO11__GPIO2_IO11                            0x003C 0x01EC 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO11__LPSPI3_SCK                            0x003C 0x01EC 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO11__MEDIAMIX_CAM_DATA05                   0x003C 0x01EC 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA07                  0x003C 0x01EC 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO11__TPM5_EXTCLK                           0x003C 0x01EC 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO11__LPUART7_RTS_B                         0x003C 0x01EC 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO11__LPI2C8_SCL                            0x003C 0x01EC 0x0400 0x16 0x0
+#define MX93_PAD_GPIO_IO11__FLEXIO1_FLEXIO11                      0x003C 0x01EC 0x0398 0x7 0x0
+#define MX93_PAD_GPIO_IO12__GPIO2_IO12                            0x0040 0x01F0 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO12__TPM3_CH2                              0x0040 0x01F0 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO12__PDM_BIT_STREAM02                      0x0040 0x01F0 0x0440 0x2 0x0
+#define MX93_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA08                  0x0040 0x01F0 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO12__LPSPI8_PCS0                           0x0040 0x01F0 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO12__LPUART8_TX                            0x0040 0x01F0 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO12__LPI2C8_SDA                            0x0040 0x01F0 0x0404 0x16 0x1
+#define MX93_PAD_GPIO_IO12__SAI3_RX_SYNC                          0x0040 0x01F0 0x0450 0x7 0x0
+#define MX93_PAD_GPIO_IO13__GPIO2_IO13                            0x0044 0x01F4 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO13__TPM4_CH2                              0x0044 0x01F4 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO13__PDM_BIT_STREAM03                      0x0044 0x01F4 0x0444 0x2 0x0
+#define MX93_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA09                  0x0044 0x01F4 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO13__LPSPI8_SIN                            0x0044 0x01F4 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO13__LPUART8_RX                            0x0044 0x01F4 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO13__LPI2C8_SCL                            0x0044 0x01F4 0x0400 0x16 0x1
+#define MX93_PAD_GPIO_IO13__FLEXIO1_FLEXIO13                      0x0044 0x01F4 0x039C 0x7 0x0
+#define MX93_PAD_GPIO_IO14__GPIO2_IO14                            0x0048 0x01F8 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO14__LPUART3_TX                            0x0048 0x01F8 0x041C 0x1 0x0
+#define MX93_PAD_GPIO_IO14__MEDIAMIX_CAM_DATA06                   0x0048 0x01F8 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10                  0x0048 0x01F8 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO14__LPSPI8_SOUT                           0x0048 0x01F8 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO14__LPUART8_CTS_B                         0x0048 0x01F8 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO14__LPUART4_TX                            0x0048 0x01F8 0x0428 0x6 0x0
+#define MX93_PAD_GPIO_IO14__FLEXIO1_FLEXIO14                      0x0048 0x01F8 0x03A0 0x7 0x0
+#define MX93_PAD_GPIO_IO15__GPIO2_IO15                            0x004C 0x01FC 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO15__LPUART3_RX                            0x004C 0x01FC 0x0418 0x1 0x0
+#define MX93_PAD_GPIO_IO15__MEDIAMIX_CAM_DATA07                   0x004C 0x01FC 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11                  0x004C 0x01FC 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO15__LPSPI8_SCK                            0x004C 0x01FC 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO15__LPUART8_RTS_B                         0x004C 0x01FC 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO15__LPUART4_RX                            0x004C 0x01FC 0x0424 0x6 0x0
+#define MX93_PAD_GPIO_IO15__FLEXIO1_FLEXIO15                      0x004C 0x01FC 0x03A4 0x7 0x0
+#define MX93_PAD_GPIO_IO16__GPIO2_IO16                            0x0050 0x0200 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO16__SAI3_TX_BCLK                          0x0050 0x0200 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO16__PDM_BIT_STREAM02                      0x0050 0x0200 0x0440 0x2 0x1
+#define MX93_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12                  0x0050 0x0200 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO16__LPUART3_CTS_B                         0x0050 0x0200 0x0414 0x4 0x0
+#define MX93_PAD_GPIO_IO16__LPSPI4_PCS2                           0x0050 0x0200 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO16__LPUART4_CTS_B                         0x0050 0x0200 0x0420 0x6 0x0
+#define MX93_PAD_GPIO_IO16__FLEXIO1_FLEXIO16                      0x0050 0x0200 0x03A8 0x7 0x0
+#define MX93_PAD_GPIO_IO17__GPIO2_IO17                            0x0054 0x0204 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO17__SAI3_MCLK                             0x0054 0x0204 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO17__MEDIAMIX_CAM_DATA08                   0x0054 0x0204 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13                  0x0054 0x0204 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO17__LPUART3_RTS_B                         0x0054 0x0204 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO17__LPSPI4_PCS1                           0x0054 0x0204 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO17__LPUART4_RTS_B                         0x0054 0x0204 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO17__FLEXIO1_FLEXIO17                      0x0054 0x0204 0x03AC 0x7 0x0
+#define MX93_PAD_GPIO_IO18__GPIO2_IO18                            0x0058 0x0208 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO18__SAI3_RX_BCLK                          0x0058 0x0208 0x044C 0x1 0x0
+#define MX93_PAD_GPIO_IO18__MEDIAMIX_CAM_DATA09                   0x0058 0x0208 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14                  0x0058 0x0208 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO18__LPSPI5_PCS0                           0x0058 0x0208 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO18__LPSPI4_PCS0                           0x0058 0x0208 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO18__TPM5_CH2                              0x0058 0x0208 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO18__FLEXIO1_FLEXIO18                      0x0058 0x0208 0x03B0 0x7 0x0
+#define MX93_PAD_GPIO_IO19__GPIO2_IO19                            0x005C 0x020C 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO19__SAI3_RX_SYNC                          0x005C 0x020C 0x0450 0x1 0x1
+#define MX93_PAD_GPIO_IO19__PDM_BIT_STREAM03                      0x005C 0x020C 0x0444 0x2 0x1
+#define MX93_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15                  0x005C 0x020C 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO19__LPSPI5_SIN                            0x005C 0x020C 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO19__LPSPI4_SIN                            0x005C 0x020C 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO19__TPM6_CH2                              0x005C 0x020C 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO19__SAI3_TX_DATA00                        0x005C 0x020C 0x0000 0x7 0x0
+#define MX93_PAD_GPIO_IO20__GPIO2_IO20                            0x0060 0x0210 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO20__SAI3_RX_DATA00                        0x0060 0x0210 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO20__PDM_BIT_STREAM00                      0x0060 0x0210 0x0438 0x2 0x1
+#define MX93_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16                  0x0060 0x0210 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO20__LPSPI5_SOUT                           0x0060 0x0210 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO20__LPSPI4_SOUT                           0x0060 0x0210 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO20__TPM3_CH1                              0x0060 0x0210 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO20__FLEXIO1_FLEXIO20                      0x0060 0x0210 0x03B4 0x7 0x0
+#define MX93_PAD_GPIO_IO21__GPIO2_IO21                            0x0064 0x0214 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO21__SAI3_TX_DATA00                        0x0064 0x0214 0x0000 0x1 0x0
+#define MX93_PAD_GPIO_IO21__PDM_CLK                               0x0064 0x0214 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17                  0x0064 0x0214 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO21__LPSPI5_SCK                            0x0064 0x0214 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO21__LPSPI4_SCK                            0x0064 0x0214 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO21__TPM4_CH1                              0x0064 0x0214 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO21__SAI3_RX_BCLK                          0x0064 0x0214 0x044C 0x7 0x1
+#define MX93_PAD_GPIO_IO22__GPIO2_IO22                            0x0068 0x0218 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO22__USDHC3_CLK                            0x0068 0x0218 0x0458 0x1 0x0
+#define MX93_PAD_GPIO_IO22__SPDIF_IN                              0x0068 0x0218 0x0454 0x2 0x0
+#define MX93_PAD_GPIO_IO22__MEDIAMIX_DISP_DATA18                  0x0068 0x0218 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO22__TPM5_CH1                              0x0068 0x0218 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO22__TPM6_EXTCLK                           0x0068 0x0218 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO22__LPI2C5_SDA                            0x0068 0x0218 0x03EC 0x16 0x1
+#define MX93_PAD_GPIO_IO22__FLEXIO1_FLEXIO22                      0x0068 0x0218 0x03B8 0x7 0x0
+#define MX93_PAD_GPIO_IO23__GPIO2_IO23                            0x006C 0x021C 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO23__USDHC3_CMD                            0x006C 0x021C 0x045C 0x1 0x0
+#define MX93_PAD_GPIO_IO23__SPDIF_OUT                             0x006C 0x021C 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO23__MEDIAMIX_DISP_DATA19                  0x006C 0x021C 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO23__TPM6_CH1                              0x006C 0x021C 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO23__LPI2C5_SCL                            0x006C 0x021C 0x03E8 0x16 0x1
+#define MX93_PAD_GPIO_IO23__FLEXIO1_FLEXIO23                      0x006C 0x021C 0x03BC 0x7 0x0
+#define MX93_PAD_GPIO_IO24__GPIO2_IO24                            0x0070 0x0220 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO24__USDHC3_DATA0                          0x0070 0x0220 0x0460 0x1 0x0
+#define MX93_PAD_GPIO_IO24__MEDIAMIX_DISP_DATA20                  0x0070 0x0220 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO24__TPM3_CH3                              0x0070 0x0220 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO24__JTAG_MUX_TDO                          0x0070 0x0220 0x0000 0x5 0x0
+#define MX93_PAD_GPIO_IO24__LPSPI6_PCS1                           0x0070 0x0220 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO24__FLEXIO1_FLEXIO24                      0x0070 0x0220 0x03C0 0x7 0x0
+#define MX93_PAD_GPIO_IO25__GPIO2_IO25                            0x0074 0x0224 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO25__USDHC3_DATA1                          0x0074 0x0224 0x0464 0x1 0x0
+#define MX93_PAD_GPIO_IO25__CAN2_TX                               0x0074 0x0224 0x0000 0x2 0x0
+#define MX93_PAD_GPIO_IO25__MEDIAMIX_DISP_DATA21                  0x0074 0x0224 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO25__TPM4_CH3                              0x0074 0x0224 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO25__JTAG_MUX_TCK                          0x0074 0x0224 0x03D4 0x5 0x1
+#define MX93_PAD_GPIO_IO25__LPSPI7_PCS1                           0x0074 0x0224 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO25__FLEXIO1_FLEXIO25                      0x0074 0x0224 0x03C4 0x7 0x0
+#define MX93_PAD_GPIO_IO26__GPIO2_IO26                            0x0078 0x0228 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO26__USDHC3_DATA2                          0x0078 0x0228 0x0468 0x1 0x0
+#define MX93_PAD_GPIO_IO26__PDM_BIT_STREAM01                      0x0078 0x0228 0x043C 0x2 0x1
+#define MX93_PAD_GPIO_IO26__MEDIAMIX_DISP_DATA22                  0x0078 0x0228 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO26__TPM5_CH3                              0x0078 0x0228 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO26__JTAG_MUX_TDI                          0x0078 0x0228 0x03D8 0x5 0x1
+#define MX93_PAD_GPIO_IO26__LPSPI8_PCS1                           0x0078 0x0228 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO26__SAI3_TX_SYNC                          0x0078 0x0228 0x0000 0x7 0x0
+#define MX93_PAD_GPIO_IO27__GPIO2_IO27                            0x007C 0x022C 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO27__USDHC3_DATA3                          0x007C 0x022C 0x046C 0x1 0x0
+#define MX93_PAD_GPIO_IO27__CAN2_RX                               0x007C 0x022C 0x0364 0x2 0x1
+#define MX93_PAD_GPIO_IO27__MEDIAMIX_DISP_DATA23                  0x007C 0x022C 0x0000 0x3 0x0
+#define MX93_PAD_GPIO_IO27__TPM6_CH3                              0x007C 0x022C 0x0000 0x4 0x0
+#define MX93_PAD_GPIO_IO27__JTAG_MUX_TMS                          0x007C 0x022C 0x03DC 0x5 0x1
+#define MX93_PAD_GPIO_IO27__LPSPI5_PCS1                           0x007C 0x022C 0x0000 0x6 0x0
+#define MX93_PAD_GPIO_IO27__FLEXIO1_FLEXIO27                      0x007C 0x022C 0x03C8 0x7 0x0
+#define MX93_PAD_GPIO_IO28__GPIO2_IO28                            0x0080 0x0230 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO28__LPI2C3_SDA                            0x0080 0x0230 0x03E4 0x11 0x1
+#define MX93_PAD_GPIO_IO28__FLEXIO1_FLEXIO28                      0x0080 0x0230 0x0000 0x7 0x0
+#define MX93_PAD_GPIO_IO29__GPIO2_IO29                            0x0084 0x0234 0x0000 0x0 0x0
+#define MX93_PAD_GPIO_IO29__LPI2C3_SCL                            0x0084 0x0234 0x03E0 0x11 0x1
+#define MX93_PAD_GPIO_IO29__FLEXIO1_FLEXIO29                      0x0084 0x0234 0x0000 0x7 0x0
+#define MX93_PAD_CCM_CLKO1__CCMSRCGPCMIX_CLKO1                    0x0088 0x0238 0x0000 0x0 0x0
+#define MX93_PAD_CCM_CLKO1__FLEXIO1_FLEXIO26                      0x0088 0x0238 0x0000 0x4 0x0
+#define MX93_PAD_CCM_CLKO1__GPIO3_IO26                            0x0088 0x0238 0x0000 0x5 0x0
+#define MX93_PAD_CCM_CLKO2__GPIO3_IO27                            0x008C 0x023C 0x0000 0x5 0x0
+#define MX93_PAD_CCM_CLKO2__CCMSRCGPCMIX_CLKO2                    0x008C 0x023C 0x0000 0x0 0x0
+#define MX93_PAD_CCM_CLKO2__FLEXIO1_FLEXIO27                      0x008C 0x023C 0x03C8 0x4 0x1
+#define MX93_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3                    0x0090 0x0240 0x0000 0x0 0x0
+#define MX93_PAD_CCM_CLKO3__FLEXIO2_FLEXIO28                      0x0090 0x0240 0x0000 0x4 0x0
+#define MX93_PAD_CCM_CLKO3__GPIO4_IO28                            0x0090 0x0240 0x0000 0x5 0x0
+#define MX93_PAD_CCM_CLKO4__CCMSRCGPCMIX_CLKO4                    0x0094 0x0244 0x0000 0x0 0x0
+#define MX93_PAD_CCM_CLKO4__FLEXIO2_FLEXIO29                      0x0094 0x0244 0x0000 0x4 0x0
+#define MX93_PAD_CCM_CLKO4__GPIO4_IO29                            0x0094 0x0244 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_MDC__ENET_QOS_MDC                          0x0098 0x0248 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_MDC__LPUART3_DCB_B                         0x0098 0x0248 0x0000 0x1 0x0
+#define MX93_PAD_ENET1_MDC__I3C2_SCL                              0x0098 0x0248 0x03CC 0x2 0x0
+#define MX93_PAD_ENET1_MDC__HSIOMIX_OTG_ID1                       0x0098 0x0248 0x0000 0x3 0x0
+#define MX93_PAD_ENET1_MDC__FLEXIO2_FLEXIO00                      0x0098 0x0248 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_MDC__GPIO4_IO00                            0x0098 0x0248 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO                        0x009C 0x024C 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_MDIO__LPUART3_RIN_B                        0x009C 0x024C 0x0000 0x1 0x0
+#define MX93_PAD_ENET1_MDIO__I3C2_SDA                             0x009C 0x024C 0x03D0 0x2 0x0
+#define MX93_PAD_ENET1_MDIO__HSIOMIX_OTG_PWR1                     0x009C 0x024C 0x0000 0x3 0x0
+#define MX93_PAD_ENET1_MDIO__FLEXIO2_FLEXIO01                     0x009C 0x024C 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_MDIO__GPIO4_IO01                           0x009C 0x024C 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                    0x00A0 0x0250 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_TD3__CAN2_TX                               0x00A0 0x0250 0x0000 0x2 0x0
+#define MX93_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                       0x00A0 0x0250 0x0000 0x3 0x0
+#define MX93_PAD_ENET1_TD3__FLEXIO2_FLEXIO02                      0x00A0 0x0250 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_TD3__GPIO4_IO02                            0x00A0 0x0250 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                    0x00A4 0x0254 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_TD2__CCM_ENET_QOS_CLOCK_GENERATE_REF_CLK   0x00A4 0x0254 0x0000 0x1 0x0
+#define MX93_PAD_ENET1_TD2__CAN2_RX                               0x00A4 0x0254 0x0364 0x2 0x2
+#define MX93_PAD_ENET1_TD2__HSIOMIX_OTG_OC2                       0x00A4 0x0254 0x0000 0x3 0x0
+#define MX93_PAD_ENET1_TD2__FLEXIO2_FLEXIO03                      0x00A4 0x0254 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_TD2__GPIO4_IO03                            0x00A4 0x0254 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1                    0x00A8 0x0258 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_TD1__LPUART3_RTS_B                         0x00A8 0x0258 0x0000 0x1 0x0
+#define MX93_PAD_ENET1_TD1__I3C2_PUR                              0x00A8 0x0258 0x0000 0x2 0x0
+#define MX93_PAD_ENET1_TD1__HSIOMIX_OTG_OC1                       0x00A8 0x0258 0x0000 0x3 0x0
+#define MX93_PAD_ENET1_TD1__FLEXIO2_FLEXIO04                      0x00A8 0x0258 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_TD1__GPIO4_IO04                            0x00A8 0x0258 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_TD1__I3C2_PUR_B                            0x00A8 0x0258 0x0000 0x6 0x0
+#define MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                    0x00AC 0x025C 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_TD0__LPUART3_TX                            0x00AC 0x025C 0x041C 0x1 0x1
+#define MX93_PAD_ENET1_TD0__FLEXIO2_FLEXIO05                      0x00AC 0x025C 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_TD0__GPIO4_IO05                            0x00AC 0x025C 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL              0x00B0 0x0260 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_TX_CTL__LPUART3_DTR_B                      0x00B0 0x0260 0x0000 0x1 0x0
+#define MX93_PAD_ENET1_TX_CTL__FLEXIO2_FLEXIO06                   0x00B0 0x0260 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_TX_CTL__GPIO4_IO06                         0x00B0 0x0260 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK    0x00B4 0x0264 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_TXC__ENET_QOS_TX_ER                        0x00B4 0x0264 0x0000 0x1 0x0
+#define MX93_PAD_ENET1_TXC__FLEXIO2_FLEXIO07                      0x00B4 0x0264 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_TXC__GPIO4_IO07                            0x00B4 0x0264 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL              0x00B8 0x0268 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_RX_CTL__LPUART3_DSR_B                      0x00B8 0x0268 0x0000 0x1 0x0
+#define MX93_PAD_ENET1_RX_CTL__HSIOMIX_OTG_PWR2                   0x00B8 0x0268 0x0000 0x3 0x0
+#define MX93_PAD_ENET1_RX_CTL__FLEXIO2_FLEXIO08                   0x00B8 0x0268 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_RX_CTL__GPIO4_IO08                         0x00B8 0x0268 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK    0x00BC 0x026C 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_RXC__ENET_QOS_RX_ER                        0x00BC 0x026C 0x0000 0x1 0x0
+#define MX93_PAD_ENET1_RXC__FLEXIO2_FLEXIO09                      0x00BC 0x026C 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_RXC__GPIO4_IO09                            0x00BC 0x026C 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                    0x00C0 0x0270 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_RD0__LPUART3_RX                            0x00C0 0x0270 0x0418 0x1 0x1
+#define MX93_PAD_ENET1_RD0__FLEXIO2_FLEXIO10                      0x00C0 0x0270 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_RD0__GPIO4_IO10                            0x00C0 0x0270 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                    0x00C4 0x0274 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_RD1__LPUART3_CTS_B                         0x00C4 0x0274 0x0414 0x1 0x1
+#define MX93_PAD_ENET1_RD1__LPTMR2_ALT1                           0x00C4 0x0274 0x0408 0x3 0x0
+#define MX93_PAD_ENET1_RD1__FLEXIO2_FLEXIO11                      0x00C4 0x0274 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_RD1__GPIO4_IO11                            0x00C4 0x0274 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                    0x00C8 0x0278 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_RD2__LPTMR2_ALT2                           0x00C8 0x0278 0x040C 0x3 0x0
+#define MX93_PAD_ENET1_RD2__FLEXIO2_FLEXIO12                      0x00C8 0x0278 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_RD2__GPIO4_IO12                            0x00C8 0x0278 0x0000 0x5 0x0
+#define MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                    0x00CC 0x027C 0x0000 0x0 0x0
+#define MX93_PAD_ENET1_RD3__FLEXSPI1_TESTER_TRIGGER               0x00CC 0x027C 0x0000 0x2 0x0
+#define MX93_PAD_ENET1_RD3__LPTMR2_ALT3                           0x00CC 0x027C 0x0410 0x3 0x0
+#define MX93_PAD_ENET1_RD3__FLEXIO2_FLEXIO13                      0x00CC 0x027C 0x0000 0x4 0x0
+#define MX93_PAD_ENET1_RD3__GPIO4_IO13                            0x00CC 0x027C 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_MDC__ENET1_MDC                             0x00D0 0x0280 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_MDC__LPUART4_DCB_B                         0x00D0 0x0280 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_MDC__SAI2_RX_SYNC                          0x00D0 0x0280 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_MDC__FLEXIO2_FLEXIO14                      0x00D0 0x0280 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_MDC__GPIO4_IO14                            0x00D0 0x0280 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_MDIO__ENET1_MDIO                           0x00D4 0x0284 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_MDIO__LPUART4_RIN_B                        0x00D4 0x0284 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_MDIO__SAI2_RX_BCLK                         0x00D4 0x0284 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_MDIO__FLEXIO2_FLEXIO15                     0x00D4 0x0284 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_MDIO__GPIO4_IO15                           0x00D4 0x0284 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_TD3__SAI2_RX_DATA00                        0x00D8 0x0288 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_TD3__FLEXIO2_FLEXIO16                      0x00D8 0x0288 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_TD3__GPIO4_IO16                            0x00D8 0x0288 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3                       0x00D8 0x0288 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2                       0x00DC 0x028C 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_TD2__ENET1_TX_CLK                          0x00DC 0x028C 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_TD2__SAI2_RX_DATA01                        0x00DC 0x028C 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_TD2__FLEXIO2_FLEXIO17                      0x00DC 0x028C 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_TD2__GPIO4_IO17                            0x00DC 0x028C 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1                       0x00E0 0x0290 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_TD1__LPUART4_RTS_B                         0x00E0 0x0290 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_TD1__SAI2_RX_DATA02                        0x00E0 0x0290 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_TD1__FLEXIO2_FLEXIO18                      0x00E0 0x0290 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_TD1__GPIO4_IO18                            0x00E0 0x0290 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0                       0x00E4 0x0294 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_TD0__LPUART4_TX                            0x00E4 0x0294 0x0428 0x1 0x1
+#define MX93_PAD_ENET2_TD0__SAI2_RX_DATA03                        0x00E4 0x0294 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_TD0__FLEXIO2_FLEXIO19                      0x00E4 0x0294 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_TD0__GPIO4_IO19                            0x00E4 0x0294 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL                 0x00E8 0x0298 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_TX_CTL__LPUART4_DTR_B                      0x00E8 0x0298 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_TX_CTL__SAI2_TX_SYNC                       0x00E8 0x0298 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_TX_CTL__FLEXIO2_FLEXIO20                   0x00E8 0x0298 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_TX_CTL__GPIO4_IO20                         0x00E8 0x0298 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC                       0x00EC 0x029C 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_TXC__ENET1_TX_ER                           0x00EC 0x029C 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_TXC__SAI2_TX_BCLK                          0x00EC 0x029C 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_TXC__FLEXIO2_FLEXIO21                      0x00EC 0x029C 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_TXC__GPIO4_IO21                            0x00EC 0x029C 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL                 0x00F0 0x02A0 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_RX_CTL__LPUART4_DSR_B                      0x00F0 0x02A0 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_RX_CTL__SAI2_TX_DATA00                     0x00F0 0x02A0 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_RX_CTL__FLEXIO2_FLEXIO22                   0x00F0 0x02A0 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_RX_CTL__GPIO4_IO22                         0x00F0 0x02A0 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC                       0x00F4 0x02A4 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_RXC__ENET1_RX_ER                           0x00F4 0x02A4 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_RXC__SAI2_TX_DATA01                        0x00F4 0x02A4 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_RXC__FLEXIO2_FLEXIO23                      0x00F4 0x02A4 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_RXC__GPIO4_IO23                            0x00F4 0x02A4 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0                       0x00F8 0x02A8 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_RD0__LPUART4_RX                            0x00F8 0x02A8 0x0424 0x1 0x1
+#define MX93_PAD_ENET2_RD0__SAI2_TX_DATA02                        0x00F8 0x02A8 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_RD0__FLEXIO2_FLEXIO24                      0x00F8 0x02A8 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_RD0__GPIO4_IO24                            0x00F8 0x02A8 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1                       0x00FC 0x02AC 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_RD1__SPDIF_IN                              0x00FC 0x02AC 0x0454 0x1 0x1
+#define MX93_PAD_ENET2_RD1__SAI2_TX_DATA03                        0x00FC 0x02AC 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_RD1__FLEXIO2_FLEXIO25                      0x00FC 0x02AC 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_RD1__GPIO4_IO25                            0x00FC 0x02AC 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2                       0x0100 0x02B0 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_RD2__LPUART4_CTS_B                         0x0100 0x02B0 0x0420 0x1 0x1
+#define MX93_PAD_ENET2_RD2__SAI2_MCLK                             0x0100 0x02B0 0x0000 0x2 0x0
+#define MX93_PAD_ENET2_RD2__MQS2_RIGHT                            0x0100 0x02B0 0x0000 0x3 0x0
+#define MX93_PAD_ENET2_RD2__FLEXIO2_FLEXIO26                      0x0100 0x02B0 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_RD2__GPIO4_IO26                            0x0100 0x02B0 0x0000 0x5 0x0
+#define MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3                       0x0104 0x02B4 0x0000 0x0 0x0
+#define MX93_PAD_ENET2_RD3__SPDIF_OUT                             0x0104 0x02B4 0x0000 0x1 0x0
+#define MX93_PAD_ENET2_RD3__SPDIF_IN                              0x0104 0x02B4 0x0454 0x2 0x2
+#define MX93_PAD_ENET2_RD3__MQS2_LEFT                             0x0104 0x02B4 0x0000 0x3 0x0
+#define MX93_PAD_ENET2_RD3__FLEXIO2_FLEXIO27                      0x0104 0x02B4 0x0000 0x4 0x0
+#define MX93_PAD_ENET2_RD3__GPIO4_IO27                            0x0104 0x02B4 0x0000 0x5 0x0
+#define MX93_PAD_SD1_CLK__FLEXIO1_FLEXIO08                        0x0108 0x02B8 0x038C 0x4 0x1
+#define MX93_PAD_SD1_CLK__GPIO3_IO08                              0x0108 0x02B8 0x0000 0x5 0x0
+#define MX93_PAD_SD1_CLK__USDHC1_CLK                              0x0108 0x02B8 0x0000 0x0 0x0
+#define MX93_PAD_SD1_CMD__USDHC1_CMD                              0x010C 0x02BC 0x0000 0x0 0x0
+#define MX93_PAD_SD1_CMD__FLEXIO1_FLEXIO09                        0x010C 0x02BC 0x0390 0x4 0x1
+#define MX93_PAD_SD1_CMD__GPIO3_IO09                              0x010C 0x02BC 0x0000 0x5 0x0
+#define MX93_PAD_SD1_DATA0__USDHC1_DATA0                          0x0110 0x02C0 0x0000 0x0 0x0
+#define MX93_PAD_SD1_DATA0__FLEXIO1_FLEXIO10                      0x0110 0x02C0 0x0394 0x4 0x1
+#define MX93_PAD_SD1_DATA0__GPIO3_IO10                            0x0110 0x02C0 0x0000 0x5 0x0
+#define MX93_PAD_SD1_DATA1__USDHC1_DATA1                          0x0114 0x02C4 0x0000 0x0 0x0
+#define MX93_PAD_SD1_DATA1__FLEXIO1_FLEXIO11                      0x0114 0x02C4 0x0398 0x4 0x1
+#define MX93_PAD_SD1_DATA1__GPIO3_IO11                            0x0114 0x02C4 0x0000 0x5 0x0
+#define MX93_PAD_SD1_DATA1__CCMSRCGPCMIX_INT_BOOT                 0x0114 0x02C4 0x0000 0x6 0x0
+#define MX93_PAD_SD1_DATA2__USDHC1_DATA2                          0x0118 0x02C8 0x0000 0x0 0x0
+#define MX93_PAD_SD1_DATA2__FLEXIO1_FLEXIO12                      0x0118 0x02C8 0x0000 0x4 0x0
+#define MX93_PAD_SD1_DATA2__GPIO3_IO12                            0x0118 0x02C8 0x0000 0x5 0x0
+#define MX93_PAD_SD1_DATA2__CCMSRCGPCMIX_PMIC_READY               0x0118 0x02C8 0x0000 0x6 0x0
+#define MX93_PAD_SD1_DATA3__USDHC1_DATA3                          0x011C 0x02CC 0x0000 0x0 0x0
+#define MX93_PAD_SD1_DATA3__FLEXSPI1_A_SS1_B                      0x011C 0x02CC 0x0000 0x1 0x0
+#define MX93_PAD_SD1_DATA3__FLEXIO1_FLEXIO13                      0x011C 0x02CC 0x039C 0x4 0x1
+#define MX93_PAD_SD1_DATA3__GPIO3_IO13                            0x011C 0x02CC 0x0000 0x5 0x0
+#define MX93_PAD_SD1_DATA4__USDHC1_DATA4                          0x0120 0x02D0 0x0000 0x0 0x0
+#define MX93_PAD_SD1_DATA4__FLEXSPI1_A_DATA04                     0x0120 0x02D0 0x0000 0x1 0x0
+#define MX93_PAD_SD1_DATA4__FLEXIO1_FLEXIO14                      0x0120 0x02D0 0x03A0 0x4 0x1
+#define MX93_PAD_SD1_DATA4__GPIO3_IO14                            0x0120 0x02D0 0x0000 0x5 0x0
+#define MX93_PAD_SD1_DATA5__USDHC1_DATA5                          0x0124 0x02D4 0x0000 0x0 0x0
+#define MX93_PAD_SD1_DATA5__FLEXSPI1_A_DATA05                     0x0124 0x02D4 0x0000 0x1 0x0
+#define MX93_PAD_SD1_DATA5__USDHC1_RESET_B                        0x0124 0x02D4 0x0000 0x2 0x0
+#define MX93_PAD_SD1_DATA5__FLEXIO1_FLEXIO15                      0x0124 0x02D4 0x03A4 0x4 0x1
+#define MX93_PAD_SD1_DATA5__GPIO3_IO15                            0x0124 0x02D4 0x0000 0x5 0x0
+#define MX93_PAD_SD1_DATA6__USDHC1_DATA6                          0x0128 0x02D8 0x0000 0x0 0x0
+#define MX93_PAD_SD1_DATA6__FLEXSPI1_A_DATA06                     0x0128 0x02D8 0x0000 0x1 0x0
+#define MX93_PAD_SD1_DATA6__USDHC1_CD_B                           0x0128 0x02D8 0x0000 0x2 0x0
+#define MX93_PAD_SD1_DATA6__FLEXIO1_FLEXIO16                      0x0128 0x02D8 0x03A8 0x4 0x1
+#define MX93_PAD_SD1_DATA6__GPIO3_IO16                            0x0128 0x02D8 0x0000 0x5 0x0
+#define MX93_PAD_SD1_DATA7__USDHC1_DATA7                          0x012C 0x02DC 0x0000 0x0 0x0
+#define MX93_PAD_SD1_DATA7__FLEXSPI1_A_DATA07                     0x012C 0x02DC 0x0000 0x1 0x0
+#define MX93_PAD_SD1_DATA7__USDHC1_WP                             0x012C 0x02DC 0x0000 0x2 0x0
+#define MX93_PAD_SD1_DATA7__FLEXIO1_FLEXIO17                      0x012C 0x02DC 0x03AC 0x4 0x1
+#define MX93_PAD_SD1_DATA7__GPIO3_IO17                            0x012C 0x02DC 0x0000 0x5 0x0
+#define MX93_PAD_SD1_STROBE__USDHC1_STROBE                        0x0130 0x02E0 0x0000 0x0 0x0
+#define MX93_PAD_SD1_STROBE__FLEXSPI1_A_DQS                       0x0130 0x02E0 0x0000 0x1 0x0
+#define MX93_PAD_SD1_STROBE__FLEXIO1_FLEXIO18                     0x0130 0x02E0 0x03B0 0x4 0x1
+#define MX93_PAD_SD1_STROBE__GPIO3_IO18                           0x0130 0x02E0 0x0000 0x5 0x0
+#define MX93_PAD_SD2_VSELECT__USDHC2_VSELECT                      0x0134 0x02E4 0x0000 0x0 0x0
+#define MX93_PAD_SD2_VSELECT__USDHC2_WP                           0x0134 0x02E4 0x0000 0x1 0x0
+#define MX93_PAD_SD2_VSELECT__LPTMR2_ALT3                         0x0134 0x02E4 0x0410 0x2 0x1
+#define MX93_PAD_SD2_VSELECT__FLEXIO1_FLEXIO19                    0x0134 0x02E4 0x0000 0x4 0x0
+#define MX93_PAD_SD2_VSELECT__GPIO3_IO19                          0x0134 0x02E4 0x0000 0x5 0x0
+#define MX93_PAD_SD2_VSELECT__CCMSRCGPCMIX_EXT_CLK1               0x0134 0x02E4 0x0368 0x6 0x0
+#define MX93_PAD_SD3_CLK__USDHC3_CLK                              0x0138 0x02E8 0x0458 0x0 0x1
+#define MX93_PAD_SD3_CLK__FLEXSPI1_A_SCLK                         0x0138 0x02E8 0x0000 0x1 0x0
+#define MX93_PAD_SD3_CLK__FLEXIO1_FLEXIO20                        0x0138 0x02E8 0x03B4 0x4 0x1
+#define MX93_PAD_SD3_CLK__GPIO3_IO20                              0x0138 0x02E8 0x0000 0x5 0x0
+#define MX93_PAD_SD3_CMD__USDHC3_CMD                              0x013C 0x02EC 0x045C 0x0 0x1
+#define MX93_PAD_SD3_CMD__FLEXSPI1_A_SS0_B                        0x013C 0x02EC 0x0000 0x1 0x0
+#define MX93_PAD_SD3_CMD__FLEXIO1_FLEXIO21                        0x013C 0x02EC 0x0000 0x4 0x0
+#define MX93_PAD_SD3_CMD__GPIO3_IO21                              0x013C 0x02EC 0x0000 0x5 0x0
+#define MX93_PAD_SD3_DATA0__USDHC3_DATA0                          0x0140 0x02F0 0x0460 0x0 0x1
+#define MX93_PAD_SD3_DATA0__FLEXSPI1_A_DATA00                     0x0140 0x02F0 0x0000 0x1 0x0
+#define MX93_PAD_SD3_DATA0__FLEXIO1_FLEXIO22                      0x0140 0x02F0 0x03B8 0x4 0x1
+#define MX93_PAD_SD3_DATA0__GPIO3_IO22                            0x0140 0x02F0 0x0000 0x5 0x0
+#define MX93_PAD_SD3_DATA1__USDHC3_DATA1                          0x0144 0x02F4 0x0464 0x0 0x1
+#define MX93_PAD_SD3_DATA1__FLEXSPI1_A_DATA01                     0x0144 0x02F4 0x0000 0x1 0x0
+#define MX93_PAD_SD3_DATA1__FLEXIO1_FLEXIO23                      0x0144 0x02F4 0x03BC 0x4 0x1
+#define MX93_PAD_SD3_DATA1__GPIO3_IO23                            0x0144 0x02F4 0x0000 0x5 0x0
+#define MX93_PAD_SD3_DATA2__USDHC3_DATA2                          0x0148 0x02F8 0x0468 0x0 0x1
+#define MX93_PAD_SD3_DATA2__FLEXSPI1_A_DATA02                     0x0148 0x02F8 0x0000 0x1 0x0
+#define MX93_PAD_SD3_DATA2__FLEXIO1_FLEXIO24                      0x0148 0x02F8 0x03C0 0x4 0x1
+#define MX93_PAD_SD3_DATA2__GPIO3_IO24                            0x0148 0x02F8 0x0000 0x5 0x0
+#define MX93_PAD_SD3_DATA3__USDHC3_DATA3                          0x014C 0x02FC 0x046C 0x0 0x1
+#define MX93_PAD_SD3_DATA3__FLEXSPI1_A_DATA03                     0x014C 0x02FC 0x0000 0x1 0x0
+#define MX93_PAD_SD3_DATA3__FLEXIO1_FLEXIO25                      0x014C 0x02FC 0x03C4 0x4 0x1
+#define MX93_PAD_SD3_DATA3__GPIO3_IO25                            0x014C 0x02FC 0x0000 0x5 0x0
+#define MX93_PAD_SD2_CD_B__USDHC2_CD_B                            0x0150 0x0300 0x0000 0x0 0x0
+#define MX93_PAD_SD2_CD_B__ENET_QOS_1588_EVENT0_IN                0x0150 0x0300 0x0000 0x1 0x0
+#define MX93_PAD_SD2_CD_B__I3C2_SCL                               0x0150 0x0300 0x03CC 0x2 0x1
+#define MX93_PAD_SD2_CD_B__FLEXIO1_FLEXIO00                       0x0150 0x0300 0x036C 0x4 0x1
+#define MX93_PAD_SD2_CD_B__GPIO3_IO00                             0x0150 0x0300 0x0000 0x5 0x0
+#define MX93_PAD_SD2_CLK__USDHC2_CLK                              0x0154 0x0304 0x0000 0x0 0x0
+#define MX93_PAD_SD2_CLK__ENET_QOS_1588_EVENT0_OUT                0x0154 0x0304 0x0000 0x1 0x0
+#define MX93_PAD_SD2_CLK__I3C2_SDA                                0x0154 0x0304 0x03D0 0x2 0x1
+#define MX93_PAD_SD2_CLK__FLEXIO1_FLEXIO01                        0x0154 0x0304 0x0370 0x4 0x1
+#define MX93_PAD_SD2_CLK__GPIO3_IO01                              0x0154 0x0304 0x0000 0x5 0x0
+#define MX93_PAD_SD2_CLK__CCMSRCGPCMIX_OBSERVE0                   0x0154 0x0304 0x0000 0x6 0x0
+#define MX93_PAD_SD2_CMD__USDHC2_CMD                              0x0158 0x0308 0x0000 0x0 0x0
+#define MX93_PAD_SD2_CMD__ENET1_1588_EVENT0_IN                    0x0158 0x0308 0x0000 0x1 0x0
+#define MX93_PAD_SD2_CMD__I3C2_PUR                                0x0158 0x0308 0x0000 0x2 0x0
+#define MX93_PAD_SD2_CMD__I3C2_PUR_B                              0x0158 0x0308 0x0000 0x3 0x0
+#define MX93_PAD_SD2_CMD__FLEXIO1_FLEXIO02                        0x0158 0x0308 0x0374 0x4 0x1
+#define MX93_PAD_SD2_CMD__GPIO3_IO02                              0x0158 0x0308 0x0000 0x5 0x0
+#define MX93_PAD_SD2_CMD__CCMSRCGPCMIX_OBSERVE1                   0x0158 0x0308 0x0000 0x6 0x0
+#define MX93_PAD_SD2_DATA0__USDHC2_DATA0                          0x015C 0x030C 0x0000 0x0 0x0
+#define MX93_PAD_SD2_DATA0__ENET1_1588_EVENT0_OUT                 0x015C 0x030C 0x0000 0x1 0x0
+#define MX93_PAD_SD2_DATA0__CAN2_TX                               0x015C 0x030C 0x0000 0x2 0x0
+#define MX93_PAD_SD2_DATA0__FLEXIO1_FLEXIO03                      0x015C 0x030C 0x0378 0x4 0x1
+#define MX93_PAD_SD2_DATA0__GPIO3_IO03                            0x015C 0x030C 0x0000 0x5 0x0
+#define MX93_PAD_SD2_DATA0__CCMSRCGPCMIX_OBSERVE2                 0x015C 0x030C 0x0000 0x6 0x0
+#define MX93_PAD_SD2_DATA1__USDHC2_DATA1                          0x0160 0x0310 0x0000 0x0 0x0
+#define MX93_PAD_SD2_DATA1__ENET1_1588_EVENT1_IN                  0x0160 0x0310 0x0000 0x1 0x0
+#define MX93_PAD_SD2_DATA1__CAN2_RX                               0x0160 0x0310 0x0364 0x2 0x3
+#define MX93_PAD_SD2_DATA1__FLEXIO1_FLEXIO04                      0x0160 0x0310 0x037C 0x4 0x1
+#define MX93_PAD_SD2_DATA1__GPIO3_IO04                            0x0160 0x0310 0x0000 0x5 0x0
+#define MX93_PAD_SD2_DATA1__CCMSRCGPCMIX_WAIT                     0x0160 0x0310 0x0000 0x6 0x0
+#define MX93_PAD_SD2_DATA2__USDHC2_DATA2                          0x0164 0x0314 0x0000 0x0 0x0
+#define MX93_PAD_SD2_DATA2__ENET1_1588_EVENT1_OUT                 0x0164 0x0314 0x0000 0x1 0x0
+#define MX93_PAD_SD2_DATA2__MQS2_RIGHT                            0x0164 0x0314 0x0000 0x2 0x0
+#define MX93_PAD_SD2_DATA2__FLEXIO1_FLEXIO05                      0x0164 0x0314 0x0380 0x4 0x1
+#define MX93_PAD_SD2_DATA2__GPIO3_IO05                            0x0164 0x0314 0x0000 0x5 0x0
+#define MX93_PAD_SD2_DATA2__CCMSRCGPCMIX_STOP                     0x0164 0x0314 0x0000 0x6 0x0
+#define MX93_PAD_SD2_DATA3__USDHC2_DATA3                          0x0168 0x0318 0x0000 0x0 0x0
+#define MX93_PAD_SD2_DATA3__LPTMR2_ALT1                           0x0168 0x0318 0x0408 0x1 0x1
+#define MX93_PAD_SD2_DATA3__MQS2_LEFT                             0x0168 0x0318 0x0000 0x2 0x0
+#define MX93_PAD_SD2_DATA3__FLEXIO1_FLEXIO06                      0x0168 0x0318 0x0384 0x4 0x1
+#define MX93_PAD_SD2_DATA3__GPIO3_IO06                            0x0168 0x0318 0x0000 0x5 0x0
+#define MX93_PAD_SD2_DATA3__CCMSRCGPCMIX_EARLY_RESET              0x0168 0x0318 0x0000 0x6 0x0
+#define MX93_PAD_SD2_RESET_B__USDHC2_RESET_B                      0x016C 0x031C 0x0000 0x0 0x0
+#define MX93_PAD_SD2_RESET_B__LPTMR2_ALT2                         0x016C 0x031C 0x040C 0x1 0x1
+#define MX93_PAD_SD2_RESET_B__FLEXIO1_FLEXIO07                    0x016C 0x031C 0x0388 0x4 0x1
+#define MX93_PAD_SD2_RESET_B__GPIO3_IO07                          0x016C 0x031C 0x0000 0x5 0x0
+#define MX93_PAD_SD2_RESET_B__CCMSRCGPCMIX_SYSTEM_RESET           0x016C 0x031C 0x0000 0x6 0x0
+#define MX93_PAD_I2C1_SCL__LPI2C1_SCL                             0x0170 0x0320 0x0000 0x10 0x0
+#define MX93_PAD_I2C1_SCL__I3C1_SCL                               0x0170 0x0320 0x0000 0x1 0x0
+#define MX93_PAD_I2C1_SCL__LPUART1_DCB_B                          0x0170 0x0320 0x0000 0x2 0x0
+#define MX93_PAD_I2C1_SCL__TPM2_CH0                               0x0170 0x0320 0x0000 0x3 0x0
+#define MX93_PAD_I2C1_SCL__GPIO1_IO00                             0x0170 0x0320 0x0000 0x5 0x0
+#define MX93_PAD_I2C1_SDA__LPI2C1_SDA                             0x0174 0x0324 0x0000 0x10 0x0
+#define MX93_PAD_I2C1_SDA__I3C1_SDA                               0x0174 0x0324 0x0000 0x1 0x0
+#define MX93_PAD_I2C1_SDA__LPUART1_RIN_B                          0x0174 0x0324 0x0000 0x2 0x0
+#define MX93_PAD_I2C1_SDA__TPM2_CH1                               0x0174 0x0324 0x0000 0x3 0x0
+#define MX93_PAD_I2C1_SDA__GPIO1_IO01                             0x0174 0x0324 0x0000 0x5 0x0
+#define MX93_PAD_I2C2_SCL__LPI2C2_SCL                             0x0178 0x0328 0x0000 0x10 0x0
+#define MX93_PAD_I2C2_SCL__I3C1_PUR                               0x0178 0x0328 0x0000 0x1 0x0
+#define MX93_PAD_I2C2_SCL__LPUART2_DCB_B                          0x0178 0x0328 0x0000 0x2 0x0
+#define MX93_PAD_I2C2_SCL__TPM2_CH2                               0x0178 0x0328 0x0000 0x3 0x0
+#define MX93_PAD_I2C2_SCL__SAI1_RX_SYNC                           0x0178 0x0328 0x0000 0x4 0x0
+#define MX93_PAD_I2C2_SCL__GPIO1_IO02                             0x0178 0x0328 0x0000 0x5 0x0
+#define MX93_PAD_I2C2_SCL__I3C1_PUR_B                             0x0178 0x0328 0x0000 0x6 0x0
+#define MX93_PAD_I2C2_SDA__LPI2C2_SDA                             0x017C 0x032C 0x0000 0x10 0x0
+#define MX93_PAD_I2C2_SDA__LPUART2_RIN_B                          0x017C 0x032C 0x0000 0x2 0x0
+#define MX93_PAD_I2C2_SDA__TPM2_CH3                               0x017C 0x032C 0x0000 0x3 0x0
+#define MX93_PAD_I2C2_SDA__SAI1_RX_BCLK                           0x017C 0x032C 0x0000 0x4 0x0
+#define MX93_PAD_I2C2_SDA__GPIO1_IO03                             0x017C 0x032C 0x0000 0x5 0x0
+#define MX93_PAD_UART1_RXD__LPUART1_RX                            0x0180 0x0330 0x0000 0x0 0x0
+#define MX93_PAD_UART1_RXD__S400_UART_RX                          0x0180 0x0330 0x0000 0x1 0x0
+#define MX93_PAD_UART1_RXD__LPSPI2_SIN                            0x0180 0x0330 0x0000 0x2 0x0
+#define MX93_PAD_UART1_RXD__TPM1_CH0                              0x0180 0x0330 0x0000 0x3 0x0
+#define MX93_PAD_UART1_RXD__GPIO1_IO04                            0x0180 0x0330 0x0000 0x5 0x0
+#define MX93_PAD_UART1_TXD__LPUART1_TX                            0x0184 0x0334 0x0000 0x0 0x0
+#define MX93_PAD_UART1_TXD__S400_UART_TX                          0x0184 0x0334 0x0000 0x1 0x0
+#define MX93_PAD_UART1_TXD__LPSPI2_PCS0                           0x0184 0x0334 0x0000 0x2 0x0
+#define MX93_PAD_UART1_TXD__TPM1_CH1                              0x0184 0x0334 0x0000 0x3 0x0
+#define MX93_PAD_UART1_TXD__GPIO1_IO05                            0x0184 0x0334 0x0000 0x5 0x0
+#define MX93_PAD_UART2_RXD__LPUART2_RX                            0x0188 0x0338 0x0000 0x0 0x0
+#define MX93_PAD_UART2_RXD__LPUART1_CTS_B                         0x0188 0x0338 0x0000 0x1 0x0
+#define MX93_PAD_UART2_RXD__LPSPI2_SOUT                           0x0188 0x0338 0x0000 0x2 0x0
+#define MX93_PAD_UART2_RXD__TPM1_CH2                              0x0188 0x0338 0x0000 0x3 0x0
+#define MX93_PAD_UART2_RXD__SAI1_MCLK                             0x0188 0x0338 0x0448 0x4 0x0
+#define MX93_PAD_UART2_RXD__GPIO1_IO06                            0x0188 0x0338 0x0000 0x5 0x0
+#define MX93_PAD_UART2_TXD__LPUART2_TX                            0x018C 0x033C 0x0000 0x0 0x0
+#define MX93_PAD_UART2_TXD__LPUART1_RTS_B                         0x018C 0x033C 0x0000 0x1 0x0
+#define MX93_PAD_UART2_TXD__LPSPI2_SCK                            0x018C 0x033C 0x0000 0x2 0x0
+#define MX93_PAD_UART2_TXD__TPM1_CH3                              0x018C 0x033C 0x0000 0x3 0x0
+#define MX93_PAD_UART2_TXD__GPIO1_IO07                            0x018C 0x033C 0x0000 0x5 0x0
+#define MX93_PAD_PDM_CLK__PDM_CLK                                 0x0190 0x0340 0x0000 0x0 0x0
+#define MX93_PAD_PDM_CLK__MQS1_LEFT                               0x0190 0x0340 0x0000 0x1 0x0
+#define MX93_PAD_PDM_CLK__LPTMR1_ALT1                             0x0190 0x0340 0x0000 0x4 0x0
+#define MX93_PAD_PDM_CLK__GPIO1_IO08                              0x0190 0x0340 0x0000 0x5 0x0
+#define MX93_PAD_PDM_CLK__CAN1_TX                                 0x0190 0x0340 0x0000 0x6 0x0
+#define MX93_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM00                0x0194 0x0344 0x0438 0x0 0x2
+#define MX93_PAD_PDM_BIT_STREAM0__MQS1_RIGHT                      0x0194 0x0344 0x0000 0x1 0x0
+#define MX93_PAD_PDM_BIT_STREAM0__LPSPI1_PCS1                     0x0194 0x0344 0x0000 0x2 0x0
+#define MX93_PAD_PDM_BIT_STREAM0__TPM1_EXTCLK                     0x0194 0x0344 0x0000 0x3 0x0
+#define MX93_PAD_PDM_BIT_STREAM0__LPTMR1_ALT2                     0x0194 0x0344 0x0000 0x4 0x0
+#define MX93_PAD_PDM_BIT_STREAM0__GPIO1_IO09                      0x0194 0x0344 0x0000 0x5 0x0
+#define MX93_PAD_PDM_BIT_STREAM0__CAN1_RX                         0x0194 0x0344 0x0360 0x6 0x0
+#define MX93_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM01                0x0198 0x0348 0x043C 0x0 0x2
+#define MX93_PAD_PDM_BIT_STREAM1__NMI_GLUE_NMI                    0x0198 0x0348 0x0000 0x1 0x0
+#define MX93_PAD_PDM_BIT_STREAM1__LPSPI2_PCS1                     0x0198 0x0348 0x0000 0x2 0x0
+#define MX93_PAD_PDM_BIT_STREAM1__TPM2_EXTCLK                     0x0198 0x0348 0x0000 0x3 0x0
+#define MX93_PAD_PDM_BIT_STREAM1__LPTMR1_ALT3                     0x0198 0x0348 0x0000 0x4 0x0
+#define MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10                      0x0198 0x0348 0x0000 0x5 0x0
+#define MX93_PAD_PDM_BIT_STREAM1__CCMSRCGPCMIX_EXT_CLK1           0x0198 0x0348 0x0368 0x6 0x1
+#define MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC                          0x019C 0x034C 0x0000 0x0 0x0
+#define MX93_PAD_SAI1_TXFS__SAI1_TX_DATA01                        0x019C 0x034C 0x0000 0x1 0x0
+#define MX93_PAD_SAI1_TXFS__LPSPI1_PCS0                           0x019C 0x034C 0x0000 0x2 0x0
+#define MX93_PAD_SAI1_TXFS__LPUART2_DTR_B                         0x019C 0x034C 0x0000 0x3 0x0
+#define MX93_PAD_SAI1_TXFS__MQS1_LEFT                             0x019C 0x034C 0x0000 0x4 0x0
+#define MX93_PAD_SAI1_TXFS__GPIO1_IO11                            0x019C 0x034C 0x0000 0x5 0x0
+#define MX93_PAD_SAI1_TXC__SAI1_TX_BCLK                           0x01A0 0x0350 0x0000 0x0 0x0
+#define MX93_PAD_SAI1_TXC__LPUART2_CTS_B                          0x01A0 0x0350 0x0000 0x1 0x0
+#define MX93_PAD_SAI1_TXC__LPSPI1_SIN                             0x01A0 0x0350 0x0000 0x2 0x0
+#define MX93_PAD_SAI1_TXC__LPUART1_DSR_B                          0x01A0 0x0350 0x0000 0x3 0x0
+#define MX93_PAD_SAI1_TXC__CAN1_RX                                0x01A0 0x0350 0x0360 0x4 0x1
+#define MX93_PAD_SAI1_TXC__GPIO1_IO12                             0x01A0 0x0350 0x0000 0x5 0x0
+#define MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00                        0x01A4 0x0354 0x0000 0x0 0x0
+#define MX93_PAD_SAI1_TXD0__LPUART2_RTS_B                         0x01A4 0x0354 0x0000 0x1 0x0
+#define MX93_PAD_SAI1_TXD0__LPSPI1_SCK                            0x01A4 0x0354 0x0000 0x2 0x0
+#define MX93_PAD_SAI1_TXD0__LPUART1_DTR_B                         0x01A4 0x0354 0x0000 0x3 0x0
+#define MX93_PAD_SAI1_TXD0__CAN1_TX                               0x01A4 0x0354 0x0000 0x4 0x0
+#define MX93_PAD_SAI1_TXD0__GPIO1_IO13                            0x01A4 0x0354 0x0000 0x5 0x0
+#define MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00                        0x01A8 0x0358 0x0000 0x0 0x0
+#define MX93_PAD_SAI1_RXD0__SAI1_MCLK                             0x01A8 0x0358 0x0448 0x1 0x1
+#define MX93_PAD_SAI1_RXD0__LPSPI1_SOUT                           0x01A8 0x0358 0x0000 0x2 0x0
+#define MX93_PAD_SAI1_RXD0__LPUART2_DSR_B                         0x01A8 0x0358 0x0000 0x3 0x0
+#define MX93_PAD_SAI1_RXD0__MQS1_RIGHT                            0x01A8 0x0358 0x0000 0x4 0x0
+#define MX93_PAD_SAI1_RXD0__GPIO1_IO14                            0x01A8 0x0358 0x0000 0x5 0x0
+#define MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY                         0x01AC 0x035C 0x0000 0x0 0x0
+#define MX93_PAD_WDOG_ANY__GPIO1_IO15                             0x01AC 0x035C 0x0000 0x5 0x0
+
+#endif /* __DTS_IMX93_PINFUNC_H */
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
new file mode 100644
index 000000000000..5544f3d9cbf9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 NXP
+ */
+
+#include <dt-bindings/clock/imx93-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include "imx93-pinfunc.h"
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		serial7 = &lpuart8;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		A55_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+		};
+
+		A55_1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+		};
+
+	};
+
+	osc_32k: clock-osc-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "osc_32k";
+	};
+
+	osc_24m: clock-osc-24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc_24m";
+	};
+
+	clk_ext1: clock-ext1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <133000000>;
+		clock-output-names = "clk_ext1";
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <24000000>;
+		arm,no-tick-in-suspend;
+		interrupt-parent = <&gic>;
+	};
+
+	gic: interrupt-controller@48000000 {
+		compatible = "arm,gic-v3";
+		reg = <0 0x48000000 0 0x10000>,
+		      <0 0x48040000 0 0xc0000>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x0 0x80000000>,
+			 <0x28000000 0x0 0x28000000 0x10000000>;
+
+		aips1: bus@44000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x44000000 0x800000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			mu1: mailbox@44230000 {
+				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
+				reg = <0x44230000 0x10000>;
+				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			system_counter: timer@44290000 {
+				compatible = "nxp,sysctr-timer";
+				reg = <0x44290000 0x30000>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc_24m>;
+				clock-names = "per";
+			};
+
+			lpuart1: serial@44380000 {
+				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				reg = <0x44380000 0x1000>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart2: serial@44390000 {
+				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				reg = <0x44390000 0x1000>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			iomuxc: pinctrl@443c0000 {
+				compatible = "fsl,imx93-iomuxc";
+				reg = <0x443c0000 0x10000>;
+			};
+
+			clk: clock-controller@44450000 {
+				compatible = "fsl,imx93-ccm";
+				reg = <0x44450000 0x10000>;
+				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>;
+				clock-names = "osc_32k", "osc_24m", "clk_ext1";
+				status = "okay";
+			};
+
+			anatop: anatop@44480000 {
+				compatible = "fsl,imx93-anatop", "syscon";
+				reg = <0x44480000 0x10000>;
+			};
+		};
+
+		aips2: bus@42000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x42000000 0x800000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			mu2: mailbox@42440000 {
+				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
+				reg = <0x42440000 0x10000>;
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			lpuart3: serial@42570000 {
+				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				reg = <0x42570000 0x1000>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart4: serial@42580000 {
+				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				reg = <0x42580000 0x1000>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart5: serial@42590000 {
+				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				reg = <0x42590000 0x1000>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart6: serial@425a0000 {
+				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				reg = <0x425a0000 0x1000>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart7: serial@42690000 {
+				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				reg = <0x42690000 0x1000>;
+				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart8: serial@426a0000 {
+				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				reg = <0x426a0000 0x1000>;
+				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+		};
+
+		aips3: bus@42800000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x42800000 0x800000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			usdhc1: mmc@42850000 {
+				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x42850000 0x10000>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_USDHC1_GATE>;
+				clock-names = "ipg", "ahb", "per";
+				bus-width = <8>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
+				status = "disabled";
+			};
+
+			usdhc2: mmc@42860000 {
+				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x42860000 0x10000>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_USDHC2_GATE>;
+				clock-names = "ipg", "ahb", "per";
+				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
+				status = "disabled";
+			};
+
+			usdhc3: mmc@428b0000 {
+				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x428b0000 0x10000>;
+				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_USDHC3_GATE>;
+				clock-names = "ipg", "ahb", "per";
+				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
+				status = "disabled";
+			};
+		};
+
+		gpio2: gpio@43810080 {
+			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
+			reg = <0x43810080 0x1000>, <0x43810040 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&iomuxc 0 32 32>;
+		};
+
+		gpio3: gpio@43820080 {
+			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
+			reg = <0x43820080 0x1000>, <0x43820040 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&iomuxc 0 64 32>;
+		};
+
+		gpio4: gpio@43830080 {
+			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
+			reg = <0x43830080 0x1000>, <0x43830040 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&iomuxc 0 96 32>;
+		};
+
+		gpio1: gpio@47400080 {
+			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
+			reg = <0x47400080 0x1000>, <0x47400040 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&iomuxc 0 0 32>;
+		};
+	};
+};
-- 
2.25.1

