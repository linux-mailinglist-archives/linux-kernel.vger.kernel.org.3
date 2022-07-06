Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26005688BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiGFMxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiGFMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:53:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F4237EF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:53:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so11903476pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02sx8dmnjBV/TuA75YAbyzwEMk2jxyWLuGZcJUXA1mA=;
        b=X9gPzsTtEqyMRnO0Ze3pIsRss45disf2+3R39oFMVTCGIQYT5ISLaMeO4Gh8LRckRx
         OERTPNsDduJXlF7SJsWM6NOCPOLaRNPDFhuL1h/nJ9YD5qa9n21qbyoY8vZic5K1hDcl
         VxrOjj8xpT3Tn2zhuDO+XCcn7MNtsKGW5+rZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02sx8dmnjBV/TuA75YAbyzwEMk2jxyWLuGZcJUXA1mA=;
        b=IYTgASuo7obDesS6IrvGs05CXIvp65G3ZxhAqbkDuqtIZV95rjlcqX4Z032aDOeMdd
         qsPM+grFP2smXQ/4uckAQciDqmPnMMighkUna5NsVIarWjRVfgBm2SYqdlShS+4P4g1L
         fohW5mVsvQ5yBiyjU4HQBH/I3hGE4RkNPCGq5EUkTB/hvlzwT+izQ04aitCdtsPev8O4
         ZvBVuNg1ruYENh4jusuBXyE8JmxAmhphFrSoryCD+hehX8/MT4GhrncZ1JU6AqIur9UV
         9+Ep6uD40db4LO65URwEEBInrSOn+zbLD0v/8VPLx+hlM68PaaTgH9AzRhVAwLo7LZC8
         i4YA==
X-Gm-Message-State: AJIora/rpDnVesJCd7ysuqI6DS/h7cjjUeU0wP52Z+plCWeJ/mAjY8yV
        V03U1cU4Ya/208xLRvTif6ulvQ==
X-Google-Smtp-Source: AGRyM1tVtIQMvEuRrEN1V6YdOkUQGwBxQrSJYSlc5cAvGJXjazJWEXQKaWJoonujkv303bFau4bonQ==
X-Received: by 2002:a17:90a:1a42:b0:1ef:680b:8ecd with SMTP id 2-20020a17090a1a4200b001ef680b8ecdmr30544374pjl.88.1657111986992;
        Wed, 06 Jul 2022 05:53:06 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5300:b974:1680:1bd])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0016a6cd546d6sm25640127ple.251.2022.07.06.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:53:06 -0700 (PDT)
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
Subject: [PATCH v2 2/4] drm/bridge: anx7625: use pm_runtime_force_suspend(resume)
Date:   Wed,  6 Jul 2022 20:52:52 +0800
Message-Id: <20220706125254.2474095-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220706125254.2474095-1-hsinyi@chromium.org>
References: <20220706125254.2474095-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
more consistent.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Xin Ji <xji@analogixsemi.com>
---
v1->v2: Fix typo.
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 33 ++---------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index ab346d32d8735..fcf07a037c2c8 100644
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

