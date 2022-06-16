Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6527454ED05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiFPWEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFPWEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:04:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A695F257
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655417078; x=1686953078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtS68tJQspJzkn5mxiwBgJrb7I6MfCT13tBpLas9pUs=;
  b=HE+VcZMFtmSLzh0oNGlasdj2HVD6QNUFr0XjOL3Ap2HDcK40pticYbeN
   wsHMRVFbRB1q47PRxg+EKnE/lAxyYoaGfb/v3B0mhayzxSiLt834xDJN6
   m9C+5TzvuspDM0agdutzVTh0SJSb262tPJqbQDLeO19FhIWDPxlCzShT1
   zvc2BY9nQs6EqtnDTqXgrmQejoAYhTyp/Hx/L7YJNWFYTJkfEYv6OyCsi
   R7iAjQiXnEDi8MkN+Q/13GI6OxnrqTlQOgYPY50j60UBJsZ30iBhKs92v
   gqXGOhSFgfdzKDsYLXulfF5tX/Dq3vVMR22wOvgV0aaDZATcDDlh8K2DW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276936388"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="276936388"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728084954"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.52.70])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:37 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lianjie Zhang <zhanglianjie@uniontech.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/11] ASoC: Intel: catpt: use pm_runtime_resume_and_get()
Date:   Thu, 16 Jun 2022 17:04:17 -0500
Message-Id: <20220616220427.136036-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code does not check for errors and does not release the
reference on errors.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/intel/catpt/pcm.c   | 26 ++++++++++++++++++++------
 sound/soc/intel/catpt/sysfs.c |  4 +++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index a26000cd5cebc..30ca5416c9a3f 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -667,7 +667,9 @@ static int catpt_dai_pcm_new(struct snd_soc_pcm_runtime *rtm,
 	if (!memcmp(&cdev->devfmt[devfmt.iface], &devfmt, sizeof(devfmt)))
 		return 0;
 
-	pm_runtime_get_sync(cdev->dev);
+	ret = pm_runtime_resume_and_get(cdev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
 
 	ret = catpt_ipc_set_device_format(cdev, &devfmt);
 
@@ -853,9 +855,12 @@ static int catpt_mixer_volume_get(struct snd_kcontrol *kcontrol,
 		snd_soc_kcontrol_component(kcontrol);
 	struct catpt_dev *cdev = dev_get_drvdata(component->dev);
 	u32 dspvol;
+	int ret;
 	int i;
 
-	pm_runtime_get_sync(cdev->dev);
+	ret = pm_runtime_resume_and_get(cdev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
 
 	for (i = 0; i < CATPT_CHANNELS_MAX; i++) {
 		dspvol = catpt_mixer_volume(cdev, &cdev->mixer, i);
@@ -876,7 +881,9 @@ static int catpt_mixer_volume_put(struct snd_kcontrol *kcontrol,
 	struct catpt_dev *cdev = dev_get_drvdata(component->dev);
 	int ret;
 
-	pm_runtime_get_sync(cdev->dev);
+	ret = pm_runtime_resume_and_get(cdev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
 
 	ret = catpt_set_dspvol(cdev, cdev->mixer.mixer_hw_id,
 			       ucontrol->value.integer.value);
@@ -897,6 +904,7 @@ static int catpt_stream_volume_get(struct snd_kcontrol *kcontrol,
 	struct catpt_dev *cdev = dev_get_drvdata(component->dev);
 	long *ctlvol = (long *)kcontrol->private_value;
 	u32 dspvol;
+	int ret;
 	int i;
 
 	stream = catpt_stream_find(cdev, pin_id);
@@ -906,7 +914,9 @@ static int catpt_stream_volume_get(struct snd_kcontrol *kcontrol,
 		return 0;
 	}
 
-	pm_runtime_get_sync(cdev->dev);
+	ret = pm_runtime_resume_and_get(cdev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
 
 	for (i = 0; i < CATPT_CHANNELS_MAX; i++) {
 		dspvol = catpt_stream_volume(cdev, stream, i);
@@ -937,7 +947,9 @@ static int catpt_stream_volume_put(struct snd_kcontrol *kcontrol,
 		return 0;
 	}
 
-	pm_runtime_get_sync(cdev->dev);
+	ret = pm_runtime_resume_and_get(cdev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
 
 	ret = catpt_set_dspvol(cdev, stream->info.stream_hw_id,
 			       ucontrol->value.integer.value);
@@ -1013,7 +1025,9 @@ static int catpt_loopback_switch_put(struct snd_kcontrol *kcontrol,
 		return 0;
 	}
 
-	pm_runtime_get_sync(cdev->dev);
+	ret = pm_runtime_resume_and_get(cdev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
 
 	ret = catpt_ipc_mute_loopback(cdev, stream->info.stream_hw_id, mute);
 
diff --git a/sound/soc/intel/catpt/sysfs.c b/sound/soc/intel/catpt/sysfs.c
index 9579e233a15db..1bdbcc04dc712 100644
--- a/sound/soc/intel/catpt/sysfs.c
+++ b/sound/soc/intel/catpt/sysfs.c
@@ -15,7 +15,9 @@ static ssize_t fw_version_show(struct device *dev,
 	struct catpt_fw_version version;
 	int ret;
 
-	pm_runtime_get_sync(cdev->dev);
+	ret = pm_runtime_resume_and_get(cdev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
 
 	ret = catpt_ipc_get_fw_version(cdev, &version);
 
-- 
2.34.1

