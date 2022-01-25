Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6A49B51D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382831AbiAYN3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:29:55 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:15749 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1386682AbiAYNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:25:19 -0500
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="107606150"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Jan 2022 22:25:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D6F29429594A;
        Tue, 25 Jan 2022 22:25:14 +0900 (JST)
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
Subject: [PATCH 2/3] ASoC: sh: rz-ssi: Add rz_ssi_set_substream() helper function
Date:   Tue, 25 Jan 2022 13:24:56 +0000
Message-Id: <20220125132457.14984-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A copy of substream pointer is stored in priv structure during
rz_ssi_dai_trigger() callback ie in SNDRV_PCM_TRIGGER_START case
and the pointer is assigned to NULL in case of SNDRV_PCM_TRIGGER_STOP.

The driver used the locks only in rz_ssi_stream_is_valid() and assigned
the local substream pointer to NULL in rz_ssi_dai_trigger() callback but
never locked it while making a local copy.

This patch adds the rz_ssi_set_substream() helper function to set the
substream pointer with locks acquired and replaces the instances of
setting the local substream pointer with the rz_ssi_set_substream()
function.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 2c8775d37f50..1a46c9f3c4e5 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -188,6 +188,17 @@ static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
 	return (ssi->playback.dma_ch && (ssi->dma_rt || ssi->capture.dma_ch));
 }
 
+static void rz_ssi_set_substream(struct rz_ssi_stream *strm,
+				 struct snd_pcm_substream *substream)
+{
+	struct rz_ssi_priv *ssi = strm->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ssi->lock, flags);
+	strm->substream = substream;
+	spin_unlock_irqrestore(&ssi->lock, flags);
+}
+
 static bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
 				   struct rz_ssi_stream *strm)
 {
@@ -206,7 +217,7 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	strm->substream = substream;
+	rz_ssi_set_substream(strm, substream);
 	strm->sample_width = samples_to_bytes(runtime, 1);
 	strm->dma_buffer_pos = 0;
 	strm->period_counter = 0;
@@ -224,11 +235,8 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 			       struct rz_ssi_stream *strm)
 {
 	struct snd_soc_dai *dai = rz_ssi_get_dai(strm->substream);
-	unsigned long flags;
 
-	spin_lock_irqsave(&ssi->lock, flags);
-	strm->substream = NULL;
-	spin_unlock_irqrestore(&ssi->lock, flags);
+	rz_ssi_set_substream(strm, NULL);
 
 	if (strm->oerr_num > 0)
 		dev_info(dai->dev, "overrun = %d\n", strm->oerr_num);
-- 
2.17.1

