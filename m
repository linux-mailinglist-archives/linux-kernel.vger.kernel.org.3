Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D520A5681A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiGFIfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiGFIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:35:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2122.outbound.protection.outlook.com [40.107.100.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FEF248CB;
        Wed,  6 Jul 2022 01:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og1oIh3E/7s9bvOCmr10hy9KqiVypFYzTJokTbUDhZFhOab4JrE7pYqHpIdhlGv8uCPp0NjvJYqVeXxs+cybsxBHSpzfObCT/rsIhyMhiPJ8fRMxPpgDFxW1rPphSZ6V+5n9alFKWUmMJK1FLMdA99gzSBE7cpvU3bzFL4BToquOl5xWEW/LQHjMcFzRHdVld8CabQqeOovyYTRGO6aQpQBjPBF+hlpa1J9LrMC/i6RN4jxMmACf6Tux0HPZPxH6b45e0a2JAAG5ammfdQyXv/cSq8ZFJurc2eJQydi8Q6gTNAcxW7nHwFCL3ULNi0Uq3sxpLidMs5fahmJS/OGYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNt7iIU9Y/Ty25n/uAU1tIwBPqXeI5YIvYg+W7IPePY=;
 b=gp2G2y8FhIqntmTHP2/JG+2fDy9akxIs3Yd+0qIwWvZi7LdzoPloJkEfjuwYwSwfV957NrabfCfJrxFsB5z3tqwYbhOx5X9Ru5anUsO1p151xCWrmteiGqzAZuT4aggFbdQQ0oI8yC6i6yIiiaqs61Mzpig2sodbXKmw2YQmj/UgmoB+9gn8tRdV2Ega8VbZbYpiT3g9CMlh4hAvhyiAkt4H3XfaMf0/PwXvgfWIjycoBhrTlW8au45JAuHygR3l8JQ0A2X+QMC4CnhLd/lo2AJpK4GZSKACbZPpUSg49/s//E6MDLr+V3Mo5nKSMIR2FvagpHKQUS1bjal8p3VL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNt7iIU9Y/Ty25n/uAU1tIwBPqXeI5YIvYg+W7IPePY=;
 b=aU3LM/fSmJ/2BisoKCtZ8TyagovwFlUbUesuZfaJzHyzocHyFnsm3c+EZZzgRLU9SVWlS286Mm4CxqfZEqBCWuqAC+IuQDvMK4xzVlmFVO3SNoHB2Q0unHf13IPUPfquW33uQeDPfwxKbLQ8KwYvulhiZq2rMpcFF7pOxrnhWVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from CH2PR04MB6741.namprd04.prod.outlook.com (2603:10b6:610:96::19)
 by CO6PR04MB7827.namprd04.prod.outlook.com (2603:10b6:303:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 08:35:03 +0000
Received: from CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::5400:a1a0:be8f:34bc]) by CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::5400:a1a0:be8f:34bc%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 08:35:03 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v14 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Wed,  6 Jul 2022 16:34:32 +0800
Message-Id: <20220706083433.2415524-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706083433.2415524-1-xji@analogixsemi.com>
References: <20220706083433.2415524-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:405:3::19) To CH2PR04MB6741.namprd04.prod.outlook.com
 (2603:10b6:610:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0275a38-a3ba-41b2-5b3b-08da5f2a6c1b
X-MS-TrafficTypeDiagnostic: CO6PR04MB7827:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYyu10lm7CHuLtl6YS//+Zp02pCrarlBs1Wy7Dg83acpl16FjLFV6+RWFMoo/vQfHE3FR2HoG41CDgYDqOMamnHe4R7PNNhFEgZs/ZANuTOrligsh3QtSMOJlXXahVtGFErd7J91HXhNDun7p/ESmsdvS4uc0vf8FHgaZJ01V4BxalofDTVIbqYI7R3L6i0KJmV/ieyML1YZwt8d0FUS+PdwslAjDUYScHDavM6rufQT205TIrgrfMKO4C8V5cJYlDfHH3Laap0ktiJGeYXR5TUq+KnPTTHueYLloI739kvuVTTVjWKWQ/AQYTHVTrE9gq4NbUaqgofBFhCZgBhvFiBXo5f4qawrCQyyD7sYssD02SNSb6Ee23RwIbWmnGPNLeOGzDdi6oG33Cdv8V35pDnxuN/vlq6KQV2p1uaLpJ0o6ZO0liQyXJSt+FyR+fGZs4QoH9DV6l5i1IYCS1WWcMARuBubF1mcm7KqLzRrjEIh+8Y4NXyWYwKEdS1UVdiwt9gbz/WE/vFAIR2OARn444fiM+CVl9eWOh81mjJrv9QdzNz0TPAwNsuomP/8oPYCwu3D7GT9pvET/9JjEjrr/MGoVkUNmHEclaQ4oMFKDf8WcltjvQY+gA8aCHcgZxcJgPtYdgPrLeDVszBn7fZOwRnwcJYaEo8HLrgpEAYxV8y6x8jVUlCxuS+YpLVnC5UILOGGyUIQEzeYTIvRq7KtVEVNgv4eoRUU8xAxSzkt+04CzTkskb5nz4uxlTNLZEGQF9hD7MI7VVAX3lhlKUJGegZbpLGfchO7u+WjWEHyvuhQJLy7d9Av134zKYMWC+p5yicoGBh2wNRqEW+F+PkIN9mTfAoRdUV5ehhpznT0Ap8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6741.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39840400004)(376002)(136003)(346002)(41300700001)(6666004)(316002)(6512007)(1076003)(26005)(186003)(2616005)(7049001)(110136005)(55236004)(52116002)(6506007)(86362001)(38100700002)(38350700002)(5660300002)(2906002)(966005)(6486002)(8936002)(478600001)(8676002)(4326008)(66556008)(66476007)(66946007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f5Kvp7eLsPmUhzKQUvuknJMEtCWp3+AVfY4Ts9wfqdu22IezrYOOBMCDfYka?=
 =?us-ascii?Q?1WCuSSuAYnx2iUCc64XCD+MNSAXVLk2u/VPZxWuIJSqTIHpMgPR0TunX+98s?=
 =?us-ascii?Q?H8yMporImgp/I1RxwM+Mo6vK9yyS3xq1e1JOYpEYe92ewuBL2Hue4HHOQTaR?=
 =?us-ascii?Q?J3YnEEeQ7n3PXj1obv6hraTMEROATIRSXDq31C+HYhBAQ+a3IZ91RMdbSNf4?=
 =?us-ascii?Q?3Ir0THReoxhyZBmbISgIaUoJddnbehTBWrS9XxP2N439fVx2FLvfhHe1A081?=
 =?us-ascii?Q?6YD6gcWtBqa+yV+/qqULIsMs/2Q/Nw/1nRhgAm3k6R35McjlkV1tp5y8Jkzq?=
 =?us-ascii?Q?O0Z1AptwtkY1Xro0dhDgI6tWBXpfqTYJBtT5yLbX2ADbVZW1/HTJTIjzbgCV?=
 =?us-ascii?Q?RC5bXF2zTwjRIvXY3oTyH13mP+q7UA2eyhbd5xta7lUeYf7u2DiefmjSlQnK?=
 =?us-ascii?Q?HoskbPrteBs8dZRnewbCV1nLwv/HhMRd9FRR6giktfN0PdIG1oNhSzhvGH0y?=
 =?us-ascii?Q?GkCkAGKxc/YOUEF++jTtzR1Ss7pVsv7Ubtg1dlMeZRM5vKknGsBOVEaP1oaY?=
 =?us-ascii?Q?ed08yB7yZd1lg1/O4d83ZHQP/0GzRO99wTDGicunEVuP2ff72REtVqK0+w/L?=
 =?us-ascii?Q?BEp+v2t0h1Oq5b0Xx6Z3ChiDcYbadhxcph4QT+a+s6MXor0C00AAhXW70uLN?=
 =?us-ascii?Q?IdWRculN5gx29wwDz9uv2QmFD5p2pGL4XOtOMKdG8x5xBcmgKgaOQSAo1OWI?=
 =?us-ascii?Q?veNj/kXgi9W/2WAkT4IT9HlET76CAYkoNobS2vg2CpZuHtfMZfGYniZpHC6H?=
 =?us-ascii?Q?Seq60J3YF7joov2+gfQ0z13ZsxvUWUg6bZDYEuqwfnAEnGUdhIyLt4M9g6xu?=
 =?us-ascii?Q?RXlqG7jHGeI4ltBhJxJ+tEeU5JdMt6ExC11OfviFgPjEVrPdYaVsEATn95uf?=
 =?us-ascii?Q?3T2RPmF/4Tiwr2OgNOzyZII6aasOHa33SgR0SGZ47lyP6bNq9p+AAiuzgHSL?=
 =?us-ascii?Q?B3ZUbI4VRlH5oAM+jyOJznsuUU+t+7hPZpkTG3lJPnzhN7mnVaMgq43fKJFV?=
 =?us-ascii?Q?FB9iBKZ9hpYlWKxVfz+r3HLhO7UFXSBGyltYl2wesKVdaeDwNtU5ADQCck/T?=
 =?us-ascii?Q?itrWhLwVarB+ph7hY3ER+a7E9TpqjRzVPXENDMR7cjym1L5AHHsV8hxyZ4CE?=
 =?us-ascii?Q?OUsN5tWIn4AEHSUUaFdKV1YOEGIr02WJX5AD6xSj3OTeopUqOzJ/QwDvllQc?=
 =?us-ascii?Q?LD52xQp7smfdpcq2a0XJAeuT5AXHlXYhu2K6q/D/qE2Iqx9z0Crnk14LTreZ?=
 =?us-ascii?Q?w1erQEa61wlR3qhU33YjA3TE3yb1R96JuY3LkQPdF1l2Vk6OeUMral+OUJhp?=
 =?us-ascii?Q?R3IpJvPLY/1XQcJoE0ItP5EKBeOasOmR4mvJQboL3WIbD3hsLuEHfp0GSPQN?=
 =?us-ascii?Q?ju/NuJaKO7YmiWCxPsQFJnrXPWfNVJm2rRp1rCpnRMpUVZSho71xlMwhJSnh?=
 =?us-ascii?Q?fPeRAOfFiLK/BKzRWm2SOrOcp+xyDyQvC6d0YHOPl1hEJVdKBTDrqFCHbHSu?=
 =?us-ascii?Q?BFK6E1G+Plsj5u0lnPRW7+Izl6GeC/Jqq2uRjH3+?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0275a38-a3ba-41b2-5b3b-08da5f2a6c1b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6741.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 08:35:03.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXiqgXpP8JYuiWVqU9QlDAiRddRKF6uxW63c7obhGAoaCDhnAPlScmPahaBgdqwvRge7h4Aa4B8/sw0wuPrshQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7827
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add analogix PD chip anx7411 device binding

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xin Ji <xji@analogixsemi.com>

---
v13 -> v14 :
    1. Fix Robot compile error. Fix node name not correct.
    2. Change HEX to lowercase.
    3. Use "ports" property.
v12 -> v13 :
    1. Drop the quotes for "$id" and "$schema"
    2. Remove "allOf" label
    3. Change node name from "i2c1" to "i2c"
    4. Change node name from "typec" to "usb-typec"

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/usb/analogix,anx7411.yaml        | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
new file mode 100644
index 000000000000..bbd071ba338f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/analogix,anx7411.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analogix ANX7411 Type-C controller bindings
+
+maintainers:
+  - Xin Ji <xji@analogixsemi.com>
+
+properties:
+  compatible:
+    enum:
+      - analogix,anx7411
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml
+    description:
+      Properties for usb c connector.
+
+    properties:
+      compatible:
+        const: usb-c-connector
+
+      power-role: true
+
+      data-role: true
+
+      try-power-role: true
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        anx7411@2c {
+            compatible = "analogix,anx7411";
+            reg = <0x2c>;
+            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
+
+            typec_con: connector {
+                compatible = "usb-c-connector";
+                power-role = "dual";
+                data-role = "dual";
+                try-power-role = "source";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    port@0 {
+                        reg = <0>;
+                        typec_con_ep: endpoint {
+                            remote-endpoint = <&usbotg_hs_ep>;
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.25.1

