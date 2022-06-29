Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829F5606A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiF2Qrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiF2QrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:47:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445553EA86;
        Wed, 29 Jun 2022 09:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOSdkI28aG3RXe2VxrZjDSzwRkdN4kVFOVWBwtE6+9IZqlWKbiY1wE1ecFwjaxsOv4G71pCulC4yVe01iTZ42lY2+BhglIzhIzKyPhh6mqTiB/HtFGNVQhuc3PL4yLrS10xb6Q0lkxuD3gT+CKn0iraEDmgtgaU6L27tRlkiaVQBBhiqIumFWklt2LWUu57nLbeAEC8100UMuiRcwJm21JvT5erIHYWPsx9Ca7xIKuIVGM3jidprro6jCsBskAsR67avmnYF5af6Tohvzq18cE+n5V+EZ2VOtvnmM2oz1kNS//71LDvkSwFn2junb+KJvsoFdH51DXsZ1FgnJV6Mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1zrSUoeYfA85nnDGnCyS0YsESQ2iNulAKwh70Eex5M=;
 b=EVBLjK7E8sYMyip/2kJ0XfISJ4bsYHDl58QmGWZRbe2PTfvY0naXG4ae5/FYNoilzYKIODKOr+Gxo0fiefE9Dn940vKrmPuco5YrCbdkagPrcPBsYgfQZaqn7mvI0JzTPZ7AIUjGJEJG0L2Hk1kmUp/kcRUXDjF6zNUVopJ/EmWY6CEKICjjD+M8YPZuMq5mlQtwvtqAmKW4IY4r8gonedrox148tO4yUD9t0u7kviSdrq3cKgdCAhUwxrHrV/bvImKoWLnoNUcdIk/t/opZVlb1b6gsh4eQm1/gR/cdIeVtZlToJQPaU+ddpIl4dreVmkGaHTyhH+UCYSN9b5wV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1zrSUoeYfA85nnDGnCyS0YsESQ2iNulAKwh70Eex5M=;
 b=FtGHex+tn8U0pnewiPNsLD9/QZS/75WMCBpZhFlFPSJVGNCDDzpycSYz24BLlVKRkJ7txMGKdNdoLc/6CnT0bVgPk0DpzIUb6oeqaUIbDjRUk6G5Jdqjxs2jyclKlIgjgigGgDbnCesxXluVaPoiYqdFD6iBqc6OZiIFaWs3Jvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:37 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:37 +0000
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
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 14/14] dt-bindings: arm: freescale: Remove fsl,scu txt file
Date:   Wed, 29 Jun 2022 19:44:14 +0300
Message-Id: <20220629164414.301813-15-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7473372-ec3c-4cf3-20e0-08da59eecae0
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDdcq1HRN33XhSDw/FcwQwDHkFJD0k39X3h/XqoI86psmPxPiewiroHjiu74KZdg6Dbf81uQlGTZKH9ecbfYO4bO0FZoLfgCPAsO8RykOuiehtX7hah+3qj6GXdkLfII33xrY+dynrhdfRje1vifEz2wmiaEEWlIYDCaJrEbmon83ovv0rIAMmymxb7AZ5pBSrAEbx1GUNTVAXsWZMKZFWwy7zM7wKq1mysurbQyXHrVWvMf/ggO+ZYroA4j+6Nywz1lCroHbGQl+N/GbFovNd+Nd11nT72Lqi1LljRoC5NEYjm/L178Q/9Bf/qWMFuzitx183JXFgsYfzF5GSjipJuBcMHTWCKeYMOtUclV1HX7HtVGq0iN33N3YQP2jIYeQ3ybubUJpJB+4Qic7F8JkUk7vwjuqVDZPd6a/ZPXhjQnQbRiGy54ybXdczmuidNN14TLyFv75kbi9Sfeka+mn29793v+y5k38pbP5NmuWYanM2PdbsNmrTpERpjyzZEdP33XbOnvvEaOGLfnqq//C0Pu87Pp323SgTakIxPAkNOjFARiKm7p13tAafcFMauf1lY35idBGxI2h2MpH0BQHEDEaEUWhHyB+5xZ2IaUMepsAYwYGee6tpNHHzf2gCg4ac+18uTuzCq4jlWMmmWgX2TW7TlZmOOxwq5gRWYSvYOczdPIAoDMAdSeEjb7O1qO93Wx+rsoParidH6+JITtmKYTfDOOdSF5W3U+6h+NXP8fJKYiuWgz46hVA07WY7iWsFtjyJI6TLsmlFqDHuHMCBn2mGWOVMZinMiP6E75cIqbEpLUCBVBWgGO9HvQXg1m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(1076003)(38100700002)(7406005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5T6HOcg2eqyngqp5d5NhJU+YM/47isaaO5nZYMT9+Zsx/GgX5mC9zzTjL5?=
 =?iso-8859-1?Q?lgnnkE0LddFVnYf3HDZhjsX4lqvkoFRtdtnjl/DFipe2m0bAUBlGlQ/Ket?=
 =?iso-8859-1?Q?whoF/kmupdLPNjQlGvlJs7j8GnI7l7QhOQZtLeWG+dbT3i2s0x9t6zBeGX?=
 =?iso-8859-1?Q?nKbF8w6gqiB67S1UaCPfk9ttbTSHhJsalUct4A4o/79D38b3VwU7B0y8EM?=
 =?iso-8859-1?Q?j5ZrLCvl8TUbunRQb5JamdroJvMvPOlP/+C8U6nxGJb7I9eC//CMA7lQeI?=
 =?iso-8859-1?Q?/2VTm1WGUg0j4HSh9VfXCMeGZdtilfk3EOlC7xkLIP03C2r+wwptESOVx/?=
 =?iso-8859-1?Q?ftsQZ9SG5m4Wem0u072v64CJajSPYjhG4vBdeRkOYi1RoT8UrpAwBsSr69?=
 =?iso-8859-1?Q?ohx/K3CfN59s2incoFhqhgYK161WDAgPYITACrtnIHRWydkUn5xEtBSQrR?=
 =?iso-8859-1?Q?AY0l4zF3aS5szeQmHzpVmL+7gqGjL0fseHgxWCn1yzoR97Q/FrMXyaAYZw?=
 =?iso-8859-1?Q?4uZkD1+bM/VruRYU29NME/IzPU3iu4mzN3QEftaCvExxjk7zkYBT5IVmoI?=
 =?iso-8859-1?Q?nyxEvBCfo18+hq/NM9Ns4fRyLu3kurhqPOxaS0txbKrmZy7Bi5aljkqzi7?=
 =?iso-8859-1?Q?NW8B0oqX13hbRT4/Mlb02x3VE80qLmCEP/bCzEIYn2lvcrpvD6LH7Fcdci?=
 =?iso-8859-1?Q?iyWMHvqXKf5zBeIqDXcdte3y1j+K/OHzxjWRfeeViMLnj7V2AcqahIkSyU?=
 =?iso-8859-1?Q?SRug8VQM+TDk6ax9FhXM+A0qjLN2UJ5LM33k/JuWCApL7j5q03Y2Sglhg8?=
 =?iso-8859-1?Q?4cxLAWuujNtollcjuMDWWKCeC0uifCWups1i9WTEzJPJjwKm5tlec6zdPJ?=
 =?iso-8859-1?Q?Frt9m2VAc2ea3CM9Jix0FNFR1bImQ6yDYqR0QRWqlmW/PCNBfU5KlISSy0?=
 =?iso-8859-1?Q?zvRBOIDuCm07v4NukaIG+CjdGUPHAYeqDNz2+d8MIAriW8nX0Darvr2WkN?=
 =?iso-8859-1?Q?pw371ArFH3xQfbtbpeIFVM56+zDzMY6F6UMxSZ4oGFKJ2MKroe3n+Y+wxy?=
 =?iso-8859-1?Q?I6w9ioO2bIco+56+AvDaKlkgjcFiHkaJROQ81Sn1k5UVzXBaTbC75LU1AR?=
 =?iso-8859-1?Q?A+SPP3hPzSCmr4Zr66wzFCdcOT5bEiU4cjoZYlLzT8wm1YOo1r12m8yaYq?=
 =?iso-8859-1?Q?/CR83LW5zKkiVwAkYSwAFGy58+X2rPLTvQUD7hs3bybCOtLRjNAlripOYB?=
 =?iso-8859-1?Q?AIu7y4YURnmsYSUXd6IAYTwKd/7ch8Yk1pOzQcY+bPEFpnjBwKIye1IGmM?=
 =?iso-8859-1?Q?vUiaw3hr1mD2Xv4bYp+YXhxl+nDcn1+7HmZhD+phxwo1D1Q1km3VjEHrUH?=
 =?iso-8859-1?Q?7y12z64YH74fJ65UBkMtQswc8w85jJoWeUTFKXoNG2MKd+HpsgA6K0nAKC?=
 =?iso-8859-1?Q?jyzRbmtjauxMWo92iNyfYTKV/sMvrr/M0gHjTvdLGaCUg3rAOb/Ea+G5bP?=
 =?iso-8859-1?Q?XZHWrWCAZHY+7qGOMbm2GC70OmLrWXtP6qvv30gYLhRuRR6MNIp4J8B26b?=
 =?iso-8859-1?Q?vuPS1sf8O2CStl/s7BFFLUsYNiq+31TQvG25YIQeOS5cUK8AkCcYDKST4w?=
 =?iso-8859-1?Q?3UgDrAeWnpLHp+ZP2EplxR1kLaFF3UN2oy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7473372-ec3c-4cf3-20e0-08da59eecae0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:36.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WlHVIxwiz7dF9X+bBoAR/ei2pcauxZ8QAa+Sb8P1hOTkJk5zjkenJqPCj5w9E8zKMWZD789PPwub6evPbiKPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

Now that all the child nodes have been properly documented in the
yaml files, within their proper subystems, we can drop the fsl,scu.txt.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
 1 file changed, 271 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
deleted file mode 100644
index a87ec15e28d2..000000000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ /dev/null
@@ -1,271 +0,0 @@
-NXP i.MX System Controller Firmware (SCFW)
---------------------------------------------------------------------
-
-The System Controller Firmware (SCFW) is a low-level system function
-which runs on a dedicated Cortex-M core to provide power, clock, and
-resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
-(QM, QP), and i.MX8QX (QXP, DX).
-
-The AP communicates with the SC using a multi-ported MU module found
-in the LSIO subsystem. The current definition of this MU module provides
-5 remote AP connections to the SC to support up to 5 execution environments
-(TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
-with the LSIO DSC IP bus. The SC firmware will communicate with this MU
-using the MSI bus.
-
-System Controller Device Node:
-============================================================
-
-The scu node with the following properties shall be under the /firmware/ node.
-
-Required properties:
--------------------
-- compatible:	should be "fsl,imx-scu".
-- mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
-			       "rx0", "rx1", "rx2", "rx3";
-		include "gip3" if want to support general MU interrupt.
-- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
-		rx, and 1 optional MU channel for general interrupt.
-		All MU channels must be in the same MU instance.
-		Cross instances are not allowed. The MU instance can only
-		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
-		to make sure use the one which is not conflict with other
-		execution environments. e.g. ATF.
-		Note:
-		Channel 0 must be "tx0" or "rx0".
-		Channel 1 must be "tx1" or "rx1".
-		Channel 2 must be "tx2" or "rx2".
-		Channel 3 must be "tx3" or "rx3".
-		General interrupt rx channel must be "gip3".
-		e.g.
-		mboxes = <&lsio_mu1 0 0
-			  &lsio_mu1 0 1
-			  &lsio_mu1 0 2
-			  &lsio_mu1 0 3
-			  &lsio_mu1 1 0
-			  &lsio_mu1 1 1
-			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3
-			  &lsio_mu1 3 3>;
-		See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
-		for detailed mailbox binding.
-
-Note: Each mu which supports general interrupt should have an alias correctly
-numbered in "aliases" node.
-e.g.
-aliases {
-	mu1 = &lsio_mu1;
-};
-
-i.MX SCU Client Device Node:
-============================================================
-
-Client nodes are maintained as children of the relevant IMX-SCU device node.
-
-Power domain bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding for the SCU power domain providers uses the generic power
-domain binding[2].
-
-Required properties:
-- compatible:		Should be one of:
-			  "fsl,imx8qm-scu-pd",
-			  "fsl,imx8qxp-scu-pd"
-			followed by "fsl,scu-pd"
-
-- #power-domain-cells:	Must be 1. Contains the Resource ID used by
-			SCU commands.
-			See detailed Resource ID list from:
-			include/dt-bindings/firmware/imx/rsrc.h
-
-Clock bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding uses the common clock binding[1].
-
-Required properties:
-- compatible:		Should be one of:
-			  "fsl,imx8dxl-clk"
-			  "fsl,imx8qm-clk"
-			  "fsl,imx8qxp-clk"
-			followed by "fsl,scu-clk"
-- #clock-cells:		Should be 2.
-			Contains the Resource and Clock ID value.
-- clocks:		List of clock specifiers, must contain an entry for
-			each required entry in clock-names
-- clock-names:		Should include entries "xtal_32KHz", "xtal_24MHz"
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.
-
-See the full list of clock IDs from:
-include/dt-bindings/clock/imx8qxp-clock.h
-
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
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/power/power-domain.yaml
-[3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
-
-RTC bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be "fsl,imx8qxp-sc-rtc";
-
-OCOTP bindings based on SCU Message Protocol
-------------------------------------------------------------
-Required properties:
-- compatible:		Should be one of:
-			"fsl,imx8qm-scu-ocotp",
-			"fsl,imx8qxp-scu-ocotp".
-- #address-cells:	Must be 1. Contains byte index
-- #size-cells:		Must be 1. Contains byte length
-
-Optional Child nodes:
-
-- Data cells of ocotp:
-  Detailed bindings are described in bindings/nvmem/nvmem.txt
-
-Watchdog bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be:
-              "fsl,imx8qxp-sc-wdt"
-              followed by "fsl,imx-sc-wdt";
-Optional properties:
-- timeout-sec: contains the watchdog timeout in seconds.
-
-SCU key bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be:
-              "fsl,imx8qxp-sc-key"
-              followed by "fsl,imx-sc-key";
-- linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
-
-Thermal bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible:			Should be :
-				  "fsl,imx8qxp-sc-thermal"
-				followed by "fsl,imx-sc-thermal";
-
-- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
-				for a description.
-
-Example (imx8qxp):
--------------
-aliases {
-	mu1 = &lsio_mu1;
-};
-
-lsio_mu1: mailbox@5d1c0000 {
-	...
-	#mbox-cells = <2>;
-};
-
-firmware {
-	scu {
-		compatible = "fsl,imx-scu";
-		mbox-names = "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3",
-			     "gip3";
-		mboxes = <&lsio_mu1 0 0
-			  &lsio_mu1 0 1
-			  &lsio_mu1 0 2
-			  &lsio_mu1 0 3
-			  &lsio_mu1 1 0
-			  &lsio_mu1 1 1
-			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3
-			  &lsio_mu1 3 3>;
-
-		clk: clk {
-			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
-			#clock-cells = <2>;
-		};
-
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
-		ocotp: imx8qx-ocotp {
-			compatible = "fsl,imx8qxp-scu-ocotp";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			fec_mac0: mac@2c4 {
-				reg = <0x2c4 8>;
-			};
-		};
-
-		pd: imx8qx-pd {
-			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
-			#power-domain-cells = <1>;
-		};
-
-		rtc: rtc {
-			compatible = "fsl,imx8qxp-sc-rtc";
-		};
-
-		scu_key: scu-key {
-			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
-			linux,keycodes = <KEY_POWER>;
-		};
-
-		watchdog {
-			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
-			timeout-sec = <60>;
-		};
-
-		tsens: thermal-sensor {
-			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
-			#thermal-sensor-cells = <1>;
-		};
-	};
-};
-
-serial@5a060000 {
-	...
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart0>;
-	clocks = <&uart0_clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
-	clock-names = "ipg";
-	power-domains = <&pd IMX_SC_R_UART_0>;
-};
-- 
2.25.1

