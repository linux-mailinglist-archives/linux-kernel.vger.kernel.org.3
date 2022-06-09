Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE99544F99
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbiFIOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbiFIOfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:55 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC032389E;
        Thu,  9 Jun 2022 07:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAy+EKOBCX9lpDfCUGqvTPQu6E2BS7SK+/01HAE5eWpNdKfj7wqmezX1noIlWURtmKtygh/FQHdbMGvHPu3+RwmOIi42gPlmF5hkJ6VIgEjdWtG/O5n3pNu86pmGDMdRQNLOtnS593SkjR+Nr1uiXhvLPuRN9Ir8p+Dh6fuw51cXkBqun0U3unwyuSQ2Io8JMao+GEfv5E3cuQmBw2IP2SDrhlepLSAMk6Ud8/k217ZVdODGfCy6QBDBB1JGD9HPhKPRB8XhuZ2bsZc9p0Xc3GqTTuYHb7Jv9q66qEbdnXzwTPnOrlSBusnJH+qr5QOo6mKAw98Z6ijhKKKXXt/mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZFj1kMnx8psR3vjEGyOzQSQrD7enrkwJ+ZFw/zHLwU=;
 b=a6nfclO+XgFFj2XQgcKF+CcNG5EoiH/gt5qNLf4ZMY597oihz2c3OvbO/4NSFauyWATKr3v6yau/qFS+QzJu/5vuZ5Ovi8hkjGi+jQULHjMGWJsjP4wuKNPHPWYAM6zB9B4bpPpeZaWnOLkaq9wD3H6cWv16GJwlQM+BeJzz1BHvDdFJPYPmcu1zyVFFdwcHZs29lPG5D7qFYyimSwyLeeQdL1CW01rfBG9GHI0FeYUCrl+GCS5hOECmAYZ4TXiaseIN/K0FREdLhosI6ekm6i6prCB53wQVkR/akeHBmk10EEaCOCg8VWmJe4R7nLo5L5Lg9LIjyP/zKASuvsoMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZFj1kMnx8psR3vjEGyOzQSQrD7enrkwJ+ZFw/zHLwU=;
 b=U/xEV/v9sxmtulnh3CYZE+o+c0pwACh3eC8c+/d/0Dzy/IADcxn4epmk/fDaDkIf81LnT8kOxx8FlTr/JwINmEkU8+4T8xELT7beSDl8ci1GEpgrqhZngm9hSz9N3ZpgbPEjzfCFtR5jDxh5xkqRE3NGP3guMfg0Tl53KD9TH6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:33 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:32 +0000
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
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 10/10] dt-bindings: arm: freescale: Remove fsl,scu txt file
Date:   Thu,  9 Jun 2022 17:34:23 +0300
Message-Id: <20220609143423.2839186-11-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220609143423.2839186-1-abel.vesa@nxp.com>
References: <20220609143423.2839186-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::29) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09803def-4b7f-4fdd-b9ab-08da4a254028
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5885279235DDE6482D2E4FBFF6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTKDOb0kjZiQIVwvVeQOpWummgFm3QlrFSX2XjtMjsv/ugFiGHbbOkjMC1rcrY5qCEW/pl9S4LXfjGsbgVe+yAs5RoIlEZPIvERTXSajOQZRcj3PbTM7oVKvhIfMPeFTeNHUrmCcGnsRlq1SBxJlE2Z7Jh5uqNKyUQdpSe+VYIbnTBwCg4o/kIAVQHbk+unB3MWEFlpWwZjGFqf8EdO09sj5K3o9c9XFL7I9mcI09a+kH9UuxgcsLBbetxxE3M/GfCmWEH1sXmUlElxDY4GO40/lsbNBPYRFXL8s46Qf+WxXe+KorFhe19nGgmvF2SVG2oL4KZeNf6lAZFmn9ILWD54jL3c4N0OcLf+iNm5O54E+jUEqFkrmC1RBO6zqheeijy0L/Vtzfit/cRCbqjezfBFbjdTuYJNgenWyXGsv9qspplImZNbwPTFfczb9dsr1OS+LQiFfuS+cxgK/AQpgPyHLmyupjgdxpPUP6CdKCgGzzJSzcIpJqB+An1oP1fdn2TRtbCJFwZSOduMbZjtLoQ0+/8QefDiprs7mQvk8FA9CphKzvNbDI5otZlsaTzg+bRVu1oEMHE5F+xw1ZLu3CIhzzwpaxBwMz0F8VtNu123CMpxa+sOEk9F8F8Iy6dGV2t1s6/t3cvaTNmGezR2vqRLhwTysBhY3hvcO/vvstWlR5PmlRWZ4e6Z696PlgcWRM2/KUamFIv5tbgZKUUNiGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(7416002)(38100700002)(5660300002)(6666004)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVCL19SCRzawH+oqOHPIkc+9mJt8a6vgr37RmeErQaQ+xeT+QiLfJQEpV1Tf?=
 =?us-ascii?Q?vKxfP6+q/GujvpWVdvodACNDiuWFprfdJR8cnxYo0ICDAgRj2Os9JGq61fdx?=
 =?us-ascii?Q?5/3RF/IFrGrZPpFqi4rr3VpiGqb2CN7kp39HwS/7xh37pJXITZmtXYkF22J/?=
 =?us-ascii?Q?rGTot/2rDHKM6nHyXIre9qEWH1T5obyX8x4G6KbSEG7mfdplGWQG88JxDwO9?=
 =?us-ascii?Q?0CsOwOGFNvhq53F0BeRe0vvvBYZHb8TTFIvgbCYloxptxQ2Z6cN8gRslKdxA?=
 =?us-ascii?Q?xJVKrK0KtilCZXbY6bj3slMjCdvk+cuRy/WFcvs/QhkA6cHbYD/S9INhzp14?=
 =?us-ascii?Q?u51/1r8+t96bVxh6DNh9vi0uq8lo+u4A632ETtGh6B5EDspuixPqa6D4WMT7?=
 =?us-ascii?Q?Eftw9rjv57s/wnV2j6sax5AWKYBLJwH5Noe4NZ6N9XW5A7RN+JbYBpqUbhe9?=
 =?us-ascii?Q?3LK9eEWCmyS8lyFddrT8vWCYKaAa6qc6B+CMOMX2R8iBGkD4AK/tg6vrizpz?=
 =?us-ascii?Q?e6l5KRSJkfcTBmf74vk6IS9ORw9ze93ARKUqKD115l1os7ntMmQonIZ7ye0P?=
 =?us-ascii?Q?1wAIpxLtMNZ07BIwTduK97/MvogHYgeeOgxH1sAHPA7N8k0Ad7XR/0HhHqRN?=
 =?us-ascii?Q?9eTzFNKcDYpGq39C+fWGdNK70pOiS2oc8EZR80VSLu8okinOb9T6pPBMjGhL?=
 =?us-ascii?Q?bdt8hZFCdc6o2EMNMU1RPsJJoV30SJQOY6a1l4GOTZlInZ1Rk4x9koqzEMJb?=
 =?us-ascii?Q?wuia58T95/XeQN6l+h4WDLQiB5gYH79gHsGT3AT/z7E4jm99e+goK0Im5Bt1?=
 =?us-ascii?Q?2Ql9V+OV6mR5InCXRPvCDgS626BOcksUQXAuOcVx8enufNedmGbxZFtXX34q?=
 =?us-ascii?Q?xLy4+hdoWdx3NAaNW6XHhpFwQy07Tg2N+gSwVDQwhOKVtiglS+GMizEGMxQK?=
 =?us-ascii?Q?P47d9gjwU3nLsEFlNTr9YLz0gDzK8bM1J5/1Be8yN/xyJ358y+98kkDT+Y7F?=
 =?us-ascii?Q?axqIdVNP5EHMbytUiFN45WomrQFBDbvwVzNu9+qOJYgAbX5euQf1ruJkWVk7?=
 =?us-ascii?Q?JJEFmgc+cBrkGPT6zWgkr9MAyi8hs8lr9zyyqAuBU0v7fr54eV7uo+Oj6EHo?=
 =?us-ascii?Q?gI3p93/VlFe1pTk3vGmiRODGQrXq09sVEsbaJ7mkFIy4cC1zioj3yzUHLqIm?=
 =?us-ascii?Q?31Alx5FnmTp0wzCQIHZli6a8Hs4QnnQBYtzNwluEAJhNmvi0vgH80vsg7Ztt?=
 =?us-ascii?Q?mQNpBoXD9IjOfbqyiNgEfT/8yKm4DpmVZLUGoV5mbAIMTy5j/FPqxbjm2VI0?=
 =?us-ascii?Q?0pEY8cy2OeVbW5wBvLqpgA5C3PZkVr86mu2/UzsnIdqWtbk62OiTT052khga?=
 =?us-ascii?Q?CJwYuffxeacH/RI7jDumtH95JlnYfhUM4GEv17cSYbNqpPePb4z20n2IoKVX?=
 =?us-ascii?Q?I+uw9P0bZW9LwnxgbEJQTB56+WhKqf9K8y00yb4kQqpftyv8rzcGVHZFYkiF?=
 =?us-ascii?Q?LmJv94lo60P2v2bueuzHCzMRKu+o+aEMGKn5N9dHnUJ50WdIQgziJAARwXuF?=
 =?us-ascii?Q?B3G2yEDx9jkxccOXdTpXKVZ9crPQU3SIRIWSq6csAK4rO/bYfWjDdbYSgCj4?=
 =?us-ascii?Q?U3B1i3hRXzfbkNKvrpVqxau+n2J7LUcubgfwCSHXssXBOoASQnPXO34uqZm+?=
 =?us-ascii?Q?nsJb0HzYmWxn2u3wdc2+Hit3oBwkgniIyT/UJE4KrXKjQ3Y3xWJm39DK6z++?=
 =?us-ascii?Q?xDpBXQK4xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09803def-4b7f-4fdd-b9ab-08da4a254028
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:35:08.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbHakLW6zpC/J5k5IKhTBjDYt0o7HTvMZpHYRbtv1jYJ8EJorcQCAqx23hqZrf1MLzsN6l7qI2TXuEY0hI3dqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

