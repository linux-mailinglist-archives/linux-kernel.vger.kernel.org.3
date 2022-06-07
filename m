Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE953FCCB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiFGLCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbiFGLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95C4B1DD;
        Tue,  7 Jun 2022 04:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m87+ytyFVFFHuO4qXPYO3JYmIkLzuuAXgoL/IrSZllcK09/MKcqgr0pMaWtexUotfC6WJkTvApgbz8F8HpTo8AKpH7oEhLYSaAbotuD4lWaNihVzOEaJkCH/X52W3RdLqdXyXW92vEixE70JxtKOO4EZx3ed6qwTAolA+t/fG3nkT9dZCJjsbdlOikr5DVNc8fPfQmyIpKHL1sGarR/UrbKxVGd7hGstT6tz9XkmPHhIkGSMAwHTXIRjK+B0oT8mWCAFz9aaXmvvtDmgjyXrrDTAxH8+iD1AYq+mDDXhlMvm7Vws0VuSnQpmlS3+K7R6rUkSP9kntq7qhajhAruv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQey335zDC7/zkv8BXsj/9m8wFiyK1MjuzARO/ubneU=;
 b=db4jsKrZZ/sNE7Gj+xXrl+S5FH7eFesZTl4uBF+Yxo3XK/FweJvF69g/7yDnSre4VYGGJ49LyqzfLhMXSoxdFxHmKOYiCIYi+XH3t7Botitf2whQlnUw+9OhS7ancEUliFUC/JCkUIUoYefqLW449LfPW0fZCqiCE/CHwDQDs241nvFBregIDpRYws49WGIaxu107v3h4E94RjIDBy210Pqk3R4KxlV0HotxysVU3gMjsxuk0IIeBplqR+S3mR9rcpdXirI42qLqVrhRlmJpqUZdwANwM8D9LiocP9C3QikFhjXU9L5PQ4SciMVQtcim10sjsrJ6US7CwhhqsbVntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQey335zDC7/zkv8BXsj/9m8wFiyK1MjuzARO/ubneU=;
 b=ZkwaRlahc690kltDKTILtmKi55z7djaERP8hBb2yVTIJ/idD71LEG7gEo1jxcjcp2OamHav2h32t3zOH6lYWZugOfRJ24LRMzY7SpQVrsAl+hWDMTJxLd63FjCk8y2YnnBNt4Lz9jNZg6nt3gUdamifkUfOZoOu6Us3hr1WExfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3008.eurprd04.prod.outlook.com (2603:10a6:802:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:10 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:10 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/10] dt-bindings: arm: freescale: Add fsl,scu-clk yaml file
Date:   Tue,  7 Jun 2022 13:59:43 +0300
Message-Id: <20220607105951.1821519-3-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67fd3118-d994-4694-350c-08da4874e3fd
X-MS-TrafficTypeDiagnostic: VI1PR04MB3008:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB30082032EAAF6A6E008CD1D2F6A59@VI1PR04MB3008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dLruJ67gjy/teEJoOZ8NiNK9kilgJN06c1uD3/83FHRIXH9abO3llcWiA28pnTPqEbLytxlTdNHhhj3Qg2WcdftN6vnJ5d18WOzBNSOl3PRLvGvfHhYxjd0R778+7uu1af7Hl4SxH2KrmvwglG1yQ89vNuXWc5jUwwz+9EVLIC07FhxGFp8iPa0tOlhs9RRMph2N6bDEi23dA3D7P8QNh8vqUheRtsI98thMJ9waQVJ00gtLj2zRacEKkfWwhy4CeSqWc5A4uETXtJykgSEMHUx1czMvQk6RuuyHOvtlZIKIrNKI1K160ZA1eg1+7w+/SJEQIZDUeXK4tE5iNv/aNewbDrHR6nRyfgiSRLtN7j3rIyRaB50c759GEF2qDHLM89rVWeVGSfwZpXYLqdVV6bBOIvE/A6RKVErYXwQ7L8h9uOvFB0pXrSRXPMF/eJX8mBxfuguQikF7gi9payaK8nzHStixRAiQ0nrpHFMfRc7jGGPp54QvvysNzrJXx3ZA2b9vWWu4Yvxtr6nN9jMk+UMi6K98gBwlZsBkm4abptfoejfvqpHn0G1uqFDIurZ3EpTTA8+9zH1k9UbICPhRQhV/GBiNqzqlrxud2RuVw/Q3ycgJx4j9+syXR3bgo3YyPVts3yfFmewnjPwlQXa0FyW8s7szB2xZBYqUy1WkIvBdtJVFc1t4IfFCiak4Zi0x4qIsvTqCU6NVe7gUHcnWYuEGGv8NoMdE7up7mJ/gEoSX2Za3M12xhN2duFfSztwmJSiqjWHKaH/cXdZEmHAkjkoD5r9ibWMyZUPrhYYi00cbVXn+gdZVlSlA/ZCfdYlxlbu9sQ88V4c0uezOVy3+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(36756003)(38350700002)(38100700002)(6666004)(966005)(52116002)(6486002)(86362001)(4326008)(66476007)(8676002)(2616005)(8936002)(186003)(5660300002)(2906002)(44832011)(508600001)(66556008)(1076003)(83380400001)(316002)(54906003)(110136005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44y5mnMRii28CDrMCvN1YKxMZ5Ngr6fUum/csF/rlZDN7G7JmISzAki4L/pg?=
 =?us-ascii?Q?DU791EqVVeLfu9jm92D1tVdIxWu3K1CBikeKlPwiIsH/2F74Iom0WYzeRLlF?=
 =?us-ascii?Q?ABSh9WBR0EsB9TmMIU5iklEMJNFwnN0ZvsF30JJ9p09195cS25GdAJSmcITI?=
 =?us-ascii?Q?I2RhJXZqq06ybMFGqYmZ+PpDGUsh3dUIPLZlyDSyhdwGBuLe4gTfoDR1n8NH?=
 =?us-ascii?Q?8oAqymuweAl+tlRpvqmuj3A9ias+VhkxWdLIN0kzWr2HDevRq651GGLxfi8K?=
 =?us-ascii?Q?QEEvwbB9gjKeLiSnXxcSRcihEnQRargM0n8hOYNjqZPTo3r26Nihn4jao+OB?=
 =?us-ascii?Q?xgnYfGVibPOswx5j7m4ZhxeVvdu4gwiSE4iceXU00l0Jd3OL9Wab0zgAqty5?=
 =?us-ascii?Q?n1jI/GytqD0UxgSUh8flzsXD5Btf78OOUXaEkoSxOZ8+9BZDXe0kvd3tzcnj?=
 =?us-ascii?Q?0cT+22Ut9EL0yN1rbIECtTthRByFBSzw0uOb/pwIP16gq2js3Z1MUTCIEm02?=
 =?us-ascii?Q?x2rHidpfQLAflMWvYfA5yyi4vKsLAkwYMo6gPCpoI+aK16mKFG2fp7fmmya3?=
 =?us-ascii?Q?8/mscRdnMJVF1YFyNZthyYccYSjb56dyjNsxVjhEHHV2MIX0VbLwpyxYG6SG?=
 =?us-ascii?Q?hnp5AEnhakaSbHSO2WchAiQO8xPUjkCUiv7YpfsZsWrMHPKCJ5OpPVRfpLUF?=
 =?us-ascii?Q?miCMT9Zk+vtfr4+88ZzgVq6VRxyaZkvwfLmuOY2XO5AhgO5GXSr0/M+5eYNc?=
 =?us-ascii?Q?6ShX2OkGD/XjxWcoTu+SMc/mMm6QpQkGsTOVss1r9BeusvlnkDJYT/FziB7F?=
 =?us-ascii?Q?mruzonyIpZXVwt7HvMAHGjcFBx0UYF+qJjJpMOraq/aKkczDxr59aNz93+ZK?=
 =?us-ascii?Q?U571ub+vC+OpdZj+kUZWPhJ2/9j22JheQ0eW560G3FZIQLWdWGEZJlrhPB87?=
 =?us-ascii?Q?u4Wi0JOP0tS3gQ9JLP700I+2RCwHJHfv8iv0xz5AxA/ATrJSgvgehDvsOw9y?=
 =?us-ascii?Q?I4FMn85D6GVtkXwtyIzKs96NUtTRsXLI8jIVYZkWnZKMQloutHui7J7dahH4?=
 =?us-ascii?Q?wSNE4l6dCn56DK+ujviCfaGx4eRZrwblWUul2S+txmUhlT/zxWKGTU41HOpE?=
 =?us-ascii?Q?WG6EJJlcILtG/YJuVC0WupsNq1Ds6WeNn+ztBVsPY7ru9W6oS/sh/ls1DhJ3?=
 =?us-ascii?Q?bjs5chJc7xnFNA45QOBW6TEJgrjAcFJRQgfEhlXbpVGD0M3/qYQbvaUUAEH0?=
 =?us-ascii?Q?lPpiS8baSIIDDeBkWKF1/HZWwMauG5Vn+s+7v0oeapNqQJN/XAbo32wrCmzK?=
 =?us-ascii?Q?AmTjgllZ1/T9nmzR6mTas42vxt3vOTaywRIrb0pQbisGVFHtAdjhy0Ixe2s+?=
 =?us-ascii?Q?ws0P0xi8ART1f0d+4g5YN29Cv84h6CoCZitrBqRs2yGvxVJeXdWknEieI7RX?=
 =?us-ascii?Q?b7FTId4KD4JbM41kTy92DNo7Rjtk670au/oJ7su0XEDGUeM2CDaniFmco6M8?=
 =?us-ascii?Q?rzcjmg0SkSxDTUEqwQX4/CYZvE4r2kSPfam+BRNR7mbCVKPuzehsCa9bVKRL?=
 =?us-ascii?Q?JB4ax7NroLYu90nqCF+fYDGxhvx/gKBtzc/DIHqFSwTl+RKX6nbES/7bIg4F?=
 =?us-ascii?Q?RKjXKEuLXa8GcuvppnM5sm8zU5RqxWL+r9ipeORs6lvtn5d3FCPzreNPwqaR?=
 =?us-ascii?Q?syE7GGyt8SSC6mfNj7AzBkActkPQEth0rzuxQNGyoD1noI6WHiZO6bhLnt9T?=
 =?us-ascii?Q?2AiYzS9a1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fd3118-d994-4694-350c-08da4874e3fd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:10.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfvEf0L8Nq0+f2H8J4eacEK3vMfxNLl3i69dsRztpxuJ0nbusgmef+HFGAAcPTa7/ENT/5N3m/LZTb+IOFDzcg==
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

This documents separately the clock child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu-clk.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml
new file mode 100644
index 000000000000..f6b97439ce38
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Clock bindings based on SCU Message Protocol
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the common clock binding.
+  (Documentation/devicetree/bindings/clock/clock-bindings.txt)
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell.
+  See the full list of clock IDs from
+  include/dt-bindings/clock/imx8qxp-clock.h
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx8dxl-clk
+              - fsl,imx8qm-clk
+              - fsl,imx8qxp-clk
+          - const: fsl,scu-clk
+      - items:
+          - const: fsl,imx8qxp-clk
+  '#clock-cells':
+    const: 2
+  clocks:
+    minItems: 1
+    maxItems: 3
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#clock-cells'
-- 
2.34.3

