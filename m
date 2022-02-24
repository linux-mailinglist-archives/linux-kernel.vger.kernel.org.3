Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E634C2224
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiBXDNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiBXDMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:12:37 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10085.outbound.protection.outlook.com [40.107.1.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A11B78B;
        Wed, 23 Feb 2022 19:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQT9WAFRWMvGVpwu5+4esYqZI1Wf2E+4V5yQd9zfH+4k9VJUEUyWqZjb7AXsDwFgfrJdCRjaSHH88c6li/5PcXRtbk/egdFDd1j7IfKnA1VYrrivF/0UmOTXYWfgk/FRxExln7Nl0fPED2qz1SIjIZBfjKyBziUo0cR0hjulISErWMfZB3XDTPgxLoTLS1nwkatk+6ycpoVIvYdzEXaky2yl+wG7/jMgihrSINOyFsZF5gKIyyXdskjdLoPetZJShCk2SajHJmxNcAEo2qQFI/PkYvih8iOYWjlW25PCC0cOO7xNKp8hIH1X4t0z3zlvUHezV/MJxlCbcNP6CZ5Sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojvTb7Cio1mtUw2r/VSpJmgFC/5vvi1V76g0QleY5Qk=;
 b=BqtN/xUm2klnYVD8s92Pqlq9ct6ioxw70yRvE6/f7jtSswnDLZJhYajSpoi5vqlyRdStv3G2hm6GSCHNrWLkOc7czuJxhB71UO7YCSP/+aU4I/cZv13zdccnMCbULtrO6qcb2Q2SHypc1MEapfe1Fnoo2NWL0DD/GWUTxH9SG4yp8zRkpdixF+rHh+FhnQOJKkSgZOrACPGlapz7As81aAsuot2hAqgTZnrc+qDW+8n/O8vPpwXsQxpL9VGCCgGB+QyN2FnEwm3MuBlouvO00Uz9+tG8pBVecROF0y3qopbWEQhOplLnOtjiDdYr6IKT2cPSvvnzfIipM62RrEfUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojvTb7Cio1mtUw2r/VSpJmgFC/5vvi1V76g0QleY5Qk=;
 b=hShOHuqbNzVsE5V8oaztz0NfRNvhk3ngcf0WdG78/ZX0sMU/P68DrQ+9CBhVfgIp2W0OYEw/H+Q5mFNIyPiILPvvd9Yk7GAy+YliHO/isWdx0LzhFbUIEzpVZ7v5EpB6/ot9bWTgdPkKb37ppf5U7fZLy6HpntC00V1fs6TknHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4183.eurprd04.prod.outlook.com (2603:10a6:209:43::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Thu, 24 Feb
 2022 03:12:02 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 03:12:02 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 15/15] media: amphion: add amphion vpu entry in Kconfig and Makefile
Date:   Thu, 24 Feb 2022 11:10:13 +0800
Message-Id: <c2311359a72fb6cfddf73b637dba9857b5c6cef5.1645670589.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645670589.git.ming.qian@nxp.com>
References: <cover.1645670589.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e827240-53b8-4249-ce4b-08d9f7436dbb
X-MS-TrafficTypeDiagnostic: AM6PR04MB4183:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4183042CD894D5A7AAE97575E73D9@AM6PR04MB4183.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ML1mN+1DpJhJ+Klj1UnPB4BPwwozSzpMdaYUQNnpttgOG7xdN0WKJ55HTxdZD1Qma8N2Q+2t50o3CUIw3jfOXtZEsgyoKX6h097S7JDMcbkm8yHdQkzo7C10k3Edzh0TJ9s9hEGS+t5U9sMmyxvJvtf058LmVU2rztT72kFfRUu7a21ty4kIeoI+Bl3lrAxEVUqCpNE1Vxup0hhiVSddm4HYO+j9ER48KLti3Dxli/QA0fxm05YauICvXA56ex+UlNLx87mKDGgI5YPJQLgA7C9yHO1yKhK504tLdGVGur8ESifa8HNPiA9/Wgcf0rb97Sdz9xkzETHLTR7iixn8xr7ji8IcIuOfwf5E0da8YiYfgQPcMttZyrqqcTa78RWysymJfO0g6SnZnN7aBZ6QytpLqWmv8BDcH/3Nh/2m21cI9y/8k7Pa0gF1m/ijLaXCw49iuier8ZUn+qQ9/pedm8bPcWILaiE6qgGQd/pmLcShMq7IUnBxcg+UchZySx2knCqlFErpIG1Ab4sBQV4yCHoEXQ9QNe+XCfX5jZ/XtTuA8mMLLUKDfYbWjhiIvZL8b0YE+d8ij1YXphJopiPE+uLGGmyEcdeHuV88AxrDYNnQwu23f5vUovVsq7+u2dXs9KiRbTfTJrVnPOq3m/VZPR06SeOc4eRspTD996rNhklboM9Mx5IR/1uTHQ+hGx6me1TeEq/ggk2pttTm/mrxfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38350700002)(38100700002)(86362001)(52116002)(186003)(36756003)(6486002)(316002)(2616005)(4326008)(5660300002)(44832011)(8676002)(26005)(6512007)(8936002)(508600001)(66476007)(66946007)(6506007)(7416002)(6666004)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3pTU/8kpDMtSOPJ9kTrUEAmXoXaIIGz7lfuRhT9AVArc11BzZcR7mH75dm8F?=
 =?us-ascii?Q?mvuyIbd2pTtm4cQUqo5zfNLafltjWtJVD5W8387qwFbva/mzaGA35AupJvf4?=
 =?us-ascii?Q?4Ze8/ejhyZsRsU0PbVzBSuYSw6T6ftrA/K/v94QfW996JRAh/H23ndnr5d3g?=
 =?us-ascii?Q?noyN2BQ/Epg3uEYjI/VTp74pBMmxKP7YeAU7PLa++pRzHfM3jwbCWCTTqixK?=
 =?us-ascii?Q?Y2rQkSsb5SxgYjVgC9Kf8g8MWuU/J0doaJWh15RcXt6QZDpNiOWf3Tmn9CuU?=
 =?us-ascii?Q?IRgsSLspWNtF7TBrdmtvn+HGvZjwzICAzas/2jePc39VQ9Cg6Npo2kiOxKuH?=
 =?us-ascii?Q?J8QMavrvTXZARq+L6dTPw7nojhfvvL6VmBkeUkCjkU7rU8peOlTtL+m2IYH4?=
 =?us-ascii?Q?rAO2A65JoVpyi76Op6KlOMWZRdLDXLqvta8vfsmAlFTBQtOY+JKnZZOmtfNd?=
 =?us-ascii?Q?2s3kM2cCsI1tX+/j4zoHTF4ou3WHTbKdVUB6I+/RSJcaeWmyctkXkXOj/3oZ?=
 =?us-ascii?Q?N3a3hKhbPUYeod68tKOsGvQXIRhW1sud2lv7AETlwoDUylRqNdZqdacvvV3+?=
 =?us-ascii?Q?GyfruvfKYpZuxQdiBTIHvJ+w4k1SA/uLkDX3eW9GCHfFmjVYTH+o8ShWjUoj?=
 =?us-ascii?Q?5j85QDTx9ktlZrvGyt73QV9UWkx3o8VkQknEd2zFfFh7/NUEv7P32znmirdv?=
 =?us-ascii?Q?HRFdNVfcDPZWiSp8k9J/v8mTkz5AmqVzGydPAeEOgOaH+7688G3/C8lkAcQT?=
 =?us-ascii?Q?WHkkYY9jW92sQ739T3nrg/EFn4eMgL9DCIOiy8vdEg9gNBrDYLRBqzeszf8W?=
 =?us-ascii?Q?tXzPRLpKgLR/c5Pf+hU99r/4vQ6/zNvdB25X99BY+Sb7ZEqnSrczoL8lEVsy?=
 =?us-ascii?Q?Ln9mRd1f6EwjgplO3lNBDHGt0gkSFEaFAuZbHeqlTYe3UlVvsEXhNrvndn/j?=
 =?us-ascii?Q?7QlYzoreCok/zPjOEh2tYUBCaeRPi7v5LNWsX6NOddOOnK4OCGoabwfrp21k?=
 =?us-ascii?Q?l2NrIeCghJX8UV73wtuYOZGfTFN+HKB5iFDjopwK7A/4DMQS3jafAuYICRQa?=
 =?us-ascii?Q?pedtKXJFcOgjZgN9zTFnDxXFehk4vLvYmdnQuTEf4TxepG83croVpOMRSCBS?=
 =?us-ascii?Q?bGqk7Wi61X0SOV8fT2l5XZo5eo17qU4h5JWskW+OR6YjFQgeqqYngsgi5+M/?=
 =?us-ascii?Q?yC2khzfZ29x317aBl3f1dArds+d9tdegQZWrsHc25B/Y2fD4LSC788PqGvOr?=
 =?us-ascii?Q?5bLMxp2//UP3u3FT6WzNuAffoxV6ROr0MAGAGLFVjKMxCw8gMS+aZ6kR3sQg?=
 =?us-ascii?Q?LMP82r5HCz2jahr3TKeAj+Nqrjw1lsfDTZEBLWxb0eAFiGJOQWUJOTw3ztPs?=
 =?us-ascii?Q?W7HXWioidE1zOcpfczfm2Cu6Xg8r+daUjaSNxkt90PTurZdAIIyU0M7jc8qA?=
 =?us-ascii?Q?19L9c++JPB2RmaKFMYO8Vc3HE0NMqqX0ciWEknbgEXyTZZS5iOcBgDzcXb9U?=
 =?us-ascii?Q?uDHUDahr2gfh3nBYefcFfBd0tbiKzZShX1sFz+rEQpIEjPd0q5Im1SCiEo1q?=
 =?us-ascii?Q?t+i8zbiousWZpIPpTWgOLmOcF31Htvszyhc8Cho5dUhmj3VvVP7TWDzUu/F2?=
 =?us-ascii?Q?O9iKfPx5bUZ3tNxf+6eFMh0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e827240-53b8-4249-ce4b-08d9f7436dbb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:12:02.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oW9lQjLH3tuRQOTD9f/Y32910V3IMoIBHPt1tbLdohnIbHgKQri88mXfiys55IudK3+6cLJqid7RCYLafaNuTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2 driver entry for the amphion vpu encoder/decoder.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/Kconfig  | 19 +++++++++++++++++++
 drivers/media/platform/Makefile |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 9fbdba0fd1e7..9de9579d0fc7 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -630,6 +630,25 @@ config VIDEO_SUN8I_ROTATE
 	   Support for the Allwinner DE2 rotation unit.
 	   To compile this driver as a module choose m here.
 
+config VIDEO_AMPHION_VPU
+	tristate "Amphion VPU (Video Processing Unit) Codec IP"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on MEDIA_SUPPORT
+	depends on VIDEO_DEV
+	depends on VIDEO_V4L2
+	select MEDIA_CONTROLLER
+	select V4L2_MEM2MEM_DEV
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	help
+	  Amphion VPU Codec IP contains two parts: Windsor and Malone.
+	  Windsor is encoder that supports H.264, and Malone is decoder
+	  that supports H.264, HEVC, and other video formats.
+	  This is a V4L2 driver for NXP MXC 8Q video accelerator hardware.
+	  It accelerates encoding and decoding operations on
+	  various NXP SoCs.
+	  To compile this driver as a module choose m here.
+
 endif # V4L_MEM2MEM_DRIVERS
 
 # TI VIDEO PORT Helper Modules
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 28eb4aadbf45..c7fefccebeeb 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -89,3 +89,5 @@ obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 obj-y					+= sunxi/
 
 obj-$(CONFIG_VIDEO_MESON_GE2D)		+= meson/ge2d/
+
+obj-$(CONFIG_VIDEO_AMPHION_VPU)		+= amphion/
-- 
2.33.0

