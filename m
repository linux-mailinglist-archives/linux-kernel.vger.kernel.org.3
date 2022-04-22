Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0550AD7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359561AbiDVB4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiDVB4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:56:30 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20048.outbound.protection.outlook.com [40.107.2.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5149F2E;
        Thu, 21 Apr 2022 18:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNNtGqpldRkgnw0VOPHruk2cblLOQbycJwrudsXVMnj5SxtHgqcQMhkBMh6sI1czmC8spOUjpb4jF/N+HqIerlRyQQ0lyvHRRhz2yh2ImeK1NHfZ1Tkgs9qLR8j/CiYW886XM3jbUwUtbZDeJ983OZCG9rV8PfNmJp9zHARtEBGZrMLlea09ZQbZYIgaXUs4nZ7BXRoP37kEO/Y1KcNEw2WHxHYx5i/Guxq+r+p6QNLaqV4iZAC+34c3uFAz6PdQjX0a24ri4eMUi7o0NiojIFHyIIUb0D9lcUs8bHF98dbo84WJvT4ZT+ME/YeataGP9c7NIPFOscqjKl7Sd90Xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4tpAmY7ac9JVj49jZI+v5nbyERzFX6Ow6zAIVB45ps=;
 b=dIGIyZX8ec/Cz34PCizHd2iAFbIf1klZtDJBhLe8AyjgcuUiGi9YHS8WcKKEXJpUm0LKrClmKLZVqXdA3tNQfUBSophBVeC3vJPUHybxrUyNLJGd/8SNklLVehCPOCazqkutq2YK2ZL3jC5WtO70jIjKYmJM6y/S5NrcKqOPkHfpEvhbjt2gpv1Tt5aD7CSbFW70HW4sEJP8k4rEYQsman9ZX53XcQbM0/xB2ovjsO6e5u+Lx6p5aBzNdmrW1TMj9W1xVY0HrGJz0KlJtmXdrOzR1Uwc7AkGO0RSqg+74lKgBsqjBRTMRwPvZ00CoxAARbpfCzRyr+wMvJqPrBmtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4tpAmY7ac9JVj49jZI+v5nbyERzFX6Ow6zAIVB45ps=;
 b=BIjxsH1+slFmeooD5oobOvw0ajp0A+GkNfd96GzCSZrUuoknbTItR6tYIvYu0ehYULcoP59VRtdlE2drwThHOLjLRN3+4Ri3rq6k+AHWrohc6anLgQ7MIXHwnGsShl3dcVy6553cMlfbAqXVR21gYBzp5trPp+COtQ+ZxEuS5H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR0402MB3581.eurprd04.prod.outlook.com (2603:10a6:803:3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 01:53:35 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 01:53:35 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4] media: imx-jpeg: Encoder support to set jpeg quality
Date:   Fri, 22 Apr 2022 09:53:20 +0800
Message-Id: <20220422015320.14600-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0080c211-8d02-4e7a-917c-08da2402e9cd
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3581:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB358170731DF292EB48352864E7F79@VI1PR0402MB3581.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mL3hNN5Cw/RyqccQCK+fOGfV4r1w0g9UIvPm+rq/Id3c8B4LA7e2OAnYFRPKh/LTVKJvqDgbosSxf9fkxNNU1jK3C8OzCA/7EvLTXFxlnDm4oUpHszkeKSz9QL8OUkSXm7a6NjOVNRqywF0zyGkYOkYmMzoEUVpFZYJ/h58pf/Gr/r0VrC3xjEAu8Lv8GPNZblfu5nyJaunWt4k58txELzStRbc9gqf82Sbne8kmZMDexnQ9re3DJ96fSZHSDasHr5KvcInaXaqK1Ikp5uG/MBGbnSmcXIDoDNzQDZWz6t371v4WeJ8JXpMTzh/9CzcAio1ciEfkRSXh/cWT7WyekFzq+r1MyWOfbp5ttaNIrOb9twetDP7YcIks5CpnOM+/L9ct1fZ1uiiyrtSVsqDbhB9bk8N0Hy7uLjbEeBWFz6enGTYUO2zqHCVYex134D3LFN3OQkO1FDQjwOWfT/fhtXcasvsm/bxrWrsjDOgjYRWmmUCkPDTg0RquEJsNAAIAznJBgsljZJZliKri+dS+qH8WNVzSmdzqV3GxkQNK1M0HoTKz4kjmUE6+ZC8NCr1pV6Fb3VdzJXhkmYej6JUvKVY54T2Nsq7M58Y54sq3ZBzcamqnxMqKH19ekmJTh3ExqaFfQx82sAgMG6e/1Ow2FzaESVfIF4tL3e8G+i+OB/hbWlcW3rWMgYLrDpm2OhEM2hn/NdHoctEGMjdJSaQCRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(83380400001)(316002)(8676002)(66556008)(66476007)(38100700002)(86362001)(36756003)(44832011)(2906002)(6506007)(5660300002)(4326008)(38350700002)(8936002)(1076003)(7416002)(52116002)(6666004)(508600001)(6512007)(6486002)(26005)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXJIWXQhrJxlzwON6xkekzzOek7d4QoNrpVsasDBjbsJbZQM+rcXHNYqNQPT?=
 =?us-ascii?Q?76HJ1GZbkG2rWWRWHESCkzsB+GMjRIaLO02XzZuvyUFCnsUTzhZgiwIzjAau?=
 =?us-ascii?Q?1r+637zbymmmwDG4ZJEOe19kOG8f4+vZ5PD42o/zQwlOopHUJpVgf3kWfO1g?=
 =?us-ascii?Q?p3bRDrXoyjT7HCrf+U8qh+6PKqr2intKvmA4axGTQAxdM3Hsj6EXB1QCIdpp?=
 =?us-ascii?Q?rJ33J10/ah+qSbmRouMPzbdyB2F+mNoxZxfuonQ0hr/K0aEyoz0iCPKsySbQ?=
 =?us-ascii?Q?qj9z/I+oDtBvm55HUk5bhzu+D87qRIdPnKEWOS2ge9EC1y/uZUjt1QVJc8qr?=
 =?us-ascii?Q?yjBooe+g4QSmjbZLJdGoA0xTvwWcZeG9YwRVniVYP4WKQnkWXzFVkMgPTLPm?=
 =?us-ascii?Q?oa+8qHt6JegA2gubGsYoTKO4299umRKhj1owT4jZ2oj+bTclzClua3dP8cZS?=
 =?us-ascii?Q?/HVjKUB/Swfj/NihQ97enQhNXzFbPjkqGLMgRu4KX2mOcakyeIUEGJFPhoqi?=
 =?us-ascii?Q?9LknCXW4en7r1SarQID8/BI4CJ6tCu0/AsIcbFpexFt+7ukVtQJ4OwQGS0hD?=
 =?us-ascii?Q?vmYb3ZTIDrYkonYv06W6rhlOH8RUmzFyfKGURMZBpzh2+wloHYv3+CAl+vav?=
 =?us-ascii?Q?iRfxPT7YaF4NhKYZF7Zc10rnK58nTOuvf6tV7iCTdM8SfM728Uxp5+JkaF4H?=
 =?us-ascii?Q?gt2dJ8v1Mlt4GvTHd4HC1clLyg/rY1g8y3VpNhpJfVY7Sqa5voss0pexvhYU?=
 =?us-ascii?Q?jvOQNPF9IW7dBbBOLt5Sp6SfClXHHmrE38zCE2bjaefarEWpGRzIDo/Ax8nt?=
 =?us-ascii?Q?mtoA+MQK2VYrGllIKSqkzVMMfCO8vSJJWWD0mvQt6rPeskL/7aw1DY+jPW2V?=
 =?us-ascii?Q?VixW0j2g9NPbrXcpac1dlR6FRLN7k5Nop+QYg+7YIaSJz8WP/gzIjKNI4gMG?=
 =?us-ascii?Q?F8IjdnpxZ+s/t7X1+jJKrIUN/FcSRVcjfs/OQI75hoSoYNTW9c9RyvoozX1L?=
 =?us-ascii?Q?qEs0hlMjYueZVNUpBnS4Ya8T5bGFXP0Qx6gvfCkX6RJaapPtbgv8JueDkXx+?=
 =?us-ascii?Q?yebinc95V0I3wsANkNE4fUaCILEHupYOY8GrC3ibQd1fU/vCNCoI32SkbVWG?=
 =?us-ascii?Q?RYztPb0MnXQ/D1EeIAdPsST3O56eafwyi09+Bs8KXrNNuSUQ8rt2rEYuuKlG?=
 =?us-ascii?Q?Q8gfwR2IRTxS4DG+5vcx+hEQ7hJisJMWlGNUg5905s+yoj3U8qA16ouTOvfp?=
 =?us-ascii?Q?rc7W1Vfm3ryjcrB68plUCOlqOEXWdVj37Hp9GcPJRmnbWZNtazErs4QIy7cw?=
 =?us-ascii?Q?FtK9QVKEIAkaKZpN95iUEB9Zg1+MYkU6P+ZB4DknrOrzcQgoEWn3AHyFX7WT?=
 =?us-ascii?Q?CAPgErDfniq4Kh5oeqUTzvRN0nAzYrd4lbv2Lg2Gh2LXMOKhled+kUo5uPEw?=
 =?us-ascii?Q?r0ZraYv3Sh9q/mNkm9QkOvs9Ce7BVA9tWLzdrqDn6WrybMWDUQDeDU87uaS9?=
 =?us-ascii?Q?8pr8HA/K47Hl6/NBBYJeHREjPnn7RrTAgdkgQihJfFkrTnPLI3QzI4jXEOPu?=
 =?us-ascii?Q?sGJEqmG1HGCCz0mYQ3XFcJrSOGcN/HwRLCKiQjvPhRyap0ByDb3BChjZ40AI?=
 =?us-ascii?Q?b2+M4EI2rwr+cSy2bp9jjC6+hIEl8IisUW/wn4c6qlWsJL929HqMhlKwFfOh?=
 =?us-ascii?Q?YjEleyyAzfghUscC+ybwjJ5oj6kfMATf50JSXduAPmAaIKmk/doh8DHrfWJM?=
 =?us-ascii?Q?UcHDi5rvOg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0080c211-8d02-4e7a-917c-08da2402e9cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 01:53:35.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhBfitPq/TgvPq0bA1cf1MrPVVnRhRZa7MwsLFRB7dZuX+jbh/J7HmFu+JmDUhvyvRuvMSnKqQJ5yXwpA9cvUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement V4L2_CID_JPEG_COMPRESSION_QUALITY
to set jpeg quality

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v4
- put the changelog in wrong place in v3
v3
- put this v3 information below the --- line
v2
- free ctrl handler if error is set and return error

 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 11 +++-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 57 +++++++++++++++++++
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
 4 files changed, 68 insertions(+), 3 deletions(-)

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
index ae70d3a0dc24..356e40140987 100644
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
index 0c3a1efbeae7..1bd245ba00e2 100644
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
@@ -1563,6 +1564,51 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
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
+	v4l2_ctrl_handler_init(&ctx->ctrl_handler, 2);
+
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE)
+		mxc_jpeg_encode_ctrls(ctx);
+
+	if (ctx->ctrl_handler.error) {
+		int err = ctx->ctrl_handler.error;
+
+		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
+		return err;
+	}
+
+	return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
+}
+
 static int mxc_jpeg_open(struct file *file)
 {
 	struct mxc_jpeg_dev *mxc_jpeg = video_drvdata(file);
@@ -1594,6 +1640,12 @@ static int mxc_jpeg_open(struct file *file)
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
 
@@ -1605,6 +1657,8 @@ static int mxc_jpeg_open(struct file *file)
 
 	return 0;
 
+err_ctrls_setup:
+	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 error:
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
@@ -1962,6 +2016,8 @@ static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
 		return v4l2_event_subscribe(fh, sub, 0, NULL);
 	case V4L2_EVENT_SOURCE_CHANGE:
 		return v4l2_src_change_event_subscribe(fh, sub);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
 	default:
 		return -EINVAL;
 	}
@@ -2035,6 +2091,7 @@ static int mxc_jpeg_release(struct file *file)
 	else
 		dev_dbg(dev, "Release JPEG encoder instance on slot %d.",
 			ctx->slot);
+	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 9ae56e6e0fbe..9c9da32b2125 100644
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
2.35.1

