Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB7579447
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbiGSHeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiGSHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:34:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8832DB5;
        Tue, 19 Jul 2022 00:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQQrfYlI7tGeE5cTRlsQsr0NwQmf9gln2EminvdRTNKKOyFpGK6xjejwikA0oYyCKUwrnUoJz4aZrupC3RcG3DiKpSxAqV4Wx+7QRURYyFE3B246pKavPXF1+6q5ecxLbUoUoVJodNFOnTCUUJUIlvMB3gxgzSzHYcG3i8ZEvi0KTetNexNRvc96NlRBfQHwowKLoO38DWYIuYbMyb6tF4D1L2a5CvU6Usx+Q5GUNOtmC40y0shX0H9XUn4bUasQTHQ0WFgLdIwb8ZR9gtTE/g4pF2AABtI/PCHwGiRxXNw/iOJ4yknKTzaGtyzeo/d1SfH7hfUh8kYElPEeEdVbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avvm4EphBzu1+xRzKVWwaF7GpEHl6GCBGzTvLgYW8rU=;
 b=dAwKDA5y+rOAFtBI3lpopZhk898cRKKnQ8BOLDRe2Od0bW3l7M0yVaRvpng8t4nC+UGwF61pga9ibdCAli8YvXrbt8gau2/VBeODYCMzwdY0kUKLjPjtdtsqp4zk5JbKu8IU+HeqfLv3B8ploJnmDU3RiZ1b0qMEwlR0VqeSJc4d/V/WQOWWSwK49Sud2sbTZrmIp07Pd2UlMHmnOPCvpu2zmBkxNOERinr6mAtbqiDY9wf6tgj2vyzovMwhUGPneCVZ7eK7/H/YzaUCLhehG0NrVJrc6LlqM/21QsVtmVda7wjvzqlW4lA5/Vra+sKmFMJODUaQ7mkZCedEz+YUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avvm4EphBzu1+xRzKVWwaF7GpEHl6GCBGzTvLgYW8rU=;
 b=DdGpH25w2QQzLG7vLmJ95J6XDJNu35M8hL7LWllTD9lT0BrHhWcaZ+8Bo2zFyaSvu34Ws6mwC07uTgq+Q//2eqIo7/+mROjW8RprkF/suHjhTQ5pZmFZCHTnv2WIcSeysi7Qs0b1eZ1Xc5c6iJmwT9UVV9uf4hDMNOppvyShJ8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:17::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 07:34:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:34:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 1/6] dt-bindings: soc: add i.MX93 SRC
Date:   Tue, 19 Jul 2022 15:35:36 +0800
Message-Id: <20220719073541.197788-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719073541.197788-1-peng.fan@oss.nxp.com>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e92ee183-bc2e-4474-c377-08da69590e42
X-MS-TrafficTypeDiagnostic: DB7PR04MB4298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRv5BW7IkjeuaEADWVHS3ivE/ma5WKR2+JO2Zl+EqdcHlcdf/Vdh07pXUv5OjCUKLNqpd8HLYTBkIbp2snZgkDdzA9fPL++yQmKzOispZi3ObbCPDbVH5+byeWSPOAytA9C623PhndNFenFafF9tWe3VbeehaVAhAOsS0hd9gu173xPCwag08AxJI7cCFZSypfOIr/R8cfIa3eU72gFa1s7ij1aXqJf/jXYkjJaObXf72zsBXCb6PCsLKmdNvHSA5tLs8oMxB8OjeO3CbKQhoYIRNCwg8kG/L/mW2LV04v5OlneD+152w2eUupsL3Z3/knWsI7iiaeyM8Dw3CRoSm/GYb+gz9h9anwTHjtGK/Ah28QwQpP7rH46bILuTEeXgeZiLZWxfQ+VPu42oR1iu6Ow8i+HQJQ39J+SUEG5jEOxMxN6HtPvpB7YJB1FEHIYW+qx4rV4xtZPPBKQ3nN0pT3NCpb9RYnFe0UMgSRpFpBJ5fwcEzOnPSPZLb0a10APgWpsWyvbhAmymcLynALrOM3LodXS3dh9vDC7TfLMvdZ1E7Al6w1EJ2yPAiWrIrISY0xz4Dm7jmnpm1of93aE50DqyVCVnAEjfqwkLYsOKcHNji3OFb+hBVZ0cxicEsWR5AqVYYrPkb4+e7+tgQJPewE5dQ1LcIenlQEWdDlnGpGpv50bkokLblnsxE6mrTLUdqvSSBxJjWUL4COLs0LHAI5jbrVt5ubibVeqQKAgZc1172awONrZzrQ82O1R9yUjjy31PLza97VyrIhsY3szfQZKnplFjyqueY0NPvAyRdZ7hqrmcL5D4JSowtYfPBDpMuLKr4n9U5fVV5BH9rb622LFBn5wHcB6Oap0H5r9wukhZ9kARyqGFLPOtoVXqSg8H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(38350700002)(38100700002)(316002)(66556008)(66946007)(4326008)(66476007)(8676002)(2906002)(41300700001)(26005)(6666004)(83380400001)(186003)(6512007)(478600001)(2616005)(7416002)(5660300002)(6486002)(966005)(8936002)(86362001)(1076003)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2w1XoCoXzidZw2Ckh6AnLwKEPlv7bxBNVjG/YuDlhexZYsHkfQyLlgNOyH0?=
 =?us-ascii?Q?4Eun6SLSt7lCNiS7DJA/ih4mDkXxmQeOd1Q28zpLRyM59CMFnbVQTi4lfsLD?=
 =?us-ascii?Q?qCY3usXVpc7W7mo2vvxQvaYeFCiwdrHetrAE9zE6pVB8Lwuf2OvzJv8/Uhoy?=
 =?us-ascii?Q?aJ2qYu+Y4WeQHOdOcPYZdUCRiGFCVYgpd0oq7YnC+27G/+YZFb+NSJ9xASD0?=
 =?us-ascii?Q?XIM60TEpzkDSlDe18wSDo+CGkvD2o8xHgRhJkCZyIxdc13wq73vG+nZ1ChO5?=
 =?us-ascii?Q?HK3/29JuBp0f4Qe+ffLRC0ndE++c9wG1+5RszduuYtzfUGAU5EEO54hh0D8E?=
 =?us-ascii?Q?kIXh88ZJoHonwHzqKtPPFo6sZpfXagtennNnMG8RTckL3WHjpX2QHFugIMeX?=
 =?us-ascii?Q?WVy2Hv86Oz2dhaDa0E4JtxvkJFcIGr4EU5hD8+W0CblcWn1w93Hiy5+Fz0Nf?=
 =?us-ascii?Q?a1El2qvC89Qb0I/dzfud1tpWNgzDw6J2ldOOr4IQNalvMWSWY32JPDE93+rh?=
 =?us-ascii?Q?6xyk0vNcBLqsqeK81v1LelV6HAIKrqavVfToXvPeF6tj/rJg4bs0TftQMYXE?=
 =?us-ascii?Q?PNR3w+QgUhwuuYDYK7QW8VVRCOAEHn51l4pw7wUKCyKN+6S38/ixvhd5VqLL?=
 =?us-ascii?Q?mvQ5uo1pjUwvSGEW60jBTYrxqqfE3n6iDE0W2wA0XsiQJgewyLAJFwh8PDNQ?=
 =?us-ascii?Q?lBs90PxQMjgajluRINlJFHSLaZFra21+gpu70wn4wxXgOQnW26AjtdkVmL3h?=
 =?us-ascii?Q?n1LB9uJLC8ZoEv672vXjUkPd6eDDgTSQGJMOXxoU5IuS01V4/Qz+/rfG4m0N?=
 =?us-ascii?Q?uxuqJoeyuyXU11E5HEL0gjOnaVmPQgoBcaXKelZ4dUgbLewu7GXNX0rOomrR?=
 =?us-ascii?Q?YN9wRFcWRd1P6gtWzvNkcRWlt3xYHy01GMleC7TEr5SIzFWZ38qN0d7RGh4C?=
 =?us-ascii?Q?kI4s8cv5AME31CNBWIRs9KwtVfo2pgJTxYGocUdufK88tGCFOvvp6eKp7FVp?=
 =?us-ascii?Q?YmU87m/VvAv/U1R7nfj4Zs4tomIeMNpL/6hjXas0TtTgeRu3h0vQLaVybzyp?=
 =?us-ascii?Q?W7TMRO2WnqLLVhxjfp+JfA6wBfRx6RVVgogHocwiSfUWS2A1jx8FmgFkBmLB?=
 =?us-ascii?Q?FIy0W4K3Wt81jkEz7sbP689ExUJ+NJOO0tewmdUSb8XJdbY7Stvh88Ye9Ekf?=
 =?us-ascii?Q?UDn86UrhmZrJJEb1sL/sT1SDMlT3ASsOsd6ohdENhP6uaujTjFmsZyvKbp+x?=
 =?us-ascii?Q?CM9GS9uSgLKvjo625CMDGAzXmc8LzjAXIUkxsMYKU11W/7UKqe9joCGWO5q0?=
 =?us-ascii?Q?Zmg6eihQu4O7dRFPtxLisONPIxL7Ymk/zYPhKeV2m++f1xKTVgPIKf9h16QX?=
 =?us-ascii?Q?cSnvsintiX4Hg72nloPDdbdJM7jTt/hAfdJZomN59aVmWLXWSK0FXwXpcdwV?=
 =?us-ascii?Q?aRGZ24Z7ENJvshLXNewo5B7dd9+nwwVOFZ3noTswvORfV41x8LVytsZ1N7Eu?=
 =?us-ascii?Q?TW0sBCwcA5DpoQ0g52EF9/u9RwfKTXrp5xHEyAXwjNwQYvfRJEIMjGuVOQ6D?=
 =?us-ascii?Q?VhM0DCWePME45TOvNM0HQsJ6ciAj1VzEGhVfz7AQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92ee183-bc2e-4474-c377-08da69590e42
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 07:34:04.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hbKV72CEBn8uvzp2kPJTOBvaijBdsGy3iHGri8DmsV2SttB0PzAJjvp/ap1BGMRmvvtsgdiEstxTDT1dpwJkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4298
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
2.25.1

