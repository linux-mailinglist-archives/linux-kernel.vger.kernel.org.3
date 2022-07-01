Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D105631DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiGAKpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiGAKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:45:49 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00089.outbound.protection.outlook.com [40.107.0.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4C974785;
        Fri,  1 Jul 2022 03:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1xWFacUY4ffSIo/H5WfztWxXasrH2DMUM6GuUWsl5vTHPWj5ZX98vHVEloMObKCOx5RxOLjHHShcmO2azuNUi7LhQEXQpgGiZGzoX5q9oY+pABURHyJWvCA0hUlwxLou9BnDu2WyT+cbgOc+9K5FuPw4n7OH1G48w5tCw2H1C/JC9htUVhnQ/PxUE/3c/fz+Xv1h64YP1+BNsRuG8KJWQ2mUln3XMI3c6cFEu296p9eYKvdJOMQOb3WXQFcx5YCve0614FJriYEfTExsaYMudVruqonsP+sPgZTFdAu05LeomslNa7HR4tbFONaOKr1OkB4ib8FIB22mzBW/ykavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNBSFZAt5BRu1uVRtvnSrPSzRusjNj7+XOCxOmz0WHM=;
 b=XMvDG57Yr1IbXLjgCYtf/Ewwl0EBzgJqpGRZAbCxPtfgHnc+y6ljodn1vt/7q9F1NEkrsL6E9332w6CoXFUx0vvWLz5gUeFPKJGiSMDodWF1/LWJr6zSjSVs8PcogGy5MeJpG3ugrme9I34DOg30xFyeQUjQ5mpueYUNcXtFxOvYwJmNaiYL9wIPk2Csva8TxiI9ZnTeaaW3BDc4qZ+88oMGZsfaMHVHEVjMd9Kbxv+70z8UNPNk4RQFa4VlqUOkLKRw4dGXL3bC+HCUbdw2jLWuVAkwXt3jqh3MOHXSsM5WAw7IvDMTn1yYxZ2SfgTQzrtzp4rEcnTZzJIB6P5ALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNBSFZAt5BRu1uVRtvnSrPSzRusjNj7+XOCxOmz0WHM=;
 b=lbROq/cdtQbIN+LS4jPmB0oBkA4dFcyc7h+V5XE2K/+AMXgXrS6mOVwmH8FOayt5yto7oDuQtgV/CiJbPDfLim8xCUmU7yMjKdvQ3Rxn8xvUi19TwJRhjCF4VUw7LF7Kz+cuF79DqOiLbF8VlGLpApEGiTwcn5NEc3+b2qF29uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 10:45:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 10:45:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V4 1/6] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Date:   Fri,  1 Jul 2022 18:47:20 +0800
Message-Id: <20220701104725.557314-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701104725.557314-1-peng.fan@oss.nxp.com>
References: <20220701104725.557314-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe918483-6e4b-4bc0-0ea0-08da5b4eda8e
X-MS-TrafficTypeDiagnostic: AS8PR04MB7974:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TYQfH4FDSjSTuAyjtnNYncEKxS1vOsom/J77C2x7L14rUKB0F8ZvkhWo4517sOtqyy6txRpKLYFKPOODTS9L5aC4v9iMpYYRf/1ksrsDRPSxQQ3iL/oCKW+707jWj+Ty86eJHBTvn5gC2p5xeVs+/EiRZ4pffKqTfNVx0yxzqIaiQCG3yJ6AqIP6hUWa5+4fckhfbkq1cGKOyxT6MicFqtHl0abmZTy4oUqD0+x7r4o56dK8FPrRX+1biGcKa5zaZtCXrWoR+0JDHL0Ry4bxD9jbb4x+hpTJhjKgZT/LjiTCYdH3PInu25v8sHzvhnBBVRz5+w8FtZr8UK73XBNv82QxbWFDy+3CMGgMicCfkeY8RzJyI4utQ9AKX6QuKJdNA70A2ZLMxhdA0Wlb+VFng2f+ajwo0MhJ8wVXlJANk5UTROFku578cW/byaBgfK6NKTVtRGRCF5jx3r7zhdl7jopUXGBJNvYFMwUcitQWI7RUR1Fo+U2Xj/P+Qq6svYyDqQucRdzLFHMaMi7zrgP0QvOhHMhaLq82t+5hDTocOJiAhUpA01x9sEQLwzIdricMVWEaF70OanUmFj6lshJWsgwBIEj2ljAjkbJmMbWCYr6EMjDc5VAOjpDkavF2CHC35lKcWzs3uP4frw+zf0pqsKgCUHRUtQBNZpxjGK7mJrnwA5edilWAqx/LwhD9Osk7BAxOuBs9lHK7XI9arbqToBdRZB71oltLEe0d6G4qmFfWu4BjtQbob8ffZPrZPInPtO5NgPRzOhBijyjOh33mrNEQMcI/DNDLskEFB5WLS0rWG1G3uQqm8w/OMGl+L0P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(478600001)(7416002)(6486002)(38100700002)(38350700002)(66556008)(26005)(52116002)(6512007)(1076003)(6506007)(8936002)(86362001)(6666004)(2616005)(2906002)(186003)(41300700001)(5660300002)(4326008)(8676002)(316002)(54906003)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tgnhZrKUkij8I/1HXr2652eoezWTlEQ7/JRzfD28g8Q3t+oJJtZgQOpHOp50?=
 =?us-ascii?Q?b/OYTrEhGcY9fSzwSi6rRned+6ysAS84GHRsHxcgtj+Rap7gqwfQm7k0IlQ7?=
 =?us-ascii?Q?B0e0nNaUFBZE7wKw1ad894jI4eLOXXie78GE9Tgfn0qQYJU+MDn0GdneItwb?=
 =?us-ascii?Q?odjfbk3FTzbPdfr8Ecz9SgbV7VXrQj8QO/gMY5cxG+5jJ8WsxmOs3hLnzC79?=
 =?us-ascii?Q?Bu9hfl1Wl1uPX/iWgWl/lFt2r52BzTQIhUzf4rruXzOtxiiq6EyQssos+2rU?=
 =?us-ascii?Q?QpB9IeXsA/D7ZGdX8rDrPymr5Irkp+/+Uq29QtiK6tcazWyN4kDN1kKuZ3uy?=
 =?us-ascii?Q?a/OnKknjMWJNxP+GgOJGTzZDtruV598GEDooKmlCOHy404m4e53Uvpd+fWYu?=
 =?us-ascii?Q?1SFWEryd6JXKDVIhDtrIaanbzad+yOk2aI/HB0AVL+uWLRKTpCh4aYA94ptS?=
 =?us-ascii?Q?hsHECMke07DX2/fZVzOxn9LhmL4bptqqU1MshRyh14hpaqcQwla1lF14B2jD?=
 =?us-ascii?Q?uW0fkdI9qZPC57qznaoJH/9fNA15RRjuuueLGxiMq116ilE+MmaRDIISUD8O?=
 =?us-ascii?Q?zH0PH0GbQZ74+FbnpVLoNGWJIilsSzTQK1NB/1G19oi3n8fY+JFLI/piuPbU?=
 =?us-ascii?Q?epCiZaL/pRVnar8zNHGQxErLM7dlvGloIijn72UrCfP2bWaOHeUFvZPJ5ms+?=
 =?us-ascii?Q?MIEovtoCZA3Ufd/XswZ/We2chiOMAUfyksjvgOyLGXksYw1qNr6rRUjOqIfv?=
 =?us-ascii?Q?iKqQtVS6D/aALaXEgYjTckYRNoSIesBU4XcffVdOn69Px7t0/puvKPSazPFD?=
 =?us-ascii?Q?3ord/Hw4dNK04fNlw/+RLUJl0KOA8t0zM7VDoq2HPlEekabWK18XJ4quYcQv?=
 =?us-ascii?Q?81s3tdCEt3couWzxIVilJe1jT9RTPGE6OUdStdKbqJTJCpTI8OIpmgXxPyGG?=
 =?us-ascii?Q?qmgmUT1CsNnHYEp70vg4Po8d3jBxjX4Bq6T5ZvGkhupYKH0cb2zK6Z0nRVLH?=
 =?us-ascii?Q?aaVjh9CbweBWoWfOGp9k6OlIoKReHXqIWgO5Y8gPPwvSgFHRodZ0dtoOnLAC?=
 =?us-ascii?Q?AOemuJtB7fVBet7b1cDp+joDXR4/P3NCQlYNox9bVmReSI/6RUsmSLLT8EqR?=
 =?us-ascii?Q?kiJEb6u1aRQQeITKKM6Xx/WslGBhMgrQ27D8TKKiTaSsRY788YhC1fHp0YeG?=
 =?us-ascii?Q?jieSOUfK1dIH3kfXbb56ocqQ4cYvhsov+vFh3KqsJtgd+aq1ZHieypCH8rgb?=
 =?us-ascii?Q?bDVSusxcfYK+dbN3yymfAm+5GFKkZuzSqQ/eGRaqAow+6LRvRiItGfIPq4p6?=
 =?us-ascii?Q?jKIebuO1UiMUUgv/QBxv7tsxJGTwrmpLEQ0gYMr5s+UzvXp9HaWu210TOf/g?=
 =?us-ascii?Q?lhuhGQjEE16rw4mtCT1itca0HddjfT8AX25hH+Y6kqZVlwdBayWpZfiJqHwj?=
 =?us-ascii?Q?qS0yMI5Jpa3UTmB41wThCeR01hiDn+xHv+7hx7lTLbjxtkiCbxx1OXWVbSfd?=
 =?us-ascii?Q?czuyrmTe2eTwWq/LSnF/clFgYisqqVkKH+3qrIiNrA3bfj4lw8MGhXNj48Z1?=
 =?us-ascii?Q?SmBQ8osxiZ5UD+N09Sq5oyq8kvCubz2V9tdpJilP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe918483-6e4b-4bc0-0ea0-08da5b4eda8e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 10:45:46.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj3EbI80+KWCGBP1c9hMZgtnxA23Kn+0tWqomKELdq34EAE9lOoUOyfbFefboMFIcocP6JGeOyqhgwYlzT31qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QXP compatible

Add a new property fsl,resource-id for SoC which supports SCFW.
This property is used to check whether remote process is under control
of Linux or not.

Add fsl,entry-address to specify the entry address which used by SCFW
to kick M4.

To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
cores, need power up M4 through SCFW, then M4 could start. So introduce
power-domains property

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/remoteproc/fsl,imx-rproc.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index 3a1f59ad79e2..70322e57b6ff 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
       - fsl,imx8mq-cm4
+      - fsl,imx8qxp-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx93-cm33
 
@@ -54,12 +55,26 @@ properties:
     minItems: 1
     maxItems: 32
 
+  power-domains:
+    maxItems: 8
+
   fsl,auto-boot:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
       Indicate whether need to load the default firmware and start the remote
       processor automatically.
 
+  fsl,entry-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specify CPU entry address for SCU enabled processor.
+
+  fsl,resource-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This property is to specify the resource id of the remote processor in SoC
+      which supports SCFW
+
 required:
   - compatible
 
-- 
2.25.1

