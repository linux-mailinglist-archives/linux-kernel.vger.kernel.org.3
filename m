Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5A51B5BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiEECVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiEECVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:21:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46919483AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:18:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a191so2586287pge.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pIXDVokFolVKrzalTPKUm2CP3QVEc7PDIydFuy2ELrg=;
        b=VTMfiv/xxi6fGdCelW3OOBaUHSCm7CuZK+BQdtEUII66q8gebxTf/i43wtPpxuwg46
         5OXvSyTPQJ4h5XCfeXHkYuEyDfjap7ZqgOq+130hL11jSuDpUzvwjrVjbo/uTaqtGsPe
         msDZ7TOhh6Q62Cl41WK66/t5wy29qmqTdjeeo0wWa9CP411/IOJ8EcHvJgal+ZwepiMK
         4HRNPzZWvsiVxGNUZQsbHKlaiwdWDw7d6hKuwuyNnQ6j8RCQGl7JYJvIbvHdXCSkg+hk
         ARyfUqXY63VnGRzvh4aa/DJntuX5ziUFLzXtAGQOWXALdGZDcweQepSrO1tTJNUvo6W7
         vfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pIXDVokFolVKrzalTPKUm2CP3QVEc7PDIydFuy2ELrg=;
        b=NNZy+1zeCqhwShUf8ad0TZGVBZxaJ0j0PxzcA8Q3jWOj3nfX5eIjghiqkLQwcgdcYy
         8e/Vx5xT4UoRLpU8B0kRDaniu6EMIbJpQnsV4fGK3KntYl7TzGd9rHMsSWKJXiov+xHS
         Q0Otjf5A/YeIZDoC9sUEasDuRX/1eMBtRUcz0DPY1F+T/5bNidoSo4rV1J+QbBLfM3dM
         F0+uoZhKaR1ncmJm2/QBP0KxX1xlmMhPJzfClpIHk1UjkJ5FlGLetzxM04SDBuG0+vex
         Zz4yjahTd6yjGnggjLMxCgoDnWVNdPdwSZXRe99dn4moJph5W/QupFVOvUAQ8EiQwmOs
         tHTA==
X-Gm-Message-State: AOAM533RI1iLsY0kHW3PNILX6BE18JQ9kqYyC5V93M+7RVWJVFUTvfLX
        4Ewz/gjs1H/sWDLw1Dbd1s8=
X-Google-Smtp-Source: ABdhPJzWZdSl8kCzaGbBSh6IuuBwK7I7BYee0kVZukFZY0T4WG5+0idnYzYBVwUf4sMRTt4ffT1k1Q==
X-Received: by 2002:a65:6cc9:0:b0:399:26da:29af with SMTP id g9-20020a656cc9000000b0039926da29afmr20022746pgw.489.1651717092863;
        Wed, 04 May 2022 19:18:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090aab0100b001cd4989fecesm3967290pjq.26.2022.05.04.19.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:18:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: mediatek: simplify the return expression of mtk_dai_pcm_prepare()
Date:   Thu,  5 May 2022 02:18:08 +0000
Message-Id: <20220505021808.54337-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c b/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
index 151914c873ac..12644ded83d5 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-pcm.c
@@ -213,8 +213,6 @@ static int mtk_dai_pcm_configure(struct snd_pcm_substream *substream,
 static int mtk_dai_pcm_prepare(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	int ret;
-
 	dev_dbg(dai->dev, "%s(), id %d, stream %d, widget active p %d, c %d\n",
 		__func__, dai->id, substream->stream,
 		dai->playback_widget->active, dai->capture_widget->active);
@@ -222,11 +220,7 @@ static int mtk_dai_pcm_prepare(struct snd_pcm_substream *substream,
 	if (dai->playback_widget->active || dai->capture_widget->active)
 		return 0;
 
-	ret = mtk_dai_pcm_configure(substream, dai);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mtk_dai_pcm_configure(substream, dai);
 }
 
 static int mtk_dai_pcm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
-- 
2.25.1


