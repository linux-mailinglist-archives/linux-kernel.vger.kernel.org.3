Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E223D4A972D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357882AbiBDJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:53:17 -0500
Received: from hutie.ust.cz ([185.8.165.127]:33278 "EHLO hutie.ust.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238145AbiBDJxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:53:16 -0500
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1643968390; bh=LuyZYQHYhM7mDbz1CL5RgnP3xYkRgZlDQNSvjNOXph4=;
        h=From:To:Cc:Subject:Date;
        b=WDUvnWecUmePdGih1J3vLtPXuIautd/TGo6FSlu9tdW2q4LP4WNyBgGI0x77v3oD7
         p2/9r57QXimsxwnaphJrB+0BkHOCLIy+GxmB5AfdYvbvwnW/mQr7Jg15WAKvQLEOkf
         1riKOCdTsR5pDs6+I2CqvzNj7sj0SUXKPugxqpc8=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ye Bin <yebin10@huawei.com>,
        Frank Shi <shifu0704@thundersoft.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH v2] ASoC: tas2770: Insert post reset delay
Date:   Fri,  4 Feb 2022 10:53:01 +0100
Message-Id: <20220204095301.5554-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per TAS2770 datasheet there must be a 1 ms delay from reset to first
command. So insert delays into the driver where appropriate.

Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
In previous submission of this patch some people got their copy
encrypted. That was by accident, pardon that. I have changed my email
provider since.

v1: https://lore.kernel.org/alsa-devel/20220201234612.74401-1-povik+lin@protonmail.com/

 sound/soc/codecs/tas2770.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index b52c0861edc8..b397a2122dd4 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -38,10 +38,12 @@ static void tas2770_reset(struct tas2770_priv *tas2770)
 		gpiod_set_value_cansleep(tas2770->reset_gpio, 0);
 		msleep(20);
 		gpiod_set_value_cansleep(tas2770->reset_gpio, 1);
+		usleep_range(1000, 2000);
 	}
 
 	snd_soc_component_write(tas2770->component, TAS2770_SW_RST,
 		TAS2770_RST);
+	usleep_range(1000, 2000);
 }
 
 static int tas2770_set_bias_level(struct snd_soc_component *component,
@@ -110,6 +112,7 @@ static int tas2770_codec_resume(struct snd_soc_component *component)
 
 	if (tas2770->sdz_gpio) {
 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
+		usleep_range(1000, 2000);
 	} else {
 		ret = snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
 						    TAS2770_PWR_CTRL_MASK,
@@ -529,8 +532,10 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 
 	tas2770->component = component;
 
-	if (tas2770->sdz_gpio)
+	if (tas2770->sdz_gpio) {
 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
+		usleep_range(1000, 2000);
+	}
 
 	tas2770_reset(tas2770);
 
-- 
2.33.0

