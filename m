Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF557154E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiGLJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiGLJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:05:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2131.outbound.protection.outlook.com [40.107.92.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA333E0C;
        Tue, 12 Jul 2022 02:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiUR1A0SK46TeS9hQ4skFwyvUw9ztMsjS3VqnjiL8Rqlk+Fk617aPDB33VoM09NPxR5BE/JWGKNDRHOhVwVNLhL4ZOvYabdePuFG7OAOBrDfkqcA4/PN68316RdwMws1YEIqMf6Q7nHibj2tyk+vgOEUX0wXW7iA+yinMz4D16B9QqDi7+Pu3iB0p6+lXLZkiuLtuJGbuv012zuwHAsFADEhFqRhgVTzXGArxteX3afmqaNkzIfnlnYTlKzFzRy0GF35pZmW34ZXMQjTlVomQty00+k1rWqI5J/8wqipfV/kFkf/Q1uhHYKZcaYajdVWrf0SSVLPBtoOQeAjJ9dWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNt7iIU9Y/Ty25n/uAU1tIwBPqXeI5YIvYg+W7IPePY=;
 b=lW5LYuG4nou7j4AqeP9uJJQxRGi/rMckAkCQzqoUB6U21oBumoKv3WuENSvl3dL80ubDdsGPc7C8LP/TxSxu1t9/Gt1pIDdLBy8y2NQsA5wFRFxfAOPcZVzwpcu+JDux0CSPtymmIG4eQnRg22JMbKOJdAZzmth+fYqJKrs7PD2IglwYyL9HkxAHN54FlIs09LQYI62HWQP+wVskGrpMK7D+IZyTVG4HfykCRc6XQrIgbuO/hKuVoXfHzi5rTSejEkcr93ESpu07moiQ96Isei3BW6FMy75UiOe9676eeGn2TS5v5w5rq9MNTVHZGA6h2A/B8ASCooDLRodEBplNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNt7iIU9Y/Ty25n/uAU1tIwBPqXeI5YIvYg+W7IPePY=;
 b=nVhmS6zzi6iCPzyGCeyCdX5lYQijLh6jz298du5ncdM2yK/k/0fHEPi/9YER1uvRqOn6JAgzT+AcCGZDc3Iy3qHszr14bE5+mcQx0ty1QkQdmzOOys596okcnugx4zsqEP4D50kCERrFDy+kEEzEFbJ1FYfovG/JHDoxWHVBXyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN6PR04MB0658.namprd04.prod.outlook.com (2603:10b6:404:d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 09:05:55 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 09:05:54 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v16 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue, 12 Jul 2022 17:05:32 +0800
Message-Id: <20220712090534.2783494-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712090534.2783494-1-xji@analogixsemi.com>
References: <20220712090534.2783494-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:404:15::20) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63717930-0a5e-4094-0d9d-08da63e5ba0f
X-MS-TrafficTypeDiagnostic: BN6PR04MB0658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xcLqerm8dL7RuX/ss+zKttmh1Fr3goMwjbdpJrxgrW8bY8k0l4S1SdQoSMDKhbcDeDL1xgQX5PxeG4tSKGhNofXmDT/ty/q/4XMZABcjyHKuvVz+AeTDcbzHhBkJVZvYFvN50KKUVNAjfyj5SxKaIvUTbzgvSZluFaIbx7YPmcmnHQD3yY1p0DaIll21htbRZTYak9+79/GYltukw6sPbhREMLwF1qpgL8C5b0zoMw6pngfNeR68Vsrach0zTBYhDfRINOPPvlH1cC0995c4Gq5kc42/uCPWtrlFB0IwUqd+SNazyW3fG1QQav/hOxq/IhkGM2jqEA8igzSL192SVBQHBfw6XvVH4W06VcKIHcUAUigKX9eCXU/PboEn/4abiynjWOUnnVark27QJx2Yla3fgrD3C/6x8Sx0LUOipEdyprHf9EESx5+ru/zouYS5SU1hdTIJUcA69DmkuLUgZH9iUDczJftKvtC8RCKdAOmMCjcEEvgqfcJohMy28RD6XE69zSNPngfX0XLDF9xAaWIxYSPf8VZfzKkI97nKpYOD//DuJzsgqcex5QkhWno+qeARM3Y2w/MhpOvSakFykkhZmPJqmkfVHeHep2mE9pwb729rtMf63wwnlyhQzjvrijPMm6xveR9eU/Ol8F32h0nqJy1FYXg8ezT6VlhKi4tIUY2C510IGhi0gTlFGBKec7EGpO1KU4wXJN89L/3V9emzD/e3JCmSObHubBRk+su+YNJbJv0nU8iV3QVQDRVM8Fgh8ruhU6Fhu/AFdN3dbhRxqn7aETmjRM0U9uDlGGT2wcKMeLfL+mA8bmpMdbhmFWtFS06y1JhOC7leZtuZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39840400004)(376002)(396003)(136003)(366004)(4326008)(66476007)(66556008)(38350700002)(8676002)(6506007)(66946007)(186003)(7049001)(8936002)(52116002)(6666004)(26005)(41300700001)(6512007)(55236004)(6486002)(38100700002)(316002)(2616005)(1076003)(478600001)(966005)(110136005)(2906002)(86362001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3fFBMhArkFGu9MKesDE2U9YsXoqPaQ9H4irpfUe0f3vY/1i+CAtD1Nu2277?=
 =?us-ascii?Q?7jxxuOiAyZkh+SNte0PXoLzQ46nIPPB7OSBhPKlHnLXt8G/DYCAzU7P5t7BF?=
 =?us-ascii?Q?NjU//qrMQmjg3hj0YKMySBcNWC5/y6ClS0R7xkasX4a9f2MrdGM/LrScwB4N?=
 =?us-ascii?Q?5vHhYSwls/0oCVDLW314eyD8B2LmbmpCE/4D3KzsCu8T33rNb+sY+0lLKHKz?=
 =?us-ascii?Q?ZwRPPKFcOJMAe7Kv96VNFrn0p9gGCmC9e8maeEy1U314udJ5VYHMrbA3FUMF?=
 =?us-ascii?Q?RQrKyK2sg3nO+MRzgrUYlmPqhZ2uazcvIK9KqddDKwYnRbb42iTCdO+qGAJC?=
 =?us-ascii?Q?yjiCHLGaXINPg25RVwGRp3aACXFO3YxLzlRSL9SwtjeqvRTjQN6Mugp5BGsk?=
 =?us-ascii?Q?ZDNwyqHlkKC/6BSA41eeK2ESVVs+awTsiM5IxJ3yb8xCiayuI6OB8bHaDrxB?=
 =?us-ascii?Q?Ka6H2EYwj/zksmg5/OI05l7N6urSsGooIvG7AcwpDW9ogZo1dYEoAXdzLXoI?=
 =?us-ascii?Q?64nV+sMEnGiAAHKJ+ax4NyuSunhsCouzV/MJAxflX7kVpZNksIWgDmAkr5uc?=
 =?us-ascii?Q?IKT+bEJhFfOKvHzfzQmqTw+uYR3eDNy5u2+HbKg4aRz/gBRQ4rLroaN/UNcb?=
 =?us-ascii?Q?v0H1XnSAlbseKUx5qCBVUWy+vcCducZ2lxGxdu4zhkXHV9E1HTS9URuPQla1?=
 =?us-ascii?Q?mqWX6sW0PzMHqgWdCpIAMrSgA8MRozKXEdBxZQ9v1adiGp8EWZe04cXazKy/?=
 =?us-ascii?Q?4pN9GpEr5JLxn3xFAR6ngKEnb6DVK4OUIQCcJm4ep3kJrrMZWN6tcY0TOp2S?=
 =?us-ascii?Q?GQtzvvinqon3bFxvDeiFdqWrTMR0D2lb9qFmvtIxOnaqkKeMdflPAUxLb6V4?=
 =?us-ascii?Q?rXmvMrNaQJpQaH4ICWgLdTgeXyc5/jqiiimj6vtxG6fds+E5yIYte0kBRboB?=
 =?us-ascii?Q?sjqWE83AbEWt9YsENsKGdcG/vC44f5ejM1s74n0+rt60XT2MsZy9FaB+3ADD?=
 =?us-ascii?Q?0q4tt85w8XFb+sJ3DcPqps4WIfV9X8S7Nf4GxDcdUZ8aYusFsQPvHEHk+fdA?=
 =?us-ascii?Q?LKTamvoC9Ih0BLE61CpKULcJ4ZW2dXTWdLrWirGjBxNVRjU6ZalDs9a0zGlk?=
 =?us-ascii?Q?bRptUtXKosjvbguKduh34592va7ecej1PFicSfkssHE+f7hvphBI6A6zB38t?=
 =?us-ascii?Q?3LJjK3XVWiuDW+v4BGzHBggBtF8XilK+ovFguY4bUg2CWQUpqwhCDdV7lTxR?=
 =?us-ascii?Q?Rvlv+t4u/Owwavsb1LbgracfxAnYrqB01yd+V2kd1KXGTf6NyfJAJONtIiBQ?=
 =?us-ascii?Q?ZfyWlCu80umSkULuR+lC9w4rzFj2/1uRpMWqkav+FbZtgvJXu+WaGaLBhdEg?=
 =?us-ascii?Q?x0gD2yvkzYB/PhaIQDA3X1KuxRyN03CiF+DzaS6cGWfN5FYTBQKczLMMpZ0z?=
 =?us-ascii?Q?uoS4+HkL1k/danco5BojdTsH4bbHuq7IoDrDmYfM/alI69RmPK+0eNf8qK1u?=
 =?us-ascii?Q?gSKnMg9nj12xIp6Icm/ywSPk+AeZGyqD/WyDj8QcYkQW4bQzAYPi8d5GHhWm?=
 =?us-ascii?Q?VAR+E/psn6JaihE/DatebifB+AZGtm1WKp5AFcLK?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63717930-0a5e-4094-0d9d-08da63e5ba0f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 09:05:54.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpk8hF4q24lMVNaQ9E67EEhChixSU5u16CRJ0uhQh1GpGqI+8V33MrPK49LsmQ+Zce2MI2+NXg++M1v2QLOKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0658
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

