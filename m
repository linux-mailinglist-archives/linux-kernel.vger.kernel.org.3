Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDED5AE39D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiIFI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiIFI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:58:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0785624BC1;
        Tue,  6 Sep 2022 01:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RH4QI43RMtnm9dzsYl0YSUjJyiJfoMwmhEEZtyTSf5yaRh6tOSHpYSUJ+fdjv2b1P0YH+jEGfsPz1EM4mQH6+0i97Bj1QKta89p2KOSt9W+rIn8A6WufMPRbi0zrZfMZEnwIslmlQh9m0OzdYO0X0IJFhPo/imV/L/dgWFp/8mjUtFJbal+fpmMs2yHo/K7mganaIo0SUDEOw7+QWhMEu6Z9C1Sg91kjUNMFBbH2y0lvKekanMt3M8FNyiQIuA2/HBZyp0PcWTDSXgaEsR/FTUZfVlT3T9O0dU4m9aTH0AVibRW8K4RsVaRqYreMFcdAwMGShrcakc6+UTaC7b6Eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1yHYvtrCaGg1T1K0Q3bQiucSXVkwa6JR59aPtH+eRc=;
 b=C0AoFypyu0aeQqEHLs0ESGxFgYTSEL1M+ohH3eDa01dsoPNtTramgQJHS4TUdEVelbcT9TKGQCnPT0YObnq5FBKRDFVj3UMaI5cc5VOw4XOClKC+3DfZyaEiEHpQmja91cN+Rh7WBZhZscFS8bL+HLhVDPpqtbPvtKy00Staa8ZHB3Yav8ZT9m77P9nYLQgA66FeOhiiPutDwXYVq9Dh+VE9TFiR42oy8rmbL0S+RjzrWxpLD/5wOTJjHqEdy2cZo7OeRDZWyhODxg8912OnppP3juC1NGJaJG7JTBSUkoJzYauRonQr9VjySuhdo10pIu/pNKXH4NH/GxFje3xmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1yHYvtrCaGg1T1K0Q3bQiucSXVkwa6JR59aPtH+eRc=;
 b=JHoLcCF3hZQYa/ETOdrjI8LKVTwbTrj/RveshjCqe7AoVFZ7BQrgWQOoauBSQpiz6QiAUO+gs4MXkAtwe44hR9tiFmSUdgaOqbUHpFJhnzs7+5P59PwvKl2wLDyNYIMPC7rKKx+wYT0hIBpxa+qWZf32VkKPB/Obn7h3lY+1Ybs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB2927.eurprd04.prod.outlook.com (2603:10a6:800:b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 08:58:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 08:58:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: clock: add i.MX8M Anatop
Date:   Tue,  6 Sep 2022 17:00:13 +0800
Message-Id: <20220906090013.3724305-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cdabb01-9cce-4ee1-d309-08da8fe60285
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2927:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6wDeepiS2rTvQaIzowUgATGXby+flftgkRHoFnAJHlmzIME9Fxy7CUOJWpmFXyVcsUqWdORjRLa5Ik6+vAPJgmtybk+kLevbirFPTP6mcS0orIFBDUrXm6mbnIpxsosa/EATYBsvn88biovGAACUua4jqkeZOnKYbJX/Qk3okCAED3QFak870AxZW+5UC6OhSQdzJrUOK8+5uV4/L9bZbd2/7ftB8bRpmIZHw5gJp1nDAEbYlkGw/Vv//Q1mK9+Ys/APzicjWnQUyOn7srlbwn149Hdj6CKemcTCFJapkXnd9r1g2NAoNgVhCsjICztvGQktiMZ16SPImbkCS+mOqCIbU8i7AHQMesoYE/DM4V9ky7KUAqtmurC+8G+1cymg+ph3I4o87QFHUqv+mldnHMS5ULI8kdbtGD52bgBm7YbMqt8MrpjgMWaoSWlUSV6tcEt+LWBI/opo+xchnAAr8FCf60PrXLtp5TJoJ4wlx7J6ZzVG3mSDkjlk7VTO9bsy+xV98pmcJLVpiZ2nEtwVqnYI+0Yh9vc2o5QfNhXhraqzz8dk1A6TWkQJwLXe2YiBp4mKG2KYS+7CsjrGl2CWLFZNHiH3yAxTMyVv70/PSjRAoYqh5VZ/LIiKnisLRjQzmR1XI10wDNPDGivnn0Zsw3JCB7lRIZ/iH+ejT7wpHugC35PvIMmV1P3vAFM/taOKQi50sF4XUADJaCnglhE3gEUrovofpLTlL66duxDDwnQ0+S1DIbPu4hpleXMQ3o/EI0iEmgkwGi0G1flpAceKB25q1Evw1CjMhZ7XHh2Fp1RMRuMsEyOvfcyyCFbXxSMYzpNxa+L3qSuxzIsUYZ8/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(86362001)(316002)(2906002)(38350700002)(38100700002)(66556008)(5660300002)(7416002)(8936002)(8676002)(66476007)(83380400001)(4326008)(66946007)(6486002)(41300700001)(2616005)(6512007)(1076003)(966005)(6506007)(6666004)(186003)(26005)(52116002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DByE9DtV5Ge107KYMdnJ9Pt/bH16UnA+0tvhAnKqEZ6R5M4yAMPnI0oR25O2?=
 =?us-ascii?Q?Zqnm7s0zIEBVvBtSq8Fjojxd5KWKZ1Q1a3gvH+dp1vg9vtYg+mVUGf5lWIKC?=
 =?us-ascii?Q?NTnu9T0n1X2d/RsGQIfUR5auSsOYRtyWzgOpxzRXWS5SCq2eZD7GmNzqbYSe?=
 =?us-ascii?Q?pPRL8yvg9HD/2KjIkQc5PPQGdOjtTB82vPZQOwMi+Igb7ZadYRuVqtthxDxj?=
 =?us-ascii?Q?isJTWIUmAzJ+GA7o4IDzyWqUGmH/QeID29NAafgetVvEF63MexirbrerW3JD?=
 =?us-ascii?Q?jGA0EWIAVz7hkoYLtPrJORLHS7Ugka/CgW+ip3CgmyNtxw06+uBJZkCsSr8X?=
 =?us-ascii?Q?gx9gDY7KfUDUgag38kwrXAiAmnf/vad7MVy7mdnNKcs3r+7Wj/aVMEh0o/bt?=
 =?us-ascii?Q?XPiAYQnjJoohHct2Srj2kmMbLFaaBzQJL8XxrBBC2AdovlyrKGRwByvL8pRz?=
 =?us-ascii?Q?VXu2zKCzTlXPLGSD1ULi+nqYD8425/T6ci59oWHkK2VtSXYDt0umF6UkKHc4?=
 =?us-ascii?Q?wQKhTf4NdjYk+VM8V3Z5YIXpiuUkkGwrQTZrGo30+uxbIISbzlSmDAnO1bEw?=
 =?us-ascii?Q?WCNz2CmPBhjACaCqiDpgVR9LGEQ1PbK7+Z2uw/IiU6xVeqVtJJoNnQ+d9luq?=
 =?us-ascii?Q?OjwR4YPyvsa3pk1ttn+gEdXQFDK+4S4Ap417AvYvhnocevkOvO2sm3nuB4Cv?=
 =?us-ascii?Q?W/Nzlmd+J/yL2fqyHhf+xs2n2llcrk0nKGqWz8hbVowYKve5s0zfNs1TS+sc?=
 =?us-ascii?Q?bTYpyyIK/oFF9bSKlvOPMrxOmhF4DcCiQszMpG7tp3LvLogysR4W0JfAqSxR?=
 =?us-ascii?Q?3VCiQ9WxZrEFADm9qyVjhhZkchFReEZFqg7vJCQaorMIMwTU4Gco+5KVP/aY?=
 =?us-ascii?Q?iN/jIxVxjr5aqlOCeK5wudXxA3tAhHp8RhXaUxTjyJFv9BOpxbZykke4c1Kz?=
 =?us-ascii?Q?ZpGZeVDB7fL1HOVsxTtLbkx9YwrKLcePFjHSQHKCBqNaFvqNH0795o69LCf+?=
 =?us-ascii?Q?Cc2qMC6GpFLNoPIeE/6Fy5qB3bYnPV051PEfXaiOB+V2LRVBiRE3GswF9UI4?=
 =?us-ascii?Q?3+gnfkltv7wfiEB7RmY3W0xYO/0ws6DTJIVzJ4yJ9S8Xj3E1l/nu6inMt60k?=
 =?us-ascii?Q?x8vE4wggNE4OwtIuCHPTusLlxsJU7EnyvLVyPGig3hPb7DTxDrUV+OPN8XwZ?=
 =?us-ascii?Q?XxCCPUd8INTkT5AbwXC9KYkHLInRhNfIOmVaj4mnH2Q2wQt9C4WU3PGYVLhi?=
 =?us-ascii?Q?qvjA6NNgv5rnRbMtHraa1Cf1O76196JkNyUfgb/Dnw4DCGIofxBNQYIUjNZt?=
 =?us-ascii?Q?zMdPspmvi4yElJgLNhc9hD+6XbbeSaAbpLcCiqZYD35zQMbBKYph6jWY9tpg?=
 =?us-ascii?Q?IOsQwuAAaEF+6QuDyrEW7qgGVCX8GRTYMMx7DmnoRTDek5v0mFhOspzYxSdh?=
 =?us-ascii?Q?VSmXnx4ooObR0MI3FFsHQ79dXejBvA00d8cV+ApD9NJt30uMLqPDYk2EyKrI?=
 =?us-ascii?Q?76rxrzjE/KRejRDh8mOrpNOul3eCFXQcbI8qihQBV5wnhFkcXlKWgBtlYGt7?=
 =?us-ascii?Q?phUMORRKSsbMApqOhMszinE2q+MW/IdFebLcW9uz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdabb01-9cce-4ee1-d309-08da8fe60285
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 08:58:47.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtapB/vMtvQgl6l0hDxMMcqBIppbbmCSq/j10nN54ALlYXI+FggW1vmQq657w4BJrUFL7bebQZrrvHZg6kljVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2927
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8M Family features an anatop module the produces PLL to clock
control module(CCM) root clock. Add the missing yaml file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/imx8m-anatop.yaml          | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8m-anatop.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/imx8m-anatop.yaml
new file mode 100644
index 000000000000..e247a5774d17
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx8m-anatop.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx8m-anatop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8M Family Anatop Module
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  NXP i.MX8M Family anatop PLL module which generates PLL to CCM root.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx8mm-anatop
+              - fsl,imx8mq-anatop
+          - const: syscon
+      - items:
+          - enum:
+              - fsl,imx8mn-anatop
+              - fsl,imx8mp-anatop
+          - const: fsl,imx8mm-anatop
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    anatop: anatop@30360000 {
+        compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop", "syscon";
+        reg = <0x30360000 0x10000>;
+    };
+
+...
-- 
2.37.1

