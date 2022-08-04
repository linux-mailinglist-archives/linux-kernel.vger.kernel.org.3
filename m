Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF15258A0CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiHDSud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiHDSu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:50:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC710FE5;
        Thu,  4 Aug 2022 11:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaVFN4+rWU+SmIR3s0VkhkFjlwa7V6FvizmAwAEamxpifjcQFHN7/yxw21hfYgB9s/1Sz6trqGQiTM3SUCKgOr5KVqFiH1ChJJ943flI1PqKL/mdQsEtrPlDWRQ1qDZU9tUnt7wu7FvFLUYj2Red13t3YAdymjAz+eAobMqtlhCgKgrzAqKTupTtfF30eO3RG/YhDT4Htg723liEqJUYqpPEXsCn9C8oC/0rYXj7fW0YwZKLDrvY3Zute6umzbmcgkf8brr6Z238aS8IM3FWBrwPea4aAsShtc6bsdRgGaCC0c7pEtf+3VySkxy5GLU6luFDOxDFDJXQ15eaNKBdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz9jfM536FH6asE8Q6u4TPDLSSpmepRW9GXSwBLdvEQ=;
 b=h6nPZWuJGl1n2x+45xEEWnqm2hlvMgjN6Tp14h36jfWcp63IuV/7hRtxgPZ4JlswXitI/A6Pc2AjmBoHfPMvHr7rtnWANAfsAY1+oW2r/YOdofKTb8aHZZQhavGeRlt8/zjVkrX1WKkjMTM17o/a1fHqQfu0UAxDy0JmgjHHe5RdsOd6TUSjeagNM28CB4/nHQlAR49Eq1PIMWxpnZ6dIbjCaVfW6C0otsYtOFOW76vKQzjcyJxdZlo0Wfv61WpgXGmVPJFjJjJIgvqYU+T0cDA/beDaUNfYEKrZ4wqGxf+4ybJW+NN8puN85u5UMUBQAza1YEX02hBxjMsKe1rqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz9jfM536FH6asE8Q6u4TPDLSSpmepRW9GXSwBLdvEQ=;
 b=eFyFZoYuRIIZoeveAtefiL9Vc6aMEa7C85UE4KZatQCAYPaVpHO6zoFedBVH/rD2rdP0hC0ftByfUgMcAPxzftZyZ0FD36qwpTNhhYWb9m68ZcBeFMQVdndYycZimGSI+OHkslcT6v7jhiKv4ZAiduiLdIG8Iy5f78GJDNCUk64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB3992.eurprd04.prod.outlook.com (2603:10a6:209:50::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 4 Aug
 2022 18:50:18 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 18:50:18 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v1 1/3] dt-bindings: gpio: Add imx-scu gpio driver bindings
Date:   Thu,  4 Aug 2022 13:49:06 -0500
Message-Id: <20220804184908.470216-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804184908.470216-1-shenwei.wang@nxp.com>
References: <20220804184908.470216-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::14) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f5c721-8132-4610-f8b1-08da764a2cc5
X-MS-TrafficTypeDiagnostic: AM6PR04MB3992:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbXfgYqCmZ24TqUkz7VzVUpDwIQHMh+zdzNIKsRS/J6cXMbClWpuvVee9Xbi4dBYScoN0L6Rng3xhWLFt7TxkWk39cdGYThtcBs4UZM3/aljqGS65cYHSvwindH6EI9IS9esrW92Jf2VlnZgIIO9gK8k/2D6hYn5zUp++ZJ28wS4jC/Uf86YwdrDynl9489kgF/MBBB8RRQoMqnudLwXodxw/oARHk8zR0Q49wGZutHIMvu9mvuLhxzxLu/hHKmmNGpdytax0GC1LckllZRw2gSBxU8wrUFzPAETnJEMnv+DWoxCYDVJeVzFORSCZsEBHCXGexevbRzQu9MufjbaCPrBPAPB7xjsYm9Xlb7rMXFkkfo58K3xtjngflyGC+yIajdB1KRu9RFQYBg6Ils1jNeQmd++dBBYTY/IQudR7RtjawsuWr2rzcg04Xr+6o4RStsA+/DfbNghOj87yFmyQfiDVItc+RgiUgrFbXJ0HT4Ce9EH9mvhq6kcvw26vbm0f3/K4H9yvZwAA6PTmgbqh8hp/gAzM2Vusz5bXC99ZAD5C3lgeihP6UTlHNjhl6fKQmUX2uv6mZde+e8Mhcjh0kpPxTzhTSdiFqDT97wjxcUyKt7mKUrMr3xeaMPakY4islx1LUCmleiu/zBYDe15NsLfgqLbtQFVTgAR1f9ffYBNXLAj5ArWlZmh4QCpGTYb1MSEy7vHQyQkjRlYBtQHZdCMUX2pXod9HFgq/nUEbHQ17Akfr0+M2AJsfywUpR0FcIu1bqU1QmxDw1NAvUe+sh6S3uMdRTgEXzvf7xkwp/lm7/sWDpch21STnVjAHXkk5sUKm0tvHpm2r8ayeUDyrQRD5+/54Py/c/8OlV2H8WRdUVlkeqL1vUOq5zyMpAbd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(2906002)(6636002)(36756003)(4326008)(8676002)(66946007)(38100700002)(66556008)(8936002)(316002)(66476007)(6486002)(38350700002)(6666004)(86362001)(52116002)(478600001)(6506007)(55236004)(26005)(6512007)(41300700001)(966005)(7416002)(5660300002)(44832011)(2616005)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A3tnIlofn/JZJEfn/hDc6HQ8Tka5e84hX6ZyMcxXKQqRE30Hgj/4fDlsX9nG?=
 =?us-ascii?Q?Gwvsup2E2ivSk4sWgyBn0tKIMpEqZTf0DdlZaqpE45SPTxX8aW2d3Nmqd5s4?=
 =?us-ascii?Q?lnz/u0WM89OYvy3H9YUsE53jz/3HmqjYGwTw1pmgX1B0LjgjO41/8FlKVk3k?=
 =?us-ascii?Q?fxQYMgqm/utZ9eZ3Zg4OKg/V4pKHmFoXt042no7lnRZ95cyzEh2XmZI0uw66?=
 =?us-ascii?Q?6tQCLwZZBFfFmB/9MYDvQ0y+QBZGN5LbJC0pJCKMuyMHqxQugUcSHNlos7iJ?=
 =?us-ascii?Q?7gnm7+um07egjSfhacX8fiVrWqJL+eZxWYRkWUWI1uW+wYmtUKamLocPLTMC?=
 =?us-ascii?Q?2Sz3YeslFku2tA4qv0Dz6mrHsxdnDFGq0miJuvkceWE6Jq0DO+QBa5IRSwE8?=
 =?us-ascii?Q?O79283p2fMF57aF7bkHSkBSK5uPs21y9u0+oA0Ih/+v1+cCCoe/uJ4t9+FhJ?=
 =?us-ascii?Q?Sc+dT6BSYH/K1T2CRWXUz8bq9Mq2/CiB7SEt8l1vlwJQFx4YaDdT0qbZncM1?=
 =?us-ascii?Q?P3FNw2DzCdv03rPEZApCm1FcpebcuqGd/6fz3zQlngg3cAlvhO3Age3hgxtW?=
 =?us-ascii?Q?6q7ihCfMtQ3v5oa8Th8BS6iNe9vkjh0zQpCRG9n/Jitd8EVbPLJbr2Ywppcy?=
 =?us-ascii?Q?E2yBCn1YUo1o6wzFCmNajJcXL1qjC/gYYeZUqSonwPFGcZ+ckCTOVd1/TU9E?=
 =?us-ascii?Q?KM262J6rKVH0LJCzV7O4iAAj8KBRXfWGLWSrYt28aQqotfKGIyv3SItPDdK/?=
 =?us-ascii?Q?9ANeGnkpkv3fhINaCK8ZTSZ4a1254I9Y45H2bg9VEt4lljjt/9PzSnZJV+rg?=
 =?us-ascii?Q?QDaSnnPbC9PpoT7oJH0oNg1gqpZqt/atU3TJrFwuYefqTVb2/o56NA5i1fLL?=
 =?us-ascii?Q?7KECxffR1P0M48Ftfw/ySmtKY8p5fDYxsVvd/6qcGV09+iFTz48J+Va6XjKh?=
 =?us-ascii?Q?hg1ssntqWTIA4a1ERL2pyykVe0PCRCZz7KypzqaVevU+TbBVkI3NAL9YdXrG?=
 =?us-ascii?Q?FpzM8vkflA36SZv894B4zJIiRR2wsaLTwyfKreQ0Ia6KvintLD+eq4cW3pTK?=
 =?us-ascii?Q?Jk1Z6RixM/kIuDFIjjl2wd9Kzh4Ct6ufJ48LE++4rOmFwtvjqOIgI31iLPoW?=
 =?us-ascii?Q?OUDbAAKCuVZN5Jls/0a0f39F9RMLt61MZ2hDlqcSahQ6K1pzAj73jH75r1Mz?=
 =?us-ascii?Q?yCjuKNumPjCujnZGSCb6X5L6A85e9a1/9Vf+Gn75siEvyr5pstV6bMz9Vbl7?=
 =?us-ascii?Q?eluYVLQ9qoJ7UW4tqg2x0kSnMAOld7H4j7TTW5xId8YNvkCUoRKDjhkp7oet?=
 =?us-ascii?Q?Pe3c5omrRUVChuhA961S6liD2jK//BSlYwrloVtgoqEGlJNpnOzLgjFM7NCA?=
 =?us-ascii?Q?iWAKWR5iCnADQVPv+KJuEPJaQkJaugF1kkDJIdocTsOAPR2EHcFZc2ARYWpy?=
 =?us-ascii?Q?BS6vFwZm7xBKJ0gzcFlTcUepTVCc0ksnNygSZJ0KC0N1XbLoWZTHL4+M8Ga8?=
 =?us-ascii?Q?4O68NZBk7idZdlSYVCBIHqUGJJ9a7XobCya7ComPoavtwldL5ptvjPWyP6fM?=
 =?us-ascii?Q?hXLhoSbdgcvpmAwg77N14/6NVLwvreP0Jz5W4Dkb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f5c721-8132-4610-f8b1-08da764a2cc5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:50:17.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYaj9RiIMPqBiF/UpjIgi5buVFXcHfvXhDvRQYstiJwS+IatMeyFjemB3NGlY4hsY7PEzv5pQaoFgPqgv8BWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the imx-scu gpio driver.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 .../bindings/gpio/fsl,imx8-scu-gpio.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx8-scu-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/fsl,imx8-scu-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl,imx8-scu-gpio.yaml
new file mode 100644
index 000000000000..d06e91402666
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fsl,imx8-scu-gpio.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/fsl,imx8-scu-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO driver over IMX SCU firmware API
+
+maintainers:
+  - Shenwei Wang <shenwei.wang@nxp.com>
+
+description: |
+  This module provides the standard interface to control the
+  resource pins in SCU domain on i.MX8 platforms.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8-scu-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@scu {
+        compatible = "fsl,imx8-scu-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
-- 
2.25.1

