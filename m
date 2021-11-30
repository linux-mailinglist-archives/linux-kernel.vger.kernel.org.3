Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE194642D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbhK3X20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345250AbhK3X13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:29 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D14C061756;
        Tue, 30 Nov 2021 15:24:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id p8so30795383ljo.5;
        Tue, 30 Nov 2021 15:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUPMWYY4B4RjKlltUXgnFtV9hhuqy47aEg3MTgDplAQ=;
        b=IQ3EtdM0jdKUmytJHIAa8UHQuvKg3GFTWTgffBbQ6VIdxz7Mp1JidKJf6JoivVWwvM
         2hJfTQ0PkunPptgLCBBlK2XBNvwqHlkxbaIRzkPJyV8FlxCjsZQwZlCun0IHlPn1rJLr
         dwlBtOq3xQsKFzcnIIJ4OCHZ1bYMeBhtowdj9k1OY7wr/hXF3Fly/QvCi6VAP8t6B+WG
         Zy8PigW8k8pp/aMH0P4d92xjr1ptFRZX1a2ZpJJiVlmZFCUU4fptcv/2hIFl2xRWxngY
         8TpztzKnhecVI9QhRr1Dgf5zXfJjWu4OTP9efC8mIXL3qh6Xev/zG/eG38ulsXuOPXJ+
         //eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUPMWYY4B4RjKlltUXgnFtV9hhuqy47aEg3MTgDplAQ=;
        b=OSCwy5FJMTsYvFC8Jl/eR/tDKIuTdZuhxERBNude8ZayjyYDFRavUExHy0WoSY0P9V
         D4HmY0CU9z3aYVUsFF4KOBATbCR0wcAhwQaGLt+gyqna6tvGrOKBsRuGKxhWvBAP0v6B
         cN/E+vxV+elvpkezUDL1E3B9+4v4DXLObTyiVwXwCNzlLCxEAbHyQhmIKjfXVD52zU/d
         1fKxil8cYJgTjLTjBy8wHXgbQCTurIvpzvhgcBPMdmrqV5n1NEQpzMcFcTObgkcs6HFV
         +Y9TUiRwKmcf0/qzNVsWbE3o4diWwPqW4H+ZY75AKPF0OIleyaK6OTvZNOW6+0QVEuem
         gn3A==
X-Gm-Message-State: AOAM530bFCFZnx8IDxqqx7OpJshJRtnceJ88+j5gxbm6yanq7Se/3Bzn
        P4WCRXtl85yrmfdsCtj8h44=
X-Google-Smtp-Source: ABdhPJy1x4JUGPw6jSGGVQPIy/5wvOS7f5XNpYbhYwejSd6jeed3qTaCBAhQIIqpTx20RCDGKcrleg==
X-Received: by 2002:a2e:b7d2:: with SMTP id p18mr2055862ljo.104.1638314646770;
        Tue, 30 Nov 2021 15:24:06 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:06 -0800 (PST)
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
Subject: [PATCH v16 12/40] drm/tegra: hdmi: Add OPP support
Date:   Wed,  1 Dec 2021 02:23:19 +0300
Message-Id: <20211130232347.950-13-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now HDMI driver must use
OPP API for driving the controller's clock rate because OPP API takes
care of reconfiguring the domain's performance state based on HDMI clock
rate. Add OPP support to the HDMI driver.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/hdmi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index e5d2a4026028..9a87d351a828 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -11,10 +11,13 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
@@ -1195,7 +1198,7 @@ static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder)
 	h_back_porch = mode->htotal - mode->hsync_end;
 	h_front_porch = mode->hsync_start - mode->hdisplay;
 
-	err = clk_set_rate(hdmi->clk, hdmi->pixel_clock);
+	err = dev_pm_opp_set_rate(hdmi->dev, hdmi->pixel_clock);
 	if (err < 0) {
 		dev_err(hdmi->dev, "failed to set HDMI clock frequency: %d\n",
 			err);
@@ -1732,7 +1735,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, hdmi);
-	pm_runtime_enable(&pdev->dev);
+
+	err = devm_pm_runtime_enable(&pdev->dev);
+	if (err)
+		return err;
+
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		return err;
 
 	INIT_LIST_HEAD(&hdmi->client.list);
 	hdmi->client.ops = &hdmi_client_ops;
@@ -1753,8 +1763,6 @@ static int tegra_hdmi_remove(struct platform_device *pdev)
 	struct tegra_hdmi *hdmi = platform_get_drvdata(pdev);
 	int err;
 
-	pm_runtime_disable(&pdev->dev);
-
 	err = host1x_client_unregister(&hdmi->client);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to unregister host1x client: %d\n",
-- 
2.33.1

