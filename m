Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267944E4EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbiCWJIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243142AbiCWJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:08:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF6A74857;
        Wed, 23 Mar 2022 02:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BegJH0dzxoxW8P5nK9ICZN8pb5QGR0PkZOPOLCSKjeEH8HttkYXnzO/E/cRKMT3ve620AnwDvXhXWGmpXqkrAf/BkmoW98Ds8BTYOe/1rkkDzjR2MDtKMh8Wj/8ZlfhSxM1KUVd+jkFBrhIb5Ciaa2eea31piBBnMs3m0d4OshXNr6ojVNOgBWNQnuMoZ7RZrKj1LXUELpo37DTsHPyT5KdofPufnoaphctDuyY3OP0T/aArm2j9MS7zL6+5c2GlsfVGQ8cPoa/UfcBVts/F2QNJ9vfGPnXWLvVZfqjgBFERwoWxBqVebc9e+ENYEXvUI8KJsGjRfiLM3kigYuup2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxnJbqncKEweF+paty/0EbSShq4QeW2vvkPTLwpQZRM=;
 b=hafWvuFOEhOhFS6Hr2fvL1cmxol40ZkIOeoATPaqCnrQNbb+wY4GfxvUbzwwHczsIEyepsGNi8AOAFaAjBOHWYe9vCpnwEN9Me0b9/14QmSLhFHf5dRwX1o1emwpewQIxJijnCpmlEWQOrJwXGCmQFTGgo7vT8GHEh3Keevij/9mzIIhdhavGweF7nb4XGJdEJHX3LZgwlsdIwigiV5Kg+cB9U4SD8loNKZm0V40iKAK12CR7DmSAZu5YsUg0yz+DQJfBi+IDvzO43FsxarQqSnwL7d6hlFcZ72upXtvk5JIjbY6NCHIbAavbixd/PwTQqVkt7aDu1Dev/qXv3wJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxnJbqncKEweF+paty/0EbSShq4QeW2vvkPTLwpQZRM=;
 b=JYv60Lr6R3II4bmiszl0VTpurBeyioMR6KgADEY0cKJmbX0fDz/Z5kIMaSjhleoEUC14+rxQMNmV1OOU6ALw+yVjNJ7lrVC92BtUE9cLvbadGlthHpF5Wj0J5KnNLjznHlsRDNZcRv5A3PHJ6NdId8ikJ56qmhrdUI+BfJFe5XM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBAPR04MB7317.eurprd04.prod.outlook.com (2603:10a6:10:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:06:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 09:06:29 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/5] media: imx-jpeg: Handle source change in a function
Date:   Wed, 23 Mar 2022 17:05:57 +0800
Message-Id: <3f3be7bac34c43b38ac77bcdccf93e1a364534a2.1648023273.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1648023273.git.ming.qian@nxp.com>
References: <cover.1648023273.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:3:1::24) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e8fa2d5-9a55-49b9-98d0-08da0cac6b1e
X-MS-TrafficTypeDiagnostic: DBAPR04MB7317:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7317A07D011B8EFBD101C752E7189@DBAPR04MB7317.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtZ1h5/EvTqQQSvpCmnGSp9YbINGbV/Lz3NX6gtPInjmrmRn5TwFlS21QyThiCyBJ21ASBioEByZB69lzxB6fksLA0f6tlgmuipLK6tpG40crJZj2vsKdblk1EyPYih4EM/+foYa0oHLVqHIr7lkh442yinPFvNKSgUwftlxnaioPMOP6JEF2zjpoodJS7z6gc3vtI03t2m2CVIxxJiV4ySR7INJU5JyNc8+dZvd6lmFsY3fGjLd6ipGkhmE6rmqUtE0GEZ+CTgyhlhZK+Pi90raT/GQisGOlKPqBDTWu1KOzTQZqgBrsEs/erkJm5HqRz6+/EN9kxqgoIoBOml9isCieJwiK1dTWGY2QWEv5P5s3k9n7wV+zmy3UinZhC/QvGUXNk8X6AGdkyn/uLrl9brEJiU5hiIYr75eHY9ZYs2EvGjtesDCdOh5Si8g2xxPr1pGkU7RNEE3n01Uak50bS/ovtnarb58tcnjmMtoKjCjKpb+Y72RxzN50KPyXge7iUD8fsOkdUyrtk5Qq0+C1dt2E1KFxh+IbDszjS15dFkou++T7noQtXEM0iRU0Ad7kuwN+7lnb7FZMRL3aXjRF3/vCMOf55GzpBkxwmKKjDjJQ+TucuM1+++zozBaNjOkM0zQmsXloOzGhpnN2aBWoet2WDL1QV0pU86u1J05kgafmvUnQBYraW8kI1iw4XlWU9K9qCf4js8e0PnlUGK2tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(5660300002)(38350700002)(38100700002)(83380400001)(2906002)(66556008)(66946007)(6486002)(7416002)(508600001)(4326008)(8676002)(44832011)(8936002)(316002)(26005)(52116002)(36756003)(86362001)(6666004)(6512007)(6506007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6AskAJLj1C8gnGtte/orF88XigBIfuSz+ynWmPs+eoNGw3W66cOoX8kIM6q4?=
 =?us-ascii?Q?wMnSG8/JIBD5wQkJr9BmFtO9htpQENJNHCZH3Kiqv0OVtX+Y37cSG/KBUitx?=
 =?us-ascii?Q?M+BBM6cPPXitsv6kYD8g+UzPLEKl5+juvK2A70ZLGDy+BcDijcMmBDAgWw22?=
 =?us-ascii?Q?RDfGIL0yIBBTx8liYu9JU3fdYsCRLqSTojnwMbioah5O0KM8DG5Az1lcsV8E?=
 =?us-ascii?Q?Q6yzVFVVinf33dNJldhHoXsrzh4IJykWAuIK15EWF8zpKDh2xGUzwzuIWXWk?=
 =?us-ascii?Q?JagPyXB/Gjl5m1XrRDpPUfU/KTr3ckWJXas/D0mePj9Pz/5x4VqGLgjXz09w?=
 =?us-ascii?Q?RQM88yPnF3nY0U3OXQz7RIK98fmoMcuB8b92CkaITaOtVe99InAFxP5zAsXI?=
 =?us-ascii?Q?132FhM47XqjjjVVpVFYac1Mfw2QwGFUgH3inD9j5NTNUTH+S+vVKkum3fBwh?=
 =?us-ascii?Q?ZH0RzB5dor9RwB5alxmfkEXOUGYfOtAsN8pOGAswHLM+peHbTSHlaFKAiIpO?=
 =?us-ascii?Q?si6gyh6PbeLIP+XUIbfZiKlYfCR5Sf4sw4kBEKOBuVNM5vl8JMck6H3k1nop?=
 =?us-ascii?Q?hlEO/nIenMsHpFJMzrZiAy7pJ6s0b6ZQDdk5TmjejxGVTqQXCQVspv/OsO8K?=
 =?us-ascii?Q?1owVCRu9/YdXJYqhPCfmRvQxO2VkBUNMx2/q21DHFKYePOdAEwuL7iUq+Ipy?=
 =?us-ascii?Q?NkPnU3iqPCgra2XmjkyO+NQ3xZYv5xW4uMyyu32SB/x8JTr2xAoA8vGwNUiB?=
 =?us-ascii?Q?yzOYJ1jxbcb4JHAexCNmi/561ZlL4vytMzsUOJVYe8SouSkFx7T5JRpOqrBM?=
 =?us-ascii?Q?mYGOAiJVwO7Qw8Z3p9dKvPMAhTbyaxYFgWov/tqwwBrge716k2EKYombIcDu?=
 =?us-ascii?Q?Jxvr6GhuiuIaILRFrDLUWMFo1TgAwPTtBIpYZ/3t4x11DC8Vl7F7DkTj1dUZ?=
 =?us-ascii?Q?6xJ/i9UdBE9qwO32XOp07n2NmW/tA7vvTG1emJURnzepEaREJzVO/NOF5d0f?=
 =?us-ascii?Q?QbNIpIGogD9vWNEjy0+v50difeMB918bt4Rkxkr5KH4HniBOPHP0Fmxh5Atq?=
 =?us-ascii?Q?+EDbU3MH04JGlKMGXIsRUyO6E+6fad9/pVhrkVvDbIpvm63bzbrhJ9+nVHYN?=
 =?us-ascii?Q?fA+MeIN4Wn29MT1TFj3a/a1tc7/Mwovv/NKWo6J7kjY+SYjRJEv64Cnrrqw6?=
 =?us-ascii?Q?Of23a41H0ISUizCiz8fMOxE4Z44lh5y60ajCSW5S2kR1PiahgfulEJeMWePg?=
 =?us-ascii?Q?ANWWSpRxmf+9m5bTNslOddyahNuOvFRNJha0XYiHdJLRHF7NQSwyFcoBVu3Y?=
 =?us-ascii?Q?y9GPdN/MH6tJtt+Inal/MTh6y9u61vbE/ZY6XzTUCHyER4DlMG+5SMG82T6C?=
 =?us-ascii?Q?vWHbxzPGX9Yx5GyUjVAds6jE+ofgib9Ts+1mdsUXEHmqFJV2M/Q/h2DKjA3L?=
 =?us-ascii?Q?B5AY6aNKYqaMkIgS7tCDB0eZHPWdK/1U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8fa2d5-9a55-49b9-98d0-08da0cac6b1e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:06:29.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frFg1VXFRUsw93qENf/oTk4JKoD+xkov4KlG7EAtjotottOd6U5nGSw4tsYm0iRRFlG9zeaMyTaHvy9KtJa44g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refine code to support dynamic resolution change

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 114 ++++++++++--------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 5dfa6f87871e..30289f2be3dd 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -315,6 +315,9 @@ struct mxc_jpeg_src_buf {
 	/* mxc-jpeg specific */
 	bool			dht_needed;
 	bool			jpeg_parse_error;
+	const struct mxc_jpeg_fmt	*fmt;
+	int			w;
+	int			h;
 };
 
 static inline struct mxc_jpeg_src_buf *vb2_to_mxc_buf(struct vb2_buffer *vb)
@@ -327,6 +330,9 @@ static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Debug level (0-3)");
 
+static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision);
+static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q);
+
 static void _bswap16(u16 *a)
 {
 	*a = ((*a & 0x00FF) << 8) | ((*a & 0xFF00) >> 8);
@@ -922,6 +928,59 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	mxc_jpeg_set_desc(cfg_desc_handle, reg, slot);
 }
 
+static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
+				   struct mxc_jpeg_src_buf *jpeg_src_buf)
+{
+	struct device *dev = ctx->mxc_jpeg->dev;
+	struct mxc_jpeg_q_data *q_data_cap;
+	bool src_chg = false;
+
+	if (!jpeg_src_buf->fmt)
+		return src_chg;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	if (q_data_cap->w != jpeg_src_buf->w || q_data_cap->h != jpeg_src_buf->h) {
+		dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
+			q_data_cap->w, q_data_cap->h,
+			jpeg_src_buf->w, jpeg_src_buf->h,
+			(jpeg_src_buf->fmt->fourcc & 0xff),
+			(jpeg_src_buf->fmt->fourcc >>  8) & 0xff,
+			(jpeg_src_buf->fmt->fourcc >> 16) & 0xff,
+			(jpeg_src_buf->fmt->fourcc >> 24) & 0xff);
+
+		/*
+		 * set-up the capture queue with the pixelformat and resolution
+		 * detected from the jpeg output stream
+		 */
+		q_data_cap->w = jpeg_src_buf->w;
+		q_data_cap->h = jpeg_src_buf->h;
+		q_data_cap->fmt = jpeg_src_buf->fmt;
+		q_data_cap->w_adjusted = q_data_cap->w;
+		q_data_cap->h_adjusted = q_data_cap->h;
+
+		/*
+		 * align up the resolution for CAST IP,
+		 * but leave the buffer resolution unchanged
+		 */
+		v4l_bound_align_image(&q_data_cap->w_adjusted,
+				      q_data_cap->w_adjusted,  /* adjust up */
+				      MXC_JPEG_MAX_WIDTH,
+				      q_data_cap->fmt->h_align,
+				      &q_data_cap->h_adjusted,
+				      q_data_cap->h_adjusted, /* adjust up */
+				      MXC_JPEG_MAX_HEIGHT,
+				      q_data_cap->fmt->v_align,
+				      0);
+
+		/* setup bytesperline/sizeimage for capture queue */
+		mxc_jpeg_bytesperline(q_data_cap, jpeg_src_buf->fmt->precision);
+		mxc_jpeg_sizeimage(q_data_cap);
+		notify_src_chg(ctx);
+		src_chg = true;
+	}
+	return src_chg;
+}
+
 static void mxc_jpeg_device_run(void *priv)
 {
 	struct mxc_jpeg_ctx *ctx = priv;
@@ -1209,8 +1268,7 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
 	return fourcc;
 }
 
-static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q,
-				  u32 precision)
+static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
 {
 	/* Bytes distance between the leftmost pixels in two adjacent lines */
 	if (q->fmt->fourcc == V4L2_PIX_FMT_JPEG) {
@@ -1261,9 +1319,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
 static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 {
 	struct device *dev = ctx->mxc_jpeg->dev;
-	struct mxc_jpeg_q_data *q_data_out, *q_data_cap;
-	enum v4l2_buf_type cap_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	bool src_chg = false;
+	struct mxc_jpeg_q_data *q_data_out;
 	u32 fourcc;
 	struct v4l2_jpeg_header header;
 	struct mxc_jpeg_sof *psof = NULL;
@@ -1331,51 +1387,11 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 	if (fourcc == 0)
 		return -EINVAL;
 
-	/*
-	 * set-up the capture queue with the pixelformat and resolution
-	 * detected from the jpeg output stream
-	 */
-	q_data_cap = mxc_jpeg_get_q_data(ctx, cap_type);
-	if (q_data_cap->w != header.frame.width ||
-	    q_data_cap->h != header.frame.height)
-		src_chg = true;
-	q_data_cap->w = header.frame.width;
-	q_data_cap->h = header.frame.height;
-	q_data_cap->fmt = mxc_jpeg_find_format(ctx, fourcc);
-	q_data_cap->w_adjusted = q_data_cap->w;
-	q_data_cap->h_adjusted = q_data_cap->h;
-	/*
-	 * align up the resolution for CAST IP,
-	 * but leave the buffer resolution unchanged
-	 */
-	v4l_bound_align_image(&q_data_cap->w_adjusted,
-			      q_data_cap->w_adjusted,  /* adjust up */
-			      MXC_JPEG_MAX_WIDTH,
-			      q_data_cap->fmt->h_align,
-			      &q_data_cap->h_adjusted,
-			      q_data_cap->h_adjusted, /* adjust up */
-			      MXC_JPEG_MAX_HEIGHT,
-			      q_data_cap->fmt->v_align,
-			      0);
-	dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
-		q_data_cap->w, q_data_cap->h,
-		q_data_cap->w_adjusted, q_data_cap->h_adjusted,
-		(fourcc & 0xff),
-		(fourcc >>  8) & 0xff,
-		(fourcc >> 16) & 0xff,
-		(fourcc >> 24) & 0xff);
-
-	/* setup bytesperline/sizeimage for capture queue */
-	mxc_jpeg_bytesperline(q_data_cap, q_data_cap->fmt->precision);
-	mxc_jpeg_sizeimage(q_data_cap);
+	jpeg_src_buf->fmt = mxc_jpeg_find_format(ctx, fourcc);
+	jpeg_src_buf->w = header.frame.width;
+	jpeg_src_buf->h = header.frame.height;
 
-	/*
-	 * if the CAPTURE format was updated with new values, regardless of
-	 * whether they match the values set by the client or not, signal
-	 * a source change event
-	 */
-	if (src_chg)
-		notify_src_chg(ctx);
+	mxc_jpeg_source_change(ctx, jpeg_src_buf);
 
 	return 0;
 }
-- 
2.33.0

