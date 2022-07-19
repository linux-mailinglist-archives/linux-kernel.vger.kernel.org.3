Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85534579451
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiGSHfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiGSHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:34:30 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10053.outbound.protection.outlook.com [40.107.1.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76033E0B;
        Tue, 19 Jul 2022 00:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpBWhutOPn3quST+S5Qj+va4FKUewlAksHEgfJShjhfZ8BNxoavt75Qn/s7wFqwPuM1Sbynm3e1iVpkdA8WupOdWZd0VRfamJrhJN5OnZAMbOx9dI5N4pf5u+lG+r/46X9LMQkqNREY/MPjn1xHj3cQM2pe8zMrEZvugXij5VGThrOndPoO9eVDsEKNhBJyGxWF8gKmJRwxFc8+Dcw/ZtCT5yv8zb6+SkAiqjIUGbOd8fldwEW88M+w4bKruBPpe/uuajZvZFt0+9ezapSJnW5b0R1s6wmcykIop4WmW+vNdvHfYD8sM6hcpNPl8MeosY0tjrm7FaJuoX0P739QAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5bdDglt1tblNlLtRJCdYhFCcgZcKfaN0LdTUoF47Yo=;
 b=gvmD44T6Jwjilb4BejkjORhDg93xMbZtOD7cgMiZDHu6mcH0HAbuvkkrcNd7nrnzr0Y//ZVrOm/THyswdi3nN3m8/AwGGPCtTt48qtukmrYTD2y3zi4mDZPgKe6L8rtgxtfVIuVFtnBOITzO2GWEjdVGXuR9Hf6QAZv3oK0+oc7BzP+IZZ3xDeHQ31nf/JLyH+VfdhK4kurttJoZShs0vO0nXEXl6ESErpEJpIWUOnkbEBAEOIZzom/FrC6zBBdSlyuQ5ZKwNDCysmfK0uQh/hGqEzLGrZfW/I0bMxpVkaUGktuWrO1P6XCdNLrK9QpCPhY4qqEZ7C6XHlw2azxofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5bdDglt1tblNlLtRJCdYhFCcgZcKfaN0LdTUoF47Yo=;
 b=eZd+c6xfqSKdm8SEW5vrb5toTdeMw0s2b6LoEeP2wbeeAxQjakG34p3AkuWWoyc0/3W85D9W5VAsoqllIa7QIexC6pJsdoj/eTHhGeL5t/j488JRwxHFzpTc9if7l0rTHV+GqWNUn8f9xRFi63aV8ZICbyHYBDGJ4u0RDiGmMnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 07:34:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:34:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 6/6] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Tue, 19 Jul 2022 15:35:41 +0800
Message-Id: <20220719073541.197788-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719073541.197788-1-peng.fan@oss.nxp.com>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ac5a78c-0d21-47c5-336d-08da69591b4a
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C91dIrDymFFsCe/ADsmN8TIJFL6NIT1pMq4tP3zBqh7pgJ3r4thnqulCy6jSyPeACq7eUd2oh7064hZ2xGKoI88PeRS0/T5NtzQi9YmUsZX3eWN1NMWeTwmKhsbYbFNk2rx41ehwqNINS/WHXRykfzKsJ49aGU/J5y4hYWxThj7qM+4ligvDOI0BLCFAJjWRvlPBNZ+23o/aJDFwijioxHMs/mCXJrE6DtE7iN6g1VBC8mr94NjElr2dggxKHft44txrddo2NYu0nem3tdcByPkI7NUMunPsp4xEEVkcbvSl1G8osc8j/Rx5cjiX5fqFjHVv02hn2UD1gMaNP7EWlrS5Ta9qHFNWzh966y2XTd4d1yGYOQcDSK1w8ls58VFn2DRqqNUC1HKaVc6codhv91AvDPBaautFLomKg2GnIZyPDw9aFWJ8aEYvTYucoeVxhks7IOVNzsYAsGV6wn1F94RDCIYRdAdW5TRXWcKq66y8kyaepszRXtAM4esFyu3YPSV+7VPdaFCcxh7wpvwSfuu9ZgxxS7eemqEsXjWEDJ4De9qdznJ2dSvcR5qkAN6q6akLerMEGDawq7M42QY1DsVNqFgzLsLrxAmuyzcyV35SuS3s6HkdBSEvR7QRI61o+0uU19iy8ja2F3iyRQMia/2FIj0UVFku+yxlO+zRAcJnYo9nykVcc8AOVkBx8o01OWP5ASmSHU8Jq88pBV+3vsFHM+45Qd+zrkp1Frhhx7rmOzTT7C4gaMY1TuU0rYowUHRSq6+IbIe+/6P9QG+IwuAUZDL0z1X+ydYEhtiCOFD2CTmg+xKHwdmk9zsv4b+t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(38350700002)(38100700002)(316002)(66556008)(66946007)(8676002)(4326008)(66476007)(186003)(26005)(2906002)(41300700001)(6666004)(478600001)(6512007)(83380400001)(7416002)(2616005)(8936002)(5660300002)(6486002)(86362001)(52116002)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SvYPRMEZME4TTvSoyxdwQoGNfjc9RkbyOTp5389mVgv2a/a9I7bRu9hyHDH7?=
 =?us-ascii?Q?vEjvlXg6s76wOkwmOVa544vevyF/RXTKF2ovWrTzvZFxhtGhhfmakQOnti9p?=
 =?us-ascii?Q?ibG448qZDuOJf6dg8qD2yf2VfpSzWeCv8/ZFt+dhRLoFuUKJpDLUwm12Pi3k?=
 =?us-ascii?Q?PCH9we8jPLFQt3PvCQ7mcANgFn+JxMl4kBCa5TCwbhGwDFXY3l+uvRkuKDrl?=
 =?us-ascii?Q?4mLeSoHq+YLZJzTSluVnM1NmyU6FbKYFw2SOEeEORDxrqG+toot8JO3fMGbA?=
 =?us-ascii?Q?7nY62k8yPK3camPMwHrzcMC/VCxMCy6UKxZfExOjIRYQfwgoxg+DFQ++Cwkx?=
 =?us-ascii?Q?2IMiC6rfKBkBYzdRezhT6iMbj+41FFwsC3qsH7EYu8ZHPeMz6t+dON/jr0vv?=
 =?us-ascii?Q?NF2DfegHTAw9u78gekGa0lEuj2CMSNBUJ0cRFxj3fBuSNAIsb9q/dyhugxtL?=
 =?us-ascii?Q?wy33FdqHGz0MrBco5rC8aOaBBfmqonKlh2/PH7cr2jpcdyA0DTreT1tYybC9?=
 =?us-ascii?Q?lon94NsJmuFgXXytAeo1/i6U3V0KZgXnIGE8zNxH+Ok0ixz5TmpFovui4hiY?=
 =?us-ascii?Q?8doYj5jLRTuhx1yMt8OJUykurCnjGxzWzlF1DJdu/ipcT9TQnj+3kxvxdJ9r?=
 =?us-ascii?Q?2F4qTOCA4ruEsZMy91QtJpML1D+vwsR3uHFCrsb23FQ0mim7yDdLZduwYyLb?=
 =?us-ascii?Q?ogJu0skXGFJtDFNC9zGf9S202hgbwIYUN857aEg/x/YQs+TkS2U97/2G8gDe?=
 =?us-ascii?Q?ZTEqWiubDrTnTnTJCfaamiTRvO0wNfbrVg4+KGCJPzqciTw+U1iXAIGPgqtl?=
 =?us-ascii?Q?lW0JPeU6/G/B3HZmcXlMrjtOPouDO7J5HpVJI8ZU4q5X/yL+9N3cfvLkk7yd?=
 =?us-ascii?Q?IFwisoanIPTeKDHXr4kPLF8YO+98XlTPi2FsFJpSDs7OT1R+j/YX2hAQquC+?=
 =?us-ascii?Q?QW7QgyEfRZF4KM/QAO/AOaw+knWGKHfDHhLSieTBXnPKskOdgvIhOrtEuqXh?=
 =?us-ascii?Q?NuV9FQGDQFmk0CBUEP5FgHoH6HAbIzQK72r7t7/GZmqzRKa+j396KH/EWS8s?=
 =?us-ascii?Q?194ojXy0SwbC2girmzY5fPebYfHw9dKOdTB0f+L5fEVQbm5oDZndJzabwo2g?=
 =?us-ascii?Q?xx8l1bHfqD3J1T+snPcEk+raOp0NHbTinF9gaiBE+PJyxtMMtm5eyfEu987F?=
 =?us-ascii?Q?BkhVPnbwiF+PP+9uMI9ISpXjkI+D+5i/Dgz4c4/BQexymWdPBFxIuFLA78Jt?=
 =?us-ascii?Q?As2Su40PQ+o16k+jM1VBE03I2BnfPKQM6xtO83tQnjDiHVXUmwf54BtLXCej?=
 =?us-ascii?Q?1bO4gePQcB2C5GzD6P09S3qFIIgSZgiwv3hiGt7wNc9ei6W7LhcHI3OpSnHv?=
 =?us-ascii?Q?4ue1efrkVYlEyHhcDr+aZRmhMTWmwONi8etQXsISeKzD+yn6BtPsc1dmMIBU?=
 =?us-ascii?Q?DJQkBiTd0Dn6yKL5B2c292FT7LiWv4//ozWndcwyskGCDZr5JPfswBri3FE7?=
 =?us-ascii?Q?B2EeiFBDuZoDdvUFygZ++bmgfOnUyO/n1OY0k6wsrKeZomDsaTcU2w347Emi?=
 =?us-ascii?Q?ClWmVXJKo5AcJ81mwPIiYgrPTmTFFqFO3fIOVdUA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac5a78c-0d21-47c5-336d-08da69591b4a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 07:34:25.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZSmNrpN0Kku7L29RR2JcLGHZBj6QfOpWrIx4q8S0GWTcvSQzCkTAJdevu999yXAMKqN9ZMoiNrlTLsvXGb0Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7779
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 mediamix blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 883d38920db4..7b93e5037a27 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/fsl,imx93-power.h>
 
 #include "imx93-pinfunc.h"
 
@@ -346,5 +347,25 @@ gpio1: gpio@47400080 {
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

