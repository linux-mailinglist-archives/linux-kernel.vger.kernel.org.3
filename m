Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F84C672E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiB1Kif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiB1KiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:38:22 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE0034667;
        Mon, 28 Feb 2022 02:37:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdpbbpAgX2F8/UFSejwk1qsOlst34Wx82F0/8tFs3RlFjJKijVPNUzHHKZzGsd6h2//k+cx++9qqe/jNXOb5AWxKUvb1si4udgs2KfP1y5PyQwvNNB+eGYwYu4g2a9cmkf08RCQwwaCgh0MtYbm6R9r7hTmqlN9VnPWtaqlsLoDhBOKXIWloOcy384orDDtimCKI9EQPNgt0r9e20jLnm0USWjWvRnxM9uUPnaX8JHHVarXyBstHkqIPV1pWkfxhjGm3yp9txM8s/kdznr59Wv8riyxAUunUqeHpo1CfLa6EV9QcDdehOY3JVgvIJmSUCZR786vgtMF5fW5qtrFMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2WkNKQyC1ZXnMFZ9T3XTkRPnzibQht85VTocQhwvZ8=;
 b=cV/zanf5HeKYMkUGNDEsV+YlkIDXnX4AFMictdVI2JKvJj/yKBjsr0kgdtPksweBx9x6RD/6KQcg1GVTMZLG+d7Flzkz32lQbxxMolpWS21w9ytFdkPmSyIma6XLbXTkXZoAZdlEe3Q6TtoQESQ903GCN/aKU0ZXwh/i92fVV+tt8WimJpY+sTtV9oKIT2hi2FIFL1GWDGAXBZgW6jfEl8oDl4b/Nq4E2cpoUFHOxxgTCCl1UbyECDJfPWAEJZbA04QpjMSCZZzGnPr1UtaJZj9BVGuIBM2laZBVYPPU8FD5VQjfBiqX9P4QSW3lNENYxLFGsJ8Q1apgzNfuvWqYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2WkNKQyC1ZXnMFZ9T3XTkRPnzibQht85VTocQhwvZ8=;
 b=fMorruJ5KNpmg4BqIzYl173wETHdpMOrs+jOU7oH8qLzD5R7kuub7yC/QLIVeopEdUHS5oS6khjr/gOCll81YZjxH7gNOXTq9ELziNExOH8aOtJzG+Fy4+FuyyOHw/z0EIJ78+nYAElXx11aT/dpVopqdBLzLlergAh/8+TxVJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SL2PR04MB3002.apcprd04.prod.outlook.com (2603:1096:100:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 10:37:38 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 10:37:38 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 2/2] dt-bindings: hwmon: Add sample averaging properties for ADM1275
Date:   Mon, 28 Feb 2022 18:37:16 +0800
Message-Id: <20220228103716.10774-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228103716.10774-1-potin.lai@quantatw.com>
References: <20220228103716.10774-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f08a110-ea88-4f92-c92e-08d9faa65707
X-MS-TrafficTypeDiagnostic: SL2PR04MB3002:EE_
X-Microsoft-Antispam-PRVS: <SL2PR04MB30020056B224D76B707C8D618E019@SL2PR04MB3002.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYXVAu2VuN8Y/PCk0n6oVc5p0zZ5pEtzGrInmYlnClHsMxNlvsRBNcHRuOsO+pudukMx7g3TinmpNjzHn/gy8xX36MhgU/fnz25H313XtvDaQuG+QVk/cixDqcWSIWpu4StixTKfF9CJlzppe2uF8ML0alLzj9T5XL4meALBgGjEtIeJc7mSndlURYuh7b1isWHPmH/8Wqfhg6V09bbNhwlu3Eu6vSo+wfYF5h8+UBOcsF9M6A2F93DG/XKXmg3om4t+wJ4xWbsLWZoTuA3ihP1U2QhRAhr2/jm8tExxyG3xJNeXGTqc4R03Dm9QD1K/jwifX6hzLQd6jHxN2TptSVlKm14C9RU0DfGXD0VMldHCRYudNq06a34yeL0lVTPVvB8ISe9ZSm76KXqAvAR2FfLBo+G4hPgTYgeMpQ/xmUPI1XGs/YjPXRC1UlUzRhPL/CKTNm95w191UScAAmVMrMI0Xj3PaCVBC/bFH6h+iAYIhZrh61NYcFoiG590KxZhzKKvxTE4kqdL8QT33nevR1FCvGXs2QbhCNhLnaY6HNjzZjMIvn2wIUojE2lbKXVCFATeSTmI+QwXCz4CF68GtemVjoOqzBtgdAeR3e1/jguo5AhigL4vXWM/lMpU3j1zjTfjj+H4/z3oZFfPIPE9e1/XGcQmZhwnznyftNxR+L7y6AUHdNfQTn4OvDW1sB8zHZxrXycki52tc2vwoD7jSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(86362001)(83380400001)(316002)(36756003)(4326008)(54906003)(66476007)(66556008)(66946007)(110136005)(5660300002)(6512007)(6506007)(6666004)(52116002)(8936002)(508600001)(44832011)(107886003)(2906002)(26005)(186003)(1076003)(2616005)(6486002)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vKeibPEBCWccnmD1EDRnhALeV8GosVRx4gDxHl0Wmwd2iqEvxxxUBPAnIkvR?=
 =?us-ascii?Q?ckguilyuYrJR+49UcQ35OMNXUCA7sOtElQoz9iDOHtMEK093EjnS0Q8eYfa3?=
 =?us-ascii?Q?lBdvMdn9EPDG1TRxZ7q3Lz98jQOEFadbI1X42gVe9wXxjOH/G1Ukj/1ka+p8?=
 =?us-ascii?Q?VBRm9PJhW67Vm6aSZpeaOvDm5zjQ4ErlEp9l3eUamywWJbsr0/yGFSUg9qe9?=
 =?us-ascii?Q?LeNHnFijDCNwHPFO/O0DjqJEGjGT0ADynk2b5QGtqtt9ROmCndCaNV+khO4z?=
 =?us-ascii?Q?03RVFZVjmvAZtH9b9VNFyHEw5+KMspm1Q8ADwX3QijMOKMcOyebNI68hfCkU?=
 =?us-ascii?Q?5BEkpOp+MWyIINKNZZoAbjYqarRgdVaGGiGpXpBRkRqz+TxIqgxCmvEIrC++?=
 =?us-ascii?Q?le4HwgOJB0hbv21ZJbUKOCx0YhkcvKdQXSNiyFcCvTd+lnaZKA6MkOhEwOfv?=
 =?us-ascii?Q?uLRpCbn1/Ukuz/jlhpqrJU8Kd7B2yhQOrpVfP34vL56SDt45EsArzjH+hs+3?=
 =?us-ascii?Q?IW5OIP4aeWVPoceMMz9YCVZoO2jhx+A21Upe2QONSMZcLkRhSRpqmitoUz29?=
 =?us-ascii?Q?j+6kOKlZ0Z7wOKtSOJMO7GbYdXDOx3BbFBJG6nYcDVvXw2SaSrnlnQScVsay?=
 =?us-ascii?Q?Ns30h9ZQ2of3IqpJdvh12PHomi4rryTsTzTsrC7A3lokQgc6h+EeuZGcx+GT?=
 =?us-ascii?Q?zrm1BldbUGHlCRQtN/NszTd1yiTO3bPnlPYCcLzpIoa0RrPPtPjfOB26xihC?=
 =?us-ascii?Q?pqxe1ehZ9aPGzyBMM+xVvhrcdb61i53SjFUkdKc3fenO0CN78JsP4DQ7Hzm5?=
 =?us-ascii?Q?hoF/SqOCB7IbLz0dSpHkPgK8u2HrxhPS51MRec5Z7xpqwxFToRmsdDRhbEnN?=
 =?us-ascii?Q?JWv/ktM137cOCqY25yg67Z+kjmo0z39MAGFv5N401+28oe2T30Y3FCShAmFk?=
 =?us-ascii?Q?SMLppcFnpreBdfbMaM+d6OgcXRzQsZnZX9TUKhItoHb6++wB3cbVI2655sed?=
 =?us-ascii?Q?7yrkDaTFboUDyxlLyFRvf1BzMiD7BhRLUf48YWVIqFKUO755Avz0LDhmDCwY?=
 =?us-ascii?Q?jsj6nSuSkoQOh3lx4Ex74DVcWjkOPwvPTdnLlz2Q6hSg8iSfQRD5Of+vhiGJ?=
 =?us-ascii?Q?G8YcNHGsOzL7VjvgsIrZfnWamLOGh9ZlGZy8/1qnaOCskh00NE3fBtOzQfa1?=
 =?us-ascii?Q?wWD2+vOdIW8VEckSJFeJRG8lz4hzcoXywxNcJZnFHJWKIBuYN9GdI4667utY?=
 =?us-ascii?Q?EW7uUMQnRU/tiWnxcnMpwi1hurg/1sxzLjLjzprV1T9bOusDAFSpldw1ZSlD?=
 =?us-ascii?Q?82GlF/PnxHnLUnY11dND8Y+ZVSvEihjXt7gjG8imOR5kPalS4yTPKX43UKcL?=
 =?us-ascii?Q?eUwWI1fmEET7pmhKj/EyBnoxhkt7EGYwy6a//eCMSzbUuPURC6rCoYDYhC7O?=
 =?us-ascii?Q?UuzfEB5kQoAC5GvqWnCmGIKC92iEAYf+huXqWUGmaVIOaHbJb9kq01gXBqkr?=
 =?us-ascii?Q?d9gLN/Rm4nWEZwDS/03CiPpID4nNLJX5+uRwRIog7z1QwxuP4xWRbRfFnxDQ?=
 =?us-ascii?Q?hO1GNDpxUD8n6CowMaq2SiFRWDP7UKCp/dy+LXLxlFzIpNPY80yn22ufjpvq?=
 =?us-ascii?Q?PM0J7n5LCORroyDMf17Gp28=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f08a110-ea88-4f92-c92e-08d9faa65707
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 10:37:38.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HfP1AiUcebfVCyLfc2pHzu/mc4ykuUXvxoS+ExS+FpEbwTdE2asjbPgO8iH8VPTVtKD6X/ddfsfJr1mmk8fMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR04MB3002
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

doc
---
 .../bindings/hwmon/adi,adm1275.yaml           | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index 223393d7cafd..bc4206b257a8 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -37,6 +37,43 @@ properties:
     description:
       Shunt resistor value in micro-Ohm.
 
+  adi,volt-curr-sample-average:
+    description: |
+      Number of samples to be used to report voltage and current values.
+      If the configured value is not a power of 2, sample averaging number
+      will be configured with smaller and closest power of 2.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 128
+    default: 1
+
+  adi,power-sample-average:
+    description: |
+      Number of samples to be used to report power values.
+      If the configured value is not a power of 2, sample averaging number
+      will be configured with smaller and closest power of 2.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 128
+    default: 1
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+          - adi,adm1272
+          - adi,adm1278
+          - adi,adm1293
+          - adi,adm1294
+then:
+  properties:
+    adi,power-sample-average:
+      description: This property is not allowed.
+
 required:
   - compatible
   - reg
@@ -53,5 +90,7 @@ examples:
             compatible = "adi,adm1272";
             reg = <0x10>;
             shunt-resistor-micro-ohms = <500>;
+            adi,volt-curr-sample-average = <128>;
+            adi,power-sample-average = <128>;
         };
     };
-- 
2.17.1

