Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC85AEF50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiIFPrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiIFPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:46:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240BA59A0;
        Tue,  6 Sep 2022 07:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/x8BFLb9cXXBLqiWtLlfr+o0IBVZgZJsmYWa/EB57RMp60DS530BlWri3/ED2uTyiXx3B0ueCM6EJHYLYKd2Viey677qdbixAwqS+nCPveh5gB937LRyHPlXLDChBcoaxRu7D5nbmNURz90TghoX1cWCIVtWgmRXZ3mbvVz3qUWqy8NM7v4Ub5IBleqGHP9xPnWQJZG6YfvJKIQ550EJRHUaeDMDqku0g60tBksVSqLFz3YpWGJwWoo6kzU26yIY9LEqDeq+o0oWW6WTU9UjWyR+cs99jamF6sDhRLIyLzRbxQy5H48E7jRwsVQOoSjNe7CZrYxyCKeZjl1alBw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHhiC5QsF+JzIhG6doRHhCQtHC9jdJD///6vKdKxEAs=;
 b=Gl38JMzeMEd2h6XVladBNitXdtHggIMupyDTWvpTdEQuSmAleD0HYtYP1yv9oq9FNBhqttnpV4qaA46pyBhB05tvuwnpQ4oXCML35iGpflE6CmxSJ2MeiWs7sHbyEy+OHAt3Xwv5BjOuUklwAq7Ew8gDv8For45Do4/0f71uzCH/KEvtlGoSxzZrrHlddxGN0dDjgN4FK0aHtgomshbdyEIEvIkOQhtLTpGQvyZhD6xz0g3AArAA4bxOgsBqhVEEmIZinIISusKygc3hGGG/ahPGWEAxFSVKzOpNWSdH9745Q3YgzIY/XWCCwnYOPMBtrd5+VxRJzEnaatm/Q1qyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHhiC5QsF+JzIhG6doRHhCQtHC9jdJD///6vKdKxEAs=;
 b=fmEZvBgSU3A1Wccoo6tDFl6wv+AqzDu179WONEwjj8Rbf0938G7CB8THWbXXd+d8mcGADfXWXziXcT5FhpxviH61s8twy4gfYflB+CyC04iSf6AJ5Sn0NSAAQsnPiB8zNl5X7qWm+6FTEHnIvmwcPgZBz0pobuRSIMybioS+208=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB6PR0401MB2343.eurprd04.prod.outlook.com (2603:10a6:4:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 14:56:51 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 14:56:51 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v7 1/5] dt-bindings: firmware: add missing resource IDs for imx8dxl
Date:   Tue,  6 Sep 2022 09:55:24 -0500
Message-Id: <20220906145528.40079-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906145528.40079-1-shenwei.wang@nxp.com>
References: <20220906145528.40079-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f929f69-14ce-40a2-fd3d-08da901807a9
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2343:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtRpDYSt4al8uDvjhA+wxi1CJAUus69+rHaDoWKQfe6zxbKX14Ky1lULKtwCBboEQzdA2NWWEW+x+uk9WfN8/PKHRs37/SE9oMkFhNZlakeTHTJzPfofLduvz2ozNGsNBQxFMTZubL7uBGVkh3Bol5TH09ZfJ/MwtHdlCiiOwaX7C5BMq9nTv/jENlVSB7dSdEmUsc/6CGO1I+zNhzPq46Q+jvQBXHT80r5RiuKHpfQKD4lwYbGh7yMLKNNd3LV3lw3NvmojtDlHT2WJMCv6QDwc9nc8fu4hp/nGYsSX//pyedM07jW6dJJBqMATezDpoDE2sOK63IZWW0xWL5MWxU6i7NiShCxnUtGkz3SfmbhIrGxWx2dt7cdYpvRflX9jrDFcnF9BgrH+SsIDjZQ+4VfQVgZIRDrFm+y75V0rXw5gXYYa1Rp8tZ7tTuUAiMbwlPpng8DltmSvKBTDvBUYlJCR0FESpGmyyJcn/noXAfcsHNJ/YgOmpm25EaOLodgB6I9LtG7PnrzFcOvmdoRlBiyYaH+gP7UCy4gH0wJ4NMhdKpYw0ncmlUBm+tF5k+myWHwfQhmPG3OKChHf4WqfWX2AJDv27BY6+PKPuiIAlHhd59x/RxZAeHA4kQ/6jHxsdWswX9JniYEM4siQk3JF7YroAeTOqQ1GQDOs01QEn0dnHY3ZSi+7yqgBGSvZRo1J7VVrnDrS58XZZ+iiqD/0wwJ7v2SEHdxWKUTHgGvZyBKy753m4w6UsgiyFtv2AqDaQ1nY+tn8DGl9qdczqmNeqcsCSjOEZZ9i8REaQ4acgog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(186003)(1076003)(2616005)(41300700001)(5660300002)(8936002)(316002)(54906003)(478600001)(55236004)(26005)(52116002)(66946007)(6512007)(44832011)(8676002)(38350700002)(86362001)(2906002)(6506007)(66556008)(6486002)(110136005)(66476007)(7416002)(38100700002)(6666004)(4326008)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j1wmWf2wjviUgg57srLA2VpYdkwwyOHFR+8EifCK4Ux71M49GMM6Ze0A4PiU?=
 =?us-ascii?Q?MJwMaJSN505yoS+RJTt2RcMg5TGQh9KjemWr0kydUY7TykIyb1iHXj34RK91?=
 =?us-ascii?Q?ugiEEU50u/qAHJ4uBC61qguRntAY2cYee084nq/XUkGLbGATZLs8VpWSY8Cs?=
 =?us-ascii?Q?XZt6xVPrTOAHPyIMsx8bQZwlZHHGM9Pc+tY6le8djv7vUiGLuR3Jxp1wgdAr?=
 =?us-ascii?Q?7Y8uxhiBuV5xIzHfn8gemGqHAXvfNj64urocWeqxFy/pA3z+IQ45/elvTMnv?=
 =?us-ascii?Q?qYEr4QTmz2fvaSC61p9T+RAAMHO50gdcjXEvlWpEzI6sL15/JRQWSZJAjtIl?=
 =?us-ascii?Q?Vpm54wRMWNFzP/jrjlUijnQLpMGS7PA9T/yRXicuecc/DohTm8Fav09oVHqR?=
 =?us-ascii?Q?bQixA72S6WlE65vJdThHTr68olOMtrBfBBYix8a4WGjdUny8OdNmalIlYm0C?=
 =?us-ascii?Q?7JLYwddz0EeDcZ5Phs9tx9+A1W3X/cfU89HMj03Np+VHdGfFQaEVtIhX12gM?=
 =?us-ascii?Q?UsRstRzxbbVpfrNeQ8Vn+Fo9uTa+0lMdWZcODVXWkXT95p3W0xKwmZRv0szm?=
 =?us-ascii?Q?jYEJLspdnuC1I1PHturg956k3C//qZ04DVAAmX14uZB4nDcJkpqPn0M6fn2y?=
 =?us-ascii?Q?eAXNUXckD+JHIrNt1ZEmgpMkzODEQA6vzYUuJX6J/agZqufz1Qd0eUUzHDYZ?=
 =?us-ascii?Q?s72U64tlH6gxLLPhl23QGTEfPTTo9oxvL07ff8gIcBoKjg5l5p6NBqMk3VBW?=
 =?us-ascii?Q?F3Jy2p317VlnkaYFlLLBp6DT1fbL29qDx+EURC0JkSr0VkE9cSnr2l/LqOws?=
 =?us-ascii?Q?3SP5V21p9z1oLLuHUmWjwxxnVZm0aixP9YbHsntWm0RJ4U6AhIHeLlEK7Y/N?=
 =?us-ascii?Q?VcfpVHhWnTUPjaZTAQqQYJ5UHkGCbH3zC8sxP5Bo7aW+Y/y5mzjaxRgOI0Vf?=
 =?us-ascii?Q?H6FqTWAPJmp2KmjHYNmJmH97UqWouD3QPD9ZoSDtU5GFdzEI9Fp9gjgk7K18?=
 =?us-ascii?Q?PifmhiSy5M9b5QbQQdfi9r4fpS+2n2GCB9hP+OFRPPNEDtxc07WXW8iDvyef?=
 =?us-ascii?Q?T0LowjCdzq0tjDli3EvgCKkGz0l1IljbRdIBAOaxCmGf9wRbAeuh+XP8kD27?=
 =?us-ascii?Q?dUGUvdv7kLq2TBZacxYy6potxjO8iFF0X+XDrGbMULpXow+9ApgvKy4smYlr?=
 =?us-ascii?Q?x0SLy1qVfLfz13X5D9RKhSr/eFVhlmt0aZqnAqi9nXqYnYJy4MO7iqIVFj4t?=
 =?us-ascii?Q?FItOZYLfEO+GMerGQZ0nsRMNnOIfUN5qMmlvq0dNCxWOYYuwiZYFNRraUHBb?=
 =?us-ascii?Q?szW0m80Aq0hg8gjMqH8FA0VYGe4iGryl3rEBBivkOJPhHFtvVsvqcc99LD1Y?=
 =?us-ascii?Q?YnhyfdnLKcCsDXQI0I3vjo9B0ASaFZGN+UwQJoCjlS8jH+b5nSOjPoBpKWZm?=
 =?us-ascii?Q?4jmZJosBSq0TjAbBXjP3wnyKIbnijSVDCjdNCf3ALO9f2NmPjIZDd6zSi6FG?=
 =?us-ascii?Q?nSwDORbiLGy/MYimjJzGFV00aPOD/VRHw15dl8ynfsD5gWqTIYz4VumAh+u+?=
 =?us-ascii?Q?mFHmSjmXWkqY4KtxXXDrJ1sV7JWXUyVwasQtUnTy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f929f69-14ce-40a2-fd3d-08da901807a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:56:51.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADZeKJsFjzAp8mB4mzwgTGvHMXZof23+2clARmoKWnoJFWxizLw5yqAxlXW5mhTneAEOtNbj9Ixn3JPSm/jMZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing resource IDs for imx8dxl.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/firmware/imx/rsrc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 43885056557c..1675de05ad33 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -37,10 +37,14 @@
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
 #define IMX_SC_R_PERF			23
+#define IMX_SC_R_USB_1_PHY		24
 #define IMX_SC_R_DC_0_WARP		25
+#define IMX_SC_R_V2X_MU_0		26
+#define IMX_SC_R_V2X_MU_1		27
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
 #define IMX_SC_R_DC_0_FRAC0		30
+#define IMX_SC_R_V2X_MU_2		31
 #define IMX_SC_R_DC_0			32
 #define IMX_SC_R_GPU_2_PID0		33
 #define IMX_SC_R_DC_0_PLL_0		34
@@ -49,7 +53,10 @@
 #define IMX_SC_R_DC_1_BLIT1		37
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
+#define IMX_SC_R_V2X_MU_3		40
+#define IMX_SC_R_V2X_MU_4		41
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-- 
2.25.1

