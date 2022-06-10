Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC45466EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349058AbiFJMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbiFJMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:52:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD344A16;
        Fri, 10 Jun 2022 05:52:47 -0700 (PDT)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 326D8660172E;
        Fri, 10 Jun 2022 13:52:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654865566;
        bh=KEgYpRbmOg42RSvzgWzI7s0Dp0JPZPIQTRZtvkFaa8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqDiqDXGwGHyu3h9CfdF6JAWg8pVEAp7cWWaAgc6izCdsLLvepxAjJouykKy43dWM
         8QzWrjNMJWBEJDQDtLXEMHR2S7fWtChcPIGY0Dft4r5Z13Pkp9GiCrd0YyiHJ9gxZ6
         Zc2LkjX+iNKmvSijbrah7q4Qmz+zYYIqDKlH0e6oOkYrXgHM5fODqxWWr1Np+0woBE
         8yU2M/bvRcMfUcBYCGdtYWBWmZ2VnquGtq79hWTs1/vDB8ecz5l7aDPIMF7ukgg3mF
         10lfCbPqtsUd+oQvNNmecDE2dF8fYo/ZJF+GKhbjJ5Cc0eRMpxHRIaHya6rqKhaiac
         v1vAk0fBPNcbg==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] media: rkvdec: Improve error handling
Date:   Fri, 10 Jun 2022 08:52:15 -0400
Message-Id: <20220610125215.240539-6-nicolas.dufresne@collabora.com>
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

There is two way decode errors can occur. In one case, the ready
status is not set and nothing have been written into the destination,
while in the other case, the buffer is written but may contain a
certain amount of errors. In order to differentiate these, we set
the payload for the first case to 0.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7e76f8b72885..27f1f7276dd2 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -954,14 +954,32 @@ static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
 	enum vb2_buffer_state state;
 	u32 status;
 
+	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
 	status = readl(rkvdec->regs + RKVDEC_REG_INTERRUPT);
-	state = (status & RKVDEC_RDY_STA) ?
-		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
+
+	if (!(status & RKVDEC_RDY_STA)) {
+		struct vb2_v4l2_buffer *dst_buf = NULL;
+
+		if (status & RKVDEC_TIMEOUT_STA)
+			pr_debug("Decoder stopped due to internal timeout.");
+		else
+			pr_debug("Decoder stopped due to internal error.");
+
+		/*
+		 * When this happens, the buffer is left unmodified. As it
+		 * contains no meaningful data we mark is a empty.
+		 */
+		dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
+		state = VB2_BUF_STATE_ERROR;
+	} else {
+		state = VB2_BUF_STATE_DONE;
+	}
 
 	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
-	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
 
-	if (ctx->coded_fmt_desc->ops->check_error_info)
+	if (ctx->coded_fmt_desc->ops->check_error_info &&
+	    state == VB2_BUF_STATE_DONE)
 		state = ctx->coded_fmt_desc->ops->check_error_info(ctx);
 
 	if (cancel_delayed_work(&rkvdec->watchdog_work))
-- 
2.36.1

