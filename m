Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A625466EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbiFJMwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344807AbiFJMwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:52:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22A32ECC;
        Fri, 10 Jun 2022 05:52:40 -0700 (PDT)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A15526601724;
        Fri, 10 Jun 2022 13:52:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654865558;
        bh=y4VN0AML4mJdPo0xkn5rxhw/upvGXg3kQ19JexvXyQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UI3Skr/92kfXBj52tMYRIZ6FWRT/l4PEhIYivbCO05yNRyVcPNbvgF58uk6e6+iQj
         Kt3JacKtz/oSASW2AH5I/QH7vXPMz6wOCiOsyncXJ936xqn4AZ5m3kmiw1X/W6tlmu
         xf/VPUEhR65CHI4yAG+aF1fRIK9gY//Rd+U5uh/A86dr2fmKKu+XaIBn3mGETMSOdv
         Rd2KKU96sZayrHVHhRJo4EvEmomy08l8/miShcx1rPDAlwdt5i4tK1OPwfYD2RCAkv
         iQrqhZCJU60bytKOvheg2H2SuLwBfmgt8jjNdeG7jG5sm0OqBOvTtsnLFCAPOLaSKM
         ZvnQuhht3iQVQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] media: rkvdec: Add an ops to check for decode errors
Date:   Fri, 10 Jun 2022 08:52:12 -0400
Message-Id: <20220610125215.240539-3-nicolas.dufresne@collabora.com>
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

This optional internal ops allow each codec to do their own
error status checking. The presence of an error is reported
using the ERROR buffer state. This patch have no functional
changes.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 10 ++++++----
 drivers/staging/media/rkvdec/rkvdec.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7bab7586918c..7e76f8b72885 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -950,6 +950,7 @@ static void rkvdec_v4l2_cleanup(struct rkvdec_dev *rkvdec)
 static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
 {
 	struct rkvdec_dev *rkvdec = priv;
+	struct rkvdec_ctx *ctx;
 	enum vb2_buffer_state state;
 	u32 status;
 
@@ -958,12 +959,13 @@ static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
 		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
 
 	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
-	if (cancel_delayed_work(&rkvdec->watchdog_work)) {
-		struct rkvdec_ctx *ctx;
+	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
 
-		ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
+	if (ctx->coded_fmt_desc->ops->check_error_info)
+		state = ctx->coded_fmt_desc->ops->check_error_info(ctx);
+
+	if (cancel_delayed_work(&rkvdec->watchdog_work))
 		rkvdec_job_finish(ctx, state);
-	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 633335ebb9c4..4ae8e6c6b03c 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -73,6 +73,8 @@ struct rkvdec_coded_fmt_ops {
 		     struct vb2_v4l2_buffer *dst_buf,
 		     enum vb2_buffer_state result);
 	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
+	/* called from IRQ handler */
+	int (*check_error_info)(struct rkvdec_ctx *ctx);
 };
 
 struct rkvdec_coded_fmt_desc {
-- 
2.36.1

