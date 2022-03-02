Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC114C9E42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiCBHKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiCBHKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:10:07 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89051B54DB;
        Tue,  1 Mar 2022 23:09:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5mV5D8wq7a38SEcR7aYjWKMm8/MaUgoxkABHh89hMcKqLxUYq964DmQKVi/h1EPdqnFuvt0xL8CCNr7YJIJGwiCQogN6xXJQwrayjfwS4oRk0/MwWdyWUy3EcwIX5lMoM3shm5rESD1xE8W97TBCqUSwiVfihiEEFov+9jTJlobAT0XGXvgv/BGYRO49aoYeHbmKYbC+BBTNGtRaMw6W/6qvoAEAg2KQoP4LOiE3qvRe5XFx+JkzXobfCN1D+ewYHeJnx0RixdvNJr+iezbow3112KdyUQplmYcP+ieilOns0ggihrOlFeGcfR8Vh+4iIbmZkGsPAzopyBKyadOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j73LoHFRuf13XQNRyNzYuBLfvLloKfkme4wRXanBQU=;
 b=DbBqw9ONFa29v2sWTJ9Ik5YSjCRiOS+jHngndbsEli2hwhtjBog33x6hjU2i+oHI6mmmn9gpeaveO7QSs/C0XVsljZAviGIrH+DyRc0lAINOgEBmIj9Ro1nUgM5QreePLWgbyxfNxMIfLBmTgOP1KdqkXlvk/JrOqeBeaitQ3i9FXqiKKfLl44nb+6yFqNtogk74Ad0u1vfK7SNuE9zfoubec60caQlGywSnXkrijM3Hwaaukm/AvAI/dBntFCjlifnYPnx5fxKDK3NbwrFDa1GSmQcCkwi0yqlh8TN1qQuWDoOkgQDV6DvcFnd0SQOIzif8Be+7WKoawe/6RUaIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j73LoHFRuf13XQNRyNzYuBLfvLloKfkme4wRXanBQU=;
 b=UlD7Sl08NZwXZFk56Hu2QVE0OJ188xwdZInqmJSb/aurSc6+10kkwqEfAhgP7olmv1vVoHSe2cCppXS27xe5/aeNooeZtl6m3yJw2ZTnpasf2OEe0rx/yz0eYl5s5NUL4KxXP3gmvQjo49BpTcrDhyJgnekYxZQDFyIG9vP2V/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by PSAPR04MB4488.apcprd04.prod.outlook.com (2603:1096:301:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 07:09:21 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 07:09:21 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v5 2/2] dt-bindings: hwmon: Add sample averaging properties for ADM1275
Date:   Wed,  2 Mar 2022 15:08:31 +0800
Message-Id: <20220302070831.23822-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302070831.23822-1-potin.lai@quantatw.com>
References: <20220302070831.23822-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a37c84f4-44ee-4a2a-b210-08d9fc1b92f0
X-MS-TrafficTypeDiagnostic: PSAPR04MB4488:EE_
X-Microsoft-Antispam-PRVS: <PSAPR04MB44881C819AB10FFDB8F19E158E039@PSAPR04MB4488.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHduVs7MwumKq8SePeJv4L4ms5kpJAB6S8WuFKiQ7Ohjsqk2XFMmd0GGhAXaYsQBRB+Re1ACt9ndbe0aj9IPWd3S+hLdlgsF9Q6VFR+4NPlG0cWRbs3twn71b3OLjEsII6OcaQEg3VLcHVYxOJFFllxbfkn/mAidVohf0G/4ElihCH6pGQpXDn6KgNqqN8SL0fHFAxKktOhSsnjRZ54NiJnPI1cgNSqArC0JW2kRoZTAhLP+1FXCPRkjeKrBno/OoHhaqPzoVOCwgj6I5Kmeq4IrSfE2/IcUcAUjXKH+itqMxZ1FTmxKH3UJzKpobZJwfyEu3kXnkST0iL63orn0pgbl+gBHFPLOSct6oYDN6l1nbdFYg/7nCZUMh9m0f7iyyhw+ewfbE7VstwZv5tFoU9RHn/2TP2zYiN6wivPKJTyWNecgdKwCcFnN7oPEL9JrIChi4a7QsPonfZ0BMtUM2GI7It4uvcD6/wDlEL4ciqkdnk0rp/rvwGjMUcvNnVd7I0+HLiibfY1Z907Wfwp2S26CfB2W2z5ImLS+3kPMlj32a7QGFP2k4F2Jsul3IefEry9l7vK7KSBfzx0Fjl3UM2+7MMSeQEAA01vTf4RoRd9CwSRyqs2e/ZPn3CjUnkG8hGCiRl+6ggmT5Z6J0C/7wIuMc5TSbTLn3QLmFDQ24IUqzN1AsBZoVKavkkEQjXNCNHAFyih3/D9UQGVbBexNsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(2906002)(36756003)(1076003)(26005)(186003)(6512007)(6666004)(6506007)(4326008)(5660300002)(44832011)(8936002)(66946007)(8676002)(107886003)(86362001)(2616005)(38100700002)(38350700002)(66476007)(66556008)(508600001)(110136005)(6486002)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OYhcb3d58NxaMuXTw/IZ+Jrs9RSiZZQawEbm1aGjyN8igZU/7RRl3rstRKmU?=
 =?us-ascii?Q?IJbLoZ+lAz1/l+onr+z7/okviMSWx7sWEtXWRu9F23UKV8zG0fEg64L2rZPc?=
 =?us-ascii?Q?PezSkqsFgB/zLdRp878b/oGi3UVKJbHupZKotCOHfsc11UJepHRsMlcQ1YMx?=
 =?us-ascii?Q?RLqFB8Mk1ZsCZepygEsQDvU75+rva6YYH2c5eYiXYp3nMaMelvrrsmCl6QpR?=
 =?us-ascii?Q?35wU+ZlPh46gR0ETCSTRam4YrEmvDbQxPSGhuJsIgcW1bHHtOBWciRijuD/o?=
 =?us-ascii?Q?r+0+dZDXCGmnO4abcNKLkfXbFGv4ponJJoCjK9dnzH3pQINq9FSVFfXCc8ki?=
 =?us-ascii?Q?gstPM99zH0IGwX9Jr3dMucQ4SHPxNU6pJX+eKKBCucZQuDmVlljNEBQETRAI?=
 =?us-ascii?Q?m6WlFa7ji+Imbp4xmTC7wJQkc7/g33clLkXdbh6D5CsWwg8Q78hLULGvMgdi?=
 =?us-ascii?Q?jdg2RLdAqfVSuRTR+QqhrsdapkQ2xsM6yaPqQxevDdnf0a0vNpOfkfTGv0rT?=
 =?us-ascii?Q?wYUJfNom10Eu/nGqY2P9yBksER+bxnGkDaOZXg4OtQPfpEcePNh1W+WgKE0B?=
 =?us-ascii?Q?eWOAKbcR72GBMhXeItpSVIF5ZKER2TomFr909AyKd+Ajp7RB9xycG7nIjuNP?=
 =?us-ascii?Q?W7gm+6+ovGTgYRUcfobGrJAAU3Ax7j9ntYUzylD5PBB87Vhbr8eM/848OM3G?=
 =?us-ascii?Q?pw/JLy1W7HO+5LgCdtM5WTBrUEAettvykoG2qet77/bGx67rE7DuJXdGxO3c?=
 =?us-ascii?Q?NnMQ0JvbqjretmgzMmOe2xzVZA6n9RfcoqMBcN7L9Z8edtHnnK0xrxryKFkJ?=
 =?us-ascii?Q?8mxQFle1ZforVOigDgSOFat1lkVkWMSiou90IBzAgoKxa7WXv6fbBAfl9Bf3?=
 =?us-ascii?Q?nWag2iHbFhZ/jFcztCSQ8v/U63hRyVFrGwXMzMyBTz29o0TZpeTuZnfuzpEC?=
 =?us-ascii?Q?Th7zyKWM2apimn4V5ozRlzpzwiZRstW+p6sKRKibjT9wvkkPQ3maIVELraAo?=
 =?us-ascii?Q?04+wRxJAQSPn8CmuNn+gSWT7+VgBHssa9YhzgZ2kHepOQNtEce0C+AVu6Gdj?=
 =?us-ascii?Q?lSMYS5Sp7qFnpb959o1aAJk2+1bE2vta7OfFVtUiyz6TkjSG1ULM5QzXp6NH?=
 =?us-ascii?Q?5NJh0JBKE0K5vrmaEOqudz94oTOFOYr1xYZ5VpjSqiUrhdyPoYakS7c5jjbc?=
 =?us-ascii?Q?3wMjSRLwXHFCSRtwITWcvgrNcL8CaKmdwJqWTDHk52ZcSvfEFN4XxLGlRFWA?=
 =?us-ascii?Q?Q31vAt7rnCj0u3YOPp+T+DbPo9gThYd1AE02exqIF+vye+I3wyAswDPrWwaz?=
 =?us-ascii?Q?TA7ZQO+kBeirI/THIN9XBLr/FRQI4RC5ktyfu05x1tOkWKV5X3YatuyCnr/m?=
 =?us-ascii?Q?CaNurkdtMN50ZeWf45EA3MOwqxqQwCQvPCku5k9mrCIj/M+/n7QuZAEqPrMI?=
 =?us-ascii?Q?qu8jp0rrfUSrapRlMl0tLO7u8qgIymPMvH2cmEy00K1We2fhk8v5JNYzIqc8?=
 =?us-ascii?Q?pv51jAok7Dnpz9/iUfYJA2jNiOZXqLq/98/AUqDvdokmf6WTLyz0GR2M6D2I?=
 =?us-ascii?Q?OXyAjRv2u1z0gFwc1sTbuRJ5MnqwD7RclPG//XxVTXBj1E+5gqGOJO9eskGB?=
 =?us-ascii?Q?JMV61CpPfmdIQz7s+/KPymY=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37c84f4-44ee-4a2a-b210-08d9fc1b92f0
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 07:09:21.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu2BZ9jNzhRPWaKQ0LF3xd9D3tmu1kxxRTI1oV5Tx73+TqK6QJi/ybuR4QyJHGhtnX8WtF1nWkjqbnRUqVdsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4488
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of new properties for sample averaging in PMON_CONFIG
register.

New properties:
- adi,volt-curr-sample-average
- adi,power-sample-average

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../bindings/hwmon/adi,adm1275.yaml           | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index 223393d7cafd..b191abddf20b 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -37,6 +37,72 @@ properties:
     description:
       Shunt resistor value in micro-Ohm.
 
+  adi,volt-curr-sample-average:
+    description: |
+      Number of samples to be used to report voltage and current values.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+
+  adi,power-sample-average:
+    description: |
+      Number of samples to be used to report power values.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adm1075
+              - adi,adm1276
+    then:
+      properties:
+        adi,volt-curr-sample-average:
+          default: 128
+        adi,power-sample-average-enable: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adm1275
+    then:
+      properties:
+        adi,volt-curr-sample-average:
+          default: 16
+        adi,power-sample-average-enable: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adm1272
+    then:
+      properties:
+        adi,volt-curr-sample-average:
+          default: 128
+        adi,power-sample-average-enable:
+          default: 128
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adm1278
+              - adi,adm1293
+              - adi,adm1294
+    then:
+      properties:
+        adi,volt-curr-sample-average:
+          default: 128
+        adi,power-sample-average-enable:
+          default: 1
+
 required:
   - compatible
   - reg
@@ -53,5 +119,8 @@ examples:
             compatible = "adi,adm1272";
             reg = <0x10>;
             shunt-resistor-micro-ohms = <500>;
+            adi,volt-curr-sample-average = <128>;
+            adi,power-sample-average = <128>;
+            adi,power-sample-average-enable;
         };
     };
-- 
2.17.1

