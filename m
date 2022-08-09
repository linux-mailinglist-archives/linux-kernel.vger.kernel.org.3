Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EFA58DA5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiHIObm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243109AbiHIObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:31:37 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00084.outbound.protection.outlook.com [40.107.0.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A971A807;
        Tue,  9 Aug 2022 07:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKBmLfamhIQNgPQajKgR6LS6cPTG7doqLUhyNBcI7b0Iokz6m1S/u+QMDRHHyy9kfPEul+fdS1WktuZjaIikQUufIo/fWDowEOdggWujNkCLGjMp+vyXlZ/NR1rA3yA6mygozFWDJ3+BfzXcDxIzhfLtvcp3yrWIxlj9jNxh7qSm6dyhJ64m/sRGD9yaNiL9oK+KBQgk8uL+gBor98aKiGFWEnPRxvQtpxP8YF8o2qab0SxR4fFr4JS+nF7mDIordg3qnyjFicrt/bUFIQxnq1rRRoCeckshde+wqSkR4c2zvoml+lhTqP4pCZ3/y1wy8ohlfF22Vay9eMDaNvansA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBdwkibQBfzIcg01Jah5JxGscgRatFXJFDauzqiDOcs=;
 b=XXS15MAmr/pikYf2qjccnC4kjVmcSF8/jCyQyhxNh7MHE0H/9R0fgIk/v11X0QN7gpJckLAkWwdtRI79DXbVE8A/uLTDLR8Sj0xYul0cxfhE6mNFC7zIBzUHUIvVfq1J+2XBxNBu3uceyYVDv++2XJAeOlgzGdH1afIcravsCNlwMUhpOqRe3B2eeHdjwPR+Si8Ry8gmXR3VO7QvVuafzkisrkkIhlPptBGi7sYkhrGlVJKNriL9v7WvfLFK7mI339fLEJKQ03wkz7noff1NcOIZuBt/CU/r+wJ0NoPqg6gzrFrV29FxIuw5DS+dkHzi5zpWQt1g6gTWWzCb5btfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBdwkibQBfzIcg01Jah5JxGscgRatFXJFDauzqiDOcs=;
 b=TcCQjmpqBIsTAMiK6yt3ux6JyYLUrpQWC2aJtLODAyzh+B+vrFOTVmB1tisoQqgHOwAGj/yd7yxc9NwNSEc9w+g0suzJr1hvpqPubQKl2jS8qtYsTXsqZNYS4td5X/3v7h45OFkhbVattUAFe/KgkkR/VJJF1Z7S6lhFsCRd+i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by DB7PR04MB5226.eurprd04.prod.outlook.com (2603:10a6:10:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 14:31:31 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 14:31:31 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 1/3] dt-bindings: gpio: Add imx-scu gpio driver bindings
Date:   Tue,  9 Aug 2022 09:31:03 -0500
Message-Id: <20220809143105.17967-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809143105.17967-1-shenwei.wang@nxp.com>
References: <20220809143105.17967-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:180::16) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f6a7343-8fd6-456c-0aef-08da7a13da44
X-MS-TrafficTypeDiagnostic: DB7PR04MB5226:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/dJBxTxK0gB7/tKlznynYza6qqRba3bKv4YYVoZDc8W9vl+rEraQrz9UG3qD8LR0T/9QSFAwgL9v3kLbnZOrtP+P9vDwTZIi41qWlgx+iBy5rXvzJCKjjwAKy9J44t9Yo4os8/4J51TkMr6xape59Mmzp3yBg/ZwNl8HM86ISGct+yxfXI67Jd0/MKpB0F7fNqJqi7VyPUXivhee9tG4hT3HYGpUTa29vQABvfs3bAJKOzNUtWz/GzuQrprtF+eGpRk7c8RznT6ypx2sv4b+u2d3hHZMWKudTCMtsSLzJRDmWb0NcGn/XLrnBxMqZtA4fX5ePEBO0AikmFUzYdqXWD7WftdZTwuTW3ZTSPtcqJS3S5pEEbrUnQNNXJCR7aZhVGfAjdiv+oUlGADfym+z1FDShl1y7Nb6rabU9x1aVh5PjGfaqEEgNH6JpzOyxMp0hAJRMeSlCniyTE0v6gA8f5GDsmHO3vVi9PJHhLXFGRjdq7gpvYJ+LMQPM7JmAkWPHC/6hb1DQC9MhSZipF7bquEz4uyQj7g0LSSfFXQ69Mljws0s0/lE98raJk2dGyPpWWB84LFb/kNC8IqFNneY7DixQugfXbRtufXLE0sKRxCb/1Bo3MY5plbpopRiLzZDVedbthVhKMhU4u3lybPnO4ms0Ekk8hqXkqR/20+/6TCh3IA+D/QE/hXicynqA+Zv+VyixSMi00TuZBavQrNbDVKVv8OVWx5sGYBWc9xlXa5oPgj4v6Ay4rBqFdTlmzgq3wXuq3VLVr4stBOG7ehJ1iJRGZG8DSbfkUZswAiqYB5Pfc5UOwWBLE4i15O9K5q33Aer5fMgLcuJNNiSCAFfr4UblmVA/hEirxNHEUgKD6JTGSmSMVv53BZnuw641K9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6666004)(55236004)(2906002)(52116002)(26005)(6512007)(7416002)(6506007)(44832011)(8936002)(6486002)(41300700001)(478600001)(36756003)(966005)(86362001)(1076003)(2616005)(186003)(66946007)(5660300002)(6636002)(316002)(66556008)(66476007)(38350700002)(4326008)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9sWRJGp+mBqZTHpYAGYJs/Guab1PG/zst/xkF0fwnMTGBK6RCohCGTN3bGwl?=
 =?us-ascii?Q?zBTKkPvlgNMWr07RueQDWV5d8YvjPj5Aw1V3Y9OF60LKdxFdVa9kltzUXD/H?=
 =?us-ascii?Q?hllESqs+i0QVnpArBI+fDUBpVy7V2JPRmymZzJNNXdJXQCuzY3+sO/m+ufDI?=
 =?us-ascii?Q?Tp3ID/oR1bax3iQn42ydq6U5h0wWTnokI8M5hrqYuhNn8l1rKEV4IzuUty6l?=
 =?us-ascii?Q?42KHa0JF14NCxidjFUP4uMkXDiD9THbswts+cje0oRM4oYiK46ZiCGmNYmHp?=
 =?us-ascii?Q?6dIJnDbqKz3pDVpCv/GX+UdBXMAAvR75+HBj29xPJ3mKUQiXy7vdu5mnjk+h?=
 =?us-ascii?Q?J4VJNOOh6CeGe4lGaGA2eLZhlk0OgNyFCQUXIr3nsTdXT/i8hjcDHQwQgt1J?=
 =?us-ascii?Q?J5x0gDoSPqDrmsJ/eoqYoZPVD/zJMJyvjfHOqRkU+ET556RiTXVdqD6wKR7p?=
 =?us-ascii?Q?4yWKux1AJcECufTAByox5KrKIq0x0ELAjaIyKcTNbBVIJY0q1QiBUJmA0voz?=
 =?us-ascii?Q?ibjRKjjtnts/lKc0mhlW7OxuiWWMEGyHZnRnF+/iyOZpBbb4yj3S5b8+Mv8p?=
 =?us-ascii?Q?jsJzBO+hSxuH95NnFtQ/QDS3MUQWWmUSQB6egADGMCxSjCpVy+R+Di1det0V?=
 =?us-ascii?Q?43y+aarEPxfMq4i8TlaHKmaXnsQfXpAXZEE+krFHStICq7FVuvgOnBK1G6kn?=
 =?us-ascii?Q?KIRBxdrhNrGEtREJm0Tk3/scOREZUEciXPTcsnuqe9ZEJEN6dg0pIgmQtKAN?=
 =?us-ascii?Q?phQ8mVV2nMf9sNErWw6M/eufJ6KgA1e7wKIgOzFR+GzR8su0fryfEy0+fjId?=
 =?us-ascii?Q?AXazPTO9ouRdsLgNtuzBiUto4cHGEIuw9RJAgv7YggHXDt3DJ0tEWCo0hd1d?=
 =?us-ascii?Q?urg+MLTRjIJlghgQQt+U3DK6REAXzOEQoFqe93SxImW72BXx75PBuVjrC4za?=
 =?us-ascii?Q?oHwGC8Ot91g+ckC7IWYwH0P3nk+5G9zn3I1qenwTUuyaAvQcxescztELzgmR?=
 =?us-ascii?Q?mFP3PdGPUcyn2ijjBXOTjMqdCb6oeR2EShUPGGwoq0+zbY+uCklIdGlKEScr?=
 =?us-ascii?Q?IcnxqsPYFieG6KGAVwUIlz6lMzL5tAo/PgkttAFHgy+3m8nsH1dPdKOLZfcr?=
 =?us-ascii?Q?oH4CuLSY2bifveCdwbzI0E0+z6/DM4jP9SVzpcDevdKHDDl52og4E+qfzslR?=
 =?us-ascii?Q?3ZLdj8n0J90oFhLPywzgvsu6Iwe1diymWbP6BZ8MHqwAZelTGrsgInlMU9PO?=
 =?us-ascii?Q?cf6jYgqf01lCzo871QrJKNEa9Gprok1y5pGw62E8kUYuiBYLdFc4MNi8Pgg9?=
 =?us-ascii?Q?W0Ql7rRJRC2qFTnFDq+td8jruH37Kp5siqZ+kdyDEDB3hiq8YPi12vV8IQCh?=
 =?us-ascii?Q?9j/2tm+v1JiWJqrSapK8e6TUTyoELMZm9ySmwjjchVLEK7ef1mhj126SABCR?=
 =?us-ascii?Q?jI/SlRwiAwzV9G6q6AJ7N7Ybp/VdGw2o7o1YlIU6Z0X0Fyu1R5cqBthONIr+?=
 =?us-ascii?Q?LNKd3Rjh6I0CxIge5RFKD4e6kwHFuKxBp44u9r91N7pTZg8QsKFCGs2GL4FN?=
 =?us-ascii?Q?RJleqE57yiDlJ9/A42tcD4+Jd6bkK1C2mtjgXS+j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6a7343-8fd6-456c-0aef-08da7a13da44
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 14:31:31.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0oPoRgzyAw0gIZH0B4K1SRrNp4PeF+v0ebhp6a73HQDK0aqw22orir99ewcVf+GwGfqb6TV0dSPEUmytIiu7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..4cbe3108a612
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
+    gpio0: gpio {
+        compatible = "fsl,imx8-scu-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
-- 
2.25.1

