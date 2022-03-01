Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CE14C8976
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiCAKk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiCAKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:40:22 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48D593B8;
        Tue,  1 Mar 2022 02:39:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmDh0I5a/LvuSDKm3Mt82aCR8WOwTOlCSse/cx8kSOkmbLrCHOqktcATX49pY6ocmZ1lb81tS0T8UScKiGxrfiQfQc32T7xE9mrOS7/yIQONxEq8cCVgTVHoAqgHP7yXh4w7mPkTndStVTKQ/2GtZt8NkUw/s6MljV4T1uJvkKvc9fkAwG8aEcrhyhFoVSX5XUY3JDoKPFvYYFpaklo1Vz01cVvJm04bYbVlKG7SroAZgFqilWCxHb/f3jkpXjW8Huj3/dBzTyHDdVUJQ/hl8wEnTwRvaOls5OeZSo4HNuIX07Lb1O3zpCJrdU4WHLNK7XZ7iIGf9yNjbbDTuL0qSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy4h7GbVHqJlb6gex0kd9iCoN3mDmgwQF6Bkk5v4J4w=;
 b=FcjqDbNOX3tP+zoYX+W+c7JAbfL2wxGqmNfBEk43p324ktJxyV1itylSFOY5p1c2mbiFuoIqvIXp6omQozwYDwlIatE61VO8+Cya79JlIOebRpbDlErKV4NPbHooCIe+YBWZgE4ij/oMGJLzNLZn3kxwo4/Q8PpuR6DSOMbp5JRHCI6V+CME3f8sBXAOFLdcFCKh0lwhMcnnmhVGCdlRS415738TRfzHqmRA/M8GjuP0Z2t31cbEzePCwLDY3l3BVfE8ZjoemOHsrceGSchhXFJcVfGA3qhptf1FB+/0ZkkL/DKtUwHOHcD5Gv/Kkwde3cRnmuRqtC5NxVZakEq8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy4h7GbVHqJlb6gex0kd9iCoN3mDmgwQF6Bkk5v4J4w=;
 b=Z3nV9FLrSHHqh/V496hSN1hWDBr5Nyx9AqQ6sDjs8gHTRotNmCNdXUdMjaabwjuwUQkSOqfDIfaDIJuNDxdVe96cX/V01iLSyVBwWwz/CyfCvM95ypyZCPpbnZDVBh0INEFFECGcz6zqxmeMhV0Q4xk8dfenzZYA4vndcdR899g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYZPR04MB4925.apcprd04.prod.outlook.com (2603:1096:400:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 10:39:33 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 10:39:33 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v4 2/2] dt-bindings: hwmon: Add sample averaging properties for ADM1275
Date:   Tue,  1 Mar 2022 18:39:00 +0800
Message-Id: <20220301103900.12637-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301103900.12637-1-potin.lai@quantatw.com>
References: <20220301103900.12637-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ead7a7a-3115-413c-d7ca-08d9fb6fc5af
X-MS-TrafficTypeDiagnostic: TYZPR04MB4925:EE_
X-Microsoft-Antispam-PRVS: <TYZPR04MB4925A6A3CE036104A68A4BC08E029@TYZPR04MB4925.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQuqxT3mh9Lk6iSbUvaDSWfgUBMRa0nm/Q5aVvBWz7o9nZX2UIi/dX7PEmHlZD3zbtQz/DPZzfvJNrCY37/lpKEgfRoExflv1HjqLELjVepYuIL4j+pKMXsl3VKGHbeQ4GUCemPfhej7MoifJ2RNOjplpPxsm4qPViITMZdza+AF1vsLkTcPEdzYq2Roibp+6u5F+414A7UAPTgNyu2F+h3OxKCHZxb5Lwq2uNw3HdtkNYwnTPspubzWEkn3Asq2G2LUjMUQt2gI1pqY4VAV5INPra+p8gQPkDOvUT9XCCkj4HkqDwvBpTnlcw9zOcgrA48K/1DTFaDbryZFiWRUaOeigXF0dmTbX4QAxgIumtGThCYR/NFovhg99HlrTpRJTNQZw/oGAdC4F9GmhG9vQ0ZkNeMvr2bznluWVSvro66DbfWvb3qmWsVZTSYV5Qp+7F4cnXbLHNbcw6KhX5CMp64IBxz94dPQW9v49IAeQhvvHdhXGpXl1+SH6W/qlGDopQujH6Bq3KBLcEeK0vNxnnrVSMnMpbIZltHmbmndqLAQWHjpeTiz0Iub+fyfRqtPsS9HuYzdQJa8A1ie3pHcHayBuf1kE73wyzoHvp8kBSsYPPnGJXMmszOFwLlW98njuOfqU0sRVcH9bYMyRHcgHENC0zDzyMei+KR8JN/vt8Ayhqk/qUqvfN4chU5vVJWRQ8LfdkrbYmmiszZijAN2eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6666004)(4326008)(8676002)(38350700002)(52116002)(36756003)(6512007)(508600001)(83380400001)(110136005)(54906003)(316002)(1076003)(8936002)(38100700002)(6506007)(44832011)(86362001)(2616005)(107886003)(5660300002)(2906002)(26005)(186003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RejYNmZv24Hx1O+Lkk+KlNL0Jd7Adyjo2n8UE48GltWwsQzYtKJEjohGMNVD?=
 =?us-ascii?Q?nkCKGBIMABkj0iR6yON3MLXihT7a0HTedQY/vExszO4XEzFv6rb3ypHFc8Vt?=
 =?us-ascii?Q?LvFn5PrL1bImXwgvg0zvvSHByZPL68FFXYX/8jVZqswemcVtrDhrMe/sXTcf?=
 =?us-ascii?Q?xcVO619L644ziYo9d4K2l3IqAgkXmxsZ8t75AZW+wTdJzo+Q28dO2v9tb7o7?=
 =?us-ascii?Q?UnrHQy4Q7UUB+gf0MUFRCX07jCMvFfCzbYUYQ2h41Z0kd+C3GBBYUFTk6ob6?=
 =?us-ascii?Q?NeAkTdie2cnp3oKZxvx4OnFAcn93lFTnUb3YBstp3puznL3qSsdN5NbgRJnh?=
 =?us-ascii?Q?f1oXSPadXN9jfSqgrRYuPPHU/NC/XxNuPjPDQ62ThXVWetKU0rF8RoILmjiw?=
 =?us-ascii?Q?/yBfTjPdn3U81N2gpT6PWeAlrtxyRxiv5lxgLruFW/l76VYItmqDP06jvGM4?=
 =?us-ascii?Q?/JmT1kSmIUoQ5BnBaY5MPYNImOl+/neeG18BVmDktF4ly22IBTj8i67MY6+K?=
 =?us-ascii?Q?JbRPzzYcUhVOljK7U7fo9Gn0IAhkd4zHPAIpE4LYg3pK4nQ3rFjFh67Nq7Mn?=
 =?us-ascii?Q?Xy8Vlsxn87PZpcmlJGo+fYHvNZXY7fRTFAub4bKfjFiSjFYMTYTrkqYlxLMu?=
 =?us-ascii?Q?QLVzNxpPykf9Fwh0r6qA+lQgu4UNu/mmKzNNZ+sHG0qFrkgwdtSIQ8QYz8jv?=
 =?us-ascii?Q?1LkyCJEKssAYgfWzhsK5bxgcnbpPSXffT3tR5DJ7yiyr8HImH5eb0yqjrDZ0?=
 =?us-ascii?Q?KZfmSGgp6BlSKaA4OClxSX5vf5rNYl3AUjasD3GkgL0N9d0WmvfUD4aB1fN+?=
 =?us-ascii?Q?0NtMfsCD1FfCeusGdGRgQZZgY0zuW2WrlW7kkxJT2MgrUTkcY4JUnQN9pHcj?=
 =?us-ascii?Q?7k0kmcUinBQjgEbE3g4ZBl7bRxenQvDn6uTi9lXL4NQN4rmtAECfUj167WNB?=
 =?us-ascii?Q?QxLS257nTYpGIq+Z0RENqaQ9FXoMbvZsL5s5zHpSsID3Fo8d2lmGDYESuOmY?=
 =?us-ascii?Q?crQpSjPe8FblN0nY5z9cKAStDygQB4NiRHl1DJTuhHa/0WUsutJJQLuiG49R?=
 =?us-ascii?Q?HM0iKoHnF+tE+SYq/GW5zOU4SVSYgQPna66bjwV8LMr9kJsy5OrybeBq/Snv?=
 =?us-ascii?Q?FReFqXSzctR2lQqXwNf0B6DASGVGTaEl3Ym7vK4d6uve50j3FKQaxcST+K/4?=
 =?us-ascii?Q?/uFtEqxoIREoGhQEaOVmTHDQ2Udabqzf0pAk/qFCHGH0UZuCqr1yNUZZk7h/?=
 =?us-ascii?Q?2/pq3SpXGukQPdY0URMnA0IsIun2G3q4WXWEBATYvEamCHFz4ICaprN9XUSm?=
 =?us-ascii?Q?qjZz69Er2dPQkJow+kPejUGA1Xb/7Pz0OuSUYtDD0AWLPwajUEBDW6tKtzKY?=
 =?us-ascii?Q?nud+LWdbfgHqrkAXELrMr2+6zyoEyNc56i0jR+nCIyMosDe7hSleYQfHCpsz?=
 =?us-ascii?Q?yguuTVv2UDY/g7FQvA7zjV+y03JadNKKPd0ogtAGE0hhQMVKP1Q2R1Xxs3dU?=
 =?us-ascii?Q?GGobEyAiEcAOB8obWT8Y6l2f1Qbo0TOIlN2RS8vsSyuWhXU0G6aunpC4Ir/4?=
 =?us-ascii?Q?NzVYsOzcMGP5zMQeqmWHUkxP+KmN1a2KsWlZ70QGrLjLwnCe9rEetQZRTwhn?=
 =?us-ascii?Q?UuRK9xWCLJTArvfQ0xP/ItU=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ead7a7a-3115-413c-d7ca-08d9fb6fc5af
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 10:39:32.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbyJqc8r3xHPKJwu4K9lbJJ9kT+4RQRxh+9jiiznCaphYvU4m5Av/FqddvTF3S068KwkZKkaEvKUHQEjnxcNoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4925
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
- adi,power-sample-average-enable

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index 223393d7cafd..1b612dc06992 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -37,6 +37,47 @@ properties:
     description:
       Shunt resistor value in micro-Ohm.
 
+  adi,volt-curr-sample-average:
+    description: |
+      Number of samples to be used to report voltage and current values.
+      If the configured value is not a power of 2, sample averaging number
+      will be configured with smaller and closest power of 2.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+    default: 1
+
+  adi,power-sample-average:
+    description: |
+      Number of samples to be used to report power values.
+      If the configured value is not a power of 2, sample averaging number
+      will be configured with smaller and closest power of 2.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+    default: 1
+
+  adi,power-sample-average-enable:
+    description: Enable sample averaging for power reading.
+    type: boolean
+
+dependencies:
+  adi,power-sample-average-enable: ['adi,power-sample-average']
+  adi,power-sample-average: ['adi,power-sample-average-enable']
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adm1075
+              - adi,adm1275
+              - adi,adm1276
+    then:
+      properties:
+        adi,power-sample-average-enable: false
+
 required:
   - compatible
   - reg
@@ -53,5 +94,8 @@ examples:
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

