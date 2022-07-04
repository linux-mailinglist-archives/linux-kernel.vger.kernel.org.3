Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2033C565B03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiGDQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiGDQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D347995A1;
        Mon,  4 Jul 2022 09:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk+n92RkAixk1FfQwqOgc3EWVYWF0VCo+PIzWJ/JQyldDSDlbb3P/Zk2E8De3UAN0vNqyt6bGSLzTflfDZd0hMqQR5dxTabooJkTPHUPv68E1OUXkyJEe9F7DmZbqoRinf530t3mdlNr0e+EmjWA22Z6YXtQG5nM1RhIfWMOQ5HEHqdNE5KBJpG0iZm5wbVr/x/7l9Tlqa3v2axsT425A8O7aQugnfsfuLG9m6VKlzMhQGgeLz/j9fa9HqJYBYcm7Yauj2BV6GsfSXD6nm+RGNZSK0PDXkAgDUfqbQns6155MjmOrUsWzMG4lZb0ezffi76v6ZrX6MaZqCXXEb29ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWNpL/Wgh3gXm+XW183wIMKXz3a40cWjaBNz2z6N5Zs=;
 b=Tcb3PH4wgLQCHUszSAS6GOxo65oR+b/3uO1eqDRzei/k53T+G3tdBpt/Hg2sNEXWrmSACySt0LKipjPduLABWoTJ4RHoa7znfK2sM83GsvHV9+3g6b49aG4dWBAwyAUa2IswXumroPQKD0wYclbNeC0Vm03AFpy7fldi0Df8coZthqyS52qcsLrqZ0FMONNZ3OHUbVT5XfDynUDttV31uGYapFDEd3QvGWN0306Nxj3UIS1HvFO/RFI6BY9aMVhGvJFMDdzrT0aMwt4dnwMDNPos8RlN8BprnlhwGgvi7m0W3t43Fwodx9SS78jET9VZvYiedoHUsr+XiZpVN3nLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWNpL/Wgh3gXm+XW183wIMKXz3a40cWjaBNz2z6N5Zs=;
 b=NSxYb/BHQ/kNF3iGTEtIANN8GxlsMWLWZLilFtguMepYLZ3GGV0nOuRzQKK2XsHuXaCF+xN8ItLrAt0qqUDPSuZCbIQj3YK+yhK6Xav2mqYcb7n+0as42Z/CTRljwKS0K15LzXwnNSpSR+BJ7WBC+DX71FtO7UKy0F1fqaOU5Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:26 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:26 +0000
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
Subject: [PATCH v7 02/15] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Mon,  4 Jul 2022 19:15:28 +0300
Message-Id: <20220704161541.943696-3-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef13b9a1-afc5-49dc-7495-08da5dd88b5d
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYu+jClD2zSsbef3axsTIpLd/+lOya1Krt7NwpFFroFQWRYcahDVQYrMRujJrahzbtIicpypQPq9t2cjab8sHonmV6ZFIoJ4VtgWBjNVFYJD9ZRceKbNBVW6njRt10CrpW29F66kg9705bmcmMePY19MM1Y31m0nrbKU8C8Zrt3WS/bcRGDfkUUAuFvrDMPgwmeT3lbP4NlZLuPD7CQXlfAThVCmMVSMsR84lYtnvdKezQlm0TmgZyGu+LJhTgaAYxS5x9JOiX0+KqVxOinjnenMyn6oGE6O/MSAkDjgDMLJ70Wy7ipgDkqfJa0ydgTNGs6LGIaFEuP93HjjzLySnte5XMbnS2Zf6aYeiFX0+JCO35LBCora0EcztRXbe4EKvjgMunP6/PWctn3b2xUEJppw5j9QVwYk3IPmoya35M0nEt90cGv5Qt3mj5irul3eK3QdkmPker7tjQ5YGjsTkOsgmYH/lZezFp9WhaNpNc+hg2wcOKfYcA3SNjqtyekFCy91Nwivsje00K4yr/zR9Cmgs93uFkTZ2A5gTl95aX/2NdFuYV4IiNG/gYp5ymuYaQjSe0UuOcPj6axfDDpw3bZalizuuy1X/s38eILcoPZDMmNUvPBtOrsrOhuH+I6Q6rIVur/H4wkx52/xY/fEgEZ4oKyQYdibzqbs/pbYpNoZeFTIvmVlUdn3DgNQPxGdBhhc8gQLccFD+hOciH2Ro1P4Tg+DThBDbJKgqTGAJ/Rfru4kfgqPP4Q968g+xzfKOIOoDo3Ad8G0NK7/9zcA9rvsxPxOMbgcB7Ae3IRYzLa5BSYwKulJfPkJccjjbURCETE8+nttynXKZ4pS89nDUA/xHn0PoTBJQMOZVCyj93GhRZi+40sBSNNv8hH95nJ3u72KMzI+mGIbASDe2VOGGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(66556008)(7416002)(7406005)(66946007)(54906003)(8936002)(66476007)(6486002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xEG3X9106mvQi3LvFfK4pwaA3kWpSDQCcxhGALaQv6tT+Mv7aJ+ojwcMD/?=
 =?iso-8859-1?Q?Pg9fNCtKa2Jcz4AVP/UkuvWivKzz50QqdKco3aX9BmJVAXpPuabwEiygVD?=
 =?iso-8859-1?Q?0h4S5FcyNzGUXDM7Ab1ev3hGoJYyAXb6kxu1qSQjLma2OTp0lWJ2/k9dEY?=
 =?iso-8859-1?Q?2GcFl56ifqIHR1VCm4N7bly4LD2XTw8+ajmW9RBSoUO/jdquBP/7djUmaY?=
 =?iso-8859-1?Q?/nCsvERqoKOmk/N9gSx971wTrxlkMjZ9VgHjJB1g72RmhDT+FkMDe3AMB1?=
 =?iso-8859-1?Q?ZTD0eM+KsrHAbXokF0/DEQo07nwszVXSV+/ZrYA5yBl7pwMqmnUc1zCPDb?=
 =?iso-8859-1?Q?Wl3aRZQZpdl3fy6Jvml2LADt2oF5s6Ne/SdFcGrc+8tRqY966h4tK9GDYJ?=
 =?iso-8859-1?Q?t/u8gRbN8rpf0FKnZYigr+SZVofQ1YUE+q84xANStr2HJN/LkGQL/bscpW?=
 =?iso-8859-1?Q?/EyU9KgkAekRosgGra7XGOlFLtpj85CFm3QjufasTxjpLxBjzrVoGDEANC?=
 =?iso-8859-1?Q?T7uVyrC16GOuVzP+R7nzfMO7ljzm9Vft4s5cyNkTbvx5iFA1M1/n92PTFM?=
 =?iso-8859-1?Q?DJJFz+sIjL0Uk3greGW3TYklQlOQe4w/+wUppV0AhGDePOjGMahJxA0wSC?=
 =?iso-8859-1?Q?ic4WnjahByICA6J4uf0s+ThrEbMWzZ5kvNn1cwJk0K/441W5chPXxC7j9o?=
 =?iso-8859-1?Q?zdFW7bR9YDIQWutz/70hn7SDaDVHIMw07axdf4oiMGcTrJL/8kjfq5rBIR?=
 =?iso-8859-1?Q?oxXr2BVCMTJ1eD7n6cXfY3hZsOVAW5HRUYmUqCdeXde+Nod1/8zKNRp55q?=
 =?iso-8859-1?Q?Tr7bZB1uor/6LLQSqD3C+Km4y2tcysRWvQUM54+XBmfeSEvaMC2mUlHL3H?=
 =?iso-8859-1?Q?oI382aRspzMelp3mmeNlnn2MJsPjddkB8lbHKNYbd2cWvI4uzrIh8gEph2?=
 =?iso-8859-1?Q?xi9sIsiFEY1rgmTjJ3QnnpgU6HeE5xWXC10Vx1mMrMSrpuTa85UG9I73Gk?=
 =?iso-8859-1?Q?EpCmyaEewQAXvEPvafDkHPhLuZRDifeVvyPUaRtVtgfF9qzy5C3C3+yKDp?=
 =?iso-8859-1?Q?kp0WtjLkN6I1+0Y34JrPAlCp5+95lPmM9jLDI66R1GDzbeayzJie0Oo2dm?=
 =?iso-8859-1?Q?NvoSCn9iZFeXxPEb9gMne6WV/FQj0Z2TkHcqQWwN4TCAneKoAsBVmaRUGP?=
 =?iso-8859-1?Q?syTaHtjwmAt6djn0o13yESXIqGxlFaWljtvPeyIHr86i7/PPwMjJJbpggL?=
 =?iso-8859-1?Q?JtAe6XnvKU7VTT9ERUygqfeRRX9CHoI5dqMoBEE9SuODsTzuZfUUMmkZZK?=
 =?iso-8859-1?Q?3e/CX24Pq3VUNYd5Jdz8W0iO84t1pq1HkF2L9AlxCMNdOmif71/NpW1UWX?=
 =?iso-8859-1?Q?X+tsy3RUOYykk4d6YiSsuzAWAxWIpV2HZWrV+djBqV4JAZYRcjIy/boAU4?=
 =?iso-8859-1?Q?KUPWJQdXRus3FodeqeCQpLKBDmhIp2EtkFrFPjOsvFMsZnv/REKusAxfr/?=
 =?iso-8859-1?Q?P73xLQcM8zpeRs3UmN63EndlXseS8+1nhT8R1pr3ifU2yyFeX+ecq9KNKC?=
 =?iso-8859-1?Q?iYdF4Y0phNAUPJKcUqYXyVVsNxJOzY8nfQy9Rxn2Gsrc8dlz78lWwKKDz6?=
 =?iso-8859-1?Q?bBNsJqGUpQk3K5jWMIe49x2pcLBwpBb/TQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef13b9a1-afc5-49dc-7495-08da5dd88b5d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:26.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EhrcQE+OUHHSOivZ200WdscOx25FHzd8r1K+IiF4XesA5eIRIWx3dmAdF0REhoDnQvH6cyk30PcmMcfJzwweQ==
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
separately the 'iomux/pinctrl' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 40 ----------
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index ef7f5222ac48..5ec2a031194e 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -79,33 +79,7 @@ Required properties:
 			See detailed Resource ID list from:
 			include/dt-bindings/firmware/imx/rsrc.h
 
-Pinctrl bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding uses the i.MX common pinctrl binding[3].
-
-Required properties:
-- compatible:		Should be one of:
-			"fsl,imx8qm-iomuxc",
-			"fsl,imx8qxp-iomuxc",
-			"fsl,imx8dxl-iomuxc".
-
-Required properties for Pinctrl sub nodes:
-- fsl,pins:		Each entry consists of 3 integers which represents
-			the mux and config setting for one pin. The first 2
-			integers <pin_id mux_mode> are specified using a
-			PIN_FUNC_ID macro, which can be found in
-			<dt-bindings/pinctrl/pads-imx8qm.h>,
-			<dt-bindings/pinctrl/pads-imx8qxp.h>,
-			<dt-bindings/pinctrl/pads-imx8dxl.h>.
-			The last integer CONFIG is the pad setting value like
-			pull-up on this pin.
-
-			Please refer to i.MX8QXP Reference Manual for detailed
-			CONFIG settings.
-
 [2] Documentation/devicetree/bindings/power/power-domain.yaml
-[3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
 
 RTC bindings based on SCU Message Protocol
 ------------------------------------------------------------
@@ -184,18 +158,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		iomuxc {
-			compatible = "fsl,imx8qxp-iomuxc";
-
-			pinctrl_lpuart0: lpuart0grp {
-				fsl,pins = <
-					SC_P_UART0_RX_ADMA_UART0_RX	0x06000020
-					SC_P_UART0_TX_ADMA_UART0_TX	0x06000020
-				>;
-			};
-			...
-		};
-
 		ocotp: imx8qx-ocotp {
 			compatible = "fsl,imx8qxp-scu-ocotp";
 			#address-cells = <1>;
@@ -234,7 +196,5 @@ firmware {
 
 serial@5a060000 {
 	...
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart0>;
 	power-domains = <&pd IMX_SC_R_UART_0>;
 };
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
new file mode 100644
index 000000000000..45ea565ce238
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the i.MX common pinctrl binding.
+  (Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt)
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-iomuxc
+      - fsl,imx8qxp-iomuxc
+      - fsl,imx8dxl-iomuxc
+
+patternProperties:
+  'grp$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      fsl,pins:
+        description:
+          each entry consists of 3 integers and represents the pin ID, the mux value
+          and pad setting for the pin. The first 2 integers - pin_id and mux_val - are
+          specified using a PIN_FUNC_ID macro, which can be found in
+          <include/dt-bindings/pinctrl/pads-imx8qxp.h>. The last integer is
+          the pad setting value like pull-up on this pin. Please refer to the
+          appropriate i.MX8 Reference Manual for detailed pad CONFIG settings.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            - description: |
+                "pin_id" indicates the pin ID
+            - description: |
+                "mux_val" indicates the mux value to be applied.
+            - description: |
+                "pad_setting" indicates the pad configuration value to be applied.
+
+    required:
+      - fsl,pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl {
+        compatible = "fsl,imx8qxp-iomuxc";
+
+        pinctrl_lpuart0: lpuart0grp {
+            fsl,pins = <
+                111 0 0x06000020
+                112 0 0x06000020
+            >;
+        };
+    };
-- 
2.25.1

