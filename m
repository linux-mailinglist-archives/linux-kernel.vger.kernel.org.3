Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5425653DF8A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiFFBtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352128AbiFFBtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:49:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB24FC5B;
        Sun,  5 Jun 2022 18:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+ZgR1/zJgObr4e8wB1QiVU6v/LCYtltx9rwW9SCFLb25tT1ChLV/neOSvOOne2903trdHuH5x23uxQvM8jx7r265vX8H28FdKY8Zvd8mVJO/goAlnfEQvfFLInkkaCS7t6Zxtrl5cKse5410RbDH8kUp5vjU25yQV/SlNd6Di+nCczjsiBslUP3azhD1EslGdj/i6ux7/6uz4x2NAbff9dgpngA+HCJp+uSYFrw0rf/yULI6hU7pCBDruHX7WrOraNoErVHVaU20NrYsz6u7tDPPezJ7WQige3/7IrAy2R00SMRYHzmn6Dx1WQF51wInVghB8ofpJt8og7F5mHalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxBay6abfWj4uI2aTF7bI6Jy5vsMsTD9VaqBi1hNmZk=;
 b=UYhuzAFkirwFb9u8/OqEXTZW89vMJUmbN1y5QvbaGJFV+GdOQuzdP95spc3wK9P8vpUoCpkeT7UEE5Wq5C49tfgedfL8COOjz4gOOPCxJI25hvTtCIzgyhltcMF/iiVvrru7G03iIDGLzjnYhJTfBynBDk1DPyG9uPWoecz1uqdSVvriDr47OBypVMDcgd0PTadBp41Lo5N0bDCOkUSWoj5kALmpcBWRrle2pqCcTArzF1EzoJnvTgQMf4/jJb7sc8QB4ScSxh0zjq2n222McFvGE3Ve3kkZBcVXYiZYpIwQ7sQvztQU3KWpvjXjlMpxHjSyUGv/SgCgz+4GsIiCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxBay6abfWj4uI2aTF7bI6Jy5vsMsTD9VaqBi1hNmZk=;
 b=NZ57SGFbNGxpadij66857twsaxNSH7ZQqVgopADiufcuIRa2uDmig4qLCaea7qzvRwHc2r5dkyxQrcxIcri43zqujPL+5meJZhX3I45JXw1hmd+jpJ3Xo+o8HWStHHr7KbgfBPG56JDsX40mtSsyLibAMhlU7BpefDI216Qhw+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR04MB4840.eurprd04.prod.outlook.com (2603:10a6:20b:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 01:49:24 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 01:49:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 7/7] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Mon,  6 Jun 2022 09:50:25 +0800
Message-Id: <20220606015025.180840-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606015025.180840-1-peng.fan@oss.nxp.com>
References: <20220606015025.180840-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb6e269-4c92-41dc-c101-08da475ec80a
X-MS-TrafficTypeDiagnostic: AM6PR04MB4840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB484015676942256600C24CCBC9A29@AM6PR04MB4840.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOx0E0ovmDrpKhttjYRtpKdXPDxKnTYTPJY0QDpVGMioZa5yreIKB2pcpIPDqc7mnI0o57teQF8f7IgcWnoOhzU4IdPMVoW451GNL+4kzP1PgUp05jqokiy4bATQbF4QDfsNKPPfd/Qgrlx5qzV5oC7ymfuWouOFZF3r19LyunjiwJQH7xmC4Oh/2k3mz2itpsbpWAgL67MQWl1qlJHFki8my2mN+jBSnOGMflRyifp1K5nDxOtO/IqbW+QQxHBIFIEKG5yTqBSL7hJfP39Mi7ANeR+gvyXNieHiPq/lC9pey0qYt4x758g+YClOSKn3QEFaqVYFZg156m4oW4vAbHH9LK8F1XyCEc5reLLtnZ3li7x6pPM/RKk5/Ax4Z0TqTHwnxXmm9KV5BABPIrX1l2P9oHpmAs0BRohG90uQO3+g7DCz19fEpSbcvIEQzcWG7IHGfQRx8nbkOJPQTYH3uT3gVxHNit+s5GUV59vLycM7w/IrYfJfNunuYh5WQNODn6NDlWge6eDoBVpkmCj9Njrfs1bLdZygKWOPtGF8sEThiYVAaqDNO54+vOrTWycyKXLX1nO0yDGOpYLZMe4xHFMN36jjqQ/lHZ19EsT77wlTdiS2GAVnhIzLtcRjXRxdljjy59yFCiQv+XPsUPtQ78r1r9OCoMU+z04GTXjfUESZorjFVshoEXfuX8pCxC8UqWLgIoGFInj5DYpMpGTd6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66946007)(7416002)(66476007)(66556008)(5660300002)(2906002)(8676002)(186003)(316002)(26005)(83380400001)(1076003)(6512007)(508600001)(38100700002)(38350700002)(6506007)(6486002)(52116002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owN47qhNP6a83otnDdK3NsSpMgbiz3Xl/6kKyk6B9T3iewX9NkWhKNnNAfUQ?=
 =?us-ascii?Q?au5WeKftjeDZkiyWQ9LhCaNG1/mfg0tWeVtBPVFYJlVAH8IXXATT6kRUyxGB?=
 =?us-ascii?Q?HzBZMdxEcylEpdzXCB9sflUKgc+S6Zf2iuw2KduY1YSsJYo8UKWUtGryZJ2J?=
 =?us-ascii?Q?xtGAKi9UUaXyBA40w+ZY8w39LfOgbBe4Y6glJyGr6kOwDYIsb1WHP1VIGf+U?=
 =?us-ascii?Q?lfA6HMo9+4YpIEGYBi7TQ5njx7CjctiE254GT76W0n+W/nCYtiSM7DdsM6zt?=
 =?us-ascii?Q?yDngq6Eib56CQEcN++mC9lPaTNaKWWScNc/LmhVrlCSsG4bdojjiOlgZL2Vm?=
 =?us-ascii?Q?GZLm1ZXfyVBNh8vT/KpkQL1X9nuGaFDr1t+CjPzyJ335Yw3nWhdIB9LPhI+/?=
 =?us-ascii?Q?EvArht0L5fAmL8Zya4l3DtqUoV4J57gPzBtjrHadj821TJQ4t3JNBuPztdBA?=
 =?us-ascii?Q?/CkKSoTkqZMONSbU2irdc+V6wNZpXdfwxGliZ4IAmHv894OqBqJTq+2wvKxP?=
 =?us-ascii?Q?FPm7AGhrUrhUKfApOwwVHDfN8TymvAeS56VKQ6wOcpWZe1HYeVeL0kwKL+j1?=
 =?us-ascii?Q?EhXIbQCmjToPDX9rSF8IJyI++xkZWN6SH2G3i6+XL6D/jwTfq5+Am5Y1h+2l?=
 =?us-ascii?Q?0tgWkxK93dw/jvZOjGuL2nEuzWM6ZhM0IEmgA1mHPeIbnTc5MDmTJL4sYbgz?=
 =?us-ascii?Q?UeyIlYjNmz3bf6uz0AfYqBCVY0pOA1xQYgT0l3t+jmEoZkQv6D/3ixoF7+wW?=
 =?us-ascii?Q?E+p3AamWT9/lTjTTuYBsI/jWWSREjwocmDEtF1eIeEkGNMVHHJsFf//VSu2P?=
 =?us-ascii?Q?j4siwT7v1icflrCvUL2zCdyf6/Fni0lbVOZV4l1QrpX85Luwd0g5+vW0LONq?=
 =?us-ascii?Q?Bg2jLWvKnYesAbe1Uqn6yYfvLI6cAYt39CE9loUGcuFOx1MYwQbsV4ECexJ8?=
 =?us-ascii?Q?9jwN+5NOrHMPO45c98JBd7gBZCDvDB4wYMSX5rHEh0fCx97vKDxshYI5mmDZ?=
 =?us-ascii?Q?OzbMwWv+gcUauJI3XrlGtz60Jw0nwF7JTM+K6/DDYayh5Bm50oRRgoKRdNES?=
 =?us-ascii?Q?piBKhGntQjUypxnvOqv7kk0ML3qzSGscEnIVy6nZsozuwFOMVycvAXSfC9VK?=
 =?us-ascii?Q?3hv+vMxgQaKvSnADv++TP58XcHLzsPQmY0U34UFRyIQ06xlu8ifW9vqyKEAS?=
 =?us-ascii?Q?EpG/09gqOkCfPBzYYxYwNwoyuh8pHrDvrhvNAgSKVzY5LV0k3kS9n3xm03CF?=
 =?us-ascii?Q?Co8DzIk6ZKQw0ZozkUFNQTwz8G6ymmyZgN7BHjiTvEiDRlVNc+kuCE/D98yz?=
 =?us-ascii?Q?1TzIzwevs0dtr2XuXQ+ppQlFYWG9Vee5+NsQY5ld2AFz6r1Ecsfct4AM1d0f?=
 =?us-ascii?Q?nP7RBCVWs/3Vp8qJbXglLHbgnDeyI+hBE6z/aT5c+Ah+79aeyHoP7uKtN0Jo?=
 =?us-ascii?Q?DNzn5A5HbHXVrWYPv2sdqiVlLPsfrKuSoWH+uUiZIOgn4Y+rgIl1Af68KJE/?=
 =?us-ascii?Q?792uvB/peWHye4lK9zqn4/QwdAzaFg/nu9eOhOAJp/eDiJ+/D0LIc+epSKfF?=
 =?us-ascii?Q?lHURqJgVXC9q89PamgJU4BAD2sD2bygc/rrrkMZq+YYS//XeKRlo28J/gCpq?=
 =?us-ascii?Q?zKzZLCZuYRAH6INsZc06A5UN2ny5iZgtYC01ubVMxohk9HidvN589ZczXrDL?=
 =?us-ascii?Q?TqnU/ssS8B6VzP/sI39xt7rD3GEj2jF3KAPNK9nnHih5qMblf8vLbpvEGXR2?=
 =?us-ascii?Q?amf1c2qYoA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb6e269-4c92-41dc-c101-08da475ec80a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 01:49:23.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbxcyewcEAlFA0DkQ1Sn13H/PFnvxDzo8qsex1qMOUzQtY5wfyJMTylbhokxHQSaJ0TsY+nfDHE9DJE46AasoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 mediamix blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8f0658e95e0d..bcc8fd296bb9 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -348,5 +348,25 @@ gpio1: gpio@47400080 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		media_blk_ctrl: power-controller@4ac10000 {
+			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
+			reg = <0x4ac10000 0x10000>;
+			power-domains = <&mediamix>;
+			clocks = <&clk IMX93_CLK_MEDIA_APB>,
+				 <&clk IMX93_CLK_MEDIA_AXI>,
+				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
+				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+				 <&clk IMX93_CLK_CAM_PIX>,
+				 <&clk IMX93_CLK_PXP_GATE>,
+				 <&clk IMX93_CLK_LCDIF_GATE>,
+				 <&clk IMX93_CLK_ISI_GATE>,
+				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
+				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
+			clock-names = "apb", "axi", "nic", "disp", "cam",
+				      "pxp", "lcdif", "isi", "csi", "dsi";
+			#power-domain-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.25.1

