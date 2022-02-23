Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A14C06B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiBWBOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiBWBOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:14:51 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30050.outbound.protection.outlook.com [40.107.3.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AD8DEDC;
        Tue, 22 Feb 2022 17:14:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fkcj95uPJ9C5OdEtbPz6cW7YxLCd+dIXN/T9nFoBjIOLey5y17NOB0RoAgctQY0keSNSN+4RNcv85YYpgOB09WqgkQK0IuF6WxXxktTxKt3B+JaE6sPq7qg5m8zFq3RpW3WTPpmKddilFy9KpSibsSYYPyL+V61tBKAVMrY2pdgpzpEk1z9QBEWlawQGZ0AdRB/3q45IzqoVTZZ1kSe9GQcmWAICHhJluS3xm14UCeQbaVfdtTlh2fdcs6rqR634O56hZuSaaS2CRXOtd/uRIvdBEM4CIP3kdgGw7CEbORr6UHPG5JGC1DPvwYPP49/dZDgJzFUm33vUT/C0f72snw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFJZhKTGSa5lsjtLLCCFdEq69GcftU+K0cdBdAhDE/Y=;
 b=nWIs4HL5/oww4CjRgn94Qi27Qr4sM8U4Xh6szo9ECNzA1PkgNWg3X/o40RgqRkcnDVnOQGssJ8V9ZANt+i6n6QjFdVnDnc1/nUP05nC0lH65jdrksoE9Wqjgs+dFMhpFhGG6JAQ/g20CP2iF4qq4cHpA5t6ugj3BgGVO+5ldUIVaRLn9CtGFahVwJpTHw1JBLvcUrPC6AHOxYM11u5xax9Ms3GaMMMKv6Lr1njrpP5/Etzg1n8IBwFqSRrrlg6/y7xJ4qXM2vCXY44hahUIHe153wPnop5Zhjc9NTrjiSP6WtL2InjKNbp7dP4EcpseSlt3PCcTMdR4w/hFfZJY7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFJZhKTGSa5lsjtLLCCFdEq69GcftU+K0cdBdAhDE/Y=;
 b=CnS5auqv1Y34selrMc2s7lZ/I7BpQSIaRVZ263j8iNEltN9eXXBRrkiRR5Pb0fc3ewncBawTqTjiBPirKksVN++mcgwjPcQPG61/fvBbARCkh07xkjUPNBBVOV+NyntrLCvF2n2jQLpgbriDz1JRsadoIEgvikXZIVgfYoYr2CY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 01:14:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 01:14:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/5] dt-bindings: clock: Add imx93 clock support
Date:   Wed, 23 Feb 2022 09:16:02 +0800
Message-Id: <20220223011606.3282165-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
References: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e40f4f61-3b82-434b-57df-08d9f669d320
X-MS-TrafficTypeDiagnostic: DU2PR04MB8533:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8533432235B5498F3DFB4461C93C9@DU2PR04MB8533.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQQRjtxhE4kpp7P2V4y1q5x76+oM0swA99KV1W97D9yP5N/zEnB4QbrbRlUZC/FXRIlBByLVAGudrR1JI7hLP1jj2x+788pfWMWSabdRv19lrAOicKBz9RPETT9NbUmqAyhqnbApcTSNecOyYt0GOH7NbvPlqttgDsRKPpldUSz2VLmyyQ1zz7+VRC91d1tWJyZlBjRAop6Uw6vraHf3XrlK8yzdNId0Dez/6LDXhA9AxTEhhIzE5wv+RvzswYN2UdtTYdKz3JEU9MtsQyC3J/K6H2hVasS6NGbomA0IRbnFOCbJVNCdTkOHWcd6laJXRUuvbsJagHam23oMSITU3GJ3C0ya2Fmx7kH4154yUmA1uLAMYvF5lMYp7vJMBK2f2wbeFOERLY9r8U2LW6ePn7Uhm/27N97htx7bmxTAWUiq0XDw7/kKSkWXrmx5sOfpTBP/xhWICjd7U5I4XV8dRHdIsQHo2h88oOOf+iHuDIH1zLGAdSVIfbSblaThiSeagYCVvSl6HkC6plniFJlYb9lTxXtBApbT3qJUT+UD71GpNf/Vj5A9/GHLOCLriLx2lY4vFiTdIOWjnZ2XkVDZjM500gQ6r7oq7G/WPY8gChDxOXunpLRiUekHYj5duMhBI1B/dnPppPlxrma9ytigBHEV6VRfubvsVt+CXIeMVlK5L556L5qwjHTRb2GmZ7HxwXtF5aI3cTPXCbnj+Ixd+4olqxNDKeWKrYLcDcM6AKpPUxXO5Gk6ni6Qn4N5aKtPQd640t5X0ZC+vheL2x9B1jQFuD9aSjIDKRGi7p9pv80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(1076003)(2616005)(8936002)(2906002)(6506007)(52116002)(6666004)(7416002)(6512007)(5660300002)(86362001)(38100700002)(38350700002)(83380400001)(66476007)(316002)(4326008)(508600001)(966005)(8676002)(6486002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xe1TmjkYePtj56ON+FyK9OeStRyuhOi6o0kSqA3zBnJkZAVoXPHe38TQ78Bk?=
 =?us-ascii?Q?sjk0vAqz63MHj6hZYvUxrdVmPei6Y/a37Ymtt8FKDWniUA0TXE1dojgvibzU?=
 =?us-ascii?Q?bX1svByANJ4vXpkXZM1glvLo/Ud/NiBsRwHPgwLN3IKsXmWP6w5KOkKsUt6Q?=
 =?us-ascii?Q?H2bDnDrOOLGekoumxKegUlF9Xwd0SwVbJ0aahtOpTImYbnTGtFhYW6pGGC9y?=
 =?us-ascii?Q?3oULQSHB4plroNZgm0NmmrNsWRaANxS9HYc2/a3YGYHQ554BrE2CWLEA7KtO?=
 =?us-ascii?Q?R9EuaN5u/HSuHCu1oq/inq61bFm5tMbeaZvPRzJjGYzFbjo0hYsXy4On1yvG?=
 =?us-ascii?Q?jww/1ZYm5kNpEt78uw3XnU8dZErYt+qqDQUSF6Ef84uP40hw8/M3uuQp3NgG?=
 =?us-ascii?Q?zfiGMtlL0crjKf2pm85fxi1TrH6BNZgjiCbyJ/q5YKxwCzXJLIYbsXtFaqXz?=
 =?us-ascii?Q?/mNInHzyj+ENnO3stRhv/ulqajlcPRb4i1ifFV1h1bH9rUU7knrEn+qGoRcC?=
 =?us-ascii?Q?E1qOGw2yerMvepVA6kbiTLAnKCo9nfK3Yc9CX3gQoOoPcFKs4KSilZYXXR7i?=
 =?us-ascii?Q?T8cVINZhQpa5hdFYa3qEMDOYE4QftqcomNdvdwD5pyFjA731tM4OsxZfQTYj?=
 =?us-ascii?Q?xWG6RCo6rOyXjX6XPxD7BEgNekc5m9U7k5GkHhXGAsNsfARW0IKcl7zzMZfa?=
 =?us-ascii?Q?8ijH/wkDQixxdjwCeQuZnged7MI7uRS90/ktXkBQFnM2LJXyZfk2CGYgPP6W?=
 =?us-ascii?Q?HdVsKpH3L/5c0uyAyrLLpZ7t2X6FP69XznzOszM0ctOprd77ktTj6AJUSn6K?=
 =?us-ascii?Q?354QqOb3cfRqhnUmHG+g72Nb2W/dYP8PJNVyWcoBHVkFZRIze+dX8qvIarWl?=
 =?us-ascii?Q?UrDtQHCZWpqcZZABKak+sgRpHXRB/NgsGtXgA+WKN0/vXKQKWw1DkBo7nsrI?=
 =?us-ascii?Q?mLc5HYjYCKSpnQZ5ZFT85CtTIXUWG+6VVgVKay1nR8quZDgCWZ2FsLIsqMoU?=
 =?us-ascii?Q?AhFY4TQBnxYoK4KbxWcyrNMLsgOJTffMWyVTpJD38LVR5afXQXG2ZjtvO7az?=
 =?us-ascii?Q?nsYTmdIrAouoBIlKkG4/SH0xsrJm6aKjL9QQGuyMJiSFWHg4+JlVOprkfNrC?=
 =?us-ascii?Q?fSfcUDKTfgKHKw4UIXP5e34Je580W/DsP77vbdLX8p0ny3ZKBbDTJMluF6QP?=
 =?us-ascii?Q?lHnEvHEY3hVBuPd3+ThtQ0ND7ZY3006UF0JcJWH3QdZ6MWQhuZa0DMVfbGm/?=
 =?us-ascii?Q?Jq4OfbTjoTMgBD3FU2AE/pQfLqrAaE2eWE+zonn1QdnORG0QRofZs5+zE5sb?=
 =?us-ascii?Q?kHnyIfYQ4hMJehaA4wxaUlr083qoVKiPLIxVJkUi7VmjF+wEpQ4615ly4SmJ?=
 =?us-ascii?Q?+iKOalbj/d+oXjyj9TGGry83qv3rR3R+4QelztAwaIx/QmscSYOIVDgK8jJS?=
 =?us-ascii?Q?gbtu9zgDdO4z+rg2FTLlpuZWPIaxDm52VLqPLe+ws+dhMj4inhp9DKUzdkPL?=
 =?us-ascii?Q?yRxw1kbvDCp1086hMFo59kF7qqVhHRQGkFC+4X+NfA6h+V6nWuAAIG3Z8Flf?=
 =?us-ascii?Q?Nf0K4TVHv8FvQILO7i4aqNDzN8gIDh52hkN+u9UjjhW06H5Z+8y36SCUrws2?=
 =?us-ascii?Q?bCLyK4YhUU5nGFVWmp6B6LQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40f4f61-3b82-434b-57df-08d9f669d320
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 01:14:22.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnBPTJYnN8udCaMMuerry3gReqg3mLkwGonkRELyLiVd7Mtx0PSdxDRJebkliA6v3s4/h5neLZ/9Wdfr/y+XCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the clock dt-binding file for i.MX93.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/imx93-clock.yaml           | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
new file mode 100644
index 000000000000..a4c3ae23b8c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx93-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Clock Control Module Binding
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  i.MX93 clock control module is an integrated clock controller, which
+  includes clock generator, clock gate and supplies to all modules.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx93-ccm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      specify the external clocks used by the CCM module.
+    items:
+      - description: 32k osc
+      - description: 24m osc
+      - description: ext1 clock input
+
+  clock-names:
+    description:
+      specify the external clocks names used by the CCM module.
+    items:
+      - const: osc_32k
+      - const: osc_24m
+      - const: clk_ext1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx93-clock.h
+      for the full list of i.MX93 clock IDs.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    clock-controller@44450000 {
+        compatible = "fsl,imx93-ccm";
+        reg = <0x44450000 0x10000>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
2.25.1

