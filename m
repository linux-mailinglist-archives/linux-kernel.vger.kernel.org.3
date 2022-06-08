Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A775439A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiFHQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbiFHQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:51 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE4BA9B1;
        Wed,  8 Jun 2022 09:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mmg3CHjQ3NpxFoAUf2zOCeK8C1JnS2ijQO5QJc8XrYqu3W2pV8dEp50QooS1ZxVAtSnaFVoOJamY+ZkSPjmyqkzccbdLiRDgemMdcJ3oNS2wBIJeF1X57EtKpuXnQEKEd2jf5a7TenJymw3IbMiKcvE2wkhfKp9OqaNNwsFPGyxQogVLHxE/ynr4XTO7QKukyVybWLqleKcnKIxHL1CBvad3TwxwhghGmjwAqb9OBPQrgzyxnRzu5/NpHjLTWsmHLnOwAYgz8+oWWae/r/103xxSj4c2yWiMJ2/OzZdu7JI8viVws1R32sQFzxv4MVumJtdzUzeRKbfEPUXUPJWJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hco6TCJrMZkUFKp0ro7/epSlYhQqRvn8mJSQLxtfLPw=;
 b=U+lMv50NeX3T1HO5uKfq2Clb1ZTJICVRtG1x7b45zVpWK9DfTS/1OEjEHwtlmMzD4Z5kYvHw0xZjJHVo3g/5Ytr54NyA+RnGQKPCa2Oo0opkQCBWh5RbWGNZ3Kfq3WcCDtTxtkYnDJiOq+/J/RPInJCIENrLk1LOB4aGEgzi7w4rtycqhRHkjHtHiUhxEOx3Ec7Ej5pIRGo1fj2VXZH0x3GoFRiAqVp/DkDfCKcGN4oW4w8Kn1XRhafaRmIohzvpoSKFDHzMaS6HhZ/2f9jS5wOTM/ButwciaTmLaopzDkmCNs/nSOpT7zhV5uRes9pTz2qr9CRZglEAn2uMn+ffXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hco6TCJrMZkUFKp0ro7/epSlYhQqRvn8mJSQLxtfLPw=;
 b=VQHjHiNom5zQCRiIFpg9P75tTFIyn0xpjX5dyEIbSysOHRwOBkTcR6NteC73Y+dDoiOkDmLjwnWgcUOAs+EVpFaeQyTFsWLSJfIGLLOiRUD+tN2i35jODE5EWlGEblQniIiqgyq5zcBUGoA3/iMUoy004r6p2UR354XFmTcbJTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:47 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:47 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 03/10] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Wed,  8 Jun 2022 19:49:21 +0300
Message-Id: <20220608164928.2706697-4-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61ee65c8-352d-4057-e57d-08da496ee5b6
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7431FDD8731AB342D9C1B5F3F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44UdnRvXVlGDJRWC4/+r6udDPY0kAFS4gVL+aAke9NjYVIzBUf3dpDXaHC5fm4IlAP56ogsvL0DKBysu4K7DY1zAKOr9O5M3yicfRbElaw9VmwykOOEVVrc7Ti/L1b9U/1AObLNWZ6WXQ/a5mJPDxq1UsHN/nddSTrgFm35xx6+hVWQ2K65yqoIVVQY6BESqmOdS1qLsxIAwlR3UqUMnT63DMrXrXF5Co1iWz8Y+uIKTpFo21rQ+OkyMzcnz89ly96DfIfMCVRABACcjPd5fpuqiE4xtByAYcoHzuaObG0njgvfY4yAh3Wpjxmhe5Q+Hq6W6QsnYA4/x6Kq+xfxfO5w0ZxLSnEM8quLHGQud7xGk111mMpvvG5jvwE2bkpptgw63matMe/jcT2Z1tBV12g5WcLNSit+QXvITvVbTyTKO64oWfSmKLgLcZlC5XTRRVbL9xDKjTUMHyfGqb0rxgYMsLKXkX5KqbO2YuUd25yON/ndWfwUHCOGRr8eDwhQqUnWaQRmt/AXSq86X6jCClHRitD6WqzyW4YSZuV76xfJ18UxJTWYGEBxqDFr0nzyD038cD37hiQCgxyQpwEh7Zv9QyYewM2y3uMhjViAZEKBuswoxlunPRIqviypvPwdA+tsyxRdlmMQi4wDBp2N20efVapArRq/w2limzWWyNcMN77Dyaq++YBETjgHZz+CBrBVX8rJq5h5asr/IJOWKWHhOhEksRgs2DdRZZ+CRKyMXYrGV7KvFfeJUn4tjlP6cqXH5dSvayzYXqxldP5LGU9UjOgwYJIr0B/IxuISEQnxFFgM6yY6Wb6a6hJ6eblWz411ZxqyWhKeLvOwJpvWhCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y75eH70L8Vztz0qv4MS9BGDjciVZfQWa23c6yyNv7QGgYvlnKKxqGFlMAeiS?=
 =?us-ascii?Q?UVbnbBHz2/xSJXyk2Rmm2C6humPpHRk4OuTYYvCDzD9+MklUqAX37+siBJve?=
 =?us-ascii?Q?lC6OE/TA6EtpeHC9Qpmkrnbm4Ji1V4lZ5EMPb8vvMoh4ukxm+NFcEX7pW0St?=
 =?us-ascii?Q?rx8AOJ7ailFqocVMsvQ7IlFHDXxW5UR6bTUOLm5DhJHIXoHAf9qBe4lEddsu?=
 =?us-ascii?Q?Q4cDDUMEfb1V+MIoGrhweqrJMwvI5YIQdmxY3mC+tW4FhAVGc7Cvxhoeni5L?=
 =?us-ascii?Q?iCqOPW3yFAKigezS+T3fKrsYLJv/T6n7hNWMbNA5XwzEBdu4dHAkLj/FPuKY?=
 =?us-ascii?Q?cD2vd9lPZnc+FWeGw5FBIw7x96HNgBJWDEHajqA+yeupJE5ZHBPAHe53JE1e?=
 =?us-ascii?Q?Ij//xzGDspjWgIxI1wpP372MZhBFRtdFLs/Ayxe8SysvxiPNIzlMDgJ0Qv1P?=
 =?us-ascii?Q?+fhO1dUyhHAza5Ai3DaQJFVn52bBgeZ/vPWdLXgFwcq37+JUcQljVI2f7pRW?=
 =?us-ascii?Q?Kaj3jfksLzQKLmGtK/z3lLOSGKUBNsrWRYAmt8tDQET7T+T1SoGepfkU9cl/?=
 =?us-ascii?Q?NfGwNWcdO8mNeo26Jy/TwIika946d8LmdKdUFHlbNeYlB4nJFxHkM8uj2gj/?=
 =?us-ascii?Q?okd67nwtxPkNYpu3yvrdaTdmck7gmhamaPuYV/jv3N2L1PmPtJSbD2VBoICc?=
 =?us-ascii?Q?vn/Q155Oha+Rh2j59JOAqEakBCInQBLlczJAL+DRH3RgoEe4CPoximBrxgIv?=
 =?us-ascii?Q?aSFCQxV8ke4PZeYRBTDasQ3DIwZOsXbCaz069O/l5ylcgmyENOT1hUppa9lV?=
 =?us-ascii?Q?u06OJQA0J34qLvvG+vetkd7tupsmFr+aJSiRtUPmttUVYO4q6CduvxOsiJSY?=
 =?us-ascii?Q?ew2GtOD3Vs59WjejnP4nM7EgRuJQ7FDa4x1ak0HVvhwuMilJbGdEMOADW0XT?=
 =?us-ascii?Q?xrI4kNP6yqBtB1KPA8Z0kA3RwFmGLS1vyAMOXsSI+jYwCH2iEF5MsYFRDNU2?=
 =?us-ascii?Q?5s6CSRQJV5XZRiuDacPRmxqdPHm9GJ1COGVHdHZfkIS7caMNk/mmNG3oNcD0?=
 =?us-ascii?Q?QMKpH94EAWc3SYNgdgGxaRfVC2LMItVXRMXJ9R7i8ITwY3ViGljE33WB0ZFr?=
 =?us-ascii?Q?4wBm0Ig/P7+pThOoC6fRbSxpukrjcAP3KfhwcEk9xwjzK57itEWJ/KGnW0g9?=
 =?us-ascii?Q?X2EE+cjj4MuhxFXd1p3KhRMCsGNlhfiho5XrPpuow3ec39DXitDvobgWaMWG?=
 =?us-ascii?Q?wYp4LXCCGa5Bv9bnAqIGC4SN2CGvyzEg6546Vd1Alg1XTc5rFddcq0LoorsS?=
 =?us-ascii?Q?TmDIuYsBn/hsgTgjl5/231qWnfTIGUL2PHQWS4O4jIlFpFRn51+yOKW3e7CX?=
 =?us-ascii?Q?iKTBfr0yT9KWzAw5JGpcFQR/V9Z/3PxkBqpC6nCeIH+jLgX+6VCZAmR6SeyN?=
 =?us-ascii?Q?5+AoUvfLBA7YctTWZdso5FVq9g6xBfaEbVp/7dCB70CRPr8+wOnbhQJa9SLr?=
 =?us-ascii?Q?GsZ3nnBHqG3mg1SRIsilzBb0LPpBobsv5gSPhB4lKcS6igwKh1Nf6URoZcLD?=
 =?us-ascii?Q?74JduaidIBjIOEPs9XfKwdLC8tCS2whQOzJBkgSkrzeyaunWZO3MdBZsdjAp?=
 =?us-ascii?Q?r/vlrgfhCOwdRV6RJgUhjV+juUB7YDi3Z6YjWVz3dylJwv7fNOUDNejgsgWx?=
 =?us-ascii?Q?wfrsBdEDtXvC7BapyoCnjPmBWx57uOisuLOhePCocng7VnTbmsRiQSrjaNI6?=
 =?us-ascii?Q?mQs2H83T6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ee65c8-352d-4057-e57d-08da496ee5b6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:47.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tetlwc5M2MZ1Cq6rPmGPbodvEeBLV+MW09Vr86/p9zoJrqx9iDcj6QD9m88toRYm6/8b7t8xM5ihq7RAPPZ9XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'iomux/pinctrl' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
new file mode 100644
index 000000000000..d325340403ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the i.MX common pinctrl binding.
+  (Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt)
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-iomuxc
+          - fsl,imx8qxp-iomuxc
+          - fsl,imx8dxl-iomuxc
+
+patternProperties:
+  "grp$":
+    type: object
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.34.3

