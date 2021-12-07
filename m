Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A27546C272
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhLGSN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:13:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:52996 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240464AbhLGSNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:13:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224513465"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="224513465"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:38:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="751385248"
Received: from charriso-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.98.250])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:38:13 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 4/6] ASoC: soc-pcm: serialize BE triggers
Date:   Tue,  7 Dec 2021 11:37:43 -0600
Message-Id: <20211207173745.15850-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
References: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

When more than one FE is connected to a BE, e.g. in a mixing use case,
the BE can be triggered multiple times when the FE are opened/started
concurrently. This race condition is problematic in the case of
SoundWire BE dailinks, and this is not desirable in a general
case.

This patch relies on the existing BE PCM lock, which takes atomicity into
account. The locking model assumes that all interactions start with
the FE, so that there is no deadlock between FE and BE locks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[test, checkpatch fix and clarification of commit message by plbossart]
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-pcm.c | 46 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2e282c42bac2..7043857e30b1 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -46,12 +46,18 @@ static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runtime *rtd,
 	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
 }
 
+#define snd_soc_dpcm_stream_lock_irqsave(rtd, stream, flags) \
+	snd_pcm_stream_lock_irqsave(snd_soc_dpcm_get_substream(rtd, stream), flags)
+
 static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
 						  int stream)
 {
 	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream));
 }
 
+#define snd_soc_dpcm_stream_unlock_irqrestore(rtd, stream, flags) \
+	snd_pcm_stream_unlock_irqrestore(snd_soc_dpcm_get_substream(rtd, stream), flags)
+
 #define DPCM_MAX_BE_USERS	8
 
 static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
@@ -2079,6 +2085,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 {
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dpcm *dpcm;
+	unsigned long flags;
 	int ret = 0;
 
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -2087,9 +2094,11 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		be = dpcm->be;
 		be_substream = snd_soc_dpcm_get_substream(be, stream);
 
+		snd_soc_dpcm_stream_lock_irqsave(be, stream, flags);
+
 		/* is this op for this BE ? */
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
-			continue;
+			goto next;
 
 		dev_dbg(be->dev, "ASoC: trigger BE %s cmd %d\n",
 			be->dai_link->name, cmd);
@@ -2099,77 +2108,80 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_RESUME:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
 		case SNDRV_PCM_TRIGGER_SUSPEND:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
 		}
+next:
+		snd_soc_dpcm_stream_unlock_irqrestore(be, stream, flags);
+		if (ret)
+			break;
 	}
-end:
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed at %s (%d)\n",
 			__func__, be->dai_link->name, ret);
-- 
2.25.1

