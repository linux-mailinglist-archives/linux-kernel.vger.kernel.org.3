Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A34F4A34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453955AbiDEWhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355094AbiDENHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:07:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF17E37A02
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:10:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c23so10774524plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbiE+hfmclVFPMzSs7FFPFZTMtCm2FkL6jROPMDnRco=;
        b=f90euc1zGDb5iI2Drt4AgWz4VSglJB6yfAjqBN2f2PEHYRVTGUMuR2aWLT+B9bQLYZ
         5mdNK58woXp0Y4e9aOv3d8OX/VqNTyQtckVs5+qiav9/te+260XIfZTexMNJ1laI1MOS
         UPtB203QxYia416r6lnWw63WrEB3TjBwSdLl2sTYYDa5Dgjfxv/80o+ItR/X4Fci8vsc
         bDwtnerqMSS5Tg51zD50a1oBl0zZM6gHRDpyLX+uQxW4P4PyIiMXRCZF7LYrOp504pSZ
         5By7/QzVinQqc/m+fx/fy/oyq/uJtMRlCqlfknv48FM1UjI/IphqHLC/x1Unw5gvUOJs
         T4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbiE+hfmclVFPMzSs7FFPFZTMtCm2FkL6jROPMDnRco=;
        b=QmYIE7wESEgl8BqHLWQpmVd5Y2keCIgoDlDpOk7e1QXIGT+lV83trnRRNhAKnqI0O9
         jIgu7eRj3g32ABVbu4FkzhqVVC9UtJnky+GWpro+YJVL2GOHXK3eLGmaHZVxRAfqi3Xu
         kSvagK6qHNiT2k7C0DkAi9pYSAGuWTEwmesWrSSZclT7ge39ompWNjmArt1/KZjbr/O+
         EqO21si1lVmIUga824EP+H12vmpt7WYVP5pPe8NHLs29Iq3G8zFOvf8U/RIEDhA2dXct
         53LdM2HcPAB+OwPnwbh4TOCEmKiurA2jX8sNPUPiMZg+rsp3deU3OOctEmjPJuAbN9ON
         VWpQ==
X-Gm-Message-State: AOAM531LX6H0YyH2/XX322A+rONMrjIdBwEQ7VfuNOSbhbyblgElMg4H
        IzSd+YNPOU2nGfKjX68lAA==
X-Google-Smtp-Source: ABdhPJysxtv6ffWslGA0KEeiw5vxSuzfXJxSlxUJAcxN0jasthK2NULv5We+duXJGrrCrP1B3w4OZw==
X-Received: by 2002:a17:902:e748:b0:153:b484:bdf4 with SMTP id p8-20020a170902e74800b00153b484bdf4mr3198892plf.66.1649160650444;
        Tue, 05 Apr 2022 05:10:50 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id n52-20020a056a000d7400b004fad9132d73sm14980117pfv.129.2022.04.05.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:10:49 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] ASoC: wm8731: Disable the regulator when probing fails
Date:   Tue,  5 Apr 2022 20:10:38 +0800
Message-Id: <20220405121038.4094051-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver fails during probing, the driver should disable the
regulator, not just handle it in wm8731_hw_init().

The following log reveals it:

[   17.812483] WARNING: CPU: 1 PID: 364 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
[   17.815958] RIP: 0010:_regulator_put+0x3ec/0x4e0
[   17.824467] Call Trace:
[   17.824774]  <TASK>
[   17.825040]  regulator_bulk_free+0x82/0xe0
[   17.825514]  devres_release_group+0x319/0x3d0
[   17.825882]  i2c_device_probe+0x766/0x940
[   17.829198]  i2c_register_driver+0xb5/0x130

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/soc/codecs/wm8731.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 5d4949c2ec9b..b14c6d104e6d 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -602,7 +602,7 @@ static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
 	ret = wm8731_reset(wm8731->regmap);
 	if (ret < 0) {
 		dev_err(dev, "Failed to issue reset: %d\n", ret);
-		goto err_regulator_enable;
+		goto err;
 	}
 
 	/* Clear POWEROFF, keep everything else disabled */
@@ -619,10 +619,7 @@ static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
 
 	regcache_mark_dirty(wm8731->regmap);
 
-err_regulator_enable:
-	/* Regulators will be enabled by bias management */
-	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
-
+err:
 	return ret;
 }
 
@@ -760,21 +757,27 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(wm8731->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto err_regulator_enable;
 	}
 
 	ret = wm8731_hw_init(&i2c->dev, wm8731);
 	if (ret != 0)
-		return ret;
+		goto err_regulator_enable;
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_wm8731, &wm8731_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		return ret;
+		goto err_regulator_enable;
 	}
 
 	return 0;
+
+err_regulator_enable:
+	/* Regulators will be enabled by bias management */
+	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
+
+	return ret;
 }
 
 static const struct i2c_device_id wm8731_i2c_id[] = {
-- 
2.25.1

