Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32BC47EA7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350960AbhLXCLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:11:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:54155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245561AbhLXCLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640311876; x=1671847876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=alLTBXDy3O+6GzU4DwFSKQ3fIJ/zBnApQ/F3BpD6psQ=;
  b=m1z4uok5WIeohSinu30jvBwAhrsxjupyhBdc1vSOyH2dx4hWkR5aZPai
   bScvfmNuFVli3itlCOSmiJx3djyND5ISVbthKRDnhAq3QsBYi8K7hH3V0
   +aWiHEJcBIb3nr2E88O3oH6XFRUVCt/2fmHeh+kdHiIe6I5HG3qm4MGc3
   RGX7eq6SPDp8bmN6TEZiBsMaM/GUG9QstywPJ8sxemEs7te1iYlk02CQm
   PcUQcpkFevmPIkqr7jPzXle2ljpyxBiVxUlibT5JatBaIaS3KSUXt9mq+
   UqU7fre/13fTwySba9U+o5gxYB+V4nCD8N8dFfVEi3rPQo9uZNucHuD1j
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="240715087"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="240715087"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:11:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="467156195"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 18:10:48 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/7] ASOC: SOF: Intel: use snd_soc_dai_get_widget()
Date:   Fri, 24 Dec 2021 10:10:28 +0800
Message-Id: <20211224021034.26635-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
References: <20211224021034.26635-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We have a helper, use it to simplify widget lookup

Suggested-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 18abbd13d593..99255028d3fe 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -189,10 +189,7 @@ static int sdw_params_stream(struct device *dev,
 	struct snd_soc_dai *d = params_data->dai;
 	struct snd_soc_dapm_widget *w;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		w = d->playback_widget;
-	else
-		w = d->capture_widget;
+	w = snd_soc_dai_get_widget(d, substream->stream);
 
 	return sdw_dai_config_ipc(sdev, w, params_data->link_id, params_data->alh_stream_id,
 				  d->id, true);
@@ -206,10 +203,7 @@ static int sdw_free_stream(struct device *dev,
 	struct snd_soc_dai *d = free_data->dai;
 	struct snd_soc_dapm_widget *w;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		w = d->playback_widget;
-	else
-		w = d->capture_widget;
+	w = snd_soc_dai_get_widget(d, substream->stream);
 
 	/* send invalid stream_id */
 	return sdw_dai_config_ipc(sdev, w, free_data->link_id, 0xFFFF, d->id, false);
-- 
2.17.1

