Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2346433F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbhK3Xca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345317AbhK3X1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF05C061759;
        Tue, 30 Nov 2021 15:24:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c32so57986971lfv.4;
        Tue, 30 Nov 2021 15:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pvBnCjRebH1Ho4jqA86XCWq31CQHA17So2RdhwVkZw=;
        b=Ujwd6YKYpLhBzckFt5g4Krs4pTlirowAGoPYNPDf2o0fAysHloUiO0p6ao600ck4Fn
         Eoq4mpEscmsbun0AE1qLckBsCiX3Q3czjW00JP73Ov9jr+qjzQk1Cx337pO4kFUnng2C
         yZT+jrNRxnbB45JqN3l50+x1ZmfH4diH9rDbmgwIwZduOd9Hv0r6cmkLxIQR7c5EBQVC
         4mlD0YyYYaY1/BJqfazXMUGnXXei0kGGeZElpOBy92GOV39EK9EqJ0mo8sXuWmhsECCL
         W8W4sx3icrCtGZOpwQ1WfgyycKFpimkYYlkS2v0Irgzv9GlLGy7fesEStra6TOg94Z2/
         M1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pvBnCjRebH1Ho4jqA86XCWq31CQHA17So2RdhwVkZw=;
        b=gSm2UMtNB7/HGR8v6YuE3dXap9FKobRuwr5zgFjat55y1XT6aJXBOPef4PrxOkqu6Q
         Asnd6eO0rjlOsS4+MXQP6v/LLKHzVoz2KAzmQhsSswhIcuYtQ/QtDiPSNMHJq1Fca9ek
         ske0g/ZVWWn+WqcufoZBLi6g1GyREBJVDMlR1JtYH58ftSuU8DNngJzXZkZM4+HFAgzM
         on5rWRcXeO0j+vGnGRL5ZXDU64AShBlw2xfxQRKgI5/CMXIesWsP7Ss4hQ36YYa64ioA
         hulpkqLZxwEiAqxMmCrp+bLgLPh0pzvuOtGaq9yhjDyIFV934BKW6l14PsVSG9ty2SmK
         kndA==
X-Gm-Message-State: AOAM531hXbJdLUMAH/2JT4Y3Vs7SfACbIR4otcZYLLZeyYCItOvDS/jy
        wxbKVozcRWk0/ZHzrWj8Icc=
X-Google-Smtp-Source: ABdhPJxx+yLQZbPYt275snVuRgprmFVFBjIS0xZ25/qA4BhyemaOWc0LSucq5zi71yLYtB2iU/YNHQ==
X-Received: by 2002:ac2:4c52:: with SMTP id o18mr2248096lfk.372.1638314652854;
        Tue, 30 Nov 2021 15:24:12 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:12 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 18/40] drm/tegra: Consolidate runtime PM management of older UAPI codepath
Date:   Wed,  1 Dec 2021 02:23:25 +0300
Message-Id: <20211130232347.950-19-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move runtime PM management of older UAPI code paths into the common place.
This removes boilerplate code from client drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/drm.c   | 11 ++++++++++-
 drivers/gpu/drm/tegra/gr2d.c  | 10 +---------
 drivers/gpu/drm/tegra/gr3d.c  | 10 +---------
 drivers/gpu/drm/tegra/nvdec.c | 14 +-------------
 drivers/gpu/drm/tegra/vic.c   | 12 +-----------
 5 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 2e7da2a7505d..dc04ce329be3 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -10,6 +10,7 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic.h>
@@ -116,6 +117,7 @@ static int tegra_drm_open(struct drm_device *drm, struct drm_file *filp)
 static void tegra_drm_context_free(struct tegra_drm_context *context)
 {
 	context->client->ops->close_channel(context);
+	pm_runtime_put(context->client->base.dev);
 	kfree(context);
 }
 
@@ -427,13 +429,20 @@ static int tegra_client_open(struct tegra_drm_file *fpriv,
 {
 	int err;
 
+	err = pm_runtime_resume_and_get(client->base.dev);
+	if (err)
+		return err;
+
 	err = client->ops->open_channel(client, context);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put(client->base.dev);
 		return err;
+	}
 
 	err = idr_alloc(&fpriv->legacy_contexts, context, 1, 0, GFP_KERNEL);
 	if (err < 0) {
 		client->ops->close_channel(context);
+		pm_runtime_put(client->base.dev);
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 2382def93923..e3bb4c99ed39 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -127,17 +127,10 @@ static int gr2d_open_channel(struct tegra_drm_client *client,
 			     struct tegra_drm_context *context)
 {
 	struct gr2d *gr2d = to_gr2d(client);
-	int err;
-
-	err = pm_runtime_resume_and_get(client->base.dev);
-	if (err)
-		return err;
 
 	context->channel = host1x_channel_get(gr2d->channel);
-	if (!context->channel) {
-		pm_runtime_put(client->base.dev);
+	if (!context->channel)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -145,7 +138,6 @@ static int gr2d_open_channel(struct tegra_drm_client *client,
 static void gr2d_close_channel(struct tegra_drm_context *context)
 {
 	host1x_channel_put(context->channel);
-	pm_runtime_put(context->client->base.dev);
 }
 
 static int gr2d_is_addr_reg(struct device *dev, u32 class, u32 offset)
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 032d71365494..a1fd3113ea96 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -136,17 +136,10 @@ static int gr3d_open_channel(struct tegra_drm_client *client,
 			     struct tegra_drm_context *context)
 {
 	struct gr3d *gr3d = to_gr3d(client);
-	int err;
-
-	err = pm_runtime_resume_and_get(client->base.dev);
-	if (err)
-		return err;
 
 	context->channel = host1x_channel_get(gr3d->channel);
-	if (!context->channel) {
-		pm_runtime_put(client->base.dev);
+	if (!context->channel)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -154,7 +147,6 @@ static int gr3d_open_channel(struct tegra_drm_client *client,
 static void gr3d_close_channel(struct tegra_drm_context *context)
 {
 	host1x_channel_put(context->channel);
-	pm_runtime_put(context->client->base.dev);
 }
 
 static int gr3d_is_addr_reg(struct device *dev, u32 class, u32 offset)
diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 15f036e09e5c..79e1e88203cf 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -291,29 +291,17 @@ static int nvdec_open_channel(struct tegra_drm_client *client,
 			    struct tegra_drm_context *context)
 {
 	struct nvdec *nvdec = to_nvdec(client);
-	int err;
-
-	err = pm_runtime_get_sync(nvdec->dev);
-	if (err < 0) {
-		pm_runtime_put(nvdec->dev);
-		return err;
-	}
 
 	context->channel = host1x_channel_get(nvdec->channel);
-	if (!context->channel) {
-		pm_runtime_put(nvdec->dev);
+	if (!context->channel)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
 
 static void nvdec_close_channel(struct tegra_drm_context *context)
 {
-	struct nvdec *nvdec = to_nvdec(context->client);
-
 	host1x_channel_put(context->channel);
-	pm_runtime_put(nvdec->dev);
 }
 
 static const struct tegra_drm_client_ops nvdec_ops = {
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 9622ca96c539..7886740bcbf2 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -344,27 +344,17 @@ static int vic_open_channel(struct tegra_drm_client *client,
 			    struct tegra_drm_context *context)
 {
 	struct vic *vic = to_vic(client);
-	int err;
-
-	err = pm_runtime_resume_and_get(vic->dev);
-	if (err < 0)
-		return err;
 
 	context->channel = host1x_channel_get(vic->channel);
-	if (!context->channel) {
-		pm_runtime_put(vic->dev);
+	if (!context->channel)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
 
 static void vic_close_channel(struct tegra_drm_context *context)
 {
-	struct vic *vic = to_vic(context->client);
-
 	host1x_channel_put(context->channel);
-	pm_runtime_put(vic->dev);
 }
 
 static const struct tegra_drm_client_ops vic_ops = {
-- 
2.33.1

