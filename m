Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5738950AD59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443147AbiDVBpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443125AbiDVBpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:45:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D249FBC;
        Thu, 21 Apr 2022 18:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRybqMa70u1oZruZ7O3JtpkSTqSDOKAkvPIV8BlxPIeDS5c78HAj2OVeeVKKZx80BAFk4kdc2HuRlEARYu+nrDbK6de9285EiaQTmML0m9souNJjfXvtN3+a/ZOHd82KLCuwR+bQ1AJdUYpgjf6UEHSiVCpt6YgHWfP5H8VXqYJmpW056ouy047G2wajpnkC6xGsHF+KdZUsXVz0QCSjw9wA1h0Dm5TlUI7sCUimqy7Y5fRII80RoT/OUMwVFQVNvqe9WR9ECOlicHCm/TuEeJ2U7Jbz6Y3i2nY1hS1d2FXEWLdp5IlOim/Gpj8rtMDo6iNJuY7J7UfrhLtZ1qUKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXUtA2pT2fcq6kqE3mqV9cYOd8aGikqFtp3QfwDFyTc=;
 b=j4cRXezTsAH/mUWeRod2cJbgrxBwg2AtVGHNFnwaZv/STMimDFAz7Sf9dXYr3pfW0EhLX7eDdQaAftD1ArJNiS1uiH95wQQLqVXkr5gcP2qXA4p6fL+Zg5XETT+kP03B0JyJNnwDPfjtV7Zvg/yra3OoxlF2kphjF4els9QeMb8HDjwIq0cwu41qaHU0sv3CRShIlxEPjdtLzkC/qBuUkuenkhCtdFbF+7tIS1vX8xV6jr7M4cOQUahaEIT5mGWo52FFT+FfgnvFcNZbbmVPJwbroxiG8MEYdFaFHlCAednUvrEse99cwvJYQe+eNvphJhCsSWmlq3KHEf1fX+ocdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXUtA2pT2fcq6kqE3mqV9cYOd8aGikqFtp3QfwDFyTc=;
 b=gVweSZChulDc16cLbIAm95u6d26iwsduhsM2bKNjetIAt7TN3pwNTm3jidzwOw35HUPScLqndnpPr7xqk/eBBzjqYpt47v+7tY7891sqPnibQhZX2Kfg+PlT5qcBd5rENLhrA2VwnStPSabRAwX2mSsMfkwIzn9Ucgokh2kGL7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 01:42:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 01:42:13 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] media: imx-jpeg: Encoder support to set jpeg quality
Date:   Fri, 22 Apr 2022 09:41:57 +0800
Message-Id: <20220422014157.8200-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1f5f31a-67f5-40ba-ea97-08da240152cc
X-MS-TrafficTypeDiagnostic: AM9PR04MB8145:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB8145C1E8E48BEE29B741DF9BE7F79@AM9PR04MB8145.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Alov3tW26KUfoU2OpOsdxMt2ODxaQj55W4x9qVZIK3sbq+W/YzRRaCa1iY5Z+Dti1WSlB3rlFQSjTjM/5ly/OKwFw3KPBfcfO2b5oQ+AuquMQxw04/Szrdrjoo3exrjh4V0cylBNFI5Maav5u2M0/YsCgHrIZTf+kpGfTRr/2sbsBwzZS4WHAsqt6q9lmJAJYvUNB+CACNKILzoTL91Fx8KJgE759V82pdSHyiEocwqCPBIr/PHbcbwsZW+13/1otWcxwOECwEuB7YVPkyupTR3720WXtu/KupYUuH0ty66YWoKM+jTq5PAHW528muzD5A2BejkjaLj5US5cjXNx3X0d77X4tkdbEjYo/uM1VJngrPOcXtazUwLODXUgxR6Sfo8LJSFVIVtxXyA6/eAR5KJp4UjtDdpEh2bwGXrxvKchMKMoV+L58UbSHCVRusqk2gdR6GUnHY5UP+NyT7E/5uXEbtFgJhe9jiP6Lnm9XskCuyduZ+ethDucD+7Mt4ZtCmycoqbB0I0j5annlETdaSzZinHEWq14PzrrZAHb6SEotmuDsYXzV5Vq7GZ1fU9Y4jk67ZHsLjgEVJDCp93+zJCKg5CQAhj0HgOTn079ngvTDeIBrcjgCO83ieKKsIJopc8LcmpIHgHSPkdmWyaVWWCeBdR9dnDnIntmraOkihdAwFiFNUHfpWa3UiQgLR6nqXi+8+rBxyXYzuVSJkhPnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(2616005)(1076003)(6666004)(52116002)(36756003)(186003)(38100700002)(38350700002)(508600001)(6486002)(6512007)(26005)(5660300002)(7416002)(6506007)(44832011)(86362001)(8936002)(316002)(8676002)(4326008)(66946007)(66556008)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ikT7iaxraeajXwzgUmKw71VxbJ/kf81Wm+FjURdIxx6uqMgFmmVKhY9mM3S?=
 =?us-ascii?Q?ZE8CcEhJSNDXnUBKV+4P6QcpoQxaFPHt5T+mOP5a8H0H1+UobaodIvDDSUAC?=
 =?us-ascii?Q?kJyrSVTYYtRKZ/p77EaC8YXtY3wmVtgdgjVWRHmiodkPX/zoqoqCytAzmyb/?=
 =?us-ascii?Q?zGlwDpYRtSReaLUMJaWn6rsll9IERkl8xBR8aFsbwsY1tX5TT+2SOliFSNFK?=
 =?us-ascii?Q?7m76T9hZKOthYGclfQf+j7TLMGdLvZ2njGgl/3L3i8RskE0BGl9kYOCYLCwL?=
 =?us-ascii?Q?YKdww5BR1/VMXh66XuGZCSxksNCsjBUBPNEk2auB9EBXc3Flt5+7yJ8z9khd?=
 =?us-ascii?Q?vJMu6TxAdEiqn9bJZDJhJr0aMKelWI8i7W4byzISTOzmGYBHNIcBhcjmwIUm?=
 =?us-ascii?Q?1OiyUzk2wRxzTWv8k1PpF0U1YGp5Pu8t/8Hieh4l+19EwkmCKY10j6/431IZ?=
 =?us-ascii?Q?YqVWBNRjGzj7U8Hq9EfLFSFK3ziGXx5teKVaViEzJLzYmf+6V8Vg+FhCtDnP?=
 =?us-ascii?Q?TewfnpKbQhOUl5cSVbzrELe3AXVW6llVcftCYxZeX3C2syWWNtN8uu3I/yxB?=
 =?us-ascii?Q?yca8YYou5AqEOb7iMwh2KzJfkb0cUa3KQIGTlugfmtm+j6dN7mxO+qQED966?=
 =?us-ascii?Q?uAZ9+WD/56PPZhMJc2zrMAGRi0YvrL31v0wGEQlmmEE8bFE5buY5co25t9kJ?=
 =?us-ascii?Q?K2p7VK/0CrJAMGfyJ3wuHui8YtVZdqQmqOfOEI6tUcRAvyhb9KHFMwjI4N93?=
 =?us-ascii?Q?gUmM0HT77w+cB2kIfCuTimIpJc3WYOgCukw5LSjx4gm0ICkJa9Hp3ImAIffu?=
 =?us-ascii?Q?AITOu4Wkb/q5ruBrhM8G6T0fRYvsVIRqjtrI4n7s4FJ0KWhHdhWuXdoAtsRu?=
 =?us-ascii?Q?pVlu9sQB3ETviWkTW7HodOD1DD7nwzYhAqKcHI44B2BXFC1rxxJtXV2iIzo4?=
 =?us-ascii?Q?JFfiodwkzqyHKZD8CaEqqV6eGOVnR/KmXt9m36oY2+KNsQQI0MiMgp31VTr1?=
 =?us-ascii?Q?J+f6Uwrmpm0Ed6yrSh27OKGZg713jU12HW8fKoOIs8bUGHVmx23u0Ql+6YIc?=
 =?us-ascii?Q?ATO4jyQCselP6lhOsSkl5JGbYy9nCsVxSJ2BUwSaEgSURKjosQd5Sy4ghUEh?=
 =?us-ascii?Q?u3vjPWnOMq4Z/X7JKLiNYczYFGB7l0Pb21piQGRxicrd+oXfmv5Am5CplbPc?=
 =?us-ascii?Q?5kYwP1AbuQ7aQbwrIaBSgyQc6HPujj6wS9ZyOCHwpCQREa6ZbAXoMrSYhvc/?=
 =?us-ascii?Q?1f5Lp63siT6bUvIbdF3g8+l+S0NT4sgEk6qVI7Ynvno+jvOitNtUn7FIR7ha?=
 =?us-ascii?Q?KmFfe8Hu3ZdJG+KCszn8rQxnAZjEj1PWIZhLIsd9NvgbcU9K7bL49G6TBZFo?=
 =?us-ascii?Q?dl2sBFH4YQMQGjxqPquMYTvdupf2drUyHNE20DMwC4/9vw9emvmPrOchGOY2?=
 =?us-ascii?Q?PFoWxln+ittxY+4vD67ohZSO1Lf5dSxdpRBt7OElYJ3o11mCMLlLXkzOR9T8?=
 =?us-ascii?Q?GrJHmT8QzUFHjIL2HX8IWwSV918bnwncnQT+zfSNhUi1MVAj73wUKbtVz75/?=
 =?us-ascii?Q?yzgdRVJ750WLe74LTY2DxRd6QjYU6876uFTbytheHRJ8XSZnoTlMg0YJk8so?=
 =?us-ascii?Q?6/0NCs8gJFn/cv4/V3A2/en/nVqavbSGdnwjrrJP49XSvoqbnL9b3+UHY28H?=
 =?us-ascii?Q?LQUjrT/Iq/u5rcPh3MRBaUuHvCm2v/2WC7RE4gxAdpxtOLlJn2ExqMfCc/+v?=
 =?us-ascii?Q?aL9YQ0Ut2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f5f31a-67f5-40ba-ea97-08da240152cc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 01:42:13.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7844iuTBir0ainabF0DVcwL4Brj6ARVuhiwj6iiQAcAeXQ/UoGsi3ESMMp0ixdYsZ0dr/gTdFTf1T/mVz273jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
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

---
v3
- put this v3 information below the --- line

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

