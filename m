Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93185AE5D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiIFKrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbiIFKqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:46:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8B7B7A7;
        Tue,  6 Sep 2022 03:45:23 -0700 (PDT)
Received: from pyrite.rasen.tech (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1839425B;
        Tue,  6 Sep 2022 12:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662461102;
        bh=BsC/oYZMlsU0AfsdsrR9QSz2oK4VIzDllo5FeG24Gr4=;
        h=From:To:Cc:Subject:Date:From;
        b=YSpBUFbsYKtRJgJCOHldFTmoGOA3QaSUl28vxA1uT3F7eTXuuVoBYAh/jWVuImJux
         F5Ko9VPNesLXMs7UAowUvglpjWyJZ/Z7a4OOMsxd7Oxp5zU0Fu7c9FYiN8IEVgmGFG
         m5rvbmP69kqcwAuCOZmQt0XaIz18IwVmqR22swsk=
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
Subject: [PATCH] media: imx7-media-csi: Add support for fast-tracking queued buffers
Date:   Tue,  6 Sep 2022 19:44:37 +0900
Message-Id: <20220906104437.4095745-1-paul.elder@ideasonboard.com>
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
race is resolved by locking the programming of FB1. If it came after the
interrupt for FB0, then the variable that is used to determine which FB
to program would have been swapped by the interrupt handler, thus
resolving the race.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
 drivers/staging/media/imx/imx7-media-csi.c | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index a0553c24cce4..06e50080ed31 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1296,11 +1296,60 @@ static int imx7_csi_video_buf_prepare(struct vb2_buffer *vb)
 	return 0;
 }
 
+static int imx7_csi_fast_track_buffer(struct imx7_csi *csi,
+				      struct imx7_csi_vb2_buffer *buf)
+{
+	unsigned long flags;
+	dma_addr_t phys;
+	int buf_num;
+	int ret = -EBUSY;
+
+	if (!csi->is_streaming)
+		return ret;
+
+	phys = vb2_dma_contig_plane_dma_addr(&buf->vbuf.vb2_buf, 0);
+
+	/*
+	 * buf_num holds the fb id of the most recently (*not* the next
+	 * anticipated) triggered interrupt. Without loss of generality, if
+	 * buf_num is 0 and we get to this section before the irq for fb1, the
+	 * buffer that we are fast-tracking into fb0 should be programmed in
+	 * time to be captured into. If the irq for fb1 already happened, then
+	 * buf_num would be 1, and we would fast-track the buffer into fb1
+	 * instead. This guarantees that we won't try to fast-track into fb0
+	 * and race against the start-of-capture into fb0.
+	 *
+	 * We only fast-track the buffer if the currently programmed buffer is
+	 * a dummy buffer. We can check the active_vb2_buf instead as it is
+	 * always modified along with programming the fb[0,1] registers via the
+	 * lock (besides setup and cleanup). If it is not a dummy buffer then
+	 * we queue it normally, as fast-tracking is not an option.
+	 */
+
+	spin_lock_irqsave(&csi->irqlock, flags);
+
+	buf_num = csi->buf_num;
+	if (csi->active_vb2_buf[buf_num] == NULL) {
+		csi->active_vb2_buf[buf_num] = buf;
+		imx7_csi_update_buf(csi, phys, buf_num);
+		ret = 0;
+	}
+
+	spin_unlock_irqrestore(&csi->irqlock, flags);
+
+	return ret;
+}
+
 static void imx7_csi_video_buf_queue(struct vb2_buffer *vb)
 {
 	struct imx7_csi *csi = vb2_get_drv_priv(vb->vb2_queue);
 	struct imx7_csi_vb2_buffer *buf = to_imx7_csi_vb2_buffer(vb);
 	unsigned long flags;
+	int ret;
+
+	ret = imx7_csi_fast_track_buffer(csi, buf);
+	if (!ret)
+		return;
 
 	spin_lock_irqsave(&csi->q_lock, flags);
 
-- 
2.30.2

