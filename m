Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470D246A921
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350156AbhLFVL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350111AbhLFVLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:11:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93503C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:08:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d9so25103784wrw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVbLQURO0Z9+ByAGWQaOmsfWDUK6bDVmhiIqKeEs0aE=;
        b=JJI/H5a668Mbw7an8DN7K5GFo+wMZtRO8iMv7j/qlsQGYFUIRN6UN8UO4pRQj4kE4Q
         3E+w1ZmIpJu3OuLUHoI9LMIe8ZBkG26ekEFAwXwIv2KDBvqWUqcgTuKHLPykX3Ai3Jm/
         e/lrTmT3Y4YmHzwAg4UvD7yr+Zw7wBUhk2EHakWmhWg36/pTFpm0yypEDi/g4CEjIiaZ
         0CdFL2GDfoNavQdQNPbIw64cGgxlrrYI0bIc03PrjA048vcvDH8SY1jLtta3PEblBI2j
         XvAdE7zk/vz8Ryvo7GHx+FCqS5wosrdXIsgXuIBBh5MaU09HaDgeLkAFqHFgrwn2i4Zb
         0aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVbLQURO0Z9+ByAGWQaOmsfWDUK6bDVmhiIqKeEs0aE=;
        b=YIQZ0O0dp9SyxD9FxARJ9r4gR3aWMj8yqs2wCwuzwPoBmn6P73tkZ5YRMkYQaymFDF
         FnGpm3GKAS/jN7NSYi5bSr45fCkcFQVcF1QIyCNuKjiGSi+niabfVUeOYfG7MwKZzGEW
         ZZDpwh0RfPvJtyFOLRgZxmZJDvUcQEffH9Thlh9SYUmUKPd1DX9viAj724gEz9W9HSKy
         qJm1yonNq1viJCngHvvAgaAslAygXzfDzegPMTWO6mlavontO7MQyHsCvIVuDkvUr3kE
         Ev2q/KDvV5Zzk+gYSkCU4yDZvgVZpuSGJTuZiJn9xW2Fgj2b/nctZv6i4OkzbEa6xRMI
         C/WA==
X-Gm-Message-State: AOAM532/6Q5BZ/Lr9g2yPxPTIzEQZVRJ32T8wvcY8TaxPefz9DqGGvDL
        QN3Ud/9TboSdxp9lr1DO9mWfhg4EzJw=
X-Google-Smtp-Source: ABdhPJzEwhqm3P3YmM/t7Y0RuKivCcAhGdMYzJbPK7Wpsp6pnDkQCJuVYBBJQWzsPjGC43hmFI+h+Q==
X-Received: by 2002:adf:cd09:: with SMTP id w9mr44802888wrm.619.1638824902076;
        Mon, 06 Dec 2021 13:08:22 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c0cf-f800-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c0cf:f800:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id p13sm511195wmi.0.2021.12.06.13.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:08:20 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] ASoC: meson: aiu: fifo: Add missing dma_coerce_mask_and_coherent()
Date:   Mon,  6 Dec 2021 22:08:03 +0100
Message-Id: <20211206210804.2512999-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206210804.2512999-1-martin.blumenstingl@googlemail.com>
References: <20211206210804.2512999-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIFO registers which take an DMA-able address are only 32-bit wide
on AIU. Add dma_coerce_mask_and_coherent() to make the DMA core aware of
this limitation.

Fixes: 6ae9ca9ce986bf ("ASoC: meson: aiu: add i2s and spdif support")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 sound/soc/meson/aiu-fifo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/meson/aiu-fifo.c b/sound/soc/meson/aiu-fifo.c
index 4ad23267cace..d67ff4cdabd5 100644
--- a/sound/soc/meson/aiu-fifo.c
+++ b/sound/soc/meson/aiu-fifo.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
@@ -179,6 +180,11 @@ int aiu_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	struct snd_card *card = rtd->card->snd_card;
 	struct aiu_fifo *fifo = dai->playback_dma_data;
 	size_t size = fifo->pcm->buffer_bytes_max;
+	int ret;
+
+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
 
 	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
 				       card->dev, size, size);
-- 
2.34.1

