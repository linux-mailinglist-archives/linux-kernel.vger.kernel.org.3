Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD653FCCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbiFGLDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242862AbiFGLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:55 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50066.outbound.protection.outlook.com [40.107.5.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E411A0E;
        Tue,  7 Jun 2022 04:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obfmeUjlt8OW1y3F/D4kMLfJ+2seueylpHmoiQU5Uh+wKbtUY0cAe6wgYSrGBeKP6NWPotqZXf76mRJtgqnSMoDQzr1n4mz8hPvCWB+J5ev5Yni3vtFRw4Xfjsp+lTQTxGzq+8fPzlc7QpbF3VhE9VqPnBVl9BmppggrBUFi0t9iYGfyLoEWbpGN0+zhmx3SMz5WcatdPvvqhS+S6IOQ0RU0h0qSkdnUgGAKUG0vJNZnsABkCUbEoc2yQ//7M6kdXdAG19o1D+NwrtpYqENL9pFLTSxm62vq9/ePponfWBOVbVt3hPNAMXvcf+B4pGa+fy3LWi0nGgMplRxhPx3R5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKGHhgOeQXTqn/PRCrCXpxd/iv8pNEC8xRkCz5jzAG4=;
 b=WW6lPkRqT2RlJEoutoyVsNRnoo3OZstwrTUvSj1B+lTakl1/X92kDvGgOWEMT1+aOobLDQKYORgbPlCm66ePtViUFrUC0oC+poMvsSyvOErnZYlJAsNecEzuOQVKF4nEA4d/x2YV/6KANHfRyw8kYPUCZpsNx36H6+BF+5B9yDeibFWJCSuPzTAOEK0FBGwb6nbdvYg2pVtw3C+DrUtrbjStr7NJm2zpTzFixZD3qqOGE6g+wAcmWWaY6QWKZlNl2P6t4bDT6wQHVfWbHbX1zgdWqvqhmdpx2WDtC5ucf9oMh6zxSdnw/fvVY5dSma7wxu+Md73pcCYF5IK1Pp80IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKGHhgOeQXTqn/PRCrCXpxd/iv8pNEC8xRkCz5jzAG4=;
 b=RAJppYcI+OpvfKiAG4eZXVHm9qRK0rnkd8V+n7kex2zgdSjEZvFAYAQ9QnbZQjNsaocAcV2F2OYj8op7/EP5zR95+KSY14RkV2Jq34zTNmV79J86ndnuK6zJ4AYhHPku06LgKokS81buwKzLLWWzEaD6Zyy5gzQr+i0IUbihSgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7301.eurprd04.prod.outlook.com (2603:10a6:10:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:18 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:16 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/10] dt-bindings: arm: freescale: Add fsl,scu-thermal yaml file
Date:   Tue,  7 Jun 2022 13:59:49 +0300
Message-Id: <20220607105951.1821519-9-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ba230ae-a511-4096-0ee8-08da4874e774
X-MS-TrafficTypeDiagnostic: DBAPR04MB7301:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7301EF3A5EF438CB4FA55BC9F6A59@DBAPR04MB7301.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xS89xopHPZfXsMNg5bzlmMPDrSbPcnCPCHiONmxYTgI7gY6vwuZBti+50nN+eK9xhLnHQeoLSRIOgKTiNPyRSPTtoG76yB5eRQNyJC6Un5oCsJt3JoRlm7V6dkytjLxnRSQQaS7M3rDI10erJjJV3Ov9GZAkr9j/3zOD4vxNd24H+6NjZf4JloxhqUqiLTrxLd3i4Ul85yROGRFAcoqZj7RsMN1STO6Iyl97qv2XRFTPP1v2JAGh5kHVJFkp6y+e4GlG9hjnUzonBIQs1l1kujWVX7p9zDPtfXPjXWEeinAbdnFrVRvPKWF1Jeq81E3hV3kzBCBqVFl7/d8DzCIyKJKRl0ZOUFElltZL/Ams+KInXM9OQGPnLhEAwlVS0gjWumqIVDjTpQ7sg4CcsmnBlyhRm6JXg19BSkA6byilB0BRWrQsXLNS/m56j0IvH0OvCJ1P0Np/PpWVypxYWAjeOaf7vhJkal+P+Fv/g+IBhAh2k3Ex0RrQmJMPSXA5GxNTjSZ8xvL1IsfhJwkI92wpBMzGng6VN89nMU/dEkyDMSQAGckO+EuK72UqhSllKuoNlvK9X6qaolj24R4eKYiRJ7SjSU1m3tYxPac/0C3DlMyty/ygcI9cHvaWcnTXaDINfxZwrckD5pbf+Q3TY4qrQNF6a0fAJsG1HDYoFWErt+rXbcdke3dgFz4KT5rPijGyMTiLMJwe9NeacHsqejjCUFRIkKlthQiPni/Rjy/k9+Sg/mXA4X3YZts6A5i4Mdvzeq58iscDB8ozKo8jqm/gng+3+6jfvKNghNtcqQ/wFNm4+YdjI84zLrAsNz1V8SZINSSzO1Kz5Dx/9QFl5plv2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(83380400001)(6506007)(4326008)(66946007)(44832011)(1076003)(52116002)(6666004)(508600001)(38350700002)(86362001)(186003)(6486002)(966005)(2616005)(8676002)(2906002)(110136005)(36756003)(66476007)(38100700002)(8936002)(54906003)(26005)(6512007)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0XycwTirBIiC9CaHnqXKUXNs/p2tgMWQfYNdC7JQ1kQO89SqyfA//DX7z3t?=
 =?us-ascii?Q?bAThFI4FCuUSNrG44J9IP9D77Dn01n0fkkgBs68KuDC8msrD8fF2kKfWEMIS?=
 =?us-ascii?Q?bAXd6riKTBZoXVAJqyc1vUHnY4Z+puf2vFgAuMHyy7b/hzqZwTxCCcpbLmMx?=
 =?us-ascii?Q?+yeXfmTOs6U7xN4DXEsJBuWNNd5OGdxpA/QLoEoolE35+Qt2Y9AaqRwXvlYx?=
 =?us-ascii?Q?9h/1gtduEofr/fJlW+38ujHxzpWKX9a84r+o21tcYS0SmdgIce+kvl56ySl/?=
 =?us-ascii?Q?eBEr5630qFDXaNRiMdAmvA0ESK4IUejgF52Skn95+mNmnMCd4onJwgcUbf7f?=
 =?us-ascii?Q?S7DX0YhDFAopRXqqKQm8osnxHuTJGaR12hGwMr8KFLtB2e07hMgjMaWhOIiJ?=
 =?us-ascii?Q?UTxy9CHsT/vVM/5tdGe9BL959QYKi2DR9m+cYENS4FBRlY4WQfJMEHKpE+s7?=
 =?us-ascii?Q?SqjK9KUYkxE/MUoW8wjbR00GWpG+h0a0BgUsvfsYCNE+91ldpOmVJQQvD/Vt?=
 =?us-ascii?Q?5ke6WwEhYDnAIuH4a6FZc7pRSLFUYt0iqTZBYxvxwEuOtkX7yjlC3OvVOmnM?=
 =?us-ascii?Q?8chSPSsfdRP+xxEKPTfWwqhEAuN80rTvadjVODuO2T9aCxdeFU2uPZt9AwrM?=
 =?us-ascii?Q?h7yd9k3t6by/WWW50+bD7I4FqykppzZbyPLJ8vg6W3xCH6ODQIXNUWLxDaFo?=
 =?us-ascii?Q?zTAEHz/rj1fc9i2ur5DDp6saZ8zIkBpuW0ZNUEhabZ7qDVMFeor8O/r5FYMF?=
 =?us-ascii?Q?ZPt/5Wklvwq0LMNqJ/EkOi/wnWcVqekjZ8slmFEvDXX8q6/BZb3D5xVHU2jC?=
 =?us-ascii?Q?pvKNjlYwI/KbRKrkn0/EPfOws/IXpf5dBMXS40atFo3xC0zZ2muH6iApydFM?=
 =?us-ascii?Q?tbpVFwSmPFFsROIchjggLsljjl2B5WvGfh7NZn7ZSkzMb94IcdkL+5jcXUUC?=
 =?us-ascii?Q?qT8krpwH8/gX+TAJv4/XNJOsY+ICKeQ9k9sgEvCbhnNIdqR/WaVD7WqMFDug?=
 =?us-ascii?Q?D7Q8NYynoQ3S5oxqhAtdhMwODaIPhCluHA7GO3YgNa3JfkXD44UnxMEx5czU?=
 =?us-ascii?Q?V9kP7YJV2DpMcVxnqRDIHC0yTQ3O+6WCgdl+UXmqpYYGofHmPD1ZatKeL95e?=
 =?us-ascii?Q?ZdECRDvfY2TjQ56H/+dpREhTkvC2AU1hgDyVaa4SexG3+5O0+lVz2DnklMpd?=
 =?us-ascii?Q?0vJyTOlfYGpJX3bwqOyl0dvKXFvJ0i7k9fg+3jnSbJBZD0o58boHnweBs7oR?=
 =?us-ascii?Q?MN1082CBvYqQrucyz93h+LoSTKaorf9IS9kyZLCS5WVta988+qd8jGBD5bJv?=
 =?us-ascii?Q?qqWGKrIvmYijkBlq0edrSd8htpVYb766fKyX0M4enHk3g4wVmZdQkgy8OSu4?=
 =?us-ascii?Q?n7K2NFCxeJ+z8ZdbXyQWEspSC8Jmt5IjRyvm6AzDUXdvOu3GTvvYr3piI6j9?=
 =?us-ascii?Q?rMcEWbB3wIRKryWSdEzfxjjHYxJsv1+Le47kOMvlI7ea/ndmjIIZyhTqLFgJ?=
 =?us-ascii?Q?uo2f+GmTzrIs4E0hGt7P6CFBERwDMOIhr7moDf4xAG6KLethkttiu2YWMvTT?=
 =?us-ascii?Q?+S/rqxZUgK6PkcPekZgxHU8ixnbdcfPGCYLkRrFVQlqYpZrqB4onmdPlJ+uG?=
 =?us-ascii?Q?xuzCanBYT156CM/ZX+gGBrthloabGbPJZV9Ju91uKDrtwn4EUsKBHByJW+Ql?=
 =?us-ascii?Q?KkCQtyftvwk47O3WfSTlfmyF+bxojFu7cnrxohPCuUjlAamHlkGnz2h8Aq4b?=
 =?us-ascii?Q?KD/u/p2Gpg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba230ae-a511-4096-0ee8-08da4874e774
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:16.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DROM8/XP+g9DU5b70yo1qf+PG9F1JIXcN4Ge4NZmnh10ng9U5UPaUMf1RYtStTZ3ztAGAq4zyBinOrcTP5YeQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents separately the thermal child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../arm/freescale/fsl,scu-thermal.yaml        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml
new file mode 100644
index 000000000000..d94d378443a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Thermal bindings based on SCU Message Protocol
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,imx8qxp-sc-thermal
+          - const: fsl,imx-sc-thermal
+      - items:
+          - const: fsl,imx-sc-thermal
+
+  '#thermal-sensor-cells':
+    description: See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
-- 
2.34.3

