Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8961D50AD2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443041AbiDVBY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiDVBYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:24:53 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ED3496BB;
        Thu, 21 Apr 2022 18:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXFvwc8itQcIjnNDEUJPyBv0CqVMEJZfeEzBAhZBxtlrqh8US4G69jrriqrx+AVburq4Mp7vZnGNHtx+nmiFAGmmolB7/Dw0OYOU18WDUZfDAJa9ToGonIKAehVQboVxYNbmIzYM3n4rsrO15u6l3mMokNBRI5AiCM9bLh9bLC+i/CypUO8syR6TV0QemgU5gXQ9cXQT7rRjwtsqESvbGN9WEjxb1vuoJypjMf8NDCBjmTJ5m4sTU+iS6pwOufepNifhhmN6hJAkgBuu8Q91375m/cgcVqg7v6ntqhiIRm3XVMcKJBgeGB4Yhbv/xiPDyg+aCzeupB5U4zXUuSUnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDu+HTGG2OitpFpklBMyUhdNcBnbZiXui6olJg6Af6w=;
 b=cBp9uZsQ49VUvQq0Pa8/X+TGpL1aNNdESJwF9pJmfpQvXpsIxYsTUdZO0xdADP+KjRCkkyZiCCuhxkabhumMSfneK7YxLXYH9kiWjaVPS2euxecKE3ZaRTUPrPcS9HvXFnasZouK72/Hhzui43DzbhDaKjSRQM95jtiWrv88bsmjxwe0jJZoRxJpxzkwx4Npy5Ha77QX1D6dvJ4lsDhE71anWNDRjPHIGoLSqoLPtIGTJCrv9ofIfSCwhuuj+/2vDLCcrO6m3vm5y83ptJ33MEzmkj5+cwNQdf/XJgCVY7nAUC41PhG7vcXUABuhhiebHU0mjiAep2WKsa08/BmhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDu+HTGG2OitpFpklBMyUhdNcBnbZiXui6olJg6Af6w=;
 b=gYkKPUtPW+uxrY/XmJRGIpq2DVWY2VInfuXj0+whITxzXRizKKxxwjaF+wSVQrA9zvVwyPSSFHbN8EQkEOYtwfTChtp7iFEDP7gD6E1JZz3S3CHSwmb5foWa+09P8PwagJHGrAYEmk2+nnee6KGYgFvxtxaxCegfWI021Ghug9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6001.eurprd04.prod.outlook.com (2603:10a6:208:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 01:21:58 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 01:21:58 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: imx-jpeg: Encoder support to set jpeg quality
Date:   Fri, 22 Apr 2022 09:21:33 +0800
Message-Id: <20220422012133.23079-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 333b87d6-fda7-46ed-b92a-08da23fe7eee
X-MS-TrafficTypeDiagnostic: AM0PR04MB6001:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB6001C8B9997E3636F3B01B9DE7F79@AM0PR04MB6001.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yP16Ri4Tu6oVQfYNMq8IkS5cQwhlMP535TbDihlr6SH+vqG0nV715fOR3NEAsJtakHox5bfQcvUBioarryPPM9BoKx19JTwtpfUrZ5UhSf9eg8FpMPzBeMTyOGaarCNNUKwT6I4AKNEA8l/Rk+rmiBDkKtCO0faq7YEABRKLtzfsg2vBvP6c8GjZRw9PLA8yhLU0hYddwOwVr608RTdHsCiWiuQy1blBZqwC6A47Tq6pjyQ4pGkUABh1E1cHsOyzLT3TeOBI6DNd9C6G//Dbm8auQkqjm92Q7Cl3tJEwBaxWpDkPmNb/+nGHOOtEtaWttt3Ga5tCcvBz3cIZTRZxIj8BL80GDCDD3vUNsmS64wFq4oBxw1RDyRvGUiDz5VzG7vnY8LPWtqSDUJqbt2Fhz1QYnR8B7W6AgGjBeWAUqYYor0H5L7BOKazzEcUxoOR9ppURvJY/jFP/c+Ah5SneeqB5af5oWvjop2y7PlAHFXfUILWYh48h7mI0IEB9pAWtJN8V7fcREJ1IRIs8Zu7yGxENCUOvDbmnVyn3tWeR9xvbQVPqFbMbA3FkoMktU8X53pFGQGthqZh8m/mmzQhRAmDXVvsHpsQHhzP/3gzHxeEIrkkrsaS9jep8oebswCYv5K06jmv/a6HIDvWb7PCvh8cT7jV/tndAKkhvECn9GI3nMc76pmsr1mu5bGzcb1aknXtcyibTQTHLxqnNeDcEkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(36756003)(38100700002)(38350700002)(6512007)(66946007)(7416002)(4326008)(8676002)(66556008)(66476007)(2906002)(5660300002)(83380400001)(6506007)(6486002)(86362001)(508600001)(186003)(44832011)(26005)(1076003)(52116002)(6666004)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4aeNl4qUAn7Vkuqf5S22Jjs++M3ZjTyXA6FyKH1it0YWD/ZuF4r2tT3BUanq?=
 =?us-ascii?Q?riSXWccz8XDH5Ept7dKwudZx5kcGCySf73LzGeAdQU+i6ldJ+FEWSXcg6Vui?=
 =?us-ascii?Q?RWGBPy9sVSjmMPt/P5nCuMs+MzQiyFPeAuvxh2arYzhCZEeK5VVyhU5mXf7L?=
 =?us-ascii?Q?WiZPe16hxZDC48dNpsghc0VwNPdwDwW6zRXScM7nj2gQu6krfqcDoOAIRFzx?=
 =?us-ascii?Q?2icL3ZmymnUSxOz4yx10akl7Mbi3w4i/YqqEXuH6yZdSEw/BCMc7moDvGdbW?=
 =?us-ascii?Q?/rVGGo7zlxDCrMt/WS0i/f/vHApENQX2oc0IfaAMEeGcrefVxjS92cTlt0CA?=
 =?us-ascii?Q?QW2JsYnZ0jJiUzQfCgYW7flif3ir++9DHJY9QvhH83zeApr9ycR36fpEj3S6?=
 =?us-ascii?Q?4dJ61USmcys3s3VQs4fSbx32hSLfqXUBdXDc/ndIA1NJrPb1egy3PHszivie?=
 =?us-ascii?Q?JVYBSdih9tz3tZ5KB8HiGvR7M9EtHb6RomMXyUgnFCV9D3+R9xQWHr6B/DwP?=
 =?us-ascii?Q?kCW7wpOSb9WeP0hFIL5vaBQP2BdqJwXi7NneAoIHSnbit6amn4LvEpnJUrKl?=
 =?us-ascii?Q?bxOYvy8IuvVW+9uvEvAqgf8mYscT/Bh1S/Kb6IMNnoZUeahBg00kWgPnYP4V?=
 =?us-ascii?Q?4mddfQrF8kQmc7iSDOmuLZY5vQtxWBE2XGBmr4ktkHpmCRRkh2KCD3WTuFYA?=
 =?us-ascii?Q?PCqWqJxBWVWzHCh0B72x3w6uiUfCWMv7f3puHhMorhG8cUAopeR0vOhx2veV?=
 =?us-ascii?Q?WxmT2wbXSGliKKQCmKeQgUoUwlti25/jI6YCzqLy4vi+URZrzfF23mkk8Hey?=
 =?us-ascii?Q?IX+PlDi2mADtasZ52LeBjTNRSLjyYFE1Wofn9evwpCXTfdpW2XvzON2iJefu?=
 =?us-ascii?Q?3cO7VVVyVd8NWaLPh7J7D48caxfc/Vg+jFM43Og1gRShh4Fdg+ho5ufCdAiY?=
 =?us-ascii?Q?kO3EHj1o+YzqZH0qAgu93EHkXlHZ8kpMA7EjJFDi7TwjYg8Slq8SfYpcRTFB?=
 =?us-ascii?Q?c8jaE5Ci8aLv8R11yN1gDeR6CBPBW2bldEmHntS+1u9tt9JVJS5yYZrWWhgg?=
 =?us-ascii?Q?wveChUI72B0fihyMye2fYxWBBYBxC2GOsiVjGX2O61AEm7+QzswSOmjsryBD?=
 =?us-ascii?Q?7O55kzts5pWs5XQWaBr0y2dJqTgvMK/ln6GXRUG6+RdT5YS4ay8NUXkY1MKA?=
 =?us-ascii?Q?mzRRaA99i2bSUUuX/w3HmcgJEv5rUKSxkywqi1EdpJd8HEYbAxSyla30yl+E?=
 =?us-ascii?Q?IfuEE99d5eMWC5LHEkvQ1zA1Dvi1Sq2III5dE5+KT2lRp0XWJPi02g4xLhhv?=
 =?us-ascii?Q?Kq1KZyvC7QsRXWdWDKWxGSr76EIOms1CU2m6fwMrmhOBT/lGxhSYlM4tLdrY?=
 =?us-ascii?Q?iN33z+/gkEbOxlVTb/lRnMXRZzJ8LRMnqat0lliLj1Tg3Zcy9lexjmqa7t/C?=
 =?us-ascii?Q?dUVbHQMuZNdZ4oXeDFgEkneb6ZC7wUzklGHVY9rnxXgKwOVNe98NJfRhnN+P?=
 =?us-ascii?Q?WS51sxfaJqvQt+tfd1s6eP8zeE3DTUOme0OtqLg6pwxMxBt3EP/C8gvsb+ng?=
 =?us-ascii?Q?m4tZ700CkecQJL7XZ5e3NI/WOnT6DaOTRoDfzfP5Mb1u6aV89XLMsXSns+Gl?=
 =?us-ascii?Q?BWnMqksybZadeHB8KG3LouMWtJ/ZJRMEIxa8HtEGTBl7NPHLWM1aTcUfpsT+?=
 =?us-ascii?Q?eItKMNAFfkARrQokeJWcaohYwyKh5Sfon2xj+AhR/2PJVeJiZTXxq+1U+LVJ?=
 =?us-ascii?Q?k9Y67beLHA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333b87d6-fda7-46ed-b92a-08da23fe7eee
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 01:21:58.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teq5kIDXk7Th5sbFyTpaw2KtZx3vpZo7ZBz6ysssUgX4iZNT92McwKAMs9fnC8KaceI1prIA31XMC5F+ULfZvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6001
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

v2
- free ctrl handler if error is set and return error

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
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

