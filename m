Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2EA548437
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiFMKAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiFMKAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:00:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2139.outbound.protection.outlook.com [40.107.243.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6731CFE5;
        Mon, 13 Jun 2022 03:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+OJW7x9KRHwKqzy+Ezx45uioZR32R3vJAu6mCd6HfnJU6ejh6h8MR1ijdy0+armfWtobQ+xuHRsLTTP7HhWa5/9QAHurU/ZJfznvTIaPyBcJ/FNSmajyHcz90KtzwrNri0DKf/ye9mEJPu/1gJoUxk9Gf+8GJzGkjEKE/OmuHeAfBlido1svtHIKZc4xgUVyd1Bs0a4ZfWB7lDSFeB/u2WCrxCx9rPXb/M1O7/rLelEbcXXwIJ+KY9TEt5DzeHIaZb3LYA+c3TcclCt01PKcRUA6RTI7Rk/yNuC2jH8ZevlwchjXUqwG76q8WvKWZtHfg6n3/AyUOMkl6yodpcA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=kecXG1PfIqUMCGjV8YYHjzGjiSF0PcSOEzYCqQ0RkfC3Fj+eqLwN3WoC1kuGVSDnuWJFLRmc+8jZ5HCRQFP/e5PYtsBLvZ0YWG3kbJ1gPPYglJig9sAV52DGYpds7GLq8LNppdkryVaHcRyVtxn8082DUzXJNF3dTJ64mq5+OqHh5wHz98L1D9MmfxPG2/BR+vkMNWUCRvDC+tr34DLLw5KJW0tqbdCP0ZZk2WeD8RH351MLmD/Sq3FJYxtiakmAG/Yv+J9DAMLTQ62vIROiESIGprt0wmwfMFwMx2EBVImOLfhHhNLKCkMzFQ1il64/jhtAdIXor+gW3MRgqCU14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=XmTU0QWXM2w8n+HZ8+pVRiM5EZWkhL8HE7AXfoj9GYK3mcirwlccDgHECFRrOnPjY5MPLcNFRTVfSyYsYNrIc2dHCwvYuPz0x5Ja38yaa731tZg5CRYYUGoSgS6G2RfQVECNFYYvitRAUDB2Z5jQ5XHwRLYmzZAebhmzk96pZG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SJ0PR04MB7229.namprd04.prod.outlook.com (2603:10b6:a03:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 10:00:35 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 10:00:35 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Mon, 13 Jun 2022 17:59:55 +0800
Message-Id: <20220613095957.1669829-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613095957.1669829-1-xji@analogixsemi.com>
References: <20220613095957.1669829-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:404:14::24) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e1cda84-1cc3-4fa0-2e57-08da4d238f54
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7229:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR04MB7229C940DF776A060EC9B12FC7AB9@SJ0PR04MB7229.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+Q6NlNBJcp1PAjmVnHR1Jm5KKCkAWw5s8YFU+B7Hb5d74+NtV31bA1QDSyKvMCIVITkoZDhn5zLSQRxMPARUjGHbt60kWo4VuANCDbl3wL7B2uHRTupM6czhEfg8oE8awQWJjO9pGNwt0J2Hv1eaL7CZ1mPmC5J7fjqEYKcYYpbKG5FTjldXMxvxwR9aETKdsHkAbC2kEEL/QvJTPfFaC88qve9DZyGqTK2s3bCFWz4NQiRZgymIRlQUkILG4YJ7KyJ93ucoBFjBUadsX6I3eCmgb0/8A0hGVgshuLOdpXfqUOGXDz7nTEyWQ9H67bB9bDDn74OuYCMS8wh6dxkJg99oFFIF3uH/RJHamShh61oww++Ei8mBxemfE5qsUdVMmgp23bNAt4FqK3EvhDKsRU7KBzTw/UrEFU3MJKuoIebAwALaRGZk0fxCOeMBI2jOEopMHy6js9xl0A9Vhgpq5DCFVq/nACQCY+++4m9Nxkzn7UTHpMs0Po3MKNHysaI/hPFYNaPSNASKXzQv56tadtwvrZh6tg+RB7EMdZZLRkcnD951tIw/7km/GnUVucuTQS5Vp6P/bbucp8GHUfUMhtJusiHom9UVPBakubF/fi975PZMspCyg1tVKtFRKEKr8ZgKak5SToQwbaepgKFgTk+/ZZF/z37VEECcjV9o3BzRYsMDnOhENUYmWWJhSAI3QVgGO1VJ7DRm+7n8usZJMxO7cwLqVgh4deNEXHnngvLfyIXZG8iWw8In4BSiD9lJgRoZYuMhFlyAumDEWIBef+3Vfk+KUHWvOKBW8GnOSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(110136005)(316002)(36756003)(186003)(2616005)(1076003)(8936002)(508600001)(5660300002)(6486002)(4326008)(66946007)(8676002)(66476007)(6666004)(66556008)(2906002)(55236004)(38350700002)(52116002)(7049001)(38100700002)(26005)(6506007)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uDdFnsYTlmP0TlrOyht8oQnddhhffRKizp/ZOEV3QMRJRUHjdBJccz3+Ut9q?=
 =?us-ascii?Q?1liWV1qXjmzbxeELBNbVC2sLMSSilbRnWXveiu1c+0c9Dymzx/NbGZIKUr7z?=
 =?us-ascii?Q?+mcGdjnI9c4rcYAlo/i3/nu1Pf48fMeQk0lGkLw9Ng+3aLGifj2SUgzKbAms?=
 =?us-ascii?Q?FIkXdYfoXiZ0L9zQ1IRu4/sAea19PI+GX6Nqxm/xFdkMHvZtxsVIkrXhVwxi?=
 =?us-ascii?Q?7mh4D7ulMHjH+94LuMrFJMGiHA/wjQcfsxV8XQsXgLxTiw82GSf/8bSfynzA?=
 =?us-ascii?Q?q+9lMqXSQijmb0PIxWZ811omwZQv0wD9a7gMkTnTQWq371tJRrByZdlPrQKd?=
 =?us-ascii?Q?dusxXl3Yclhf3zICH7EspDw7ADTRwGb0QZJEW0A3LukyBoHw5WhUFSbYhb2l?=
 =?us-ascii?Q?M1YY8KTS2PmzDf0LvlIfrc0ge9RDBKQPkoByTzQ73BPG0YCnetLyVXJTDPbp?=
 =?us-ascii?Q?ZN1g93mWxAaXRjLylANWGLMobrUARdFQ8euDuZYEr4z9swHKzrgLgTdSjjIc?=
 =?us-ascii?Q?Azlm65n2vYf28YhOIPlzNWZ9jDF/2/efRBsC/tV4F49Fy7et/MaEecEkyQUb?=
 =?us-ascii?Q?D4gtr4/LM54ERfFa/3QyNZm9XMTb6i4cJ0jo4+yELRn3AhgIDhEr6600Q9S6?=
 =?us-ascii?Q?TTVoX0EBUyNTsvOpkwPayZs/nu2lwIt2upFPpJJqO64iJOwV8Gu4aNQ6X7gb?=
 =?us-ascii?Q?XExzyrhfjtY5Qfu7CBAdfE52q3v4TxHypg7ywIzyP6Eh824GOP7s0Gs0uhtD?=
 =?us-ascii?Q?tHVSR3wJvVsyCKVmoauNk+ePbf8HBe+X5U3dbeZvvVg4RYI95WOBTvUuV5tl?=
 =?us-ascii?Q?rVT9iDZTlIT+vofxuK94o0Is44OY02uUO+A0hY/1le9DSnSd+PdVcw0HlZw3?=
 =?us-ascii?Q?S9J9ZpITx+bOSHdRLg9P2SCi5RwQ4IKKl1QKSqAEVkJkUuk/0iJu7YTgT4WO?=
 =?us-ascii?Q?J4PRcMAnTk7ulWFXsEZWfHJFQz8VrfbSf3uuS9SZYCEsp0NSmOIFkLV5JIzA?=
 =?us-ascii?Q?uObL5XWuPTPuH/EcTljNMpkdzPoaniHHhpDy4pBS1uwGk5wMu7tg9UGJ9u9M?=
 =?us-ascii?Q?B71XHevjHgNYDcuhOquitpOcIZxOPmgG1HUYzt392Wu8Igc4Kz/7KYMf8c+I?=
 =?us-ascii?Q?OwMYSkxKvRDs+NaNVZGA2ARvgkZTTmRg1rq7UsPv+/xy/s584wn7hqOS7+m8?=
 =?us-ascii?Q?l2FLIV17Ns9FiX5Ik+BGSQsnN9jPcJsom8f+pS5uW2JlxI3M6Mi01pnmW0P+?=
 =?us-ascii?Q?/fL8SluxitMf4Qaeu3YwAt2cy30sxD5ocbo0E2iiY1ElifBrE42FbHL2aSqT?=
 =?us-ascii?Q?M8fWzdcAaBSo8J1LofeucUm8rQH97KGXqJsLEX1bd56rALRi8fPl9OTYjIt2?=
 =?us-ascii?Q?M6LQeDnm8Z8GzT5vZ9mOnxCNSwYOfT0NyX5sqvGJB4XtlRlocjTe4CRlyixc?=
 =?us-ascii?Q?btscafb8OKZ14aKFCm5nV7Z1swNF7RWB9JexCGTLrcR5pXKuE5O2goDuNWpw?=
 =?us-ascii?Q?vL5vp7ZeNNEIchL4PPwRKqY7VmWdpB/hE2C9gX9+27wm7O1UYod+RVNzE8FD?=
 =?us-ascii?Q?cFaFtcWpC9DmOamdFrsHKx8D9BVfUfwBiJFBfujdIh73+/1o42P1/GRSs29k?=
 =?us-ascii?Q?ft/rFdtV+pHhBEjlmu9m6+yt2G9OlKhzWE2/gdGe1gxzNtOwWpkfOMv4op68?=
 =?us-ascii?Q?u2L/vV26ypaV3u1xWXNhm74yWMFRVpZGIHG2Goa7Yas/9yGWsME/CnVwyB+s?=
 =?us-ascii?Q?kianoZ2HiQ=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1cda84-1cc3-4fa0-2e57-08da4d238f54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 10:00:35.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNl1apKc6lyvN4udMgv5Qx3ulsw6uXqcc1ryCNtK/g00N3GFIaUEwcMDuMrW9D1oZFfGuP5RFK0wigj891LcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7229
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

