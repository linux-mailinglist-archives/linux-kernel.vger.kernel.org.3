Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2BC53103B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiEWL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiEWL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:28:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780843385;
        Mon, 23 May 2022 04:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7UU6M3QVW6henmwPUwtqZA+uvBvRB6wdME50BifGvIyc+L69puKO4kdMc77V3o9HA0ZuzbvjGgwxSC+RfFKTwrlGcNT5oGbaU0GhVfpKxYXSXC5p4AYsqpee07mNcyxQh8rMg2OxLj/xukR66tzdUlyFIwFxGSUf3WUgrg4drXt2SU65p3NfcXVya6mLEHQGaXbxFsqmcwZBQ/7VDnFjmiDQrthsOfBjAcktFHhPUqb8f3RGSMvB3UjhLZXa2ySDaJ+bnQrUEinys/RsQTzRVtfShdFwdY6QFX37qUmmtQEniTzICTWB6FEzUckkwzTNk7N3AP504Gy9jyE6nAhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhJqlq1ARYH7LUVPZUxdrg9Rv7e3+TNdrXtHCpaHGkM=;
 b=llTI3NgnlewoY/DKofle/FhMGracHpCfFuaJHrjFnY1pKpJz2b63ewNoMo7X9oXzVE9WHm4kWGbtKWTQ9vYoAgbA4LEgmhti2uE0ImlfGedGoSRI3MjttG4ozmmJoLQflnMQ3/8IdzHan54iqALN6tBQRYQsDLOFj+MnqmaEDQ6fpXhgczpUAxYicWa5azBypgcfJONzKNRu2qf8yBokjALvBEQpYmX31y1D7ydbXQbIEQNujuyNu0BLaboOzP+sbaXzsOBgabygJJ90tnQqUWaeEip6vQkwmr0I9C6fD9FvEZFt8pFFwInToCx9kX2ZuCH+hk1mBE2zz/FZEvrSqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhJqlq1ARYH7LUVPZUxdrg9Rv7e3+TNdrXtHCpaHGkM=;
 b=SoEdiYiuaSsjFv1+NC0ZgYfPxMnL6zSeQCcVAS3O3ykcP7xC0FSytcrWGwIJ2+vtWlN9NsIxm0TVwY/0aU6Je0qk02xBzhe76HThGBlGniTktdf+exIwyGZ9h+olq2Q3MiS/mQxiAnjfCSc70BFBJq5mkFmJE4kkFzLAtvg5Dcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6296.eurprd04.prod.outlook.com (2603:10a6:20b:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:28:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 11:28:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Date:   Mon, 23 May 2022 19:30:23 +0800
Message-Id: <20220523113029.842753-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523113029.842753-1-peng.fan@oss.nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2727f334-c7b4-497c-ebf2-08da3caf66f1
X-MS-TrafficTypeDiagnostic: AM6PR04MB6296:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6296CCC964CC9D71074D9711C9D49@AM6PR04MB6296.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CL9jcfa6dftrJa3rTZunGsS+8oggrf8gzj33JhWyym1wMeACQX4x36mnn4zdXUP1cURUJke3nEAwcIefuBPHgIhT3yGM2xQHtgTfwuA0oRXsvgj1vgvW4aQ8wsoKqvbuj3omMpP6v84EvtIzqHtxMF5JL5v+ap+1gJbQR70JT27sTjEJZQ3LaGrX4o9J+Yvs8PbPsiaJMiXzenibFVd8w8IDewn8jzCviifs+cVn0qYmeOzrDeobQSz/r+JSDRD/KoSSCGVhVUh3Had0wUYqNYaESQOJAh1s5WwyvtYLRroPThzpf28EmX4OxMTCP6edg9JqQeBABAL3hRAncpoAl9eze5j7HjsevfrZkiy8Noqxqpt26/ScN97xDA95DfUknrjDRj5XqoU39EiNPP7n9DT2t6P+DcNox7gd3orWlsVBkLOkxsy/6mgCIZveHjtiNSozdvq+bkul5uC5ZGaoKd43dyWNmGG7tluhxOgoTcdr1VDgV8Gkan2HT/qIVXM+Ob6mNmn0OhCD8XtDCwjDs++f0IxKykjhb1R78jx1kn4T3EpsCOz13330e4nzMqCfWAV2RtHZjIUjcOAVyhdsJFhPSTAsgjnx3NJcSlM8Wy9O2G0Zjrcyhu2zGawjVaHSovAyL8lTXez+0p9FjvDEt4Pocg7hmEHpYcdwistiakjiln1sk7GFslSe84Xab18/+0nnAp8SExavmr2Xx1LbcqT6oshhvXmpHOY+VDQfdN9ZWJ5mOkBIG6LPrIE7ScEp3cSNLy79Wx1mFjE/rrEgxlGp819bsBHxS2/99/5chvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6512007)(6506007)(66946007)(6666004)(38100700002)(52116002)(8936002)(7416002)(26005)(66476007)(66556008)(186003)(316002)(2616005)(2906002)(1076003)(4326008)(8676002)(6486002)(966005)(83380400001)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?brQraNYv4ZA8YBaHOU2ayCGRJfxurPO7gXbGinhP4s3VZBHXw2OgPQV3o339?=
 =?us-ascii?Q?VePNeRiEXCjQnzp7qwn9boWP7DOBKMCv5nwsT+q8ZpGBqnt/pfkPsO/t3M70?=
 =?us-ascii?Q?ur+R0CtjQtA+822phHKIgjZ/jmSAFzn4tDEQkOc0vX0a0mLIEbxJuj1+O8XA?=
 =?us-ascii?Q?sfndI+S9/ZjlaM4YWG/Q6C8dN4bL806pieBEi+9zdBTjqtesz/b4w/w6juSK?=
 =?us-ascii?Q?hvjqMsPy/GYh6CYZFaVI9xiqB07ujuNbY4qUgrUdwa44T5rHy2EX85gv4yUJ?=
 =?us-ascii?Q?ez1iJX/89eDrGMe3BVkO99P8fYpdWEPhPzKL9llRtEnNAQyuMba/Zbb+i3G8?=
 =?us-ascii?Q?XtNwVKLZXo1sJv4mcICTdsNwBENjGkYt8UWQyCRHOI5u4m4Wm+6snPvIjXqx?=
 =?us-ascii?Q?63HQwRE3Hp14Id1L7RK/QRKTU81OpnJvJUQBIK+rwpAJ5asQRFhhRnjlnmca?=
 =?us-ascii?Q?+sWO6yTOjjhGpvHJXQOeFv4Ok14hOlesrFjHrjzysTfFYWZTbssD9kwc/CEi?=
 =?us-ascii?Q?T0mLiuwN476UGIcHO5JRMSZTxdqIJjXtWJWdmD0TqrCXBUkiiNH0lSkYjGdi?=
 =?us-ascii?Q?vdM1MaFc5yMhncSDwFdkLSycmAdczGuPDCNum+1cyyIU/ZXRB2v4FC70CSAS?=
 =?us-ascii?Q?D25Beelc0HCTMF4bmOP5rhqicqY2dsHQuUALOhkCBOSqCXVdHt8TwTWqm1NT?=
 =?us-ascii?Q?JvK9pqCLnOQhxggMWECwALzsVEm/pcEk/mVz82xt21IyTQhYggVPpw75kFd8?=
 =?us-ascii?Q?KIODfaYKsPa0izdZLgu+2P0VUvVcqRgrae0G2cc5rzMEYx5psW5DQ2iIpxQ2?=
 =?us-ascii?Q?WWdPyi7Z5d5MySc2PhDBn53yq8IpTH0ga6nFDSY3YXzK/0/mwv6s70e4JyzN?=
 =?us-ascii?Q?DqTBn64nn5vf9Yblb6oLs8ydFPZW7QjJ8bpe3eAKiqMFg/0MWdFLvdVQg3FZ?=
 =?us-ascii?Q?iGL9IxWJkMv14vb4vaDErGrpohDgLJKu4FR0WjCr4onXA+wxbMIqwm/2a1XP?=
 =?us-ascii?Q?zmQ+CZ3wBuFs5kP8/eR/tsAtG9aQsQK1ExtKYOTpuS+2WVMXzuJ9Z8ZvILp+?=
 =?us-ascii?Q?ROloDuIanrhg9Waleo0PgiXG2oE9eEsqHHuMeqey+QTARN2FZ18K4hDahGaH?=
 =?us-ascii?Q?tePiqckS72Lin2jDlvJl9osUMCSSs3tEMKJpYTiAet0Ky0T75TjJT8Car+MS?=
 =?us-ascii?Q?hY26IsvOSIbSQFDwHdeBVy9G4XUONVCSdinBpr34tLk0Yx0Zhr6E1+Q85LkN?=
 =?us-ascii?Q?LYOwwBB5YUhkZU3aaNsfPFAf1JFf82EOzyLg8tguN64wkdI1C7TCpmGhz/Le?=
 =?us-ascii?Q?IO6bnzBshxG1NDjdONiWJkAfpXHnbEyaQvYWC7CmIqRLGubfrukcZw9PHFiX?=
 =?us-ascii?Q?Q5XQzjrs6IszZJ+CYKR4vqpoXPotendyrmL791ZyUpCNPv2IvIYuiSflyVZg?=
 =?us-ascii?Q?qONK2CN8oBrMozcehpgXgCwfaCzLRk9RbHwkpjFB0K+pAYAf+NTd/oiHoMtR?=
 =?us-ascii?Q?/+R4ojxqvDWaldyqK+Q0VTbYcgeZVPDLAOsH5F75ZJ98y6IJuLnkTrD8xus9?=
 =?us-ascii?Q?f146CTYgTfMNMgmHnNMhJoujSaEa60EFTXBNTKxD4hN1hSHM/KPp5dGzCFDo?=
 =?us-ascii?Q?Z43HcVhRRxesaSqZWeDfo7l6fhXSDAJegeI23RNGsUeNsQmiTxIfPd0f6ye4?=
 =?us-ascii?Q?BagPwI1zb3amkWCwrNeb90jCKV3b7kzG1MhfEYuiwE8+ZkYzUPuGjcTUwU8r?=
 =?us-ascii?Q?gIlSx5azuQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2727f334-c7b4-497c-ebf2-08da3caf66f1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:28:47.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJxuQlmEt1A1MkGYOG5DeiEh+6H/GreQhJelnojq2WbiwX/H/fxNJ3enyjzSxb48crrjsBv71jkQZcpXUZHwwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6296
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
resets and power gating for mixes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx93-src.yaml       | 88 +++++++++++++++++++
 include/dt-bindings/power/imx93-power.h       | 11 +++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 include/dt-bindings/power/imx93-power.h

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
new file mode 100644
index 000000000000..d45c1458b9c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-src.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX9 System Reset Controller
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
+  slice:
+    type: object
+    description: list of power domains provided by this controller.
+
+    patternProperties:
+      "power-domain@[0-9]$":
+        type: object
+        properties:
+
+          '#power-domain-cells':
+            const: 0
+
+          reg:
+            description: |
+              Power domain index. Valid values are defined in
+              include/dt-bindings/power/imx93-power.h for fsl,imx93-src
+            maxItems: 1
+
+          clocks:
+            description: |
+              A number of phandles to clocks that need to be enabled
+              during domain power-up sequencing to ensure reset
+              propagation into devices located inside this power domain.
+            minItems: 1
+            maxItems: 5
+
+        required:
+          - '#power-domain-cells'
+          - reg
+
+required:
+  - compatible
+  - reg
+  - slice
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/power/imx93-power.h>
+
+    src@44460000 {
+        compatible = "fsl,imx93-src", "syscon";
+        reg = <0x44460000 0x10000>;
+
+        slice {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                mediamix: power-domain@0 {
+                        reg = <IMX93_POWER_DOMAIN_MEDIAMIX>;
+                        #power-domain-cells = <0>;
+                        clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+                                 <&clk IMX93_CLK_MEDIA_APB>;
+                };
+        };
+    };
diff --git a/include/dt-bindings/power/imx93-power.h b/include/dt-bindings/power/imx93-power.h
new file mode 100644
index 000000000000..27fb7df80f93
--- /dev/null
+++ b/include/dt-bindings/power/imx93-power.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright 2022 NXP
+ */
+
+#ifndef __DT_BINDINGS_IMX93_POWER_H__
+#define __DT_BINDINGS_IMX93_POWER_H__
+
+#define IMX93_POWER_DOMAIN_MEDIAMIX		0
+
+#endif
-- 
2.25.1

