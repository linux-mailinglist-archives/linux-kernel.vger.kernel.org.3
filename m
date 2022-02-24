Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909C74C301D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbiBXPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiBXPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:44:20 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E17020A97C;
        Thu, 24 Feb 2022 07:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDZg+sp50jFdu5XhjJ2/z1KgGhJ14AIr5i4wFvzzfgagNXb2462NViJSuVOnSRE8i8Rh3KUT2VId2src2B2H+k/2DTcAi67UWFzTZ3jT+Zd4fvMoWJ33f4tnLA+2EblfxRjTbtD5m0kKfayHOj3jgskBQav11rDWNEbl/nzFW9aVEUi0RhXdqRSI2FaUmGxjbSiUy2+Q+A9EvvMXP38Fsqo7/ZGmU+AVg5/in/wKAjtddtIzM40lm4A6QUHclIG1M65fxjTwA8iiR+oqR5J7Rf6tuAtqWMauN7dWCrcGNjEOylg2kkpwt4+JFgJjvFk+2k4eYV7OS6NGAHZiPAn1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nShOoLYpG+chTYIH/z9jhmqadyKfbeiWZZJemY6uF8=;
 b=nF6GruelnmICwE0Rb9q8rVVz5cOeXJxPq93Xck3Jp6fy6Amk6OGM4MvYzD5mc5bctd+ET8eYBOHEbuGW/5JJyX5fULJdiHunchcH3RQPa5sydFv6MV6hUoHUpYk6QfH1MZQG74rJCKKFnSKRBv5RET6Kb9QwTGHkgxb5GeqBaJ9298FxMBe+a8Ld9+2iPSgUvbdHa/YdtvkqDsFsAdcVNDZmmtPbdvoBeP4S0BFFrnASFffoYml9Jy3JVTNyzIJOZlJcNcrvz9lYYO7Mk7ZLPAFFpWGNxkJBLLAdiGQfj2UfqJG9Og4bQuPPx72CZcJAHFLsasX3kEVJnqu+2pRVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nShOoLYpG+chTYIH/z9jhmqadyKfbeiWZZJemY6uF8=;
 b=KmvEucy7Z4jas265/l2pvGlZyXtQTkQgZNusGKllyXtT6iIDxiqEV/SS85w0FlDov9G7ri/buv/ZnSdQlXpTckcs5VF1zv+BVmgVFNmMJqC2gCFq9dlhotIXD+lxMPXbvvQO7uvJoKsyVWAsueyhnyl6I4z8sn8FQyKo8hSYNHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SEYPR04MB5858.apcprd04.prod.outlook.com (2603:1096:101:6b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 15:43:45 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 15:43:44 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 2/2] dt-bindings: hwmon: Add sample averaging property for ADM1275
Date:   Thu, 24 Feb 2022 23:43:29 +0800
Message-Id: <20220224154329.9755-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224154329.9755-1-potin.lai@quantatw.com>
References: <20220224154329.9755-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0c44c69-dd4e-4043-3133-08d9f7ac7076
X-MS-TrafficTypeDiagnostic: SEYPR04MB5858:EE_
X-Microsoft-Antispam-PRVS: <SEYPR04MB5858061A52FB7C6BDFA557548E3D9@SEYPR04MB5858.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGMzszXX5CQNY8q5FnvBm/QY99dzC3tDI76Y28sF6/yYyrR2ti5kGAiN7BSiemQ0VKRwbTBLcp1dI48UaQcwOKk0VhZW1oDi+Z9O5jP7cFSaHSHFhOMB/pDNIb8kGnKSehh+/UXrNZi+LyGVVV+GhHhif5pVqVNgxzP278xMiW/gszlTLEimdFXpmc+kfH/mUkM2dMf4y5UdOn5OslzxhG6eq1u825AptuOcQHYRjNM5W9dyeWeYYN06EkncRupjBD6hBbJ0tzGA1Y21qQfxPZ9JRauDjHuUu57ZustlLBgVwMIu6aVumWhW2IefKqJCI8Mg9ivb9x1+hz56bXGtMgRsFUoRYfs2r2vOLC1Oj3ZfO2dK+Hpb8ZgGZ8531XLhYZLW3xZrHIy4gUDrBtNZEpRCi6eynczihIw+y8Pr6jDFpkXhUMojyBjGlC+RR3fqbYJAWMEpk1BwWwrURCmeS4YyqDdCqfGa4iI5XGyq4jFKr3Kv5gmy3EXjNDOGO0+9Acpsd4wo6EFIO2NpeebVprkD4cvKePI1LbssjQYoc/x+LUpAeb+0+V2SkpZXcJAqt8gY8cBwlf9uONsypR6A4wS0ZuJZ4x90/+8EGdQy8xqy8ZSa7b+Oxxb12WVpStiWWXDxhGS3EFR0UNpuPjjbmKNe1zLEHHu0eHBcz1gDwSxZSYGE/OtyvdKhgZOmWyeLikMTsSRTR7pjzC4nmDhWJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(316002)(110136005)(6506007)(66556008)(66476007)(6666004)(6512007)(66946007)(52116002)(38100700002)(38350700002)(86362001)(4326008)(2616005)(107886003)(508600001)(8676002)(8936002)(1076003)(5660300002)(6486002)(26005)(186003)(44832011)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d3i3kAnFVdgxf1288MY5z/3e51qq5mU/qYz88Et3mljxgiIL7CX5lOnJ1gCU?=
 =?us-ascii?Q?ZjfWnIa+22rAWB6CYINd6ayLiKhEMcXLnOsI9wJiy0JJY8ReEp3mEKf5Ux7s?=
 =?us-ascii?Q?91ynjnFM2DJAXQQxmW0Lxd7O+90Yq0VzpUdoM68RaIjwVQlasBQhYT1aP6Iv?=
 =?us-ascii?Q?HFYYxg8F8ilKRYg/4zQk6DihyljyKbMaPT8Cw0n3ofPmiuKRzfJAMI66JaiQ?=
 =?us-ascii?Q?Df6u3rTxK/zPpTfIwcTC33mmgXpCKCDQIEEr3OsmexGiLVPbSMvIqOYXvcxe?=
 =?us-ascii?Q?yP4lC1WQiU4O/u8PFSr7PkSCX6aWvbecm69vs6gJJlNeVcdWUdOGP9h5TlDh?=
 =?us-ascii?Q?DLM5P1ZTdb5r6eAxO9Mww0yWshjGd0j3h+DBAKCt1Oz1armWPRY6k1IqoS4K?=
 =?us-ascii?Q?RjBCIEjTJKP2UtymVZUmB5LagXaYLUGaa4rAwzhX+ylIvuc+L4bMXpaJz/UJ?=
 =?us-ascii?Q?qjHOS2vI6hFVaFkxowWszClsuJfkVDvhGvKc9RmKv/DfIAHix7v0keC6FsNR?=
 =?us-ascii?Q?LXmjrA7ndidP9TDFqZzRnlw1hCk41KWXVh4QZnOPdIZI2Fq7cUaQ7g4CNJ6I?=
 =?us-ascii?Q?BLEJAINRDIVl3JoWZs09bK95H+ehdH5t6zlkmsxwAnWgv1vqKYbugKpGJaNf?=
 =?us-ascii?Q?J86WuONpeGqk+5wXH+dFoVEnaUpE7NxHmjsoN/Wg8lQ9EaIWq/qaZVWNLdbL?=
 =?us-ascii?Q?mwUC2gmd1gMM2uICQnV9sR303CRn4VsnWlxsTc8AEOWOr8htxQcKo8vEsmpt?=
 =?us-ascii?Q?MdWqOByqz8eordBfxNlzc068D5NMvrQBk/2LEbto0hjCiQxxyQdoBFz3mbr7?=
 =?us-ascii?Q?Atb9kjCDUHD7NjGUOSs0lB2wmGE5hp6aVmSTN7Lciz/mgqi+uF/zKkeHOQK+?=
 =?us-ascii?Q?Rg/y5XHWdZvXllAO1pA/EfAA/jFQuPBkVv6VIlhtcBsJ4gPUuU9VuPAJSmuW?=
 =?us-ascii?Q?ecqpiuAfvkVZfGDFC/XlPG3PH18AdJdOhm2Fitd8XYnTQRwwDFX5GXHfhPSE?=
 =?us-ascii?Q?Stj9KfIFhUGkshuWXuFIPBVcrcIASqCLfUqlSfraER4sZ/S6bwwB9KpGpmHQ?=
 =?us-ascii?Q?9/IwZNAi17Id4vy2eiSenQk8MY79GGnBIQYSra2vA2koCo1yzL/wwov1gZGz?=
 =?us-ascii?Q?eaGCAXMtHEZARvH3HlpgUcSxBgieqp1pNWR2KGEhI6MXCyRPKgmIGDqCIrow?=
 =?us-ascii?Q?sOfrqxMwVDIdXhuKjPL1EZbaSPRta1K1ZG8GgIwmFET13GUs5hfYqkAJN4nM?=
 =?us-ascii?Q?Re5IHKdIIM0Xsl1x28ehTuHQJd/sgLOucWSV1U9ttd7SLeCVz33gHfkxwqwj?=
 =?us-ascii?Q?oyWuylLN9zNWHNhVueihtScX0hBvrI+gvLLInY0L6XsUbCg3c+2W49+5F23B?=
 =?us-ascii?Q?kCpwvgH4alIDzSMnPzxGiAFALnZ2yfJxSaplHJ+MCwySnQ7eaqoxn1FIX80P?=
 =?us-ascii?Q?PHP7RfOCyQ2ronbmzJYp+3kQATaTAUYchybvfg0Ls3oQd6wDZ82DlWZe2B1u?=
 =?us-ascii?Q?sug3DPNe7Ob1LF3ZBhFeYEiw/zL1lSw+KpZh1c3niUbwt+sW+QfCP4JKcFYS?=
 =?us-ascii?Q?npY4v4gwfqohniyyU/RzcJpGmoemDTEftRZupemobsUCynXDnZyOdCiyoxcs?=
 =?us-ascii?Q?cHt2SRZ1v2llk+AxViS+6c4=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c44c69-dd4e-4043-3133-08d9f7ac7076
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:43:44.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mcym8YEzQ1xGHHMqf1txSVOmvYuolqVUO2ru0DI04TOugzZPiw56rc9CEs9Mos+cDYetWStxQHHNWsy0UxpgJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5858
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new properties for binding sample averaging in PMON_CONFIG register

- adi,volt-curr-sample-average
- adi,power-sample-average

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index 223393d7cafd..325f6827648f 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -37,6 +37,48 @@ properties:
     description:
       Shunt resistor value in micro-Ohm.
 
+  adi,volt-curr-sample-average:
+    description: |
+      A value to configure VI_AVG in PMON_CONFIG register to indicate a
+      number of samples to be used to report voltage and currentvalues.
+      If set to 7, the 128 samples averaging would be used.
+
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum:
+      - 0 # 1 sample averaging
+      - 1 # 2 sample averaging
+      - 2 # 4 sample averaging
+      - 3 # 8 sample averaging
+      - 4 # 16 sample averaging
+      - 5 # 32 sample averaging
+      - 6 # 64 sample averaging
+      - 7 # 128 sample averaging
+    default: 0
+
+  adi,power-sample-average:
+    description: |
+      A value to configure PWR_AVG in PMON_CONFIG register to indicate a
+      number of samples to be used to report power values.
+      If set to 7, the 128 samples averaging would be used.
+
+      The chip supports power sample averaging:
+        "adi,adm1272"
+        "adi,adm1278"
+        "adi,adm1293"
+        "adi,adm1294"
+
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum:
+      - 0 # 1 sample averaging
+      - 1 # 2 sample averaging
+      - 2 # 4 sample averaging
+      - 3 # 8 sample averaging
+      - 4 # 16 sample averaging
+      - 5 # 32 sample averaging
+      - 6 # 64 sample averaging
+      - 7 # 128 sample averaging
+    default: 0
+
 required:
   - compatible
   - reg
@@ -53,5 +95,7 @@ examples:
             compatible = "adi,adm1272";
             reg = <0x10>;
             shunt-resistor-micro-ohms = <500>;
+            adi,volt-curr-sample-average = /bits/ 8 <0x07>;
+            adi,power-sample-average = /bits/ 8 <0x07>;
         };
     };
-- 
2.17.1

