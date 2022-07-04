Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF3565B1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiGDQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiGDQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E86B11819;
        Mon,  4 Jul 2022 09:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHwpDJL4BQbTnTgFs1dFBLA4B0p777ZSIXeNW1T4k0Jj97Kt4MAnvy8sKM7yCvQtyh0Dwb5ctRdgasRtHheP1Qy205DZ2YzV9Rb3Dqp/rf8WZ21S4+xZbRi5MGUNNHFN0kIV9kFkCMFa5Gtn9Uw0QDN2zQEuK2BxT3wf8f8W1e528TpgiYs6QKWlHl+bPbc0m6TV2qzKTn48KSE2U44g/d4Pfes4w98T+Tedhp/XvKn+QfmFn4AzPC7QTmm9szl5eZuzXN612JAvQZc/9EXuG/+mSalu5aft23s966iUceLWRIor2WbhgqxZZjqLYnIdtAp9ZzI0l4Xgg9Z+CZZZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmYZ9mY70MA/B7uXoEWTj9Yof2TG/9DkcAE8TY1pBVM=;
 b=oZUtR70pH23wnSDg660eHX6M4NpkETV4igu7Lg2qnzbEua+3aVfv+8mbzn6LgICjbZVTu3EwtLAgExLEah4fga+7SLdr1GsnJt0u4NvXfGWcBRTJH7jVwUN+ovPLICUBaHIwxtqOMdFcyZOowfK+7NDqIoWRNSJOCvAHYOWqgpl69oIbOCYAef15dB7SBacBCdSvfT0Lkc/LaSkoNz7E2lJLJRNXR+tF715kRbb/Z2X5WoaYYRBmw+ezTqA2LOTS3tqgg+u+0aa7I2IlnngcbF1jOU+Dm7O16GMN/mBGjd1UNSzTDzjZArB/wD7AgCUSxtxZGAFq35kRrRDeI9RzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmYZ9mY70MA/B7uXoEWTj9Yof2TG/9DkcAE8TY1pBVM=;
 b=CmsIGvNoKtIBf2MxRkNWSVuJh5WKw/YwFeOG4F9Bkqb2fEWecxmcG06+PHPdsTW3HKhGl+O6kxAbBolJ7AjjBnnql+tEYwG/upUT6+wzS0rG8pONsRAadnGK+9yOuqsnNal9D0Ihh/76/jWKlVsC+7iJsi1vQN3duDaBaToMDpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:38 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:38 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v7 06/15] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Date:   Mon,  4 Jul 2022 19:15:32 +0300
Message-Id: <20220704161541.943696-7-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51e831aa-84fe-42f8-fe3b-08da5dd89281
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bD9YW+LjySnMPVKU57v0HDgArt1o7eP9zIG9zLg6i3sbcOo+tc517DIWyxa57ecMjaAcgWSXUqHkFtJOJvEA1zqsafb0OJuKSLP+3oQn6C+PD9FEPGOw1iMBPdhOQk4sBbphpY7F8DtfLyp8UOa8iWWSvMMPqIfEnrVL25ZQAst0gIsu7kwAthftRrNzjjSq7i02xHtB02mrSZIpQ6QIQoLHSFOY0o6GZxNxUKbN0JzmzmTCb/fdLCVtQn6YyX1ybY+qbWXwJAiF/IdQlpkQUBMKW23c86CX84cleOYcrxRfl7R2j3FLpfSP+lahAjGoImYMA3kDbUi1wTnHKkiTs68NCUh8AySondUm0PEf3OqdJA7KFwLSUDc57O7apcCHnmEOq132YTDiymXFS8Z4lfiRyEoQSVJLMN/e1SUDfyi2NrEU5cxXALiU613/dkI33cRMAPZhqR3SQOk1s8kb+W2BO/SnmOnlmV5mPzauau3xWUyUcEF5J8BX8yjtJQMTDSwmrhFHkKCXofxjHQaSCc9Siq2hTiX0IoIVZRy6DkHFAnrmAt74Fz4bxDTc+SgBmwuAUBLZO7zcq3rjx2bnvc2dvWA9NkzukeLbOJMBU/mEbg96EwAJuOft0n9rq5U3WNv5uzvlhKjpuoHPJJjGnYEBnSXDq96olu0R2HoLBjLunhBfqDSZYBe8RchVF26FbCmpObF/QI0VSevhMhUd+ynEnZkyNFCSAZU5zrzgckolcVpUI21cie0Xotznej8izpacnzjO9R+DCNXxTswg8S4h2pwzXSnOFlRcOw43NONKyR/LH+4GjvvAZa6bzN4rtYcSfFNjtgKUM2FxMEcOKPaSIwoml9pHEjj3+N00NdjohzoVaIybwLU1dvEHqrZwU/ImM+Woud3iTB56TCw0bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6666004)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(66556008)(7416002)(7406005)(66946007)(54906003)(8936002)(66476007)(6486002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MwHIUC85qMUwqfL9yi3R9NNd32EvLGRuoyRbHv9QvSS5Ge6QvE25chhn6j?=
 =?iso-8859-1?Q?7Hskwx5ZlCtmmA7GioYjhPtDK+ORmSmzB43Qh0CIQyMs0W9awa5aIrgDzc?=
 =?iso-8859-1?Q?Eh10AduXNsLifMrOU0dH1CdP3LlHCC8Vzl0JuIkmGyEdPwj11jnVkFmnyu?=
 =?iso-8859-1?Q?Roa611IlncOoIk3I4EJpBXm5UGpxNl/HXEOHIcsup4lg5A5vUNOiqA001L?=
 =?iso-8859-1?Q?74FwyzCFlu8sE2tzGI/5gAWlI9HVuvGYQwtP9xpw5TaHWQoKNHn+msPybO?=
 =?iso-8859-1?Q?i1ryYakfJwfvHFub9WGZ7a2PIE1I53E8ob8BRPvBQuEqx8LtojhUcQyFri?=
 =?iso-8859-1?Q?OqYKjgGi6jflpZT2LJUAay2SQgsDMQ+BOKFawHVvUJG5JTQIXBLpJl4p3K?=
 =?iso-8859-1?Q?eg2LECw3IamElgrOKdOx7TFMa+KNddej4r5ZjTmRjrXunm/+i6ypcUwAgr?=
 =?iso-8859-1?Q?PYX09wgIKzpnerDgBZJvGxH7Xa/ekAV7dJL69CQeIEFd8Gdm0ZZ7bwyYRl?=
 =?iso-8859-1?Q?kBsIcA+tMaOQvNxhDOeSgo6A41H8zZBgqqd3dRTlBt5wEy3v6K3Td6N/vs?=
 =?iso-8859-1?Q?BfBMnZJXZNw4EkBhD9ZkyN2XlMrRyCqRBRCbEa2+JxGHFatSSjvbewiy4v?=
 =?iso-8859-1?Q?A/8KF7WF4U8CSmaIkmmbbBjk2VvXQgcTrEUli/95n3gTlyKN7Es5z/jcy7?=
 =?iso-8859-1?Q?1Y+PTur84kG/DWbgiTKEfrWLV/L0W9aR842MT5FPkHTyJYsjKvoQ+pqT80?=
 =?iso-8859-1?Q?mB/DQZpwLdnbcTzY25QyxYv+/QLiL14kVSRmS/TKSYj/UenjCruiUZrDfj?=
 =?iso-8859-1?Q?AtqfYXB2WN3+mauThDVnQh1u7eP6H8nQfk5I7uQco8lDukgAdRK1dfyJR/?=
 =?iso-8859-1?Q?pGHCHNctp8UToxo8o8Nd5g2FjRZtqf19uY/Io/vzgP8XMErWdC9TE6Gk7U?=
 =?iso-8859-1?Q?auIUnn6ZMaJWPladsGwiqMj75z6/HXgueLXx91FF2rzvkPzNHc9nv4hZvT?=
 =?iso-8859-1?Q?rhOE6TkI0JKQZ9oh/YsXHofetsWQNLmN5AwkELZTqiQMrndhssCDeUcZsn?=
 =?iso-8859-1?Q?SpZkyvlUZKFc1agIZHzIKLSblwwEukvq9qEqgizkRYJ30Pz0qddWAjVLC7?=
 =?iso-8859-1?Q?KaDgjFsPaainDJ1bX0QBZ7T/362SsS0HTN08EmtWyH7GMuRM0GaAMbo+6Y?=
 =?iso-8859-1?Q?RZLy2+fhlSRtLq2jRcA6Pn4GNMRmaarFxoDmfL8gzYI6GE/egWqA2Bze3b?=
 =?iso-8859-1?Q?Ah/Wp5KYJeMSfTcS2MkC9jGt7l0V4B9W/U/tSuw2fgboX+++ZjA89oucj9?=
 =?iso-8859-1?Q?GftsMxsietfvc0h/f9sJF6DGHDjl8Xek03nqclPiavuuXfJlc29TVvHlc+?=
 =?iso-8859-1?Q?KRp9tgTcIwM2lWPkH594ad2Q2DKYquYAEED2bL9qPhPGoppWr8BhjjeWBA?=
 =?iso-8859-1?Q?vOhfBo1QAIvGiEmh9ZqHrmX5jgaHvbwuj520rac6jTwx4kAvdrQoTl64Jb?=
 =?iso-8859-1?Q?mt0UZyz/6nNTR8uVfjGCNMv5+Hd5/4fuRfSTO9qWlFRh5goBzCuVrY4AGh?=
 =?iso-8859-1?Q?EdP0r2sIDHayZqatD1LWYMXagoXuAxZ/MKyxbITx1IFhii35NTqznXRWlu?=
 =?iso-8859-1?Q?cU8CY2Fy2xh/5OR2uI2K7AguMpVgjldxhW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e831aa-84fe-42f8-fe3b-08da5dd89281
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:38.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGBdhdZGJDV9/4iuab/LIT4g9vTsE8iK/xiMO0OEy3pNhucn/0Uggm5gTKc++7EOmJr/WD8DtgC0cOeyyRm5PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'rtc' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 10 ------
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 1a06f627b125..6c0161fa4adf 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -62,12 +62,6 @@ i.MX SCU Client Device Node:
 
 Client nodes are maintained as children of the relevant IMX-SCU device node.
 
-RTC bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be "fsl,imx8qxp-sc-rtc";
-
 Watchdog bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -116,10 +110,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		rtc: rtc {
-			compatible = "fsl,imx8qxp-sc-rtc";
-		};
-
 		watchdog {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
new file mode 100644
index 000000000000..8c102b70d735
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-sc-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc {
+        compatible = "fsl,imx8qxp-sc-rtc";
+    };
-- 
2.25.1

