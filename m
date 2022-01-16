Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106F048FC46
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 12:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiAPLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 06:18:29 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:64347 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiAPLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 06:18:28 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 93YEngVhBZQwW93YFnBe69; Sun, 16 Jan 2022 12:18:25 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 16 Jan 2022 12:18:25 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: soc-pcm: use GFP_ATOMIC in dpcm_create_debugfs_state()
Date:   Sun, 16 Jan 2022 12:18:17 +0100
Message-Id: <ed322b8821fa787907c1a4cce879564d1281b69d.1642331884.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit below states that dpcm_be_connect() may be called from atomic
context. It changes a GFP_KERNEL into a GFP_ATOMIC to deal with it.

Another memory allocation is done in dpcm_create_debugfs_state() which is
called by dpcm_be_connect(). Also use GFP_ATOMIC there to be consistent
and be compliant with atomic context.

Fixes: d8a9c6e1f676 ("ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not clear to me how dpcm_be_connect() can be called from an atomic context,
though. But better safe than sorry.
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7abfc48b26ca..1a536a2b9dc3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -212,7 +212,7 @@ static void dpcm_create_debugfs_state(struct snd_soc_dpcm *dpcm, int stream)
 {
 	char *name;
 
-	name = kasprintf(GFP_KERNEL, "%s:%s", dpcm->be->dai_link->name,
+	name = kasprintf(GFP_ATOMIC, "%s:%s", dpcm->be->dai_link->name,
 			 stream ? "capture" : "playback");
 	if (name) {
 		dpcm->debugfs_state = debugfs_create_dir(
-- 
2.32.0

