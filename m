Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9455DA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbiF1KrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiF1KrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:47:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EDE313A8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:47:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b2so3710815plx.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOIcgKg0TtpygR+M4l/a5Aie7Bx2vAFMNFWbFKFYQ8U=;
        b=GuvFAaNjrohDIewzt9xxIfAXValLDg3IzoAnYxQQMA6X6zm4KAWN+PuxIBqzsm5/SI
         mxV07tknmbPx8U/rDWAC363nkdVz+vHZYm4ufprrnfDdDpaIwSfb+QY8f8NgMrxOWgTM
         h3qOMjrpAVTUPm2jQNgSKNjQ+iMx5CZOvcgeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOIcgKg0TtpygR+M4l/a5Aie7Bx2vAFMNFWbFKFYQ8U=;
        b=EuHTzqT74nVuaAeQLp1zKnQ1NQnyWxMib6FyUMGESzNuqIjFDFCfpMWTUuzaHPfDAI
         PYD6qbSZAn08zy5TKm7hmQonIJUm8iaaZmNe7Zy+WEaq/qWFcltn8pt3SZvUktCdF+no
         1dr+gzHdoz249+dzZUiSvmj3Ml/9QbzXpgPNavQPHIoxOspgLisEx7w6znx4OPmwT3tu
         E8rgrP/pGGAByXbsoD68DuhAv5LTMeelC1vfrMxogpL8qJ7umKDAfaM9THfzkWKRJydy
         LfLtGess4AlMDdwAzxnZ+HxnSdoWfrIeXHHkKzHPoz2KISJ2i/AKI/y9l19A5MN6o392
         gzvw==
X-Gm-Message-State: AJIora/cNokADJ/x+czywkwAFSB+D/C6MSL/rXIsD5w2BuPVuejzV2uw
        oTQppzFYzqqRw8U2JZzy7PCfVTBRs6ecrg==
X-Google-Smtp-Source: AGRyM1sdnK8kNyQNyHtoepsQkJEghWZ/ol0iWg2u5H/YPdHl6rnzDJLPpw+uJbtuDgeIVjMH8gSCPw==
X-Received: by 2002:a17:90a:e7c2:b0:1ed:3a07:caa8 with SMTP id kb2-20020a17090ae7c200b001ed3a07caa8mr21070377pjb.234.1656413219420;
        Tue, 28 Jun 2022 03:46:59 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:eafc:4c4c:9d0a:651e])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001674d61c1c6sm8846377plb.272.2022.06.28.03.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:46:58 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>, Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: use pm_runtime_force_suspend(resume)
Date:   Tue, 28 Jun 2022 18:46:50 +0800
Message-Id: <20220628104650.2239191-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to check for IRQ or disable it in suspend.

Use pm_runtime_force_suspend(resume) to make sure anx7625 is powered off
correctly. Make the system suspend/resume and pm runtime suspend/resume
more consistant.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 33 ++---------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 3710fa9ee0acd..09688a1076037 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2542,38 +2542,9 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused anx7625_resume(struct device *dev)
-{
-	struct anx7625_data *ctx = dev_get_drvdata(dev);
-
-	if (!ctx->pdata.intp_irq)
-		return 0;
-
-	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
-		enable_irq(ctx->pdata.intp_irq);
-		anx7625_runtime_pm_resume(dev);
-	}
-
-	return 0;
-}
-
-static int __maybe_unused anx7625_suspend(struct device *dev)
-{
-	struct anx7625_data *ctx = dev_get_drvdata(dev);
-
-	if (!ctx->pdata.intp_irq)
-		return 0;
-
-	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
-		anx7625_runtime_pm_suspend(dev);
-		disable_irq(ctx->pdata.intp_irq);
-	}
-
-	return 0;
-}
-
 static const struct dev_pm_ops anx7625_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(anx7625_suspend, anx7625_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(anx7625_runtime_pm_suspend,
 			   anx7625_runtime_pm_resume, NULL)
 };
-- 
2.37.0.rc0.161.g10f37bed90-goog

