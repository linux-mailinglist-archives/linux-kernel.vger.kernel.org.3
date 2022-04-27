Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B212511440
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiD0JY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiD0JYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:24:24 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA6728E35D;
        Wed, 27 Apr 2022 02:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxi0vVAkwHPhbf+4wNTSdaj+2e5T2c3w0YsWhOmuHOW50SJ0X+HQCFNNT9CFvfLBAF08hndZ6wEl6inkg99WJl9TdI9dtpfKtH3tmXoBElhkrsxv/lr2+EJgzuoMbOevf0okHcFsXg872L2OfXQ84jkGyOTI/ymqfhx/L5za44Jg2TO6a/cORXVhpylCeYeM/vZ7RvBWFnbAtiSIQAXI17F6moRJQ7udySQU0XNBLiFsDOYYPAjXuhtGE0P8OvY3InYKGD91cllC/33+QdqbRE/j5MU7YRn7w/vCXR2Gz47wYu8vxwxJqDxg9SBeSwT8B2Vr5vQawD70a4RR50IlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL6x8Q83Ck96DTCFE962M7gT794X42qpo/xnHvLGlhs=;
 b=SVaHfDToLFyTIwYdzREFvwnblDQlqfOxwG8VwkAjmWngYGX6e2Tu97HuJxfUR86Q0kiIaGa/60SQdB9dPoSVUje1FH+vuHoEkJgnnV6cH2t1gIbvw2tD3ohVznMfr5dQMhtI3ZV7JxIIZY+ISEPQnZ4OZGKWRCg/jG6vQrdt0vR82vGBDCkk4Zog/7JBnwgkPsB6ZZQkCyHZS1dlTnzPaiWCF4lSepK5168h3FBHyndbcr0+Jx0UkqMJje65VrZO5VPTgmaxwHm1T9LmrDx+yYaGaAh5cU9bu+DmJy8Q6erdSgptsi6bxmSEzXQBCPWaLSRe/O+HOpCT+FIqg8ttLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL6x8Q83Ck96DTCFE962M7gT794X42qpo/xnHvLGlhs=;
 b=CxO4WhcYYNodI/rs5lrfjN85YFuuvhVspVgMCdJXCna+v4a346l/cNhol00VTpYW8nQqqLlj4o4mN109LteNHPXH/dner8PZGp02R7G1sAd+EVEGNhMdaueMtMOi4rSKVHSxeAsP+UPy3RT5iCzM1VHCVOb8EK2NZXI/77iNx7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 09:19:25 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::587c:b068:1987:da36]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::587c:b068:1987:da36%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:19:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] remoteproc: imx_rproc: support i.MX93
Date:   Wed, 27 Apr 2022 17:20:54 +0800
Message-Id: <20220427092054.3765690-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427092054.3765690-1-peng.fan@oss.nxp.com>
References: <20220427092054.3765690-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98587aff-341f-4dd5-52e2-08da282f0605
X-MS-TrafficTypeDiagnostic: VI1PR04MB6848:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6848065A72B6ADAA612CACFDC9FA9@VI1PR04MB6848.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +smWnbyZF1w0e8YWSkczfjgAsL+Rf2Zza17ANaJsdCFTwA4EuYb6eipK4Z0M32msAhJ22nUaNl5tLRY9Z+4duZtVN+Nv6zCPH3Eq7PKj6JQMQAN/xBaVz7IOl/022yhZa/2z80jI8WlfkktLgcg7MTqMoLf24wZ7HwxK6mA+wfpTO3vLcq0WVQDG+IrCWCiJ2Yp7fAdRb8tSpSvEh/CDMMP9/WQfB30+R/pV+NsF2MHbiHtp+lCVULfk/lkItYBrVtzNQFl0qCqINs2GT1TOkbZAJpjHyHxUMpRZzfVYWlMnaOfndgCrcl/ab2UG6Uj9hbPSiFwcnL7pS2RUNPwIFtIg+KBfs0DtnWlbf2MFy9Ap6B3E+EFOoko89+/XHgw0Mp+wAkulCxRTxVRAuw3G1+5eNH3rdG/i6s6Geq5HCjfDgWz7H38D7sOeBZVTIIyt+Np4zO4S4RWMwRLWvanV9Y/qW+QFOpqJuqSJiE2kowH/mQFhGP7k0w5ZClZ0cFYaoK9YG/Mr2u/igTGWr0xouOTl3DcIyPpuOt48jpTGHoRWgImGWge18PLINtBp9c8OcRapaH53W7ONjGG7b2frtpx7jEVLx637uQW9T9v1uODfPp3VCi1j/ZVGRiNB401+86wyrqwN56z12VbPxTTK5dc9kXSeBAlWMeOAlYeZhp4RcKtzSA+3CejUassV06qD2GpEsD205Xr+4fvyIvwnx3pUI4xMv4mzpA+Fr1z5HSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(921005)(2616005)(508600001)(6486002)(52116002)(316002)(6666004)(6512007)(5660300002)(26005)(2906002)(6506007)(86362001)(186003)(66476007)(1076003)(66556008)(8676002)(66946007)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qsAZvjHQHtvRo+Bizwn6WW36pW34599sGd5p9EVD7rgHm6wslBQ9VYJVLtYL?=
 =?us-ascii?Q?djtlS6srnnwmZs8rcYlLc6ns+FN5hBhoHF/v+DgeA2OgTN0IWrlyZCYKYFwT?=
 =?us-ascii?Q?4txEGBj/BUU7YvUItirWTbnJ5SwnsdHTOumHLCxN4XzoXIH6HBMUxurGCp2L?=
 =?us-ascii?Q?RyufLmLXN1WRygcXOLKEkyrFUQeAJHyPXPl3m76GIGsKYvAF+9CKKHEwjpkv?=
 =?us-ascii?Q?5cdGIY6dvMUI5SDl76+5NjNXmu3UuCEP9fl752D4BuMH5S9X3ZbyRCGAjd0v?=
 =?us-ascii?Q?10I0fRG/84n1V7xHDF88uiT2U+BS1eMQIkETbHKozCNhO3F4lQahSpGvOALJ?=
 =?us-ascii?Q?w0H2UGWji5dtUXa3JNwDNHdzgN6rFh4GPNKSSGmqOxDQnnfRuZ7fhLdmvgT4?=
 =?us-ascii?Q?HoRJd3SObPFobrfp7oRy1ap4rtjWHzCpNNm5VgyAK25AtBbx/iU6CAvKe4Z4?=
 =?us-ascii?Q?W406RKOsoOulis8by4T0g6wj3EBEOjJ57mxwU3h48UrHbJl7FNXbBqZKaHf2?=
 =?us-ascii?Q?aYpxdgFyDlMWKWoYEmU3CAFZ/kBuEPlFkU134TDliAStB/aPHBvLycpatIL3?=
 =?us-ascii?Q?DwvafdHfe6xUqUxm5jziIRXzdp6WydD1RSuvZvkq02mehCXcKzs4CALVDDhB?=
 =?us-ascii?Q?uePV7jTSaWwjwcpbMfWxcpNXwOUtAFAe5lmuSDaDqc3TomlMyo0PTmyQ5nbE?=
 =?us-ascii?Q?v/jEJLrl56MJka5664L3VrZu1OUnwAMgrJVCJcgwcUk5QVt5qoRqTSvUK8xY?=
 =?us-ascii?Q?DXjKqpwjd5MbayKxxknLVaD36Dvo9x9gfpc/HyD1+Kt8whOc6CZiddVuFbRo?=
 =?us-ascii?Q?IqyZCORXqRZ7Dcm5dYFlyT+cvJUaoxgD6LhYJFaaoOEKyah27QLu44OFIflp?=
 =?us-ascii?Q?kZndlGU884G7ICMOAYS6Wz6g+31vjLae5bucKAg6CVK511MSU/yOVxGjCvOA?=
 =?us-ascii?Q?JFrywnF/nvU9c0tloTjmITF0lWM60h4QseTqgo4O7s3qfGwyZA6QZOZFGWQW?=
 =?us-ascii?Q?2paapT5YnNCVna2+nMBRnovBMJHanwLAYvHgOVOCwLMdhQQR6vLtIdHQRRbA?=
 =?us-ascii?Q?2GKu/iIloiaDaAIXuTdqpDRRNi/y9PNUfzY+yKCzy2JSsiopA4EXNIpRHkwo?=
 =?us-ascii?Q?z3a9h3cZKz2dFCXhqfrklsz9XOC9E58x9c0RNyVQS43tWWfABXcCdVIC6Rz0?=
 =?us-ascii?Q?1VB3saawaBl28g/utS8pHB/8QnEfM1jKNroxwY7QyyP4zxQ+bXdKeJFmM82D?=
 =?us-ascii?Q?/2d9RHEZVtcGgY0wQqUGALDqhb92IaY6SiJzpAIvmXCXaISXP5+V4hNhiucK?=
 =?us-ascii?Q?QwmQxpkCc2Voo6cCdTltg3teaH8cvnJZ7Fv9Qcg0tJyvLsJH8oBAZWDaAsy2?=
 =?us-ascii?Q?BPmMB6LXSGcH1YStmKco35DO/4gB8kgSiXliVYxL5rv8shbwX6t276TKxszi?=
 =?us-ascii?Q?UebLwNWwy5KP+En9Y8R4rJXYB7fImaq01HEkOa25vuxyR8ggixkNaU2qK8Og?=
 =?us-ascii?Q?cQwRjQH6JrFFJHd5AGa6i4yTvGVfWu4vZArfNejcRk59IZMNw6no841l1qi3?=
 =?us-ascii?Q?rmyaoIQSPKe+smG1nvbzMVq6YLnKbovIG1WDhH21nWX3UEDQ6mKuSDPM/b7z?=
 =?us-ascii?Q?YXJbf5uhfBZHdw55jX/vFOw0/1pBK42gd9GQomeZo5smLrJELJn8HGrK2JnA?=
 =?us-ascii?Q?mLKdECNyqkg3swhD2g4FKvSXY88Jw3krHmvUo0FB1lw9TUxn4P/GSpBBCNrh?=
 =?us-ascii?Q?AlLvfdQk2w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98587aff-341f-4dd5-52e2-08da282f0605
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:19:25.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZNQS57+zvpeeX+6wJsK0jhgtwWxR0OnLT3OyCJfiFv5ebAsYaEq0E+aGJfGYR3YYElVSdGt2vrR36iVz3+vEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 features a Cortex-M33 core which could be kicked by ROM/Bootloader
/Linux. Similar with i.MX8MN/P, we use SMC to trap into Arm Trusted
Firmware to start/stop the M33 core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 91eb037089ef..4a3352821b1d 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -91,6 +91,32 @@ struct imx_rproc {
 	void __iomem			*rsc_table;
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx93[] = {
+	/* dev addr , sys addr  , size	    , flags */
+	/* TCM CODE NON-SECURE */
+	{ 0x0FFC0000, 0x201C0000, 0x00020000, ATT_OWN | ATT_IOMEM },
+	{ 0x0FFE0000, 0x201E0000, 0x00020000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM CODE SECURE */
+	{ 0x1FFC0000, 0x201C0000, 0x00020000, ATT_OWN | ATT_IOMEM },
+	{ 0x1FFE0000, 0x201E0000, 0x00020000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM SYS NON-SECURE*/
+	{ 0x20000000, 0x20200000, 0x00020000, ATT_OWN | ATT_IOMEM },
+	{ 0x20020000, 0x20220000, 0x00020000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM SYS SECURE*/
+	{ 0x30000000, 0x20200000, 0x00020000, ATT_OWN | ATT_IOMEM },
+	{ 0x30020000, 0x20220000, 0x00020000, ATT_OWN | ATT_IOMEM },
+
+	/* DDR */
+	{ 0x80000000, 0x80000000, 0x10000000, 0 },
+	{ 0x90000000, 0x80000000, 0x10000000, 0 },
+
+	{ 0xC0000000, 0xa0000000, 0x10000000, 0 },
+	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
 	/* dev addr , sys addr  , size	    , flags */
 	/* ITCM   */
@@ -261,6 +287,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx6sx = {
 	.method		= IMX_RPROC_MMIO,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx93 = {
+	.att		= imx_rproc_att_imx93,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx93),
+	.method		= IMX_RPROC_SMC,
+};
+
 static int imx_rproc_start(struct rproc *rproc)
 {
 	struct imx_rproc *priv = rproc->priv;
@@ -824,6 +856,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
+	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx_rproc_of_match);
-- 
2.25.1

