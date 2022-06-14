Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18C54AA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352954AbiFNHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353257AbiFNHIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:08:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A232073
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655190514; x=1686726514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=89fJyn3HdQE4qrmLLsHd0B83txiGpBAciNGBYfvWWjY=;
  b=VWavr5eQB2nc9fyoZV9CLEbY8dgwIbonwy1j+u7Qgdem7IEIV3H72Rw8
   AQEiYzWZUpJps6dIVfnqd4R+J1Psv9++c5r79rCrULSD5+5A1kV5Cmxq3
   bTObfy/XpR7458sgR4XyQtZ5/QBB3GmWvhFyO0zuUYyJA35YIaXx7lOOj
   b5s80rI+f7GSgXpfZjT5WCRCOALRS/d16ovo60T9lcGzddEmMR1gOiwuI
   FdyDkIDOWsbLzDTmSp5ryioaoLw2kzGjXMrh7NCfHHCaPA/N/0PDy/yCs
   LHjvdbQ0N0atEIoN1+8ojhfUwWKpOv3N6lSn8a5Bbr0BxmIJ6mOCh/dBr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258363560"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258363560"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:08:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640185952"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:08:32 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/2] ASoC: SOF: Intel: add trigger callback into sdw_callback
Date:   Tue, 14 Jun 2022 15:08:17 +0800
Message-Id: <20220614070817.2508-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
References: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
 sound/soc/sof/intel/hda-dai.c | 15 ++++++++++++---
 sound/soc/sof/intel/hda.c     |  2 +-
 sound/soc/sof/intel/hda.h     |  1 +
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 228079a52c3d..6ed99fdc5793 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -713,8 +713,7 @@ static const struct snd_soc_dai_ops ipc3_ssp_dai_ops = {
 	.shutdown = ssp_dai_shutdown,
 };
 
-static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
-			       int cmd, struct snd_soc_dai *dai)
+static int ipc4_be_dai_common_trigger(struct snd_soc_dai *dai, int cmd, int stream)
 {
 	struct snd_sof_widget *pipe_widget;
 	struct sof_ipc4_pipeline *pipeline;
@@ -723,7 +722,7 @@ static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
 	struct snd_sof_dev *sdev;
 	int ret;
 
-	w = snd_soc_dai_get_widget(dai, substream->stream);
+	w = snd_soc_dai_get_widget(dai, stream);
 	swidget = w->dobj.private;
 	pipe_widget = swidget->pipe_widget;
 	pipeline = pipe_widget->private;
@@ -758,6 +757,12 @@ static int ipc4_be_dai_trigger(struct snd_pcm_substream *substream,
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
@@ -809,6 +814,10 @@ void hda_set_dai_drv_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *ops)
 		if (!hda_use_tplg_nhlt)
 			ipc4_data->nhlt = intel_nhlt_init(sdev->dev);
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
+		sdw_callback.trigger = ipc4_be_dai_common_trigger;
+#endif
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
index f4e4cd7d7406..ec7a2d947eb6 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -771,5 +771,6 @@ irqreturn_t cnl_ipc4_irq_thread(int irq, void *context);
 int cnl_ipc4_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg);
 irqreturn_t hda_dsp_ipc4_irq_thread(int irq, void *context);
 int hda_dsp_ipc4_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg);
+extern struct sdw_intel_ops sdw_callback;
 
 #endif
-- 
2.17.1

