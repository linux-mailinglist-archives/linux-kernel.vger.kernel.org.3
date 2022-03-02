Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D44CA500
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbiCBMmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbiCBMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:42:11 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1616FA1A;
        Wed,  2 Mar 2022 04:41:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF9ZPd1X7d5ObMul89/RlytARNu67bbUmQf/b7cqA383vuBl9gQnuxcaNzd5JgdkBRgGYBkFPmfczg+Uyek7k/W2IcY33dQToFuFGFpXSxZ851lL6E8FzsR7wSSkC0qhpPQEs0lH03vJEuAg/ytRAoOsNCVIJ10Jgg4pAgsBjoOxtWJ0tI3KzHRnBgh1/hj6bNQO+yOqSERYz2LmczuPWtyCdG0baT9IVmT40b1VoR68iLnBbx+C1T2AgO0bXHtjD7fkwF+SNavFvwLbi1n1sGRzJyrjhdbE+nnx5fgQ5mm6YyTPTCBm0SEJUKjaaeu7V1bqaP4mj5W1CBpTL2pFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeOU5wfAlkDlgYBRAJghC88isDNKPfhyLOvyKVNU9Uo=;
 b=g4xezQKsXcFMf/ewscBDRajs57KROvJC0UfTVb59D7BO/rFXX4ld4C62xau+R8o6WSXmNo0J4+HPBChVL64HhWXsR50XEQoSdfAEvuymLXsOiVIFo3zhuAxUt+ecm+d9Pldb4ULXVDadalhWuzsmniI9aH7dqCxISLGd9rX4hzfJXyKWGV64Jimkctp/ehhTuGbXooiKtdfS47Vnm6rQOTlDUVeBI3FpzVkfCFGdX+zTHlqJ+U9c3wpE/DZ697no73o9itKY3ZEmyml+BCH33AuDeh5q+ZS5ZeDG7O+beHb2XJQU6x06ZHtKCTzfKpCkyov/W9Hm2SOiJOQKEJ9Ejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeOU5wfAlkDlgYBRAJghC88isDNKPfhyLOvyKVNU9Uo=;
 b=WuT7UjlyZv3KwjQSqLuQWpe1us8efPyzITX2jo3+eafarnikxLTe+NVB3vmm5WNSvCaxOywrV6M6oqdDXhKhr3pdMXyzj6TAC9CzWiFfbmISdU6ue9S6wrKtKQyAD/dJsHF+qY0Qf5AOzBWmk216LdSa5Q11EOPFultGUUcWrpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2689.apcprd04.prod.outlook.com (2603:1096:203:60::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 12:41:23 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 12:41:23 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v6 2/2] dt-bindings: hwmon: Add sample averaging properties for ADM1275
Date:   Wed,  2 Mar 2022 20:38:17 +0800
Message-Id: <20220302123817.27025-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220302123817.27025-1-potin.lai@quantatw.com>
References: <20220302123817.27025-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c167d731-7286-4858-cdb9-08d9fc49f5b4
X-MS-TrafficTypeDiagnostic: HK0PR04MB2689:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB26894F44C46478C01B4C13D68E039@HK0PR04MB2689.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUPgMQUIZ6V2vBe3fYaPqGANqPPIiu1+2qaCsbfyNkAzFqQVRILpbBnuIgZrsQWF5pd7S5LIbCxQc1YayBJ0gVLW+rRSCwLRKEYZXk7zgnX9NcJ7Oh/ye1DSIADv+OcM+NhI5ZeJPkTSW6mdfvgeP47UM4ycTlXJ6C/o0rPI/bQ7P3DFPZsVfr/hhNJd1vYKM5qpn1CKYquUs7JG0kivoxS35CZbNzQmqqGbxGS/yNaeGflAlnG/G4ZvnXNqtsbscChHQuhkaNVDvZtjCQOVgxcxPJCNLauvVztKBGa2IN19TyyG0GaClC9XzJcR+Pmf0zDALEvJh4+vQo4/crpnRErVeRxxIK4qpCkc88vCr23A9p1h1mEhr/VMj+ybfjL/TSggPTcxBDO4ek5DbOJXwUW5vtLEgKEuMLYhG1P5iHVaBnUTQpMQQ2Hj2HCLvBM/X4EOeomYpEE58bSv7EixTLYiKzRC5EcCDSMRczEyJrqIPXwWJSIqyP0vy0KWdZ5WVgochvYNhP3K6nOC+NezWmIzFfOPjz7onQSLdMEXsaoCFK5X/sVIzwLkRcsM2Ks2eyavf7ZLhAJIBjFTB/10ePVZgiTTUT5I6y9OlA0LOlwupjEEfkjaafgyf/Yf3cHTIBJnGrM3lZOffT2suIXHxreiXFVgVLueCOJ6KaNQatwL9A8E2u5htHoRGWNBAad//fIy8tpBvv0XaU6vt9Wxvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(110136005)(44832011)(36756003)(6486002)(66946007)(6512007)(186003)(2616005)(86362001)(1076003)(26005)(6506007)(66476007)(2906002)(66556008)(316002)(5660300002)(54906003)(52116002)(6666004)(38350700002)(107886003)(38100700002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fhivy3UYPHf9ppo5lMAxwvqJqrwTi+oTDXlrXuA4VkCcZvbcU5gyOcgS8G6+?=
 =?us-ascii?Q?Nt7jvLwP3pTLHYU0Mf6hSzUweUdXTo0M18T19N76Kduug7ybdWSeL60H826T?=
 =?us-ascii?Q?fFhZm/qTEdjDQuWWjXV+m2ydI2KRLK2V55YdmFZ56Rn+0qBmLl+78YK1dCB8?=
 =?us-ascii?Q?YU8EcR0woQsMew5FA+JT5QbQS1cN9D2lNwcCU3xUWrShZwsJvTrgzyVPOq/N?=
 =?us-ascii?Q?Maeos0Xifa7IxVU0J35bmYH/IOIIHpGklUG7Mek2sFtZzen6qo99qSV0sZ8m?=
 =?us-ascii?Q?Nc6FeFE23WHzBev8SEbbEl1LHb1kYu0Iqx1QZZSvId335Jos4WzSgCFqKslE?=
 =?us-ascii?Q?ZL0/MjnVfga+k60l8oNG6IUb13JkRoZW2Yfb/XYptxLKXJ64mBp1f+2fPsk+?=
 =?us-ascii?Q?tKmcSdTaXhOHv6MrvlUySgBmcppo5A7rFxOkjkK7Gi27U4jqdkidVR9UYEA7?=
 =?us-ascii?Q?MZDAK6K/Wm7+Vegfi0mjvh8gkkKS5/NQhkxWqAqfFoDRHVksVqcaN/jx2HrR?=
 =?us-ascii?Q?eX3fKX8tWN27hV9ssiB9X9al+gn3khAEnqIaIZWKAa/EdH457d/n5IU4qbmo?=
 =?us-ascii?Q?mYHV6u8JpAM6bnLtQwogcOSgnC33ZM1i+uif7L+uNPJUjieQALs+wVwWgcUe?=
 =?us-ascii?Q?l1YIOO55ImINLdC1oh17jy8eL1zMNrQ2rMimKi8JWIWWlLLRIMCoutAr8wVU?=
 =?us-ascii?Q?sbCzsoCqaJzgly+2rZegk89tGy+bLr+aJvvgAec8ibII55WbjJHXCvWN2f2b?=
 =?us-ascii?Q?BzH3dKvdM1ub7syXEr9ZqLDZmDIcxcCgFWdp3JVrXBWydFAYZaA7gobf5CYG?=
 =?us-ascii?Q?6L6EdxM3xak5Dt5oNxOLEsLL1JWgyblLnoHtz4sxWenWGkoKDUOtMS9hAoK7?=
 =?us-ascii?Q?3IQKr2UHBnqaiBOyLi/tJJFvrfwbODM6jlSQ2c+BlctoMfPuzVP5noZaMCbp?=
 =?us-ascii?Q?HdiHNtoF/snn72adVmM81s+gFns+7yCbXjyUQgQMonblG7YvQ6ry1EBeyhnl?=
 =?us-ascii?Q?Ss3PD42dPPZ+QverMfKZa8Iys4hcFSYueELQBK+JZ52MBN9hVM/z87WEz5yp?=
 =?us-ascii?Q?pb16CgavsV2rlnPY4BpgKEdknBpuEKpyrUwnXcSh9TfscqIBYgqfhPCQU9S0?=
 =?us-ascii?Q?6ciJyhpHK1HfqJ4RNqoWZZoypGNMBU8Ta16nBewC8fOXZt5SYiF9r4q7wFjb?=
 =?us-ascii?Q?ihbHjIGH3DxppFhf99iu+D+abRlo5GSaBjm9tYy9L8QFMTGbxvgHeCdguDWO?=
 =?us-ascii?Q?ggb7Y8GODWwcdBZf2uFm7Wu3PYlU/4V3pN4LJTYd+9INLMw0ktjpOeFWeJbx?=
 =?us-ascii?Q?GBw0W4Y1a6wKHbB4NVzUeo0VpbkSNMn5w935toXTfL7r+EwD2WmPrRZKaAbG?=
 =?us-ascii?Q?R5+o4lO78MHUCyY35uLn93AjRftj3ovOcX6D5DP5N2hODZWS04S94GTjEQZW?=
 =?us-ascii?Q?8otjoV5tPHWdN1lCR53wMDGhxVYjgkcQFS1Sh4wK/rtv0Stsz7fPsHbAVQJX?=
 =?us-ascii?Q?7nU4w79AtBQyUP4MbFf1j6XcouolsYdTk47Zr16aRHOYyQ2LNkZsb08owz9P?=
 =?us-ascii?Q?ZnbppDnTUtPOP4gJa/GGWgqQpr8fLFtG46aB4Vc9C0kLXwhI8Cpp9c8It8OF?=
 =?us-ascii?Q?u9Q6TCSpL8zWBnKqW+DDwQQ=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c167d731-7286-4858-cdb9-08d9fc49f5b4
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 12:41:23.6121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hc10JF6k+URjQDmtv3/4+afPMisXQBC7Za1BOGzCSXpCJeGhLoRHpWLuIq7suYe+0f3brEZ7JjnNWt6I2EwQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2689
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
 .../bindings/hwmon/adi,adm1275.yaml           | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index 223393d7cafd..ab87f51c5aef 100644
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
+        adi,power-sample-average: false
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
+        adi,power-sample-average: false
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
+        adi,power-sample-average:
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
+        adi,power-sample-average:
+          default: 1
+
 required:
   - compatible
   - reg
@@ -53,5 +119,7 @@ examples:
             compatible = "adi,adm1272";
             reg = <0x10>;
             shunt-resistor-micro-ohms = <500>;
+            adi,volt-curr-sample-average = <128>;
+            adi,power-sample-average = <128>;
         };
     };
-- 
2.17.1

