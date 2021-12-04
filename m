Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C42468593
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385254AbhLDOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbhLDOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:11 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B600C0613F8;
        Sat,  4 Dec 2021 06:37:45 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k2so11977205lji.4;
        Sat, 04 Dec 2021 06:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyTBAmupt7gDEygKBlHM3btaCL0Q7p9LZZKGom+gcjE=;
        b=lKpMV9rv2g3EC6HIcv5fYnov50gxSxh9imCWDiny5m3gD788KV9hmRAT7m0jzezDaV
         zGAJtT1bqJ76/4qNyF8crgnEtSCKQ6/ytPHtWzEvWbBJGGPDAA3lmdzu3lSSvh1ap73D
         5UBQT1IQD0XnAmiXkCUAWqGbomTKBfimNu70t2mJxsKj5Mtqu/V8wlr/SPAKDAB+RhEo
         yXbtJNOSwfapBiZVy0N4/l+Jyeuevj1A95gP265vd9oKqW/xW2PXsd0c++LhKARYyv+t
         kB0Le+13MSpFJQLzhBaAqhDVErhR440Dm2vqBslNrH/wmTxUUGoM5Gh8bTDrAeRHstIV
         f+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyTBAmupt7gDEygKBlHM3btaCL0Q7p9LZZKGom+gcjE=;
        b=RbRk0cE/1247U76LOKJtkipjKGQpAaTjtVPUN5QgKVGH6b3ve8aHcwX53RA8an9qRt
         OE6H/GkB0WSPqT0TNuLBnRilHN8kKUG5RfHR/ARr75grOhrR890PmRNxwqYryxKE9xzK
         wiRdaVhMn14bRksoI1jjc94W35gAKJ7PGJzTpKKNJ07sph+nwx65zku4Pvmfx5MgxSVU
         wXpFqt/aqM6coRpIfiZdV2iZGVlV0+/MM6VIXW125lFQ7xPeg4Bcf0dcTc9vmkVhOp+p
         AAxCObh2aVmK1rPiNPhvCWhaIlOZYSwMevdLImKsds21ph209DFd+OITG+WeUk9i695V
         JQFA==
X-Gm-Message-State: AOAM53360QT7BT3Tuw+wv9xxd/vod7vNgJxGrf0qPeE5Ys8luDjBKhvH
        rN+wJHiu2Rsvjo/Ps8OwDI8=
X-Google-Smtp-Source: ABdhPJyKh7iPIkPR9sjuIJZzBhU8EUxsIHQvcnSOmjYFxxbKxUNmulYsBjbeG4ukJlImYa+sGVr+EA==
X-Received: by 2002:a2e:858e:: with SMTP id b14mr23909495lji.338.1638628663700;
        Sat, 04 Dec 2021 06:37:43 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 15/22] drm/tegra: hdmi: Register audio CODEC on Tegra20
Date:   Sat,  4 Dec 2021 17:37:18 +0300
Message-Id: <20211204143725.31646-16-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20 SoC supports only S/PDIF source for HDMI audio. Register ASoC HDMI
S/PDIF CODEC for Tegra20, it will be linked with the S/PDIF CPU DAI.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/Kconfig |   3 +
 drivers/gpu/drm/tegra/hdmi.c  | 153 +++++++++++++++++++++++++++++++---
 2 files changed, 145 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 32fe64553d2e..40f0d14cb240 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -13,6 +13,9 @@ config DRM_TEGRA_ORIG
 	select INTERCONNECT
 	select IOMMU_IOVA
 	select CEC_CORE if CEC_NOTIFIER
+	select SND_SIMPLE_CARD if SND_SOC_TEGRA20_SPDIF
+	select SND_SOC_HDMI_CODEC if SND_SOC_TEGRA20_SPDIF
+	select SND_AUDIO_GRAPH_CARD if SND_SOC_TEGRA20_SPDIF
 	help
 	  Choose this option if you have an NVIDIA Tegra SoC.
 
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index cc42476fd023..5353f83cbee8 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -18,6 +18,8 @@
 
 #include <soc/tegra/common.h>
 
+#include <sound/hdmi-codec.h>
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
@@ -81,6 +83,9 @@ struct tegra_hdmi {
 	bool dvi;
 
 	struct drm_info_list *debugfs_files;
+
+	struct platform_device *audio_pdev;
+	struct mutex audio_lock;
 };
 
 static inline struct tegra_hdmi *
@@ -363,6 +368,18 @@ static const struct tmds_config tegra124_tmds_config[] = {
 	},
 };
 
+static void tegra_hdmi_audio_lock(struct tegra_hdmi *hdmi)
+{
+	mutex_lock(&hdmi->audio_lock);
+	disable_irq(hdmi->irq);
+}
+
+static void tegra_hdmi_audio_unlock(struct tegra_hdmi *hdmi)
+{
+	enable_irq(hdmi->irq);
+	mutex_unlock(&hdmi->audio_lock);
+}
+
 static int
 tegra_hdmi_get_audio_config(unsigned int audio_freq, unsigned int pix_clock,
 			    struct tegra_hdmi_audio_config *config)
@@ -832,6 +849,23 @@ static void tegra_hdmi_setup_tmds(struct tegra_hdmi *hdmi,
 				  HDMI_NV_PDISP_SOR_IO_PEAK_CURRENT);
 }
 
+static int tegra_hdmi_reconfigure_audio(struct tegra_hdmi *hdmi)
+{
+	int err;
+
+	err = tegra_hdmi_setup_audio(hdmi);
+	if (err < 0) {
+		tegra_hdmi_disable_audio_infoframe(hdmi);
+		tegra_hdmi_disable_audio(hdmi);
+	} else {
+		tegra_hdmi_setup_audio_infoframe(hdmi);
+		tegra_hdmi_enable_audio_infoframe(hdmi);
+		tegra_hdmi_enable_audio(hdmi);
+	}
+
+	return err;
+}
+
 static bool tegra_output_is_hdmi(struct tegra_output *output)
 {
 	struct edid *edid;
@@ -1138,6 +1172,8 @@ static void tegra_hdmi_encoder_disable(struct drm_encoder *encoder)
 	u32 value;
 	int err;
 
+	tegra_hdmi_audio_lock(hdmi);
+
 	/*
 	 * The following accesses registers of the display controller, so make
 	 * sure it's only executed when the output is attached to one.
@@ -1162,6 +1198,10 @@ static void tegra_hdmi_encoder_disable(struct drm_encoder *encoder)
 	tegra_hdmi_writel(hdmi, 0, HDMI_NV_PDISP_INT_ENABLE);
 	tegra_hdmi_writel(hdmi, 0, HDMI_NV_PDISP_INT_MASK);
 
+	hdmi->pixel_clock = 0;
+
+	tegra_hdmi_audio_unlock(hdmi);
+
 	err = host1x_client_suspend(&hdmi->client);
 	if (err < 0)
 		dev_err(hdmi->dev, "failed to suspend: %d\n", err);
@@ -1185,6 +1225,8 @@ static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder)
 		return;
 	}
 
+	tegra_hdmi_audio_lock(hdmi);
+
 	/*
 	 * Enable and unmask the HDA codec SCRATCH0 register interrupt. This
 	 * is used for interoperability between the HDA codec driver and the
@@ -1390,6 +1432,8 @@ static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder)
 	}
 
 	/* TODO: add HDCP support */
+
+	tegra_hdmi_audio_unlock(hdmi);
 }
 
 static int
@@ -1419,6 +1463,91 @@ static const struct drm_encoder_helper_funcs tegra_hdmi_encoder_helper_funcs = {
 	.atomic_check = tegra_hdmi_encoder_atomic_check,
 };
 
+static int tegra_hdmi_hw_params(struct device *dev, void *data,
+				struct hdmi_codec_daifmt *fmt,
+				struct hdmi_codec_params *hparms)
+{
+	struct tegra_hdmi *hdmi = data;
+	int ret = 0;
+
+	tegra_hdmi_audio_lock(hdmi);
+
+	hdmi->format.sample_rate = hparms->sample_rate;
+	hdmi->format.channels = hparms->channels;
+
+	if (hdmi->pixel_clock && !hdmi->dvi)
+		ret = tegra_hdmi_reconfigure_audio(hdmi);
+
+	tegra_hdmi_audio_unlock(hdmi);
+
+	return ret;
+}
+
+static int tegra_hdmi_audio_startup(struct device *dev, void *data)
+{
+	struct tegra_hdmi *hdmi = data;
+	int ret;
+
+	ret = host1x_client_resume(&hdmi->client);
+	if (ret < 0)
+		dev_err(hdmi->dev, "failed to resume: %d\n", ret);
+
+	return ret;
+}
+
+static void tegra_hdmi_audio_shutdown(struct device *dev, void *data)
+{
+	struct tegra_hdmi *hdmi = data;
+	int ret;
+
+	tegra_hdmi_audio_lock(hdmi);
+
+	hdmi->format.sample_rate = 0;
+	hdmi->format.channels = 0;
+
+	tegra_hdmi_audio_unlock(hdmi);
+
+	ret = host1x_client_suspend(&hdmi->client);
+	if (ret < 0)
+		dev_err(hdmi->dev, "failed to suspend: %d\n", ret);
+}
+
+static const struct hdmi_codec_ops tegra_hdmi_codec_ops = {
+	.hw_params = tegra_hdmi_hw_params,
+	.audio_startup = tegra_hdmi_audio_startup,
+	.audio_shutdown = tegra_hdmi_audio_shutdown,
+};
+
+static int tegra_hdmi_codec_register(struct tegra_hdmi *hdmi)
+{
+	struct hdmi_codec_pdata codec_data = {};
+
+	if (hdmi->config->has_hda)
+		return 0;
+
+	codec_data.ops = &tegra_hdmi_codec_ops;
+	codec_data.data = hdmi;
+	codec_data.spdif = 1;
+
+	hdmi->audio_pdev = platform_device_register_data(hdmi->dev,
+							 HDMI_CODEC_DRV_NAME,
+							 PLATFORM_DEVID_AUTO,
+							 &codec_data,
+							 sizeof(codec_data));
+	if (IS_ERR(hdmi->audio_pdev))
+		return PTR_ERR(hdmi->audio_pdev);
+
+	hdmi->format.channels = 2;
+
+	return 0;
+}
+
+static void tegra_hdmi_codec_unregister(struct tegra_hdmi *hdmi)
+{
+	if (hdmi->audio_pdev)
+		platform_device_unregister(hdmi->audio_pdev);
+}
+
 static int tegra_hdmi_init(struct host1x_client *client)
 {
 	struct tegra_hdmi *hdmi = host1x_client_to_hdmi(client);
@@ -1471,8 +1600,16 @@ static int tegra_hdmi_init(struct host1x_client *client)
 		goto disable_pll;
 	}
 
+	err = tegra_hdmi_codec_register(hdmi);
+	if (err < 0) {
+		dev_err(hdmi->dev, "failed to register audio codec: %d\n", err);
+		goto disable_vdd;
+	}
+
 	return 0;
 
+disable_vdd:
+	regulator_disable(hdmi->vdd);
 disable_pll:
 	regulator_disable(hdmi->pll);
 disable_hdmi:
@@ -1487,6 +1624,8 @@ static int tegra_hdmi_exit(struct host1x_client *client)
 {
 	struct tegra_hdmi *hdmi = host1x_client_to_hdmi(client);
 
+	tegra_hdmi_codec_unregister(hdmi);
+
 	tegra_output_exit(&hdmi->output);
 
 	regulator_disable(hdmi->vdd);
@@ -1611,7 +1750,6 @@ static irqreturn_t tegra_hdmi_irq(int irq, void *data)
 {
 	struct tegra_hdmi *hdmi = data;
 	u32 value;
-	int err;
 
 	value = tegra_hdmi_readl(hdmi, HDMI_NV_PDISP_INT_STATUS);
 	tegra_hdmi_writel(hdmi, value, HDMI_NV_PDISP_INT_STATUS);
@@ -1626,16 +1764,7 @@ static irqreturn_t tegra_hdmi_irq(int irq, void *data)
 			format = value & SOR_AUDIO_HDA_CODEC_SCRATCH0_FMT_MASK;
 
 			tegra_hda_parse_format(format, &hdmi->format);
-
-			err = tegra_hdmi_setup_audio(hdmi);
-			if (err < 0) {
-				tegra_hdmi_disable_audio_infoframe(hdmi);
-				tegra_hdmi_disable_audio(hdmi);
-			} else {
-				tegra_hdmi_setup_audio_infoframe(hdmi);
-				tegra_hdmi_enable_audio_infoframe(hdmi);
-				tegra_hdmi_enable_audio(hdmi);
-			}
+			tegra_hdmi_reconfigure_audio(hdmi);
 		} else {
 			tegra_hdmi_disable_audio_infoframe(hdmi);
 			tegra_hdmi_disable_audio(hdmi);
@@ -1662,6 +1791,8 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	hdmi->stereo = false;
 	hdmi->dvi = false;
 
+	mutex_init(&hdmi->audio_lock);
+
 	hdmi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hdmi->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
-- 
2.33.1

