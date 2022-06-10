Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14805466E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbiFJMxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345266AbiFJMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:52:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3F05639C;
        Fri, 10 Jun 2022 05:52:45 -0700 (PDT)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A335D6601728;
        Fri, 10 Jun 2022 13:52:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654865564;
        bh=wWMofSJhxz35wCMoU0gFvStbDROWmB6gJh3rFolZ2b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc39kUqXVm4NpX5ToqnvUXuwpqC5ysWHcXBhNGwEcuZ0ijPuZch7WdS5d+zyUfYmT
         Z/PFJEJ6RCd1P2d0ABRqYmkU9fpa5Wv27TtRl8Mp5wr9FPZ4VnbHi570Q2NuhqyB1K
         UHoijm+nq8uZxz84O21B1pMgEBrO2ZlU4gJcdKv6dyDpMDkqjnyjbCgb/OOliSUCl6
         p0y3f4l7pMV7l26qQSDHjy3hAC6KRE8n/X7y7kC0M6BQwc9+UebCL9UtsbaKxabNuh
         g6KaqdvHXfsX4/pjANaI+CeTlINqejMqVudTtAmQjhgDMMbMb8sfSi3pjOw/Pz2Sz/
         op8PksAsAQC8Q==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] media: rkvdec: Re-enable H.264 error detection
Date:   Fri, 10 Jun 2022 08:52:14 -0400
Message-Id: <20220610125215.240539-5-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This re-enables H.264 error detection, but using the other error mode.
In that mode, the decoder will skip over the error macro-block or
slices and complete the decoding. As a side effect, the error status
is not set in the interrupt status register, and instead errors are
detected per format. Using this mode workaround the issue that the
HW get stuck in error stated and allow reporting that some corruption
may be present in the buffer returned to userland.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 55596ce6bb6e..60a89918e2c1 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1175,14 +1175,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 
 	schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000));
 
-	writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
-	writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
+	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
+	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
 	writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
 	writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
 
 	/* Start decoding! */
 	writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
-	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
+	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
+	       RKVDEC_H264ORVP9_ERR_MODE,
 	       rkvdec->regs + RKVDEC_REG_INTERRUPT);
 
 	return 0;
@@ -1196,10 +1197,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
+{
+	struct rkvdec_dev *rkvdec = ctx->dev;
+	int err;
+
+	err = readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
+	if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
+		pr_debug("Decoded picture have %i/%i slices with errors.\n",
+			 RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(err));
+		return VB2_BUF_STATE_ERROR;
+	}
+
+	return VB2_BUF_STATE_DONE;
+}
+
 const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
 	.adjust_fmt = rkvdec_h264_adjust_fmt,
 	.start = rkvdec_h264_start,
 	.stop = rkvdec_h264_stop,
 	.run = rkvdec_h264_run,
 	.try_ctrl = rkvdec_h264_try_ctrl,
+	.check_error_info = rkvdec_h264_check_error_info,
 };
-- 
2.36.1

