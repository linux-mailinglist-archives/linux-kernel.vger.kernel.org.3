Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C96464331
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbhK3Xas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345375AbhK3X1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D2C061746;
        Tue, 30 Nov 2021 15:24:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b40so57920013lfv.10;
        Tue, 30 Nov 2021 15:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzFtA16LetdYQr69hwWW6HmkTpjJj0vMycP3EfoabOc=;
        b=jPWy56i8ajzWNplFlLAI4CP8mtrEOsjcngEiiSzT3Rr6iup43Fj7T/HFsWpUj4DWQf
         flS2e5tRcFh2nZ/FU8F2HOK/1A/s5SdJNTIOl14o3oOs5q5eTHgCrn/FRKc9vkGW8lGb
         ij+u2lGRy8IxFh1/iyxNHQmO504XdVe3iprvmvMCp7wj/XvuAybUn3Dxs3377d0IYLRh
         n9jakiGgRmEajrgRlWkXGV83PmrNiZxgXG3u65QJJ6UrMistUuq/lycj54UK+cGEgpo+
         KwAJ9cYQixyU4MbpAIQtXtNFCD5FxbzGWM0lDq0qygihn8uvB4orazPDy3ImbmH9Asiz
         TTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzFtA16LetdYQr69hwWW6HmkTpjJj0vMycP3EfoabOc=;
        b=geJYU/9WdWPhGDf/3dmhLzpMiLA6P5iws7aF8V/WuI4L6uWrNBbQRz04jaUNpgPyYj
         9D40bBIksh32cJCVPJL2u+nrN524Sfj+gfftneIBU7BOWcp1w7omY6zYP3FhyV1SztO3
         nTcpztvv4ymCERe9XjYIQuwKvBy7uZraMMYQB30R2oMhYqNJTfHMfPn0sU+hP6dFm6qJ
         7f/5mpuF7HTVahkW5V6xLN2fP+NcB/BeLh5JD3MK2A3fUGra/ckgnb5xwCNS+5K7jJUa
         2LwAD7CcmWWc0xrN9r/hsazYesftYq50hUzzZtnzUROqyLrN6NTz6zoiVc+GaNCK88z0
         HyVQ==
X-Gm-Message-State: AOAM532hbbdIbx2FkNOVXv94ODe8VeHaVpiGDTN1RGksz6BPSz4YmUlF
        TvflXrP6NJ1nGE+H3qAANYA=
X-Google-Smtp-Source: ABdhPJz8ZvSN0BpYtwKaSYMEu2cE5LythDUC6fnDK89df6oq2plp9wZlTn6M8kyPx0QcggRLRXLt5w==
X-Received: by 2002:a05:6512:2350:: with SMTP id p16mr2261895lfu.482.1638314662205;
        Tue, 30 Nov 2021 15:24:22 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:21 -0800 (PST)
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
Subject: [PATCH v16 28/40] soc/tegra: fuse: Reset hardware
Date:   Wed,  1 Dec 2021 02:23:35 +0300
Message-Id: <20211130232347.950-29-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FUSE controller is enabled at a boot time. Reset it in order to put
hardware and clock into clean and disabled state.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 25 +++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h       |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f2151815db58..cc032729a143 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
@@ -243,6 +244,30 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		goto restore;
 	}
 
+	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
+	if (IS_ERR(fuse->rst)) {
+		err = PTR_ERR(fuse->rst);
+		dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
+			fuse->rst);
+		goto restore;
+	}
+
+	/*
+	 * FUSE clock is enabled at a boot time, hence this resume/suspend
+	 * disables the clock besides the h/w resetting.
+	 */
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
+		goto restore;
+
+	err = reset_control_reset(fuse->rst);
+	pm_runtime_put(&pdev->dev);
+
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to reset FUSE: %d\n", err);
+		goto restore;
+	}
+
 	/* release the early I/O memory mapping */
 	iounmap(base);
 
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index de58feba0435..1b719d85bd04 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -43,6 +43,7 @@ struct tegra_fuse {
 	void __iomem *base;
 	phys_addr_t phys;
 	struct clk *clk;
+	struct reset_control *rst;
 
 	u32 (*read_early)(struct tegra_fuse *fuse, unsigned int offset);
 	u32 (*read)(struct tegra_fuse *fuse, unsigned int offset);
-- 
2.33.1

