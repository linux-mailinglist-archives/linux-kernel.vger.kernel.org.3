Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8D648959A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbiAJJsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:48:38 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:30206 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243273AbiAJJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:48:01 -0500
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; 
   d="scan'208";a="106003032"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 18:48:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 160774238CA4;
        Mon, 10 Jan 2022 18:47:57 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ASoC: sh: rz-ssi: Make return type of rz_ssi_stream_is_valid() to bool
Date:   Mon, 10 Jan 2022 09:47:10 +0000
Message-Id: <20220110094711.8574-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rz_ssi_stream_is_valid() never returns an int, it returns the result of
a condition which is either true or false.

While at it, drop "!!" as the expression is boolean.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index fa68d3a0bd62..aabd15e9d515 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -188,14 +188,14 @@ static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
 	return (ssi->playback.dma_ch && (ssi->dma_rt || ssi->capture.dma_ch));
 }
 
-static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
-				  struct rz_ssi_stream *strm)
+static bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
+				   struct rz_ssi_stream *strm)
 {
 	unsigned long flags;
-	int ret;
+	bool ret;
 
 	spin_lock_irqsave(&ssi->lock, flags);
-	ret = !!(strm->substream && strm->substream->runtime);
+	ret = strm->substream && strm->substream->runtime;
 	spin_unlock_irqrestore(&ssi->lock, flags);
 
 	return ret;
-- 
2.17.1

