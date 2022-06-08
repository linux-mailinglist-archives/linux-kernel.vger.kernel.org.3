Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B35439B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbiFHQvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343589AbiFHQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:50:06 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00046.outbound.protection.outlook.com [40.107.0.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA81B7039;
        Wed,  8 Jun 2022 09:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klc7BYrBOFU+61UaSfmlxV1Fw/FCVBJSkkw0QFR1AqQLO7vmpxU8VVT6t8cOSngWTCN1/S9XhUCqKcJevRiWpMZBQ3fkuDpNDztOU54XdOxidaQw6Q57eNgMsFknMGDk6UnX2EHseUxocOEhRIRxiOYpetbZQiqoixOHnJiFTWncxtap6+GTxd+GK2qJsQDqeLZiyhsRe7cpcKpz+EuHMn4pEiEFDeRvY4lddOz3WLavRlpOkmypN8qBKLix2VIWb1Vn4nh1yQLNJvjtNNKCz46fp3s2Q/X7NGEY3cC6/pvHyrW3YxJGTz897hk1XHhFzmFZ5pNC2UHlqDoqGaZHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZFj1kMnx8psR3vjEGyOzQSQrD7enrkwJ+ZFw/zHLwU=;
 b=Go15laU3h5dSJ3KZ7sLYj2rLz5Um9XXX5DHEfE2+Neq4T8L4Cj5w9iA3FxnlmUbMIDV2BTbWNpT5DHVE0JOj0dE3XHhou2E9Uq44as5RaYBgYCNpp3qlLkt9zXFM39WEhlLR7hsuIuzRtnl78ECq2ZjTiS3DBXlqCMKAPWS3GMkkwSVheIXFDCejsWDfgD1iIHbd+3aOWnwGpbtnXGIGBs1eCHgSYM/5JKPw74TAkknf4GvPDeWI1lIyzX/B5y04DiPngDKs0BqD8YaMPMTQxZrGcCdWdeYHKToDkPFPfMxT6XJHmYfsLvJtWeGfqjO/wqgOZJb6RP6eFBsTJVZfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZFj1kMnx8psR3vjEGyOzQSQrD7enrkwJ+ZFw/zHLwU=;
 b=dBQUhxdm1uYBdmzTxSMl8zw8CLYf074qBemUOIgyWpAN7a4vOB9tajUg5V3hfpbAkBBdqcutXubx1DbjwLNtBIjNVTlH+APcPstaTsgOLSbdwiaG3Q+WOiFOMfDhk2J86Bc27XNXUU3TxnN6/tFpY3bzY7PnlEH0Ws9/MvxhG1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:50:01 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:50:01 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 10/10] dt-bindings: arm: freescale: Remove fsl,scu txt file
Date:   Wed,  8 Jun 2022 19:49:28 +0300
Message-Id: <20220608164928.2706697-11-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41778a76-11e1-4368-3b00-08da496eed8e
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB74313896466BB414435BCFC9F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2HpGikZTzjs+liY9vu4iLcpk/KdRa3NCPfpVCACN8O9ACGgjf3W03Hryy/DnNKWawOxGKXRd4dCFCZoJ4VKZJOwCCCiT1lLX+40bTSEj+Y1Lqn7TzytHUlzQbMR5tAPdAW4s0b2+ivCSo2lwOMzLyFpjIZJnc57X7/uQcP/164vHIw/E/fC9G/EpxOrExaDuGQEKNcmmFNrfjQSDqsuWkCndOYvP3vtBE4j140KoMVqH2wG+19IYhesQgGlyyH7NXF90LJy6/vjVMzO9aXCvEaYjpxlUoHlxwmRL9Ik8H9hMzSpw8fWMMto9pBQlEMP0g9S+PzMxvPAfZCTJnrcNc3T4pe8F/qOPfq/4ZTH572VpH4gMQNqZefBtwn4Yjw9SY8M/++kfgl0F7sfW5NC3VyvfQQTPf7LUbZOuXmoDA9s7Ahkq9o0H6ewzSanLnlytidSZUmcVE5y520UMphr2uABXyRfA8f/8/eKecI0RnlrfAiSUYxrZdsLHAvrmSHQyasq6UdyfrUk/f3zXkCZ/cMPMQXnk6CtGUPvhTemzwH801EM4J1/JQ9xLoQ3WJ+kpKK9PN7gxRYshoB03Hw2s9XsZ7rqOMRf0GRHh920Mtb1F1Y1d7QrdMqOQjlJNDQo8n+Su/+fBCG82NsTMTtn4Y9CQTk6Hr3mcwMZ7Q2PL5SwF+cvws6nmyrOPd8GWd35OnXgGdiXXKdGmZ9fb1ol+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HHKpap/+W+WWoSkmePRVzAz+O3OJWNLW54oi2tBqQO779KmXwdI26QZsZLMk?=
 =?us-ascii?Q?I2CiWaL9ZX2EdfR4G3H+HEOiz782oWQqGyVsg/IoEVgcAzh8ki9CPkbsmTW3?=
 =?us-ascii?Q?1TklwvLhmhSp3yK5QKjWYA+bXWpqG+B4Baa6uV+flac/jpfvl7LJCKuwUeNa?=
 =?us-ascii?Q?T9HdaqLVgzjdSr2G1i+XaHsAaFmtRvn2hMZcbUhoKf5t97rAJdL8wBOLjTnP?=
 =?us-ascii?Q?Ggt3Z9rvXLmUW9oR2UyVGVGl/QXzoY/Egyhre5JlNbcRTrPn9GXhQFpXHVHc?=
 =?us-ascii?Q?y49AvQ8ogzGPtVmegp1pbpri4AY00mo2hA3flG8xq+bGwfNzds4pcHGJraIj?=
 =?us-ascii?Q?S6B4jywvhUCWmcMywcsGcMhdcK4Lbjb/pGhfWp88KL/U3x91a6rG/puah3CK?=
 =?us-ascii?Q?e9HKILZjIZk/NrxQwRF9uMhNmtv2MjJWmmK6+q0cRfi6k+MOdlrHDeLXPXka?=
 =?us-ascii?Q?0T6Qhb/iZg3NE2RJR+2rjgCnk8Se08Y0LyBhmy1B9dsH0YvLNdohSM7LJ9A9?=
 =?us-ascii?Q?BLsS69RH1lfVihmeStq8FAXuslwEteSh1jsfw+FP46C+yEZclY/a3w5hO2lI?=
 =?us-ascii?Q?AGaYFzmzD70ZNJiIyI2RsQ4oCqYdYZADaGOxqjZ6eJ8ubFXfk7oGVGb3NFSS?=
 =?us-ascii?Q?vbBFWlfadd1iepQjwhc1F7Yz8X1Q8o+aNakJ1m2boA7C90Yd5lli1hcNgIuj?=
 =?us-ascii?Q?4SRHx4iCRBVn02HmhI8HhNh4IfChAySy99xeEsB61z4ikxHiKOJzykIP/SJD?=
 =?us-ascii?Q?+MBgnuaPaf2DF3j5jb1YDRehh/9/QBNcQOEfvqvzu7YlCtSNr63f4H+QjtjV?=
 =?us-ascii?Q?GtHeDYvFi3AKky5hxyLk1YyH/wZrdFjOE98Om/oY/lFWs3xi8v/utbHqrCsS?=
 =?us-ascii?Q?yLp1xH6U8uJDHktgoq6NuINJdSleOZr1v6tvYAYDHGR3U28z5QgpJaCL63IP?=
 =?us-ascii?Q?8UlDl29X5w6vB3nsiVH00PAJn+GkFSMTj9Yk8V3rnVlrfrHzi/q234/ZDp5a?=
 =?us-ascii?Q?NR9UQvVe06W9aOCB9LZ9Nt3oxo7jq0Rf0kPGrtTuaWbXLnH6CxaNWVzWgRs7?=
 =?us-ascii?Q?fOJgCY2yQ36OtxliFbUUuWTXUkDABr4r+s0/EIcO1xKspqZh1XN/L8Gxni3G?=
 =?us-ascii?Q?gj1WPbQFHAr4FyDJtmtcpdD8AJEpNmuVDlH5rmOPwDw0chZ/g5d43LqqG3Ff?=
 =?us-ascii?Q?3XkohbFlKplMJYFK273MLFUZxqWhbE/m1vwBIDlOVsQC1uKh0U12/4G8UE0r?=
 =?us-ascii?Q?T4qu1iNTu2VG3nTKcQCnH6d9Ua2iwVhntTqAOFqkkU9eiekc5jzl9zEoB2aU?=
 =?us-ascii?Q?JElw4Ew52fopjg2wvyfMdaQu9ALJLInrM/jycYcTSxExS/ucFLsh4LPoxOCV?=
 =?us-ascii?Q?D9mAVSyovVnfohg7SDFme9EqP4gDmFMt+syApNFyD0QQy30nNF7CLTeDLjpn?=
 =?us-ascii?Q?+ucFS+ihJIEtqn7Rq7jO/E1QCoNyLFB4UJLJqVu0OmC83+phbEgVCbh3wsfN?=
 =?us-ascii?Q?3opxsXnSr0ZNsvtDUTo1clCevjacOxNajs4FEQkIVRD5mVYgMqf3NjvxYA0+?=
 =?us-ascii?Q?ZwEAID51w4T9Jron5yMcJ+m7zQHSbFOb7gpcVM2i2wyXXZJwNy/B5CdayGlg?=
 =?us-ascii?Q?i2a8b93EQT8BDkf64YoYBpM1q2JN3SCoFM2URPaCLetT+bIjHE+4ljZITbQ9?=
 =?us-ascii?Q?ifBJI+QKkMsti3+rjGBYUmast7H/2CvRXyi7xmAHtaBthFpx3MLszDJD754Q?=
 =?us-ascii?Q?jB9UMITPbQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41778a76-11e1-4368-3b00-08da496eed8e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:50:01.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H4R7EXnnYAgwS+HpoglAvHJw2oQBxUucGchR6bJ/MrWAN3GvUQAL1/Xw8zSIxEyzPNMVFTymi34Dth/Iz0B0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.34.3

