Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D0856055F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiF2QGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiF2QGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:06:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541162E2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:06:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d5so14515257plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egURh53ld+NhXDS1wdCdA08O6R9LPjRpDFkoMid42Z0=;
        b=OSUkiwyuskUf+Byr0SuVvncCH4Lzu8K/kheg/bLfzzOv9U5BElk+a7IkIR+OjNTcHM
         iXFdbBJNlc09zCigO4KRlLz54n0cFDGu0DzFnbh+XATA//Bv3VoM7/dkXOM8/xR0gOhD
         DIeg1AciRPbBxiRCRbWd/Lh2svnORZXpz5cto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egURh53ld+NhXDS1wdCdA08O6R9LPjRpDFkoMid42Z0=;
        b=IJ/xeaRXFmvfNNP8y22fqySLJi51AiPFN0G3gb01B6z3lyysGeKoaWsVYlu0djKauC
         n8pTE2aLXpgtZ2rd9PS9CCLeeY4qWa6i5LX4MJ0DPhBRyS4Cz1XhbnFEoEDIS0dhhsu1
         SYpcGNfB0YyEpenKTYEdirxYwqeHhYS944Bg2UB+C/ruX3kRd09R3AD+/EbatA66ydJc
         ju3UsdinmWkK336TgX/m1nn3urWTgKCgjL7gGvaxrt/NMhfWHb//Oj35PWr5j2fCSi3z
         CCOYjWPFKAZnCMeDJeh7mDOaoEu75gFCfyKPsTUt3Ta/0YtnP2uqnyepHxrfOZk9fRGh
         CiQw==
X-Gm-Message-State: AJIora8rML2KX4X7/OBbDMNy2aUFqQ5XwL0JQxvUpKopHfJztZrNFKBj
        jxs1s/OiXGe1FvmPvtnxHxWhgg==
X-Google-Smtp-Source: AGRyM1v0n9Yujom0ChKMec4x+DMXG77s3nGIWQJwoZbRjQyXCrugCj4jmNVrznO8yxMBPKzwSGF+LA==
X-Received: by 2002:a17:90b:1d09:b0:1ec:bb51:9396 with SMTP id on9-20020a17090b1d0900b001ecbb519396mr6573335pjb.192.1656518765408;
        Wed, 29 Jun 2022 09:06:05 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9841:721:7d8b:4502])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902e3d300b00163f8ddf160sm11495350ple.161.2022.06.29.09.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:06:04 -0700 (PDT)
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
Subject: [PATCH 2/4] drm/bridge: anx7625: Use pm_runtime_force_suspend(resume)
Date:   Thu, 30 Jun 2022 00:05:48 +0800
Message-Id: <20220629160550.433980-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629160550.433980-1-hsinyi@chromium.org>
References: <20220629160550.433980-1-hsinyi@chromium.org>
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
index f89e8151475f7..478f5af381c7d 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2504,38 +2504,9 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
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

