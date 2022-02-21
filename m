Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0C4BE294
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347221AbiBUNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358674AbiBUNLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092AB1EC77
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v12so27036069wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lv2cURY5ctLyr3w/A6pppI7w3hfD7whTI0vMJP1Qd1k=;
        b=Qhf8qTxok8B+nYSoESkmhYepqk5DhUeRay0CpursGNJLagZ+rGGfLsFjJkoB+caVcv
         gfPZL7uWeUq+O0SjB7iwPAOE7EkmGwo9D/d8Xmt977m9bNabSyJXx4xjmp3YpL9W837T
         ZbduZOLtx4JTMqsQgNHPlZmERTLF79DlVMjmneW/q6Pyr3i1xv/zLvP8BI415iXBOPBd
         kwCgqvWY767wX+dkeJUyO12moZ8ojm6ymLq24zphhUoNAcvbyxR0D+PdWROsJOt948ku
         dfzq2+wUaxr6PXe2Bv6W92by1grhecHKCU41lraXGPDUv1qlg0am7Rlz5WqKi0OxpfTP
         hhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lv2cURY5ctLyr3w/A6pppI7w3hfD7whTI0vMJP1Qd1k=;
        b=g18MqE++Ou5b7O03cfhI3CCEPIYWCbF1laLEeZSn9D5H9PbBew9I894pAzrhAzpScp
         ZGOqx09XnjZC4Qmd14OttPjphiAATzBDCBRdpDdU1ti/FzMiy/Cy2nCgJkve7gZAByXB
         StH2MJF3iRgwhtOv5R0M47w0vyh1Rrc34FBAWXIjpPCZsf0k271iQQKDLvo1NCQLQauM
         0NjLFFasGsbs1wDkFnFcWOMj+9k0Kp044bUZDiMzlYo0XKt0gsH6H0NAXBltiC9S9vqu
         yhJnBbDTITASgb0NAN0KV6ee7FoLyDdpD5id9jb7JzYY1RllqZYPmufnMmtG2m3liw1x
         07Gg==
X-Gm-Message-State: AOAM531Z2c+l0wx1px6nGPtJSSKf6uET8bHN02wjFJ2KUTnMZB6IH0qc
        CXa7PaZDZI7OAIZYrlmqV/1kwg==
X-Google-Smtp-Source: ABdhPJxmN9JoqBG+vnbmNNu11ati/Y+uONpXUxzd/ucsg+UiEuVXR6Aeymf5Rc+ZEIF67qkKuQze2Q==
X-Received: by 2002:a05:6000:44:b0:1e4:b901:5f72 with SMTP id k4-20020a056000004400b001e4b9015f72mr15506187wrx.109.1645449046590;
        Mon, 21 Feb 2022 05:10:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/10] ASoC: codecs: wsa881x: add runtime pm support
Date:   Mon, 21 Feb 2022 13:10:32 +0000
Message-Id: <20220221131037.8809-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WSA881x codecs can not cope up with clk stop and requires a full reset after suspend.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 0222370ff95d..d851ba14fbdd 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -11,6 +11,7 @@
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw_type.h>
@@ -198,6 +199,7 @@
 #define WSA881X_OCP_CTL_TIMER_SEC 2
 #define WSA881X_OCP_CTL_TEMP_CELSIUS 25
 #define WSA881X_OCP_CTL_POLL_TIMER_SEC 60
+#define WSA881X_PROBE_TIMEOUT 1000
 
 #define WSA881X_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -747,6 +749,12 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
 	unsigned int mask = (1 << fls(max)) - 1;
 	int val, ret, min_gain, max_gain;
 
+	ret = pm_runtime_get_sync(comp->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(comp->dev);
+		return ret;
+	}
+
 	max_gain = (max - ucontrol->value.integer.value[0]) & mask;
 	/*
 	 * Gain has to set incrementally in 4 steps
@@ -773,6 +781,9 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
 		usleep_range(1000, 1010);
 	}
 
+	pm_runtime_mark_last_busy(comp->dev);
+	pm_runtime_put_autosuspend(comp->dev);
+
 	return 1;
 }
 
@@ -1101,6 +1112,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
 	struct wsa881x_priv *wsa881x;
+	struct device *dev = &pdev->dev;
 
 	wsa881x = devm_kzalloc(&pdev->dev, sizeof(*wsa881x), GFP_KERNEL);
 	if (!wsa881x)
@@ -1124,6 +1136,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+	pdev->prop.simple_clk_stop_capable = true;
 	gpiod_direction_output(wsa881x->sd_n, 1);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
@@ -1132,12 +1145,52 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 		return PTR_ERR(wsa881x->regmap);
 	}
 
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return devm_snd_soc_register_component(&pdev->dev,
 					       &wsa881x_component_drv,
 					       wsa881x_dais,
 					       ARRAY_SIZE(wsa881x_dais));
 }
 
+static int __maybe_unused wsa881x_runtime_suspend(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
+
+	gpiod_direction_output(wsa881x->sd_n, 0);
+
+	regcache_cache_only(regmap, true);
+	regcache_mark_dirty(regmap);
+
+	return 0;
+}
+
+static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
+
+	gpiod_direction_output(wsa881x->sd_n, 1);
+
+	wait_for_completion_timeout(&slave->initialization_complete,
+				    msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
+
+	regcache_cache_only(regmap, false);
+	regcache_sync(regmap);
+
+	return 0;
+}
+
+static const struct dev_pm_ops wsa881x_pm_ops = {
+	SET_RUNTIME_PM_OPS(wsa881x_runtime_suspend, wsa881x_runtime_resume, NULL)
+};
+
 static const struct sdw_device_id wsa881x_slave_id[] = {
 	SDW_SLAVE_ENTRY(0x0217, 0x2010, 0),
 	SDW_SLAVE_ENTRY(0x0217, 0x2110, 0),
@@ -1151,6 +1204,7 @@ static struct sdw_driver wsa881x_codec_driver = {
 	.id_table = wsa881x_slave_id,
 	.driver = {
 		.name	= "wsa881x-codec",
+		.pm = &wsa881x_pm_ops,
 	}
 };
 module_sdw_driver(wsa881x_codec_driver);
-- 
2.21.0

