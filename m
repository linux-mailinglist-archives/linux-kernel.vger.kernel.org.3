Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8480E50696E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350887AbiDSLKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346610AbiDSLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:10:08 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796C2AC49
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:07:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b68so8344960qkc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLm0olCcsH1PqiLNhih1I6coZ5sjLUN64Q3yF02wEzs=;
        b=PSQBQufQk2Bz8JcA9FwJJnEAxb0jhkWZncWJxOvMU/8os0VWmKxPVpu7ekk2yCbmig
         F8M0n76lyKXF4vaRwovvTsh9F7MT8ixs5vnBQEbvkFHBC6ih0QDhFvOXbk4w3IVjGrkW
         f4GO2voFORmG59CzaPPIPg3+1oyaqulK6LXqRiPORAwkJ/XMJKh5VHnDkFQE+M6W7l2W
         39BnRaXCpqrJbXHJRpjr8gmDCvFtqGlG3uth4+KSzOPCI5rGJr+OASWbaFRSWF/afkEk
         cJhQqrhYYL/bF5g0pv7zEFmJvlLM/BflWFWj8Wjdiy9nSWBbCxi6RK7KjUCdVjfTdWAL
         t8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLm0olCcsH1PqiLNhih1I6coZ5sjLUN64Q3yF02wEzs=;
        b=G/INWZ6wKq3VsyPTWvhGDgUg2w9fE8zYpHF78DmJRB/qU0LeirlL3K4tuXaiB/yvRQ
         kbB40mBdrZprHQjDfpDZlWAq6shhaLdbcJC2URrSbu8pfu5dRKwS69teOrjzB2SZ1iRk
         RVV3wEg/ix9Cfl+nHoXxaPZTLAjIvKPEB7yrFb85XrqfNbyeltTuNz8nSUGUfBhAeKts
         0uW+ldromLacWRy57P3yjhtClSTL1xXGx65yd0ENROqRsxd8mDm7DY3YdADO1gHixdNX
         7vJfbZcuxIWf+mNMuFuR/C/wFmwEXeCUe8z05oXwK72ISpSB670l0wzaFFiI3EPQOY61
         wz7A==
X-Gm-Message-State: AOAM532CtcbR2IN6ORTvqyX5HrrYmwJPKWuRS+Vkymbu2uhGh3s/oxAQ
        GyUPahOX+MCQegGCi/kO/249SAGG1Dc=
X-Google-Smtp-Source: ABdhPJxsgEYEL6TpaTURvRKsl8jgBFGSvrzsRlM0QgUA2u1c/3EhXptk4RALE0ivrn6GfVzU89SpZw==
X-Received: by 2002:a05:620a:2681:b0:67e:933e:54b6 with SMTP id c1-20020a05620a268100b0067e933e54b6mr9348878qkp.428.1650366444421;
        Tue, 19 Apr 2022 04:07:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b2-20020ac87fc2000000b002f11f6dd5cdsm9316456qtk.23.2022.04.19.04.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:07:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: img-spdif-in: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 19 Apr 2022 11:07:18 +0000
Message-Id: <20220419110718.2574674-1-chi.minghao@zte.com.cn>
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
 sound/soc/img/img-spdif-in.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/img/img-spdif-in.c b/sound/soc/img/img-spdif-in.c
index 95914d0612fe..a79d1ccaeec0 100644
--- a/sound/soc/img/img-spdif-in.c
+++ b/sound/soc/img/img-spdif-in.c
@@ -749,11 +749,9 @@ static int img_spdif_in_probe(struct platform_device *pdev)
 		if (ret)
 			goto err_pm_disable;
 	}
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
 		goto err_suspend;
-	}
 
 	rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
 	if (IS_ERR(rst)) {
-- 
2.25.1


