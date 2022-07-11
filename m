Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2656D49B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGKGX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGKGXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:23:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7417E20;
        Sun, 10 Jul 2022 23:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clGsZZF45OS0sO9MsLEryB4O4W0b2Vg1QpmYmrBhT+vgxlWUvkycTMUjzNxYQa/qUm//z8aA7iVXI6/zo3asAe9FaRX62qPhtbv3hWLLJei1UAEV2C4El5jrCGJs5iwgPpgaV8ySA/YpiDeCW5sNQqVUnlIq/Qgd+1qt26JqOpERb9LtYQtWMXyPn+dZislu+4AWXJMGiA10snHUTFkeXsfdPXxE/8jl2LpgoY6rzXGf2pSIoLjinUBDfF7R3C/XlH+e0etAmIub9dL3zQUAMU66/NTO+uCOXVG2TVpJ/RDYx1xvb4gQJSY++sSKKk6hpUDluJeEwNsfPtRq9MeLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciBMk0v2SC9yqKy059MJJszq6M938gk6Hv317w4BUuw=;
 b=MmG6G9MefK7twBGesdN5fjSo8bTLUz+JQB5c8+Jh9ZZm9vupS9ITwjLFuIr3QkjJPeF+qCWjBxtOHp3F1ad9YlxhRrUPYuKZlrRqf7/nhB+UwTJarz/NTd1owCMTYDZVMo8js6PLH8THs8VRe4JxHOetgcNUyGKe2ElzgGdU/le8pEaKn9ZLccOH4Kk/DZW4XGF2ZgzxS+9jBJmBIRs9gdKc084rblgft/Zp41nK1ducexz/ERiwqNB4bPeuF7DDh3svNkAk/OpSG5uPW9ikpsaKP3OvkOjd7jAnNY1bdAB2bsIk9mwfjVMgIIVXnI0po3CkWmQsmpdVs8TUFGZWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciBMk0v2SC9yqKy059MJJszq6M938gk6Hv317w4BUuw=;
 b=aoqRZkk7lZNWxIGqMgxqm6Yq2dI6p7HveDduihOcDfOskHfEZLJJbOfwTJGR5NwOPjF4cUolORd5vm3BhEL8XRe7yWFUG+dZTF4R7r2L0DozyyklBDIegLbSlj/OXoOip+8Ijp9szMGy3++yyukqgAPVUFPzP/Yfn55Gcc4JVH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 06:23:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:23:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 1/6] dt-bindings: soc: add i.MX93 SRC
Date:   Mon, 11 Jul 2022 14:24:47 +0800
Message-Id: <20220711062452.3575032-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
References: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec10f486-45f7-47f9-0b31-08da6305d83a
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7xD/tX7/JWp+ZYZaSGIvimkPPB+tHNIbPeKgviE/UfyXL8hH0+DYsSJHXrCfdwLcekfiLSOWNsuJNpKtbOLs5mAwQhmrKU2trAsjbyz6QrKCHlfBeVmbzG7jXpWphlwwuwELhIX2osWjsKaeow+car/dumo4i606kjc18znsQhSBY7L6W96IqI5yuLtnm87qvQ/iNFAAifuiPSqP+/mXpkNN0lsMQ739LPGanz7zscDwORtGOEdksJsQSwszXI/Fv2XU0ho0CAooQyH8VQE6JP78d4XBAvou+VLEVLWItwDPbx4gPTl+BoV+cvUV17dVolmSXgZHpqZ6R/fElg76CQPiody0VGODdueq4EHuhMth1VbC6ZG7BTJQQdVccE35Ru1X/TKn4x4nBJZRi086UKqgqKsHZLpRmKZoL3pcgbZQFYcnqLXQqq4lZ9nCQ0lff2+DGZYM2dIF8xRRnPcldjorsplMVQxAoc6eEverNfwVvH8zG8Sqy7aAHN2FMxiNQrgU3US+6MGKaVxLDd0FZY2OajGRtjq3UgLZ3144uvP2Dt11Zu4V7ug/m8Zxxy2vPB9941oPhzRbtpkMtuMDPbYV7ssvEXJ4ROqUNPiWPM7SeSi+x7fZ8eT98nBBvpK3a9yYv58yo7uvBsjzrPgdANUvcrB0yqyjIHF8o1Rul8Y9wgwRJhaowNxpE2HpAVlgWeD9lmpvKoCJ9GYrgWhHjgI2bjGPYd9CX47lDku+ofMrn1+YFFmAMLQYOEJQR9tSA02qLNlK4ekJazzs3B+eD/MXhUFBSlTzZMUsgOUdRQRmSp9g7qA0C9uzec9dHEcuD+bmlNwMYXoDDSNkuaBBi9ULT4+PRbwgQgAPzCLCQ4M5hACqmvQqXn9Ncb67hs5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(1076003)(66476007)(26005)(6512007)(66556008)(4326008)(8676002)(8936002)(5660300002)(186003)(2906002)(7416002)(316002)(83380400001)(86362001)(478600001)(6506007)(41300700001)(6666004)(52116002)(2616005)(38100700002)(38350700002)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R93n4bqaMdu5zbcHbUf161b+SfehnJ36RLpulpiD3jQRrgnr9hxj8CDmrzpz?=
 =?us-ascii?Q?wRt3ZsLo+AJeqLU1VT4F4W3gI011iS0JLfbcZIllQV5v/Y5aw8i7fAVauc1X?=
 =?us-ascii?Q?mbqliUbKulH1G3WgwcB8HUjD9p2Hf7skmE+OuBFuT5hMVOFht72J88p4IXvH?=
 =?us-ascii?Q?7ICsd8hVBwcSVCzv8XKIoncHLGMYWX+8fwmjDhWSibYTrzvV/nuE4JlLIJHd?=
 =?us-ascii?Q?3hXg/yYWv61OqgOZguZQHmfmXiXooLKufK8KneoeSBREnqdt7IMfzdxIDYi4?=
 =?us-ascii?Q?Bq4ocPzKnMFqyQhZmD2sJIKBGs50lafOs2+FZQ6BTZl24xyqwhMvhykBIoIb?=
 =?us-ascii?Q?V+tcVQLG6VEhZP/hxwauOKvFYI9eFqMZa2qsb1hS0j/a5RlIX2RibSJIXAZc?=
 =?us-ascii?Q?YKz25sqdrwkINEYD1iihHttavzcJC3qhpQIdnqPLFtqqG5MTfMxeUK/hYlpV?=
 =?us-ascii?Q?5TeHNuM+rAJMG5/+y7QIZkV+KiNqSwAvWRxISFd9+7VcJZ24ZAxSXeGp5RhC?=
 =?us-ascii?Q?AIAW0duR9vWJNdloLgFovI6CZ7lOIx5EEN6l4z1xbHsQmQrekTNw3vlNUIJU?=
 =?us-ascii?Q?1M9DINwnCEhY82FRdLvWCDHrVRrlJbU2Nb8vCGMEOvZqExAAz0yf0V31d3GK?=
 =?us-ascii?Q?CdTx0JXfS5p+I6jcXSkFDpenkMnVcPXyUm05vnwZVrrc7XCvHfLkXxvTy6vy?=
 =?us-ascii?Q?GOsiy1T7xNUcAWsRwkUS7F+i+HqZM0C8yK9mUZIltRn++avaQwlV8UFa8B7b?=
 =?us-ascii?Q?Gq21BUCEFBdGLv9DPM1sRuoy0ylUjXk/NWJKfM3OiI4XufebEoArGDQyFnbF?=
 =?us-ascii?Q?5bU7mFIfGCAWWO+r2x8emtKlfWqJVEafgCScwD6cBi23xX5J+NoMh4OY+MBG?=
 =?us-ascii?Q?CCje/+4unfEdPR0CXpeMqFonKXMmcra1hfITr8JyhYrR3oRLYMVF3cdLTzds?=
 =?us-ascii?Q?OC9A1vk9Ljx5u0Lckg4Ed5Ujm7GsHXPEEIPtwSr8hnj8BRA0ye8zBo8wQx1V?=
 =?us-ascii?Q?PPzoKWZz587R3oUpWDUzLKax09Ss93prUkcGl2tllmFdprkbv3UYsdTQ+KUc?=
 =?us-ascii?Q?BZRAZRPg47eB7wvySchxJ/J1oPMA2uzB07SCi37ZvGer5Awns0V0t1P6+eZB?=
 =?us-ascii?Q?ctE4juODef+vznRHbM/s2l9mJGBYgawy144kmp91neQM3bSd0ZZkkgVO1B2h?=
 =?us-ascii?Q?p2GPg+D8JBj3HcRTziWZthJk5F+1BWvv/hTBlsxGgHSMVxVMHF37qR8BF7ZX?=
 =?us-ascii?Q?jeqf9XwzCl3uIpnLQRGEW0OH02lBi4wDGvOhqyfPR/XUum0OkFw8XM/STcC8?=
 =?us-ascii?Q?nZkft5GtpjZEwbV9HrEEZgnpd+OvXsijWVdmVne/2zKZpLoMySaBygjdqYsq?=
 =?us-ascii?Q?KUIRBthmQ5mG5ZeDe/9dkVidoD++tldw5pQqbBRuOzObrKYm781x4QEVpZHl?=
 =?us-ascii?Q?4S2CPW7/18+ybPQ9BqBQPZSiQN1weYm+Lg6zvoY18mPF9OCt2KqbnqYIEjqS?=
 =?us-ascii?Q?rxMOHNgx2rMCMrrlQFa+6fqGqazRlwnP8IwbyvQvtLXiwYV+A3f7ojUCMQh5?=
 =?us-ascii?Q?kxS9kVa97x7LjE+OldKIjNrvOIOnD1DIREc0ARTk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec10f486-45f7-47f9-0b31-08da6305d83a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:23:18.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeGaDoa2Vltg8fpZmpMqXoD1hhYJlDeZLDovZXElQLX04IwH+/lmKjoz7sDSZhHI/kpaW6gEIbPHMoFvN5tdyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5212
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
 .../bindings/soc/imx/fsl,imx93-src.yaml       | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
new file mode 100644
index 000000000000..5eb22c993d59
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
@@ -0,0 +1,95 @@
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
+    $ref: /schemas/power/power-domain.yaml#
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
+        maxItems: 2
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
2.25.1

