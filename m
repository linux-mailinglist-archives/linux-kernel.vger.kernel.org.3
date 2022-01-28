Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F67D49FDDC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350021AbiA1QSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350009AbiA1QSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:18:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D911C061714;
        Fri, 28 Jan 2022 08:18:45 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so6341680plh.13;
        Fri, 28 Jan 2022 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=JUl3tU81ulG2o/FS7WdDZJtA165EJwTPBOexiNkfwFU=;
        b=aFLEoXUq0kkWqnHccTrMalUzfNeqHWPRtKD3x01go2djzsUMaLTe1qcHivabLgI2pi
         a4f4WzotPROqJsKS3Ap9bGH0yp5Sb85dgtjnxP9+I0O1M8CH9TDsfCR2HSRuEFDCrieX
         U7QprzOcz4ZOs9qxOHCyUbF6sHw7vMarnh5Rmw/mPfvD/3u+2q/sfK9+X6BStsPz0EI7
         Q81skbYbqM3XvmPZI6oax/jG1dg7kR9FfepNEU6rTVfPhT42rqyf/woSmtdtaMTGGhR4
         sOrfeXW4qgTW/29i8G6/LIjYixzlBBp6JaUAUEy1ew2w9jOhvZD4uLmvjxA2C7vMR8Ex
         XmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JUl3tU81ulG2o/FS7WdDZJtA165EJwTPBOexiNkfwFU=;
        b=omJ9Ct8rzX4kg80SbW0GecGLP4w7iU0bU9P71I5HnYN4NsEW2Zyirt2748hcJnOi8c
         8HBoVZsu11k2ijO6DArgRAdOImhG0ud9zbO4jHdW7vF8p+xAhAtbfK2rv1n8uRcAW45N
         XzsrOUVGmDl2NfAwE5eDpQzcHsbiDwsg2kszVNkZ3AxyGp3HsrsKxSRrGhJ2PGPuAead
         Veg+UWM3GG584sy7Ukgs2JONessng7A38tymyYqHmgmJbi9ydfdLzkhwgTiYqk1P6rUF
         dCTlf+Jbfcoe6gtexvzF08piqUOaCdyVQoG+vOVTM754QuD95kgxICB2doIiqY9A5JUb
         DduQ==
X-Gm-Message-State: AOAM532MlrsJD93eP+/XC5skNYKUJABMdv4947qxCt6jhpPtZ773pb9X
        1h+UdUPfqiv5BQ1ulfYzJVw=
X-Google-Smtp-Source: ABdhPJypd5B36o1OwVLweiiIvQ6ZtZRuVu9tzEV/NalXnHQor+PmG46qGCgj/2wKC39g1t02O1kS2Q==
X-Received: by 2002:a17:902:db01:: with SMTP id m1mr9544640plx.126.1643386724684;
        Fri, 28 Jan 2022 08:18:44 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id t14sm2933199pjd.6.2022.01.28.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:18:44 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] spi: tegra20: Fix missing IRQ check in tegra_slink_probe
Date:   Fri, 28 Jan 2022 16:18:07 +0000
Message-Id: <20220128161807.10145-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling request_threaded_irq() with invalid IRQ #s.

Fixes: e4bb903fda0e ("spi: tegra20-slink: Improve runtime PM usage")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- fix wrong func name in commit message.
---
 drivers/spi/spi-tegra20-slink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 2a03739a0c60..0eea35882777 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1100,6 +1100,11 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 
 	spi_irq = platform_get_irq(pdev, 0);
+	if (spi_irq < 0) {
+		dev_err(&pdev->dev, "Unable to request IRQ: %d\n", ret);
+		ret = spi_irq;
+		goto exit_pm_put;
+	}
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
 				   tegra_slink_isr_thread, IRQF_ONESHOT,
-- 
2.17.1

