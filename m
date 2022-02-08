Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E54AD489
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353483AbiBHJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353471AbiBHJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:16:43 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2127.outbound.protection.outlook.com [40.107.223.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A303C03FECC;
        Tue,  8 Feb 2022 01:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShB2OCfc5+S4dPKyFZYpC7qMny5VTVS9qfkpWjmV4D9ZDrIs0hcqF1zYiky5oxD8ps6Sx6GqEQ4d0WC//BhZXzkSYZ/0FQiS9mYgX3NoYpW7CiLOraDKvmPBJ5SLH6EfYQv9u+ERHq1en3B5DtlgnaEtHjoD18dKppptFYulEVjrlw/5z1BLygm/hMDpGzSInRcLIKVyKD4Vsj/1v/GeZjRoKZdcDVCRItRMDGtHJ8x3OAXV3+sGFJiyaVxC9KDCgyX3uZx/d0bWRVfE+tPsG0p9liAZxltsqSFG8hJv3WTFj44UUOhNDH8A+iT+jBC579ieX/sHHFEUd1gtSl1x/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=NSgQTVEJwDM3IFr3Q0eAs4UgTQuQQ5kgcni6uCSxAon6TZOW28jI3WLbdRnMyDh2pIfRm/i0hVMC78q8vG6DH5VBYqvZgX4mHMAmS95qIqs5Qw12Xjiy31LYPvZDVKWJ4hcWPj2NvF6ocnsCgjX0HkKQUJtO/AmQYoTBMes8q0Kx8FNK9fsuGeKwPmeVGODbKh89L+JiT/oKVX4XP5yyslhpbGYbkCqUuF3KYyLHeqkiBk/GVpHm06/y/i2UGaq3mwA9qtq4KhrIJmYEYcc+xxx8B7aEDVBWj+XZboTmsVdIiPCSJYMEUcMSfCnznU7mQKaPigJcmuPHaygyrB7FSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AE8IR/Q35SjIum4hi0AsFqvQnEf1l/8fXca+rNHjMk=;
 b=R/A7l3+KQiSvjil/2b1aiRGxPWcQwEqcJJcJmoNsICqFa3xg3HF+xu8zH1QXtqofFOKqDgMZr+4gXl9EOafAkivfKXaT5It70aLSMosJj+tJFQKPItuy0nXxhEKEiPrdoQbLCzvPuhrp9/IdCZKyMlGNW4+O6EJpGXwVnDBsRWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB4604.namprd04.prod.outlook.com (2603:10b6:5:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 09:16:38 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8545:a99f:9aba:4cd4]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8545:a99f:9aba:4cd4%5]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 09:16:38 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue,  8 Feb 2022 17:16:20 +0800
Message-Id: <20220208091621.3680427-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 767bc240-aa7e-489b-52c2-08d9eae3b60d
X-MS-TrafficTypeDiagnostic: DM6PR04MB4604:EE_
X-Microsoft-Antispam-PRVS: <DM6PR04MB46043A1C0F1CF7CD52EBF081C72D9@DM6PR04MB4604.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5p5tug/EybpxRq6pY9wZsm2Rzw6CoG+4excUXsiDPQbGzaILibOvbAdF6xKwOae2nXGLwG8/WVLcMfouKCxdzsZ+v5mulotg4Ey2DGE3p2Xttq2Mj5tiwkYeYifh6v8Gvx2I7Y9A4e1/KKy13o/8zP64D8H1T/rMo1GAW5rfIEcpEVQ5O9nV76vI4QdB1/uMWPi1f2CVu1Yr3eu0o4W96R1jn4zVr3LpnYDZAAPRMv6bnsNxmNAFH0dxlhZeqArFrcURCLUDWIbb/gBXt4NRlcPA0hQc7a4rrelmvoO/GOLEWreWkf1AAlXVrtAE+5z+QjSVfsa1mHfAeft1t+8VKPYUfAt9uviLSU2r447TGfoY6dFjwVSgiX2kcGxSUQChxNATU+vMNdSFmr780Q2j/dpks0ZYfsT8e7xk97D4cgMkw5qBdZ5v0UVme1bhpVzTTgMY3Ejxkxgc0tu1l7IdSFrIs/P6pghif93t/Q6oMXbAS/3LZx10WIRcPZiUy7OQx32a0dwCpkoceJrm4kdNAQ0x+8iLP55DTKP4EPf3F1nMOMGKYToky7KDbh7uHG9VtdonwPAoGkW0/mcyyjjsWbljk8a3g7CINhCLZaAj37mcGjZ9qNJEDvpOHqq0lB5c60JAgJ8I63MuxxpySrJvcMieu7nUvEfJVVcyKPTzDYDQbf1/Va6/1GZ3dbMDgkldxsu00OswHpsG3ASMjvc9Q/93VGpHQNPLfCpj+/zYKG14oYMSfOpfR68nux2542U5WC9ifXU8r2S2x7JaXRJab53l4zwO0HmExUnJXTtOwJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(39840400004)(396003)(366004)(376002)(6486002)(86362001)(508600001)(38100700002)(38350700002)(55236004)(6666004)(6506007)(26005)(6512007)(316002)(186003)(110136005)(1076003)(2616005)(52116002)(4326008)(36756003)(2906002)(5660300002)(66946007)(8676002)(8936002)(66556008)(66476007)(7049001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DKSDDhXhllELwdJHd9mWHJA9O8VxLitwpuSf7y8qA8k7bIChjcWPbxN8OQxL?=
 =?us-ascii?Q?UeifQuXmjEArLd+CT9Ydmg4RhKqcakrQsS2KGXkhOBrzsgIHaIq43a9fo5Yu?=
 =?us-ascii?Q?pbJ1okQbH3asrukcPTFrEZL1I200f3uSeKqJsKMj7Y8dh195EXKl++z73MKz?=
 =?us-ascii?Q?FEVa3SZQWP1C5mAPr5H9/v9tW7ABvYY1GeiezxyYarGbT73R64Hjud0Y4E9K?=
 =?us-ascii?Q?7KJbCzsSeGAGVpE5Cs3V2Ll0SgnsPgMfKcPQ2xVEeCkBTc55s6FkoiLBUsGx?=
 =?us-ascii?Q?rfiIUu4QcgYiASNPyUZl4smTCo2aMLHnjiPqBkszC4A8pbwFq3XEEMDX9Je0?=
 =?us-ascii?Q?dZuNWQEUM63Q23WUDwXfXx+Ut3Sv0sWx85ur+DVhsLvLLScFs8vDlzFJJvw1?=
 =?us-ascii?Q?mqWP+t//YjxiIaWK1AHLuX4IUyZJ24NoU+K70Uwp91n5j/WKLk515aNDy0i1?=
 =?us-ascii?Q?WAwXh0l7IkoUp055qxA7kuyTUTunYT7eW5pwCRmdvhnln8PBSTc87JNaRkI5?=
 =?us-ascii?Q?kp9jFC1jovkA9ZHY/T5Ubpjg8bdVPry1VwgMiTtdjn7kZbjUopy0dnzfJH6E?=
 =?us-ascii?Q?uqaCZQAv/yc3uLczcLIT69NI6D+aYhGOPq1Xw1ny0k9A2dJ7bW8ERgSaIAX5?=
 =?us-ascii?Q?ilEaQ7qRpG2UwNjFjOiqcTanEuliwlfPPcJO9sldpjuRJ1CQR4Y+PWOvbsR+?=
 =?us-ascii?Q?SfgV1BxpMqAoLTOMPTBpocdWg4OTQP58M1s0FU7GhDPuvmP2DDyknjpsY8PR?=
 =?us-ascii?Q?eGr+9v4yqQM+LtHMWpuIblQbruffa0TmxU+fGDG6kwkfV98ztrRi13D4a6kI?=
 =?us-ascii?Q?YWImX1h8PlEAUtc//xw/fzbBu5KN410UBzqQk95+7UtQ75zkl/Ew+/BTt4Zb?=
 =?us-ascii?Q?SCMljsgFZMAUwPyXG+DbDWXbWx/6KYbYSpWFD7M9LXVfoAylsBlUiRX0IAtj?=
 =?us-ascii?Q?zP6q48VSrJcaBynnjC7DHRa82GTSUY0rfFqmlTNdJn6HOb74CGIVVqCY6QPD?=
 =?us-ascii?Q?/X5OaX+pOQD/UuVgWCJuagsABof3j9XvAG7lU+ZXPsCNcMYXDV9bzWiyPL8P?=
 =?us-ascii?Q?mTzIlP/JamltBZESFDE4x1JyHbsAqVNbn1Fu19hQo6j5tBZfsFmFrBVCQeHB?=
 =?us-ascii?Q?TqPY/Qt16RsPE5HRMEfdYfjsHjbv2KeWqRsOY2q9oG1M1ebHRTas6QGYd1sg?=
 =?us-ascii?Q?Ci0CN8Oc9J2kAfyyeWd815nbp+OrcgyHIOl3kF5ZNMpIPNcL6NC27gqQxd2E?=
 =?us-ascii?Q?cQZDq7JDuNL2zfPzb3DMqSOAg2ydhYh8XHhk3FwkoSOb2dHPUXK/6W9YEkUZ?=
 =?us-ascii?Q?MrnmAtfppGK+DP6u+dpwcB7ieqsG6pJ4cuQv+5u0NER9ptZHvEt1Xc7FVtiO?=
 =?us-ascii?Q?J0pVFJUW5FBUv4zXe20y1ouNVNXmwtJxR1H49E27xk3hWBbGtOQc2ZYR/QIn?=
 =?us-ascii?Q?2zlOoyBQ/Zz7JxkdWx58kAmHEG/QkVmc9u5q9rr9kiejQako22dT0c12gF9T?=
 =?us-ascii?Q?IMGr+6gOtargA2e9PbslpS1UAdY9cgidKiYyc5SdMxoGyueviRCej5OKwRRi?=
 =?us-ascii?Q?FgVFe6g5oZyGl0wJTohXk+G4uE/h3cJP9NHCGEk8wbzeJ/FdVQ3hpRqQbV1H?=
 =?us-ascii?Q?Nd69Fe5qXRB9vy49/1o78+Q=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767bc240-aa7e-489b-52c2-08d9eae3b60d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 09:16:38.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhyDOXTRqyhsFrXfpxVfaPC+8U1Dc/47LjPwE/0lE0qJXsOuE4XomgBGFH7/fvFHCs8gqtM3ddTZ9g4mYJWnkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4604
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

