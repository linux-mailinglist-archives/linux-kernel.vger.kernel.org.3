Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679CF49C8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbiAZLdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiAZLdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:33:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615FDC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:33:12 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h14so5282418plf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=a8wHaxFP6XLg/+G2Gdl2AxvIcrGqp9pWAjcn6Z4Bg5Q=;
        b=PSlbe9++ZoQHmKjIdWrjG+TGtkYyetB4XHKyf09AJjOlKxZjkgHgCh4a+vWBsR0oS7
         mxALTkCh1w9lBxjOWpnGuywGjti5sA3PO3lmLz6YLekl/HL39j0JGRg54VNDX7XBB871
         zlmnhSA/jMwu5kgnZKy3T1ApGfz+/vI1QKetRHciKlkudV+ym07Y5GBA8liEWrXlYVJR
         C5KGEN3qwKt/7SxTyLNiQUEZNvpPHkQigi5k3FTshX07frGPWOiniLBZOyqqhF7WVWWo
         iiZ+mFuNgvkpbCLBhwUeJvbuhelvp3HI3OO7IkVc/nStHiC1nb/7pZkwnI23aab+vin+
         gusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=a8wHaxFP6XLg/+G2Gdl2AxvIcrGqp9pWAjcn6Z4Bg5Q=;
        b=6xeFxJFMkqRUVfm7QjpRgJfyVKd+6hBENXnrtjVubI4M+U6SdVk6eXMSe/BwPuN8PD
         6CoMk7wR3WmplPes9AbVmZfKkY8t8gWs3lope4r/TLOZh/Aq7bI9vtxokexqzNtRLs//
         8if/7iDZnT/B3Y5CWb4C6zDxPb91HylYZBoGZKOykJmhbZrtDsSXHP9y8taRMD17btXU
         qOTTGbL8cuWn9CFcp42WJlPEf/RRxyC1wysYiRPbd17fWfmbZ0+I0ZxbJ00ZC/QzWbyJ
         Gjb8IsGZbVNNOEXDiiD9qw8EZbCkaVwE13+tBHJIXRTQ88L+Z84jwxIRrE/ZOZL0wYzc
         ZvnA==
X-Gm-Message-State: AOAM5326VPPuKsr97gv3P4ICLoiGQ55Wqvt/CcmNhvGXl+yjCP4Yqifk
        omLYBBWFsQKljR74QUJUFIs=
X-Google-Smtp-Source: ABdhPJyYzirjwI2H2BJxS8J/fQ26G11g80rcwzf3uUGfhnZSUjJpCP5YHoznUbQ/c6XDeMzYwfXeCw==
X-Received: by 2002:a17:90b:3ec5:: with SMTP id rm5mr6448550pjb.14.1643196791927;
        Wed, 26 Jan 2022 03:33:11 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id m1sm1913787pfk.202.2022.01.26.03.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:33:11 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Eric Millbrandt <emillbrandt@dekaresearch.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl: Add missing error handling in pcm030_fabric_probe
Date:   Wed, 26 Jan 2022 11:33:04 +0000
Message-Id: <20220126113307.1673-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_put() and platform_device_del()
before return from pcm030_fabric_probe in the error handling case.

Fixes: c912fa913446 ("ASoC: fsl: register the wm9712-codec")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/fsl/pcm030-audio-fabric.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index af3c3b90c0ac..02c4ae20c673 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -93,15 +93,22 @@ static int pcm030_fabric_probe(struct platform_device *op)
 		dev_err(&op->dev, "platform_device_alloc() failed\n");
 
 	ret = platform_device_add(pdata->codec_device);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
+		goto exit_device_put;
+	}
 
 	ret = snd_soc_register_card(card);
 	if (ret)
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
 
 	platform_set_drvdata(op, pdata);
+	return ret;
 
+exit_release_dev:
+	platform_device_del(pdata->codec_device);
+exit_device_put:
+	platform_device_put(pdata->codec_device);
 	return ret;
 }
 
-- 
2.17.1

