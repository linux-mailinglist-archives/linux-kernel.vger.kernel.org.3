Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1871946434F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbhK3Xdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbhK3X1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD4C061748;
        Tue, 30 Nov 2021 15:24:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c32so57986736lfv.4;
        Tue, 30 Nov 2021 15:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQ5jO8IglZlUMaRNPcN9PUVJW42EUXyxCQcfBM+SAVk=;
        b=dvSJo7xzm1eJfh0VhPIQ/ualcGjwUWikpagcRiIdb/9jusqbHGcZerkLtz1ZR/PH+I
         8hLAVLcT3AidmYxrQBDRtN7EJc6oTN8OHngaw7f9SOcu69vky6Th3Sw2lkuDoktXtKOA
         lJpRgMAph56ewr+hUE0DsKQ5Ton6qQpe89Fqt71e7gjM3+eLU633Opqf+Jg4t6F3b4h+
         b1hJ+nKbZ0p3rUID87bFVhOwzcsbJn1TFrRyT8d0tRJNKTM0wNrp9183PmTGcokb4CX9
         QVaT6hSE9qArRqYZp2gNMntxcMuARDZ9FmYe+YmvkONRNAtJEfk7A7mI9PB/x45b9cIC
         GSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQ5jO8IglZlUMaRNPcN9PUVJW42EUXyxCQcfBM+SAVk=;
        b=fUVBTELzmq89WADmeVESUgfuxBILHPVFFtOrbTiussaqHVP5I4y3411CFyZhEGCX1Q
         jdmLZLVXUAH7OYWizIC9hsCcMRr7hIuyL8mOCiVq6Lu/U4IrGpgO2OibDNOlzaZxcMk6
         diEXiCIksnsGrVf6r53aWb5ktThULzC/sPnqTJwtE66XKFv6gB13xWjBtq56sT5JCyib
         2rVxKi8NVbKF5OinFuCsi/stF3U/kK686HTPR7OdAkTRlYdXrjw3iJN59V82KwDUa3VO
         i7pGHyB2IKphWRYUssdPITTak56/w6YDe9trcuIsEwOOmhgkPj6cP+m8HGxkGj5f/FYL
         ovSw==
X-Gm-Message-State: AOAM533GTGvNP308lhZL81HDCiJYoVhy2umprH6UHbaGyftfbVNeMz2x
        x+94GpLlDOzgnNIb8CY7BQY=
X-Google-Smtp-Source: ABdhPJyTRdX5wiYTmVoFjF4P8647/2ZqIvFbX6o0+UgUnk0xxvSu3+zbffENKNhFeInBCsH5zfNFjg==
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr2248990lfu.505.1638314649852;
        Tue, 30 Nov 2021 15:24:09 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:09 -0800 (PST)
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
Subject: [PATCH v16 15/40] drm/tegra: vic: Stop channel on suspend
Date:   Wed,  1 Dec 2021 02:23:22 +0300
Message-Id: <20211130232347.950-16-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CDMA must be stopped before hardware is suspended. Add channel stopping
to RPM suspend callback. Add system level suspend-resume callbacks.

Runtime PM initialization is moved to host1x client init phase because
RPM callback now uses host1x channel that is available only when host1x
client is registered.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/vic.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index b58e2b99f81a..9622ca96c539 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -151,9 +151,13 @@ static int vic_init(struct host1x_client *client)
 		goto free_channel;
 	}
 
+	pm_runtime_enable(client->dev);
+	pm_runtime_use_autosuspend(client->dev);
+	pm_runtime_set_autosuspend_delay(client->dev, 500);
+
 	err = tegra_drm_register_client(tegra, drm);
 	if (err < 0)
-		goto free_syncpt;
+		goto disable_rpm;
 
 	/*
 	 * Inherit the DMA parameters (such as maximum segment size) from the
@@ -163,7 +167,10 @@ static int vic_init(struct host1x_client *client)
 
 	return 0;
 
-free_syncpt:
+disable_rpm:
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 free_channel:
 	host1x_channel_put(vic->channel);
@@ -188,10 +195,15 @@ static int vic_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(vic->channel);
 	host1x_client_iommu_detach(client);
 
+	vic->channel = NULL;
+
 	if (client->group) {
 		dma_unmap_single(vic->dev, vic->falcon.firmware.phys,
 				 vic->falcon.firmware.size, DMA_TO_DEVICE);
@@ -315,6 +327,8 @@ static int vic_runtime_suspend(struct device *dev)
 	struct vic *vic = dev_get_drvdata(dev);
 	int err;
 
+	host1x_channel_stop(vic->channel);
+
 	err = reset_control_assert(vic->rst);
 	if (err < 0)
 		return err;
@@ -482,19 +496,8 @@ static int vic_probe(struct platform_device *pdev)
 		goto exit_falcon;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		err = vic_runtime_resume(&pdev->dev);
-		if (err < 0)
-			goto unregister_client;
-	}
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
-	pm_runtime_use_autosuspend(&pdev->dev);
-
 	return 0;
 
-unregister_client:
-	host1x_client_unregister(&vic->client.base);
 exit_falcon:
 	falcon_exit(&vic->falcon);
 
@@ -513,11 +516,6 @@ static int vic_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pm_runtime_enabled(&pdev->dev))
-		pm_runtime_disable(&pdev->dev);
-	else
-		vic_runtime_suspend(&pdev->dev);
-
 	falcon_exit(&vic->falcon);
 
 	return 0;
@@ -525,6 +523,8 @@ static int vic_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops vic_pm_ops = {
 	SET_RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_vic_driver = {
-- 
2.33.1

