Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACA49FE71
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350341AbiA1Qwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350319AbiA1Qwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:52:44 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2EC061714;
        Fri, 28 Jan 2022 08:52:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id k17so6562276plk.0;
        Fri, 28 Jan 2022 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BTwHUa1RWCsQXFr28TUnMkGh0jWJXQC2xD9hGrZO8SM=;
        b=qHcbaqTXTTWI+hpQpFpkoHjFxR9YTcdZu8PAdYe63XWywHBRFMMh8ZJeJcUpPU6a9l
         ukrgFjyBBqtbVe/c7wb3kL7laYKWOuHBIAqtWOhJWHx8QRKkYyrlxUVBCf4e1TeV+FVK
         xSdNlVad8yxkZzjIv9wQjqSPy30AVykprdUihJ/uXx/AiEf/B5dpS5n7U2xp/Z3GQT/Q
         T7y3wLRN8VKN5Rnti3AwbssqfNvFOewdsLecPNt7m6E3VhrwWrQgon6iJrL8yVeDDyF2
         6A4juq0Uq7vhAZHnSUP2Hg6781iaQCpvM7c8Y4SZyevc3H8wvorBuQI7I6lXVeySby5i
         2GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BTwHUa1RWCsQXFr28TUnMkGh0jWJXQC2xD9hGrZO8SM=;
        b=GkJkMb4NUQDgu8Esj0wK1oA3KlhTVmIGiH4WmH+SsZppAVJzKXjX2wDtA+s78BiyJA
         e+xO99X+I1BR3Aitsq3givWppt9wIj7CDKH5nzxtW5ZZ4Z8N8Nbf9E0PKfBLrJBIa9im
         T6V8RfwfBp1QmQqNUVDhC6ByajVkVpUJYUQUqiTom7ylASdfKZO3C81fP2ctbUxV2luW
         qJ1uY9LD2G5h4Gr1/wfghFRPsK/itED0UubmUPKYh3Oiy4tfkZ2alYZmfBiOfC0SMkXO
         fvsa5TmxM1s+6Y/TD79ExKGlcSYHxuYfz2KYpZV7bFBuRyDQi+NSHs7bfUOxTlURQwkR
         sktQ==
X-Gm-Message-State: AOAM530m/bo7dd+H/wytsVFWYaVsfxPLkNKcDQl32UP+0frEeRZUfRk4
        9gqhTd7a2yOvqeNxR+QXijtl+8iT3ksce9SaW7U=
X-Google-Smtp-Source: ABdhPJwtjxg2rwlV8T8wjqiA81JrSYaZVYeKbshSSl/7neoZEMYuj1M5w4AKdET9sA/iyQQ+U4JPKg==
X-Received: by 2002:a17:90b:4d82:: with SMTP id oj2mr20734075pjb.170.1643388764018;
        Fri, 28 Jan 2022 08:52:44 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w8sm4975178pfu.128.2022.01.28.08.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:52:43 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] spi: tegra114: Add missing IRQ check in tegra_spi_probe
Date:   Fri, 28 Jan 2022 16:52:38 +0000
Message-Id: <20220128165238.25615-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling request_threaded_irq() with invalid IRQ #s.

Fixes: f333a331adfa ("spi/tegra114: add spi driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/spi/spi-tegra114.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e9de1d958bbd..8f345247a8c3 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1352,6 +1352,10 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tspi->phys = r->start;
 
 	spi_irq = platform_get_irq(pdev, 0);
+	if (spi_irq < 0) {
+		ret = spi_irq;
+		goto exit_free_master;
+	}
 	tspi->irq = spi_irq;
 
 	tspi->clk = devm_clk_get(&pdev->dev, "spi");
-- 
2.17.1

