Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670F554DBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359567AbiFPHiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359590AbiFPHiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:24 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30045.outbound.protection.outlook.com [40.107.3.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A956412;
        Thu, 16 Jun 2022 00:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc6ae9gQ1BD8fzgOVzMB0Bf68fi9H5mA6YaWhblYP+AaYk0DtqWVyU8uUkS5uaRKpDKyTOT58jAuxFknSuaCj1zjHebEmIM706v/AYEwyqcEVuYpDOyewRAqsIV+HjjlZwWnRfumBpdjqGf7IvGaDkBJf2GiS2OVIeKeNBDf88usboVBva//4qqYLXy/srmC2WR58HRxkY6Gy8JDDq7tmTDFpuMf+FwPPZwAhEvU4x6XmksTCw4gK8DLuaeoRHNpUHfeYmwEpATYLXls6mNKfd1bqXh6xLZtIk7lpJBP2gi7rYk5UUuEqdxNnPHhkmnP/YlaErBby6Hy3clqG+xLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLhlNisqvlpwQtd5Dm08Rk/xcIL5USTSTUhDsl8b+U0=;
 b=jUxZZwkNu+4ani1lcHI80FxfviEYoTKQhf/lDU6tBjpRv8Wwnif0eekO6UPAf6rf6zv54fNcYHY++zLT4CCubmDWKaOedq6WpQa+b+mRZi7Ga14taoZ9bMbNhd8Mflef3gmTQFOcYp8yrF/vMH1wfCPHVGryyTZd0ijYf/ZmKk+d8jY9J57zt5vg8lMNn5rdjaEkiPiOEjBbDY8x6X0Y8fEHZSXkkw2QGVooK04estO3TvKZRvBqcUKSIJV64RSdaLf8DVyX85VxdqrAwK/nXdUjUFbI6+RN1p/gWqfhorQAI/hHdDmA9jrK2C0iNjDjXJXH0ENJ1ekbEIfQBZeUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLhlNisqvlpwQtd5Dm08Rk/xcIL5USTSTUhDsl8b+U0=;
 b=KusQwvwArb25bs1JSJdEO3RetbOg/eaodOF5XnuW08Nmk5ALLcdZzwpVcpzEwN04Gp5NhyTeLvnixbX8mPWusaMrAk4l/RJBpei8va0jX9SkewPgj41WkSiOhnV2S++2AvgUo8dVRmR86hcv49WNBkPoB4Cqkk69ZmJsYO4woK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 07:38:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 2/8] dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk ctrl
Date:   Thu, 16 Jun 2022 15:39:47 +0800
Message-Id: <20220616073953.2204978-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
References: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07381daa-e8f1-462e-7e80-08da4f6b2d25
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB429332589B1A9A251A8454CDC9AC9@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhnwRvjiU+G8w4LlfUI3x2vuyoWfv3ATFFOED+EJGXARNvJ8m0MfCTqTCpIh2cxNqGIKG4T3/fLju1QzJEuOJlMLz45oov0g01tS/yDByL1/PxRHIxqTuCRB+P2lhFL+mYECzw5WBWU6GYfcgWY20WUWYN4R1shffXxAFwHuKcYUDANQo3T/4NcJ7wuiFty9QLUCCsPTAMXL9ENZD8H19OBAi343Qy2T63x7PvFKwRs3J5hPzMA931mlBi84vE+LkStLxxpblKoYNIgO2dFyEZOWtjUkHcUH1gI6QtLi4TiNbVwBGPcQyL5DQWWuedzn9U+5C0CiQAa7g24YsES0OUMen9+M+sikNhxlyMiDHA7OUFrAnRklWABpd4o5nJZB9CZn0znElDIKC32SPp9w72z4fHDGDdu827WzFJ5pgEplWsqyWDeI6uKCYYMH1zDlOkJhccI8/RzUxiil/2znTZSxa00nVh92BnhRKKM07OsqjolD9z0fXE5uxxpwX/SCdxU9ZgEjBMX+/AL05wgQjbCu//F13UwpQyHemFeRwDXAFkL4Zgh+lzFcyt4a5nMYfKjtvycO7m/3VWHJ088kwDarbpIGwz2VdleIx5RcGNJelWm7KwuXBgLqs215RoArMSQkERf6tdhIbAEUEtmOLmIZVJvfLCBUJD/R9gcPb1uqDmkpUyb5tG17txM9MBWrah/JYyoK0w3RtudQDY18rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(6512007)(4326008)(2616005)(5660300002)(66946007)(8676002)(2906002)(7416002)(86362001)(6506007)(66556008)(508600001)(6486002)(8936002)(66476007)(52116002)(26005)(4744005)(316002)(6666004)(54906003)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wj4rDlZ0V9XSTO4kb61E21l8SLI1lor+r6551dcYK3/vltb/CvHJrBSyoDvS?=
 =?us-ascii?Q?HkLSASGM10BbNXq3EkipKgu0in1a5Fpnce5eLXl3bd1JAo0B2nslBlaJdcNG?=
 =?us-ascii?Q?hvx7xig1AxJgOJLGf59tBNQp1/qlQHXtVJqRPeu70fiAUvacdZ6DxN5FaRtn?=
 =?us-ascii?Q?xm0vTCoAOAfdhDNQlMZS2KXyzwLzq41TugnnWwV9fmI6knf0gDSdQA0Mp7ep?=
 =?us-ascii?Q?qRDV8iAnq6EfBu015yhk1zd2phWU3sS/RG3KSGA1/c3IWFyfDuSBF0WgrJv7?=
 =?us-ascii?Q?7P4dCOzJ2Y1qh8nZGh0Ei9Rw9QM2Zd+lSCf16ltOCT8hZDzIhjO/ve+jA/16?=
 =?us-ascii?Q?ZINiaYpVl+iWEYkvTBTp5toG5cxY3J2jWzZY9ytwS7C28j58c6ujJnMLfpcn?=
 =?us-ascii?Q?+7F6i/9PqzopkXpuz46IZUt2GgKxHgBwAxVtysxBgIS60uCx38Ipp8TjIxM9?=
 =?us-ascii?Q?HxG1mXEuYpMZ3oKHDMS31uNDKmkEO32eu1dP2UN938HUHGZzv04Lwax7zSG4?=
 =?us-ascii?Q?CmbfmqFoH7qH+go0rRX4U5pH86ana4k2wmyotlJeieH6D6IxBVkSYZ1UT/UK?=
 =?us-ascii?Q?QdA5asCoKd7EgwytdoS/3K61jvYArD79diwo0RuYxUe0OMYC+ZYRx+gj54pR?=
 =?us-ascii?Q?r1Ew68Tj4W1YxGnfnkLie1hL4TwdkDglxnJGotXdqjeXYkCE3ggyXqfkTMfD?=
 =?us-ascii?Q?4rB/XJq8u/Wc3KFfzdNSYZCyE1UmRWj47//QJHn4QxTyNqpK9RdgBpo7MIpr?=
 =?us-ascii?Q?InPy014wJ/39P4+PUKFyqxsew3W2eGKFwOquKx8LNgD/xMn9P0CezUn2BWPG?=
 =?us-ascii?Q?C8Hi5MoNBR5DeSOyvxbXxhIq7I7vgpV+UQjT4ZxOJ8yzjDs0d0Hsc/usjYVU?=
 =?us-ascii?Q?+N8l7d1jFZWDn/WW8fdycO1zzVPruO8yOFm5hj1PPRairq3thoEQErFqXD4V?=
 =?us-ascii?Q?YE7XCce9jflshlgENwDgBSWu18HzDvgB6Y1Lzyb6g9dzhgEAQ8Oh80RSqG+x?=
 =?us-ascii?Q?MvQoMqqLhA7AleRk5SB5VayoGtL5gdx+ncZArcVi/9TGn37aqLolmfToHywq?=
 =?us-ascii?Q?pf91YkgipQDmct2XlySqmrX8kw07xNuJgjcJN5q0mBhI2dGfDQ2CxUFGVM15?=
 =?us-ascii?Q?4K5sHyrilEL1aGALmS+R7N4/Td04T/Q8EfkpMBPSo2YadCOr0wZYPNnoIo92?=
 =?us-ascii?Q?UFEOrzNtZ23EQwXF7b5UGgRoyFgCqAkO0g0RnvV/AQ6yZzwS8noC2iRce3Vd?=
 =?us-ascii?Q?vpUYTxPojhwRlTPfbvBSt3DHVtINOdGpQnapGQE/lv3NuSIdLJtkNENTmTVT?=
 =?us-ascii?Q?solHMUz8BZLTEJpc+fvIn/hM6e3GUo9pD9aYkUAa1ka6YCDKKboYb7jHN5xe?=
 =?us-ascii?Q?csOgLKjfBoIbz4vZaU6aCCB6GTaAYUWF4xppvJZ8Iy/A7omvqs0dfooOK1ci?=
 =?us-ascii?Q?mViIcMXq8g+daoTuw7hDYkTWnWuu+6uaKA5cMmq79G2pG6QhE7KCR6eZO2qy?=
 =?us-ascii?Q?15iJ04w2gpcaTNBFnXuh02Qbg6FOmEuA5monaFILk9JbwKOcajnpJNThj+Jx?=
 =?us-ascii?Q?cAHyoM3UYrCNtVl0fRVDuuAGjfnaDkdkHUErA7DUtMbMgDhrRVkQvBm2sXba?=
 =?us-ascii?Q?R2dOVAVYKR5YEWWUY1vnQqmMimAzOM5lsrv8JE1KCYfNn+rJ1KhDUu7RbIFr?=
 =?us-ascii?Q?sXHieJ+wFh6AxFhgEj2iBtxuMj6ZLohX1aCGjbd2L6pTjyTzsUJWL/9CShLw?=
 =?us-ascii?Q?BdyMKP38lQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07381daa-e8f1-462e-7e80-08da4f6b2d25
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:16.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ALoCq90U+iMXMSnFgVxi/AtrWN5ki9UbzKIKNaXmrBGPWGoY8z3SkcayOguEjGlKvniAFvr6xISDF1CqOifcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP hdmi blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
index 563e1d0e327f..1be4ce2a45e8 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
@@ -52,6 +52,15 @@ properties:
       - const: ref_266m
       - const: ref_24m
 
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    items:
+      - const: hrv
+      - const: lcdif-hdmi
+      - const: hdcp
+
 required:
   - compatible
   - reg
-- 
2.25.1

