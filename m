Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5648F411
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiAOBXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:23:18 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:50400 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231298AbiAOBXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:23:18 -0500
X-IronPort-AV: E=Sophos;i="5.88,290,1635174000"; 
   d="scan'208";a="106547798"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jan 2022 10:23:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D0001417EAE4;
        Sat, 15 Jan 2022 10:23:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv() recursively
Date:   Sat, 15 Jan 2022 01:22:59 +0000
Message-Id: <20220115012303.29651-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of recursively calling rz_ssi_pio_recv() use a loop instead
to read the samples from RX fifo.

Inspiration for this patch is to avoid recursion, as recursion is
unwelcome in kernel due to limited stack use. Also to add this driver
will later be used on RZ/A2 SoC's which runs with limited memory.

This also fixes an issue where the return value of rz_ssi_pio_recv()
was ignored when called recursively.

Fixes: 03e786bd4341 ("ASoC: sh: Add RZ/G2L SSIF-2 driver")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2
* Used a do while loop
* Fixed comments pointed by Cezary.
---
 sound/soc/sh/rz-ssi.c | 65 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index fa0cc08f70ec..637802117c6c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -414,51 +414,48 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	u16 *buf;
 	int fifo_samples;
 	int frames_left;
-	int samples = 0;
+	int samples;
 	int i;
 
 	if (!rz_ssi_stream_is_valid(ssi, strm))
 		return -EINVAL;
 
 	runtime = substream->runtime;
-	/* frames left in this period */
-	frames_left = runtime->period_size - (strm->buffer_pos %
-					      runtime->period_size);
-	if (frames_left == 0)
-		frames_left = runtime->period_size;
 
-	/* Samples in RX FIFO */
-	fifo_samples = (rz_ssi_reg_readl(ssi, SSIFSR) >>
-			SSIFSR_RDC_SHIFT) & SSIFSR_RDC_MASK;
-
-	/* Only read full frames at a time */
-	while (frames_left && (fifo_samples >= runtime->channels)) {
-		samples += runtime->channels;
-		fifo_samples -= runtime->channels;
-		frames_left--;
-	}
-
-	/* not enough samples yet */
-	if (samples == 0)
-		return 0;
+	do {
+		/* frames left in this period */
+		frames_left = runtime->period_size -
+			      (strm->buffer_pos % runtime->period_size);
+		if (!frames_left)
+			frames_left = runtime->period_size;
+
+		/* Samples in RX FIFO */
+		fifo_samples = (rz_ssi_reg_readl(ssi, SSIFSR) >>
+				SSIFSR_RDC_SHIFT) & SSIFSR_RDC_MASK;
+
+		/* Only read full frames at a time */
+		samples = 0;
+		while (frames_left && (fifo_samples >= runtime->channels)) {
+			samples += runtime->channels;
+			fifo_samples -= runtime->channels;
+			frames_left--;
+		}
 
-	/* calculate new buffer index */
-	buf = (u16 *)(runtime->dma_area);
-	buf += strm->buffer_pos * runtime->channels;
+		/* not enough samples yet */
+		if (!samples)
+			break;
 
-	/* Note, only supports 16-bit samples */
-	for (i = 0; i < samples; i++)
-		*buf++ = (u16)(rz_ssi_reg_readl(ssi, SSIFRDR) >> 16);
+		/* calculate new buffer index */
+		buf = (u16 *)runtime->dma_area;
+		buf += strm->buffer_pos * runtime->channels;
 
-	rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
-	rz_ssi_pointer_update(strm, samples / runtime->channels);
+		/* Note, only supports 16-bit samples */
+		for (i = 0; i < samples; i++)
+			*buf++ = (u16)(rz_ssi_reg_readl(ssi, SSIFRDR) >> 16);
 
-	/*
-	 * If we finished this period, but there are more samples in
-	 * the RX FIFO, call this function again
-	 */
-	if (frames_left == 0 && fifo_samples >= runtime->channels)
-		rz_ssi_pio_recv(ssi, strm);
+		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
+		rz_ssi_pointer_update(strm, samples / runtime->channels);
+	} while (!frames_left && fifo_samples >= runtime->channels);
 
 	return 0;
 }
-- 
2.17.1

