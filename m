Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC3B49FE8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350388AbiA1RAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245576AbiA1RAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:00:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9783C061714;
        Fri, 28 Jan 2022 09:00:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g20so5664516pgn.10;
        Fri, 28 Jan 2022 09:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+C9vX6xCDqvkQ70Y80+HH81TrwKxhCYxQC092GOuFQc=;
        b=QBncfqMh62y6OfBYS1O3hAMenwW5HA6+1y1SzVQ8DuwIlu81PHahMSu4lYyNz92mqw
         VCF7g1LAZaC1G/HAkQZ4nlqC38oR1+hl9oZCpz0EZu0pyV810arjgJuBtUeVgjReBUfA
         Suk1P9W7f+nF9D6eDIpEd8ePa5w5+54TPqPLIZJx6x1xDwDkJsUxOFa2WeL35XZ8FdKE
         Vi59dpo1/2lfCuBKe6zmlb+X+TQ8Cmm1gnnQdjfbHDoJKHVBcUY/dzKqoFAOGq6E+1Rp
         jLEwgtp1hN1j5oJGw/+gWFoDsQoa1B6DLDgeYQ39Xad30AuOTG2oZP27qUl6AoSFBX6g
         uAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+C9vX6xCDqvkQ70Y80+HH81TrwKxhCYxQC092GOuFQc=;
        b=tcMA3LvsLl3MIHCCJCeCMkFycGhsmBfhawl6cUJaGz4cnUqYWDRHMaPgQAgVesuzko
         FgjmekiW6MXPjzJcD8RirW5GTastb0BIj2t+ICRSspt2oaR/HWrIMM/rA+wxEFP+Cyq/
         7OnQdWY5H9Yys+j1dFS4zUos4hMb4PaIElqjcw6fuNKT35i2Qsq9trGkxcOYGvlzEsX/
         u2BEphPK5AgF9yvf2appfq68sfjmMdxSsqy1u58eD9vdax2E8MFNYvdLisa6PAtyPEpw
         nMVqSKm8aBfF/YBJ488UZCdAnjdT/YkHGi9AEDHaUGaU+w1z1rcjPF6ehMW6ZWWC6pRy
         6pHg==
X-Gm-Message-State: AOAM532k2rq6iWR8FhFTuzepJvjbteWH2TSW3wv7meG10t1qMkv1KuJx
        dR71GzVuk3XB4V8NWSFtLEbPcRgXBj7SMhBseL4=
X-Google-Smtp-Source: ABdhPJyB6CItxjnOMvt+FRSBG50hnskVKlJqSjGYtvtldH72NRe7B+pKu96pHf8ZvXRDUBG3VfvtFA==
X-Received: by 2002:a63:e704:: with SMTP id b4mr7235174pgi.315.1643389202302;
        Fri, 28 Jan 2022 09:00:02 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id o21sm22261791pgl.19.2022.01.28.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:00:02 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] spi: tegra210-quad: Fix missin IRQ check in tegra_qspi_probe
Date:   Fri, 28 Jan 2022 16:59:56 +0000
Message-Id: <20220128165956.27821-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling request_threaded_irq() with invalid IRQ #s.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/spi/spi-tegra210-quad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index ce1bdb4767ea..cb00ac2fc7d8 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1240,6 +1240,8 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
 	tqspi->phys = r->start;
 	qspi_irq = platform_get_irq(pdev, 0);
+	if (qspi_irq < 0)
+		return qspi_irq;
 	tqspi->irq = qspi_irq;
 
 	tqspi->clk = devm_clk_get(&pdev->dev, "qspi");
-- 
2.17.1

