Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DBA4FD88C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiDLJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389004AbiDLJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA325132B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:30:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id md4so9466028pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m+EBqN3UPFUGLYVFLyAS2kc4ocqBW5MswCAjPd97TUw=;
        b=Bguj7CwrjTc+mzk+TmB7JVFoPyy0Zskev01NAMeOClCzjpw2E1k0tA1zrwPWhRhZYh
         8MxY/6opBxkk5Cb81qAM+dgfsdS/yu/xmJntl8ipYL+X6CYZL5nZYM4ob0ElVhk/spAo
         w0KsetW8iDqNEbwwyi3/I/y+s+75Vel4sYcox7oKIuFBWC7xIB72GjJ2KVsMY9joDV74
         e5HGMB3Thh/AHmZmAeBUntojUpjX9wxCLnru9Wa56l1wzN7avN+EAlLlCCMfhA/kCzb1
         GAO4g8VZO+eFrbmYO4t/SMgdj1KfOVEThMrxSUjoR1GlAFTkOYlFrQkW8vHAO4qXlpct
         jdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m+EBqN3UPFUGLYVFLyAS2kc4ocqBW5MswCAjPd97TUw=;
        b=cn2VzEO/1j+IcL+hKyE14yVsRFy3FtobTgC6pSzz//mMMdOd8wVFo5/JF+qIwVP51V
         kz7NTxdSxZ9X8+ZqUa51us9UwHfthpd88qk5mdSHpWXagfkJ8bJYlKyv9aFMVcP5Dl86
         LitfBPY4LknFd8Wi3zPJNf2EUa98cs4sK48e2+vLOi9hftqnJpSWhDQSQLWVfcljRgzN
         Ru2UW1f2xJ1jiHj+T8Owv0ltnvymAhbhc4iztvQ3btCH3pW9Qq3H0cRgx6m7260kiPE+
         2esGHT+y+X+EXHP3K4giyyq9wTT4Xx/5dJBH85tAjUy4MZelGsBNnzg3vaUfZOoDHBsg
         9+Sw==
X-Gm-Message-State: AOAM530FewiRwTACosrBgvntIU2Y9Qep4O+gdqZ7vwM0XYP00YSHlxDa
        dof4Z4A/Rhve8PKv79xx4TYe9+BQG20=
X-Google-Smtp-Source: ABdhPJwJPW0ts18fTByd2sl+p9939cGGiOvxLr5m0ZbLLv7Y4tadnT8ZE6+LYBT85nwWVa/BpG9kkg==
X-Received: by 2002:a17:90b:3e8c:b0:1c7:3001:f359 with SMTP id rj12-20020a17090b3e8c00b001c73001f359mr3699846pjb.179.1649752208998;
        Tue, 12 Apr 2022 01:30:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b00505fa4c7ba6sm1654089pfo.35.2022.04.12.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:30:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     shengjiu.wang@gmail.com
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: fsl: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 12 Apr 2022 08:30:00 +0000
Message-Id: <20220412083000.2532711-1-chi.minghao@zte.com.cn>
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
 sound/soc/fsl/fsl_esai.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index ed444e8f1d6b..1a2bdf8e76f0 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -1050,11 +1050,9 @@ static int fsl_esai_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
 		goto err_pm_get_sync;
-	}
 
 	ret = fsl_esai_hw_init(esai_priv);
 	if (ret)
-- 
2.25.1

