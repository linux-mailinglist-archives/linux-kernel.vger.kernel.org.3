Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97524959D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378644AbiAUGTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:19:20 -0500
Received: from mail-dm6nam10on2137.outbound.protection.outlook.com ([40.107.93.137]:15136
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234126AbiAUGTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:19:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1sQs+dMOq2SE8BEhll75wcMYBIX1lJJKExHf855+IW3L/B+t3IImXOC+0/YqN6xvh1GbfdeajFQ1//S/5+Wil9YBpJVNuB0HGP7qfSSW863ErF4sDElD75WRzZJ4SqyvIXXH20inQ47cJZO3ECLWo6zgWB+5D6cMqZczi+KkaUmSKg281CRF8CMVf1t/3eGhJ/HFugwXr7mjrFsBivlaU4/IaX0lX8klBM++9VzApP8V/VZ1Sa1cWlQIFpS+iozhcSzOpOirICtiiJZemwYv5N/ZfbBRn281a8KQq/OwTCnaQwgoDhNeQbhT7G7WG8lhvQBJqNlroALmu2Xp/KC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MW4bqoImvx+fxKvPf3M10JcKtmBGlmTCpQUF2ucyg=;
 b=l2DrNISiarmMFSaXYA6pkcNahvN94ygf/jF9ZUXxp09ARWN/NsKxbd60rvsQNEsNugl8FE7YLXSBpWsuVcgyRXrGpgbaIo72vRBqlpvGWZHzuvXG5urEsGhY1GKRTy48VcLo6NwhOdrhRsZTbOd+sgTf3tWMGZvh40Gh3FxD5PW9K+IOpV3DT1ug0fzVcwGBmqBfEs1IV34D1PX1upjWp7LPRQCzNUdWg4lkp/t0kHpmic4xWkFihoIwM4VfGseXwJnFXKnghDI1eAlstgvQeyX/XwLeMcCwm9a97/gARI4i9q3gwiyfTws1KoDCbYfrARUcwcJ/pwpYgB7QoCGcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MW4bqoImvx+fxKvPf3M10JcKtmBGlmTCpQUF2ucyg=;
 b=d6GcLaMlZQrRQIDN8hstBl/MkPk9rbECLT+wkfXLTldBgnq8hgfBCxkaLF/OkCelWvBRL0OU7wxCYmoo11t51ewF1oXT4cP+JVa4fJ55+A9z4Fs0hCHz3qsfnsBUkfBwr+xE9Q05IyFxRjtCmJKILVmJsdiQ6bJ/Y926zJWLsyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BL0PR04MB6579.namprd04.prod.outlook.com (2603:10b6:208:17c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 06:19:18 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%7]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 06:19:18 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Fri, 21 Jan 2022 14:18:55 +0800
Message-Id: <20220121061856.2038958-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:3:17::30) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d865cb0-22c1-4b83-f986-08d9dca5f491
X-MS-TrafficTypeDiagnostic: BL0PR04MB6579:EE_
X-Microsoft-Antispam-PRVS: <BL0PR04MB6579DC8D86919157450BB07BC75B9@BL0PR04MB6579.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/YyMXmwir0CZ7xYZ66jwYkK6I147xJNyno+YSWjtz4w1trXnncGsCaN0AYCm3vJ4sNe5v1RI81iDVsUJlPHCfifGAjX2bkl2ilzFDMGYpgoubF49U/eLNFIkd7OH9xgSZV2zTWa9L+On9w8FpQIDXHQxj1hJulVccoAK/r0cEJOYEXSbtKejfOMxTx84UaqpMr8bH1VsNX2eBWTUL1VqYEzuC0DDinUJXFACd28j8NSDqNrrgjvH5f7T1yQCescaJyAWQ2z7Vxd7VQPW/lLY21ehiaHIsATAMfQxLqTMnj83r5FtjQGU/+DZ4JoVPh5DZlA15huZdg5mbd523voT8ISv924VVOFf1OuQxKVfC+Weob3oi0vhVGiX91xWpJimQw6PUjGaXM3TxvYcCiUBSGJGu4JwzsdqDcAwd/j3tiWZU6IkQUKaLiUQ1m5hWeFkQPQFfzgaSe1X10bSo8XNEk8JpMUwM81Ngz5Sw/8lg68gOaQL0bvX54ylRAJqlF/reIfDR+U3Z2X+ijLKb9DPcCCeAyVW3yJEgSAa8+d5rMertiZu6thbBJOJU1nYOM8yUKcQ4AEXPtVRj/ppV1PbqpdoKLr6oQjcaF8K26JMH4AyRg0yOU1o9eXLHgYfTxN/QWhXuBv+NuVlOpzsUroFCAZh2VzKzYdxq2fBLMVK3/O0wBGZRm7VGkn6aWng/URFYyDFJge1i8qcklGZZGrt9yku/7khC1FMeTgQO1cjJt6SOKV8gLWwaaJy6K0RRuxawhwO7mIhodVMhocse1zoyOQskg9+vH0682SsIg5HZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(38350700002)(38100700002)(66556008)(66476007)(36756003)(508600001)(86362001)(66946007)(52116002)(1076003)(55236004)(6506007)(6512007)(186003)(26005)(110136005)(8936002)(316002)(6486002)(5660300002)(7049001)(8676002)(2906002)(6666004)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ZSvBtN05OVuzFCp7vPvzz72/rOaVKEuk5sjFN3QCqxmGKXDiMOaA/jgyW+k?=
 =?us-ascii?Q?/hVVdfzmbVlfnikaPRvRUFGONKWMGMgkbfq26MhiwrxRcFs6IdKgf34++zAr?=
 =?us-ascii?Q?hZT/Vo0DAmd1l1srUyWbZ1ZDz6U+U17FK+aw8aj8neBDDNJHSU/UyLonICQq?=
 =?us-ascii?Q?QrlXnw109czjfD7rAKfj9fzePSxlRLQREH1gj9EvcF1SCJPx3htnuQtB6Q/W?=
 =?us-ascii?Q?z1mX49nLv1zPGo6b3ieHZP4/Lcl2SMEvYrZNLC0ig/MsQVlrdE6ax9Zfhlgt?=
 =?us-ascii?Q?0RvDv1l+Yqhw6vH1XQr2Ho2tpd36Hgb3eYQzd8BfWWB+3O8dshW3fLd633Qj?=
 =?us-ascii?Q?HZQ2nU+jm24GhagfrhgGis7k2Azd4mFa2hwXZ5R/ngfsb5NaaXoSOauMFxDe?=
 =?us-ascii?Q?GsXi2YuW7fCHtUswYpHsFsWOLpMLAXBrivvxFsvJPNNFUyVUz8lCboe0hvJj?=
 =?us-ascii?Q?ntvKrtzBJYcJvosI0n9SIpBLxyzDtaHa2z/0OrcVm98FwewsFSY+HBhA3Uk+?=
 =?us-ascii?Q?rcUkosPddZW/XcsOzhtopEXhDsmJbgG7H9jhqWCFQ4+91NpMWSXkVrikXmVl?=
 =?us-ascii?Q?KQlWQHSU0fK3CdvdoV3o8odHevXecaCOtFYfbZzoiABxYOQuq4jwEYKsX9g2?=
 =?us-ascii?Q?oAc0Yf89UOIFFGWdaU82qB2wrUoC42XSC8YOemHAbZzFrz2S8AVqIhtMuqwW?=
 =?us-ascii?Q?lsab0nbDRnJJn5c1hBCQtE58NMCYI1eOYyqJ2MpofXUzrejPSWt2jW1j+req?=
 =?us-ascii?Q?hkfyjra4Mktbo32BL9+XlTXfFmiha88iRMCAvX+DhFjulClIc52hXFymmWSW?=
 =?us-ascii?Q?YQLD3DahD1j7TOsK1fLoX9kJTsIjQTKbIpyUVfO48Cn0ZNT3Y+dL/5luTVYp?=
 =?us-ascii?Q?L98k7KNLSP+VDRMlgpZz214WYPGLwrveNpxa/nPbyv9qRJaRSBV/vOJwfLI6?=
 =?us-ascii?Q?5HU0vRU7Etu0pkrDW5pxcAj9jH+jVz9uQ36FJOEWmPmsK2qLC4mAp1ACN9Qt?=
 =?us-ascii?Q?nYm3tMYjNj1eKnNQGGaBxhgeOwbkhC9VfUDJfAJ9tBLAAbYPD/xjNOpaRD8l?=
 =?us-ascii?Q?Q6sev2980G+vi7yeDyJ3Qvw5xECSN4YT/9Ik9HSu92Qkh3UCtiA8NeDQ25ZJ?=
 =?us-ascii?Q?6BO1i0Uz8C9h28QqW3VgZLy/J4gwJzqe2oN2d8zYlu1uJtfqZyA0mGSNEl9J?=
 =?us-ascii?Q?uVKi64FmCn4HbYJcyn02uECA1zIdJC9rlVqnA8yYutTv1i+m+9HL1RNrGgH5?=
 =?us-ascii?Q?2NB885JQaNrp49UuklnwIyy7aAnnDwVxdAXzwTCzungGO01vEshkoeFjw+UK?=
 =?us-ascii?Q?hp+VyJhqCwH21YbJ7ymMjIKyEPcb3aB1BVWaayNjVQST7XkNvwHEpcMsvjCd?=
 =?us-ascii?Q?ggW1RG9du8UZa1sLvEUKEKanquOj9BSua+X4voFzcROUiRyiTUCBrT+6oqT9?=
 =?us-ascii?Q?UsV4aA8Eb/9O2Ic6Ns7xUqoMBVaTCmues08ruq1a40EmsKN6SRBGL/M8pVoU?=
 =?us-ascii?Q?gFDHU8coCNZwFXGyjzszGxpAipLFnEJY2jlbQ8HKZhWQMq52elGt4JNM5GvH?=
 =?us-ascii?Q?1BlaczHAm33JYY16gWI4Is8lkqmKX63KZvkiEjcOwIjEE/Xt0/yH7XJn/n/u?=
 =?us-ascii?Q?3Rt+OCQw3WHOG311FzdG7Vs=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d865cb0-22c1-4b83-f986-08d9dca5f491
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 06:19:18.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaYqL2b12tO9vODQKUEirdI9ER8vQeo4zEw9mtR7pQrh+/e0uyS7c2AvXdHqCZuSY0NebhPpjyYnemv5FB0bGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add analogix PD chip anx7411 device binding

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

