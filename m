Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518704D26FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiCICfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiCICfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:35:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24579A4F6;
        Tue,  8 Mar 2022 18:34:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbBl7QLBECcDTxJZZcrcd6hzh3JlApkb/KJ4luL+3J10VGwV50prpxc7jS9OymObnxo3FTIuNg0bzdAgASfR3T/zJn+C8tvTzOi2vUWNERWn8QSjmv9mh5JQqjOtx40RTuWpQqBEorkt9cdlC2W8IDGwjckkwBLw7m9g5KGLWbli75XT55xvEgjhXBzREUFyeTPAFqNkG9XYBnUbPuLxHBMF7aqUCCOuel03Z5MrdR1uIvX189MjREYg4Es+TmNhR08m1G942vE2SgavgEHebEV/q0WsdaMuKvxAo5olKvXvrbu+RY/U44gAn/G35P3I89eBDys1zxPBiFs0hTL6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=SoFOBsk1MRciBB3ihTxPttnbWnMldLKqVmiT91znTXz0KtDocKpZ6Stx4+7CyC9SxfrsY9qAzHnlPLawDZoFxPTKLa6Pd49RQksFKrCnUpHX6KTH7vpp27a4YJXKmwrRC71kamlLma4SlOQ//zm4e9mMBYf9zRLYCn5GbyIsQUFVXJJ2e0TBe2+Ggui9GIj6a6uQAMyjbKEXgxidWsrjxTWMa+bLmUdVid/Sc/r3H67SwnnyZM/ymXy06RYBKi6Y4FeZ//BrhZmt6iEg5jliz6x9eQsE567AKe5X16fwaw+1UmJ7Rc+vimjSp1cAG4b2UYQz2D7KpiVt05oqH2MMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=gMHtiLBEWXkasVw2V/c91MiO1cBQfZsV/XSTWWycXSdyACLlkJT5EMJbMw/i3MI2UqdtokD9qfJsmngReEksxPJyNMRwikTO2R2pA0IS7VzIQOaMDV/Jtbd+VkJUTxW6q1jX/YqLZ7a/HI0cAFeIVvrTVYMXNMaUK97QMA5/j+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN6PR04MB0533.namprd04.prod.outlook.com (2603:10b6:404:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 02:34:37 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 02:34:37 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Wed,  9 Mar 2022 10:34:02 +0800
Message-Id: <20220309023404.1221453-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309023404.1221453-1-xji@analogixsemi.com>
References: <20220309023404.1221453-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16fbed85-f413-47cd-8d62-08da01755ae6
X-MS-TrafficTypeDiagnostic: BN6PR04MB0533:EE_
X-Microsoft-Antispam-PRVS: <BN6PR04MB05336FB9B459F0E85E48D3EEC70A9@BN6PR04MB0533.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CT9myVnf8An7OLw599VMDxoIXF3Z+JWaMynQJAC9MWvpLpS2XZwPDI9B0C0LdihVcpr7pIlIFdkBY8ogqmJqrwufUFRh16MbsyGSyFOtR5BN1Xavwa4YppLYkUfCHfzhn4pLnyhiCqWP0sdb8rAV5tq+dUk/0Ou5QrIh/ppCbRLlgaHUgHcAx1jqtXQOupLIf/SfYAgw3/1mIB3dYQTeJgtHfq6+S204JnZAraIxdKd25LX50OGNUQ8Wo2j758Yj8m/Vu7F+cZCW1nbYEhkJ+ZlEma+UuivTR9MeFMlr/W8n/7/n1b6d/x72L7icSpOugdOqbJDE1SYh36PXpvwjQgeinCiyvDTTXePHhuEpbr5Pu89GGzlIDi9ekeNjy0//mWpLQRtVx96mfTIlGOUDI7CXIOhTFGghuOeP0isCQci2mPFZtX1+IfDIXBtuK4sQpiUoDh1Hs0sQ4nabkJib1mR3TSLk3GpnOCSDX4MbCZx/3yI8QxLJ2ffWFj88xUMa6m0vErq2bdbdRqoSNo9WSBWu8K8NRsKOGlbY0DjYsz+E8ySXdmgxl6sOhmEzRXOC8ghooFkbP33PMyLXK+BIQYiZfVR0mHZ7vWZhvNLBRe4jca7fbXGccbihS+WAHlou1fJBWj528id4jcS3BSlTnttcC4sJkqkQYpDG8lvcqf6F7LyHWbCaz20JNTWKJioCZezCCPhnQ4JJAAVpSu/a04dXBUsd/Dngbg+SaWZNiZ8hT0+VN8sdjDv89Q4eEQ2zPLRSZYRLduQBl3Oa/SC1AyXrzjpbSha4FOK6Uq4KdLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(38350700002)(38100700002)(6486002)(26005)(5660300002)(110136005)(8936002)(2616005)(8676002)(316002)(186003)(1076003)(66476007)(66556008)(508600001)(6666004)(6512007)(4326008)(86362001)(55236004)(36756003)(7049001)(2906002)(52116002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8Tgt0sGQpbjFyzVbINuVgrFa5+ZGDB5XIppzbFPbqY8i1WOwsojFhQVjhvX?=
 =?us-ascii?Q?58Hzu2ZInUN6dvgbaem67iVOGtfWfSPz+7ar02FtXyhkKo0/JEPpwRmZVVXR?=
 =?us-ascii?Q?pVlbk8VQihCPbwumfD/At9VuyU30Rxw886BiYAExigfnWQqsAI9a6OsOhNK4?=
 =?us-ascii?Q?ReUD78xlgkT/qHCpcLX1ixM6iMahhmSIgP/24I1ZAnJO1HWthKOGjleUp9tR?=
 =?us-ascii?Q?6hrjkOVcTyVhlzMDJzfxxifNupU8QWgSVFfk3rZNo0NTPdf2jbtoItd6s/SA?=
 =?us-ascii?Q?7J7vdJyQ5YPrxEQ+OFxfGqJlFCWOmIiEywwA9TkKeeXvFw7stnaC40IskNpw?=
 =?us-ascii?Q?hMc3ZjxGjwwWC3gXZ2LuTf7MtUq48WjbjFh49Wy1nGilBYSd1QDwzFqdGxwQ?=
 =?us-ascii?Q?VUnr7bsojab0GmhwbQmalw4/GpiKg4fthu9Gz0Gwin1GRj4bVQErZK4C3y98?=
 =?us-ascii?Q?/ilzn856Y3/5nt9oQDh4QR8F3rr+pFN2F/SqPOETPYXUwk6LnwCDp83JM2it?=
 =?us-ascii?Q?WkAAbrSnLePTFfErofhcLNpLoTo3fQomdP9Rkwovv6jvH/Esj9JoFAi3T6Ot?=
 =?us-ascii?Q?SQ2RnHC5gNhnGw4BXUxvaE/4BQZTgKh6dAjsdBbnt3Ilux5PWz9YNWFLev22?=
 =?us-ascii?Q?YYmYtmf5kp2dsJUCunUNgyecDfCeUqVnS3jd83phAvkAdUjlw0WSV8vjazDd?=
 =?us-ascii?Q?1bwivoyC+JfEa9C7s0jEiI7vWBeRamSeizHV7AW4aVknYwaBgT0QuI7PY6GR?=
 =?us-ascii?Q?e+E7fLUGIg32C1w3OkbcaGSxg8Tf8HjvxsHVpNHfiF0qCzNy70G11Bpf9Btw?=
 =?us-ascii?Q?rYuQ5Gi89dI6DDs9256wnkarEz1USDCnWXV6s8zcXKlonfksSvRm+8lrgFQl?=
 =?us-ascii?Q?3eu2oa/ZuYXMR4AaZTeUJrz4p+hs0zqi1np2Alg7OjpT/I/lT3uJq6a731tE?=
 =?us-ascii?Q?jMnP+K02WyL+C/uf2uZANHDAhH+kn1emf+QDevWovkrpo40w9VaFpc0v/k+J?=
 =?us-ascii?Q?MPJtH8ZVW+FVuH665sx1qr5dHcIFaFRM0L6G/HeDDjaPK3opPjhYfDNXw5Gk?=
 =?us-ascii?Q?b2aG7BxFFst7M5TBuvDqjPy3saQ1VLWQ4824RFyDmsoMTKY9Y7eROx0xURmm?=
 =?us-ascii?Q?1Kk79Ysm2QDzv+8M0o8kaqMjkQdz9dZR4OKR3+kQCR60y5+ozJV1BTeMwEFh?=
 =?us-ascii?Q?A5d54boIVHgmfLdjSrvoj+qmSle8R2xVizV7zEZLGPszbhx0giq+9nTgzsiv?=
 =?us-ascii?Q?g8wTWIgvQ4r30GsMMXZXSIj1kBu9hVbODOi0XWBposYiH64xi7N8ylw4BATD?=
 =?us-ascii?Q?Ejvhi4C5Qv8okAuzbbgp6XE0XpegRrJKcrsWzymO1eHETK0eJ9nO52o0FByO?=
 =?us-ascii?Q?2yj9qdmwSW/PsZlh3+YuY6JBsAzZSPBlbsJ/fnNf2eHZRJSSubu2piaev0O5?=
 =?us-ascii?Q?iZNJjJyPDMItxJA+gOzxCfytpfHcloksfyhWfic5QG8gF7USYXNorp7ac7hk?=
 =?us-ascii?Q?/ASoq44arwk0fcCfnpht4MxWGSevky9/4ut1h2jkvJiSTFPQxKSb6IcLlSN+?=
 =?us-ascii?Q?i6iSCyeLet6ic9sGPWHYyyFSNsKld3YQPvXv+Q2yionNMu08MBYn9UkwM3MK?=
 =?us-ascii?Q?vmnn3Qgk1p61AhuydG6Yy08=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fbed85-f413-47cd-8d62-08da01755ae6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 02:34:37.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtXGK+zs7Av1V3JnXzL9Khu6j4+sMzooNrunxPh3Ke7eM5+Kh4sT3f0EZdf+GCJG4/X7vNJoQKX9eMSv6wIegQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0533
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

