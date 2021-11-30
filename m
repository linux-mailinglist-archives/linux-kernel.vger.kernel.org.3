Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3DF46430D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbhK3X3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345389AbhK3X1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:40 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E82C061746;
        Tue, 30 Nov 2021 15:24:20 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u22so44298408lju.7;
        Tue, 30 Nov 2021 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eME+Ghk5yYp+vqFqDcay3Mk1GyWQJky7Yrr0vWPMFpg=;
        b=Hp/kcTE3+FG+iHC4vDD1K9H3BwGkmxkvbqO5yGK+uA2zxJhFyynAVgeKawKy0FXPY1
         U2ueDUgbXAIFcHq1rkd9w12smB96KNZeeIwaCRid/bM4t6xF/Oaqw5wOlsa2f+3YqsUz
         d3hnWVBLdWb27bzK5B/QRHi1w7kanSQyMpT9xHvaNFOwycehr1tRLmoDmbu+ePNcJJID
         mUjOm07Bd+YGVVq44gm11XYjjSCeMD4JSpjsASm3wyq5opIER0BCz3mgpM3iFyhsbCTB
         RsEKsDGSjidvcWQLIasP4M47RFyDNcm7j0YJh2TpvNorPa6MVTxirVoj+AoD/dnb3w42
         ZNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eME+Ghk5yYp+vqFqDcay3Mk1GyWQJky7Yrr0vWPMFpg=;
        b=HA+8DL++R2DBiptGtuNHBBApcioxgEVd0hbrHGZYGWfRAhIwsph0mTgNMvBIIama9W
         ouC3ATcWN8OPFlW5EKAiO+bGe31lDatXTEcr7e47k64vSE5sS4euXYD5T4swDIBqgIdJ
         1uCK2jMUHxYaNb8/OFKesf0G0MnCq0MW6Lr2g7Wgy3lVo82D9dNoI3rAOfwX86qOMg2v
         0Hqgq6uM4r0Gqo472E1CLMjDI9tFz1rNTfOEz5+3EFrQzwFqJTKztG+2cDAfArcEJMIW
         Psd5DFTJwWKK3/QxN7m/BQuBItfgs4/7hIdKm2VmMfzs5Ro3gqM+isiZCNGDQvpV60A5
         iAwQ==
X-Gm-Message-State: AOAM531K3ZYmbjr10MJAjOvrDxzTDSDS5mNqPXCDgv2TKWxhoVmoP/Y5
        WT9AkbCBeMp+mP/ZCd5kJLQ=
X-Google-Smtp-Source: ABdhPJwZJi8XFTq1MWTLjHF/OqzoNlH8yU6buUDXoCpqkTXi8DvjyqXvCF8bIUywGvL0zdAGH4x+Gw==
X-Received: by 2002:a2e:781a:: with SMTP id t26mr1975988ljc.90.1638314658388;
        Tue, 30 Nov 2021 15:24:18 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:18 -0800 (PST)
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
Subject: [PATCH v16 24/40] spi: tegra20-slink: Add OPP support
Date:   Wed,  1 Dec 2021 02:23:31 +0300
Message-Id: <20211130232347.950-25-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now SPI driver must use OPP
API for driving the controller's clock rate because OPP API takes care
of reconfiguring the domain's performance state in accordance to the
rate. Add OPP support to the driver.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index e8204e155484..2a03739a0c60 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -18,12 +18,15 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 
+#include <soc/tegra/common.h>
+
 #define SLINK_COMMAND			0x000
 #define SLINK_BIT_LENGTH(x)		(((x) & 0x1f) << 0)
 #define SLINK_WORD_SIZE(x)		(((x) & 0x1f) << 5)
@@ -680,7 +683,7 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 	bits_per_word = t->bits_per_word;
 	speed = t->speed_hz;
 	if (speed != tspi->cur_speed) {
-		clk_set_rate(tspi->clk, speed * 4);
+		dev_pm_opp_set_rate(tspi->dev, speed * 4);
 		tspi->cur_speed = speed;
 	}
 
@@ -1066,6 +1069,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
+	ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (ret)
+		goto exit_free_master;
+
 	tspi->max_buf_size = SLINK_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
-- 
2.33.1

