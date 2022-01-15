Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D27E48F415
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiAOBXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:23:25 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:25388 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231962AbiAOBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:23:24 -0500
X-IronPort-AV: E=Sophos;i="5.88,290,1635174000"; 
   d="scan'208";a="107116846"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2022 10:23:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9B5B5417EAC4;
        Sat, 15 Jan 2022 10:23:21 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] ASoC: sh: rz-ssi: Drop ssi parameter from rz_ssi_stream_init()
Date:   Sat, 15 Jan 2022 01:23:01 +0000
Message-Id: <20220115012303.29651-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ssi parameter is unused in rz_ssi_stream_init() so just drop it.

While at it, change the return type of rz_ssi_stream_init() to void
instead of int.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2
* No change
---
 sound/soc/sh/rz-ssi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 89428945d48b..50699e94772b 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -201,9 +201,8 @@ static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
 	return ret;
 }
 
-static int rz_ssi_stream_init(struct rz_ssi_priv *ssi,
-			      struct rz_ssi_stream *strm,
-			      struct snd_pcm_substream *substream)
+static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
+			       struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -219,8 +218,6 @@ static int rz_ssi_stream_init(struct rz_ssi_priv *ssi,
 
 	/* fifo init */
 	strm->fifo_sample_size = SSI_FIFO_DEPTH;
-
-	return 0;
 }
 
 static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
@@ -723,9 +720,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
 		udelay(5);
 
-		ret = rz_ssi_stream_init(ssi, strm, substream);
-		if (ret)
-			goto done;
+		rz_ssi_stream_init(strm, substream);
 
 		if (ssi->dma_rt) {
 			bool is_playback;
-- 
2.17.1

