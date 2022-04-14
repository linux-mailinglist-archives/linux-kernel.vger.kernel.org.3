Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1A05008E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbiDNIzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241345AbiDNIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:55:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8A76623D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:52:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so4093602pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+75oGozFhysU8kD1Lg/rKFGSAHmgc1qYyotBmF08jM=;
        b=UPD8XVIWD4mPKPFPSRTZZw7rS5flMgBMcFYR/JI+sngKZx/Ni3zarN0PFke1o6Fu1L
         InBFy/wIn9tnObwcezs7Z/4Vje9aGXhfVgz2zcRDaz3XsN+ON/t/lKcSMaY7If6Ag1yJ
         QYHAGg3J9FoYCMs/l69Ds5moWeu6J7gBNh0slliAzvCo8dvJDuv0Nixw4CGGLOn9DH+l
         W6H/VXbHHQdH7PPkXEk30qQSp3wvuRWX2fJGLnmakDOkyH59oBSX83D/3gVuSZl+1ebS
         Mx2m8S4XPgLehczU2j9KgPQ73RGP98QmIo/+FBhv7qPg5NSG4Nl1FkSeElGaVsqS6G/s
         rPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+75oGozFhysU8kD1Lg/rKFGSAHmgc1qYyotBmF08jM=;
        b=aDP2qgerIvtNQKmQNUiuQi+kYt4ac/xZwTnf4/SFuZe8ZSUbIdi8G8QgGpVA2kOl3h
         UJ/X/dfvw7ORaJoJy+l5+lIKtkkwNVFMOlNlAgpueGLmm6u2SPMqkD2So4AM34ry/j78
         41NrmpFJutvojG+JjbnSkHbvd8Aws/Jw0QLQYnSJVXI5GvpMikrKKVoG25+RTfHlNd9O
         l3PuSBDwsJCDUis8R9gdmuatU14YrnkIbt8hAu9XfEp5y2USqPvTd2i3W3ma9ncz0ALT
         hrQ65vXKU0LDeQ3k7fmpyc+N177fLNxPa9zFxh3Ne41mHmpoK0NJ4md6NTOnh9ArHB9P
         JKHg==
X-Gm-Message-State: AOAM533Fynny6TzWFUvhSYGJH40F0qpuODoSvgTe/oi8IpdA+HDG1ORz
        QBcgRyptcfOdAldJ36zPogg=
X-Google-Smtp-Source: ABdhPJw49/iSTrK6F3IHxwDYuRMrTRAEGaa1SDYkT/crPMXWEUcOiZlpFWkHagaj+numhN1BJmbP2Q==
X-Received: by 2002:a17:90a:510e:b0:1cb:b1de:27a0 with SMTP id t14-20020a17090a510e00b001cbb1de27a0mr3229470pjh.196.1649926364403;
        Thu, 14 Apr 2022 01:52:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id qe15-20020a17090b4f8f00b001c6f4991cd4sm5216580pjb.45.2022.04.14.01.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:52:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     shengjiu.wang@gmail.com
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: fsl_sai: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Thu, 14 Apr 2022 08:52:39 +0000
Message-Id: <20220414085239.2541484-1-chi.minghao@zte.com.cn>
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
 sound/soc/fsl/fsl_sai.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4650a6931a94..a7930049a049 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1134,11 +1134,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
 		goto err_pm_get_sync;
-	}
 
 	/* Get sai version */
 	ret = fsl_sai_check_version(&pdev->dev);
-- 
2.25.1


