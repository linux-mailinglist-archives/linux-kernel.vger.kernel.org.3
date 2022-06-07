Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F253FCCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbiFGLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242849AbiFGLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:54 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6C2DEEA;
        Tue,  7 Jun 2022 04:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3z42ph+Nn9zIGnCA3nziU9/HppZC/oEYzwR+2yPFGNdoPI+YK99yFpHNkskx7eXlmj6J6tYJhXhgp487188uRpdOL0WdbV2lL6kgEaBGEorSSykY+IAXHFpMcWatnVmv4gSBTfzRta5HypXXqaTWkB+hfExkKzePyZYWkr3sQeowvEflKq8BudXtA0TVc59a6qVbvG8sq3DVzCxx9a0qIEZT6xpabrPLLfNgGuqPJ2jRQMzbjAkyTK+FyBLX4zS2uUjM9fkuI3K3mV3UlrIzf16HqsNXcRfpvIXo6qTopxjStTMfvjb3NMe6o2F8D69sMcpa1opLIlJNCB5yUFNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWzuf3U7Yi5g/jLI8kDau3AayQPgNiIIu/tA9DkM6LE=;
 b=FxZODWTgbstGWjlO/zU7l7syY4JXOtoglgWy3G/WbCxLh/6fVaUfsInQ+R8PvF18z3sAof8WHXkhyNXJ2JojqOesaQbdclAf43NTfH9whZD9osteMjI0s4dFa1ZS3fqF97Bq3qEZGCgwW5v4DoRjMUHO3Wkwr6R4pWp9DPAW5JkuN6+19JycJ8SXwC7nYGwiU3sp55dVnf6X3fPQmnXZKJTjucRpnEXKVbFhxXXWhBOf17xv45ciHoodT5syGu3M+GEx/P83bdyBmlIQWEFq5DdKiLBecl6Joq88CBol4vbQJYDhU7rpVmlol5JXGv70jxnpk4mNiPB53YXZ/Kibbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWzuf3U7Yi5g/jLI8kDau3AayQPgNiIIu/tA9DkM6LE=;
 b=AR9IHMx4tqlK9NUCJ9QqkEwvY4bV4uaAeQ6Sqw367Z6280tTWDCRmZ+7kE4VKcNU6BDxPLymKCWB5+hclyd8AuGzBPUcUf99JeT5rTRyGWmBrf8S4MCsN4Jpu/+pS1SYZUWosEyBsqvQ7CqLWT8M+JPwxQrABVy04L/NT6PcJSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3008.eurprd04.prod.outlook.com (2603:10a6:802:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:12 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:12 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/10] dt-bindings: arm: freescale: Add fsl,scu-key yaml file
Date:   Tue,  7 Jun 2022 13:59:45 +0300
Message-Id: <20220607105951.1821519-5-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11b155b6-05a5-4744-f9f2-08da4874e52b
X-MS-TrafficTypeDiagnostic: VI1PR04MB3008:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB30086FE7DC620B99F72C3B06F6A59@VI1PR04MB3008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huaNBzvLD+USIL8ZDFCLPGC8HskHUOCc6LbjZDJLOxPn+JpTEZNDFHx3Mk71yHg7AkcofHp2YSYmUs1ItUwLaVNHMOuOQJLA7aiI/0XIRmrGgCzKLVrXG1M8boBFaYX77MVBU9Xe7f3kaaHU0xF+gzwVrQaIJGADZtqmPNGF0hPjzwcQFHzTX6W6XOEPctDnl9BpSm3IfK0itufBd3t+Tlrkeh0TSJXzayM4YvJz/Hbd8foWVIplxqe6XaOFHXpRGjNYX8xTSUFyMFKtZUasL1/fabslcbopKYsv2ByTxZGyS8wGAYVwP26ChJxpmWQiob1YYPM25oDKv4DycfYrWVVMA4oFa1jIHSwhAkEjQh+XrKoH1IOlS7UkMWIe4iAct+mWZzbvM3aT0sYN+CEZT5ZSWxau0QqbJoS3AUI4OsrQBZpLEVB5xxrqcjjdvNAn7d/Lgvi6O2rM42B47srQ5q/j/IcV6YRLbTIuLwgfls0WPFpduzjj7K6PVN6I0KSyVXrUx5qUHmH8XYQQ69YN4pmXxEBhzD2JcunOxx5w7W/X/Gw7fZlCliVaL/OcMc70MyheSvWd1t7kvPz0VkkVbETp48p0DmFQ9uip5svAKHQqkD9u68bgYdLR+d6Q98/FUeFg4aoUwjh8d2E3sYuZPUs5BSWJUiZ8HkJ6QbTddfVIw81JDiRrOdMiKTaH1BMJC59I15avYoCRqJ+5FJyqAsrb68CMEzxELYHiICTy613mwrMXUo10LFWHlOw1CRTrQmqJFkRkcINXRpYTdiRDhR/mvCg72nM3HHu+Y5Xs2tca4ixUfEqKFVW8oZRWFfphzSoNho85nZJZUmS4X+sPAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(36756003)(38350700002)(38100700002)(6666004)(966005)(52116002)(6486002)(86362001)(4326008)(66476007)(8676002)(2616005)(8936002)(186003)(5660300002)(2906002)(44832011)(508600001)(66556008)(1076003)(83380400001)(316002)(54906003)(110136005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfQAdVjQ2nUOqZ6/gc5hIsAyGjI+HFV+z0YwSn3eVhi52qIFzkcYDso2OOMY?=
 =?us-ascii?Q?jVToRKe3jktR8lriYnyPWyKkEWMAG2NIdPe8m7qTmKgRneGDLzDFgOaz8gs6?=
 =?us-ascii?Q?7uCqgRmM3Kvy9e+A0e2Ej15twOp6usZDcwWtvwwqaT1lwsVzfdl6unETJnyy?=
 =?us-ascii?Q?B7z4RkrpjZHQKMXNYg+SH9vdFY/zG/eFdzYFZfWRI9G+w7K5yGHe9v1qk1UF?=
 =?us-ascii?Q?4KDX2xMfx0pjINhxe7vLAqzeD38zzRm0xMJjq6ZC21OVVg8U/XHQD7wCWGVE?=
 =?us-ascii?Q?X9VwhXJ+VdUo/nzGoTViGvuARToa2GvTNf/0EoS5kSSDn6r4Euv6gobLhfNj?=
 =?us-ascii?Q?iZiN0a8v7VJECfL+RW34A+JdtZyoKwUzdPfiSo8jiYS2V1R1vrXhsdRmRa6a?=
 =?us-ascii?Q?6q4Em+4hCgemHFfg74zOhrC9kuIijCEt/kPRJsapIFgC7VGZKyMTEUkpWrgW?=
 =?us-ascii?Q?trd3qwgrj3h7u44+2FZdj6gDeZMBcnB1tPWMrL5DIiu/QXlgJ9b1UzSKeNEP?=
 =?us-ascii?Q?5BGabl/08zS1WHOf1JVTZOaB0N6zfEfB/w3+0VlmtNzJebuAXSST4/jEsqW/?=
 =?us-ascii?Q?neTpNaVHfmnzsR3QwJV2b/32vl8QDD8lv/DPN2LueDb5K9KzOBx/wLC/1sft?=
 =?us-ascii?Q?qZfwKAsWKp9/z/W56IWykguL/McIdCcG/SBFbRBGb0r4gowadbxfp3lH/3SI?=
 =?us-ascii?Q?Cf7XsSN85DRriRCDapPHhRBptql2fFZmDKRSYnXwpCJMwc3kyCix9KfXMh4a?=
 =?us-ascii?Q?VxRpJPtT7kVF2MmM8n8puWS0E0mkQkqzeIRJyVWCKK5+WukQbZDqcwcrHcAc?=
 =?us-ascii?Q?6xnuJDgzgJ9a8VJ/Km42clRSBtcx36/sRKcKEcn5s/M5uoVo5dCVKaQ+Tv+e?=
 =?us-ascii?Q?hUqYAM8lpMybkAA38/xy1/Dw46txH+K8Ysa28xFl8MhwshmkddFPdfcxWl+c?=
 =?us-ascii?Q?HXEAF70QCK4lbGiH+Ce8XOE251TehirsGMW3+w3q0nM7oDpcOP+tPdTT7uuS?=
 =?us-ascii?Q?GpBVfZ4lq0S6oFiLTYP5j/1n30nKFIUvjQrz4ylxH0RT1YGcjWUEV22d/43j?=
 =?us-ascii?Q?HMpGAae8UEcH0nZefBu6/bhAZ1HWJhmohWy+CEHXy36/4/JgGJLAdmuAGzWV?=
 =?us-ascii?Q?X4d/FpDBtc4E7yXLgdWR8jdrIraR2GGGy4HlYsW4ntAelhuIJhScVbWgvKTY?=
 =?us-ascii?Q?+nN0kX3gIxhVVEuR4OyWepeotATP2YQGzbNJy2SsholHLTvOb8QWw+472zFX?=
 =?us-ascii?Q?JtG8OvOrCYUSZ/I2hp9aMCUEhQrxMwuGvLSw6pOpGvLo6UXbbR2o/Jh79h74?=
 =?us-ascii?Q?CgdACaShjxe08fuN7D3J+7c4ZP11xX4aGa2lcaYI6+Rye8764RlkohGGQZ9d?=
 =?us-ascii?Q?lR70u7uny+hZCLMreHfCLBdRNw0zk+ge+kGBX/t2XEIUSDOI7XUoqlWCut2e?=
 =?us-ascii?Q?l1mFZuDZPpFUeZl6X2zPiGxWXIwPePuInZD09TZXZaDfN3n5YpiSxZq4VBYM?=
 =?us-ascii?Q?1N6Ilo+FB6JjgwfsD7j88ADRm0Gt8X6NsUosig6L6V5QzC5ok8ONCkDgEGxr?=
 =?us-ascii?Q?vtxEN7hAF3pWRc4pUxu4Ok46Hg2OrPSjhplmeT46SZHWEPrL5Uf8agBzxYXK?=
 =?us-ascii?Q?QxUGtZ1BPYrQ5Lwowc0WWYFSnCaPGRF1mzIorZ2XZRpwNzFuWsK7utDZf16x?=
 =?us-ascii?Q?M7rVS+cWuDF+d4YeBVXU+7KiXY0aUH8MNr/2RNs3QOYd+rN/rt93jmBAmOqI?=
 =?us-ascii?Q?5/wiWiapZw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b155b6-05a5-4744-f9f2-08da4874e52b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:12.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+bKbyaBMuajmld6q+BbB8+ZzSz97wVxEOW+XZI5wtB/qlqJB4f+jJHQpZ/OgCODdaQUTq+yei4iM5k65gDlvA==
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

This documents separately the key child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu-key.yaml   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml
new file mode 100644
index 000000000000..0b52f2f33bd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-key.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - SCU key bindings based on SCU Message Protocol
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
+      - const: fsl,imx8qxp-sc-key
+      - const: fsl,imx-sc-key
+  linux,keycodes:
+    description: See Documentation/devicetree/bindings/input/input.yaml
+
+additionalProperties: false
+
+required:
+  - compatible
+  - linux,keycodes
-- 
2.34.3

