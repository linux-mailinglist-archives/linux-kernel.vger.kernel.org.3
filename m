Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E936D48F417
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiAOBX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:23:29 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:25388 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231987AbiAOBX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:23:28 -0500
X-IronPort-AV: E=Sophos;i="5.88,290,1635174000"; 
   d="scan'208";a="107116851"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2022 10:23:27 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 052E1417EAC6;
        Sat, 15 Jan 2022 10:23:24 +0900 (JST)
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
Subject: [PATCH v2 4/5] ASoC: sh: rz-ssi: Change return type of rz_ssi_stream_is_valid() to bool
Date:   Sat, 15 Jan 2022 01:23:02 +0000
Message-Id: <20220115012303.29651-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2
* No change
---
 sound/soc/sh/rz-ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 50699e94772b..2da43eecfb3e 100644
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

