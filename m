Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B74B507EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358904AbiDTCVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:21:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C8B30574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:19:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o5so600914pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=rF0d2fPjjYbYQnGkxkUzLty/3S+O+5X64cLZKZhZO4E=;
        b=a687CipGVP6S8l+yw3Z2qapCCMGrDznZGl7Hg3EB037BBEABhZ6eF3M10/IylPutLq
         tQk4PoARW3oQOylOYrHMJUSK816QZrgIdfkSTwwL0QdHAkJVcmKoL9XaORVH2tFZ8bkQ
         suw0zsEntUJBE2xRXZ3LyV8uwnGt9PxlXtBzTac8aTchaXiMvgmTCOZPXXL6jawi62ut
         YG/CoFhUJ9DK3+VJLvU6h9rohaJqhLf1gVWx+op8HU8pcClxlOXXbY1WGA2Y41fi03v6
         q6u8qH5e52PTYTG/EQ2jyxwTOkR9v9EjEuQQpyd1QGp4cAZO59SpZQ1J0naqroyozhTl
         HKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=rF0d2fPjjYbYQnGkxkUzLty/3S+O+5X64cLZKZhZO4E=;
        b=OAruLsKv41TN5Cbx5WYmnIV7qMzikoysVJqhPieL1V3Z73b+J73V03OCyBbueDoXlA
         mxqUb6/YLrj1XXJEP69xwzHbAO3YrPjMPkQNbBMasJrRQdOlbCj+qj38luspOSzenYiM
         IM0kxgGcnH/Ip1RZVXnpgcEfYzLVAZ/Y+d6ostWTM1aVdrXT3Sv+4gBgQkdRiSAWEzYN
         zK0tROeILjwf2VdQTW5prWB7OoXoIsd5PGIIF/+OP6DHgOnpJ8C1cNiErJBIrzuqjxB5
         dXHI4xyeBsKf9Kh8MsCPpiYscyD4L+M1odwwizH15Pu90VXkcDdQ7+o0wtIx+SpDKXXZ
         xeZw==
X-Gm-Message-State: AOAM530S2BQe2T4siTcHb+s5Nsmo7CgX4oV/wgVYH4rtoFnKf5YfmZA+
        U6SbCfT8VS9RsGbiNcP2S2E=
X-Google-Smtp-Source: ABdhPJxbaX8P4DgFAq5AqtRlie8zEQAmzOhdP6082cOtk6bDfu+J7/3gLmB876ENEQEoVEvDJTvcPQ==
X-Received: by 2002:a17:902:bd06:b0:158:8973:b16b with SMTP id p6-20020a170902bd0600b001588973b16bmr18598380pls.129.1650421145605;
        Tue, 19 Apr 2022 19:19:05 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x22-20020aa784d6000000b005082b06cc58sm17015120pfn.215.2022.04.19.19.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:19:05 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl: Fix error handling in pcm030_fabric_probe
Date:   Wed, 20 Apr 2022 02:18:52 +0000
Message-Id: <20220420021855.8224-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yh90u+E3RTuGEDWU@sirena.org.uk>
References: <Yh90u+E3RTuGEDWU@sirena.org.uk>
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
return early on error  to avoid duplicating the error code logic.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- use return statement to return early when fails
- rebase on top of commit 559089e0a93d ("vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP")
---
 sound/soc/fsl/pcm030-audio-fabric.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 83b4a22bf15a..096a37993ad3 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -89,13 +89,16 @@ static int pcm030_fabric_probe(struct platform_device *op)
 		dev_err(&op->dev, "request_module returned: %d\n", ret);
 
 	pdata->codec_device = platform_device_alloc("wm9712-codec", -1);
-	if (!pdata->codec_device)
+	if (!pdata->codec_device) {
 		dev_err(&op->dev, "platform_device_alloc() failed\n");
+		return -ENOMEM;
+	}
 
 	ret = platform_device_add(pdata->codec_device);
 	if (ret) {
 		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
 		platform_device_put(pdata->codec_device);
+		return ret;
 	}
 
 	ret = snd_soc_register_card(card);
@@ -103,6 +106,7 @@ static int pcm030_fabric_probe(struct platform_device *op)
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
 		platform_device_del(pdata->codec_device);
 		platform_device_put(pdata->codec_device);
+		return ret;
 	}
 
 	platform_set_drvdata(op, pdata);
-- 
2.17.1

