Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53A5B147A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiIHGOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHGOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:14:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E424A50E6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:13:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q3so16738146pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ngoKgI+Gpj5SpGutpSICvbZM5VaeXyWj2yjGsVSlTyI=;
        b=UXmoGztAvkbEq8ev/rCGPZB8yRP3yewWsjk2wn+kToOvlBnkUnfjcJmlUy8VZsh+6o
         upACSRU/9FbMwwZ0C7zy+5PrqftYa6eaR7WnqSL246uw0EdmMQrmF6AgaDl+zSXdCyNB
         m/UM8PnMtSCCyBrBgLy1MsippYNrhWJQveq8t9ROubqbcEiHnTm09hZwdEansfEacwkj
         DYIgydyEQYygV7VI8u9Y3RUTSw1sCWBJle01kKRs9OqS75pscLYWm+W25hx5bjCaPkoP
         TqRr3PCqqduYYIfGksN50DVKUhwOnLD5NHhCOTsMdvP3YmH/fEICOtblI/FqZi++qURU
         oDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ngoKgI+Gpj5SpGutpSICvbZM5VaeXyWj2yjGsVSlTyI=;
        b=OraReHuz2zLzSsW9H5gsT9mNaPhcbmSEtAFljOCkgu9aCdAgBUxf2mkL7tpzZa62qj
         D7BINJZAgpLj4d3uHmkM+ASa1XG7FzXF0yDld3se6pWtaEsOh3QzWQYEZ1Y7ZzKK50ya
         25A51fiTB/7JZWZsPOGjixlfvUVrQyUKVC2TCha31sxsjxiJz8pYGJDZU6hZlPSVmBu8
         d+vnvtst14lqAJ51A8mncdXj0hBnOQpN8gKz59rpBkvZIrEO9zFQNmOBpsIZt+86gfZM
         zsSOjDgCuJcfHy1rE6Q2Xt0QNs9GOhxc+mGyZgtkEszWR6JE/VGEG4OsiCBSahIbJTJh
         oJ5g==
X-Gm-Message-State: ACgBeo24rk3AoVuUyCW2KsbhrKlEmyQnD2kIKtiFeO/f/qDgFDkMXplc
        neDmgQ6yK6oOkR3+M0eREPU=
X-Google-Smtp-Source: AA6agR7vc1mfwDN0ui9GNVakudcVSEUPlFZb5nXcrH5tmYMdajmFL8Dk3nYYXQrt6R5mZvx9uqSPDA==
X-Received: by 2002:a17:90b:4a09:b0:1fd:d4be:fed4 with SMTP id kk9-20020a17090b4a0900b001fdd4befed4mr2578331pjb.6.1662617639152;
        Wed, 07 Sep 2022 23:13:59 -0700 (PDT)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b00176b7dcf2c0sm7775886plg.240.2022.09.07.23.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:13:58 -0700 (PDT)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     krzk@kernel.org, ryans.lee@analog.com,
        Steve Lee <steve.lee.analog@gmail.com>
Subject: [v2] ASoC: max98390: Remove unnecessary amp on/off conrtol
Date:   Thu,  8 Sep 2022 15:03:59 +0900
Message-Id: <20220908060359.13606-1-steve.lee.analog@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The Amp is already control in userspace before trigger calibrate function.
Remove unnecessary control in calibrate function and
add condition to check calibration is ready.

Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
---
 sound/soc/codecs/max98390.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 91c0bf3d76fc..4b2ee70c29d7 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -635,10 +635,19 @@ static int max98390_dsm_calib_get(struct snd_kcontrol *kcontrol,
 static int max98390_dsm_calib_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
+	unsigned int val;
 	struct snd_soc_component *component =
 		snd_soc_kcontrol_component(kcontrol);
+	struct max98390_priv *max98390 =
+		snd_soc_component_get_drvdata(component);
 
-	max98390_dsm_calibrate(component);
+	regmap_read(max98390->regmap, MAX98390_R23FF_GLOBAL_EN, &val);
+	if (val == 0x1)
+		max98390_dsm_calibrate(component);
+	else {
+		dev_err(component->dev, "AMP is not ready to run calibration\n");
+		return -ECANCELED;
+	}
 
 	return 0;
 }
@@ -826,9 +835,6 @@ static int max98390_dsm_calibrate(struct snd_soc_component *component)
 	struct max98390_priv *max98390 =
 		snd_soc_component_get_drvdata(component);
 
-	regmap_write(max98390->regmap, MAX98390_R203A_AMP_EN, 0x81);
-	regmap_write(max98390->regmap, MAX98390_R23FF_GLOBAL_EN, 0x01);
-
 	regmap_read(max98390->regmap,
 		THERMAL_RDC_RD_BACK_BYTE1, &rdc);
 	regmap_read(max98390->regmap,
@@ -847,9 +853,6 @@ static int max98390_dsm_calibrate(struct snd_soc_component *component)
 	dev_info(component->dev, "rdc resistance about %d.%02d ohm, reg=0x%X temp reg=0x%X\n",
 		 rdc_integer, rdc_factor, rdc_cal_result, temp);
 
-	regmap_write(max98390->regmap, MAX98390_R23FF_GLOBAL_EN, 0x00);
-	regmap_write(max98390->regmap, MAX98390_R203A_AMP_EN, 0x80);
-
 	return 0;
 }
 
-- 
2.17.1

