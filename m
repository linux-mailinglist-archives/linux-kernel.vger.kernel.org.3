Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A214D5ADDFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiIFD1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiIFD0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:26:52 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492D4E636;
        Mon,  5 Sep 2022 20:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKY2HOHEDJh18fsLqsGEgNxmqd2zDACo0lL2EkOuwCpE1pSphg1ROdpSer2B4o82w+A5okxt1tphN2OQrSovLA2tWiRZ34g+UxqjCVFvGHmjStL52L+X2p8Ju5IhbjEJPhpNjdjNSFxluI1r8jl5kM8yHx1/3JE3H5vJwymfljmJL3WGnN6GyWW+VZr3035N345S3lxinxRM141E7MUOZBAbC1JIjs0hg6nXQab/3e/mh+yk/ijSrlfJQxyNyfnlYKaGEavsJRUal1aS2Htft05cf3I816oSKeU1n4X3UvBoDfwTDGsOB/Azg/BMzGPeeu8dFU8Iw5rQ+3k+dugrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXFQpfR+mZ0VoTHP6un1sIy50S1d+DCNiXH0kglFrc4=;
 b=QoH73wyLqvvuq8TgHEWc7dKmY/kEFS8ayXrVVubFAUE8AqNwVWQDLBurjfFLDHnWHZIw2YJ6RYePJbV/wPD0VVzXGlxTpsxebZxtLjSk5mcUJkU3U9R3K8XQWfvFhA14L7oYlHDFMseABp+B0wN7jO/7+GZJb9ktGKsu7jDYycrjKIf5eoT7t9BLgmkSMrlEbD2cSPQRhumlC8c4HzpzILQ+5EEmiXMx7R6imyqApWd1TbhFCDyIJvPrGuJXQ/RYIH/TyNE25587XV3llqGYZP+tLXFxrMyR+HcE2Ral8+O+mcRDrNF0Qfq4rBgyCZMYALIAxomnEXUuCcnS04uzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXFQpfR+mZ0VoTHP6un1sIy50S1d+DCNiXH0kglFrc4=;
 b=XQ2XhcHpw2u1+0DTPRPfPCmJCitabd3ufm3RxezFjubJwqnmQWjsiqQdjgXEdVK3Tn1fkbNQ5dAwKK12rdS7qniU/tsSYnjlOMN89YRbuigLxoN6J9RyyD9mgLdELJgKsl/u7D4N34h2nQuCxKXmbCByKjNj5cQTQ+Aa8ssD/+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3714.eurprd04.prod.outlook.com (2603:10a6:208:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 03:26:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 03:26:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V9 1/6] dt-bindings: soc: add i.MX93 SRC
Date:   Tue,  6 Sep 2022 11:28:12 +0800
Message-Id: <20220906032817.2090160-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
References: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57eda997-4294-41bb-1a90-08da8fb7a0cf
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3714:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEs5Qlm+qaG9bjyKdYsMltxFvvzejGHpIDzGGC1wbVXUasSeXR0PR7Dge4Ww7cTY1zXjzK3P/pEyCsyZuSItLiX/seKH10FL/B36M54rXLM3UzE7POwVZss/aLsg3NKbAQ8z8gCoduBig/8eFlOoIvr6/nGD2dw0i7du9D2nYEAQ/Oe8DNX1LBdArvNiVirTcKFPSEatUBDzv9PkBh7yW/H3RHZjBbuevPIDpd8pVcpoIPQ3SxliSfWeaSkiAQUHdvoO8Yxt3OWKrInTUb3LwyCJ3hPMIos7J7Jcc4V9EOmgNZ7OJYAQOBkfQr3P6EWAZrp0xYyALz2GK2E2OIfnCAMDAJJggGE+OYysza6xaU+3vMyB2Y6vWJzwqQsvKvXGylyoHEbClBnkNUYPj2sPPyAaj8ZKVCz4g4QlVv7cVaceNYXDusYYvw3Aq2x6PtdjQWgWB72FmhogB3KmSIRBAuN/vJ9DhzwAtSXe3/c6Rzb985P000YvoDR4QXJxaGcyXq70vWVk4p5Kkxy0x2CR6Q17InPZGcCdxju/J+fQJebWzmvxZWxlbMT4RCQ5oHeatm7pJ99dRcaXN3ukAkVWQxZEM8tBJurUNqFolTIIz/daAG9zck4ZdhnSHBgtPd4Bg+8ct5FDUuLGv/hw7VMk5SoszGu3bv5sQXZfI3vSumU+ojsqBE66KckN3qkJEkcSaCsmS+ka2tgYmhXWPejo6CP9sybwBEAN8ciSDKagNEB/ZJgipXYJnnB5lv0sg3/5oQnndbs8ZvKyRb1C/15VjlNc/z8LTdo+hpG4ReQIKNTTiPGyW71qXOvnBcmA38zaMb1ly/7WC0EHw6x2mlaRCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(1076003)(38350700002)(38100700002)(6486002)(186003)(41300700001)(966005)(6512007)(6506007)(6666004)(52116002)(54906003)(316002)(83380400001)(26005)(86362001)(8936002)(478600001)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BwIY+YJWcXPk75xVdORfZzeFKTMJv6MJfwldaAoJdEe/DL/6XDMYCfebY0hK?=
 =?us-ascii?Q?xrpEXTJwyzHFO0VlU6ov5/k+MugMQZ3qU2JyfKgo7FVYQlkzXWDbelfWH7MO?=
 =?us-ascii?Q?VWjiyudRsZH0HFv1tCYZruttdMdCHlc16L8ieBNgDvmZZv1fN97F6bDvh8cD?=
 =?us-ascii?Q?8FRdLZrRoyV9BbgivHfs2Gs1AvPQk9vOEXOj8fM001nyKMN6iOgPcKzqFuV3?=
 =?us-ascii?Q?EMyp8UjnnVZAOvMcx5g8YOwEVvkVrQ4wsDUiI8SzZSn+2md4t/DzNdzvY27w?=
 =?us-ascii?Q?XF/PGJcKO+XDqpDxk+rpYyavydHctm8i0rzMFTso/QSoHymy1+CxZ1vf8/Zr?=
 =?us-ascii?Q?PEuP2ByncFtNmyfVKGtvHPq5A2+CFlRN6yRF547eLUiWvSAhGyU598dnNqfE?=
 =?us-ascii?Q?WqP5uzsrIt3p97VZZE1tU4fd7MEra9HDEphzKnrRf+1FB8VTmivq/XRuNjoe?=
 =?us-ascii?Q?uTwh+qMbAfhaNe4pajNMvbEMcJc3BftxYlJYYkcJKpYA4sgSkmNzHQiAA8JF?=
 =?us-ascii?Q?hU3HNnwNbCrakeuLctlbsZs8thhKqRDcu97GDiRrTNhIKoY43IyAzlrEqOwj?=
 =?us-ascii?Q?GFDKA+F2Lqnd2k2C4OYrGspAm6kclT9SnST5zPuSNbIuJgWnnDLt2LrUXJFE?=
 =?us-ascii?Q?bVig4Q7XGEQd/oV7bJUjjnahP5PuOb/j97glGkW7VYcs52UIBM8L5CZkMPFD?=
 =?us-ascii?Q?FOfMr3c/3Fgen3JXdVCfbaF3maIPsaIaJ/lkn8dV9ThQwHQ6GgNqn44SAlX7?=
 =?us-ascii?Q?Qou0Q0vbCGhh1wL0jqqAUqMzT4S6L/yQcJowgJlgwpvW/x1v68xjXmaJMS7G?=
 =?us-ascii?Q?qX9+THO2MDnMpCzA86qKaus3xrcU8i81Cv9N4oOI6w0rwdE5LnITMSG9UpiP?=
 =?us-ascii?Q?xUsW7ee2G4cenl3TR8fuLpU4cTrelAid4n1eXBg5S8sE0WvAkOTGhcW+dDlX?=
 =?us-ascii?Q?ARLSNmL3IPlbrkiOrsXD45piemT8AuhBwRlvgiwpbGEzbN2rsiPUVDCQbnzQ?=
 =?us-ascii?Q?8y7nIExA7KCFsrKwmsgQmHLQnqJiCCUh2aDf1dF+Cy/sod0eemX+M+ThX8uq?=
 =?us-ascii?Q?ixSUozMmtfdtyPLPtJP8eTMI9eJxOSmSUyHExn9xZVYNVJ+6a+dY8Xgde+bY?=
 =?us-ascii?Q?q/24lghi/ewk7paWZAs0IZkKOh1cwZrUcsPc4OXQs9+yjgzGTx2aJSsGS5/J?=
 =?us-ascii?Q?hy04vQnvuM279wUYD5LmSuFtG/PJuRo8qaBaqaAqT9xvhA0X++/mtOeTPnbF?=
 =?us-ascii?Q?UcY+7dnQkYSH1JG6SPM2Lg73W9WJHsjrPygdflVhLp8cGwmbMm/nhZHi3vBu?=
 =?us-ascii?Q?cbX04oDlMacstrUCq0OzbK7S336+Y0bmSFNfhPqk8TVpzWfmyXSRBxKCBrxj?=
 =?us-ascii?Q?GRM7lnSxP5QgiJMhfVakIhFnfu0MjdhR3HPuwOr0BRpBgmJyqPIOkDils2v7?=
 =?us-ascii?Q?Goc+C12XY1OMwafVyruBxGZMwhFO3QeJ8XdSFe59lMVjZ4WjqSGSzn/DFwe8?=
 =?us-ascii?Q?Mnd3Da++rbNaD71UzWHuLWfyuVT5FV2byaZ0LhxsOy3tLudv3N6iycvCot8O?=
 =?us-ascii?Q?3zj6il2gBVi7bHy7BWyIPm9zLjrWQcUMkglYii1K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57eda997-4294-41bb-1a90-08da8fb7a0cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:26:46.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 035N4KOx5W9/kXLKHDTrjzliwY4UkoBWk/9oUXSReTeBbEOOWAEkU4C1lBu+lxRwC2zYgiU6JSoSL43EUCil7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3714
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
resets and power gating for mixes.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx93-src.yaml       | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
new file mode 100644
index 000000000000..c1cc69b51981
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-src.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 System Reset Controller
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  The System Reset Controller (SRC) is responsible for the generation of
+  all the system reset signals and boot argument latching.
+
+  Its main functions are as follows,
+  - Deals with all global system reset sources from other modules,
+    and generates global system reset.
+  - Responsible for power gating of MIXs (Slices) and their memory
+    low power control.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx93-src
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "power-domain@[0-9a-f]+$":
+
+    type: object
+    properties:
+      compatible:
+        items:
+          - const: fsl,imx93-src-slice
+
+      '#power-domain-cells':
+        const: 0
+
+      reg:
+        items:
+          - description: mix slice register region
+          - description: mem slice register region
+
+      clocks:
+        description: |
+          A number of phandles to clocks that need to be enabled
+          during domain power-up sequencing to ensure reset
+          propagation into devices located inside this power domain.
+        minItems: 1
+        maxItems: 5
+
+    required:
+      - compatible
+      - '#power-domain-cells'
+      - reg
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    system-controller@44460000 {
+        compatible = "fsl,imx93-src", "syscon";
+        reg = <0x44460000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        mediamix: power-domain@0 {
+            compatible = "fsl,imx93-src-slice";
+            reg = <0x44462400 0x400>, <0x44465800 0x400>;
+            #power-domain-cells = <0>;
+            clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+                     <&clk IMX93_CLK_MEDIA_APB>;
+        };
+    };
-- 
2.37.1

