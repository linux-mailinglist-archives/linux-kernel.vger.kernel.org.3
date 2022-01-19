Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBD5493922
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353723AbiASLCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:02:35 -0500
Received: from mail-dm6nam12on2105.outbound.protection.outlook.com ([40.107.243.105]:42999
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350375AbiASLCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:02:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhA2dId8JWJwBiF6VYb2mY+9H1DWYYgufMCMRzxPTDb7lu29dbK/22oqFKjDqXrhRbXhrQmz26C8P5fxX+jdBaFtlyINw5zXM0VEbn/NkzVQxaRNHcYKAUtJ/BHzT0StbUy8DJ2HeV7L0jYXbUtIvP+p/VYwVXAtwm2o0qAHHYBX9Vu//6o/HECyofu0B4pVHzf4JjmRfMP/j8/Gl1s0iOhyukCjW6k0dXCLtKEvaErwmIsTf9k/AgdNaxIf/+xH+NPMUXh5F0txOT0W8vbBjDzklviE3BlcJNkdqVirbwyUaR6wr0E90vj1JNe88hLbwwpfEL3FaiDuetegk+kLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MW4bqoImvx+fxKvPf3M10JcKtmBGlmTCpQUF2ucyg=;
 b=btoNHfj0eItcvw3Vd3NHtb1hLAzZhwoJxoubo0mE1Tv17rfL5AXwkip3JFhpG8mnA0OV42u0//r1Pd/rkl2A3ljhgfo0bIQVAQnRZlY1CwaGqonhZU8jzgCcgZsEbBEFvNIwILZMIUV+vTcR8hVolRDQWmRzKRE7zL5HC/Ei3VsGfuv2DG2X+tPkSI9RTEdDmzBGFth3aIgZfvOPg0xFHbqy+/TxXfUbk+kQxghaPBRwvtti0zTp0HL4pB8H6GV7ltfMaDhJwaW5DKfhwUUz62lDJg967IVompJ1p6Ut0DwJxzHTiNbfIu511deULkM06P+uZ8Jje1zq0vWTsAqs3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MW4bqoImvx+fxKvPf3M10JcKtmBGlmTCpQUF2ucyg=;
 b=2febGv1ps/H4320ZDw7tqyAJFaAtzXLGnbnxRKnrGA17fdUWjIlVuRcR+T+1rqdS2qOjyFBMVyo8989xVIV8I1bQobY5OUlh/fpb5PtKgx/UbQYCCWqsvoHShr3ZFQzrNrjYuhQMJqPHKuNKNIAcDqlMu35um7+Im5XHlMgA41w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by CH0PR04MB8194.namprd04.prod.outlook.com (2603:10b6:610:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 11:02:30 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%7]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 11:02:30 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Wed, 19 Jan 2022 19:01:40 +0800
Message-Id: <20220119110141.1020452-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a225235-a568-4f97-9dce-08d9db3b2faf
X-MS-TrafficTypeDiagnostic: CH0PR04MB8194:EE_
X-Microsoft-Antispam-PRVS: <CH0PR04MB81946EF4D9E450051FCA1D84C7599@CH0PR04MB8194.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbKMq4OWqlVq8R1DRb+MiXntThHC4nIfYesRoWqEctfg1fv5U7quRwxIKX2oxzKvPOrNe4l0IP9Ttz+KrXdIX3NilvkxLQnwXV6FZZAdCowz3EWvZd0l3ovAGx1T0p/0Onkuwf8S/x3fiIpDssz8U8MkQMaNxjkIwnsXBFWsc5ST93Lrmzqc2vaVT/x/TOXSyKBlKIi3i+kCspWza/JzQns2NdHKRcBz6fEUJyw28aS447iAq+8rEBqFwnivxuyh7wZ7o2yM+01RnP4lDm07yIVJgLa9i20+8UlYeZ1PzI3Fm8RaVgmFQIY/hrsA3+KUD635i3530FcRz6fc5TZ5NZhQEZtJcCtlY31njAn3r54ydYiJDUtX022QY0W8NA4+0bm4eFZ9su85cNmbKMSnmnvKfYMYjr2lgpOQ5Ar7jj7FPvhUCu2XQuQuslzqOM5Wx/xXHzEnl2DeXWz5KduHVB2tIXBPDH36p9XZVqzko45TL9KhE4zl8TIikTdDXhuvTSeJwzsmeoy/wtt6G2h1J17qxBcUD3E1mXOEOXbxpxH0IQqWBWDB5wlj0ps0uo93cHnXyrj0wJgqdqG1Hl/gHZqjlUI85bqkjRtTeT+ypabOJYihZlwKrrtiP6kPRSTNOt3r0JGetHx6Za02Q9xkcYORJidefRuUoi5S2xrUvzCxzXu4BZinS8Mw32/yYSn3DKrRBZU8ZuRG7Jjmsrw3kcunPGVTi9OvRMKa0eSYp+ye4LKpuJvycmAZSOOy8o4RGragyW8Y4EeHo6X3CLdYnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(508600001)(52116002)(2616005)(2906002)(66946007)(66476007)(66556008)(55236004)(6506007)(6486002)(7049001)(6512007)(6666004)(8936002)(38100700002)(38350700002)(316002)(186003)(5660300002)(1076003)(4326008)(110136005)(8676002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B2YnH2vvLw5KUwtXE+qdG+JGNLszJjkrQ0dYCPKmaEzSrOAGupbhe0T/8+fu?=
 =?us-ascii?Q?vKZZah4Ae9d/4qRmG9ekXiARnq9DaX0ZXe9cOkB5fcLWZ00ezLsQFu+7pKKX?=
 =?us-ascii?Q?LuSa7Ml50ON9YzehMKwFcWQYg+ol3aNBiU+RqrZ0xHATG1tF1A/DKu2wOBUR?=
 =?us-ascii?Q?4SYMJzrkMd1lZ+Dyn7LAObEuL4DvQSqMzKWgFleOi67nIyj2UPp5sCboOVsX?=
 =?us-ascii?Q?lkNOO/3S++QhyN6t3TfWh34kqPnyGpCQ9vpqVFMuCNRnZgxL4WgB+MqxKRAJ?=
 =?us-ascii?Q?FMiZ7sraueWB/tWJPIwvyhvjtFxp5L5RHzTlYetzLNeiIBs2RuamWlxQusKI?=
 =?us-ascii?Q?G1yjWyfHVkKuF4qwg7kJ7R5l/4IG6pbWThAG/uJdBoqWldAI4nTFokTIl7DD?=
 =?us-ascii?Q?7OwS3+eJusH4sY/n81b0Rzc2hB6SKZJgcflAdkW3Z4GOwe0M7t69qtDD6OXT?=
 =?us-ascii?Q?J0qvWBcvMhUR0TEYvs+4GayYe8lWAQObaI5vaiV4OcutQqSA4rgoIz26IysF?=
 =?us-ascii?Q?c7DmUbusn2HO9w0fohC12SudWXyvX8cRj2LjqaV/V1e5poQ03jbXMxzWqzhM?=
 =?us-ascii?Q?xbVqxf1zHjXupzQWpDi7wrvmACpJAkvL2qgpg+xSOGe36y/ZBE8Svt5mNgrB?=
 =?us-ascii?Q?WOJ9z+NPe/Ly2oI8yabN9v0NIkIILftURLUx4L1nZ/i1t2fyqnhsAc6VDhvb?=
 =?us-ascii?Q?u7fGAJARAuxt8juH1tzXFitI1t4jgBjevdTU0xpjvJ7WgWRFzFTqguMq+hDW?=
 =?us-ascii?Q?OWV5wQQf1pnkgrhZSdxmeHaQp0YuUsYZyLRYBSjwow2tgs+bUX82EaCDLjsX?=
 =?us-ascii?Q?Tu+NJfkJKaOxiXWRIwM3d7L/AWSSAm8k6233CtA6TAzEgA047XW+F7PQe1ic?=
 =?us-ascii?Q?c/5FIixG8ZwpluFA7h9A+Ogha88+whhmkGEviYnNms8q9wdCL/cAtXwaWPBb?=
 =?us-ascii?Q?vsrpUuB9dLh0UKMzNVfc6WMhDFrb4LGgL0bQhXYEYllBY0wKxLJqQR97XU+d?=
 =?us-ascii?Q?UiKnAsgqLJb3sYjI0WA8GCAY3LsYvDquwvVeWymXR9DuP2IdWoSIJ8OZJD2k?=
 =?us-ascii?Q?pAgQJ0kEAAsfNdtBgKfEDbEL9ChUchymVoQ9otnR+hmHPxSKrWNpn3yOOyGW?=
 =?us-ascii?Q?LdY8h4IqoVF4aT0X6EH0ILbY83jR1vMQ520TPSO78mRJYLykH7fuVVtVdOml?=
 =?us-ascii?Q?X5vVK7wGIxEwhPVSBcMRZECtc3RJOMXrHjin8YclQgimPWySEUR+WMkv75Zt?=
 =?us-ascii?Q?BL44Lpkd1B8k+RO/ZcvNIQDr/1jJe1SfYT36IYuJ0nTDWz2EB2GV2tVXToLD?=
 =?us-ascii?Q?LSgrJUmbJUgXUww+tvZpKNG+me2FniurWqgZHut4IiThJ3MV7HVnX6mnLqxJ?=
 =?us-ascii?Q?k41CvTWiEXihMIZXk+K1YCRF3mw8umZRfSwdiDGrp6XszX2oR3HWQdzqGjfk?=
 =?us-ascii?Q?3ZfAwQIbSxhVkUFJmIACLqCtOBCc82qUgJX0CDjSYOjAGlrWUCdui8+anBwj?=
 =?us-ascii?Q?bGL+SgB4Na6Jqusexou0CcekH+OTNCVYCQqlzpSTGiCevtFCEH+CKlTNgiRr?=
 =?us-ascii?Q?S/tWIdCW+UPnL7rYnWVTqX1nZpzvDXbvytfhyAMR50hA5glPFlU6aXyGtBa1?=
 =?us-ascii?Q?o1YW+oNSKbmXqivVHBn/oDw=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a225235-a568-4f97-9dce-08d9db3b2faf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 11:02:30.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT4/+4HvM6XzQ6c2SaEt4mdZUgwLsD3QSjpYetDwaKbkxMsNtVaq2Pd0cx/HS+MBzLgk2hrBCl60gX8yI6QV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8194
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

