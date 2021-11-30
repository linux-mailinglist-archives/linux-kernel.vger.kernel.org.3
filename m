Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092AB464340
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhK3Xcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345309AbhK3X1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:34 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A7C06174A;
        Tue, 30 Nov 2021 15:24:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so58014827lfb.0;
        Tue, 30 Nov 2021 15:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5LZNzGJpLsApxqpURZGyur77JxFewe+cdR7kou+Iuc=;
        b=MT3M7qcQvUCN+etyhHm6SGYEk0wsAkakVbCCkN4LmUYWMlc8zEByKa6v6ei2JG+Rk6
         V2a9YfYSgIiCEMN2WmWuenkQ9Kai0ntIlVdClImsBJkKiFdcEV+KHo6YEecNDOpWsoON
         /ff7qTEryBQTwKT5k+5/YdXHPxIThNbdC8Si0ok3WTiqCisXXVoL4QCimpdEFz/MT9s/
         NfNQ/AYNRZullNONFibpO4nJ8znsagfElFiwB0gz0zNaFaK7+mhMNrHMaIA+KVHrqfLV
         tp2v9rQe0zD3/XEP7Jg8Th4xYQSUnD78jZk6j6DgfCB+AhjLBC6+SUw3Y1aV0xpGvIu9
         Jazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5LZNzGJpLsApxqpURZGyur77JxFewe+cdR7kou+Iuc=;
        b=0HlLjsju+3h6l3Sk5GZsq189FUDPKnB4vilf+gQTLYkIOBjrIFOoFVTKovRTaVfP+k
         m9fvlnazK5KJtCDMMziRXOon5N4Zhui15DvgScevkBPF9WbTCkgNWqj66kO4r3NUGSoM
         hp4e+PAOylRUvLLL1Ock3vk/zgLw3jcnZngMMmwY0wrmJVVUaUfblrM97SZx/OSWvitA
         QifQY8eCC9zocMoD809uf6/rGybN3SipXinCVh0+LjG4xkaXlbFUTmW+6dOYYmWaAkXE
         PmzbAeGxlUvjW2FqeHNN9ef2DHwYnzC5gzDK6+3rYRgHEA842DQDhL5zzHu769wPLiWq
         CThg==
X-Gm-Message-State: AOAM530qhuV/KirUYhN+u8L3FxccXb1HRJDjk2G2EuAoRtz1bWXayiJw
        NPrVQz0Nx8Jezc2RRDg7Xc4=
X-Google-Smtp-Source: ABdhPJyR8l7h/2KwKFk6RajKklSyPd7+Ig4dSGTAY3MmUXLu3/ZtsCMmMNhF60Ec91QzfRVXDHd3Tg==
X-Received: by 2002:a05:6512:138a:: with SMTP id p10mr2276184lfa.508.1638314650820;
        Tue, 30 Nov 2021 15:24:10 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:10 -0800 (PST)
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
Subject: [PATCH v16 16/40] drm/tegra: nvdec: Stop channel on suspend
Date:   Wed,  1 Dec 2021 02:23:23 +0300
Message-Id: <20211130232347.950-17-digetx@gmail.com>
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
 drivers/gpu/drm/tegra/nvdec.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 791bf1acf5f0..15f036e09e5c 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -113,9 +113,13 @@ static int nvdec_init(struct host1x_client *client)
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
@@ -125,7 +129,10 @@ static int nvdec_init(struct host1x_client *client)
 
 	return 0;
 
-free_syncpt:
+disable_rpm:
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 free_channel:
 	host1x_channel_put(nvdec->channel);
@@ -150,10 +157,15 @@ static int nvdec_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(nvdec->channel);
 	host1x_client_iommu_detach(client);
 
+	nvdec->channel = NULL;
+
 	if (client->group) {
 		dma_unmap_single(nvdec->dev, nvdec->falcon.firmware.phys,
 				 nvdec->falcon.firmware.size, DMA_TO_DEVICE);
@@ -268,6 +280,8 @@ static __maybe_unused int nvdec_runtime_suspend(struct device *dev)
 {
 	struct nvdec *nvdec = dev_get_drvdata(dev);
 
+	host1x_channel_stop(nvdec->channel);
+
 	clk_disable_unprepare(nvdec->clk);
 
 	return 0;
@@ -412,10 +426,6 @@ static int nvdec_probe(struct platform_device *pdev)
 		goto exit_falcon;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
-	pm_runtime_use_autosuspend(&pdev->dev);
-
 	return 0;
 
 exit_falcon:
@@ -436,11 +446,6 @@ static int nvdec_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pm_runtime_enabled(&pdev->dev))
-		pm_runtime_disable(&pdev->dev);
-	else
-		nvdec_runtime_suspend(&pdev->dev);
-
 	falcon_exit(&nvdec->falcon);
 
 	return 0;
@@ -448,6 +453,8 @@ static int nvdec_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops nvdec_pm_ops = {
 	SET_RUNTIME_PM_OPS(nvdec_runtime_suspend, nvdec_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_nvdec_driver = {
-- 
2.33.1

