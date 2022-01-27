Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A618249E321
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241572AbiA0NNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiA0NNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:13:46 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD57C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:13:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z5so2428095plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YXzkvLeXLi2eCYEQ5gEHtGCtSrlAhjMGW+JtDUaBg2s=;
        b=ABvPbSjyT6rV20F/ei4kOOQ1fFDOwJMtWo/sSVF9nIHbwU6Nqceo9/hWVX96sXehSx
         8ZsJVv3qVRw8N1xyHhNdLY/X8DD/XEoUT4H5eZ6EQG3+XZRclCPQ8IE8qdmobawqMRxr
         r6qQQ36gH5zwgOjsTBNi3nJfE1VtJpELMqDsF+jhoJ6vL/QTPfr+jWOa7uIYPXNtNdrO
         DTbby/kjEYxmz+tA4E1ifrjujFQVq1XjEGm8ipynyUYPmeckGnlGHqMYfJP9t83wmPlZ
         PmEQjfbmgnLQJAnxxvqsgMBYyaz+UDI4KEuQGYUo5iFukbzekZUltwXwB/mOLK5jkSzn
         c37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YXzkvLeXLi2eCYEQ5gEHtGCtSrlAhjMGW+JtDUaBg2s=;
        b=wZxG6U72nFofFd6Ek8OdF50ibLJRLC/eXeFvgeNntcnWTFaIBN+zNK8sXqscYtmQ88
         BJ/mrktq5miZZlrhIdgXhLVxmFlvGyi2KmyqIidTX/gwr0V5PnyEVkIzkSr4EyotLIe6
         39oPxiohB432zPOdMcK3ndyb2PCQWKJ5le6t+NRC82B3kSs3QZU1CXcaBiodf04oZCya
         d8L2OQMVGnVouVZ2ZOkGv5/+xqz/H2YTQX6zKmMP8Nqj7XZw6nFf6OG8M01dxNStRnab
         ujbcYPRjTZwwqTKoObBMwOiVBmCBBUZwEM2YIiYslhBCZbtnoH72fVGa756MGRIjjVht
         Z0Nw==
X-Gm-Message-State: AOAM531OLYFkgvGvJVmH7NF1TOjsk9nVAwcKOyYnVlT9303KWwTURM4F
        xFgOQXD7Unp83ATnv7EtAZY=
X-Google-Smtp-Source: ABdhPJysbG0ubLDHAuk/vm5CAv0jg6oZWRdNVaWO0vQPW+mAPZCdMtTl6CK+a5TjP6POX6vPtKJxxg==
X-Received: by 2002:a17:90b:17ca:: with SMTP id me10mr9860243pjb.207.1643289221704;
        Thu, 27 Jan 2022 05:13:41 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id d9sm5683355pfl.69.2022.01.27.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:13:41 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Eric Millbrandt <emillbrandt@dekaresearch.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] ASoC: fsl: Add missing error handling in pcm030_fabric_probe
Date:   Thu, 27 Jan 2022 13:13:34 +0000
Message-Id: <20220127131336.30214-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YfFFWSVgnbL6ETxo@sirena.org.uk>
References: <YfFFWSVgnbL6ETxo@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_put() and platform_device_del()
before return from pcm030_fabric_probe in the error handling case.

Fixes: c912fa913446 ("ASoC: fsl: register the wm9712-codec")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- avoid return early before the card registration.
---
 sound/soc/fsl/pcm030-audio-fabric.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index af3c3b90c0ac..83b4a22bf15a 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -93,16 +93,21 @@ static int pcm030_fabric_probe(struct platform_device *op)
 		dev_err(&op->dev, "platform_device_alloc() failed\n");
 
 	ret = platform_device_add(pdata->codec_device);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
+		platform_device_put(pdata->codec_device);
+	}
 
 	ret = snd_soc_register_card(card);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
+		platform_device_del(pdata->codec_device);
+		platform_device_put(pdata->codec_device);
+	}
 
 	platform_set_drvdata(op, pdata);
-
 	return ret;
+
 }
 
 static int pcm030_fabric_remove(struct platform_device *op)
-- 
2.17.1

