Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215E5574664
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiGNIOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGNIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:14:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F31E0ED;
        Thu, 14 Jul 2022 01:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA/frJN7jMf2vioiU3U7HeI7Rj61g0BB/HOvnV2/0JP83J+1WXmRqzDiPXV5Axx6ArmlnA1saYjZCklg7bRE0Ap0P4qnWG8a0dyc8evenlGBSRDHku/90yH6OQ0vrLasQweXYjLe08RD9O3GO4eoKeFQllwBPncai6IuN00vS4FE1qk3Fe/cmUTXSLc2LnLtyqrTjuBgXKlgSBAGOhld8H5d8gzHtozfH5JSctrTThU1gyF0nNnYN/LXA9s2mHZCdCPLUH0Am6RG1Kd86bEY6njWdf1L/G6vC2Nc0xR3RXTSyIjDFr5E6oFL9tsN6NYUZ1ZWofIYZYhOkr0SC5KmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1SQ5TbWSAXMQvWWXNIX4L9/j9KIt7Ogejd+2K2Iwl4=;
 b=IKYnGH2prFPLil5K6WzwN3XrHn/cbrTU1hz++7QvRfhVkDWZedbsZbl6BUn1cofgRxCm6r/xFBpDLtPwg5sLocM8HekNNEEs5tZ/eOug6i53jBUE4HmFA6W9jJOU/jNOmxXCjbCeKUfzUf/WkPeiwQcTb9cL/tfUTvMUmf5Hv3To/4yJ88M9NUVWNmJhbY+r4xvF6iZazWdqDNoSkEJgNhCLvoavzICoDGRYYW6CLNJOo1ile+NhxjJ1MaHLdcLicONa54f3YSJo3Mti/6KD7OXhFKEySdxfJw1URWF9SMxyX1aTvJ7anp0rqPPLGj2i5+Lo69hGWLt3K2C1DFLKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1SQ5TbWSAXMQvWWXNIX4L9/j9KIt7Ogejd+2K2Iwl4=;
 b=g+QyJM8n/Rj1TPttqNlnAHe0er5WTxDYCaxkTCArv5FCfo14yWu45EsgmQrN9zWcBE4e7StfhuWCJQQw01e8XRRc5XaEavlFI8fCcg4r3zuPopbLUNpCnWkKeNyANgsrre+Xlz8Y1FDNjDSx4NU5G0pyVy3+HJcrg+Ojjdvs0uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM5PR04MB0251.namprd04.prod.outlook.com (2603:10b6:3:74::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 08:14:00 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 08:14:00 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v19 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Thu, 14 Jul 2022 16:13:49 +0800
Message-Id: <20220714081350.36447-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:405:1::13) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f56ef1-ce2f-4168-d1cd-08da6570ce90
X-MS-TrafficTypeDiagnostic: DM5PR04MB0251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOdQdBNZmMMR5I5yBWWgzRBF+p8Ym+exjmF9M3Cv0GIyhfZatu8cR2YAQkp3wuGM+N8k4uFHmjYqOzLeob0C7Tsg4Exv4wl3AFYTWMMFIu/33mZ9ZkT73ZwgyaW66R6DiMAXqwzAe0uqGdJjZXgRLWF72Y+Pc0TbaKS0IWv8r8ag9VcY6QGCvAA2+Af33+lrNt6s+J4Fd8RqVFN5u7KFHbdWMqVPuQWvyGaZwfgMhx4uYwNY8Xdf3jOCefhDuz4DHHJdp26I0WeS26xm02V+g40N2knoqb6Q6UMi9g6vuhkYgwpOfyozvEOnQdaGWrKeFE3dng0uFAU+uCeg5Y2dDWKrFvJGyEBUi0DpbXLw0fgCrJb+UpuPWG03l0ADbc1g1e4dwCEAfNP/y96NEdllE0an78h29TjT8e7wcHuvyU+yJyFe70DrjQNFsVIgpQnt8Tl/2LCpO0A+3hCynVg5xGURcNCwfXwN+6pcVGRyrfqrHdMGS8qcWkC41t3DHwiC2xkoXvB97GFFVIiTso68VQIiXhaQ5rLWPAa4MCMsIQh3Guo+Wn4N1VzV56uKC6INOG+8bgHsIx4Ci2HnHgm+qMHZnKXSKrRb+rHdr4oTHHjM411ZpUsr0ttCMvJgVsW0L6gpy8/jktUj1b0CdK4/kHUAt5aAC8nVr4iQ4L5aCL8WNv6v3cu1L52f0NgEKEX4/66GKzYPEyPQ6/hVuIxC+l9hpb/AdsyFIUg3HRUqWk99A+2GvHQW/9JTTx1kvHwBg2UWa/fN2NxbVjFuVExZW9BgBujFdqLt/n9iCj1kW/+GamiNEKXPSsCHgI1C5lVyto+4Fnf5bIDv1sngqd26+4tC7jyRr+WjRkN/mXiZrLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(346002)(39840400004)(366004)(1076003)(55236004)(6512007)(38350700002)(478600001)(38100700002)(26005)(6506007)(6666004)(36756003)(7049001)(86362001)(52116002)(8936002)(966005)(2906002)(41300700001)(2616005)(6486002)(110136005)(5660300002)(66556008)(316002)(8676002)(4326008)(66946007)(66476007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EptHHItjbtgJk67NqRvt/Fq821zR8ozH2Hzcw8EFzAYW4rRgI1FNb5P96Iwk?=
 =?us-ascii?Q?q6VgdvT65WuXnEBMOOLrsnysTTgri/TNamdjAbzyhMvJ5jVqVUjvPzrtMjtu?=
 =?us-ascii?Q?5wK0FHaOFem6MgjadvNfK1XRKcvrQHHsFD4BuZv6O2y35+PoImVkfzcswKCn?=
 =?us-ascii?Q?7yd1DXE2V69Zmix2xxEBYoNRulOex2wfduaOZGnGN05QuLojQRHKDjncQGNM?=
 =?us-ascii?Q?uXKs9ku2C5QSYC2oWHJVZ3iAge6vCuUPYc1L/dWIpNdZn+AV4MXkNGU2gHcA?=
 =?us-ascii?Q?mgS8u8tLVULbL+omGoG1yPnW9bpTVMRb4e2SKDWd3XnpzqSxjtcWQ71yi55u?=
 =?us-ascii?Q?03DNS0y/HkRXKGEhjAhktEN1pQpOFyjsmdXnXbVYhsqdVMqWNnJyUWYYlaIr?=
 =?us-ascii?Q?x4DQprSsoptdFif6IkIDJi56TqmmuzLrQPL3YSa2/r+Smd74qqJH0tn13+oK?=
 =?us-ascii?Q?s8+GeAULl18OmBddKiGEF0xJECUvYW3rVTQ8jM24nyYTqmKw6i0NbClLJ3qK?=
 =?us-ascii?Q?XC+w2/QxrMi+geunOM7ZGUS9C7GNCdgEqyfwAyjCFLFfaEP7W2OT17iuXt9h?=
 =?us-ascii?Q?ciiQLY18bhNOHU5xwqY3YUBRBSMZnGWTy9A8qQzMuebgMQd1e+FPEnoYgIOg?=
 =?us-ascii?Q?PBxGTPteeuFDUtGQ9EnITJf3gCNsChHlP5h8myOT6VTBkAXKHH/Gu6KWfffy?=
 =?us-ascii?Q?Mci8MZD4ku8KP1BxsRugX2rmAJx+TEWj1yJZqXUONEn7o99J2cfBqizSux7l?=
 =?us-ascii?Q?vg/TrWvwd033la4QFHXlJr5D0ywxy86XRBVDzvA0cTG4YXYg56y1RrFH7l1y?=
 =?us-ascii?Q?GVdR1LJeGKXBir08xaMtwYG2D7u8v6x4Bse+mF+dDCOzAzN7XeXeOM/JqF60?=
 =?us-ascii?Q?Q1ruYbjOH8t+TwhNPubDPT5g7SgboUk39sWVHsc966SnwgmGKkrYMSzOVhiR?=
 =?us-ascii?Q?eeoi5NMXMB/7NBhTNpZmrV5e3Fqg8nzilo8AeSjzcRd/0ppu8CNSmBdxoiCX?=
 =?us-ascii?Q?W33Jj6FglHvDsuN0nTKnAabjVnsSBkNhp+ljsa1CIfackXJgegK6B+qOwYe3?=
 =?us-ascii?Q?iIiZkcPcaLTVLe2YOfwjKC4jlBG2KU0HharAGFdZvJzlyjRAwwNaSJk6u8Fv?=
 =?us-ascii?Q?2YX/OhjoqldPm1YNf8r4rWQO3oOregCmM6QtMEr/S86IVF6uQy/35MdFQm+u?=
 =?us-ascii?Q?5O4rhtNS2tyEyu7YTrK60WIZZvUvnZsGQzcN73Aul4wUKh/O13+ZUv91/3O6?=
 =?us-ascii?Q?q8Q+ddnfUmnSVapw/lQ4uhMnQ6kZLweUVMq3QdQdLQ+3edcKd0HZFrkOFCtm?=
 =?us-ascii?Q?Sex6d7z6xftfpAoOVUvxqP39P1/CiDbCZ1gHaSlFbLetoY3VygbIx7Gle3rp?=
 =?us-ascii?Q?xwefrZ2rE5SyL45HKwt/q9VJ69o6eekwnJKYSA1LgXO3luKkQpFeAx1erxD9?=
 =?us-ascii?Q?UQdSluvqWJl2o+xkj+UmHDK82t0xBLYy8Ak2xF39QOQDeRCcnA4RgsHZviD3?=
 =?us-ascii?Q?rOUtPQTob0Y+GYVQbSnyLBTJdvjk+HCExlXA22O83VDspDDndw4wKH82culA?=
 =?us-ascii?Q?otfcst95T8yo5Y1ioTlkvzYXnPAXbHCcsy48Jd0a?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f56ef1-ce2f-4168-d1cd-08da6570ce90
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 08:14:00.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfZJtsbjsaiJr7bOAYe8QtMFGNfmxDjdGIcAogMcWrw2F0ZJFbZwWwbhxkrF5qKTp6bdHxaD2x81EQWPIgYMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0251
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
v18 -> v19 : Change node name to "typec"
v17 -> v18 : Change node name from "usb_typec" to "typec"
v16 -> v17 : Add node name "usb_typec"
v15 -> v16 : No changes
v14 -> v15 : No changes
v13 -> v14 :
    1. Fix Robot compile error. Fix node name not correct.
    2. Change HEX to lowercase.
    3. Use "ports" property.
v12 -> v13 :
    1. Drop the quotes for "$id" and "$schema"
    2. Remove "allOf" label
    3. Change node name from "i2c1" to "i2c"
    4. Change node name from "typec" to "usb-typec"
---
 .../bindings/usb/analogix,anx7411.yaml        | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
new file mode 100644
index 000000000000..ee436308e5dc
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
+        typec@2c {
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

