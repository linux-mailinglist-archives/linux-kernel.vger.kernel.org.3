Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBEF562E11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiGAIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiGAIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:24:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A486672ED7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656663777; x=1688199777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KQT2Js8BSZVnKoLQyDVtKNHzugCIZ6dztQGR4wapsqs=;
  b=lps2hkyiEnnzHSZBLhmiKbMt368Nt+nnT7ovn4zK/2Bhm5GyzAzfAyka
   OOkVgZz2p90TuUr3ycF3qQixrKRzHxwDTOcsTTVHoPWSzpYS9WExn6G7T
   JvoArwjS9LIgu0QJk42MVrWwBgXb/yhvSpgLuguiyPC8EeLihEvB45V2a
   oPaDBZyngMNfFo9SomIBRxsP1CN7XpGXWMaC7CyoSTVUEHSba64FnRI+N
   9q9LEzWKXQa53OUJP4txrH09toMk2zvmpArlPHU/C3f8c35fgwA8YF2JI
   3IdraUYeOhcbSFKE6sr8A411sbpXR6N1d2pFkgyg08qBdMlRHnFfMxbfj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262989091"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262989091"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:22:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="694423047"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2022 01:22:54 -0700
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
        Mac Chiang <mac.chiang@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: sof_rt5682: fix out-of-bounds array access
Date:   Fri,  1 Jul 2022 16:19:08 +0800
Message-Id: <20220701081908.248239-1-brent.lu@intel.com>
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
new member hdmi_jack to the snd_soc_jack structure to fix the
out-of-bounds problem.

Signed-off-by: Brent Lu <brent.lu@intel.com>
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

