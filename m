Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B314DAEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345749AbiCPLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiCPLQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:16:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF0853B68
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:15:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id rm8-20020a17090b3ec800b001c55791fdb1so2095194pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zpi5C9VV7konMRkeAfHk+5WhJ0SH5tbVLPHMmc40AjM=;
        b=C2CWoCL0Ekn9fRjpQjKpOPVMIMUMUH4Npcw0+/oPcg2aLyuUpYvpAw2dmMqTRUwiSM
         b+zYOdiV3tuPw0Gfyl+AKftp59xe8UdWWNofXLCyZtOx7uURMvHYlcAeB8yKAneYjKqI
         fYjiMp+r4Vxzip6CRZd+JVH029JC7ei9MKq3aXE5t+HCCfNQBhvNEZXFvV/wfp3FPJWs
         bKIlWbir8Q68uJLn+5yO5nxMHTC+DWePTVxlHYBCzmupgsfYsLryvD7UWfSd7CILtx0Z
         Crzxs7nNVuWLQLQ1FCSjg35uCXMp/uJX+PDG8iXGsPIIJLnv5Up1osKZ48w5qCjNl2oF
         VNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zpi5C9VV7konMRkeAfHk+5WhJ0SH5tbVLPHMmc40AjM=;
        b=pYA18LIAqNJIN7uYQlDlDuyNHQJyskQskyJ1/+j9OAMGYL9KzM0QtuwbcumshKJLOP
         GlfdqX4HPOlAUL3v5n8UZkmVabZmj5TSFOvayrXzHtlR1u+cxh9Jz2qdbXep/aOy/Hrm
         MPOJTKNoTCINMrIv614b+IDM4kKcolEJLU8CjFBcqxqFXU428rUkmB/20mHZUn4v9LIv
         gvpmGyiZNMbtaIhDUa5tTk2cBG86QrQ7qmtEfJmpvPjoLa6Wb4QlWo9eYWB0g2TL7DY5
         JOrz6XhvyjFzVR1pjjBwc+Q2DUeIVqqJcJKJ6x/KZ7mdIOI3SD2o1awSn9Q6NEQvRFou
         LZTQ==
X-Gm-Message-State: AOAM531VpYB8a5qS4bBlzahH1kY7MdLTbcxAgNfz1vEiTozNIFHMiILC
        dMtn5MMe3ZgadVRCAUESM/bqJp/PBFMloF8/bHs=
X-Google-Smtp-Source: ABdhPJwD/HkV28o+VSnvQcF7fVyfofI2bk4qfLidwrOFxEvmYqOHaHPM3R6krfmEk/xw91sIJ45ZPQ==
X-Received: by 2002:a17:902:edd5:b0:153:abee:1093 with SMTP id q21-20020a170902edd500b00153abee1093mr5290014plk.77.1647429342185;
        Wed, 16 Mar 2022 04:15:42 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w3-20020a63af03000000b00381309eb407sm2125704pge.68.2022.03.16.04.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 04:15:41 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: atmel: Fix error handling in sam9x5_wm8731_driver_probe
Date:   Wed, 16 Mar 2022 11:15:30 +0000
Message-Id: <20220316111530.4551-1-linmq006@gmail.com>
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

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

This function only calls of_node_put() in the regular path.
And it will cause refcount leak in error path.

Fixes: fdbcb3cba54b ("ASoC: atmel: machine driver for at91sam9x5-wm8731 boards")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/atmel/sam9x5_wm8731.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 7c45dc4f8c1b..99310e40e7a6 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -142,7 +142,7 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "atmel,ssc-controller node missing\n");
 		ret = -EINVAL;
-		goto out;
+		goto out_put_codec_np;
 	}
 	dai->cpus->of_node = cpu_np;
 	dai->platforms->of_node = cpu_np;
@@ -153,12 +153,9 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to set SSC %d for audio: %d\n",
 			ret, priv->ssc_id);
-		goto out;
+		goto out_put_cpu_np;
 	}
 
-	of_node_put(codec_np);
-	of_node_put(cpu_np);
-
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "Platform device allocation failed\n");
@@ -167,10 +164,14 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s ok\n", __func__);
 
-	return ret;
+	goto out_put_cpu_np;
 
 out_put_audio:
 	atmel_ssc_put_audio(priv->ssc_id);
+out_put_cpu_np:
+	of_node_put(cpu_np);
+out_put_codec_np:
+	of_node_put(codec_np);
 out:
 	return ret;
 }
-- 
2.17.1

