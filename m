Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB45B0666
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiIGOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiIGOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:22:35 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7837C75FCF;
        Wed,  7 Sep 2022 07:22:19 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D228B20000F;
        Wed,  7 Sep 2022 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662560537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SRJhK68KAnFJfkryAuHaNW+7tiZrtjjidVkx4uYL5XU=;
        b=AOWGd9MnnWKkE7Kmh2RGiJ/tBsTNQAQlKX7ROe9c/tvImUL9+OaD5W96WHNG9mvr6LmjGl
        PUmSTtKfPtvyt88zsz1P9TKi8vzYE+Kx5tiTBSCYjU1wfbYNX6TDJ7TsuW+n7fkGEWEHa9
        yauHRc7Ov7tlYpoW6WRPbL0dxV0vf7gQbenMqjFAPJQTazZpap8MXWGBI7oixstVXRTdD9
        tSbp3QWfblJLKxm0SvRGUDGdSt36nQ0YrUwrQdrV+ayViu491G9x195k9S4gqsjvBJkA7k
        hdXkSoElmUCLXK6Kw7IwGFwPb1WX2xY8pMUz3K8TVuAVKNqL240woQFIA31GaA==
From:   luca.ceresoli@bootlin.com
To:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 8/8] ASoC: rockchip: add new RK3308 sound card
Date:   Wed,  7 Sep 2022 16:21:24 +0200
Message-Id: <20220907142124.2532620-9-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

The Rockchip RK3308 8-channel I2S adapter has a mainline driver that can
work fine with an audio-graph-card or simple-audio-card. Those card drivers
call the .set_sysclk op once, and this is usually enough for applications
using an external codec.

But in reality the I2S adapter has two clock inputs (TX and RX), and the
preferred way to use the RK3308 internal codec is enabling both clocks,
potentially with different rates. The existing simple-card code does not
implement this possibility.

To allow setting both clocks, add a new minimal driver that builds on top
of audio-graph-card and changes the dai_link->init callback with a modified
version of asoc_simple_init_dai(). This ultimately calls the set_sysclk()
callback as many times as the number of clocks defined in device tree.

With this implementation, the same rate is set to all the sysclks. Setting
different rates can be added later.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 MAINTAINERS                               |  1 +
 sound/soc/rockchip/Kconfig                | 14 ++++
 sound/soc/rockchip/Makefile               |  1 +
 sound/soc/rockchip/rockchip_rk3308_card.c | 97 +++++++++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 sound/soc/rockchip/rockchip_rk3308_card.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2a0a6e3c1f..96ccda9625f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17600,6 +17600,7 @@ ROCKCHIP RK3308 SOUND CARD DRIVER
 M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
+F:	sound/soc/rockchip/rockchip_rk3308_card.c
 
 ROCKCHIP VIDEO DECODER DRIVER
 M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 42f76bc0fb02..b00dc04f8fd0 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -45,6 +45,20 @@ config SND_SOC_ROCKCHIP_SPDIF
 	  Say Y or M if you want to add support for SPDIF driver for
 	  Rockchip SPDIF transceiver device.
 
+config SND_SOC_ROCKCHIP_RK3308_INTERNAL_CODEC
+	tristate "ASoC sound card based on the internal RK3308 codec"
+	depends on HAVE_CLK && SND_SOC_ROCKCHIP
+	depends on SND_AUDIO_GRAPH_CARD
+	select SND_SOC_ROCKCHIP_I2S_TDM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  ASoC sound card driver for the RK3308 internal audio codec.
+
+	  The Rockchip RK3308 SoC has a built-in audio codec that is
+	  connected internally to one out of a selection of the internal
+	  I2S controllers. This driver implements an audio card using these
+	  components.
+
 config SND_SOC_ROCKCHIP_MAX98090
 	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && HAVE_CLK
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 30c57c0d7660..680decae0c02 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -15,6 +15,7 @@ snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
 snd-soc-rk3288-hdmi-analog-objs := rk3288_hdmi_analog.o
 snd-soc-rk3399-gru-sound-objs := rk3399_gru_sound.o
 
+obj-$(CONFIG_SND_SOC_ROCKCHIP_RK3308_INTERNAL_CODEC) += rockchip_rk3308_card.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
 obj-$(CONFIG_SND_SOC_RK3288_HDMI_ANALOG) += snd-soc-rk3288-hdmi-analog.o
diff --git a/sound/soc/rockchip/rockchip_rk3308_card.c b/sound/soc/rockchip/rockchip_rk3308_card.c
new file mode 100644
index 000000000000..3cfc751993fe
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_rk3308_card.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Audio card using the RK3308 internal I2S
+//
+// Allows driving the I2S peripheral with both the RX and TX clocks. This
+// is useful to use the RK3308 internal audio codec.
+//
+// Copyright (c) 2022, Vivax-Metrotech Ltd
+//
+// Based on sound/soc/generic/audio-graph-card.c
+
+#include <linux/module.h>
+#include <linux/of_clk.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <sound/graph_card.h>
+
+static int rk3308_audio_asoc_simple_init_dai(struct snd_soc_dai *dai,
+					     struct asoc_simple_dai *simple_dai)
+{
+	const int nclks = 2; /* The sysclks are clk_id 0 and 1 for the RK3308 driver */
+	int err;
+	int i;
+
+	if (!simple_dai || !simple_dai->sysclk)
+		return 0;
+
+	/* Can be extended to get two different sysclk values via device tree */
+	for (i = 0; i < nclks; i++) {
+		err = snd_soc_dai_set_sysclk(dai, i, simple_dai->sysclk,
+					     simple_dai->clk_direction);
+		if (err && err != -ENOTSUPP)
+			return dev_err_probe(dai->dev, err, "simple-card: set_sysclk error\n");
+	}
+
+	return 0;
+}
+
+static int rk3308_audio_asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *props = simple_priv_to_props(priv, rtd->num);
+	struct asoc_simple_dai *dai;
+	int i, ret;
+
+	for_each_prop_dai_codec(props, i, dai) {
+		ret = rk3308_audio_asoc_simple_init_dai(asoc_rtd_to_codec(rtd, i), dai);
+		if (ret < 0)
+			return ret;
+	}
+	for_each_prop_dai_cpu(props, i, dai) {
+		ret = rk3308_audio_asoc_simple_init_dai(asoc_rtd_to_cpu(rtd, i), dai);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rk3308_audio_graph_probe(struct platform_device *pdev)
+{
+	struct asoc_simple_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct snd_soc_card *card;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	card = simple_priv_to_card(priv);
+	card->driver_name = "rk3308-audio-graph-card";
+	card->probe = asoc_graph_card_probe;
+	priv->init = rk3308_audio_asoc_simple_dai_init;
+
+	return audio_graph_parse_of(priv, dev);
+}
+
+static const struct of_device_id graph_of_rk3308_card_match[] = {
+	{ .compatible = "rockchip,rk3308-audio-graph-card" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, graph_of_rk3308_card_match);
+
+static struct platform_driver rk3308_audio_graph_card = {
+	.driver = {
+		.name = "rk3308-audio-graph-card",
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = graph_of_rk3308_card_match,
+	},
+	.probe = rk3308_audio_graph_probe,
+	.remove = asoc_simple_remove,
+};
+module_platform_driver(rk3308_audio_graph_card);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ASoC Audio Graph Card for Rockchip RK3308");
+MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
-- 
2.34.1

