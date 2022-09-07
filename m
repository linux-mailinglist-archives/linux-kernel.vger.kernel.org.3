Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEB05B035C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIGLsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIGLsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:48:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E349754A0;
        Wed,  7 Sep 2022 04:48:02 -0700 (PDT)
Received: from pyrite.rasen.tech (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC9D4DD;
        Wed,  7 Sep 2022 13:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662551279;
        bh=5Gr6bH8FY/a+xkGxzxUB9O3UJ8qXYspamAEUzoCXd/I=;
        h=From:To:Cc:Subject:Date:From;
        b=Cqb942fZYtP8wy6ZAcvycqM00+nUuMy+HxHOW6mxV21wa9PLGYdrAXoG4giNnEtop
         LRxrSSO8ay+JEtmxkbgRMrFoIEjlFNRAVTi2iCdG3Elm8heH8djspN6cbmlAWMIzAa
         6n4wGjexhsk/cfh1aVamZzhx9NAKK1CkhFP6gz2s=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: imx7-media-csi: Add support for fast-tracking queued buffers
Date:   Wed,  7 Sep 2022 20:47:37 +0900
Message-Id: <20220907114737.1127612-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSI hardware compatible with this driver handles buffers using a
ping-pong mechanism with two sets of destination addresses. Normally,
when an interrupt comes in to signal the completion of one buffer, say
FB0, it assigns the next buffer in the queue to the next FB0, and the
hardware starts to capture into FB1 in the meantime.

In a buffer underrun situation, in the above example without loss of
generality, if a new buffer is queued before the interrupt for FB0 comes
in, we can program the buffer into FB1 (which is programmed with a dummy
buffer, as there is a buffer underrun).

This of course races with the interrupt that signals FB0 completion, as
once that interrupt comes in, we are no longer guaranteed that the
programming of FB1 was in time and must assume it was too late. This
race is resolved partly by locking the programming of FB1. If it came
after the interrupt for FB0, then the variable that is used to determine
which FB to program would have been swapped by the interrupt handler.

This alone isn't sufficient, however, because the interrupt could still
be generated (thus the hardware starts capturing into the other fb)
while the fast-tracking routine has the irq lock. Thus, after
programming the fb register to fast-track the buffer, the isr also must
be checked to confirm that an interrupt didn't come in the meantime. If
it has, we must assume that programming the register for the
fast-tracked buffer was not in time, and queue the buffer normally.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>

---
Changes in v2:
- fix the potential race condition where the interrupt comes in while
  the fast tracking routine has the irqlock
- change return value from int to bool
---
 drivers/staging/media/imx/imx7-media-csi.c | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index a0553c24cce4..0ebef44a7627 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1296,12 +1296,75 @@ static int imx7_csi_video_buf_prepare(struct vb2_buffer *vb)
 	return 0;
 }
 
+static bool imx7_csi_fast_track_buffer(struct imx7_csi *csi,
+				       struct imx7_csi_vb2_buffer *buf)
+{
+	unsigned long flags;
+	dma_addr_t phys;
+	int buf_num;
+	u32 isr;
+
+	if (!csi->is_streaming)
+		return false;
+
+	phys = vb2_dma_contig_plane_dma_addr(&buf->vbuf.vb2_buf, 0);
+
+	/*
+	 * buf_num holds the fb id of the most recently (*not* the next
+	 * anticipated) triggered interrupt. Without loss of generality, if
+	 * buf_num is 0 and we get to this section before the irq for fb2, the
+	 * buffer that we are fast-tracking into fb1 should be programmed in
+	 * time to be captured into. If the irq for fb2 already happened, then
+	 * buf_num would be 1, and we would fast-track the buffer into fb2
+	 * instead. This guarantees that we won't try to fast-track into fb1
+	 * and race against the start-of-capture into fb1.
+	 *
+	 * We only fast-track the buffer if the currently programmed buffer is
+	 * a dummy buffer. We can check the active_vb2_buf instead as it is
+	 * always modified along with programming the fb[1,2] registers via the
+	 * lock (besides setup and cleanup).
+	 */
+
+	spin_lock_irqsave(&csi->irqlock, flags);
+
+	buf_num = csi->buf_num;
+	if (csi->active_vb2_buf[buf_num]) {
+		spin_unlock_irqrestore(&csi->irqlock, flags);
+		return false;
+	}
+
+	imx7_csi_update_buf(csi, phys, buf_num);
+
+	isr = imx7_csi_reg_read(csi, CSI_CSISR);
+	/*
+	 * The interrupt for the /other/ fb just came (the isr hasn't run yet
+	 * though, because we have the lock here); we can't be sure we've
+	 * programmed buf_num fb in time, so queue the buffer to the buffer
+	 * queue normally. No need to undo writing the fb register, since we
+	 * won't return it as active_vb2_buf is NULL, so it's okay to
+	 * potentially write it to both fb1 and fb2; only the one where it was
+	 * queued normally will be returned.
+	 */
+	if (isr & (buf_num ? BIT_DMA_TSF_DONE_FB1 : BIT_DMA_TSF_DONE_FB2)) {
+		spin_unlock_irqrestore(&csi->irqlock, flags);
+		return false;
+	}
+
+	csi->active_vb2_buf[buf_num] = buf;
+
+	spin_unlock_irqrestore(&csi->irqlock, flags);
+	return true;
+}
+
 static void imx7_csi_video_buf_queue(struct vb2_buffer *vb)
 {
 	struct imx7_csi *csi = vb2_get_drv_priv(vb->vb2_queue);
 	struct imx7_csi_vb2_buffer *buf = to_imx7_csi_vb2_buffer(vb);
 	unsigned long flags;
 
+	if (imx7_csi_fast_track_buffer(csi, buf))
+		return;
+
 	spin_lock_irqsave(&csi->q_lock, flags);
 
 	list_add_tail(&buf->list, &csi->ready_q);
-- 
2.30.2

