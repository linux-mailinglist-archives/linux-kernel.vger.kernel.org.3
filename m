Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3F57ED2B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiGWJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbiGWJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F79930F57;
        Sat, 23 Jul 2022 02:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuaOEegWm9FHEWtoGgFH4oC7adsxTOQGCtuV9QRPV0SY3bumbh1mtFlQsOp5xJyVaIiRKUyuBE1oyOLcH3forusRa8yy4FW2Mg3mbhgAgR8cBXeMA1koG6xzdWJiX53YEVHQhHe7/rh6HnqNPdXSzYdxeU3gAbSb/LxUj2WIoTqtyteWoCKTvkmkx9i3Rk0SGy7lEssZR1dH60+ZjOs82CtDco7niaMrXvtlhdO9JUJ74yWVDBaGatG8ojCGapyt6+3oI7If10sRQXC0aDA2R/CfKqMCjXsPF1gQoyPLey42uYCzuQjmjoIkK03P3vM4yvInydO7AW4W1hFWl7A0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIBdLhYSUBeDizT+fgoKoBKY+babLvAo8/vUYmDGFEg=;
 b=aT+EwF3sH8+OpPRfue5Y7OFjHsG62mw9l+8orVsx1rkLSwwEPp1IbiEpqfwQwP7SPYCx2XLm8w9ZkcpPjYf9xzefth7FQH0Z6tYOh3PuQnrco8ImcKx6gjl8I4fh2p5WxSsxXBYi8Tr7cd253MUsxusLpfLKWdjEZ3XRqkmA0EPRwv/odSHM8zdp8u4wZ7L033aB06GRuhwsJokcn6ebqvlN47zrwVPjAf1+wWBcmRtfOaw3gGyEVB3q61j5t4lbUo504BElsUlETzCjTKVN977Hbt5aWrcwUq0cN9PBf10yb6/d/A4eHTjfQVxjRyqwHHlJxLgXEz5F5jl58ktOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIBdLhYSUBeDizT+fgoKoBKY+babLvAo8/vUYmDGFEg=;
 b=cgMRAcSV9vA9OLrmCJHyqd5e3jBGd2EYjxDPDGv+rEuE/QgwGbAeCp5MZ0QImnPgb+A68pLSSxIBJD7or+OY8t4WLHzdr1gq8tX5l1thUjh6EYDfcV64qa9HMLdoongMtbogoqtWhtuHiiuXT0JH0/ggN+rUikC75pWVlUXvLP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3685.eurprd04.prod.outlook.com (2603:10a6:209:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 09:42:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:42:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/9] dt-bindings: pinctrl: imx8mn: use minItems for fsl,pins
Date:   Sat, 23 Jul 2022 17:43:28 +0800
Message-Id: <20220723094335.3577048-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 526172ba-c8fa-4ea7-0654-08da6c8f9943
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3685:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUOYORvYnROgZfKtLjM4Ss5Ra7CIXtAOfmWVx+MITGoo3OgX586r2BkekvKs2z39tnyGPFZO8mR3o2pX/07wfz7r3nKZs9FQ3L2h7sF83b1qRFMUu1wO5BGR3McdLx+SrHz0wPvYSD6hIOD0imWlwAi76xkB/5mChmP8z5u50YU/Cuu6cbgx3rolBr7tA1/UbJ2QBRIpJ1+LSo5BEuwFvTNZLuCpZs+WTo28zBk+0QjjNzRtokEYP64yqoO57zBeYwuTlwKA0qdCDCKUFiUdUe1FzKBiJmJn3iuvhW7kRcWuJSaFvIAoS1fLxY2xKE5LJL5AHJ1eRe3hoJ1h566SFThzFMiFbFpkmE5Pf5Ef+SVnjrsK4l1jVOcxrEebwaxjvZYNe6adAw8jZSdgRPJUJ+Uwb5KU2IjqqkUBA4Xt5e5U1LoX+Uy2VDq+Aa2xMpmbPg4D/A/LLfj4Ozn0UBy3aVkE5wTEzVIVFGSvIPP5HeQIUAZrOGzOzwCh5aUHmMTBNBHL9LsttzscAm0mPduj57Js7z5K59nRIetMOnU5ySNQYH6hVgTUX6PlFpG+0o/qapMS6dc/NkiJs0MMy0s/YGkazhGuiPa/jFPsz4Dtvn3dbmiLq5lqeWJtlgrqnYMm04qBLaQbSGeKm8h++i/Akm3Nd8VMjQPijG9tbJkiObb9BhkfdKPqLDr7PpSJphmLlxXQUyUNW8edcgNRZkujD+XeNTdihaIlo4frQvNl+U94yADX/5eYk0xCfPtXTUI7JKMYFw//nxXIUvaxUhR5h7+VHde/852vy7eOdj4j9yIp71pczo4Q5PxaN0YtkAjaZac/rTRAExHz0eHJQcti7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(66476007)(4326008)(8936002)(6506007)(7416002)(6512007)(186003)(2906002)(66946007)(66556008)(8676002)(86362001)(52116002)(4744005)(38100700002)(38350700002)(478600001)(6666004)(1076003)(6486002)(26005)(41300700001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i7hncwZj5xfxNREOsCmLch8maz0VHtXK+55ivqbXY7Uef5RZjGze5C+WaUV5?=
 =?us-ascii?Q?Ff1F/y1sVW4ySe/8e4RdKL4yI2Bh9sidGen4TKCeTGtLs5MaH3vrUimqRiuA?=
 =?us-ascii?Q?kGURgoexiKEHseAn/0P98CqfbakRYiaQ/TDMS4d/Xd2vDtgipo1B+xzqPbAa?=
 =?us-ascii?Q?AqTBCMes6+816Wk53o17OOL3D/QtjkVMCsfZQQUZAFPf7Z3ythT3xZZylSKB?=
 =?us-ascii?Q?FAtz3n9n7VwQr46JN+sqHqJX8EcV+BJNlop9MgQOwNNbZv4G/TVTmnOlBgtd?=
 =?us-ascii?Q?3/HE54O/HSX3PIqAeGvm9K3snuH1ZYrDxpu3vtjgKIa+XlB8AMZERvWcK1fO?=
 =?us-ascii?Q?HafwcusjBZ9MVFgIQLI2Q8VA1gQkLFVAcFK38w7bPYlwUo3iDtyzFoDcvoqq?=
 =?us-ascii?Q?Zl6cgS+H4MIz5J6qG+XoSCl6JIWphecBrfscVViPD01Ra3buvOtb76hl0vuK?=
 =?us-ascii?Q?kEpRIHcKZsu5av3KmApnsjiU8L2834/wRJFGICS1dkMF3mSOHVx/sRF7ppQl?=
 =?us-ascii?Q?11m7eL7ZKYzkc3LkxCUkT3qMpZ2Pfltz/db0w2iiz8OH5LYEfdEIlUTrW1JR?=
 =?us-ascii?Q?IRLzUo2sX2yqIR5EI8MJ4P6MW9tDQVmU+HqgeGz4kiUg2bQN1GlidqK9s+/L?=
 =?us-ascii?Q?s8wOiKPIegmixUMuR5oKQdBO+giBrSYh3rZrU0WoYq6m0QxSzZZGggTGzCi6?=
 =?us-ascii?Q?I//kvG2RccwsIV9PDbbuatb9/blVH8kml1ZmDi4IMTPznSx4HWO+PgBI4ii7?=
 =?us-ascii?Q?g34U0BJ7RBdliMN1WBRFaYGLbxDB3vTatLDIhqjbag4NDcOJiOOjqU67hfUI?=
 =?us-ascii?Q?Y/LA6+/XAoFWmiyf6MzbUIIEgbCmLaK8X+/1UQhfyHXzLy67CNmKppb7fJ6I?=
 =?us-ascii?Q?VNrZIxGIDm585rSNBYnw4ybQNPChk7vzJWVoJB+QQEZdxPzQrGMxx6f/Tu8R?=
 =?us-ascii?Q?3dj9RTxa2aOsAp7EXCdamREd2CloKgFpx3Q2qB7exEp2xcIjjqaAC0ZswPTc?=
 =?us-ascii?Q?a1fg+D3FiQeetbQACDMua0Hfa4kJ08F6cm1sTvySMb4VmAgynWY+8cJ/5dNx?=
 =?us-ascii?Q?yqPtuOYnsa/9nbT1GLrqO59HfhycrRRa7MLqwkdBzUIhx1ttx3ajIrXFY1aA?=
 =?us-ascii?Q?PmnfdAr1XD2FeybZtqqTtY+m2OoAhP26+wAZJjlOJFBeF8xIoCJNN5Tn93Zg?=
 =?us-ascii?Q?t8sHwNKYSR/0t/z5jlUyxQex46lBfL0QFIsU+kEZaeK4hmkUwz5JxVOkguhG?=
 =?us-ascii?Q?kIT1evMOFl70KkbHEDXrLgdRP45UpOAutXpENQtPXwsvptXk5fX3x5tEzBNg?=
 =?us-ascii?Q?CtedcxMh+cw58qh/TYqeh+pxa3VUp2unWxL3qfKRLuh3vm66Y5nDUVGFrDPs?=
 =?us-ascii?Q?FRPrEjdvgPtyVVVAphWLz+8dVJy7/aj19QwfCifDL0jsz2DTCpVsveC7V//g?=
 =?us-ascii?Q?CnMulq3EauN3EmDL7NKi39jnjjF5Dr9t6yWy0qsQ6aR5mflwPTwbcqAS+bxO?=
 =?us-ascii?Q?gUzJpFkdjJa9BeIxSJnjTV5qfomb6HQI3RloWhPjfpfOCbmH3nnNTzr+Ab7m?=
 =?us-ascii?Q?QcaxtOFvYJ9UU5P5RXucMYPA+lo1/rfY0tecJui1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526172ba-c8fa-4ea7-0654-08da6c8f9943
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:42:03.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6p+4E7bKMWtbR7OZTqBZjgPAidnZLsQQR6iwLLBVJvcyCnvxOOZtzebATMQjKe6kfKkZggC+y9/M3Dwv4aRyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use minItems for fsl,pins

Fixes: f4a776f75266 ("dt-bindings: pinctrl: Convert i.MX8MN to json-schema")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
index b1cdbb56d4e4..5d7fed569cc1 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
@@ -52,6 +52,7 @@ patternProperties:
                 "input_val" indicates the select input value to be applied.
             - description: |
                 "pad_setting" indicates the pad configuration value to be applied.
+          minItems: 1
 
     required:
       - fsl,pins
-- 
2.25.1

