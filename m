Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553AD5779A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 04:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiGRCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:37:58 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30049.outbound.protection.outlook.com [40.107.3.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E5112D27;
        Sun, 17 Jul 2022 19:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW26sSoGuDOQ/L6YpLMKHi2N80F2z0QwbJYX5sB9YRDbytgBRDHCjO+MrrsSPbXjbBzERPQK76mD0kYdXhaq5qnCtW6pRKPR23hR7+7n2/UX6ak0scwe7Uj6zMFa+YGDlGqgArNTI+N868LfAawlAyc5c4JHa+1f1jrTpQLIkK+NyUFl9hkE9VNV1f50StgP9SwBYoFn7k9ygivpOlh1s4lDlryDAiBNkGXxOK1JPLmq/HZoc56OB9OJtuQq4ZdVLGjrP7lWGos0faAonLSntHMMo42qkkDDxVvLL3wd5zuR7yeOmPiwAOYvRP7PCY7wfcJOy9yjyVGVz3GOwIkcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4zoyq4H77PNPEBlgYv1EuYhWhpwjpbAkbn+nJ20HNY=;
 b=FaL5JVoL5CBeYWxhFGdGBRiL7u9+VY22AbbdeWKL5G4N71zyGea9PHqsa8Acgq8nQivLwizwbtqQKIiK9GfXff2Xeb6HUtaXwgsoCWQ7dHaHkKUsOJkn+9JpFlKitAZvFuFa9GJkm6eafXNHXF14LZ7v/UthRfOmb9iyFPJkmfdvLg6y3QnbTfe+2EvmWl4KurnSu/cSL/zKXVwpOtAMja0/gkBy4rPr262OSEE/1yiq6lfr4JsAYi1/bfHzUNWIonWkbbDZ9hTG3xnFbYBi83cCbf4gX8Pc8hJlXzbJHV8P23y1BecHOzVHvhCy7u1bM+QfsM7SqMCVtYFAQ+lNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4zoyq4H77PNPEBlgYv1EuYhWhpwjpbAkbn+nJ20HNY=;
 b=YQrTLvD5x4LngE5ml7hpg0LCBHsWe5n5O9la8ea1D8078waQmu9LpsGF66VysK+aObKUu+O2WWa040brJuDK7byRZog2At4MnZToKWzNit7J/xo7Ns0SvTZJ+i44yXcSVtEGpP341TTJ4P6KabjhCcEHAl8ejSzsctgGwMJWVdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU2PR04MB8710.eurprd04.prod.outlook.com (2603:10a6:10:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 02:37:54 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 02:37:54 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Add a timeout mechanism for each frame
Date:   Mon, 18 Jul 2022 10:37:37 +0800
Message-Id: <20220718023737.12007-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94efd272-8cfe-445e-de5f-08da6866842c
X-MS-TrafficTypeDiagnostic: DU2PR04MB8710:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85y/EUoOfUyOMisVj2W7C7pxipjEf5V4tJ1GSbu1EM0wZQHtU7v1qoAU+nhIstAcHVbZT5u2KubqvUuZ9bnQk4Pe46cU0RZ1MbDz6A3GCp8but2yY9OlPihgAOBHMMmBHgdDme8C100/6T0XVZH8Qhw8EeUOk/PWwe5skWgxUryt447ImpJqE1WjZIoEO9ZT9q27ufIea9bPvjI+KfeQ9GO7NEdIcDWGDekcJe265xdQUNZ4/w0zhRpWDu28XYIkZy8hqRajUtkbWrOX36T+MJzWaHaTIxOhsQDlMWIJgqG2E9DjnAPvgE4iRuVlOGQlS+lbYLQM7RFqu6oiLlnTME5KHY1sMAg9bqIpEVe9khPkzZU1aBn7wBxbrZ/4GXKT3wDdUYcTSELq8FnSfbfjxcC/IRNpEgvrMl6j6hMKkLYbSRD+Hs3uVKQlFz4eaB2mLsDNs8acwNlsEQIauApZ8Lsy3kTLsxWl8/7TbuHn7PGtULgvLDXl+GB7rmmO/pkxfJ6I35RopNDrxJ18IlgpX/XSzVRIHDgmZcyYT2A+fLPK2XdkeRaXR2NhjWFEYa2h396Nl2M9t4BI+Xt9QXJE7IPS2O696U0iRCHGCI7VGR/LzIFSXrw6MLJqgyeARzxarGU4MTEOZ2/yQCxv4Wqzcpet7MA5su2sgS6llHao+tojLOsDY66sj5Gh1UNJrnA/4IlhZMGWlAg+ukKvDoJoTGsKVs5Ms8mlXeADK/DuhuO+ZbhkqaLqqKE0EEEcXZvA7SuMOT81D2DAE9rBbxNfI1Tfa0XsdxcwXW37+koGUhDibbF/r0JhIjZZ55K70B+h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(38100700002)(38350700002)(316002)(66556008)(66946007)(36756003)(4326008)(8676002)(66476007)(44832011)(26005)(2906002)(6666004)(41300700001)(6512007)(83380400001)(1076003)(7416002)(2616005)(6486002)(86362001)(5660300002)(8936002)(6506007)(52116002)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xUp7L4X9q4I7c1Ml4GEuSkQV1TfpJkEwcGBpWDCfOMIbC44zoblL1Gf6VI6c?=
 =?us-ascii?Q?iW1HXW74mwGgUU/w0rmTrmfXJCrOUtRQrnETvRQC4frcjybXVUGWlsGv+5OK?=
 =?us-ascii?Q?6lN6osw7fZtx6WXyCarFNuFaQUo3g+DFCmvGHCdvfZ1bjmkKazkKAW1npyb8?=
 =?us-ascii?Q?JrPn3WGDlATKGCI7w/1oiIGzGF0cqTF/G7yWCcbbp4EseRngweg8tLCeK2f4?=
 =?us-ascii?Q?D0ZRhZJzjzzVFCxg6aZlvEWumOQSBbAyFDyR8CqN97Jd5qJTRjmduZCYY9AR?=
 =?us-ascii?Q?4s2L3/g6+yoOFTYnt3TrHLQPoOHDnQJZiyUwF2ef0xej7ieHFvsyxH8jOk0L?=
 =?us-ascii?Q?HsE0gu9NwjdqPZuiWA0IgJiudF7yy3xovcQxYweAwKxWRliveZuzGttmHqHc?=
 =?us-ascii?Q?CeKDuWgfysarm4bPwlE2/gSddSx/xStNTBPpsi3RkFCph5w72xQLpsCp2VCW?=
 =?us-ascii?Q?P/3JtLouvktuqK4WOGOctf//aH3FXR5aAWg2uJaze+8x7pH5FEbxjPzd0oUo?=
 =?us-ascii?Q?OB2DsNrkGhyaA6DkApmR7twkxuestS3rMA9VQFqqrCHqU1xWGbxSqwFhp09G?=
 =?us-ascii?Q?xvh3SbyWNFbynLhD9fu1f437DsezbbE+3TClBuA4H0DlNb5GTbSU21jGlBGd?=
 =?us-ascii?Q?+tDZ1ZNFtC99IamwibEP33hOnUvcOZngmVm53LMl3qMYwcjwJO6r/9UxLh+h?=
 =?us-ascii?Q?W/6KToz9zbLDCND5Jhp3+uX8sFdKclvsoCUYsDWdxCrtO4/TJiVIl1/JZCTh?=
 =?us-ascii?Q?u/NXr/N/rWgMhz31FERaCmDZCHw76oz0uV/A/HaQ3OVVHR9oJjVPw6fdoO1D?=
 =?us-ascii?Q?vhgb1A8W00RntkfOiRbtjjM7vtP0BeQP7T3emKck33TN8ILsIw71DcU0bcu+?=
 =?us-ascii?Q?47TEbeipV2FwluRbs3WwbD0/LjWhH5OsWetsQxX0odWRoX4KRxp9AZC7nAXH?=
 =?us-ascii?Q?tep/qSMIFLXvS6UjbmLSMnyDqWHXz04i/ikYPh9odVvPUl8vBRnnexCu/M/0?=
 =?us-ascii?Q?HwjPbAq+XnNDIGMdURYCz8clxusHrPKh9lTnOGkCKruDko1qpQbibDUhVNhf?=
 =?us-ascii?Q?hL+UHP24jTtc6x1rZZyJNChhe4ajlFqCzlHqZp1d/kxprXj3bvHU3QHz3ZhC?=
 =?us-ascii?Q?JgVBG6aK1mKsacCytqgVu7bWqaGhiHqKOtCHdnIJeslfKNE5C9ZvpJ6CsLq5?=
 =?us-ascii?Q?73XlsNaXOswn/B4dKOF9n6Tmf2ts+sIIEQDJrw9uUxg9FNT/zRWJpNcMj5U+?=
 =?us-ascii?Q?lzqp90bflTpAF+XtqwTPYK5TkW8KPqdnvesm+M6FV5oFsnifEKQupcTLyUME?=
 =?us-ascii?Q?5ACB9oN5Hld7pHcvOnxpVhKH3NDTx8rx8DEC7GBMf6UFt39C/jMTw/J7HrXX?=
 =?us-ascii?Q?VO3Qt+8LLUe+m8EOLWg1ZjHAEn6Ay2gsTsaeBE8900a8WuW0MRZWFGeaP+0x?=
 =?us-ascii?Q?dmwLxdNs58Rf15NQXxvok9bliEHWy/6a+vC/n1gTLa0jpze0wbCKBiIh7yo0?=
 =?us-ascii?Q?Y1fm8qmCDGpNvNW2JBQ1eqMxs903QHmdoxJ0zuUXuk20jGtgIpPoAWMdkYRC?=
 =?us-ascii?Q?sh97Dx1lil1G9au2h+zkneHgImRr0BhyLup+jwAk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94efd272-8cfe-445e-de5f-08da6866842c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 02:37:54.2019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdNq6meh7FOMj+7UBnOaABKs8SCx4q799QOLPtorbCyooso6s7Yb1R8TubgCvGzzyEUn1TABod3VOycdx0TCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a timeout mechanism for each frame.
If the frame can't be decoded or encoded,
driver can cancel it to avoid hang.

Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 55 ++++++++++++++++---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  1 +
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 32fd04a3d8bb..fd5a65e577f4 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -330,6 +330,10 @@ static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Debug level (0-3)");
 
+static unsigned int hw_timeout = 2000;
+module_param(hw_timeout, int, 0644);
+MODULE_PARM_DESC(hw_timeout, "MXC JPEG hw timeout, the number of milliseconds");
+
 static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision);
 static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q);
 
@@ -570,6 +574,26 @@ static void mxc_jpeg_check_and_set_last_buffer(struct mxc_jpeg_ctx *ctx,
 	}
 }
 
+static void mxc_jpeg_job_finish(struct mxc_jpeg_ctx *ctx, enum vb2_buffer_state state, bool reset)
+{
+	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
+	void __iomem *reg = jpeg->base_reg;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+
+	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done(src_buf, state);
+	v4l2_m2m_buf_done(dst_buf, state);
+
+	mxc_jpeg_disable_irq(reg, ctx->slot);
+	ctx->mxc_jpeg->slot_data[ctx->slot].used = false;
+	if (reset)
+		mxc_jpeg_sw_reset(reg);
+}
+
 static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 {
 	struct mxc_jpeg_dev *jpeg = priv;
@@ -602,6 +626,9 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		goto job_unlock;
 	}
 
+	if (!jpeg->slot_data[slot].used)
+		goto job_unlock;
+
 	dec_ret = readl(reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
 	writel(dec_ret, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS)); /* w1c */
 
@@ -666,14 +693,9 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	buf_state = VB2_BUF_STATE_DONE;
 
 buffers_done:
-	mxc_jpeg_disable_irq(reg, ctx->slot);
-	jpeg->slot_data[slot].used = false; /* unused, but don't free */
-	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_buf_done(src_buf, buf_state);
-	v4l2_m2m_buf_done(dst_buf, buf_state);
+	mxc_jpeg_job_finish(ctx, buf_state, false);
 	spin_unlock(&jpeg->hw_lock);
+	cancel_delayed_work(&ctx->task_timer);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
 	return IRQ_HANDLED;
 job_unlock:
@@ -1004,6 +1026,23 @@ static int mxc_jpeg_job_ready(void *priv)
 	return ctx->source_change ? 0 : 1;
 }
 
+static void mxc_jpeg_device_run_timeout(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct mxc_jpeg_ctx *ctx = container_of(dwork, struct mxc_jpeg_ctx, task_timer);
+	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->mxc_jpeg->hw_lock, flags);
+	if (ctx->slot < MXC_MAX_SLOTS && ctx->mxc_jpeg->slot_data[ctx->slot].used) {
+		dev_warn(jpeg->dev, "%s timeout, cancel it\n",
+			 ctx->mxc_jpeg->mode == MXC_JPEG_DECODE ? "decode" : "encode");
+		mxc_jpeg_job_finish(ctx, VB2_BUF_STATE_ERROR, true);
+		v4l2_m2m_job_finish(ctx->mxc_jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	}
+	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
+}
+
 static void mxc_jpeg_device_run(void *priv)
 {
 	struct mxc_jpeg_ctx *ctx = priv;
@@ -1089,6 +1128,7 @@ static void mxc_jpeg_device_run(void *priv)
 					 &src_buf->vb2_buf, &dst_buf->vb2_buf);
 		mxc_jpeg_dec_mode_go(dev, reg);
 	}
+	schedule_delayed_work(&ctx->task_timer, msecs_to_jiffies(hw_timeout));
 end:
 	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
 }
@@ -1672,6 +1712,7 @@ static int mxc_jpeg_open(struct file *file)
 	ctx->fh.ctrl_handler = &ctx->ctrl_handler;
 	mxc_jpeg_set_default_params(ctx);
 	ctx->slot = MXC_MAX_SLOTS; /* slot not allocated yet */
+	INIT_DELAYED_WORK(&ctx->task_timer, mxc_jpeg_device_run_timeout);
 
 	if (mxc_jpeg->mode == MXC_JPEG_DECODE)
 		dev_dbg(dev, "Opened JPEG decoder instance %p\n", ctx);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index c508d41a906f..8104ee4a3b7a 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -97,6 +97,7 @@ struct mxc_jpeg_ctx {
 	bool				header_parsed;
 	struct v4l2_ctrl_handler	ctrl_handler;
 	u8				jpeg_quality;
+	struct delayed_work		task_timer;
 };
 
 struct mxc_jpeg_slot_data {
-- 
2.36.1

