Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C21572F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiGMHaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMHaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:30:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2111.outbound.protection.outlook.com [40.107.101.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D58638E;
        Wed, 13 Jul 2022 00:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nESftbGQoT/cOsPM1xiJ2gMZzKOqtROPCjV4Arh1eeMsluRCE2Pu7hKAiGndMfgqzaylaPZ+3+jZRK6BQwBSe64Jsu9JBrCoP+4w/8AFm0blIIBAk5uZVaM1FnKx6wqoLFuUaDIllepLH/6b0d5NPMGEl9A5MSjY1dSzeIaHEhT3M5XOWqwZ1553v7TKCNC2VlgFteMh+xku4TlXU8NVq1bbrfh+uKjRnWO78g5j2N3WInUkzH+OtFyGXK4I/lprlwWSYfmSpSm5tvHnLrwgQEp7sJ8A5sf08ZBrRnM0ro6PJVftQ/xuFpy7EeLf5G6KgtOKEcJ26jsN3pkhv4g7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEDY6psZMLhoFuOdfH0DFNckQDVRkGbWV2OwssAvXQ8=;
 b=mnN0DFhq2BZI2AeXlEESsj9GcklDaN25BLsQeyU5NFexu1zS4fX2gKLJi59jrB1yGn/7zYqxHjPpSPFLF+s7WTYX4Fxd8A0Jv3wqc6zP2MrNQxB2irkXnGsReeDiKG48DEkuoRTw0m1fhYMZWzmtW5QeKtfKkCjZCbVoLVZhx9bOfjvH5SV9tZJoXFWwhQCZ6JJ7WRaNByXErxJwLmGYmEFNWcJX12jz+rqd4OxBDShw88VDxq9HfjxMnyB8erXobYrchd2+WD7x6zRx7RHiKcVtPXgItOh5jRDdvRqmV9++diyy9JEG7csSbgQumu9HCZI/rcuBdhDkeBjWdEvpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEDY6psZMLhoFuOdfH0DFNckQDVRkGbWV2OwssAvXQ8=;
 b=YAg/OVmjkVdyvRRrHHjpLjFchRAMS0MN3isH+CjTQHU6ljioEa9Ps2oriee36ibWBm5Ch+N5alYifCCve5IJpcXDVCoBOxHqsHZQSqUXw3mCj4Yy7s9jfgbpdqPKV/gV228/7EO8tTtX+6BLJ17QvuVVsBjlX4JLTQGOJdkIkTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from CH2PR04MB6741.namprd04.prod.outlook.com (2603:10b6:610:96::19)
 by PH0PR04MB7445.namprd04.prod.outlook.com (2603:10b6:510:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 07:30:07 +0000
Received: from CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::5400:a1a0:be8f:34bc]) by CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::5400:a1a0:be8f:34bc%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:30:07 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v17 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Wed, 13 Jul 2022 15:29:42 +0800
Message-Id: <20220713072943.2789612-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::25) To CH2PR04MB6741.namprd04.prod.outlook.com
 (2603:10b6:610:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00e70acc-d732-437c-a564-08da64a18274
X-MS-TrafficTypeDiagnostic: PH0PR04MB7445:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZnqIhO7yGJd2OLlAjk/+yKQS5EF76spC4kR+kMDYSKaVQBlAvupyVfnhsGSPvjpIx1+V1QPceD6LFiWBg6c65OxXP8YjAe0N5liJb61bpodzA4JqzslDcKSf0KJK83oWbkgMSLRr1STt+7g9Zez/gDcbr+A0+R/91XoiqMmiio1OTJlLysTaAd3dqHcCcGld7sZCdNs2Fnk/7XETLHiNZQJFFBJb5vONk2i8mhXBVb6fumF7RGvYi9VHbbjeR9mS881hXOl6MK11DteUWCTbANDWTmn98i3bMEa7RXO2/VxmqIvAsZa7U+tJATZCECnM7l2hci7cduG0kGZ3xT/8h6oyLJA05z8rbDYuJKra+Kfgafi5O/ylYL4vcpABoUU51VYirVtS5dzvghcfiQ/s8b4h6N52Dog35IljghRahp3UVEOOMW38B95M4xQFDZqpKU7lQJUlpvGGEIbZJdR76TyN8brACfzssprDGH2468uMZ5oJGND0c590IA0WM4p10S4vxlmBYtTbdCjC5ieFVHcH5Y08efcwqQ4n/c3kGMhIwJ+f3d9lQrcqpex0ILEkvMfwdeVrnYu442YqwGV4xNSUadKovY6h0q2N4gHX8+lKe+0dIyBPWdn7+QmhPGFLms2T5mlxf3HFeSJJ3llX9r6ZOseUsqUacwBC9Vouy7r/8dDxKbEyow67yqSvCaAM6a+aLM4W6eQ8Lfe1gnzCOKhZ/VkgwTkgD64YHpnGk7baLavEOLhyB6j3RJDa8nQO5gfDoXWTnOw3K0orOYfvtBDWHXvU1aYImx9277I/XOIg0Nv1yI66vHLBTJmYRXUFmtC0QWnd9ZZ00+RGg0QnfZ0LsickGJbdraYEKHHVcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6741.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(136003)(396003)(39840400004)(36756003)(186003)(26005)(41300700001)(55236004)(2616005)(6486002)(2906002)(6666004)(6512007)(966005)(478600001)(1076003)(52116002)(8936002)(6506007)(86362001)(5660300002)(66556008)(4326008)(8676002)(316002)(66476007)(7049001)(66946007)(110136005)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S1vlkwsC5VgTTDSgKoukLCQA13RdLUMEVTBE7OryED+zpP+ItlU6jDQ3nSZ/?=
 =?us-ascii?Q?82+uqaA7jYqfPRNgai57hGDSd8W2xjBnrbLeVvpd52SpOkxlmfVj8nbtyx3J?=
 =?us-ascii?Q?jnW3fczcsKLCkI14EQk4VBUYMEewv2FOTLrEdlTHUOyZGgjbs3DQZP8TccD5?=
 =?us-ascii?Q?jLNDelO11rix7vVecUJuA58J53Axg6vFLg+opZS1vuyL5VZF1e18Rja67n6C?=
 =?us-ascii?Q?jgEC/OZ3P7y9s/tBocD88sj50NCrVOX02ZG9QJ8WjOTy83iDgfcfT4Blr30P?=
 =?us-ascii?Q?bwjIIYzLNmwuLm7ZVs3XcHikpPD5l8ZY+3p9GqR1YnMTyoV8CHRZYN5Uxf8k?=
 =?us-ascii?Q?suIKjzQR1oJl6r42t0ZxamwU81n8Yr2T33ssmx6I74EnrHK5/8MgKAWSzls8?=
 =?us-ascii?Q?XfCFEi8mIy7vpYN46P4K4VcKzGtznfQDJ7P+pdH1ywBTwL6eamC3Q0+quAiw?=
 =?us-ascii?Q?JjCATi7nI6T2Ls0OEA3aB20bM5e76QzuCWmpXKbkoFR8HpGTU/Rv20guVO8f?=
 =?us-ascii?Q?Su20dctV/mKQq+0iePWV1rcRHqLKMGtmUh+JKQ7XffeijJ6d0GnMQ3mBRfx3?=
 =?us-ascii?Q?LBzkz4wf96UgxcuxcYkH4axDZ2ZzbkqrYlg2G2DcpxL+Qch9acYQblLiCYz0?=
 =?us-ascii?Q?ouZiOPZjVOKuSfjL9q9ibh9aUzpQvBhV8pBYe1n/h/AC4U62SHP1aTZ2D57v?=
 =?us-ascii?Q?TZYjv08ljE9kDrfy8j16EmvB2K9/K+R00LXTF+4rGAMJbhOvUSGcUF5Y8kW8?=
 =?us-ascii?Q?/YkCrBCASN2o6mP0xPMlXcCU5fRlw9AFp39jzqFIe0dTgx+RKa2o55+5GnlJ?=
 =?us-ascii?Q?ZU3K4jDfDC2qFiE2JQIiK7zpSx+oZg93yYB7ck+PiRaq1YfWBPne6b1enqJy?=
 =?us-ascii?Q?2vn20+MqjdQeWVv974CUYXDarb+HvgELv68iNYMw46+77pCG3Fvd1W/0V7SE?=
 =?us-ascii?Q?j9bevgWRwq+kOxvSgfgZLAh8rORPBhcjjH8L8ChUsI+xLqBw8fqLUvV2SMqW?=
 =?us-ascii?Q?+bbNWH6uIB+77aUyP7m/3TnmI3aFSwqWRRXUTArfzdRtk3njRXxRtn78+4qY?=
 =?us-ascii?Q?ygj6giNFdBVQbAa0ACnObeSoRSdU8r6V1db6IhvJkbZR3wC9Zqvo2MDjfXSc?=
 =?us-ascii?Q?5ne7ycN8uTSx/P8nlmQcefFl+9D8o5PJSAenCF6QAif5Njzff96l9NVQvF66?=
 =?us-ascii?Q?fg5XeNof3SVswS1LeNFpvyYLE6w5NlZhhgPMmVGZ1zfooreAVEwmOouPYzrq?=
 =?us-ascii?Q?TnJ/NWCoge6Xpnp7qo7o+99z9DUfIuklpa3qhf87mkWsYNqzqb5mpvzoiU/y?=
 =?us-ascii?Q?H/qL0Ih9hBp+BeinOlHiYAuhFnbdSOSEGfBtSbzbA7Kew/m/flNxAG/PY16a?=
 =?us-ascii?Q?9BTNrX1YYpLqsx1BV1UUINNdjFyQ0TNlJBpncdz6s2FOphrJ6GeatexZk1n7?=
 =?us-ascii?Q?NVLyTros5b5EE52SNc174fugD4QnjjUEeQgP4zu5CaRRwQCotjT9lOBZ/anS?=
 =?us-ascii?Q?YcPQX+bR/jI92VJH6dr1LoO7K2E/ZeKHmHMhiqPH6t5rg4he+UtU4scH2rvk?=
 =?us-ascii?Q?67QyUbPKZqgrOrZSDS0JJdjCqLb5zZfMrrFhgOoD?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e70acc-d732-437c-a564-08da64a18274
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6741.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:30:07.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gUtB/neOib4xz9/IlkESV8KSFFjRFBxPq7wzVPDgj1BaqCJaaNA4FPKOpmxepK80bswIfsy3B4uaQGyRK2s/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7445
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
index 000000000000..60aac5765320
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
+        usb_typec: anx7411@2c {
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

