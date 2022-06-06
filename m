Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8488B53F173
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiFFVNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFFVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:13:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CE18FD5B;
        Mon,  6 Jun 2022 14:13:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q21so31392491ejm.1;
        Mon, 06 Jun 2022 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vrjMAvCFt6wUI3BDJ99m6gry4K6PxML5aBtTWp7pZQ=;
        b=JjYSoRegWg4TZgb8oMQZIZJSQWGIKj9z2gM5kWLF70V1Ib9I32PpN4BWerHyWCrw5l
         HvB34rGAglkE+wPkkNQab9kQ2pJrPEfJWtJDZUJ1KBouMzrWehKMd1FW8niFVKONtVfI
         g8AU4ecym7aMzL+hZZnsf9cHrn/sZB/GQzUuKLBn6HuBaL+iDsAEJlQDHkHpJZXUX6DD
         449ChyQIf7H4J5vEq0bzWxuAkbYfh+b2mtm2xu6bpHJvtbS1Ac2IchV5YbnwjZcQ8JBx
         psWXQsq67vFX3OebEtCBqQkMpm5deM6VD7q/RQgrd4xR56BCBk+k27cAQ7XNpg83GQdl
         b6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vrjMAvCFt6wUI3BDJ99m6gry4K6PxML5aBtTWp7pZQ=;
        b=DDxyYOz2BbiiJQIUXo2TuDoanv+OjQGUaDvQLL5OJQ3cFOG7F4o6QbRIbG3yOnEOK1
         DDCWzlOohpqsrCKlWJSQ3POfMmrFxsWR0Gc3czjpdJr9Z/huDx0Qaq4wGZhgdsTGLKGt
         rQ7YUHjmCVAmCio9ZzmncFK1TKd50YmZ11GpWcOlUtlKqfmJCKsGMqr5Q7m88bSTVKSs
         Epk32KZIH4FV2UtbjoGWee+8g9dfqnTmM9EbOMjT7aksQ0daz4hNdn4amhWcZVYzVmuS
         2hI2ljHUoE3/0PNtkxjF7Gh6gCWwmyrV9x+tbMBLqp01NTTuugs+O5msRdVc1aOl2cYK
         DSnQ==
X-Gm-Message-State: AOAM533ec8w1IDN/G9RivJ7Iqu5sy4XYDvctOYCUNrxgpqYQkbz+fRz8
        JB6s7fm1lxS9SaFfdJg+5ZY=
X-Google-Smtp-Source: ABdhPJzu0VYk2HyNbCEmKotVrY7I0kwRusHR3DozhQRm/s4pEzZeZM0+mkyCZ1uSwCq8FooJhmyt9w==
X-Received: by 2002:a17:907:961a:b0:6ff:b74:7e67 with SMTP id gb26-20020a170907961a00b006ff0b747e67mr23436126ejc.424.1654550015210;
        Mon, 06 Jun 2022 14:13:35 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id kq15-20020a170906abcf00b0070cac22060esm5144284ejb.95.2022.06.06.14.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:13:34 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] drm/msm: Fix double pm_runtime_disable() call
Date:   Mon,  6 Jun 2022 23:13:05 +0200
Message-Id: <20220606211305.189585-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Following commit 17e822f7591f ("drm/msm: fix unbalanced
pm_runtime_enable in adreno_gpu_{init, cleanup}"), any call to
adreno_unbind() will disable runtime PM twice, as indicated by the call
trees below:

  adreno_unbind()
   -> pm_runtime_force_suspend()
   -> pm_runtime_disable()

  adreno_unbind()
   -> gpu->funcs->destroy() [= aNxx_destroy()]
   -> adreno_gpu_cleanup()
   -> pm_runtime_disable()

Note that pm_runtime_force_suspend() is called right before
gpu->funcs->destroy() and both functions are called unconditionally.

With recent addition of the eDP AUX bus code, this problem manifests
itself when the eDP panel cannot be found yet and probing is deferred.
On the first probe attempt, we disable runtime PM twice as described
above. This then causes any later probe attempt to fail with

  [drm:adreno_load_gpu [msm]] *ERROR* Couldn't power up the GPU: -13

preventing the driver from loading.

As there seem to be scenarios where the aNxx_destroy() functions are not
called from adreno_unbind(), simply removing pm_runtime_disable() from
inside adreno_unbind() does not seem to be the proper fix. This is what
commit 17e822f7591f ("drm/msm: fix unbalanced pm_runtime_enable in
adreno_gpu_{init, cleanup}") intended to fix. Therefore, instead check
whether runtime PM is still enabled, and only disable it in that case.

Fixes: 17e822f7591f ("drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init, cleanup}")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 4e665c806a14..f944b69e2a25 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1057,7 +1057,8 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
-	pm_runtime_disable(&priv->gpu_pdev->dev);
+	if (pm_runtime_enabled(&priv->gpu_pdev->dev))
+		pm_runtime_disable(&priv->gpu_pdev->dev);
 
 	msm_gpu_cleanup(&adreno_gpu->base);
 }
-- 
2.36.1

