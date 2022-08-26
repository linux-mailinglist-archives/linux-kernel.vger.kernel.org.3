Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39505A1EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbiHZCf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbiHZCfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:35:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0932E68E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:35:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a65so317000pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=YLgxiF89rhAaSiqrAqLeGjys84eskoyDUq88fMYi6UA=;
        b=A08NMEbdQ2LVLqA2QG4Uylmc8AJCL8cjcSDZ4ToJVFabYXmHdQnjBm3N9UTpiyav+e
         1Eult2hfeviCaQM65yj3icHdLUJylJlFoSUszK2UlHMf8oouPQaGxXAICVp2Bn4a9pwH
         4xRyktRi+ruT9b+RcBk9uikJsfbxuN2g8ApnyBFh+5Ngn6MEiSX8rNIXwlVXWmPUX73N
         oxNvoUz0oWoiXa60u/W3CwkFYQTG9RF22hJ4HsoXeeTEaGKuzjfRFyWCBoLwpdGVJPP2
         M8LkKTlPkxdkhzBGnstnYPgCqlaIqiO3nuaAq1GYYHfP8rTXYuXluQQYBuAxo9VkE1AZ
         QoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YLgxiF89rhAaSiqrAqLeGjys84eskoyDUq88fMYi6UA=;
        b=nDcoHJj33lRQZzFsQHIG69stFQ1r4KLY/IH9HG8Ep3368rTy2I91uRPJyIcQP3urEh
         k9xOFv2gJbvXIMJMWmpgVT7cDdgeHOk9EtrPC88ZJv7CFAy8VVZPsXNd6clDLomKosbB
         B8IJCfT0Q4TwVoosZeAxe9fltktCG2DCD7LvfUJdbHhIZS69ma8SoP8tWy0C5QBVMDPG
         wfDASK96+kOe+Jg1H5ulvTZSRgow3fj8LZK5ngNwPGckFQrMus3Tqbeoljovw7BFZ/i1
         kWCPqxwYKtp9hCLRVyz1LQ7rzESguAcXlIvouesamnCaOGYC2z+2BHDiNCJ9fLeMSIpx
         CB5g==
X-Gm-Message-State: ACgBeo0z3Dc0DrbHBZcuN5XEJjqOnC+DXf5cYJDQskTzrOooRhFnVaBg
        28j7lu/moo15MeVI3p04N+o=
X-Google-Smtp-Source: AA6agR69TZnd2al9dGGB1ospcLnBSuFirgfInFDbZAM8DBaBB7U0jAg+RkbOzm4E7oPOXaZ5l7SSPQ==
X-Received: by 2002:a63:2bc5:0:b0:41d:9b5f:acb0 with SMTP id r188-20020a632bc5000000b0041d9b5facb0mr1550631pgr.439.1661481338519;
        Thu, 25 Aug 2022 19:35:38 -0700 (PDT)
Received: from localhost.localdomain ([211.212.143.131])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709029a9100b00172ad292b6bsm269786plp.116.2022.08.25.19.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:35:38 -0700 (PDT)
From:   Steve Lee <steve.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     krzk@kernel.org, ryans.lee@analog.com,
        Steve Lee <steve.lee.analog@gmail.com>
Subject: [PATCH] ASoC: max98390: Remove unnecessary amp on/off conrtol
Date:   Fri, 26 Aug 2022 11:35:04 +0900
Message-Id: <20220826023504.6183-1-steve.lee.analog@gmail.com>
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
Remove unnecessary control in calibrate function.

Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
---
 sound/soc/codecs/max98390.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 91c0bf3d76fc..99e769190568 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -826,9 +826,6 @@ static int max98390_dsm_calibrate(struct snd_soc_component *component)
 	struct max98390_priv *max98390 =
 		snd_soc_component_get_drvdata(component);
 
-	regmap_write(max98390->regmap, MAX98390_R203A_AMP_EN, 0x81);
-	regmap_write(max98390->regmap, MAX98390_R23FF_GLOBAL_EN, 0x01);
-
 	regmap_read(max98390->regmap,
 		THERMAL_RDC_RD_BACK_BYTE1, &rdc);
 	regmap_read(max98390->regmap,
@@ -847,9 +844,6 @@ static int max98390_dsm_calibrate(struct snd_soc_component *component)
 	dev_info(component->dev, "rdc resistance about %d.%02d ohm, reg=0x%X temp reg=0x%X\n",
 		 rdc_integer, rdc_factor, rdc_cal_result, temp);
 
-	regmap_write(max98390->regmap, MAX98390_R23FF_GLOBAL_EN, 0x00);
-	regmap_write(max98390->regmap, MAX98390_R203A_AMP_EN, 0x80);
-
 	return 0;
 }
 
-- 
2.17.1

