Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A8B579100
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiGSCre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGSCrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:47:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2117.outbound.protection.outlook.com [40.107.94.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17032ED9;
        Mon, 18 Jul 2022 19:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4EoJy4jhLaTwTeExyo0lrqKP9JLTKw+Tj8q9voielT7VN57ogwFwcTXLD6Y395HmZYyCepCzBexx6rZRri/qxmJHarFVN62+cYcI5Pea3PC6pinFsR62Ax0JKfJM00xtF8y+c5WCeCohvap4ybmvdzJQGIEmvL1wkgRhFJeGhbKRY3PR0Qnbrb4NhTpPoYGWA+ECwlqR5OO7cEWmYskt/EgztDBayYL6xWlgYgeJRCM6mEC9KnifFcDjHhIWL21V4HcwcnROLcLNerpQTpzi1+rePQsYJwuOcS+dsKco+SlTQ9xPGTjMj0xEzQkghRjONKVBEy3/H5nuewB2K6sRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y37IkE7lI7Q8VwypdQYoD+N7vpljHsLKA0CVcA04OZw=;
 b=dTPjdBiD07z2oy5zJLkNIC2iDCrG/7awcnlLvNQIfvQXqY2+fQUE7GFfC94i1H72hdKJRhUTTW8JBNK2x8+GMBih0clepGfG/XI8a8hwF9JCx3Ybrbe3HQV30U1Pk0X4a96j7zHr83LsLUaJXO9NUBaucbRDWW0FmizwBabAW8YHTm8DwDX79gCT1Mh0E1AIHv5rri0rvK/KuRg/LC1+nRlVpjiLYh3G0rNn6UAo0UO2s0tq+qW9Vj0d8VoxGst4YZ1NBbM9QcLapr9J79kvUZoZMYqhr0pbyoNPNAHk9jFJc6q0W8YDdjkk/xJa/47H1BFY3HY+JbP0FluGypUt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y37IkE7lI7Q8VwypdQYoD+N7vpljHsLKA0CVcA04OZw=;
 b=JQLt6dX3pHi2ABuDhV9n5R09K1ySz0alNdxBG+4rGZcnTVPhXx4oYQxUbjfQ5W4B5lkKqE4JWFJ5lPs4DnVdnTifIrdoblRos8G1d9zlWmt2a2ObsXC1YNyhjWs5KiPD6Uk0BLFnJI81FLSOY3zubBLw05C3x64CS05mrMwp13c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SN6PR04MB5247.namprd04.prod.outlook.com (2603:10b6:805:fb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Tue, 19 Jul
 2022 02:47:28 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:47:22 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v20 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue, 19 Jul 2022 10:47:03 +0800
Message-Id: <20220719024704.47395-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:405:1::17) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db00092-2077-4489-8536-08da69310160
X-MS-TrafficTypeDiagnostic: SN6PR04MB5247:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2ujpuMU6CjGXVLBqUAUwaHoQfxciIDfWApK+TeY/QotUeVFrHV804BWfENk3Hwc949D6U48mTVtWeTFdFrwS/0subpDXakaD9oAPRVjIxe9DKpGN1qJ7hJKFaNl1nIB1EWowkifBmJNrVazf0sJ1yRV+3EaA+VzcF24bvFOaWJ98sfrLCqg03LTTklEhkvx6JxhJksWK/dKAV4rTSqCzMGN+J24i7p48uMfhhMffZOVC1mQaItBEikxzjtw5xbvDPddxIYgcD7376BCPUrok5BnD4WhoypsIokr8boFehw/L0Ibr9zNmw5FkLeP5XT8/ZOHfJW/BRHfqvj9jbmZ9/4BOMmfp6bsmpxYOglon9LRKahywtT4OR0P9gJyeL6PI+SXlUps9RCW+2874JRIr8GuQcQUCjeP1HVtur56osileQC9kiFT5ppiqFwLUTPlC0cEjtwQ+bayq7a2bmdtSH1gsbmUVCcwfYPFnszQ0ZFBoD8qD3QDmeL0WicD5ao+Ixcjc53uXbLYjr2at3mMJWk3R2mm1Qa2/UFezoVpFbMVnD6jd0ftevU3cmEcCuS4tNcSIXbJdWYQ0fTu068R06SUDjcV4yHFGZbm4TisNLsSbYmeEvDYX+fU1Qc7hLrvLPSgBBJtPTLz4Z8t1XNH2jtZaKK0Sm1tDOJCRoG+v3tZw8OzDNSDuhNkxPk9obk98A+0zujoI+4Q3z5EP3R0ind2vIE61RORbi0fj+w2NDLGoEvPTj4Mseq0dek4gjoPbX1wLdOMo++AZlqz8Q9bo0ZuOgCfVmw+NdGa6huD5HB1vW8UAalvxqcBW380WQx+XHvVrX7/f0ORefpqBplVfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(346002)(39840400004)(2616005)(66946007)(6512007)(8676002)(4326008)(66476007)(186003)(1076003)(7049001)(8936002)(5660300002)(86362001)(38350700002)(38100700002)(478600001)(110136005)(6486002)(6666004)(966005)(316002)(66556008)(6506007)(52116002)(36756003)(2906002)(41300700001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtjMcQZ9w+GSdQAhTC4RwPRdiCMRxL5gMe4r3+5eYat2rUzyir5mE4PPZheX?=
 =?us-ascii?Q?tzpQwChUsYImVvC2Zjlkz5PurV9YpvSB8xrUN5LLJQ8r+H68DkJYPM7uwEfB?=
 =?us-ascii?Q?cxU0eFe2qeste/nGxw6TDU8fxudgzPcZv9BIY1KJ50PnZ7HZkSUfdZXu0zK+?=
 =?us-ascii?Q?Xz+LGJIjxUWwlkTApDIi3fxZwmIwsRxibIjuBeWmJPmY3SYhZLAeMSXUwQLm?=
 =?us-ascii?Q?RS6/OwlH0PKda8Vr+anzAxJNAZtpup2vyaBeozpZC8ee3KZy1RgyxodGs0dw?=
 =?us-ascii?Q?GjlpDnDpH4VwUurH7ROsL9EI1vKGBgiomjLNBTBw4DvxLiddDbtVpsOw78X9?=
 =?us-ascii?Q?UNjNPzGgFW1wxx+3SqV55lpF214AsqAEhR4PUEVJPj90Ohjp++6Hzu38XiJa?=
 =?us-ascii?Q?b+5qq3aKuoXk86lzgjPOQfxeGHJN0Qewud3Lc+dLbeutBcYfE+zzQRocI1fE?=
 =?us-ascii?Q?9N1CyPdkLUDUNHDw4KLbdagTKQzgO2dnKbpI7GqeMu7jUF/xj7veHGd1urwr?=
 =?us-ascii?Q?0OSLxzoAjOM7hGJV3GiMhQw8jhtiYjZAgj7FmnT0+pUANadT/CSyBpuBB77/?=
 =?us-ascii?Q?s/84f46GgB3cI4ClrVlo3x6SmslEBitfpN71N8JnZI1nrWK4u0QSoQOL+EnE?=
 =?us-ascii?Q?rNDjjapZR8Q/L6mk3yj4x8xNXjn6YMrqvqq2JAMwnHtJG4iUQyJreblzdKWz?=
 =?us-ascii?Q?p5GOeGBHVdmVslKJn3YPfB7ygx85tV/CeMD0pcuWiTNRcb+ON8QWekQHccT2?=
 =?us-ascii?Q?6lwUPkhScQjeHcksimIIgwymUfsUnR5HZYzndGMgKJb+69tsPrqOGRzVvt3x?=
 =?us-ascii?Q?Kn5aKIVdkRKs4MbGg2vlBfGuT0yp3qSaGkTxsKcc6ucD64zM6Rf/a4ELUyhV?=
 =?us-ascii?Q?oMBbd8XJ5V1jooX0rVtHtyCZ7MMxXl5nHxGD3w4OtpoF5CCePQhzlT+CklqR?=
 =?us-ascii?Q?LSHsyxJ90acEb9HA52Y4/YdNJRbJpDBqvzydqSIh8ibhNI03jpTpXQenvs0p?=
 =?us-ascii?Q?Nh2DYCyxSGYQj0abg3YEhD10BJYEYrLBRH5Zey0UYkIjmd4bPQ7HOa3F0uiz?=
 =?us-ascii?Q?jOb0PJjm3hgbt1ru1pwiqY37w2pxE4FKBgHMeVQ4HnP/7eFl0UAHExK8iXPZ?=
 =?us-ascii?Q?fTtmPFBMI/is1WrrTkH2yVF+3OzpG9VcFr+UP6iGl9nATR6+J9Sr19V3pSrI?=
 =?us-ascii?Q?fYBRnGmedA+Aqrseqy8LqqkuGcogOEbi/cpvIS4xVhAeuwDuyiB3lSsoKhD9?=
 =?us-ascii?Q?EHe2N9Km3DmmbL7Jdzt9zg3OAz/RQrAs333KyodEODyhHBf6CDfi/3rDrNvp?=
 =?us-ascii?Q?kadJkaOu7OMIBthAZ7NFRb528m3dVi6IbOXfxPpJCcFF0s5NM42Pevyhv0+M?=
 =?us-ascii?Q?vW4bzAKaSOqjig0to6W5zvRwEq0IJiKEI0MF8LHJKW2xd9Lz5vboiNxueB0v?=
 =?us-ascii?Q?DhzRFY3s7+aUr12PUEXJgAW5nIguG3D6TBz5qkW4lN/dxt3Ux0G4OOYdBrN9?=
 =?us-ascii?Q?tWIWI1HKMnrUUPkRLDGvmdxnEbvSbkt+yywiVClCaaHIzyA7yDAM9n2dR7F7?=
 =?us-ascii?Q?Ogz/3vyxobHQrT48ejnf0HqAUTVxg6rU53Qr90Et?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db00092-2077-4489-8536-08da69310160
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 02:47:22.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6elc3eTMD5c05I8+lspRSw/pNkmeO7mjFE3LvMJpa0LNQP9cCwctGkuckMQ7ezdLbNyZUxoxxtey9r2JGgtpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add analogix PD chip anx7411 device binding

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xin Ji <xji@analogixsemi.com>

---
v19 -> v20 : No changes
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

