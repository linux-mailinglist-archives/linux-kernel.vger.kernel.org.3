Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8884C53FCDB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbiFGLE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbiFGLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:54 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA491EE0F;
        Tue,  7 Jun 2022 04:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7Gb8vMgBaHOOgnEIRPV9vf4ZAG0hOrNHRpgaVDtSGhElK1c+Fd7g54qVMDwAzmd0RG8IK6hf/qSbVlZkyPDl7MtfilXvRXChjh1X4EQ6tDguG9Xf9/kR/EYuNKOVpBJ7i9BKDFsiYAUV7b0GPDcvtCLpOojQt+NnkH+cpD8R4QA6AjJGXg9ZSJWYQxqZ1Ak2zg/LhicFmLiBc3FR3XIUoBiM9cVYQFVRXOUPMeC6GIXAfTUlnDR7vNbr5hmcnNB7pFtEqsFhyUwbqZ2HW3qe97mDcSEXghgf9+Mz06di/bgjjhwLk1kOisgFLFy6zR5CSlTrOS31KJDvtuEYoxhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7wCTykQTdD7ktZ4sBsvhgr9XhglMQrt8gXS8vrpQxw=;
 b=QFSEJNcNs8uLuAXyON0A2V/G1Kk8dROB4LoFQg0NTZeqzscSSbJ9DzFgdb1i17Scrtc6HZJADdlvSvSs0IUFsyCY4QDmPyAQPBZYttC8A1DNst6BGOcx29H7HVAgp7ZmQ8ebMqdgk83V2Af3S7ATjdBpnVqpsdeTyKVzqpLReNA9XA0rGJjbY59LLYokc1hh4aSccaebEGDyl7VpLzrusTg1lPx8DYqmY14x0miKd9i8apTHaqOA2IOJmu37bsjXqi6SgvF8VNHbsX7t+l/HQPBYh2Ol7EY1oPxdewONU+E8X1dYw9BkyFlWxNfXzHD+g1cEFH6RqaQqNtuBTzOVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wCTykQTdD7ktZ4sBsvhgr9XhglMQrt8gXS8vrpQxw=;
 b=MDed8aekAHNPoS0DXz3nyQ8Y4D9cEIT59rcuGp0PR0Ck3uI3uukmpNA/KudrQZBUQiksPc6S6N20SkyojgUMolUvvWzkQu5rcGcS38Of9ZIbYVqsn2nGuTfP4OymbbF/Teqs+L8ZGhgvITfE1t//Eh908NJK083PhWJ7sw5KUo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3008.eurprd04.prod.outlook.com (2603:10a6:802:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:15 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:15 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/10] dt-bindings: arm: freescale: Add fsl,scu-rtc yaml file
Date:   Tue,  7 Jun 2022 13:59:48 +0300
Message-Id: <20220607105951.1821519-8-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220607105951.1821519-1-abel.vesa@nxp.com>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da62a33-ec1c-40b5-dda3-08da4874e6dd
X-MS-TrafficTypeDiagnostic: VI1PR04MB3008:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB30085B2E635CB1B599479EC7F6A59@VI1PR04MB3008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/sXEwzOIp5WbqrBIHRKHeMXnVQBpg46a3wX4K5+xLYow1X7KDsyVZuRbZfogIH2D8gQTIHaCtehTR281NQZDIjVghTOAGnkIIIyS/+Q8GdXoHjSDRI8u+a9VxqcVB00hDMOEVFjyBDHkeuJAE3nA0fIpxuGKUnE4UE45f7QsPkYu/Axh5f7uzA8tXY5pmaCDIrc2ctLlIxTo1/ZUEu5lzPm4KKj9kNAthxW/aBSFpZ6sgywtbynB/kG5M8JaTDwZ2c0OmU3edvLMsg3CQj8TgOs9y/4KGPblHeekZuqMfkx2yKcjr2aZyTexZCZKwFGYCEccNB13U1dY7uSnRdAhI0ZbJmx53GeIw8oV3tg1F0IRyx8QQ/+BIUuO8XEMjktyjXpY5S/s+VcpbkHZEKkxLztOIaDqYW4KjQMbJtKplc22fgCFjC/4E92Jt1XSvOWbg7xSBlJfuXqzCj+onZgYyifxQ5/JQxzrBE5bIBA55S26XlLWJ3u6QFeX2QftDuIDCAGfXTW1Erfnka4u4jh06lP2KYEeg3hxYviTKk8PzBEzH/rL48TL+bP/4ljGfexQmfP1EXr+ch5hAgUD4+qmG5SqmPXedb0ly0jV+782azwdNnRf3CidseDdbuszmJ/6ST8Tw8vcWEEMiJhAsfwkVhYYvryGQZ6B+9Tf/Cbv3/sax30TCDOxTQRVV+VrPc5VvR26pTso62pbawverbCa8JYYg8EwP6aetEynyRv+oJd6mm3cJDUgDghkdWo84YtfUbXkbDTI/3tlbmFO/z8Tol1Oy/xjWUPtOnw3NoZYzaFKB+9oV+AB3rybge2kF00qkaHHcbOABazALF6roi39Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(36756003)(38350700002)(38100700002)(6666004)(966005)(52116002)(6486002)(86362001)(4326008)(66476007)(8676002)(2616005)(8936002)(186003)(5660300002)(2906002)(44832011)(508600001)(66556008)(1076003)(83380400001)(316002)(54906003)(110136005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0NCUjSMuAFUdZ4NXMl9r8bq6em0Qq71GoDQ0IP/RuFliTLM+JpB6wJX7Qwnk?=
 =?us-ascii?Q?Ns2G/PhCZRwTj4/kDk2WAwKMvQ6maaP05Tg4xgl6VPbx0LCrWh08kCwhOGLY?=
 =?us-ascii?Q?Ozb3YzyS5SlvD0hoCGIe/omF+wQrnxnC/Jgge7djmYZ3o2syCbZvlfWqENFI?=
 =?us-ascii?Q?YWqeD8sDTDwGX/xvtQSfkL5meIjXMXTkVSM/siJpQdx02HZOhIQTOHCcferU?=
 =?us-ascii?Q?0fgKSwF7b7x+wEMehEvR/RrvMRNZQY+4B4akXmpmX+HBqnYw5iFvVSEnL1oR?=
 =?us-ascii?Q?ZEfyhiYKDgOYDVjaTlj5jT0kQTaN/D1TRLEaAjT2tZlvyYFWdMZu8B7PkztU?=
 =?us-ascii?Q?QUUOGxwCVpo3e/0YmeqWohPG0R7N7ABUkA9MQX3ZIKaquOzESY2MJ1pqQT6E?=
 =?us-ascii?Q?nRqODj+RQXhgapK46uQUNsOzfc9smGyO4CHMQYOwsLX/c4ptbwGiaAzW5ew2?=
 =?us-ascii?Q?RSvNVAJFShXl6sNmJLQ+hynOqfiJMux+x/yZCeSSjQqKlr1CZ4vMevxpGtOB?=
 =?us-ascii?Q?JOgg+cPNq1FXrKMvakSQ9Zqy/PbfXnq5/tJyJdWeqYySKPS4clGMXudstYOz?=
 =?us-ascii?Q?BJ/asq0lzRlA3fu4aILiELwa+aN86N4t6xASe/jeGlIvwBa2U/TdjJOSwdnz?=
 =?us-ascii?Q?yoI96O2sM4LlnJThCzbmYRPSrfo+Ad9bmb63CrT3X1MGErMME1xSmnsJ2DMx?=
 =?us-ascii?Q?iouzQRvkGaxIjg+Be6DyLxFuWycZyh53dMmJsTp/77evfhb3yRYInbB96Gih?=
 =?us-ascii?Q?Unen5ofXoWlU5OP8XQUwDs/bEFX3oyAfR1S1WJ1eU23dVemZYBmQn11tIfvR?=
 =?us-ascii?Q?aewt6rEJ7lNGF83ByEjQw8bj9/j+qq7aVZfv3V/k89t5FddFwfR9sK9qyyID?=
 =?us-ascii?Q?YHwV1JnIT3d7mU6yy+gSFeMIYeE8RwLxUGJlb92Vav+C+RQikyRWK9UG8ay5?=
 =?us-ascii?Q?crk8xxkV10f0e+iZHRX4cIue0CwlXw936W2R2Jc9JwbkriS3EJH6mScwsOWL?=
 =?us-ascii?Q?CnE24joiNaptCL8yIt1jkNpv31q3xEo4en4OQj2y8YvC4LIu17jYIDCCC8SK?=
 =?us-ascii?Q?0h/hP38O8W7YXQU9Tqfy2UU593uYlBtiE4c9I2UKbEvKYvt2RuVA5V3tgpYp?=
 =?us-ascii?Q?WU4Fqj9thvur5I0AOYy7/8/PSLHu6BGiOZKot91U8Fq3nu9CUNzhwJ6EeT7L?=
 =?us-ascii?Q?88bIUCGy7vb9W8thS+hPwUSnZOMUfLJACu+yhUn/7GiIs7avnoo7wdug8quk?=
 =?us-ascii?Q?PmCWkCadRP/2Wbx01EaQuZR3SCX1jv1ojjSnLFTbh3QAd0skA116YcEBRn7h?=
 =?us-ascii?Q?WJrzG6LXkycvs7V9oiE3Qf8CRJx8NMHlKmXcaQgyQS9jrRPjH/VI+gEPJpGg?=
 =?us-ascii?Q?kkpTn6cbBAd2gbF+lUqC+rYpy2tqcVwpaGmZW4KPTuqTJzTJUZrDZINrBgGs?=
 =?us-ascii?Q?EBAoeb+GYPfd8oVInk8Yb8v887cMi3NxFNYJFtUlfWhOYmxVdRE26YVbeLnB?=
 =?us-ascii?Q?jRRI1KCIOYw+ZkTwgejpIFeoMtR7NQptojc2w2hRBf4h9K0PEgSYqnQVoZcn?=
 =?us-ascii?Q?zwYz6BQvw3050SIZ1qVj37+a3WaE+cmef20Z4bk/2lv6b3VfpplibDXeTgIY?=
 =?us-ascii?Q?lv2GKuyDhiJehIu80KBFRFcB5DxFhy0btOZkvwqjlfHB9SirqaVzt7AYRWq3?=
 =?us-ascii?Q?QkePCJQbBqvKJb6OnaQE7/JfUkzYjS8j1lNlBy94lDIZwaZ//UmDxBEDDTXd?=
 =?us-ascii?Q?5YJrV7j+tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da62a33-ec1c-40b5-dda3-08da4874e6dd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:15.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmK4DVF8ap49fWGqxWrEjkB/zUJCtfCwivhekWcOH575Plk7R8/IAAPRhiCefBwN7DEk+CtYTJL1GGtm5rgmHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents separately the rtc child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu-rtc.yaml   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-rtc.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-rtc.yaml
new file mode 100644
index 000000000000..199617be4565
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-rtc.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-rtc
+
+additionalProperties: false
+
+required:
+  - compatible
-- 
2.34.3

