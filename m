Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F7549C83E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiAZLE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiAZLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:04:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E228C06161C;
        Wed, 26 Jan 2022 03:04:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c9so22058851plg.11;
        Wed, 26 Jan 2022 03:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=RR4ouPM813OFDy+c0edjOK1JRioWIwLVRFDpfla460c=;
        b=HP+tuwnNz6Y8+d3OMO5kJD2QNVUOgiTLtaVUi8wf1JlUByCQWmDWDbDr/kNgfWoBhb
         7QYoWHRB9esF44iy+btd+d6ZfWligwEPii61Qclc4Vpjnhjo8wWqsLmwToWWi/Z7KaBl
         jfKTrU0vecIWJesPNgZBvHRaU+dKM3DgjbfDg7eFmkWUxizbfMcFH9eJRjSbBBMJzsDN
         WLLuq3MBzCD1SGEJvpT+pawxdNmNOF52nPcZbinDLvNtEnwTF3Jf9hUaV0V60PzZ05dZ
         ZjfHms8JFXWTiwo7GZTFH4MmCGHkh3HxYxokd2jZRZe2JJ2bxdrWsvXHbqFWgepKJTAa
         /Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RR4ouPM813OFDy+c0edjOK1JRioWIwLVRFDpfla460c=;
        b=h7lkzufyQx8eY1BtAcJUHdUbQ5F0XPj3qPuv6zHgqrSHjrBoS7flOhDNHttmPPMOdH
         OU0paSXJp9I9nn84Lt4/kF7L3j1EmT2PWl347++qsyhTr1TO3weg/9qqcowGqygGkPDK
         +gqTeQddAD7+KTjWYqKW8orcJbTjGchPvPSoZDSt4DjQPXZWvlwNU0A0nuEgA7O9DAob
         L67kcHzya5o4yIK57EtYOfllw59AiNVCw5e7jmghwvOYDmhxmmSYav7ci5fmDd+TEmcj
         6/C+ZdJcvPCeBjaCFqcwCTZ4j4K6vkgOtClSTtdbRbnynMRKTBnSiqTC1irl9gvjyKPV
         OcOA==
X-Gm-Message-State: AOAM530whIcYHrdunW2UfnAt5Y9vZn1n4nombAf9mpX4eNyLem+6G+Lm
        otBCXhCuyKlAR2WknNF6iuc=
X-Google-Smtp-Source: ABdhPJx2FwKdI5cKtqHUQdZWmt2+i2FAlaBuvr89STNb/9Amb3meY+F5YYosOYWzHq/p02vC+1Ny/w==
X-Received: by 2002:a17:90b:3106:: with SMTP id gc6mr8081129pjb.77.1643195094691;
        Wed, 26 Jan 2022 03:04:54 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id s12sm1706080pfd.112.2022.01.26.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:04:54 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] spi: meson-spicc: add IRQ check in meson_spicc_probe
Date:   Wed, 26 Jan 2022 11:04:47 +0000
Message-Id: <20220126110447.24549-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check misses checking for  platform_get_irq()'s call and may passes
the negative error codes to devm_request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling devm_request_irq() with invalid IRQ #s.

Fixes: 454fa271bc4e ("spi: Add Meson SPICC driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/spi/spi-meson-spicc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index c208efeadd18..0bc7daa7afc8 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -693,6 +693,11 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	writel_relaxed(0, spicc->base + SPICC_INTREG);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto out_master;
+	}
+
 	ret = devm_request_irq(&pdev->dev, irq, meson_spicc_irq,
 			       0, NULL, spicc);
 	if (ret) {
-- 
2.17.1

