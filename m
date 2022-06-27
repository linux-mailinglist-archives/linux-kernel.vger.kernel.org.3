Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A515E55B644
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiF0En6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiF0Enw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:43:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F22185;
        Sun, 26 Jun 2022 21:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/2CV7k7UWNj+87BNvlhzXnZ6SC0DKajt2x6EX0NxcDMkwPUHWw/Gm5rZn2SjPCVrfK5aI7dQiXt5V+nLeyqdyaSucUbCLWCBe394vkDd9U36laBggJY65CLWVFHd52kLRPJSnoZ74x+RGEDjBbkZ8s0tSklMwrajy9qD7MmCOOu6A+EHAWEbpuScddiJjt8wwbYJgVpya9KH16ZG5+HEAyFI7abkZkP4yAErxYaiaeunbzrX9KJzTNCMwXRD8Qem3Qf2FcqjPEKof2DCP9cV3AvlXlva5qMYAc8uGl4z1bAFWTkaipvC7Jjl2o6jzwiFsmNMh+XzErpLgbsuocSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=jXK8y/CSqyAcpFlooTcDBqtNzQk+q19EBjzjsr/rkXy9xsrx99oqp0DRA89JM/oEhv+mhaNhGA7SrqaNIqys55RIOFZzC8zp2vtp7kBk/XaAOTBXJrW3BuHsXAJYK4qI1gtpjlo8O8wupFqOgEU7ArV+7tAYqxYOJ/t2MHhadeucBMQxa0UBmgUq9a1r4qdioDjOggSw6EVQ9fNN7Y/U7+Slma+F8wVQKXblkwHu89PYSiEhCabQwDm3xmOrKdDlM2gxhS/sTbjDrGD3QpCkFyevJ/kod/ip3lIgyh5Ycy+rCvitMR2XCX+g+Zdjw0TDjcALnY0FecIe4WctysjgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=o22V3+d5Lk7KfPXalzD4HVp1dGTHXMsrWsqwsrCHC1CMAfQV/7aqZ1EeBgPfo2HOZX2YbiG33Xm0UVkaYS1PUkiQw0FJ8Blwqg1vVaDV+0HzwcXDVyYJ4ctZ+cl/R1G3uagLzE4enHPNmJuW3oKrLIkX8/PQ/2SITztlCsFmBdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by CY4PR04MB0630.namprd04.prod.outlook.com (2603:10b6:903:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 04:43:50 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 04:43:50 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Mon, 27 Jun 2022 12:43:30 +0800
Message-Id: <20220627044331.2180641-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627044331.2180641-1-xji@analogixsemi.com>
References: <20220627044331.2180641-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::9) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaeefd61-d4f2-4ab9-d718-08da57f7a177
X-MS-TrafficTypeDiagnostic: CY4PR04MB0630:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbapk7uauFNaYTR+XsQYs9sQrg6Ao6rIyCbkdX1iLVd21UTv+7qzNjGQqarTG50uWTttJ/e9G9du5vHBtZGeGDL2CSqk9u/jaMTZdYnDkC4bBq486nStWbK/m9RqBhWMn9CZHCVfdvqgkrqii7E9LPer/3RJygh6zn/+LkDL7gJkgcHzVNlgSmSF+8AbinrCT3BY9I8GjhG8FLv9NH3vqdwqvn/shXRV70/PhGXhVwCJLDdYhW9Cay5eUnueVbb8aaNYGJUbF1aL5YWIfqthAOeudki9hCGKUPZi4UEIMQcFpaFvsiu0Tel9n/ykyutmdf6T6lLSSk/DsW2CJ9lej1muvGJPDkvCIz4lnUmW/T/ULzEbN+Y8xzjgo9EGvVpu07lc9MzKlKq5fuK2bRlJQPaW92/zd0yAVF8Z6cO77XtpqYZGLl77q4dcwF7s/joSYdAEYD8DUSHRgxXFUtFkIhqZWFDy3dyt0QFVq8WKs0aJ0JeAtL6uy7cQnwJRXHArkat+GGoaWseXDGgTPzZmMlt7hxQ0K2jlSAVSZBP6fHehhvB6qhvlgGQ1Cci4O6995vFx/IrBYvdT4WnokgYaF2pd0LituObu4DuZp9Bem1NT1BWSIIn0Bw1FeL6kEKlZJexyb6WITDUc7/WMy+cNs6O9GLlkoFRO6j9a9iyZXCO3VxIEw8E6X5Nv7Cs0EvpFSUNxHy1yC6omaFqWzaVixGZ/GrQlJIGF0VsT5JcppDIwBpMcFaraI5X90ILn/Zgehn1PFmoxqOopma/yXlwI97IFHeEN0ImLGamve1SpzhwGvUI/kDMbvtAFhahE4zk+EVTzHQj2080V1jNskyJxZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(376002)(396003)(39840400004)(2906002)(478600001)(38100700002)(8936002)(6486002)(36756003)(316002)(6512007)(26005)(66556008)(6506007)(2616005)(38350700002)(41300700001)(186003)(4326008)(66946007)(1076003)(6666004)(66476007)(110136005)(86362001)(5660300002)(8676002)(7049001)(55236004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ot4BG5rT4Xe0HV74qZIqdfVRKdHzBGNzdF8eMOi20n3u9dkDs6XmmF0WfoMH?=
 =?us-ascii?Q?milshNYF+sWoKU6C1CuaHa8Dhugz15zuoIcdhGRgmBEVx2TL/wgLmEIqE1l+?=
 =?us-ascii?Q?WXV6L15VwyiQtMAASYzed4JTy4VOQgu4cdi5bF+1XcPq/wd1EwU45Si+rs2j?=
 =?us-ascii?Q?iQjApWMsik30V+MbU88km8ieCHL0R19Or2riwLQBysGg614Yc02fYt/pefOs?=
 =?us-ascii?Q?+912Ak430HoVF14ZSs9cUgfDQNEkaXPL/IBQI6ail+QxDH9ZB6iwjAOZMEl8?=
 =?us-ascii?Q?05GGqN20xKquh46zJhOcCKIMfXKhemiYFLMLD+chCO9jpKB0TOsShZ9N207J?=
 =?us-ascii?Q?oVdO8FR2n1VxcMWb9mFIrU62ZzOlrBHZK/4uvvfLmXc33gvP/g+qWIHHYtfA?=
 =?us-ascii?Q?s9DW0HVzUFPhzhy1+Dc/e+iOgZ+RYcqBDeTfaoEXQiuD2+t84d9U2fnfjHzN?=
 =?us-ascii?Q?67c7VvZs3OQH20UOL21zBS+UiC93qxjBuOK9fFYq+PoPR/VjR7g4EAuCXTmf?=
 =?us-ascii?Q?Hweh93E5IIf95rJESW5YlGCSSZRBvJJjejQiNPuNh6RK3iRNCTvgFXkFEg9/?=
 =?us-ascii?Q?JrOtGMakmbTVhuFvokqozg7bDzhSl4Tm/eGGN3NpUSjryqDGW8idnlolpSX1?=
 =?us-ascii?Q?q8B1avglQOn/oRlLvhybWfkU0ERrkF5c58XodiPe6NI7C5Pdoeq0fuIl+YUI?=
 =?us-ascii?Q?a9zBh/hiwe3IjrUzCFrLXQDdBCCjp3diThm1/gVIka3mQyt2itoGf2RubRlE?=
 =?us-ascii?Q?fSQAJJu+ZhKq0+/GoRhT32RTqIlJy20B6/Y925pYuRtr5CzknLDZZ+bvH7Og?=
 =?us-ascii?Q?X5YZp59Hngz2l/bZwfWPnUpmkJS03fRs1jhsaB3m25zec7LLKgYX14hhgvQQ?=
 =?us-ascii?Q?jsfa64AbWpG3KX8Q4PsXDFkijI1OM1jLs0Iu47aeMA9anQhCHhntP1m5ETzT?=
 =?us-ascii?Q?Zo1I9U9C6+KQZv49K62joqlhk30La6KKY/7gvolN+b95akRwNAZsNIwugiWy?=
 =?us-ascii?Q?o6lRclSoEMI48shRLGZ0AqDF1vd1xCRm9TpUksVRlREAjDFIwSB3FGCDpAjr?=
 =?us-ascii?Q?z7qwL5lguGYH/wv3o2RcKHU+mqwEUqM+/mXwDt8QoSMmvcOOv3bQQn+az1C/?=
 =?us-ascii?Q?i9xbQChNhmFQRwkHWLStNDjN8P3YKeRmREZf3Jo97Wg7NCUciNMhKGmjkkP8?=
 =?us-ascii?Q?NxCIV7WqUT0rOjuNUMMiSQFqZPKyAXkoO/H8Cla1t/yeIocv8IJD6C5xH7xd?=
 =?us-ascii?Q?kKCZ0MgOZrChGtJtsyC2C6fBk8+nLmpGozP3DShABs0buL7GLNAy4NIJ0+je?=
 =?us-ascii?Q?BW1P8c7fkq/MnyshuQVN2r3UoVy233e0ogbcHO5Uyzn9EeL822AzlGhVnF0y?=
 =?us-ascii?Q?Tz81aiDCmbv9zpxbSlmZoSQdh/ccazhFjSh+7zruEe5HVmvjhVl2v9j5Ceci?=
 =?us-ascii?Q?QsRXwQeVo/rTPnSThCN1LBvCVwQ5OBBJE1/tabT50TBEnNiD82FqhnakYZDd?=
 =?us-ascii?Q?eHhe2VEGr/7aowmp/aSoMKARLajRqMOK23me4ZcBuDEM5ZtE9KPL0/zLelfH?=
 =?us-ascii?Q?qYr8GurTBzvo7HajOs5eIEQDLGmwXSf5J+zxz65i?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaeefd61-d4f2-4ab9-d718-08da57f7a177
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 04:43:50.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wh9FOloQRiico/PeTPrD0do9T+4zUbyD+V/C6XAd4ZKsScO0gMh8z6UvQZkS/ghszqSgPMydBXh2nVcHx9nWGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0630
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
 .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
new file mode 100644
index 000000000000..c5c6d5a9dc17
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/analogix,anx7411.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
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
+
+    allOf:
+      - $ref: ../connector/usb-connector.yaml
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
+    i2c1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec: anx7411@2C {
+            compatible = "analogix,anx7411";
+            reg = <0x2C>;
+            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
+
+            typec_con: connector {
+                compatible = "usb-c-connector";
+                power-role = "dual";
+                data-role = "dual";
+                try-power-role = "source";
+
+                port {
+                    typec_con_ep: endpoint {
+                        remote-endpoint = <&usbotg_hs_ep>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.25.1

