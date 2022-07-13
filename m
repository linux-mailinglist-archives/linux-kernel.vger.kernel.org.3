Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CDF573161
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiGMInE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiGMInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:43:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E385DE43E7;
        Wed, 13 Jul 2022 01:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfUqzUsNo7QNW4qC8rTb5NdAmDfwXiCucuaJogWQESZy3JcuSwp66ohxBq5e1hsU5BYsutzHm7p2Y5msegix7XD+p9XtReHqzkgaYRaVd7clUKa/zkg5jCrVDlRorBnEw7bRTDQ+E6cGMbxPg5NcmjmQ3vb2RVjgvnyxKFeT+00Oe7LTO0FbZ5FpbJJa0aAAXUfeQDk9irNi0wtNBoj5GEHf0omWAQycavJGrCrMSpAURQ84qgCTM05QBCmnFPUG/wa7DhD6XEg7X0uyYa6T93F29tnfSnbqJDQCotJMnqMu1l5VXLPS88UaxUqGutsB37femPKkHR4gS3XSKjpAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpVg89JW7KafdjhfUSXRXc8zGedZWkZbZvjswN/a8YY=;
 b=lHgAdNJxv9YoA8zo7D+zJNFPQfyFD270vjWSsMXvDa9WQs95lzSH41D0W1p6SPnWbQuE+DGCKxCkl1U0SHBdmtboN0qAikenuioxLrJozJUhhPsubH9LfwZBwoznKtVMyT+etuKfTnLxh7HFQtZ7X9oIL0O9STmL9gK/Iya0gYWMO/wcyGTDCFtMGUIld7H/YpmH0LaAjNL8IGZfO30FsZIwHNDMNCR3BlpwYJWkNOGfuYVqFV4F2iYXeXJzusPWDJLDLsT9MTlYiXuHPJQ32USrP+esXga/KPa2cuIrnRoHMUQts/5cBP0e0p2YiCI4hFtb3hNi7A3GHkyS9Di6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpVg89JW7KafdjhfUSXRXc8zGedZWkZbZvjswN/a8YY=;
 b=fXeCnTn2Azy75aHRNL3NP2bT1f7Vmaq0Gbf67JqRcXzE91uRZeN8n6tPFHLullPxahRwSWXF8MXNmQ6LLoAtekzc81X0rioa7HOk0pHrkc72axPH/f9Bsg1GWmioH2p6chFrhmx4pkrI+86szTle+JB2UJe6ME99FyjrKPfycgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by MN2PR04MB7120.namprd04.prod.outlook.com (2603:10b6:208:1e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 08:41:55 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 08:41:55 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v18 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Wed, 13 Jul 2022 16:41:37 +0800
Message-Id: <20220713084139.2810115-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:404:e2::27) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1c16ce-0c3d-42c1-6fe4-08da64ab8a67
X-MS-TrafficTypeDiagnostic: MN2PR04MB7120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpEzaMkp51xqCtgBfr9wCgXFLUPw+vTIVBcf67Pr7jKYyHS8XnjP4gXIoVChepCPSNZMjKi/9PbrSkSJW5MN6PcMEboCnY7Z/X+VzL7OM4fi8gP362WCAScm9hYlRoLIytoILUlJEU2tw9iKcyRBCb8d30jHiU8q1HgMflbpDoy4XGbbkFHjV6xKLqkATA7A/Im1fa5jjKOYS8/mqgvFlaRDTzLQ2z3MEewaKUtXtCxepPz/s2HZ1CDOtkw+fLyp03czjgcc0abXuTQHcG6rVK6RW83EOR/QohyKrIYK/3Yzfn/muDS0kefsI/jdEWkLPgdmMrtb7mNSsZ23bgXj4QmY0t0VypdWzqul7j1GtrQ/FBTQRuSkc2j+Tzd4AlJ6Ne1H+3knQ6mvUAfFDWyf7c5DGwcdriEWa8EtqSUn7HzonPmYpyS4m0CB7U+ncwLJO+YMXdWVifplM2Tu7hs1Dea+LmwhKn441LFN0ygMy8JWGzz2OgcJX3IcqohDTXyvr6mfli7qSF8c61d+GbPD1CFcJs+u8odefOs8Qj3PED+OFNexgxQVms9NAG5G+jQwnO6DCgNEYaM5nE+1QDhftqcokabZL0fQBaGZAsw4o4khVGWdb4iDEHe9QSSDcHrDq8+HxaHy13qgB8UhrbM6f+tTdVG71+rlhGYbSfpzuJrB4356paInYVxe22txkgtl0Fh9uZgC+ocaLpOFy00YMaCmlH6PxNlbhQ4PeD6OF6e8CXE6QZGeAj3aDbip+VLJTsY+JIN47vbAOO25gdadaihDbagXnHJCQD/hDB72eidZo9rqyARq9YKFtLoNxEXCUuGzr+JggF0CDnF8BE1BJ93Dj+HEwMR4w9jBlA97kqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(396003)(366004)(376002)(346002)(136003)(1076003)(86362001)(4326008)(66476007)(38100700002)(38350700002)(7049001)(66556008)(8676002)(8936002)(36756003)(5660300002)(6512007)(6486002)(2616005)(2906002)(478600001)(41300700001)(6666004)(55236004)(6506007)(966005)(110136005)(316002)(52116002)(186003)(26005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ghY9Cg5TwD2Gu3lEo0Slw+w8RSN82JpIZ0+h1DPNW+RBTqfFU8nFanLtm1YE?=
 =?us-ascii?Q?y6EdvvcLQUioPuzZ+q74uIle4gd7q6Mkrxs8g0MjTNUzx/uHvJA0abaGelt5?=
 =?us-ascii?Q?hg54ctQMBhYujlXKZ9Q6Ru1C9v1O0RCjcR39h4I5Zf6cJXxsEtatsEzyi7S6?=
 =?us-ascii?Q?D76zUA0DWcwFsfmYA2B83pwzvQ8P3QYzRFjki4RIWlpYxYzbMRgJnUCVMVLV?=
 =?us-ascii?Q?t4QuOWLNX4Uv9U9P2Ry1ngUV111cqFEm0I2aybl9/u80lHp4rRSa25de8gE6?=
 =?us-ascii?Q?c6yus3+pIa+cDffM90iwRBgXNPT1v5waE7MXn2+GpXwZj0rLd2Yts0x8vcx5?=
 =?us-ascii?Q?JZ6XJ4h6lldI7JY8hDrFqYfgOkJ1QBakYlzRhcMPhwv5TCm0UG5kvUWQdW5y?=
 =?us-ascii?Q?IA1aRKJlUtGsZ/RB9ohkRDmsiEG/Lvp/CkZ3woYdXCqYOFgVc9yBZExRkloM?=
 =?us-ascii?Q?2YOqujNeIzNrVqChnZjdNnsRUD45YEx22cRqwesTkCP9xDltpCda9wE5kwaQ?=
 =?us-ascii?Q?4A610st4ZVnycGSRl9JTYEiiFoVWkaBX3lf4q5hyTa6DsRPi2edUjH6/rAX4?=
 =?us-ascii?Q?cnLUWHAMCiVNwYS/kxrZkj6ETSJfo+06CJGP3hMZPhrJts0vA+95sFxo+RtX?=
 =?us-ascii?Q?1M8+bC4SlZ/6rLAO4rIMZ9V6g9JjvDH/dAQ4S7Cwwbd3givbjp6cGYFECC68?=
 =?us-ascii?Q?9Od2Eyph6csAbiHx+zphGJ7ydocxIMe5jtLrszSS75Ybe3EwpfXWePUAuoMw?=
 =?us-ascii?Q?7eFhgn2rN6bbMLpZZ+V6elCjA3woFC2483Ztb7JfZE4mi+RV57ykb8SCtf+q?=
 =?us-ascii?Q?VWVuyIUl8cGI0WCrwj8oJZsjmD3lAlJ8/WPLhwtpoulzPkq76N6UctX9meE3?=
 =?us-ascii?Q?m8bM6AihBl+dlP7cNWZa+y2TZ9WfbMGLOolmn2BIG5MdaeJikPv+SxTxNEfq?=
 =?us-ascii?Q?EMZJwVnc6FZvOJ0psm+XkzB82E3cpihwkZ8BbYPBQa2UBsQfIpRoVz9ghw8y?=
 =?us-ascii?Q?PFeBW3xrLM8EFyNROv8xgPo+NDzEJBzuHXuhELHoootlGjXjMDLqbU/yP23Z?=
 =?us-ascii?Q?P1eA/N6AGn7+nDdSnJeH0joBkfMgfcBL9hDpoJLSOTqMEs0AlUrd1vaOlCmV?=
 =?us-ascii?Q?U4/020jkqcHdRGUfigW/k5l+AUjlbp9k5urjv216e3WinECTSphcMPcBL0YQ?=
 =?us-ascii?Q?cZsp5NmjnHAx/03hQjsiX2jBGkBh5RjO7DDEimPiiL23nILE89p+lLrdAnNg?=
 =?us-ascii?Q?xUFEU+zdjwyH944gXdwA333LlywbuaG3t4OhTzE5HUBZjg7Wav2TFvdh5qtr?=
 =?us-ascii?Q?Dh+NHLqMerkKMHLiokMoOeclMvObC+QW9T3V7oRHxiyDafzFdg1Swr5r1XbX?=
 =?us-ascii?Q?M0l14HpcrvoX6cVXQwJ1Wg5wX58SerpP85g1RKIi5AZDmRAf/D0PhOVueSPZ?=
 =?us-ascii?Q?knefevZ+NKv2evVsPABv9d/FT70Jc/eAjJdRHgGDHrcU0Npn4h1Lja2StQUr?=
 =?us-ascii?Q?pxDdy90ipMElmG3FBM7NaiRpIp43tFz3rhZBq4uORXTqwJm3s09NecqbyYpw?=
 =?us-ascii?Q?XJCP2e8tWv7Byz/bBuN6rM7ZhOOhFjA/fQ9TRcnp?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1c16ce-0c3d-42c1-6fe4-08da64ab8a67
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 08:41:55.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgN0NkX6AnybnMeg6If/yO326MtqDVwjVELAHEMQPHyXJ7lpKXVdt9MWGiYPnLvlkgKEF7m0UFYLwNbPq5kVAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7120
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
index 000000000000..080bb9a61f40
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
+        typec: anx7411@2c {
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

