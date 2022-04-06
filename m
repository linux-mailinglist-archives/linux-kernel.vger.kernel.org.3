Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EF4F612C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiDFOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiDFOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:07:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E002E1C07;
        Wed,  6 Apr 2022 02:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PME064jj/4glkJo4uwwFeTLa51SkB3nAO0RLyO9jI5d+b6kyGkL4eAbnwDn3/Wualap6TTNrxAYnevfs2QY0lfSvHIGHTzAqgouOW61Q9vp0xQRaDdcoVAxyHkIwCLsEzap3BpIq9jV8Dvpl2iml3MEq+EwshfxP3WOQaLZsHyGQFTS245mGuRbWXWgTNCJnYYYjGHwt8hos9o2vkWfEnqYo/5r2TWOCSFqlBHGd25sa9XDes9r8ea+kw5ufjMEU2QCno2n+ebWTgtBnWdDxBdmmt+mhdp3h/Z1g6ETFpQD6LHTtN2qK3bAOiMz4aSK9p4CUuTN0Q6nqoeixp2T8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItFO3hq8vrDn/o6z4SEmX81ESsBrjqVlTl87seAZ7PQ=;
 b=WcSNf6X5WKit6DpPSZF+/90sofuTyJcroOrTrZC85MBoJaoJuPZuJP9KM6BVKKAzRZBpWh96plZ09aBHgZINMso5BcxbLhdVoXeflFnN+jZYkEuh/4WczOWOIzrP77Dm4aZZtPpY/cthxaLmKjYy+4bnvt/bqFzHrXRjxvsx0UQSAdvtodBdODLTJZ4pQh4z4tPB8TdVeC/4dQZctXEJ9SexKY0jp6Ty2gJVtn+fq9BtG85xCnnLjl1+AtwfTQHw23zXBbNYy3FJNRhZI3AqhjQWufKe3RTig5x9Yn4NPEffWtuevUB1ux6lTwX/0+pcmTBMyb1wm62nrmsQNKRWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItFO3hq8vrDn/o6z4SEmX81ESsBrjqVlTl87seAZ7PQ=;
 b=Ia8DOR9RRlVzHOVFguq1k9aPiGbef13/bQIHjbMYSBMVILdT/cA6YDy17UnbU/2LiRO/ks/2QRDq0+dKhva6ywAcEEiPa/Iz3nUMOriTlY3Q9VCv4lBgDy4gmr6LfYsZBTGJ8X1qCUergt/6cntgzGM+zIPuP5/CsVSdoNVva9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 09:46:49 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6881:df46:ac23:1bc3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6881:df46:ac23:1bc3%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 09:46:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Encoder support to set jpeg quality
Date:   Wed,  6 Apr 2022 17:46:23 +0800
Message-Id: <20220406094623.7887-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07e2ded1-2595-4a4b-ea3c-08da17b25f0b
X-MS-TrafficTypeDiagnostic: DU0PR04MB9443:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9443597F3D3AEF17E947A8E2E7E79@DU0PR04MB9443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+BLd9CsJY5bS2eNN0KBPUBD2lw2nb+ZtF+dOIOP+PrJ7SNCLbboQZdwqNRQkqc1bQSQu6TazPKLVDgRJ4Dgeittu5QSw/jlhfHY5FjENi9itpXbbr9kLAhWTWY432wwLHJ9bgVjEniw2AFhFzGDswgquq5+UeqBpkyti4TGNgOExQBvR/tKQfgMsjeJN8jDGai8M2bW9yx1/tFwlXXVk9HcHIfh/6x/WF9q9gE327jtZD5CR9IUGL4Qpxt2gVK3KkyBGtkYGSRFUQiEXcwXgRTxj6lF3ydDNm1u9p8L482sLTnWEAqDl3ngXw0tJARP2AWTNFAvW3YaE4VCz5uxcyDAsKvJNi0PqyrHlNQkAJZdd6j7IRkq7Ws6kWCTsWFUWryBa95Ht69QSra5J5kqslQbkSxBlk7sh70gX4y3GJeTNl2ZZGZXVZIk4Zo9wybjO5ApwM78nfYdp0ep7dCF3Jxjp4woYbwfDdNi882yRsd/7e7Bvs84SqG7q9NRWcSPchMu1AO3Xb5GQ//WRmq/j+sSYt5qyAQWNDSo5wzOvfWZANx+e6vpzaHK6ZDnz8yBALejyIA5CEAXLFwTqBO3xrq1IbdNq+kYRXApjPC5/Zo0MWbulxvm5X1WOYD646UK+ljFebTCAoOlx1ieGr0oQ0RNg5OnShPOez64/LJ55acEOrm5BBdF/R5vela+Jf416GfzNIh7gLOKMXeS/4gyoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(8676002)(6486002)(6512007)(52116002)(316002)(6666004)(4326008)(6506007)(508600001)(5660300002)(186003)(83380400001)(26005)(66556008)(1076003)(36756003)(66946007)(44832011)(38100700002)(2616005)(38350700002)(86362001)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9rCZ4VU/HehS1X/Su0UIArMrZVpnXcj+0ahXSwONEFZc5GbhlFGshv6OkJO?=
 =?us-ascii?Q?4gXioazHT7vx6d3xcFDQqbXuKcX57f8bM/edbUrWq16PiVF1agkxs4fXuBtg?=
 =?us-ascii?Q?AVDp4o0EWklp1gJDUsUud3hnBM8M5Cw+bfCyXuhW2prtxPJ7BHFakOrWZb/3?=
 =?us-ascii?Q?VnnA4xrKHsxinrET2QJA7spxluQ+0YLSAUPWSXnjA+gEG3NqkD7V+bMgzJQ5?=
 =?us-ascii?Q?JTIJ183TaqIiOZip3iVenOrAbPD0eriqJBpyLDylY5OxOgPHwOOdtzdt2EL7?=
 =?us-ascii?Q?ZDDKfbFS8e7A0gpCDl18smtwpl9aKaYUbNlBdDVSOoAR2VAV4Y6/GO06ifxO?=
 =?us-ascii?Q?3QslbnutKDv2a8WLZTF0nxCSyBd/aJOcqARiilijH4Z/wvcgzBjzhQAPbg3N?=
 =?us-ascii?Q?6Jy55sxOKP9jzA5JWSfKhxZA9NSKw5d36+SaXUFtyWyiwtXA5DWGVeKlXF1H?=
 =?us-ascii?Q?03Qax+sEfwQeRZ2rPYwXSSmuTGlPABgETwGLQgaiT8M/0Z+ragofqC4XzPjN?=
 =?us-ascii?Q?HH5AXx5v4DMqdVQ1GMlLdWv1gkaB1SIgIeQyQhQ1paZvPpbozDUY3jTG+St7?=
 =?us-ascii?Q?/fOQN3nPAnp7v095TKVUIwTNWBGCDBEC6kE8ecxcVxWxeqeNPZpLsIB1MG7Q?=
 =?us-ascii?Q?Md13ydpeZQkQooFXj05dJvr7BA3x9vGHbz1NPeL89RACYT5awyWHNo4/icCW?=
 =?us-ascii?Q?faq0NVqfJMCLzcmhwFSW7iXQFKxvkKb65iM3UYOsH3VZ0w4D9AKyB8CJkMli?=
 =?us-ascii?Q?3ofG7pcK1l8jCPD3zI15gebfQtaS0oVUBe8WBdhLi0nvcX3y0gEY8/I5uvpQ?=
 =?us-ascii?Q?Ic4BcoSthJ3eFtjChrJa8oXUcem2rjrWTLhJXIj0p+DRbTtt8pB2toVe2etW?=
 =?us-ascii?Q?6zNYa1xKZTcMarX+D+bq071GH6JqHUjf0W3gVbePWlQ2LDV48HjSa5hOrhKH?=
 =?us-ascii?Q?jl/eDoeObfV8/a6miqOnOU2AagufeKaOsirco4o5hDNkACAmCn6BWvzgIAAI?=
 =?us-ascii?Q?IYufxpLp0gax3K/a5CuHwGp2qD4NaGOmNg7+bZ0d3u/L65SVYWCjHX0a95OH?=
 =?us-ascii?Q?3dg1Zsu6xpfGKKvj4uGG5inOUZPn+YQis8gZD8XbIS9RrAYsiu9+DNBJ8iPJ?=
 =?us-ascii?Q?shrYg0e1loDJJ280v4fbECCR5bAZAgZpo37fEs6q0A++cT8UPxUSVu7w/dGb?=
 =?us-ascii?Q?GLMmgyeabj3fnGTTngqKbqdHzUwkbrZ3G0LKwr47hAfYTkdsOmTQDkrQ8f/f?=
 =?us-ascii?Q?E8Qv8KyUCF1qLTBEl/OnA/Zme7uq2/No5XtSnqAXs70n2nCQHmpPFI1K0s6S?=
 =?us-ascii?Q?sqJIkfmIYJlxlPa1DluxGYLnaTY5f9xNDYZBvkn5B0/7zXetSp+5GnrYQeHl?=
 =?us-ascii?Q?C9BItncMK0MJHBidAnna88+BgMXvOyJvCK/bWH5JeVzNdJZSovWbCA0j/zUG?=
 =?us-ascii?Q?tPkRTWBvauN/RMsdnu6GLdtXN5qlW0uwKRfnEFwmzmYaaxDaSCaxpCfc/+z7?=
 =?us-ascii?Q?Y0w7+h0m8s0SdFZ5O3I7WJ2gKLqiqhkGmI+HkEfJGDkRWppJGMpJKJFl11YG?=
 =?us-ascii?Q?/VWroCkt5OpkXge+6trlKT6muJQeI/C1oJJtyQ/ErnW+XSn4rbUE0enW4GgQ?=
 =?us-ascii?Q?IV5utgvzJ7IhNo/uUfDdWAddEbSkUug7phaVmCkMZAypkD8XvUhjLy6LodkO?=
 =?us-ascii?Q?l9iJ1tnifUvWywl5kHiJn/gGghFYyyXj520KMZIp/X7S8B8fiyngzf1/sjFi?=
 =?us-ascii?Q?K5D3dq2mgg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e2ded1-2595-4a4b-ea3c-08da17b25f0b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 09:46:49.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZYkdVlO+ZTsi6wLaE+oRGQRnkoCGCqs4TTGZo0PagCi1Fc8mMGeepmtpwUS5yQlyo8u4hsgdMO3Ylp1BxgTow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement V4L2_CID_JPEG_COMPRESSION_QUALITY
to set jpeg quality

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 11 ++--
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |  1 +
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 50 +++++++++++++++++++
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  2 +
 4 files changed, 61 insertions(+), 3 deletions(-)

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
index 0c3a1efbeae7..ccc26372e178 100644
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
@@ -1563,6 +1564,44 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
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
+	return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
+}
+
 static int mxc_jpeg_open(struct file *file)
 {
 	struct mxc_jpeg_dev *mxc_jpeg = video_drvdata(file);
@@ -1594,6 +1633,12 @@ static int mxc_jpeg_open(struct file *file)
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
 
@@ -1605,6 +1650,8 @@ static int mxc_jpeg_open(struct file *file)
 
 	return 0;
 
+err_ctrls_setup:
+	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 error:
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
@@ -1962,6 +2009,8 @@ static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
 		return v4l2_event_subscribe(fh, sub, 0, NULL);
 	case V4L2_EVENT_SOURCE_CHANGE:
 		return v4l2_src_change_event_subscribe(fh, sub);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
 	default:
 		return -EINVAL;
 	}
@@ -2035,6 +2084,7 @@ static int mxc_jpeg_release(struct file *file)
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
2.33.0

