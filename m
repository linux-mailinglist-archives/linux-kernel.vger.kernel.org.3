Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DF04C8598
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiCAHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiCAHyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:54:38 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875BC7086D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:53:58 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o8so13748995pgf.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=k29JDfqvR6mNy7EkcocFmwmWLWxTFCgH8vy77P+eaVE=;
        b=U4QvuLzoLqAHKmQMoaUBg1B7A0xkreLeZ9Spbt0PJWnJCyzL/Lt0YuogzyZMoU3R66
         nMIvKh9tmxlCXVma/LPIStHeRFFeCKZ5z4A4pmar0rMiSdBTAhSnlVt64ntQDfcNbGzZ
         CFoGASFO/MlfxvU/Fsv1afgYUtZpuM/4woI//24S2o4tNxj9IdyMO2/oI0fDuW3PsddV
         QlPK8iSl99r8713o9iG6Z1CyzVWc6QzRslUvPUAqmqqa2clXdAa4h7l8oMXMwgzjmV+M
         FzMyt1B3jye1dChvuCQbEY5pw/fb3UV1Tz8VE23Ei6tL3WZ5EyTuqJ9VcNqOey09ERIP
         w8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=k29JDfqvR6mNy7EkcocFmwmWLWxTFCgH8vy77P+eaVE=;
        b=ftk6DXA7dmZiIOLNLWX83k/cFbbcderLV4174RbjoPc+/rDlmz2m/GTuRG9/BWfkLY
         dpIuu6rhwFKo22uhy9/M+tlz5UDrHuDitJyBBEHJ9s3RDL6hTTSENSDeRYBwFpSuRNZr
         Hv0j1tHJrJOb7Cw9Tsb0YfAHK5hwsFpbxZmY74TffY5Z8odQ06XikWDhk4GePiDMVTOO
         67PeILlHBH+bVFMgN3y2HZ0JG9dJwfqU8HaPRVcWYDCOCaT56bO9VwBM0uqQmLADhrUw
         gqSKXPaevTmiVndwu2YAsVSBLcPz0qFxzkVWhZ55ggHLPyLD0o/Lh8wo4xWR992lVH1E
         +C9g==
X-Gm-Message-State: AOAM532TA0DzzQNn3w3TXDBj4V0nJaI/6zPqWAd+E6HMs72g/LxgyDvL
        7Tj5ihNv9sS0kYX4Iw/cDRRM61vY8OzbF3Y1UHU=
X-Google-Smtp-Source: ABdhPJzwTwnamipFkPsIa99LN8JgvfXABeGyi9pRo+WzEGsNhK2+qosAq26HNCVULju916ag/5zr4g==
X-Received: by 2002:a65:4845:0:b0:325:c147:146d with SMTP id i5-20020a654845000000b00325c147146dmr21097675pgs.140.1646121237775;
        Mon, 28 Feb 2022 23:53:57 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a0d5700b001bc3c650e01sm1856852pju.1.2022.02.28.23.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:53:57 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl: Fix error handling in pcm030_fabric_probe
Date:   Tue,  1 Mar 2022 07:53:48 +0000
Message-Id: <20220301075351.31691-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will call twice platform_device_put()
if both platform_device_add() and snd_soc_register_card() fails.
Fix it by using goto label to avoid duplicating the error code logic.

Fixes: fb25621da570 ("ASoC: fsl: Add missing error handling in pcm030_fabric_probe")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/fsl/pcm030-audio-fabric.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 83b4a22bf15a..d397bb97f37b 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -95,19 +95,23 @@ static int pcm030_fabric_probe(struct platform_device *op)
 	ret = platform_device_add(pdata->codec_device);
 	if (ret) {
 		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
-		platform_device_put(pdata->codec_device);
+		goto err_add;
 	}
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
-		platform_device_del(pdata->codec_device);
-		platform_device_put(pdata->codec_device);
+		goto err_register;
 	}
 
 	platform_set_drvdata(op, pdata);
 	return ret;
 
+err_register:
+	platform_device_del(pdata->codec_device);
+err_add:
+	platform_device_put(pdata->codec_device);
+	return ret;
 }
 
 static int pcm030_fabric_remove(struct platform_device *op)
-- 
2.17.1

