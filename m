Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42694518D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbiECTqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242013AbiECTp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:45:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC43525F;
        Tue,  3 May 2022 12:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzoEpypc7GFDigDbkr+ifwr1/4PUwrerfSPB+etJXcrQ5iIKwprvxRQLNTfwYYQ9utQvGr8hyk1hvkQYik4lykvSUkgCk3ceZAqn9/ZEArZoz8nCca5wzET4Ie+rMjZ+e+xJrvMbp0Eb2OGtyEoMZANO/o1RO0LUsZwfdxR9gh/9aH6DbJXcTGr8Hf2SKkP8VB8heJFlsvUUqQj+ciBT9pmnJ7Nj7lpckXnGCwxzZZTQjQCq4Gp4Ieywchmc+otPYvnnMtESOkq23f9MRznsw7CrzPCpFwFCEmL0CDQMySZ4fS+k61DeM/T23tbnIb3YcFP27hQI0eZ5epMT8LM19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8vtGgRLuv3nRyP88JXO6ZK6yZKrqIXDuyBIUjFkNfA=;
 b=PAg1Rx9lDhKQ64c7sdJvhbhnldaqyHC0D1LBihb2lI524+mCI6eAO67OPW1ulbVnjgbQzs2hBJWYMkjxW0Xiz/rgtxbaUgJJa9rNOPnWp4zAZ1zYfrrSrss5L4OzWeqNfo0dFYFHZp6XipWqw7ko5v/7+KAsjG56M0LGJNwLDHhTt5fpLGgR35LsHvzX2LisTolQixZ9piKvazd6wte2oUGaiSK4J0D8X+HSfcDkXX05TUA/Mu7FjOM4AFjmWrRTOrNMlL/ElMUmWVEMWIrzvco/+of8K0uegdknVQxBG+qWGA/LSwG+EXmfP0b6HSCKGMfybAKtQRGzL5wK0v2Puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8vtGgRLuv3nRyP88JXO6ZK6yZKrqIXDuyBIUjFkNfA=;
 b=Gg9ypdHkgBXvwka89rcQP52ni31O61f8DrQzZy0jbsi6o/usuuDAoN72AcGWQwAmMVs7ibzZ2TXW8vsFlQUIKXvyEwh4dGUTjeMCgMIe5RYnnGDeqLcQwXySkDrl81NF1gcKt/IyfGaA8206TW71lzf1xaVwwt6SfX4bgCsP7Os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by OS3PR01MB8115.jpnprd01.prod.outlook.com (2603:1096:604:171::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 19:42:22 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::fdcb:b853:c0a7:8d58]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::fdcb:b853:c0a7:8d58%4]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 19:42:22 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        alexander.helms.jy@renesas.com, michal.simek@xilinx.com
Subject: [PATCH 1/2] dt-bindings: Renesas versaclock7 device tree bindings
Date:   Tue,  3 May 2022 12:42:00 -0700
Message-Id: <20220503194201.25714-2-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503194201.25714-1-alexander.helms.jy@renesas.com>
References: <20220503194201.25714-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d9f7799-c08d-48ad-103a-08da2d3d0ac0
X-MS-TrafficTypeDiagnostic: OS3PR01MB8115:EE_
X-Microsoft-Antispam-PRVS: <OS3PR01MB81159DD81AFC7EDF31683302C8C09@OS3PR01MB8115.jpnprd01.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lLBGVofe6qH8PB69nLfthm0Z7LDHsYFcjJVa692ZftS1bTAt2yJBR8D/UhyzIC61quIvFtz0DbG4uegAivarsRYO/CMzknfKuCsTnalBwengmQBWU7ZARxb4ptPrre9uKHPFS3K32VB+FuAkPKf5p87EdZGM+b2XwQTh1WqkBEyppiEMuL9SN3zU/e/u85U8qeS44LJFOJtCsRFHeN2+eqJ3EYEndCd9OirNXV+0Cq3vCq5QrRCY0yIMnZW93+VFUQUwfwVlENpCNBCYH2ERgDF1O9lQ76a+DyEvT7D0s7i5RiiMva3e1BVeDWmU9zlRcUL9mD4FUi4xy2uIDTNqWCubjGfPIhoQRAXduaiQM0URuk8/dHRSPaFitRe7CXHCc2BY8MmQxv8uIGktMjDKqsHFABIJQQPlRILDgRZms9RNmlLokR16yy4nTkDybGMDB1RjbPM2vih+RpYKqljDxDKSTwxTxCbSVo7ZUSf1y57f9fnQSqEG3/sIwoEmexF+JWcQoLl38SfvAtdU7C+Eg16a6RCcTM+sADCnFplg/BK2JPIRgpCThGflZ24pKxJkCOPH/qNH2seFR+oyetn0FBSyRASj1gqktMqD8tmK4XgLKyGmyMpGts0ZfDmurM9qx7oUsWEEW6NwOvS21qj7ifSnK5irBRK3wqpfI1dItfrKCiL7FxKbyZkRQ7PLAMmD7d32zvrquslemnnN/4knPIj6CvKaRrP83p1cxNsikCiYpk6qyNVFu0hKgJM6AWAjNHOi01+fggf+sngVTQBmXMrKY/KnTdbq9D1baZ+RqgjUC1Io9WdNUHvrGGuHQrh2F3IgH3B/CDzAvlHvAOpvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(36756003)(2906002)(316002)(6506007)(6666004)(1076003)(86362001)(52116002)(38100700002)(38350700002)(8936002)(103116003)(83380400001)(508600001)(5660300002)(66946007)(66556008)(66476007)(966005)(8676002)(2616005)(4326008)(6486002)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZidBU9tWHC27ARUzGKdyT+KPrqfkwfLhOI1CLH6+DaSoJoK2ryHfYxk2DVD?=
 =?us-ascii?Q?k/m9n29BGopqXNEGZFVoCb2XNA7OdHzncnRzi29X0eV3n5YSbGJSOinvcQga?=
 =?us-ascii?Q?Llu/zFg8LfCMJyqpsBZe3cnhvRe6AQlFuKQYGxyuhIf3mXmJ0V7YG7DStQMK?=
 =?us-ascii?Q?pzDwX2rl5uEPafjq4tmLEWlUmJbM4aUaxlVOSq8AnSAT949CxG4PO3IcbUKV?=
 =?us-ascii?Q?vqRloul6ik24X7OcXvOha8a00bOssJo+oLrTZETkw5Xd3E2qEalgCcUJmC23?=
 =?us-ascii?Q?SLqxoaFI9nOgCAby0MJR9bFbB9zYB6f/SJAhFXUhR5edVoS+/5RmVMCCcd1R?=
 =?us-ascii?Q?Rb5B9Whd4S4fpiQmTzqEwZV7IM59r6kiii80uDMLjRTLdFhQl/z7+Tza0aaj?=
 =?us-ascii?Q?n3YrWpd48ngJ62oM1L/e8vG6AG/dG0tDALEvtmgQD7d672pwCH2tXKaHS4AY?=
 =?us-ascii?Q?i6lJ6aznSkEXI4y/8qxpi7IaltQI+TxQafUqK+XL6fraFm4UoLJLgSXhwioS?=
 =?us-ascii?Q?n+w+UyMR1mi108vfneq3vZN5ZUsxpI2bqBd2OOD+EPACvSbVI8pqbJCe5CWA?=
 =?us-ascii?Q?4dqNjkDuUuLdUc/iTQPM2SoIkBz4lQ9cqPuAkhfvlA7U9CKawfRQNGbq2we2?=
 =?us-ascii?Q?DrKeicBJmkU5mWB2TcjOrDZkiM66UywKC5zsbjaLo4trSo9wg7Hoa440YLql?=
 =?us-ascii?Q?TZTN/lddCBuzxkCvvfwft0lKjzxfnhi1+DDdcE6WL3d+HT5tfmNJivmYhBlv?=
 =?us-ascii?Q?Y+WFn5N0tBE1t8K0Iah3p00ZH/5CstdQ2LpfAbtLNvoLUjf9AhLVEla4gaoz?=
 =?us-ascii?Q?QU3YNoRv7Zuz54yu8hq2wbe22L4fwcUplqWPfnfA5U8/eO62Wh83cqdVJHfb?=
 =?us-ascii?Q?xn3OxeVo+7bnTobBxIqI6Iliw7xdvT7SsmP7aUntSC3AnAwJPbyi+gxf4tA6?=
 =?us-ascii?Q?9+m0v74eeFSzuqnfWiQJOQZM3aiPV8RPKyBfJ70QSmAU5k7bHUW5BFyX9/O8?=
 =?us-ascii?Q?O3iAGPfr6IwN+xcCid95m8NBEBk0tQXPSfQl9WvWElL0JpvGBsoMf4IGUfSt?=
 =?us-ascii?Q?eSfQemmbOU3R2LE4Xx6JqmKknISZDufnTQvQPGEvO4xXBeGGXwoUoHk3heam?=
 =?us-ascii?Q?2GWIwTCHYmYPLU+aIcgHpYkl17Lrr/wwZbTDQRoCaacL87l1mrr0jvZxpy2X?=
 =?us-ascii?Q?yX+bvSRaIxJUOsWS8aWOj8wg1BGoFPd7GZAC8vB/ry0JyLON7ISUWmyqzQLj?=
 =?us-ascii?Q?qTWa4PR8Jk84brx9HZNUpt5T+GmcuMzKoMibjqGaqS2sHMsh9P2kzPK1qIjw?=
 =?us-ascii?Q?bBV5yP4iajbGE8Ck3vhU0uxPSQENuGrSK2xW5sZecGSRuUeZYXGOgWz06A01?=
 =?us-ascii?Q?e88z5yCR8L1S7xRKBKmeoOJokDyvBSRnzat6abu0fd0/rxBM//lIuO1QHkl+?=
 =?us-ascii?Q?iQybbWZv0ce3omvddgU0I80b0rSlI0bgzy7QJaKRUAX1ndDK356+o60hdywQ?=
 =?us-ascii?Q?zLSjaGljSfvi4DWyBamCblbhT6ocX4709w8PNcHY9/j7tkmMrH1fM/v2acbr?=
 =?us-ascii?Q?S8cTDZxP8y9n/Y/SJrptxPf/0fyOm2vbO1xa3P4CeomrXKbZMimuAiPV9m5O?=
 =?us-ascii?Q?5mJ6Xu/JWnu3wpHYg+cLUjmzL6FnvzRtCyyJtBEOAnXs77X86NO3O0DkjPel?=
 =?us-ascii?Q?rKiPvA9VSvi41Wf6GYQRRi1p/spxMI+jeEd/4bVxFY6aN9yL0ZzD+RrMe2em?=
 =?us-ascii?Q?+/1xK5o2TZtZ+0eDmbYUiutdNVNl4/m7eoy0lIrZ1Hq+53jkZ5Fp?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9f7799-c08d-48ad-103a-08da2d3d0ac0
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 19:42:22.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdmNOG2cuhcr330Mq8wxhqhgUD6e8Izlp887E62QEXHm1Tbx6ug7xZlNUwzKjIRhbB4gu1mHvECGp7bvGWVU+sIVbYnOr4thcOwPFvGwKuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas Versaclock7 is a family of configurable clock generator ICs
with fractional and integer dividers. This driver has basic support
for the RC21008A device, a clock synthesizer with a crystal input and
8 outputs. The supports changing the FOD and IOD rates, and each
output can be gated.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
---
 .../bindings/clock/renesas,versaclock7.yaml   | 64 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml b/Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
new file mode 100644
index 000000000..cc099d9e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,versaclock7.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Versaclock7 Programmable Clock Device Tree Bindings
+
+maintainers:
+  - Alex Helms <alexander.helms.jy@renesas.com>
+
+description: |
+  Renesas Versaclock7 is a family of configurable clock generator and
+  jitter attenuator ICs with fractional and integer dividers.
+
+properties:
+  '#clock-cells':
+    const: 1
+
+  compatible:
+    enum:
+      - renesas,rc21008a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: External crystal or oscillator
+
+  clock-names:
+    items:
+      - const: xin
+
+required:
+  - '#clock-cells'
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    vc7_xin: vc7_xin {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <49152000>;
+    };
+
+    i2c@0 {
+        reg = <0x0 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vc7: vc7@9 {
+            compatible = "renesas,rc21008a";
+            reg = <0x9>;
+            #clock-cells = <1>;
+            clocks = <&vc7_xin>;
+            clock-names = "xin";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cd0f68d4a..8a23ea619 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16536,6 +16536,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/renesas-nandc.yaml
 F:	drivers/mtd/nand/raw/renesas-nand-controller.c
 
+RENESAS VERSACLOCK 7 CLOCK DRIVER
+M:	Alex Helms <alexander.helms.jy@renesas.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.30.2

