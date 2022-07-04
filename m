Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B22565B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiGDQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiGDQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:17:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F390412ABA;
        Mon,  4 Jul 2022 09:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKvZzY0qyYQVPIuKlBVql5cvcWwypDAOZD80P9z3fJy7UvAmqJ8tGyHpSr6ZC3077H2YzbbCX/vSSl9uEu+Gf6tSL/tPkfyZ+yPclgkpX6PJmvWpVCHlaq8yKN42EatpfGaOTqsX+85hXV2r7GxQr4qv4+e0fpxsxJANDIwVFyqRo5q+m0ogch/KZ5KTQWOIIbQj6taO2NRoMi8S9e6bS7HM4Vs5KffxAxF4xSxI9EozIj7GhEawIduxZ47vbcqtCOk8qIFowy8XqDx/prxZXUOAR/yi/uB2m6ymLBOG5spay98pW5JiTr5uxEb3gQZLKOhtYo3II96xxkPPjTXRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJxBnLzrd9PxcwzDpELT9+5lajU/FdpKYt6fegVqy+4=;
 b=aS/TinquPknhw3o6CKM5TB60IhVaJeUYpzw3b6hIED1xJoxzjmp0MsAqsawTZqLRBBaRrNk+f/9EzZ1lEihWoxVfWpGzQ8QvDNJ79vnAHc0IZqoeByaMQpGcNaP687pyBu/iCy+e09nXb6iQkZMyFHs8k/jeP972HloLem8kyY9Tha3HJzqTT2Q3P5FiCdlrkC0hrNBRYUvPBCzpKrlrj1gfNl0zmjQc3GZuK8vJPaipKLp0oH2GEiMtCsMY9EwOo9UCJfPF99TTB/Ia+lLMRcnBE3J7m7R15ohlrrUx3TybZYPHGpT9yF7YWH/uDqMCAhi6vOwCMEZAff3TVKgVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJxBnLzrd9PxcwzDpELT9+5lajU/FdpKYt6fegVqy+4=;
 b=V0gJac0xru4jMhlC2xroWMJ8ArcA7KVvlLizev9P6koU6pXekV8gtO99LEthjEAgMfB8ed+C2ZoP/rK4XCnr4ArBNL/21VgVVm97HyfqzszBA0Po7gsF08xEtRB6nKQzuGaVMqHCGuLv7i9z9j76Nj51K4i8ADordUUk+Fr5Mso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:47 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:47 +0000
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
Subject: [PATCH v7 09/15] dt-bindings: firmware: Add fsl,scu yaml file
Date:   Mon,  4 Jul 2022 19:15:35 +0300
Message-Id: <20220704161541.943696-10-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ebfedda-eb63-44ed-938a-08da5dd897c2
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWzQ11qSatrt83C9CZCppc/rvgDn0lNN1GdJcxya2I9kZryNKeGxhHQMRjz+ts4i/l2RfqKYCql8WOFhGfbgZCxjCWLNBiM74I/6KcEA1eLls4tiEoZFL5A9KSd47TfyolOLrK6sBLuXK0Z+uQubj5SfZ6Xh5WXh9AueDq3YIVQwciqm9qVMSf2I26KnYGXJ3nv4de+gkE6MFnwjbWr0bAl53qSGdjQxE1tOZBLBYbMKL/K7gnKRJ8aRHayIdZJx+7WIgBxZGp+t7L4e/l3Ig8PXP5lnp5RFD3FY3VQmS1/OXRa2YvVZIFSOkK9KsSL5EwJOH5w62WWzQLADm2AdQB/m3bWQzz04T8W7KJotTk+c/LMrmjhHNkesSDov9iS6Kt1DgPeoPnkEBVT87TqX6sVHGBHYrstIvDSY2AzFl51LNPp4MPO+iVeUikPNiN1gJazQzNHeGCJ9vMDPzYONdb4jEJ16CfURskfMVPiUitDIdqAZWisRckdehqgjdsfBeh/JWkg8z/DTb4VcD93xhb5pCuSxwlxz2x0ok+wHW/1yMW1O+b0trLKZya9WNyYkjm4pkljGsZuJazeRZNYsxpw2r4GhQvKK1rC+buPncLWLq1/eNg7srhbKIzisk44woRyQkbLfWwSItp2nm0iwmaNIgorb8Ik0VExf9X8KWirQJSEQK2h0N1ztyFFuhXsYiffTiLcvsVDmr/mzWIBqbGfh8LZ46CoqmpFgilVAQPxLF/v/6EFAKxhoPBF7bmJUHDVPKJ5G0GW5ivIPC+dRJ19ssPs9LpH49/o1W1uokX7UIn7ga0PLo4w4xlXRiwQJoHjEMulKgp6GeJxRd7pXRmK8CldNT4Oc2U13VQGVOEV/kC7xLUUe0u6OCnNKp3u6movDLmqgXpCRpiEu1U/5GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6666004)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(66556008)(7416002)(7406005)(66946007)(54906003)(8936002)(66476007)(6486002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?F819GibZhOqCfAf5l1XgKgXSy9VNHF/XBpbLtLJ/+5hI25NQxFHgVGIU+s?=
 =?iso-8859-1?Q?PUgoVCEERf4M09GnlKt2yd2TCcI7xf3IYIvUzwyHOUK8T02JuT6x/3zj2O?=
 =?iso-8859-1?Q?SlN/WKkgsghm2mzT9FQirnH/TS+n3tJ6bA3lenymviUGadZRbGngLDkcge?=
 =?iso-8859-1?Q?MhYC6vdd8PprVQD0hSGD5rteoOa3yzGptn/6pZt2JSAqogUvvHLQcG1jKP?=
 =?iso-8859-1?Q?nyRVqf0fJa4UpiBGnY59rg9SDn0YONI/OSFituycpThNeAjwpdYDWTg7Ki?=
 =?iso-8859-1?Q?0TOmW723bR92BQ4bdjOvc4RGQdgkuTg+u+35Aa45OJOsyQ4tNrzS8x21OX?=
 =?iso-8859-1?Q?v5/bt4bimj1t+TDwy4i2qTpHDWDR8XgWdNKTa3Y3D6n4ysH1i6Z47Gctgm?=
 =?iso-8859-1?Q?y5NS5+HzQA/KnkYyJ0r8ZISjOQWssGcyMw+NSw8pKMCq6aceV9XzBc/PMq?=
 =?iso-8859-1?Q?l4jhyV3Qm9jfTKnKN53fYCiNCEyPiU9ugGFCX518vFZa8l0muC2yN1CH8o?=
 =?iso-8859-1?Q?IsqL/nXwSkGu+Y2F3uQM4y4dPALCMDDiqp6tLit45g7ndl4aX27C1EnOjm?=
 =?iso-8859-1?Q?MIXlMef9f+cnjsIcOKB18PePsIQzubUoq+M77NkuE99FdK9XlqLnG86Y70?=
 =?iso-8859-1?Q?d6cwyL0Rdg5HQmRokzVtdCS284rRQlzEyE4Vkg5e1VmKfFOW5/VPymwqII?=
 =?iso-8859-1?Q?NMiuOanCwxIDmjDVcU93LT9SdwO/FTeSWlONz65eH7qpJvPehH0WI3FQrC?=
 =?iso-8859-1?Q?ucD6Gv9UO+HQIPoKlGUv7o/aZzBM9V/NuCKSIQ4HxU4X/09AEiYi0BEtWC?=
 =?iso-8859-1?Q?OlPbhvLpyboUgbZrLyG0mS9h90O7pu/8iQoZK7VS19Y8wxvqS23Jf+EWoA?=
 =?iso-8859-1?Q?k90LbTE0gTkuJZ8cQyB1gr6kTWIbQ6f2QjRAaPSudyBcEVfUzoRHGaJ8bx?=
 =?iso-8859-1?Q?U9CjP09PA8J3Of7E3YT39hDjA6qBexzrbuAvn2Wdvh7B2CcV9hwoaUXRFb?=
 =?iso-8859-1?Q?wgNtk7hHYB8MdwLeg59srq6yBbLjkIupSo465zjz7XP9MMQ1PcSe8p6+sc?=
 =?iso-8859-1?Q?nup3/SRgpzLbfw+rNTYU7fKgD7lcyu3M6fhvgnC3ZEFVxWiy5yss8kTGfw?=
 =?iso-8859-1?Q?eLtMU6UP/zcnAIu/KnyR/chlXDlH8010ZOpPCAzPGiUVpUnfe/hwvrIeRo?=
 =?iso-8859-1?Q?eWFRm2TyPt9fHU+d6sFA+GN1YTy3J6E+AwBOJov/UA8dlCKxlO5OckpPfi?=
 =?iso-8859-1?Q?fClPPIYI/k8+3KhRStE3VxKiu9pQDeO0OwyBbSFxghxOwPU/IGjBzPaO0J?=
 =?iso-8859-1?Q?eXRxH+C68V58FuTwFPRL9nyYYbGoGpRujVeCf5rYIfg7pgpUtjofdMEYs0?=
 =?iso-8859-1?Q?cOcqRy6eWfkomsTMEEHg8XC59XtZugwKPuJ5MaTi08sYD8VCvGohS5AooM?=
 =?iso-8859-1?Q?ZXHBs142l29z8uQ+PuyigA30AeUKgBQ9yFz3PxJ2JGXPmM+XgSsXS9C1St?=
 =?iso-8859-1?Q?oaCKaQ0HAtwRXoIOYDg7IDVNq4PUdw3cKuXvwd7/6NuKd4PxBJ218zSrgT?=
 =?iso-8859-1?Q?oI+p2jXea2kNDpIw9a7DRRzLYTX3VrTOldbFImDZxSVbYHE+5a+uEfW9n5?=
 =?iso-8859-1?Q?T0ja5oZXvVGKPAE7+O9PdqEo+QeF/hkHrl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebfedda-eb63-44ed-938a-08da5dd897c2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:47.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaZGAkC8DhfkM1muX8zRmJzOCQTkzNnxWtK2OLAAML8vEwNvfastsES/MNyTgApRwgd8hxul6+i+TzLeoiys7A==
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
we need to split it between the right subsystems. This patch adds the
fsl,scu.yaml in the firmware bindings folder. This one is only for
the main SCU node. The old txt file will be removed only after all
the child nodes have been properly switch to yaml.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        |  96 -----------
 .../devicetree/bindings/firmware/fsl,scu.yaml | 160 ++++++++++++++++++
 2 files changed, 160 insertions(+), 96 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
deleted file mode 100644
index e1cc72741f1f..000000000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ /dev/null
@@ -1,96 +0,0 @@
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
-	};
-};
-
-serial@5a060000 {
-	...
-};
diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
new file mode 100644
index 000000000000..c1f5b727352e
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX System Controller Firmware (SCFW)
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: System Controller Device Node
+  The System Controller Firmware (SCFW) is a low-level system function
+  which runs on a dedicated Cortex-M core to provide power, clock, and
+  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
+  (QM, QP), and i.MX8QX (QXP, DX).
+  The AP communicates with the SC using a multi-ported MU module found
+  in the LSIO subsystem. The current definition of this MU module provides
+  5 remote AP connections to the SC to support up to 5 execution environments
+  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
+  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
+  using the MSI bus.
+
+properties:
+  compatible:
+    const: fsl,imx-scu
+
+  clock-controller:
+    description:
+      Clock controller node that provides the clocks controlled by the SCU
+    $ref: /schemas/clock/fsl,scu-clk.yaml
+
+  ocotp:
+    description:
+      OCOTP controller node provided by the SCU
+    $ref: /schemas/nvmem/fsl,scu-ocotp.yaml
+
+  keys:
+    description:
+      Keys provided by the SCU
+    $ref: /schemas/input/fsl,scu-key.yaml
+
+  mboxes:
+    description: |
+      List of phandle of 4 MU channels for tx, 4 MU channels for
+      rx, and 1 optional MU channel for general interrupt.
+      All MU channels must be in the same MU instance.
+      Cross instances are not allowed. The MU instance can only
+      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
+      to make sure use the one which is not conflict with other
+      execution environments. e.g. ATF.
+    minItems: 1
+    maxItems: 10
+
+  mbox-names:
+    description:
+      include "gip3" if want to support general MU interrupt.
+    minItems: 1
+    maxItems: 10
+
+  pinctrl:
+    description:
+      Pin controller provided by the SCU
+    $ref: /schemas/pinctrl/fsl,scu-pinctrl.yaml
+
+  power-controller:
+    description: |
+      Power domains controller node that provides the power domains
+      controlled by the SCU
+    $ref: /schemas/power/fsl,scu-pd.yaml
+
+  rtc:
+    description:
+      RTC controller provided by the SCU
+    $ref: /schemas/rtc/fsl,scu-rtc.yaml
+
+  thermal-sensor:
+    description:
+      Thermal sensor provided by the SCU
+    $ref: /schemas/thermal/fsl,scu-thermal.yaml
+
+  watchdog:
+    description:
+      Watchdog controller provided by the SCU
+    $ref: /schemas/watchdog/fsl,scu-wdt.yaml
+
+required:
+  - compatible
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+    firmware {
+        system-controller {
+            compatible = "fsl,imx-scu";
+            mbox-names = "tx0", "tx1", "tx2", "tx3",
+                         "rx0", "rx1", "rx2", "rx3",
+                         "gip3";
+            mboxes = <&lsio_mu1 0 0 &lsio_mu1 0 1 &lsio_mu1 0 2 &lsio_mu1 0 3
+                      &lsio_mu1 1 0 &lsio_mu1 1 1 &lsio_mu1 1 2 &lsio_mu1 1 3
+                      &lsio_mu1 3 3>;
+
+            clock-controller {
+                compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+                #clock-cells = <2>;
+            };
+
+            pinctrl {
+                compatible = "fsl,imx8qxp-iomuxc";
+
+                pinctrl_lpuart0: lpuart0grp {
+                    fsl,pins = <
+                        IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
+                        IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
+                    >;
+                };
+            };
+
+            ocotp {
+                compatible = "fsl,imx8qxp-scu-ocotp";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                fec_mac0: mac@2c4 {
+                    reg = <0x2c4 6>;
+                };
+            };
+
+            power-controller {
+                compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+                #power-domain-cells = <1>;
+            };
+
+            rtc {
+                compatible = "fsl,imx8qxp-sc-rtc";
+            };
+
+            keys {
+                compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+                linux,keycodes = <KEY_POWER>;
+            };
+
+            watchdog {
+                compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+                timeout-sec = <60>;
+            };
+
+            thermal-sensor {
+                compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+                #thermal-sensor-cells = <1>;
+            };
+        };
+    };
-- 
2.25.1

