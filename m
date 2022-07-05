Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060C5662DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiGEFhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGEFhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:37:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2139.outbound.protection.outlook.com [40.107.243.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD28613CFD;
        Mon,  4 Jul 2022 22:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSMjV2z0S6Ogy6di27FBxj0d+y/f5BG6RXWIGNcDMYGwtkz0S4oySvOiqo4UC6eL60ek4YoHg8VAJYmMJZfHirmVkUd24QVlveyEvpgiq3mW3VnjLa6PdytJpqUMOGuOfpwVoI2xMwlRPSiymqto2kVD+j+qa5sm1jSKN1MJ0MSxwTkf+7avhtESct5fyBABgS+UJ9sFtpfXlFL29pw643hWfHHEgZMeiSjIQIOqzfUyou5sYvxlGzY3FllPXghhLZ0pEKrqFyZHcLf17ICUtw4gNblkv7+XByvPcm+biYkrBSDRxscoirIP+M5plu2+PqpGJzL8LRatOsrW+6jS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc3dkjkvC1nLp8F+VO+CWwprzynJuEy8TL6vgInL4V4=;
 b=hNV6trMepPKDItP5OPbMwdEvBBL0zanCGtnzlH/7vn+5sifeOxSBTE9zCm9OvbH3NTM7GSLjAEX3zmfvw3tg+ft/A31IikHnrUpCUEU5YI8cqWr02+HhpKhhssZLCZ2gq3YWF/arb+kPS3w0RPl0BuOsAIss3CPXRTqHX2xow7mjMAVCCUzNSwcz4CJnzbvKjQ9VncAi3iZVGgA9VzT+ROXX2O3dn0eKmS7qqL0C0ihalc/AQ8PvDaQcTlUXN5lkM9cLQRXzRfZsirpm0oTqNJWSeYSXZi+5Wj/MYZuvAd85Uy832tE3T0SSqOkuwFyitu69IGypGhexdYSQoz8AHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc3dkjkvC1nLp8F+VO+CWwprzynJuEy8TL6vgInL4V4=;
 b=XHmjBr+enpEl+Wa0r7LgRamqQcRfhNFlqw3F0OnEVSVZJ2fOi9WkGZgA6LlWBvmFRboY9hDSaIX7e5Gp3cQVRova4/j6mkfCbWJeQInIHviq49QqAyhra7qDIdSnlMos1Acx/5AmFL6Qe9DvREMma77pxVPIYQ8AoCi9xwEfrxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM5PR04MB0651.namprd04.prod.outlook.com (2603:10b6:3:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Tue, 5 Jul
 2022 05:37:29 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 05:37:29 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v13 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue,  5 Jul 2022 13:36:55 +0800
Message-Id: <20220705053657.2340274-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705053657.2340274-1-xji@analogixsemi.com>
References: <20220705053657.2340274-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0182.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::6) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd3aef6-ecf1-4026-c451-08da5e487353
X-MS-TrafficTypeDiagnostic: DM5PR04MB0651:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jjyBBRH6VSohvgYY3URpaoL4fJdVRE951pIpIuEOZ3lAPMPYrwcJFEmmpXtliTUwVkMSRWxrLY7XnK6DOQuAouo9u8mM6OJI93plbLRi3AUgfeXlsoxfkoovDzB/y9a+D2fSUXSScMQfFDKstnAbbT4dbJ2q+tCAUPnfDf9IpePsnkhKF+4cDYiTQz0rT/mYoyJY53lfWNLhF3tklHPafBbDatZl8uMTJe1g8V5ge61ZPCAM6p1btwP0mix+8uovyx1Y31nZx3ArAzwsaDKq3uK5rAlLjuksyKAIwgeC5/+nv8jRrS2QamQkrea0VhUO1b7KM1zBvqFu1qm/2sUG2AUQ9uypYaTkh6Le2HjuqKBP9akeWxspLN+HwAA+mVQrLY7zPtFvqdxV61kVbXks0/MQlVJY+3kPa39xEBlqQzsBGEAwMKnYUWQgl2eZ+S2uwT77N7cTG4FKO4wuZbo3tO+Fg7/ZJkm3DbqumouXl6z1KRUBolBbwG/RKGn4Op1rE/nCl1XlDwIN40wP74+1yjwlc9L7um/U2woUfoweHEEF/oCFOK+4sGY/wUA3Keir00NjMtHKGIjwdiZTgfsyc3JkOrOKQ4NFjPmublhBtvyNCwhGDx3hVuV3/+epubyJ+G/wMFXCsxeJnSv0XGAVxwauAxIfYcDgxhIWcgJkGNLTeoqhNB3pcsIqeO/qV2bQr7GbAIPK+FvmbNvHS4JwHm7n/Mj1x1yEORw12AGyMhylkwNRvWQCA5IH/2FW2aXE3Xgl8ITnbTmnq7F1RY1DaSwCYzFjZT1HMgwy7ro+y5YvzA1zVo1lSF2bidFhWRWcMIt6ANdiAXSTMOnm/N8Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(366004)(346002)(39840400004)(6666004)(41300700001)(2616005)(1076003)(6512007)(38100700002)(38350700002)(110136005)(36756003)(316002)(52116002)(55236004)(6506007)(2906002)(8936002)(66946007)(66556008)(66476007)(8676002)(86362001)(478600001)(4326008)(186003)(26005)(6486002)(966005)(5660300002)(7049001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uWqEi34QL19C3rW9erwsg1O2/uYyfhwR8jZSyiNm015lZ52zbHeGQ9SgZWqt?=
 =?us-ascii?Q?SmI6rLAUKWhjaPbX4337emtOCirYnx0xNRFhMY3P68Dk+s5sUBoNbjyJU4Jb?=
 =?us-ascii?Q?/nj3wg+ydyNTtUVHE66IQGFOwWwpkn00REnZgwXRb3BfcbTPuukc6i7JahmO?=
 =?us-ascii?Q?cPmG4epKBrHSWgyacpUYQbJBsz6sbrBV3IVudKgjT5uSza9DBW9Y0OaVJIl9?=
 =?us-ascii?Q?y61vv4iAm3jgyjQziNM16cBv9TIs77atNecPdBRQVbRMl2MQKKDXHIZ2+J/T?=
 =?us-ascii?Q?zfXavuFjBh7MbDUz56QlnNFELUoqvoTVy54qnyrAJ20X0+qeMRnSdV4W2oZl?=
 =?us-ascii?Q?5+1WbBUTeDc/UZgPtJri7k9k2GAHSq8GL2Kd2Z3tMSYN7XnJ4IXx+Bi7rxF3?=
 =?us-ascii?Q?/46ke9u1UJLJMx3OPIX15PRAWpFaSCD0wE/n5wuo9Ovb6CSpmJEC2nvJMp1E?=
 =?us-ascii?Q?ft+r80O/XcA9yf2R+ag1xs8UjZB05Vgt0VFjFeeYnj1+acNkWg5ZJzLSH39w?=
 =?us-ascii?Q?bLuAC/zibV54LHPeiTFWe4dHKhzjSlnozE2U07kCq0WyvOLAmIXBT0N3z4cX?=
 =?us-ascii?Q?cT+P3YFjKxwBJW6sYfyQRiFDMUoixL0+unz3gZcbYME1oBYTxSjTobUUj8Qp?=
 =?us-ascii?Q?l1LVbl7CXg2q8kqtkamb5gv82kj3pCTGhz7TED73hTiSFzxiOuaE5Q+EU0Qq?=
 =?us-ascii?Q?RESo7ob28bqLj7KTHKcNxCqJXV3Ru/TEGpox8Ph0IKKIUYCALdw/ukP61rQY?=
 =?us-ascii?Q?XuEjxhsbokgJBv690H2xmHdqwDI+hbeH8HWlHKJrYXBOB+FfFdXP/j91ViG+?=
 =?us-ascii?Q?9YmVFPbsesQgpaEr0QvyE6X7EYsikghkwqlXRbwkHcbdfSzBfxrcUOHcvsVQ?=
 =?us-ascii?Q?V0DxPLqCgF07MZhkr4NaMl3XrYOpMKzixtjrnYutIaa+2MH4CVDqAORWUyOl?=
 =?us-ascii?Q?f78sXyAE9Fff+3Blg5SUjEDdPcpJl+LCm2Y0J2jZn4PkIDBkMGyIu4rzePNF?=
 =?us-ascii?Q?eJShpMD/Mev+1W5/DNS0Lgh/NNJuvemmYrQ4K4+ioW3K9v1QVR5txWhtRbtS?=
 =?us-ascii?Q?642Ku2UyEfSg9EWO9EY14HEkrY/OnAE/qrOQk0RjLNJghDPL6QThEEwdhSzx?=
 =?us-ascii?Q?mHxirDjXAYCC6KKZasICUadUJXCkctP4rhYJOzws3HTORwB45RF+Gna2flkQ?=
 =?us-ascii?Q?cq16SNAdgzyz22BRoon5R7EC2B64dMHT/dk7RAdmzvBSQZzWdC31c26/Yh+I?=
 =?us-ascii?Q?28TkLpzccRw7rGQbrZZNUNCtRmX+x0nCg0sfex9KDrkyC538AZG9go2RUP2e?=
 =?us-ascii?Q?VCPfIFiW0hytBa80GH9lFSI7KfrMz81m56USMd7lyEa99aNbzrgClC8iqQ1v?=
 =?us-ascii?Q?a01ikQTJqiHONPAbkRRCqQo4moe6qQy3GUSIA3wIJpgdu0jyRrxcPh8km1cJ?=
 =?us-ascii?Q?jEo0C379ULyC9o6lI8g5jL7S656PMdJMOV+zC06aTd6dUlgm0AK6lakXHNhK?=
 =?us-ascii?Q?5jpTf3FBhnkXhW0fRBfabkksfGZehjc83Qv7YqXA1D7S4TNTgxFzLTtQizl7?=
 =?us-ascii?Q?d5sV/qyS/goZiCv1mwzfOXlvtv1yIwRtGyGI1D5m?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd3aef6-ecf1-4026-c451-08da5e487353
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 05:37:29.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QUDsk0mWIIMi9dzsaXu/RBq1U/nMdbK1aX0yW7dmuW6XYUBidmLcuCLxJLVF+Wjx0nOqWKViWmkRFCnUlWhUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0651
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
v12 -> v13 :
    1. Drop the quotes for "$id" and "$schema"
    2. Remove "allOf" label
    3. Change node name from "i2c1" to "i2c"
    4. Change node name from "typec" to "usb-typec"
---
 .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
new file mode 100644
index 000000000000..57429864d499
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -0,0 +1,76 @@
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
+        usb-typec: anx7411@2C {
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

