Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C734C4D52
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiBYSIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiBYSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:07:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE7E7651
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:07:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d28so5710175wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3494fabfX+g/TnvTx8UrlMiKRNc/OZTSYfQjqznBH5Q=;
        b=rbitAh5AMmHgf5CrW8Gtn4dCqx1Qx5svPwApsEKod3HnITDN7ArPkxlRqHmJXXFC8y
         6SYaHJ0kgFkCD8iek8fk6w9s0imY6/DOlKIvPa0V/HkBCCQofSRkwH3FZW8nGFib/FqL
         fPmn5tuPAHzKrn7Ps+xkNhh1imezyPHpswFdsQ710P//kdH0I3M0bQB8sQoCaNVw9OMa
         Y66et6ZmtuisAgQO4Vv5pJzAnoEJh4HK5aYhlHkTWkvx1iNwZVpVx8WKnCFcPCSxdCkf
         NNlbtmCcKwGjBYsZ+qMnSGJVz3ZL53PPSZVdWCeGH1dS4XoG/4NN5LvYTZK2KpG1UqAQ
         CvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3494fabfX+g/TnvTx8UrlMiKRNc/OZTSYfQjqznBH5Q=;
        b=N3CjK70JlmHHCEksNb7QJnA5OTy3y+1cXxpeo9qJ+N7znkZS+I8OMU3KGSU6OiIGir
         pidcjzCoZwzOWgbo0aIflQ5ys2q0wWImvN0VBPNjBLYuTJ2Vd3yHiSP+hByhDEP1TyQk
         MJ0OoSNDULYPMaOsLv8D+YpLJZAj+oY2z9iNQXoszfbNpYLFKQOsRSQXPWnqfEvUpfNh
         +c/1xekIy7Q3pv/+RDnA5+lc4qiSx+Ee2yeYf+DCysM9rRnTTpaNqC/XlHASKOlHaxHO
         2YQu9AY5lHMT54EZbzTfjiJ7mexjy+VoV5QFDG/894Fvfp/sxtET36vTlH9O0qGVCoI9
         bSUw==
X-Gm-Message-State: AOAM530xzaSaHMCMbiNeTgIy/1RZ6DWvPMXp1ePV1XNkqSZyiC9+8EFw
        sfrLetBSEUyzvjwJ41HjzZg8fw==
X-Google-Smtp-Source: ABdhPJxp+5JOa+KdOagd/fb8D8X0qcKGrEhy+KpOnZ5wtgjkuCNMXCg2l1AOZWTTBPN2hkXgkCkThg==
X-Received: by 2002:a05:6000:1788:b0:1e9:e6d5:9e18 with SMTP id e8-20020a056000178800b001e9e6d59e18mr6866379wrg.356.1645812439959;
        Fri, 25 Feb 2022 10:07:19 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id k7-20020adfb347000000b001e595adb6d9sm2986576wrd.79.2022.02.25.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:07:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3] ASoC: codecs: wsa881x: add runtime pm support
Date:   Fri, 25 Feb 2022 18:07:16 +0000
Message-Id: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

WSA SoundWire Controller does not support Clock stop and performs a soft reset
on suspend  resume path. Its recommended that WSA881x codecs connected to this
are also reset using a hard reset during suspend resume.

So this codec driver performs a hard reset during suspend resume cycle.
---
Hi Mark, 
Looks like the runtime pm series was partly applied, so am sending just this
leftover patch with requested changes.

Changes since v2:
  removed setting up simple_clk_stop_capable flag
  update log

srini


 sound/soc/codecs/wsa881x.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 0222370ff95d..616b26c70c3b 100644
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
@@ -1132,12 +1144,52 @@ static int wsa881x_probe(struct sdw_slave *pdev,
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
@@ -1151,6 +1203,7 @@ static struct sdw_driver wsa881x_codec_driver = {
 	.id_table = wsa881x_slave_id,
 	.driver = {
 		.name	= "wsa881x-codec",
+		.pm = &wsa881x_pm_ops,
 	}
 };
 module_sdw_driver(wsa881x_codec_driver);
-- 
2.21.0

