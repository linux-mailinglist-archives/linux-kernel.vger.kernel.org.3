Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F209358B266
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 00:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbiHEWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 18:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241467AbiHEWVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:21:33 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB7D1ADAF
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1659738091;
  x=1691274091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4iOxNsMSbtpOM27Z8TD3Hj1cDpxzqVK5IPL4dyFrR5g=;
  b=WL/zRxMUofsJB/SNA3df3G2Bz75aDODaZnW3uREQjzfYl6hU9TJrwmwS
   uWi9H/CvYx15Xi78KeVvo1tsRL6Ct1pndeRChqAch5dmVMCp7gnd5UlGX
   Wr6lX2RmLxe5mCpGxXTQoPYhocUVx6pa7maN2p+f+8WuPMhgI60itmd0N
   5nTGRhFFOlqg5o0chGuH9BXDRMAGX9yb2IRxpgBOTe2+xc0hYhcBw1/Or
   28CNhjEZkHimfSlBJyvi23dPnfQIkRWybEJWy4tl8LDt9nDQ/LuugMKd1
   4O1QuxJnEN6kLZFqN8Leu3Q5bk/HUdhDn+0/g+ts5W8ChGAQmDf75ir8U
   A==;
From:   Niklas Carlsson <Niklas.Carlsson@axis.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Niklas Carlsson <niklasc@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: adau1761: Reset codec at probe and shutdown
Date:   Sat, 6 Aug 2022 00:21:20 +0200
Message-ID: <20220805222120.2560501-1-Niklas.Carlsson@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Carlsson <niklasc@axis.com>

ADAU1X61 doesn't have a reset pin, which leads to the codec retaining
the register values after the device has been rebooted without a power
cycle. This causes the driver to be out of sync with the codec.

Simulating a hardware reset ensures that the codec is in a defined
state.

Link: https://lore.kernel.org/all/alpine.DEB.2.02.1603291544160.3594@lnxricardw1.se.axis.com/
Link: https://lore.kernel.org/all/alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com/
Signed-off-by: Niklas Carlsson <niklasc@axis.com>
---
 sound/soc/codecs/adau1761-i2c.c |  6 +++++
 sound/soc/codecs/adau1761-spi.c |  6 +++++
 sound/soc/codecs/adau1761.c     | 43 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/adau1761.h     |  1 +
 4 files changed, 56 insertions(+)

diff --git a/sound/soc/codecs/adau1761-i2c.c b/sound/soc/codecs/adau1761-i2c.c
index 0683caf86aea..23bffbd74469 100644
--- a/sound/soc/codecs/adau1761-i2c.c
+++ b/sound/soc/codecs/adau1761-i2c.c
@@ -36,6 +36,11 @@ static int adau1761_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+static void adau1761_i2c_shutdown(struct i2c_client *client)
+{
+	adau1761_shutdown(&client->dev);
+}
+
 static const struct i2c_device_id adau1761_i2c_ids[] = {
 	{ "adau1361", ADAU1361 },
 	{ "adau1461", ADAU1761 },
@@ -63,6 +68,7 @@ static struct i2c_driver adau1761_i2c_driver = {
 	},
 	.probe_new = adau1761_i2c_probe,
 	.remove = adau1761_i2c_remove,
+	.shutdown = adau1761_i2c_shutdown,
 	.id_table = adau1761_i2c_ids,
 };
 module_i2c_driver(adau1761_i2c_driver);
diff --git a/sound/soc/codecs/adau1761-spi.c b/sound/soc/codecs/adau1761-spi.c
index 7c9242c2ff94..5bbbc3d3b5be 100644
--- a/sound/soc/codecs/adau1761-spi.c
+++ b/sound/soc/codecs/adau1761-spi.c
@@ -50,6 +50,11 @@ static void adau1761_spi_remove(struct spi_device *spi)
 	adau17x1_remove(&spi->dev);
 }
 
+static void adau1761_spi_shutdown(struct spi_device *spi)
+{
+	adau1761_shutdown(&spi->dev);
+}
+
 static const struct spi_device_id adau1761_spi_id[] = {
 	{ "adau1361", ADAU1361 },
 	{ "adau1461", ADAU1761 },
@@ -77,6 +82,7 @@ static struct spi_driver adau1761_spi_driver = {
 	},
 	.probe = adau1761_spi_probe,
 	.remove = adau1761_spi_remove,
+	.shutdown = adau1761_spi_shutdown,
 	.id_table = adau1761_spi_id,
 };
 module_spi_driver(adau1761_spi_driver);
diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 8f887227981f..ac544e1e8dc7 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -974,6 +974,39 @@ static struct snd_soc_dai_driver adau1761_dai_driver = {
 	.ops = &adau17x1_dai_ops,
 };
 
+static void adau1761_reset(struct regmap *regmap)
+{
+	size_t i;
+
+	/*
+	 * Handle the lack of a reset pin in ADAU1X61 by manually writing all
+	 * registers to their default values.
+	 *
+	 * Steps for performing the reset:
+	 *   1) Make sure that the cache is marked as dirty by writing all
+	 *      default values directly to the cache.
+	 *
+	 *   2) Enable the core clock which is needed for writing all registers
+	 *      except CLOCK_CONTROL.
+	 *
+	 *   3) Use regcache_sync() for synchronizing the dirty cache back to
+	 *      the hardware.
+	 */
+
+	regcache_cache_only(regmap, true);
+	for (i = 0; i < ARRAY_SIZE(adau1761_reg_defaults); i++)
+		regmap_write(regmap, adau1761_reg_defaults[i].reg,
+			     adau1761_reg_defaults[i].def);
+	regcache_cache_only(regmap, false);
+
+	regmap_update_bits(regmap, ADAU17X1_CLOCK_CONTROL,
+			   ADAU17X1_CLOCK_CONTROL_SYSCLK_EN,
+			   ADAU17X1_CLOCK_CONTROL_SYSCLK_EN);
+	regcache_sync(regmap);
+	regmap_update_bits(regmap, ADAU17X1_CLOCK_CONTROL,
+			   ADAU17X1_CLOCK_CONTROL_SYSCLK_EN, 0);
+}
+
 int adau1761_probe(struct device *dev, struct regmap *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev))
 {
@@ -997,6 +1030,8 @@ int adau1761_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
+	adau1761_reset(regmap);
+
 	/* Enable cache only mode as we could miss writes before bias level
 	 * reaches standby and the core clock is enabled */
 	regcache_cache_only(regmap, true);
@@ -1006,6 +1041,14 @@ int adau1761_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_GPL(adau1761_probe);
 
+void adau1761_shutdown(struct device *dev)
+{
+	struct adau *adau = dev_get_drvdata(dev);
+
+	adau1761_reset(adau->regmap);
+}
+EXPORT_SYMBOL_GPL(adau1761_shutdown);
+
 const struct regmap_config adau1761_regmap_config = {
 	.val_bits = 8,
 	.reg_bits = 16,
diff --git a/sound/soc/codecs/adau1761.h b/sound/soc/codecs/adau1761.h
index 7beabf448ad1..98d698ebde27 100644
--- a/sound/soc/codecs/adau1761.h
+++ b/sound/soc/codecs/adau1761.h
@@ -16,6 +16,7 @@ struct device;
 
 int adau1761_probe(struct device *dev, struct regmap *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev));
+void adau1761_shutdown(struct device *dev);
 
 extern const struct regmap_config adau1761_regmap_config;
 
-- 
2.30.2

