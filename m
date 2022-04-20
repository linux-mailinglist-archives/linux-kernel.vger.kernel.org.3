Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20487507F47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbiDTDFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348893AbiDTDFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:05:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134FF393E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:02:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id j9so373742qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0fji8Nu54ZhqBHvvYgDr+3hwosEUpxW6x/vEKV84Pk=;
        b=lN1gvCms+NB3UyWtqtN2kTKNax/+AmWYxHLcez/Y3M1D0LFnSF8jnFnk/VGvEnD17l
         BpGDV0SHpABDq4i/bcfGPyMA+dwKy8AYC9VGF+fQQcksG417qs+B+fykyZn8NIxHqg+X
         FphCqPUQ6jlwNahtEdBHW7YRn8JDo5OUxaQSeFmkQ+a1T6xrF9plg3z3VXR9Rlrh/tBJ
         VvVGdeWrNiZ2xyH/EIgwZ8LrU0w6LNmhX0QESIx/CqFLr+ime3DIlBTkvQnh1P0Lbtbf
         5cA1ZEopnZrB5llABp047hRQ8I0YyF8tA1Spa/bhhs8VgSzrVgRgeQde/7f5G5RlwJ2t
         19YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0fji8Nu54ZhqBHvvYgDr+3hwosEUpxW6x/vEKV84Pk=;
        b=Vjld8B81eNKJzrvJYZZc/FvNdJNT37oCXaokQEJ/qiSUUAVARXo/0M0yI0wEyjAvUy
         F7HMZ+64PlanQ/ULPWmTb+KWUObYolNkeBi7iLUwlxL1honlYnatPTGcQnhNiESvfro8
         cgNm7PnsxSkWWcD1PYnIGROIkxgy2WyCT8xAF/c0KemYa1cG6d30EdiEfLOn8tHzqu9h
         sFngi854HtozpGgpUqyE7M9tz2MhCSRjMc9mss09/AIwBrBgGtLEPRs9LCwdo2/qHCd2
         4TInXm1eB3A5MtNZfO5/gEOTZ5bVu89vrKBKu5dKbF9LCtnCJW1oAvw4hxW1DTD4QbSK
         8vtA==
X-Gm-Message-State: AOAM532+5H84T3jxStWgEsm8pn94dj88tQmUq+RJggdT3a33EbX1ygYI
        VBOsmhY/mhSNSRrQqLufTk0=
X-Google-Smtp-Source: ABdhPJzsqmUYOtxkgpjJqXtaXnMb2+DfExa54Oup5JnqEb+chOJlTlEwzijLijF4Kkj18hqinJpF3g==
X-Received: by 2002:a05:620a:40c6:b0:69c:269b:65cd with SMTP id g6-20020a05620a40c600b0069c269b65cdmr11267725qko.429.1650423772237;
        Tue, 19 Apr 2022 20:02:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002f1fc230725sm1094460qta.31.2022.04.19.20.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:02:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: img-parallel-out: using pm_runtime_resume_and_get
Date:   Wed, 20 Apr 2022 03:02:46 +0000
Message-Id: <20220420030246.2575629-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/img/img-parallel-out.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index 800f247283cd..cd6a6a825741 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -162,11 +162,9 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	ret = pm_runtime_get_sync(prl->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(prl->dev);
+	ret = pm_runtime_resume_and_get(prl->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
 	reg = (reg & ~IMG_PRL_OUT_CTL_EDGE_MASK) | control_set;
-- 
2.25.1


