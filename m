Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94150D533
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiDXVCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiDXVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 17:02:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36A69488;
        Sun, 24 Apr 2022 13:59:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b19so18214611wrh.11;
        Sun, 24 Apr 2022 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iC9g0FH3bzlHy7hoAv9K0hivd/arMZ+Ly8xR4y4PBWk=;
        b=P+8os97Rm5U4fIyuksZFXvRkInCU65BbYq2K9UoiK/mVjmr82Ylpl5MFYaRprjB+tn
         15C4QL7f4g8WZHtYI+7gd1R04rtCBQZzEjfUkCGHvHxTVpPklYNWEOAHIJp+I3mmeY4l
         0zA+UEhSK946KfO7C9AzBJ5f4PeevFiabTfmAeNheaYbkuc40D5DgaYLTdOpvVL5+YY8
         clUsiu+UUHoIN4abTLuAqIBMtsa2fNmfmJ98WdAdba7pmFCufkXCkEaMPiiSKXfH8v1P
         4oQJCDm9pEBO63zeHJc8j99PWXxiPpkqML4vWfKRAjA5QeDwGNixWskYgsCu6j2Y/fr9
         tAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iC9g0FH3bzlHy7hoAv9K0hivd/arMZ+Ly8xR4y4PBWk=;
        b=yuW37nqSeHohQuwkIDRz1+pxvFbpTjvzVPJTKJ/uUv0nIBYqcFtTwbERMn4FfGmsYw
         HjJGlPbOpGgv8axgb4SeHf7acaf1Wikhlb3nIqE1UofTfM1Gkf236QB7W9LXTTrIF7zB
         gwg/GJsWZfZtsoZvUWQ8lcvUxoDCcT/htQDxwVRuVOOnMzogiTTSjv3Femox3EDfUIW2
         FP+Rk7Hz9ki3BmUjl52gV7z62rfF7S0XXfrB01UfJPFIqqeoUa6rPuqL+lMtN+t/nr9y
         tuE1YKtnBPAfUYLbR/+ZFoaZzh0PwxXse3rq5s1uuTT1T1ZUfbHJ/hRxYxjLm0ffv7vx
         TgBw==
X-Gm-Message-State: AOAM532W9SaO7kCpapX+/RJdGxbVatdJAxWN6qBvMjGaIqiRhyByMVdg
        1sYubNJulTES07uOSyM7gnI=
X-Google-Smtp-Source: ABdhPJyOmQXw6y5ZKF2bDQTx9dMffPCO4ImkFLqarqZm9PGwJVZtU39NB9Mq+ZuTOO9z5oke2RehRg==
X-Received: by 2002:a05:6000:1a44:b0:20a:ccde:c139 with SMTP id t4-20020a0560001a4400b0020accdec139mr9326075wry.320.1650833987138;
        Sun, 24 Apr 2022 13:59:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b00393e6f6c130sm3653656wms.42.2022.04.24.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 13:59:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcm: Check for null pointer of pointer substream before dereferencing it
Date:   Sun, 24 Apr 2022 21:59:45 +0100
Message-Id: <20220424205945.1372247-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer substream is being dereferenced on the assignment of pointer card
before substream is being null checked with the macro PCM_RUNTIME_CHECK.
Although PCM_RUNTIME_CHECK calls BUG_ON, it still is useful to perform the
the pointer check before card is assigned.

Fixes: commit d4cfb30fce03 ("ALSA: pcm: Set per-card upper limit of PCM buffer allocations")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/core/pcm_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 8848d2f3160d..b8296b6eb2c1 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -453,7 +453,6 @@ EXPORT_SYMBOL(snd_pcm_lib_malloc_pages);
  */
 int snd_pcm_lib_free_pages(struct snd_pcm_substream *substream)
 {
-	struct snd_card *card = substream->pcm->card;
 	struct snd_pcm_runtime *runtime;
 
 	if (PCM_RUNTIME_CHECK(substream))
@@ -462,6 +461,8 @@ int snd_pcm_lib_free_pages(struct snd_pcm_substream *substream)
 	if (runtime->dma_area == NULL)
 		return 0;
 	if (runtime->dma_buffer_p != &substream->dma_buffer) {
+		struct snd_card *card = substream->pcm->card;
+
 		/* it's a newly allocated buffer.  release it now. */
 		do_free_pages(card, runtime->dma_buffer_p);
 		kfree(runtime->dma_buffer_p);
-- 
2.35.1

