Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9044C54C6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351515AbiFOLAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347672AbiFOLAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:00:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA0B522F5;
        Wed, 15 Jun 2022 04:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt0IwG4KwZ0zLI34k9uinlZtwtec06F2FxAjQAgB4kcX6ruMb+nW0VOlXCfaJ11LtCRw+FwLD75YkJaCE/NwxUJgygZO+z56eKaOETH0km16E+TbFZdA5wHt0lWgLpC/CiT+QnZud09JfuEhOsqxAjqv/9aK6DYGTpFgA6QJcR2NeBBvaRUqRU8pbXTS9cYtuGUznx8gGCy3fX14LYMIrLgPn1TxeA77WzgiXd0aqnZHAuD9CEAMFCz5OQhP7QAuPoZ44UyTKCuBIPI8GLhyfnlvYyBkcyc2c4FfLjJlGjZjLRcEoM9A5Y8svEqV8U7VTAcJ8N7aftiuSwcYsH1gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrdB9n3POpIwIPwGyD8EKUnxHkHBkwAVIdKqp3F8G7s=;
 b=mmm7Nl34lwMbv5bVF8ZXPx8Wdtop2cwMruzjyRaPmYJOKHjgDqz0NBZ/hOVd/PJsEy01XQRUYL1Gc7k2MBOuXjN7u/m46Es9JXKnae4IFGXieWDBhfJyyPbfgha6TI6KKDBtIqwHclFk+ZMUBmM+xUN3u/skZ5aK9HU+5PjzFEJXRzcct8xR6/tnxlpQugLs+E1sXEA8mMNtx7Kph95FvE09ttvrwgx48aUC8lnrlCvyXr6mZgfwExQ1I3t3x3lwGB4DIjeCDFWSPuHb++zJJh+NOomV46c59L4cXAGevMmTGAaQtjJYmpSVdUaWmQDGPlagrg07RxvSx8GiRVEA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrdB9n3POpIwIPwGyD8EKUnxHkHBkwAVIdKqp3F8G7s=;
 b=YSTSmK4OjZL/A27JGpIg4MaKm+9O+P7jEXcM81BrIN6vQM5qLy1qDRP7BBB/8FvcsII0WPYoPlWBnozFYhhbn9iR3yqKG3vbtgHL0JadiT77UaqI9iifHRNO9umNLKbJzxWk2LKRXy/vixaj9bKNoYqXxvQClG2GJOG3rtHCmM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:59 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:59 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
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
        Abel Vesa <abel.vesa@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     LnxNXP@nxp.com
Subject: [PATCH v4 14/14] dt-bindings: arm: freescale: Remove fsl,scu txt file
Date:   Wed, 15 Jun 2022 13:58:34 +0300
Message-Id: <20220615105834.743045-15-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615105834.743045-1-viorel.suman@nxp.com>
References: <20220615105834.743045-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cd0c3b7-f625-407b-d66c-08da4ebe303b
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3948ADA3EB9B02953A321C4892AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGdxhrw+BTvHOSlIGryi5k65V0rEilBjPcTJvJTJHbqOkwakGbtlgN4l99WlegOp3628MiP+Vock4wxtZnitR1yn7w7xXEzpDXJp4WML6MijPCe3mTo6lGOephJtK6Qk5ZQYMcPb50LChI0ZmrJ1mFLzZ6F8wRYlh/QBNFi0UUmGe1IMthuBhrTuZokMgx/9x++51aB99kd34kHDwJ18vAf4D/Ml1I1qy7R+MWWoE2q2f2DS/hYMOS2HFdOSn6k/ZvyWGYQDpGCzpeIKp5h7n0n3wx7o8tiovm/n+0KeFS85K0UWfr2MuEOVNOf0st18nRopehQHnEL6lfjwmuAcEFG+Ldj4h2xxcpanu44Rhvp9nqH8lFD5imFoPnmGfq4pMjgfPZd2lonuhMsLHAzU8UeNbB3xC1+8ssUyUeMHapLs8tiwVS4TUfuRUfp0/aKUp2fLtrQDjuRIwNtKTXBwvPpp+iuTZyh9B5fGEaYELTsJAa9AagpF+wtzgHcx7pXzoBmQMI0y43SlQE1UJV9LaiGGeI0n6ehEFiEam+Fo8pYfkmVfyp8EmvlsRbNcqC4aUL4vbMOEIgOGXDkwDw7odPl31GPUxuceBhr3aJXATRxICmq1Pbecbm82jvR0BZBNQiUJfn2kwfiX9BncKJJIatLHZw34NmTS0K3red8ttl8R/k+bdsOWJcOxs0sLQ3pP+APE9dZeIuCeacI5UlRMkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(1076003)(8676002)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?V6q3t1JFTBrw0ba3+tlYNf2GNJ43LaGorRPLhgl/5VraAh7j8LJbA2GdiC?=
 =?iso-8859-1?Q?yDvynrxybJRGuSnO1LAgD/4v/BdjWe1+AhCebjrHW2mVGhsLnhkrNF3i14?=
 =?iso-8859-1?Q?Q9gv8tEO44Olg2c1LFazAzCd/hpTq66gtiEg6WwYjU0aBr9H9QArfRaAtW?=
 =?iso-8859-1?Q?RiJGyGktqmb9sJuDD4y9rAOkQfcHoJYCTG6kXgOuyf5Bnf4Hws8Jq0oU5v?=
 =?iso-8859-1?Q?QKXujY7Fe4+dI020HFqjNSJ4Jqhoj9NS1yfcknKBFDnAw1BFMAyRz+5eNo?=
 =?iso-8859-1?Q?/SH5fyfxeEPOPktkQKRFt/1Gl6S0yNTGLpZSh7Bthu4RsZ7H51n0+ShB2q?=
 =?iso-8859-1?Q?i5jc+ACsphsOEMOkgBS4zip6ipAMlhnBkNkb8IQil4oOxa6kzJ/Otd6Crr?=
 =?iso-8859-1?Q?XKK2vi6ZfAnCXJnZKMhY5etnUx/OBalSpmIJitSKUNElA2YxjKUnFYeixa?=
 =?iso-8859-1?Q?FrXTi/M27+Ozu2BMtZO495zBy/oVDG/ua4vMWDNTW9e/mQgPtRkLF1S6na?=
 =?iso-8859-1?Q?I5m6xfTc0MDV5iVplxApWbHO/skw7QBjJMh58gcfylVWRWOD0TpbWnMelt?=
 =?iso-8859-1?Q?CYMUcBG0syStOsr/qhY1POzGUs7rJePtqT3+wa7/EMxEiR9AQGxFIDe3Ml?=
 =?iso-8859-1?Q?PAWihhB90mpPQq2No5fy9m+aa/KSnfy/USd7J8h+e0vZkOICdNp7Rp6s+Z?=
 =?iso-8859-1?Q?pXpaRKOG1VmebYPJQ+FSjG1ucYdgBXk07kmybSH3hrM6n26fvhcYU0q6yv?=
 =?iso-8859-1?Q?24JJP7Rablo5EQiEtXZ+2sFbEA84+KGmk0t9QvMdgd1QMa2boU5GjXa9i9?=
 =?iso-8859-1?Q?b3XHdbk//mPcpOdpwFOHw6/9+MCgjXX8C6BEn5j4QFAizkVyYOh1/00RBv?=
 =?iso-8859-1?Q?11mCPfE+8/47PjFofiHu3snbSfc8dtPizZXFq7ZF7okoeLoF6McW3VjQ8n?=
 =?iso-8859-1?Q?9L+ir38X6K01cBSbB3ChZ+jzr+z6hk+HpxwCAA/j+wJalu5xSsOe2sZmKv?=
 =?iso-8859-1?Q?zaUkW/UoQpeuYo6g0Vd4EoIl8MisDp7iK2LX6s/Af8vMCwjVNdb6nAey5J?=
 =?iso-8859-1?Q?YAP1ses35tCSqj+pJEu6qB07YhTnjiVZULJCRKY/LuE1qbYgJfXFKVvPUE?=
 =?iso-8859-1?Q?y2WgUfHDMATBEjFVsx3XM5IMOc+Sk24oxQVbBozXfy3uGnqGXnncG/Kpfo?=
 =?iso-8859-1?Q?02aXBkJoRkh/K9zClA6g+qHniST/Xa6SlFNsaNOnrYEmDmG+tLwwBzBjzj?=
 =?iso-8859-1?Q?ajSbkf64ieWdTz1TuhyIONSmVirrciil+ofLzWyXqSZUMMq7WomtciWuKp?=
 =?iso-8859-1?Q?mHJRfjygJBnCC9c84lsbduLNqQxtKa4vH6OjSpkjjdAHMiN/2scNJpne5m?=
 =?iso-8859-1?Q?ZT4RxgtshpFyTWlWok2Xg/b9Onnv0RJ46BGHSU7MIV6fLa2DpyreIF2ICd?=
 =?iso-8859-1?Q?eJALrC3X5zmTq4g6dUVevl3khpwnnAKc39QFCeHxVshCFdqn5RjqBJAhSF?=
 =?iso-8859-1?Q?bzA1zA41CVPkfwPtjvBhcToP/Guo0f1GIIe3kAZg7g1OhJOtdk3iwNA6JY?=
 =?iso-8859-1?Q?/o8AiObD6AHkoVg6sRql+oFKgJGPVMg9h6u/4vGHelydSDya4J+1hPmfY+?=
 =?iso-8859-1?Q?C2C5KSJMJr1OmnPp7A1X+k8zoWYDCNerPpD/SUDK1ndKYOwyCHt4x+DDwZ?=
 =?iso-8859-1?Q?Ls56dAVpBWapebx4RUefsWytk/XJlS/skubGiEMi2HUoqEVxl0N/D1amqj?=
 =?iso-8859-1?Q?SOY2TYOV385ZfzTkGlk392iHBWPGeLiO9ECVCk9qV0+Y9DlauRA2bELOc9?=
 =?iso-8859-1?Q?sOlza0uxnQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd0c3b7-f625-407b-d66c-08da4ebe303b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:58.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oSsbviMnI5Y3znyiCaSJenh+58If+2aN9Iq1ft07nYTlm+r6kFYxYdMuBx9cqtthPK91ZJifti5QtKE5zmkrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

Now that all the child nodes have been properly documented in the
yaml files, within their proper subystems, we can drop the fsl,scu.txt.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
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

