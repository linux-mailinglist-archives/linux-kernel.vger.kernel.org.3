Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366724CF44E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiCGJLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiCGJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:11:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2126.outbound.protection.outlook.com [40.107.223.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A7B5640B;
        Mon,  7 Mar 2022 01:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJQYr2Jhgrw8RuzWQAx60ITtCpZrShJ9MT3lJHFDf/Ya/BCP88bYCTxDXEGfT9L+xUh1x3jxoshDOYVe35+J60jHWRBMkR183b9P5gz7lqqmShmaxZN/Z/G0ycZWf/kmV1Se3n5R5vg3YwoWvtrM5KZyNCEr0aU0zeiYHscpVDnAqvni/o0Wi56TU3ysPFDKCUNdlK8DbjbHC9jXb8VEB52M+rsynS9iScPukLhioan/7BMU1G85E9XuM4z708sYsaYQ679eUwc0AmF6JC5wMwHAwwgXTwzzvKUFalB0ogUy+pbbSdsZapUo0RWIPVGmjK+8+dhLV6HlPaU5Yz+kbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=az0uoakRNgIoEQUtV88n32/egzu7L9WZy/BLFufMhww24HFSBYE2Q6APBVPy3miwCdz4wsKtwJz5CxtjSIyte4+DDXuNf2pkG/sNLtY5wG0J94ANla/m0uQsqWt8EhZAPi3XxDBDWuGE8GRUrkF0o38TzjdEfWitb/zK3knzpU/DRl7GklMOnu7/X6D4HyOXjmKp5x4G5KWI0UUHY5h2HKK/LlY4ShQd/hGSNh1sVeP9nkZrq5TwEXYQw+VNYZF7ipfE01yEA+lOawT5a6KTEXaZEt6di64xArGy1RJ5fZDcZxdJzi8J3SObA3wBjY/xLgq+QFBXGZpnVJLJEfTLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=dpRC0L0/Wmk+TZFT/QLfRAxoW1XESWH+ehDWbbOzTVy/vhkUmk4kruFZveunGSDkJNG/whbKy8R5GxqI3bnZF3BLjHSl7QAK2KIjTjexM3oOExglg7k/x3g5vSPLGBLIjqgPHu016NDsfuwiOzKIu5FYFG39noc8fWQRaO5aWis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM5PR04MB0173.namprd04.prod.outlook.com (2603:10b6:3:75::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 09:10:09 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 09:10:09 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Mon,  7 Mar 2022 17:09:27 +0800
Message-Id: <20220307090929.701137-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307090929.701137-1-xji@analogixsemi.com>
References: <20220307090929.701137-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68ac86de-5fbd-4431-2308-08da001a476b
X-MS-TrafficTypeDiagnostic: DM5PR04MB0173:EE_
X-Microsoft-Antispam-PRVS: <DM5PR04MB017322E28335FFCF4C81529EC7089@DM5PR04MB0173.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRTvKyLN7jhpxJeazzzMJBSxKiShz8Zs1nP9/4TNTU22dKOjNJ0bbWn+EGvV224MVMXNPwri9qUz2QymnyarRp0fzefpW9y8Dl6eSL0tkflNZZGAbbQIdgNgZt4P7ZaTR8IH1PEm5r6kCGhDx/5zt+CLu9Gm7ee8WAgllJf5B74cETzJfXu2S+07WD1Ng81Gn++124ZAvuWmJrE5ikphXcR2rUtRE37Gla8CV+4fORero7oGkbAqhm3u93xbyNGxnW9eZvKRgUaj/xkjsBkqzC8/Ahky5MVPVlvJkXHLrwEqpx2xeEbGSRxZ52M570zfikR4yMawJZf0DtAxgrJCHuYKLGMmJNHciggfkcrNWWuzVQUsNO9YtelwQloxKeA6oosQursw0DgSLfvb+CAD170wRO/2YpdmR4mRqpYxOo5jys9D8z2PiFq82qbsCaXOArx/5X0fAZ/mHDM6LwTa3ZxqAhItrw4FcpqIcFVyf7DQ8OA5ShGzQpbEQeF44CQl9Ik+ZabSR7f2eZMhW0KKge7udlEF8HNjKCYxrGR17vE5/x4VVKmbxaWSxFuKIJ9XDgIcMDbPjuFvYj8AfqF3g0sZBPnz/2utd9NoOy5SG07BCHEPyI3f5m2FRDewrqsEQ+WXcPZeuKJVxbLA4jJHEMsOwW8OpfLoyBBzJGfzlU0PBrTVKzArZoLlC1z/f2gCDF8svouLJ9Bep+io+qfeClOt4imF/Z3oaTp1BFumP6D6/gwhuP5d+8l5cflBV8sgYhJIqcaeee7z4AOuK449hcRgm0glzzX4ChIrPrBJSy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(110136005)(26005)(6506007)(6512007)(55236004)(52116002)(8936002)(66946007)(6486002)(2616005)(38350700002)(7049001)(38100700002)(6666004)(86362001)(1076003)(36756003)(498600001)(4326008)(8676002)(5660300002)(66476007)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyP3LdATo2rp+nkw93P98p6Qtp5EIijG2Vq+cmpsoQdaPP9klhHXy9D/FLUK?=
 =?us-ascii?Q?cYX3utIwECZK6gkgyrqZR5OuAEuHjicTKpYjhtzryILprHr4Xt4HMWXrKqVs?=
 =?us-ascii?Q?8d1Lr5B2ieQqajVLk2CI1QThxrTRTnocOfLfHAci3lwlHcDYJNposE5tly8L?=
 =?us-ascii?Q?StUrXAGNHcsRKwTc4I/5BNAX2BgqzS13Ccm1m6qVZL0rUdnU5uCowY8xLxFL?=
 =?us-ascii?Q?m6vDUDYNm9omdXOmxP/PgluG/8kuyagSWGVaDa0ixbec4uYTC+Ze467FWZxv?=
 =?us-ascii?Q?Ltj5XmqsJpSbRtg7LtKvkNs04zs2ur0392rb3XA+rhjNWOs9WKRHGKtRBDZL?=
 =?us-ascii?Q?g4ytDq30mR9JQ2aNc6lg0/XSIkYcw5LnONLrsxaTddxC2MJB5QqYbRvhoPgi?=
 =?us-ascii?Q?hCfR8epdFMDT2saD71GcqUT4AvhHcZS4Nz1Dpw3g6uncuqHuaAfFESzbro5K?=
 =?us-ascii?Q?/q02aNKNO/qykAk88FWs2fL/RXpS8Il1yMm6mFsWJWWlWWdk6tx9i50+kI1v?=
 =?us-ascii?Q?fqfmnRI0chxQZU5dRoZWHCfqcnpedOFt2Qc8et8q8tGFQNP04U/D3AYTUNV+?=
 =?us-ascii?Q?s/lZ2ux2IFMBI2nSxc3E1fzuvBlUXR7suAIvwEG0IK5+BBl9d61q5YTop6u6?=
 =?us-ascii?Q?09LDdm2e6/ZLTLIZ4XlTTN+q5XPOmOEmKsU7Is78oULOxpDFGWy5MspuFIxl?=
 =?us-ascii?Q?rSXdmovn/IqlBxrt9gGkD/zJrynEc0ZX73c1h75BuqQojnNNM4B/zkBweMlJ?=
 =?us-ascii?Q?qS6ahKU4JG7n0ZdvyQsoTzS5zPEOnYuM2k0O1C3LyURuyG70sCoQ9e4+PwxB?=
 =?us-ascii?Q?A5hueBZcrF1TaEDXBOOv1+sCLQZq5A7usT+FxakPHvoSIbpCR3i3j14ZQj4z?=
 =?us-ascii?Q?vYr3jS+ce9A3vY4tTAgS/82kPlOiOnjKa6zjNR4J5K6fgHgGFbRjmqssB08T?=
 =?us-ascii?Q?NIioVhmI8NUqHZcCFBh/VT2Zp6NY8jUil6w3kOAS5TylaklIHsJFtO/udA8Q?=
 =?us-ascii?Q?HAzWsE47QOEv31+Q7ZflgWbZNDnewu+JQMb44B2Wx2fzrCOsBr7D1HaZPHuK?=
 =?us-ascii?Q?uHGigR3gCL4V9G87dv7XzWXATRjkygwp6Qyqhi4ZWiH41Z55GIExQoIG+Dmm?=
 =?us-ascii?Q?tWEIKRF4uWltmHzHv/asACen6TwCocaYmApki72SY8/g6qPrE7sbOiYB5nMB?=
 =?us-ascii?Q?9FsekvwFqALr6x+tXhAFiSgYXohPnj02VKqY/HDtHLYwlATG++QLFrh+a2lQ?=
 =?us-ascii?Q?ghZDsrRncJVEHXgut5FOGQNMJQpkZ6FHJ0CYQo52E0UFdpvczMzPvRF15wgt?=
 =?us-ascii?Q?hwiSOHX47V7spdHgA6NLT4EN/3NOLLpMk7N/E7E4qcJQXZSOP4WkwRw1MpTm?=
 =?us-ascii?Q?YDUIj8kwISl3wbH3CVYWcFcq7oGxGtXPI3ctuY3HK4YRxFhxmSEkinl8VUrh?=
 =?us-ascii?Q?/FcB8ihx1/jH2d2qpgFWBey7qPUwvTS1ASzoxE4G2bfwujyE5L1S6vrQheie?=
 =?us-ascii?Q?SFXNLyoh/RVSL5VIoXe6Hm4VAOTZrjQIcQiKC32wXN41nD2yIePSTP+l25ZJ?=
 =?us-ascii?Q?aqYiSjoZWnahC9G/f2Zox8Zz0cUQ2iIzLlSLyaymXvkjoxOv23OL9VP1nay+?=
 =?us-ascii?Q?11EWgqiiYwdo5gr3XSnwtsE=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ac86de-5fbd-4431-2308-08da001a476b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:10:09.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcq0EHFVytGAl1UEay6VIJUUB7lGS8/9fR1CGkS6yda7BqNWn5NbD9jWDMc0AlV0fv9RFMfj2oCGefmQCAQLcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0173
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

