Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9166852C960
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiESBoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiESBoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:44:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622A0A2054;
        Wed, 18 May 2022 18:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLuNzsoj5JORVU0WJXTawVca4qHgwLJl/ylV2I0kw3aopsOw4xm2Zia7afmC0EIm67Y4goa19KC0DUmTfV36aWsLl8cT/nnJ/4UC3YQ4XlXca5pqrx3vbbdNhPSfluctw83wO3mqzXS0jHS5T3ZFEdgow/snSLueTkn8iIIu0SbEM7aCwK/cTIjctjsUAaHrcKRN/6ssqRkaq4TJwCZmksrVdFWZ9gGOqvEmrzpFr7t+xY+N31urdJcy+8PUh85qkeEM73BkARjh5V+Gh5xGP+QDmvRVkKHgrr29DDxEsstkrksBJ1dZ18tSKmd1+8B6egKNGUJ5egVh20QvZG5oHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Rl+lVuoczXbUdM4IECvIxK/tKX7x0mq5iALauI4pGY=;
 b=D0QKwNEa2ohr2Sjx1nItWvA+G6OeYpBdo5n4OP+KsmDZNBfOItEWnsnxM868nrihPvJrnykuNgKQrQ5ZbY97bM4mbOD4qTN5f/WeoVYy6Phn+HjcuTJ7A5HHhv52O1d3ZQPami4viF1vb9dzN7OkWZ+lK1BfUY3X42Mhg1N/bYcuwyhlj6v/wAgnCz5cPfVvTFf26YhK7ghoUXPqklOoTE6JcUYBT3cINy9S4Iy7CQptmxMexwrEgCCygmjar3Ie/fGfxuRLnv7AEhODtVzRxK/M15nvtg9mPEXax9YG+UxBGVG2V63Ddr0n9wCTfiBM4ZnXR10H9e21FKa3GjDM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rl+lVuoczXbUdM4IECvIxK/tKX7x0mq5iALauI4pGY=;
 b=UuMNsxw6nduDk+aYFP9mFbngguOfuT9PXm+UBgRWRyPC1LDlE0LoBITSfBU7EpArcBzzx90FBPfqq76VWLxbiv4yYw/P9rLGHHZI0X757iOvo5pEmvRVXU+tRXJhRZbS/Q4KPMKlAjsqZj1isLgmmTTYs7AVQD34O/+ZSGFQa+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 01:44:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 01:44:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5] media: imx-jpeg: Encoder support to set jpeg quality
Date:   Thu, 19 May 2022 09:43:48 +0800
Message-Id: <20220519014348.2069-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 049ad46a-dbf0-40a9-5683-08da39391274
X-MS-TrafficTypeDiagnostic: DB9PR04MB8447:EE_
X-Microsoft-Antispam-PRVS: <DB9PR04MB84478F3941CFFDB6898E4753E7D09@DB9PR04MB8447.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZQI7r31enGrBCcXbMTp3Fhj60w2vTiqy2uZNhVRc0lzCv1YsackGJSGFPxV69ppF2nHAbKoVj0thxdMGFr0pJckqD0MGkFEf3SaGW2rvsM5CL9q3mfuCuHEAcArfuvKJ50KB4Kwy2HukAAElrtLpxGCy8xXHcd6Rf2vzFlsdr2ZnWsO1iDna8HLnvT1OD9egxZU78nItZGfIwBGFVhOifk2QtpBrYp57mkucHw8D/vGulsnk68DD3D4h1NZ2sE1bm6ovBa34neJIniOnznGpaqRXN5DQNaxmhQe25b0UhTBfG0uxtlCFH3sHPCAuc42ih/kzUI1IKWLnJb6B1VsaHWFKI7QINn2p7RsC8ZJjXmrkX2mT9DACGXV0im432w5WrEhP3Rrv1UKlSQbjo6eigFDmhSHEuRBXO6olSYHf04OKsk81cfQrJnGQ8P5jnACihfNT4wXR2cF3l3zhCYn/fe6GgXhDBA5rfgEi/Cvk6u87GY2dckIJMTED2QDBev47YuwaYavqSqrwPqRNnBHKYhe0ZkOLVJ5Tp7i2oXyuG8N79E/M6xBfXONsyyD1Vl3moqo9I2mfeP8fSwShqMOd0a3BuVJDy6DXfKHs5GDFN6c/scarzerWe+qJ4fxjCs9KS8FdIRERynRs5BW1TIP0tACwVJkA8JMaNgLb03OFH70/dXkI8pazzCX8QzJOW/z1w7D6inbAOC8Mpa126q/RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6506007)(8936002)(83380400001)(52116002)(6486002)(508600001)(2906002)(5660300002)(36756003)(66556008)(4326008)(38100700002)(38350700002)(8676002)(66476007)(66946007)(6666004)(6512007)(26005)(7416002)(1076003)(186003)(316002)(86362001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iV+MyQ/zcI7mav36r/MhCf1s5ns2r47QUnckCSOVzEtN47qXElBgIk+Tp381?=
 =?us-ascii?Q?3LCvL4EKjWAw/ldGmxgG8J3tvtANGJBreN7KmQhq/w1twAtvb8C5eHd6Cy3L?=
 =?us-ascii?Q?VvlYhDl2Q2+x26hdsgkzPm7YNS08SRV3UycQBwl8hBE1cuSQAkM74VfSzZ1k?=
 =?us-ascii?Q?Uz3bE/Q8mfvhNZh/9qELlXMQdbTq1/5strhFcp4KIpgpWv3iOc+7RpGxL1Z+?=
 =?us-ascii?Q?kVZgrG9l9dyF7QA1GqGKceFby/UfuY3Md61/AMr2nmeW6XX1RssanRr1v32/?=
 =?us-ascii?Q?086v35xA7ktLQnBQsyPs0iGkNNsAeuKLRiSUQ63wOzoY02Y35OFgo6x5NqKM?=
 =?us-ascii?Q?QE6iU6aUAZi1FMzH5zkS+pAWTBg2SxV5Si11qt+DhyVL2kV8LcAzDKTcVGcW?=
 =?us-ascii?Q?8QZhDS65jPBzxSddHCCFsB/pe9pMZWWd7j7VY2VOvzPCUnscsyLgnEXCsekk?=
 =?us-ascii?Q?HB1gJNNIHaNnjpJ3PFE0NFm93JeXnEnJR4dn2ikO637vJI+nCrZs/2R4U9wP?=
 =?us-ascii?Q?rdEpk1PvpqO/nUUhYHjQgF1cvAD10qB0vToH8eiu3L7zv2d4pqBwg5wAZRpQ?=
 =?us-ascii?Q?5F/gyyGH30QbpRW/klJgVcxeMkqdi7YQXicyO3c+TnmsR9QNbP2BUueG23dH?=
 =?us-ascii?Q?tqQQFgd9kUXcuMe2abEVGTzTyG/Qc2BFvRDL8AC8cICvYkTtfBzm5BUWjW9n?=
 =?us-ascii?Q?Dm5S5upiBGnswaOr2gy+WcwXURiheM0FAG9NlqPtabvcwroX3Qduw22qgwXP?=
 =?us-ascii?Q?1PM4ZJzmWZGdJYR0IUqFSqM2qHlz53HqVdL84K0csTa1o1Y/ASNc9zy94V2s?=
 =?us-ascii?Q?MIkwMKucrTrYDGWvERNb6X67d1vVjlnKi+cD9vtG9ytni7X2C/f8rWEN4NQS?=
 =?us-ascii?Q?78iapegYXeudwg43A/A1ZFedc7JdDaIWvUmSvAtZS9dS/0Bmvs2H+ndWbag/?=
 =?us-ascii?Q?/uugA9UEtaCP/GO7M7KduqAkaEuDr6Mf9PaDbz7H1Oq+wFeHN7W/DmMFcfUc?=
 =?us-ascii?Q?lE2gp9uU6VAVK9sTmxCdviAECA47BY2sAZPOKYmZMw8yJxQOIEWuN+mFxUTI?=
 =?us-ascii?Q?Fvpp35NQ75jIWq9oWhVypI+KIIwEQWK78OioT9uSH0+pd/nLzC5lv4vf+s0w?=
 =?us-ascii?Q?iQtXB3zxBmMAQNFwhHj1EvGEDNz8VhyH72/OpZsN+LZukYMF4nnkHc5Wd4b4?=
 =?us-ascii?Q?hXff8Mdl1JnlOZ6LDmkxqz46aiBC1pTCrVp5cka/nRDKRZNQaATV0DacPCH1?=
 =?us-ascii?Q?a1oKHJGjkOpbOh1ARmx9jqTQjBuCl9lhA6BJtBL8cLkm3mV7DGNNCIHjqDaH?=
 =?us-ascii?Q?biFQ/u8UgkMZeez1w824atauKkoGl2Qd4qjw2TebQoXEYnB/f9cUPzRc34sl?=
 =?us-ascii?Q?5d5bYvaoTDCkP2CyedS48FbRDfO27XBAYUEs80PdYBmubi3lIjXRvFSj9Jp3?=
 =?us-ascii?Q?XQPQJXkYPohKWw5Psir/s/fGMYNW0RqpO6ULP6b+nvDNu9epdb9BEMZA88eN?=
 =?us-ascii?Q?/FiaK8nG+rRet8FvSZDvj/piim75r3kTY1MPYupGyltVAVg8yJSt1sbsju1u?=
 =?us-ascii?Q?iwGeI+Gfr/Y9wTXJ99ZqzIV3GV4OaHgz2B/ZrPZ4Meq9OdC1Nv/vbVbLBfkx?=
 =?us-ascii?Q?wh0pOmgcYBJLHeRn6xfhHMPJqebmcJzTFc9qeZ8d/ayNwuH1fEIRrqrjO9y0?=
 =?us-ascii?Q?RQ+D1mr2Eay1umuPvROtrvfohb5bJlwxRsFeb6zKu7qVtgBuUyjVfdCdh1iW?=
 =?us-ascii?Q?6VcrJ6hkjg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049ad46a-dbf0-40a9-5683-08da39391274
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 01:44:11.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRu/jh6bYxcKolr5si2D3MZIeqzMDuSe+j7qQy5+QaX3EbEWelRAsSUfNxSTLRYwMf6aftfQjIT5g+aMmKwkIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement V4L2_CID_JPEG_COMPRESSION_QUALITY
to set jpeg quality

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v5
- free ctrl handler if setup fail
v4
- put the changelog in wrong place in v3
v3
- put this v3 information below the --- line
v2
- free ctrl handler if error is set and return error
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 11 +++-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 62 +++++++++++++++++++
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
 4 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index 29c604b1b179..c482228262a3 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -100,9 +100,6 @@ void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg)
 
 	/* all markers and segments */
 	writel(0x3ff, reg + CAST_CFG_MODE);
-
-	/* quality factor */
-	writel(0x4b, reg + CAST_QUALITY);
 }
 
 void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg)
@@ -114,6 +111,14 @@ void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg)
 	writel(0x140, reg + CAST_MODE);
 }
 
+void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality)
+{
+	dev_dbg(dev, "CAST Encoder Quality %d...\n", quality);
+
+	/* quality factor */
+	writel(quality, reg + CAST_QUALITY);
+}
+
 void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg)
 {
 	dev_dbg(dev, "CAST Decoder GO...\n");
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index d838e875616c..e7e8954754b1 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -119,6 +119,7 @@ int mxc_jpeg_enable(void __iomem *reg);
 void wait_frmdone(struct device *dev, void __iomem *reg);
 void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg);
 void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg);
+void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality);
 void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg);
 int mxc_jpeg_get_slot(void __iomem *reg);
 u32 mxc_jpeg_get_offset(void __iomem *reg, int slot);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 41d27b0d3cf8..325567d5942e 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -624,6 +624,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	    ctx->enc_state == MXC_JPEG_ENC_CONF) {
 		ctx->enc_state = MXC_JPEG_ENCODING;
 		dev_dbg(dev, "Encoder config finished. Start encoding...\n");
+		mxc_jpeg_enc_set_quality(dev, reg, ctx->jpeg_quality);
 		mxc_jpeg_enc_mode_go(dev, reg);
 		goto job_unlock;
 	}
@@ -1561,6 +1562,56 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
 	}
 }
 
+static int mxc_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct mxc_jpeg_ctx *ctx =
+		container_of(ctrl->handler, struct mxc_jpeg_ctx, ctrl_handler);
+
+	switch (ctrl->id) {
+	case V4L2_CID_JPEG_COMPRESSION_QUALITY:
+		ctx->jpeg_quality = ctrl->val;
+		break;
+	default:
+		dev_err(ctx->mxc_jpeg->dev, "Invalid control, id = %d, val = %d\n",
+			ctrl->id, ctrl->val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops mxc_jpeg_ctrl_ops = {
+	.s_ctrl = mxc_jpeg_s_ctrl,
+};
+
+static void mxc_jpeg_encode_ctrls(struct mxc_jpeg_ctx *ctx)
+{
+	v4l2_ctrl_new_std(&ctx->ctrl_handler, &mxc_jpeg_ctrl_ops,
+			  V4L2_CID_JPEG_COMPRESSION_QUALITY, 1, 100, 1, 75);
+}
+
+static int mxc_jpeg_ctrls_setup(struct mxc_jpeg_ctx *ctx)
+{
+	int err;
+
+	v4l2_ctrl_handler_init(&ctx->ctrl_handler, 2);
+
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE)
+		mxc_jpeg_encode_ctrls(ctx);
+
+	if (ctx->ctrl_handler.error) {
+		err = ctx->ctrl_handler.error;
+
+		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
+		return err;
+	}
+
+	err = v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
+	if (err)
+		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
+	return err;
+}
+
 static int mxc_jpeg_open(struct file *file)
 {
 	struct mxc_jpeg_dev *mxc_jpeg = video_drvdata(file);
@@ -1592,6 +1643,12 @@ static int mxc_jpeg_open(struct file *file)
 		goto error;
 	}
 
+	ret = mxc_jpeg_ctrls_setup(ctx);
+	if (ret) {
+		dev_err(ctx->mxc_jpeg->dev, "failed to setup mxc jpeg controls\n");
+		goto err_ctrls_setup;
+	}
+	ctx->fh.ctrl_handler = &ctx->ctrl_handler;
 	mxc_jpeg_set_default_params(ctx);
 	ctx->slot = MXC_MAX_SLOTS; /* slot not allocated yet */
 
@@ -1603,6 +1660,8 @@ static int mxc_jpeg_open(struct file *file)
 
 	return 0;
 
+err_ctrls_setup:
+	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 error:
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
@@ -1956,6 +2015,8 @@ static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
 		return v4l2_event_subscribe(fh, sub, 0, NULL);
 	case V4L2_EVENT_SOURCE_CHANGE:
 		return v4l2_src_change_event_subscribe(fh, sub);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
 	default:
 		return -EINVAL;
 	}
@@ -2029,6 +2090,7 @@ static int mxc_jpeg_release(struct file *file)
 	else
 		dev_dbg(dev, "Release JPEG encoder instance on slot %d.",
 			ctx->slot);
+	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 37ddbde406fa..6e8c5aa7d956 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -96,6 +96,8 @@ struct mxc_jpeg_ctx {
 	unsigned int			slot;
 	unsigned int			source_change;
 	bool				header_parsed;
+	struct v4l2_ctrl_handler	ctrl_handler;
+	u8				jpeg_quality;
 };
 
 struct mxc_jpeg_slot_data {
-- 
2.36.1

