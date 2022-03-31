Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BFA4ED7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiCaKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiCaKes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:34:48 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D31EDA30;
        Thu, 31 Mar 2022 03:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlyblrfTqS+OKBtl3CWBJRtDH7XM9WK/xVMujZVQxstVztK3x2cbg0A4C8jldxhFOlG37BOEhVf/kqupuTvx1P/quw9bi71mjJRMgAhXhx1rIekebD29dgra6PjWDJs1RPgJRPm5aX71jpGjgKSNRUdSyNq4SCs+KGNB+6Q7/PFlEN5Dz9j/fkgJwGmogFGBbPiSa1uuB/SEeRmUbQStPufzKU6lYIULm8FQQgMjx/QaZBFaEdINWEX72/aSbKifi4XNqVfDwXpTmb/e6YNNLgxMUrHQmvEgQnVl5Da8I988sM6uDUsUPPTTc8B8A7AZdU/IuRDOrPtJMBaEarxh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBl6S7O1KPkuv/nBrKr7G5FEj4H0sPIBb+CUEOHg/q0=;
 b=TsBKr598fM7QqH9s0MfNUi/1F/CSh3rhl9oHXLvhetUNO3onw6i4hxxG2i6/0O3DgqWQz09UULvwJzki8jdnNPLE4euiOdgqqMyw7b89i4SKTNu9Q6eBSH4u8e/rSoGrj+FZgIFS7oGcmX0GKQu3YH/5FMtpZ01Alf8PoTB5KXm4ndNjRs1JtgYG/uUmEWKFEyS9Uzvyexruh0svwUkGqkmwgbWVumSkPYJthtliS+BTV5ni8G0neBlxGpedkSi4tM9kdIJ5LfpN7/aeVlktYAAeiXx2P+Kx2G+hlv/wpOipEOkU3W4Kd+vYjguH3HsLGOzWHSP1G5X3DanO6k2c3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBl6S7O1KPkuv/nBrKr7G5FEj4H0sPIBb+CUEOHg/q0=;
 b=hiZL+gO1lV1vcSvZ78gs2lX16rOuMb/mIakyiy95fM947Rk/jkC5v4LaTGutZEHmJxDAtEhWCcEj8kgtZAoKr8qu+AZq3SGYMj3+CX7IHmBjNWXk2xXx5zxeXiz9YmsJeTuEqmIZmrp2RpVEO44+ySjw7og/1IQHec0K3hxVFrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by DB7PR04MB4171.eurprd04.prod.outlook.com (2603:10a6:5:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 10:32:52 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::bd5e:bb79:2c17:302e]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::bd5e:bb79:2c17:302e%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 10:32:52 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        bjorn.andersson@linaro.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, daniel.baluta@gmail.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] remoteproc: imx_dsp_rproc: Make rsc_table optional
Date:   Thu, 31 Mar 2022 13:32:37 +0300
Message-Id: <20220331103237.340796-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0235.eurprd08.prod.outlook.com
 (2603:10a6:802:15::44) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5955d00-2ff5-42bd-2742-08da1301cf1c
X-MS-TrafficTypeDiagnostic: DB7PR04MB4171:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB417142A198C93CFB34AC1E55B8E19@DB7PR04MB4171.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gD5cj7yT79rEZYm6jDDD6RCJHoqOfUc9E0eho4jzqZ2MD/jUkX1JMy181soiy4V1ANdMPe23hHKPVFcGQnjXki0b21+bV0RddxNlj9HIi0yaaIht9pD09iDrjyC2to1INMd0xmUCjL5St0fuq015Thy7iPcLRLS73YVeoB4CMqTv4KprjQhzfFV0D/OU2RIKuC6RK4uZAxqyCpgvrsZQ39beP6vAiuJr2v5hJ8FX+tq6271XefjP8QHtETuG9wEBjT9HruTeCe4uEcCiQzNKnWJgVJUiM9RMQmLwztvaba7nCoogRnfm/fGLikYGigMTIxWgoQ5Ph2UF4dOcLASaj3jQkojXgOHsPyJy3L79pB8lG7Hzz/EvzXpkTU4k5C8mVUsWbXtcoSx11HmYAM+uEEbJY4GKNhQ16Oia1tMu4ig2DgZvmc/WK2QmonbLWCZkjRNERQzuVOeTAMleYmaGMaKuuXovVNy2JYRkKkgAZLOlejVdXrIq01FXPgVQkF+zlkH6RrcQTNuLkr1VEGnkWIkFDnIB8sqZ2KESq2vYVv8t6baxy6aRJziGODyGScWxgyAyJFlFrujM1CJk402bMbFjNVfbh2egaVCVACAjT0WhVLPRK/xWA8uZCNfhVi3raTbksAOrK5f7fUBVUaUkl06MoqeB4kssEfuyfzMjwkOmkKexomyOnfAvV3hGo75ig7sw+ekrYXR2g5DW6it1LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(86362001)(26005)(186003)(1076003)(66476007)(66556008)(83380400001)(66946007)(38100700002)(316002)(38350700002)(44832011)(5660300002)(508600001)(6666004)(6512007)(6506007)(52116002)(2616005)(2906002)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sj+nmsipTfQP2ZWBsWWq7rKr7EQs4qQ9zeMewZ2QiRoJ1ayrIKE3XS6fhxzw?=
 =?us-ascii?Q?PwihAWYm77Dk4W8R4EzwM2ar4uLENU7VBJVoj60859XF8gneG9+09VS4uWt2?=
 =?us-ascii?Q?zDhK+oBwzr7xA0ZD39ia4B0FHPtX8AeS/8TV3Ph6smijT/9F5aS+v68L1YfW?=
 =?us-ascii?Q?0w1Kg+cCKWO719efMfPAoyFfV5Z6FpYWa8xk1M51FJkWxCNu8Z/CJjdlOk3F?=
 =?us-ascii?Q?cQzoaqQp/CFE0n+O64Vn3fTf12fw0pCA4DMqo5W9C2qEHWtM6uNWXCQSBl+H?=
 =?us-ascii?Q?bVK93ByKvD1hN+XYohem0fRivhry9abZSUJVk7ituS0wal/n9WjqLcxt+zkh?=
 =?us-ascii?Q?HMK9wgIH/Y5LLxjRJDwA/b97uhg3wIwjo6zKUURu68FNAzj+t9U7BpDh+pne?=
 =?us-ascii?Q?ugshtRsPKufeZ9+H0ni6QyG9IsPi4UklgqlaRZHjHiGwsUK9UbidSBnqH0Da?=
 =?us-ascii?Q?Qostr3CxR0LQyeXiNB+B72HPGvI/ICeq3VGNN0tumaBfHqRh/dWL1UPV4BYD?=
 =?us-ascii?Q?RzqxjLwpPzRMiiE7P/wpslcjq81g102D549gGlP+n4r3sEUwVTLLHtgWpvWX?=
 =?us-ascii?Q?jQN/7KXsX6q8/msw37X1ggvCgFW1BP9Z18SHVuLohJBzpUxzEFI+DvXvBwcM?=
 =?us-ascii?Q?DINmrkHWtEA/746xnzwVuME0IqOAkQFMJFkh1hes19VauM0t4lPaDaz1te5p?=
 =?us-ascii?Q?t12Xj63cBJvYGurX4HiELhTQkyr4KsBe5zKbx+KGbi7v8QdI62ArHZZZxcJ5?=
 =?us-ascii?Q?J2p2Ex1yTC1A7qRQb4SBOTcdtFvAO+wnVTPtGcGJw4IE+kPIXj+avViz+Zfh?=
 =?us-ascii?Q?tNoCzhDXn+NKpExr/Il53xKmUIJmenFRsGEtf8nAnHfMggUZ7dwTaQsCQUgC?=
 =?us-ascii?Q?IeaU70g3nrmcRrr9Ml86xX6RaPvDAro0l/fnkcJWY5pcK031Z1jJZMJUzk1W?=
 =?us-ascii?Q?76CCMnb8OsbG08xKLUtvbxhBisjhk1wIwUtyTIR3nukb3+mOLL4KFKz+8IKG?=
 =?us-ascii?Q?HnL7WMMX8lGkm44760cK3J+NPCZ7Cw8QFA8DL2yrMGlvLo3S2LnYTS/91mlQ?=
 =?us-ascii?Q?8SYfBPF+91e7mV2a5CUZiMTu75BQAEbi/0R5v2cOk5JDRs/IynjOdY3iPCYK?=
 =?us-ascii?Q?m2cmuNu2xWk4jpEnuiRRgJ8FUOOltYjL20xew+AO1yk36cGTg4p7BDLd9bbu?=
 =?us-ascii?Q?8O2g3oNYFueKZkZg7Uq7W9SDQFo2GOWuXyDLk3WoGxqd3DnxhuFQTrrCh+nx?=
 =?us-ascii?Q?FDROmny//NPnosa0enFv41CZttbBD6azxFDuGn0AreGnHeb6ArNv8L1Bue1U?=
 =?us-ascii?Q?Z0e7WuRImh2FjleUd78ggdo1qwzj3IwL3Ma0dRgapW0f6q+YiEQU4WsLKwDp?=
 =?us-ascii?Q?3yRZe2nqYoDUg77P9h/KwhpwAQ680xWDGDWwJqbbsXRbfXMUCqoAh2PanQmi?=
 =?us-ascii?Q?rW0LK1J4ijixcb+TGJTo9+PesOuYVwZyq8jUgefHawCw7v5MmDeZgW5JRwFg?=
 =?us-ascii?Q?SINGxyfATthmFbcyf9o2u6kggmIFNhcJBxVX6Pm4C1XpXg7534Bf8X2NLHA5?=
 =?us-ascii?Q?TZQfo1eb7ZgiERtQmjhFvib1P5YHwQTe8t+N66geJp1DXAeHKKyToEwKeaKt?=
 =?us-ascii?Q?Bq8Y2VNnjMMtjUUp1dKFq96XOF+In7l+wsu4BabEKTaUvb0Jfw2GD23+EHrr?=
 =?us-ascii?Q?nHt63SxjmomQqUbDQwb9+vZYY9/8Lt10NsMqQvnAbQM0oPySovcJir4g5W9e?=
 =?us-ascii?Q?IyCpAECefg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5955d00-2ff5-42bd-2742-08da1301cf1c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 10:32:52.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MNh+yiBIm1BEG67/v8H8YqGPmFGsYSsdAQLigFU+0+BnTOqlu8GEQj4vME/NP0fWHAeLxjsmUpKExDItM9ElA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4171
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

There are cases when we want to test a simple "hello world"
app on the DSP and we do not need a resource table.

remoteproc core allows us having an optional rsc_table.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 2abee78df96e..987ab1add761 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -802,6 +802,14 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
 		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid, err);
 }
 
+static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	if (rproc_elf_load_rsc_table(rproc, fw))
+		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
+
+	return 0;
+}
+
 static const struct rproc_ops imx_dsp_rproc_ops = {
 	.prepare	= imx_dsp_rproc_prepare,
 	.unprepare	= imx_dsp_rproc_unprepare,
@@ -809,7 +817,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.stop		= imx_dsp_rproc_stop,
 	.kick		= imx_dsp_rproc_kick,
 	.load		= imx_dsp_rproc_elf_load_segments,
-	.parse_fw	= rproc_elf_load_rsc_table,
+	.parse_fw	= imx_dsp_rproc_parse_fw,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
-- 
2.27.0

