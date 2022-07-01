Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78985634FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiGAOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiGAOSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:18:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBD20F66
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656685116; x=1688221116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3wzRj5NJlP7HHnjC6iFDXafrek+CylxTqxEu0SV+jSg=;
  b=ndXczQIDv0NZZc0FYSEp32hpp2ZlvZT2BB+gastW3hDrait9REH0Dwsb
   +InTBM8GASbuSd9US7GT2JeZTVfAYZpu4dNd9yvKLypbAOQN4fFef6a/Q
   B9R2TEAbdGoJGEZJHDYA0zPk/Zwy4ZmKvnrHQdmapIfIvKETndzzGt/J/
   a+ZLH4dbKsjV+8ysRcLrJ0zRSrCs7cfpli8nROOLM1RFqBtqYW4sBsDPb
   UoslKGdZUwn8CwmsCFIoGbBvzZkindagMYOgmCDW7wvP1pncyggK2hgPE
   be6y54V50u5EwYiAmx/urD9QJhlkncR9U/I4T/w+CvXKoEBKOgpmyncuS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="368981607"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="368981607"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 07:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="838058898"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2022 07:18:33 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Mac Chiang <mac.chiang@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: Intel: sof_rt5682: fix out-of-bounds array access
Date:   Fri,  1 Jul 2022 22:15:17 +0800
Message-Id: <20220701141517.264070-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from ADL platform we have four HDMI PCM devices which exceeds
the size of sof_hdmi array. Since each sof_hdmi_pcm structure
represents one HDMI PCM device, we remove the sof_hdmi array and add a
new member hdmi_jack to the sof_hdmi_pcm structure to fix the
out-of-bounds problem.

Signed-off-by: Brent Lu <brent.lu@intel.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index a24fb71d5ff3..1384716c6360 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -69,11 +69,10 @@ static unsigned long sof_rt5682_quirk = SOF_RT5682_MCLK_EN |
 
 static int is_legacy_cpu;
 
-static struct snd_soc_jack sof_hdmi[3];
-
 struct sof_hdmi_pcm {
 	struct list_head head;
 	struct snd_soc_dai *codec_dai;
+	struct snd_soc_jack hdmi_jack;
 	int device;
 };
 
@@ -447,7 +446,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 	char jack_name[NAME_SIZE];
 	struct sof_hdmi_pcm *pcm;
 	int err;
-	int i = 0;
 
 	/* HDMI is not supported by SOF on Baytrail/CherryTrail */
 	if (is_legacy_cpu || !ctx->idisp_codec)
@@ -468,17 +466,15 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 		snprintf(jack_name, sizeof(jack_name),
 			 "HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_AVOUT, &sof_hdmi[i]);
+					    SND_JACK_AVOUT, &pcm->hdmi_jack);
 
 		if (err)
 			return err;
 
 		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
-					  &sof_hdmi[i]);
+					  &pcm->hdmi_jack);
 		if (err < 0)
 			return err;
-
-		i++;
 	}
 
 	if (sof_rt5682_quirk & SOF_MAX98373_SPEAKER_AMP_PRESENT) {
-- 
2.25.1

