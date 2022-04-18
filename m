Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F29504F33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiDRLFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiDRLFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:05:44 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51991A055
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:03:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hf18so9296699qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uTmuIN0GlNXXY/94zNDu7yDIPOZyDJN9QkEI2mlu4M=;
        b=ML7YQLQYLo1Dj4jfwiljD/Rekx6c5rxBTwLIXSQ1h7gbRcHk1gxsZFi9XqkkN39V7i
         UVSFPbjACp274XdCF9D58o7ZAJmS4fUC91E2sQcZYNzYizNSKAjEsqw19vSrABzPoStF
         BEG0uJOuipXZGI34TgRY8mrJWdYvwTwiYk/a4gCXq64OtbzMAXP+3m0dUpGlkb5A0343
         ovHk0PYf92JZkmaqg8oAdgICygU8OiXaLfkybwvUln+TaIzN/8QUE/k4t3K1zd4d8P5M
         +FVTOI+7Xi1NwWp+FK+/i0ZSZhvPJR9AFN2BciI1v/ih0HM1oY/FQQBysuoJcNPjK2a7
         c60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uTmuIN0GlNXXY/94zNDu7yDIPOZyDJN9QkEI2mlu4M=;
        b=N7/NhylseAQ/+cMxvAD+Qqg0aKpUyELmlTM6jpnKtMy1XTg8Kx3wOXufUuEcrc7f/5
         Ji4KfAQNCIliulyJO+knYgJteKO6sWuC01u7nRnYN5RKHYvT6UBRnGMlOapAtHPPpdHL
         0dNOjH9WPqa5RdXGzTIK9NcuZfI6xEGdJ9Cb4bNt09BU8k3Xcesm2+1ViLh52HMpLkGS
         HJbpOBSmpDtCu0wIWvm/vB2kWC7ISiyLAmzk0fhk8mNrdrU0gPeFetcuYwN4sdlASIyS
         oNFhWJfiHr26DufY34INw+Gzc1YJPbytkIQioFOkV4ckO6lg+HnOF9V6m6+lv2Bj0OEw
         GYuQ==
X-Gm-Message-State: AOAM531J797eXXI7UpJhIGy5pubVXOeMvFVkc4HCuih3Lq83HKbxcarU
        qx18k0WRntD4wL2iCNqP0lEq+A1v2ws=
X-Google-Smtp-Source: ABdhPJxKhXQVaAvyNvVCH2UEO9ZuO7fvvlhPS2H/BF6eBn2Ammys6oZGbOC4QM/WYjW10au931GC+Q==
X-Received: by 2002:a05:622a:4ce:b0:2e1:e18f:5b33 with SMTP id q14-20020a05622a04ce00b002e1e18f5b33mr6579274qtx.565.1650279784936;
        Mon, 18 Apr 2022 04:03:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w3-20020a376203000000b0069e9a4568f9sm1588004qkb.125.2022.04.18.04.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:03:04 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: codecs: wm8962: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 11:02:59 +0000
Message-Id: <20220418110259.2559144-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/codecs/wm8962.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2c41d31956aa..f679cf0ddbc1 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2896,9 +2896,8 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 
 	reinit_completion(&wm8962->fll_lock);
 
-	ret = pm_runtime_get_sync(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(component->dev);
 		dev_err(component->dev, "Failed to resume device: %d\n", ret);
 		return ret;
 	}
@@ -3030,9 +3029,8 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 	unsigned int active;
 	int reg, ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
 		dev_err(dev, "Failed to resume: %d\n", ret);
 		return IRQ_NONE;
 	}
-- 
2.25.1


