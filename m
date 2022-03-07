Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CFD4CF366
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiCGIRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiCGIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:17:37 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14D260A89;
        Mon,  7 Mar 2022 00:16:43 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e6so12943226pgn.2;
        Mon, 07 Mar 2022 00:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=raqbpMEGShYefmM2lPsX/wn04IxIjWx9nKhMvQ9D+wE=;
        b=BNimnkt4tAYxOrYU5Uge9V4+0vLNsbclTuwKqjK74jpop5Qdyv69MW4oq/V22hs16i
         1M9kbbvMzrCC1ddQzjInFS9ZKPkERkLR9l36a0vDcLUHHxP18YHx/aiKA2UGgEVo7D/1
         1IQc1+Mq2DA8Pi4YRwDwW7I5NIm3A2snsdnOJ+A5MrZP0FP7cF5N898enWfJYa9Mxr5h
         OlTSo3RdkixkDw0H6pST7VYMAg7Ot50fRjhLFNwVHSjJp3DwAEtKX+NNasm67QhoVwUw
         6QuuzqyDseOHjUgIw9Ina7WocvpZNZoY90Ql4eW6PQhx/crSrbM7jhd0gPcvWDEFdPHF
         RqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=raqbpMEGShYefmM2lPsX/wn04IxIjWx9nKhMvQ9D+wE=;
        b=zuAEocwweglT4NhcfhPwr6EiqdyPo2aJJbX+Ca1fxXH0G9B6xaoGbkBHH4rM4XdosI
         bieFv5NqU3SkTQqdSwGftP5jDDaCK9hCPvSGGlvj5JECdGeHrT1lHH5A75srMixtS23y
         2y7Ub3dkxbUGtEf9rr710gwG/9SBVZqoJVxJ0D6Uk0fHWVBPzMdwXf5iuwF7D+gZ09PR
         H2MsBoDHLatLV8uv72ZOhuO9qyQj6TpuacoiyAL26HZtkOtqeIDqhygmabpbMVHtYdWH
         PKKfpdzPSgENxc+jH8U9aR1nAaR06XkuqnTZ2ew2OJwn5QkHFyEltDF/XQe+XXT6hBCP
         2XeQ==
X-Gm-Message-State: AOAM533m4wUhWiA5JSgXOIwejJM3m+6FChC0FqYPPrMMi8lU6LbJGbt9
        RTYza6hDC1Q6KUEX8M8EMx9I7wj2j1kzThngfqM=
X-Google-Smtp-Source: ABdhPJwLCC8qpXc15DQQZT4xlr+B37oV+EAKeb375Bz04voz9973VRvzvRyVGd+65lNjSpUCJ17Zzw==
X-Received: by 2002:a63:20f:0:b0:378:9f08:a0a4 with SMTP id 15-20020a63020f000000b003789f08a0a4mr8871175pgc.17.1646641003345;
        Mon, 07 Mar 2022 00:16:43 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x6-20020a17090aa38600b001bce781ce03sm11995365pjp.18.2022.03.07.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:16:43 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v3] media: atmel: atmel-isc: Fix PM disable depth imbalance in atmel_isc_probe
Date:   Mon,  7 Mar 2022 08:16:37 +0000
Message-Id: <20220307081638.19733-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8e4a35a4-1d8f-5aff-f577-2a2b87646528@xs4all.nl>
References: <8e4a35a4-1d8f-5aff-f577-2a2b87646528@xs4all.nl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will decrease power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 0a0e265 ("media: atmel: atmel-isc: split driver into driver base and isc")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- remove unused label.
changes in v3:
- add disable_pm label and update related 'goto'
- update commit message
---
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 1b2063cce0f7..949035cdb846 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -538,7 +538,7 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(isc->ispck);
 	if (ret) {
 		dev_err(dev, "failed to enable ispck: %d\n", ret);
-		goto cleanup_subdev;
+		goto disable_pm;
 	}
 
 	/* ispck should be greater or equal to hclock */
@@ -556,6 +556,9 @@ static int atmel_isc_probe(struct platform_device *pdev)
 unprepare_clk:
 	clk_disable_unprepare(isc->ispck);
 
+disable_pm:
+	pm_runtime_disable(dev);
+
 cleanup_subdev:
 	isc_subdev_cleanup(isc);
 
-- 
2.17.1

