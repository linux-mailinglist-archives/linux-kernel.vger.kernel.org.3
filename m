Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6C49B51C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiAYN3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:29:46 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:40774 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1386661AbiAYNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:25:15 -0500
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="107606147"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Jan 2022 22:25:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 486034295951;
        Tue, 25 Jan 2022 22:25:12 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/3] ASoC: sh: rz-ssi: Use a do-while loop in rz_ssi_pio_recv()
Date:   Tue, 25 Jan 2022 13:24:55 +0000
Message-Id: <20220125132457.14984-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a do-while loop while reading the samples from RX FIFO. The "done"
flag was only changed as an outcome of the last if-statement (last step)
in this entire procedure. This patch moves the condition from if
statement to while and drops the "done" variable for readability.

While at it, also drop the unneeded parentheses around runtime->dma_area.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This change was part of patch [0], as v1 series was applied I am just
sending the cosmetic changes from v2 for readability.

[0] https://patchwork.kernel.org/project/alsa-devel/patch/
20220115012303.29651-6-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 sound/soc/sh/rz-ssi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 81e1786b827d..2c8775d37f50 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -408,7 +408,6 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
 	struct snd_pcm_substream *substream = strm->substream;
 	struct snd_pcm_runtime *runtime;
-	bool done = false;
 	u16 *buf;
 	int fifo_samples;
 	int frames_left;
@@ -420,7 +419,7 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 
 	runtime = substream->runtime;
 
-	while (!done) {
+	do {
 		/* frames left in this period */
 		frames_left = runtime->period_size -
 			      (strm->buffer_pos % runtime->period_size);
@@ -444,7 +443,7 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 			break;
 
 		/* calculate new buffer index */
-		buf = (u16 *)(runtime->dma_area);
+		buf = (u16 *)runtime->dma_area;
 		buf += strm->buffer_pos * runtime->channels;
 
 		/* Note, only supports 16-bit samples */
@@ -453,11 +452,7 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 
 		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
 		rz_ssi_pointer_update(strm, samples / runtime->channels);
-
-		/* check if there are no more samples in the RX FIFO */
-		if (!(!frames_left && fifo_samples >= runtime->channels))
-			done = true;
-	}
+	} while (!frames_left && fifo_samples >= runtime->channels);
 
 	return 0;
 }
-- 
2.17.1

