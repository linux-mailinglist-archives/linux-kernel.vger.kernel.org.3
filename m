Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6419C54D6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351657AbiFPBSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350505AbiFPBSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:18:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6331F2F8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655342295; x=1686878295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WlF6IGDNKcYwGntMGB2JVx7A5/2QpCifsZSxNNBMeqc=;
  b=CPYt97bgjScKx8wU6+WrGaZvLsphYxr7VWamY00PvPYtUQMYCs/S5x6x
   gOQLvBvT8MN5DFkIAXemlk66BuXzhA3Zlkk6W8CDN9Lfhr9PsAPcZv49K
   vvD7dVE0G+y2pbdvvNI2qIOvEAqMnMxZSYQUCYXb1/SXVHIsJQHwykFji
   K6xfwPS1s3HPqg1pKSTn7N9a/c4G/gEMAIWQyK4a1Tkmuw703Unidi20e
   yGsfOrXCSnli5TmZGliSA3cBewoGUkr3CiV4oxL02D/CwavpMDsCHEPO2
   w9M0lB+46hAcn1wLnoeaach6rDOGPD40p9BHA1L+uU9+NohNOi9gNsFNO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279195965"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279195965"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 18:18:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="911939339"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 18:18:12 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Subject: [PATCH v2 2/2] ASoC: SOF: Intel: add trigger callback into sdw_callback
Date:   Thu, 16 Jun 2022 09:17:58 +0800
Message-Id: <20220616011758.21155-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220616011758.21155-1-yung-chuan.liao@linux.intel.com>
References: <20220616011758.21155-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IPC4, we need to set pipeline state in BE DAI trigger.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 14 +++++++++++---
 sound/soc/sof/intel/hda.c     |  2 +-
 sound/soc/sof/intel/hda.h     |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 70721defca46..97632ca4b7a7 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -714,8 +714,7 @@ static const struct snd_soc_dai_ops ipc3_ssp_dai_ops = {
 	.shutdown = ssp_dai_shutdown,
 };
 
-static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
-			       int cmd, struct snd_soc_dai *dai)
+static int ipc4_be_dai_common_trigger(struct snd_soc_dai *dai, int cmd, int stream)
 {
 	struct snd_sof_widget *pipe_widget;
 	struct sof_ipc4_pipeline *pipeline;
@@ -724,7 +723,7 @@ static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
 	struct snd_sof_dev *sdev;
 	int ret;
 
-	w = snd_soc_dai_get_widget(dai, substream->stream);
+	w = snd_soc_dai_get_widget(dai, stream);
 	swidget = w->dobj.private;
 	pipe_widget = swidget->pipe_widget;
 	pipeline = pipe_widget->private;
@@ -759,6 +758,12 @@ static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
+			       int cmd, struct snd_soc_dai *dai)
+{
+	return ipc4_be_dai_common_trigger(dai, cmd, substream->stream);
+}
+
 static const struct snd_soc_dai_ops ipc4_dmic_dai_ops = {
 	.trigger = ipc4_be_dai_trigger,
 };
@@ -810,6 +815,9 @@ void hda_set_dai_drv_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *ops)
 		if (!hda_use_tplg_nhlt)
 			ipc4_data->nhlt = intel_nhlt_init(sdev->dev);
 
+		if (IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE))
+			sdw_callback.trigger = ipc4_be_dai_common_trigger;
+
 		break;
 	}
 	default:
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index bc07df1fc39f..cdd3601e84f5 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -147,7 +147,7 @@ static int sdw_free_stream(struct device *dev,
 	return hda_ctrl_dai_widget_free(w, SOF_DAI_CONFIG_FLAGS_NONE, &data);
 }
 
-static const struct sdw_intel_ops sdw_callback = {
+struct sdw_intel_ops sdw_callback = {
 	.params_stream = sdw_params_stream,
 	.free_stream = sdw_free_stream,
 };
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index a3118499e34f..99545ab492d7 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -775,5 +775,6 @@ irqreturn_t cnl_ipc4_irq_thread(int irq, void *context);
 int cnl_ipc4_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg);
 irqreturn_t hda_dsp_ipc4_irq_thread(int irq, void *context);
 int hda_dsp_ipc4_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg);
+extern struct sdw_intel_ops sdw_callback;
 
 #endif
-- 
2.17.1

