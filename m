Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D555A4455
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiH2H5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiH2H4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:56:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B711819;
        Mon, 29 Aug 2022 00:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcamN6l+ZqBiIt/SfrCoek7npEQbEFYt3k/yzIi7+qQet6ovoZELw9RsYJX15L5SIZ8KmCpMoZIyEMptPekSbC++BYUV3nTWs99WMOQi3S0vjKzD+MHcC1j+fv4GpX8M900qKXlQZANHGoWk1P7NUY7L21cIr9ptObNKMibvyy0y5l8MdsW3xKTv80EzD12vmBX61sFHfAMDaQun3hO6itgEDqSksSCSwYGL6sCuOU78qx7E3XFBi2FvQYvPSH3/DB1iYl9WfrZpfBybbta1w365yyUdDkcoEdmfROxEExkLrWz18BH6Ki+q+mpFhEqoMOo2Zz1hEmYGLd3mKfrRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3rcps9Ux2yF0dLMCGKlmvX1I3K+2JMwGgrblKW04Gg=;
 b=jt2Mr5aWq7GnPQKnkhKD4xdutPUJggeHx+BmALhW5eL1zBmtfipDdi3NcCcmCrnsN60GISzERhC+50AXiqfEwbaMeVKx2/9Rv16nQUlJTUv7MMyrh6F3rUhmuOWWqJbKZQRtW6LAVcglb026s4dPwrXemHyRcihg/0XyNWZD+u9VY++AeV1JRtdCHlpRPMwqhJyfmXGTq9/Wjpo/33IemTUbhEIk5JUEb2d84Ddsuy5Rap2Q69JLXq2FRwZsEctir3NUR7CxqFJqvgHbTd/BvzqsTq4BviBqX35XWXtshexJuxrqia4dFm+QFyBbxFwJX/FEMTgQbG+ZwJ5dgtpmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3rcps9Ux2yF0dLMCGKlmvX1I3K+2JMwGgrblKW04Gg=;
 b=XCT3jI+l21iJfgAmPW1WHJ1/X6lhHJjCTYZ8PknRxGWRxilYPbFOpj9Y8raVVwYN/iOY5VDoPECUA6aOeVkEs40zLd/c32Phvvu41UcbbCldm3DdP49qSN3O9X8esR0j8hJmIKthtAIc9OV5SfAZKNMAtoUGbbN9QR8QHUw7iK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by DB7PR04MB4220.eurprd04.prod.outlook.com (2603:10a6:5:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 07:56:17 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::3139:70b4:6648:bd32]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::3139:70b4:6648:bd32%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 07:56:16 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shengjiu.wang@nxp.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 5/5] ASoC: imx-rpmsg: Assign platform driver used by machine driver to link with
Date:   Mon, 29 Aug 2022 15:51:44 +0800
Message-Id: <20220829075144.2405000-6-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829075144.2405000-1-chancel.liu@nxp.com>
References: <20220829075144.2405000-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:46::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a2dbd6a-087d-45ba-e9ea-08da8993f386
X-MS-TrafficTypeDiagnostic: DB7PR04MB4220:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykcmQPY0ax0pEEpv22EBA2hc7hdokClSezxWLCAfM1f2mnN84onZIBI2pd32c3i3cuMf4LUUjXXpY3O4NqR/w2d9eIjHPwBMdyE0YCd+GrUhrSupCv1TXqqa9a4Ebm2p3TPbjuFPjjw+5M+6WS6Vnk3Obxu2KcduI7dA1U7dvankthbxDX8deGTRWIqg98ieHcpgfqgXgJfIm76JFWoJyHpeqVSfEqHq76yAM7yrtxYTgNkhBnD2QFdewxsqUJ6G1QVJN1A0dEN5fWeQ9W89D/XzIbX/ZS9jxYTQ1k1eddCGa6Y+7HmHFlbUccyQRUC7f+j9Hew4CRJp2atJOrJsrZ6iQ4UhJMy976g7gtgb0B5+fYX2329PQBiL2v/9kONb3RH7a/qTE5upngEEqQ+YHu06PA3v/7Jljogfgyq8Pgrjt23PsG81VACXjXz8j5pIPYYm+EH7Emjr4jYyzxPboe/dSqoc1GegUFtl5ks4esumSORfmZbNZRjS9amSjufilteZCmkc5rrTPs6QLsBvmKYPVMtvmaNaOJDKBpv+Yoi7VKgRgrEkZGD2bYuF8QdNQ2XAYTY5SMzFGMY5X9Hp6VzzyL5E5EQQLyhIzHOqNKnfDUTHockNhncv9/bm3urKyHHNJ5UzOh1azw0+vC8HyyFCqGl9vSCviQz4o4bWSKpnGt48127ifgiIyYgd6KjtQ5pDNjGsDMnqCMq15ZMJfXFhRcJD2xEtT2YSMLF0EwWdCrZz96iWKHJlL/uE1gvxa3cavgLW9MJdW7w6tmVPkZYplQJY7XHEULpfZYCqZHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(6506007)(38100700002)(52116002)(2906002)(44832011)(38350700002)(6666004)(2616005)(83380400001)(6512007)(186003)(26005)(8676002)(6486002)(4326008)(86362001)(66476007)(66556008)(66946007)(1076003)(316002)(36756003)(7416002)(921005)(8936002)(41300700001)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6157gZvY62kbxHRkGhKxs9CoGKm2LqgvZkHwX+gNrf76DZmiKcDjrXVy1IW?=
 =?us-ascii?Q?risZiVfIsTOFCKvL0dxWz/Wx02ms4mYQLl9QR7Lj3aebw4AwAWj1yzLp2DxY?=
 =?us-ascii?Q?JwFpRjhtJ27DIxm05Q/2j4ukUaGnWMyVXdOt6EkUzWhWpouXVg25hH3TIRdq?=
 =?us-ascii?Q?q2s+J39L+3NszL86UPaZDE52snGI/Uh+Zt+srAek6G/saH0UuhjxVZTtOjbw?=
 =?us-ascii?Q?UJ3p68A2jEBbuN4F4Gsvj8eXLFGibTZlEencb75rtQo/AhjNORI3ErdZ0QWs?=
 =?us-ascii?Q?RsITW9JMlAAmDNYFzVIZBPi2dNvcNqS8KYM+Jk7vfkh7CmvzCbl8c0gSoWxv?=
 =?us-ascii?Q?QirIxcv3mYTsrl1GP1cCzf1dwumKS3w20/LD4pJByGywbM3yaa0Bl68gebon?=
 =?us-ascii?Q?j1f0SCgdIjl/3Ad056h9vsX7Hova+uuU5DgLr3Cq0k869D/ZABp17WY0Qmdf?=
 =?us-ascii?Q?Yw6pr4u648TFILvQCndxRqNwvQR6lmdEsn1O/2pODnTHT/TM2UeHg6zRSfa1?=
 =?us-ascii?Q?RkKrMxjLOmoz+epGO6mKEI5lManNLGBVaOBDb0NCXsljx+cqapQQ/7zjNkye?=
 =?us-ascii?Q?F1Fd67xTvakS5Gyx7mAd7DOLTxuaA35JJdgNkiEAyKC5+v3k/OldfAqV1I+y?=
 =?us-ascii?Q?tZkuW9kPSSFy2DckFgzlhLylQQ5qzch7AEa4XyhXA/PAziL1fW7WqroEQPeC?=
 =?us-ascii?Q?8ls6WPQBQ+cXdDLixs+2qsVXmwMu9It/crOMGpPdK525MkOaw8DASnbnFbRw?=
 =?us-ascii?Q?ZxZGvMN3ehhVzQqtPtu1X+KUtKIzO2R3fbkx6aavbyr6CccKpNBEpif0uVE3?=
 =?us-ascii?Q?xNenEVTKjpCOQ87BV2Oi9CWHcg4AMjn2pwLUrtwYCGDUygUO24wZCzClmiwo?=
 =?us-ascii?Q?27zX2A8Nqg2XwI47XVR0sLDl0p7iWoQ3FqMdohl1Yk59vhz1v2uAMnYjalov?=
 =?us-ascii?Q?5oIzwsF8UIyMkgCQRXE3zWwOsuKgUbChhX5X+eGKjI7Y1mmamsnEtg6FjOlv?=
 =?us-ascii?Q?0rbUEwyyeCDoNBBVOMzgYHVfNyDI66Fx6UIrgeVSLFcnU9Go7zQR5MV/yj1v?=
 =?us-ascii?Q?xLzgwmjvFb4M1VPwVBYWGeKMHf9YHF5TYwi1gCSMSgNg1ZF+NnEdhcKXzZic?=
 =?us-ascii?Q?CRY0QvJK3A1bFP5fLj+Uk+am8zBpyvZmvLq8svaWUqeXYVZI9qtZkFIMHwEO?=
 =?us-ascii?Q?IMcfmx2flO7Q6GMs1Xxy1bY65paKkA6i2EleLbeIlezyeOvEDOSB+i1IztXt?=
 =?us-ascii?Q?lyQLo+pV4gBEUnkzImS+FQ4mnR2kQnLSgujw1NSNMGGKNSNgUrLUsLxDr+up?=
 =?us-ascii?Q?yv340GGoYutcX4N6cpzKm1DDDr54t+cn5EirPGBeyQpnIL0whjm3oIdSTEAW?=
 =?us-ascii?Q?+Cv2oyWd+Sq5FM1a0qdprzhufFhQKIEaUL7K6iz/0IkwpnIBgxVGanY75sxt?=
 =?us-ascii?Q?W8MRa7o9ees+A9ZyoAHCqisl0drh+YPFUO7keCm31B3o1sDjpB7TlCl+8sdk?=
 =?us-ascii?Q?0xdL0ryeXFsFBzG/ygUi+4rkOV5MXFhtpNwaQMbWmtmXvgsFG2X7UUFG015F?=
 =?us-ascii?Q?lnffjaZrjYFehwAANKUYszHoi+YnMwJAEvS1E5tK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2dbd6a-087d-45ba-e9ea-08da8993f386
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 07:56:16.8530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9qjtdbjAcHDHG41Ls8wMVT8fj0awHbtvygrl3XTYywghQrT1495ESlkglJrWSfqS5P8rzLsCid6IyPs3hO6Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "fsl,platform" property to indicate ASoC machine driver which
ASoC platform driver should link with.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/imx-rpmsg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index 2e117311e582..c534b638698e 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -36,6 +36,7 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 	struct platform_device *rpmsg_pdev = to_platform_device(dev);
 	struct device_node *np = rpmsg_pdev->dev.of_node;
 	struct of_phandle_args args;
+	const char *platform_name;
 	struct imx_rpmsg *data;
 	int ret = 0;
 
@@ -81,7 +82,10 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 	}
 
 	data->dai.cpus->dai_name = dev_name(&rpmsg_pdev->dev);
-	data->dai.platforms->name = IMX_PCM_DRV_NAME;
+	if (!of_property_read_string(np, "fsl,platform", &platform_name))
+		data->dai.platforms->name = platform_name;
+	else
+		data->dai.platforms->name = "rpmsg-audio-channel";
 	data->dai.playback_only = true;
 	data->dai.capture_only = true;
 	data->card.num_links = 1;
-- 
2.25.1

