Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5724A468C8C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbhLESL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhLESLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:11:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DA8C061751
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 10:08:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d9so17617564wrw.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVbLQURO0Z9+ByAGWQaOmsfWDUK6bDVmhiIqKeEs0aE=;
        b=nFjzSkNR7Vt7NUjEHxsBt63+Y69rJq5h500HrTtMLIMNfhUgk7TR5niNnrdiFWf8WA
         +RQK/ThnUEuTN2rv5dzQc2IoCzA8BqP000JH4mLP9eotfQVdXcxKlBIx8rWDaFKgO6Fy
         pNwlAoPpzxF7X5rZcbuj2QuczHPULs64hnvYZf3i4xztjezQ5aRUfoDJ46KcglU4q+na
         NKx/oO6l3U0+oIlMDHDWpQnu+xzCeGds/oIXYweABOqsA4yX/mLk89PXAfZ5jAx7K8YY
         osT8Ld3oyXf1Zb4T3eqg8I8SQjsD7OOwSpfw1ICNlpOVu/RwdoX/pt/pGOK/rl4MAfMe
         yHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVbLQURO0Z9+ByAGWQaOmsfWDUK6bDVmhiIqKeEs0aE=;
        b=5wFg0NpZKg23Psodfl0NM2PLnBO/eqzkb7rbEaKQij8c81ZzS4F2KwNMpkZ/U6V7iw
         HLR1DSaQsIBK3AtYAPqof5TZ2s+TtlN84sGz91x91OsQ0ZN716s2L2JqAtdbvw1NEpqW
         UlK+P4tnsKOUBgnAr/duNMUeFdf1/ySI/ht+DXSJiBQaPyFQfYUmg7c56dstkoo9g+0A
         sUT9iDDZVSxixjLEtCaiLNWIvzHsqCCxUiDKz6nZrWwZxKoPhz8o2RGFzq8+B2h01kx6
         Nqt6k8VK0IkIWF/0R6B3k41pb2fN61AmWcp/6ZJJkdMjMsvWdDyM5oSCAxjDpx4f1N5a
         xG1g==
X-Gm-Message-State: AOAM533e8im8QXGAla0YlkG0/HLrhXemCIzMiTLZYVquo24mwjtnB/Q/
        4R7i+CTKRZYbn8AHFv73w00=
X-Google-Smtp-Source: ABdhPJxrxANxSMd67C/dfrBs5aJyYKwDtHT0izw5kgpG/58jALhXD31larUKefLy5N5zKN1ZkX4fbw==
X-Received: by 2002:adf:fb82:: with SMTP id a2mr36968627wrr.168.1638727706827;
        Sun, 05 Dec 2021 10:08:26 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c11b-a200-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c11b:a200:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id x13sm9250551wrr.47.2021.12.05.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 10:08:26 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        alsa-devel@alsa-project.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 1/2] ASoC: meson: aiu: fifo: Add missing dma_coerce_mask_and_coherent()
Date:   Sun,  5 Dec 2021 19:08:15 +0100
Message-Id: <20211205180816.2083864-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205180816.2083864-1-martin.blumenstingl@googlemail.com>
References: <20211205180816.2083864-1-martin.blumenstingl@googlemail.com>
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

