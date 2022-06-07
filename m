Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3FF53FCCE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiFGLDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbiFGLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:55 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50066.outbound.protection.outlook.com [40.107.5.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49912617;
        Tue,  7 Jun 2022 04:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvIeF+bdOOW2SP3VaksWq3YE2fpJfox0c6xigW+WT1/ZYRuw7fJ3e7fGU0CB8PZ3ji/9gXzrOLUjTFqHDFskPe8RSyQJ9R4U++pEkOAf4A8qkPkxtkPMPKDXhvaVnbCig8WTNwxhjddsHBirV6kLrtIgBuiyjGAR/cxBGUwqeguIybA6lzBM5I/EfpTwddGTpO4X78qhPBPCaL7WyfAV2yczvz5B8r01f5wzmH1i3EShp4gOwdtz21vPnfVL+yXv9WzAewM3ELmWZniO5lQl3agU7hJPqAN75zVl3c1S3oKUk0zdOBh8yXYaeHBIdJA5Ea7gjNEoK9jo7+82Q072iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tvm6XX1C7WFsmEqZ92Jr/g7AnvSa3IHwLnA98vX+xY=;
 b=Y0hM5DEiw1agIoJkYmp5oKkUZlzeyD8oBJHR/0SROOscs4qMNhet7uMj/jNq8grkF619QAwAHPp40gRxLvEWiKwRG7OcXAm6290oqEvEmVLDpa3dedQxxgXEl2d/EVkkeiQ4vMJzwWFixaWvx2h8zTpX/R+Xm2oudL3PdUe0E5gEq31oM3EhFDKTImsYJXOT9EyY7nRBvDNeD9MSH0f77uHE9JF13W1eMty+UqfFiUo/yg5qG9h3FZPv+rV6ewKuYlV06pCvDR2AmRs5aAP5cH3MFNKOJWXedGAvB01Fa8gQclumebT+Rbe91h0HqLKQCKgwGDoA+20t/QHStcYd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Tvm6XX1C7WFsmEqZ92Jr/g7AnvSa3IHwLnA98vX+xY=;
 b=LSXpguJbBhYeBVnsSPUJVKy3mBJBcSNaKvgbFlwYbGEU51baZ0hgWbgaUcoBItG/O8nQZXDlAyqoEZJeXoXESXnrMMx15kj9wAy/pJHF9pQzWYx64NTLFQ2PvDmRB2QQ0fA0WZk6C14MrmgPzepwnNd814rFylWibW99pJo5ZK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7301.eurprd04.prod.outlook.com (2603:10a6:10:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:20 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:19 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/10] dt-bindings: arm: freescale: Remove fsl,scu txt file
Date:   Tue,  7 Jun 2022 13:59:51 +0300
Message-Id: <20220607105951.1821519-11-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220607105951.1821519-1-abel.vesa@nxp.com>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f098d86e-35f9-43e8-acf7-08da4874e89b
X-MS-TrafficTypeDiagnostic: DBAPR04MB7301:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7301920910BF8E3224B127E9F6A59@DBAPR04MB7301.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrQ1zEnnvUPKuRnr8WpZV9gK4gZbTEaeMxpsl2gTgxU4w0st2wTkC7tTvxy0o9ZvfsI2SoyoojQOkS/1ZeASMBRQk4FSjf0+XILpP9rSWMbTClO8vm8uycCsACTLTW9naBBZT1MbMkNdf2Rflr5QgZwXPs1oU63bBWUpbFQdn32xUcrCSNW024Xy+X12qT92sh1IRky7kPYNlgD4zwy6OHN275V2BleztQ9/7Ag3s86ufA9CE+XT+hmjR0kqNtdbon9bbddNvD1/lshFK0AsI/QSwHLyJ5MQ+BjbhmslUBrS7mMR9VuLCK8i6BCccVcIeCoan1F8ttQdVZs1+Rz/X+fA7CZ48poekhP8PUM//fgnCSTWoKP4PIvwGF5D29HvykVSMC4VXXGcuHY0o+DNojAsHQp6pqkcY/j5POpPMV6FqmePgNo67qGdEIL6xaQo0QouHkdm+Q2lBZau3zxZugaLZ/Bhe0+/Zdg8Kh3k+/MGU/E9oC9oqPrvlhvkEOncc0ejiBcIky0TFAYzndnyi9H1JsKHwapmSHpqPrdYdhC6GthR/+paGuNxVuK6a71hiohT3SVEfPsYTjpvO+/qDdIFhFPutNFTFscdEocwVuvLIDhSJHcV/xf5jiVbsFmJNcOrE/b3AfzHwBxBMDjKzKX3P1uA0+wYMLymS6cAm77LB7FWGHNuZavcDCrdc5kkNscMfexP5X9IidYF4ZZy0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(83380400001)(6506007)(4326008)(66946007)(44832011)(1076003)(52116002)(6666004)(508600001)(38350700002)(86362001)(186003)(6486002)(2616005)(8676002)(2906002)(110136005)(36756003)(66476007)(38100700002)(8936002)(54906003)(26005)(6512007)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j9Kcz5SqtYe6r8UrJG8HXMV5QPwb7TA8xr16adlJTB3pjLIqNKf+2mnsgiE9?=
 =?us-ascii?Q?RyBovEfpaoi5nfoR112IDQrKv5n0B1kRcPndCq50BFbvWEedKhhJy9XA6lbx?=
 =?us-ascii?Q?/exZajw+oc2am0Jcp5duMEeV51Wl18MmFi7gwhqIH72VQRryUOUHTGl5p4gp?=
 =?us-ascii?Q?be9kHrtjn+CQEBgUu/Msa3gYswPDIUPVAgyFihDFdCVQ2kLJjNqArI6Vgr6X?=
 =?us-ascii?Q?B3uPZeMsanaAWBy2Q44ODVLu03dPhbroQX/RyQA6CfxCut4aAAbpFe5afaBB?=
 =?us-ascii?Q?oK9KvD0a/+yKzWT6CHeCfJzvMRk8mgibMMuXrKC93SZNTTHAsLpW88Wfn2IF?=
 =?us-ascii?Q?yeJn6Dhs7qMNJjbSuwfypoKNP4RlDzJoBZHaBQCJbeCaUikfdVM/aalbN5BA?=
 =?us-ascii?Q?HbO3dKZk0j8GQauD2839nylNjDRzU/LchU6AHNetsQAMqatZHrTUMkSm0cjN?=
 =?us-ascii?Q?mogSS4P6tJqmGgpi4IVzc9v18SUZ1XVrvWUT1TEEiMATLbmH1MiKhJPskrXS?=
 =?us-ascii?Q?zZ8ZCxifpAGItxHLnaOZ7YC+n4j55EEtWCxJYtcw5j1syQoPM+iEdjnh7RzK?=
 =?us-ascii?Q?cPpUGxImjt+VBYEqHiucWv6tF3j0igc/IoKgetf7wqvQQn/+rt5aX57LYgNM?=
 =?us-ascii?Q?QDVoCOrZf0u0RoEDVOVROMRRs3MKeBLph67UlxSWS7SaehChmDZhjJIsUIXC?=
 =?us-ascii?Q?YrgnGhMUXjn7KMAARPZd6pxRl5XLWQSb13NI8IEPTXtMJGbGHFbnFS1gjyLw?=
 =?us-ascii?Q?5mwey+A1kEtq8JgF9Aogy/O59NRazeUEKKg3XvTyxPPwphOSq/HbtZnQSVkv?=
 =?us-ascii?Q?sXI5KGs/IiLY8EJ8CiuyXPo9xE+IjTcDZwZf6mqJZNAVsiSpeaAWf4FjYFAG?=
 =?us-ascii?Q?tnpNL9kXOwRZijwgT4/NSb9Vx4Cn5uO94dCVzl1WjtJ6kkosSfC130Ee98CV?=
 =?us-ascii?Q?FfbCHsD8//zj+qITpPJt9A8Yimxsmrksr9R4PnK5lwyxb1mrf7W5Jyt5Wf09?=
 =?us-ascii?Q?ve+/gGoak1KfVogNOGSo+pgow3bGaQVar7Ku+CjZKU4VxNmtsi2EQUkjTWUH?=
 =?us-ascii?Q?Z7+/Y5btY4UjUX3Mmh8sXgQ84MMZnV+q+fdykR2aSIFP50387MQqbTqEoAM2?=
 =?us-ascii?Q?V405RhVM2KjhqPd4xvj2h/g6UW9ngbx/Yehaf+skYXUW2cT94VJKE1HKDCzB?=
 =?us-ascii?Q?Eq9WrsXjTF4oIV9cQy/Q9O9nUARVlJrMiPdWm0FdwUQgiasi5FnVRNXa3E4j?=
 =?us-ascii?Q?i/SbsQTHHK+oQoDHK9vH5fil7Zmtyzw/MZZkr7OSIC0aNM6bY2BAr5aZCxrY?=
 =?us-ascii?Q?VyyCjmtXAuKy2ztOrIvyKtY3XcNZ96VPw5N7pPqfP6drGRAcyoz0bQwlB97a?=
 =?us-ascii?Q?5bvI0uYBlSsoF79CLJnkN7XXgmZZoZ+mltiG0txfjupmB8wvJLaOl/CNnMFb?=
 =?us-ascii?Q?Curef/I4KGyI+Sj27LbVwTo0/U/gxGxKhD+hcayL5tBlv5FqM37Mi8hnADRn?=
 =?us-ascii?Q?Dw76oOLGe/prdh5DS4ycmbxb4+942FRfdDYjLKlkF0pjYFBzo8D5k39p1CL+?=
 =?us-ascii?Q?9MfZ6h29W1Kp4pRpYDrNC+yVL1gSy0rej14AEQyyQhMEiUGTz03XG7qOMb0y?=
 =?us-ascii?Q?P8vGO1dRDOdcsN7X+c1dXSpFf5N/vd+e50dv8dlOOQps68JFNrxTPgHnCLaW?=
 =?us-ascii?Q?PvPgGnCV4SDABI+ygQSUk03d01ZR3+7Mi2jzGCNl21ucDk2HfqT9xc5MGupT?=
 =?us-ascii?Q?XPA3lohs3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f098d86e-35f9-43e8-acf7-08da4874e89b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:18.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3j1ECSMyWQp9xDHQtS3VtAV2dO77DoTpVAiVaAAp69BwJ2ov5dji0J47hS+XQNmk93o8vfKtroGVxSbXm/yMng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the nodes have been properly documented in the
yaml files, we can drop the fsl,scu.txt.

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

