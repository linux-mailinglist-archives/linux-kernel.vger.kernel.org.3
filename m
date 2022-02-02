Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7F94A7782
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbiBBSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346454AbiBBSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:07:04 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC0FC061714;
        Wed,  2 Feb 2022 10:07:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id p7so263541edc.12;
        Wed, 02 Feb 2022 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUeG6YFMvh+7CqOP293WygA3xbDCcF5WbzMm/DaxvYw=;
        b=XUzmneYFMhqpzZi3ETL/Vrr5oBL7rNypn7pnXPyZUZ1SCx6NSSVKfevT3JkfluefFO
         u/vVrFcllGa2Xn4O2qm9bibBvhmu30dJKvkOBLR7pZ4IfNNeAQZLG6reXGHIVqAB6AG0
         yyv3Hw7ez9KNdsV+QNvvrL9mMAH8ZW1cpkLC1b4EyT3nMsiA6ZVqGy0rjA+3uchtAtWJ
         FWZ2VSS0anw2VB61zNz4xWf1R38Ag0CxvxH/dND/ydvlK+8uFv/QtL2d6iOMc4R8b7px
         V00y3g0/JIV6yx2subRHIQSmWssFxEMdgxc/IDW5vq2vB7/rG3Uydb1qzlUdnt9MminJ
         ag2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUeG6YFMvh+7CqOP293WygA3xbDCcF5WbzMm/DaxvYw=;
        b=3mg14P2Ffn93404VZEsgJFbzVhmrc9YMPS91OiRnacZjp8Av81KUmM5CHW/a3W+0qC
         nQ7EdhNfj/1ZTzWiAmp2rtI0rtKdR0LUXyAwDj0BXZhFzxgl8f6HRnqlpcgXR44Fys1E
         psow3sYVfHwamB0wZ9ropO3Fl/Ckoj51gnf1Hc4WpPI5eYxeh/asRcukNcU2djA3jeOC
         7qOwA/qMmtriZYHGSZVTxLguYScTtmdXaRET1C5wefhIFRmyz0IKXfsyS0UzCtODnVHd
         0lWwaOCn9vxdOBfvPD/nytM+bD7UUign9zSOrEVik4bq6s5MfblXL7Fi713b+Flyqpyn
         7bSA==
X-Gm-Message-State: AOAM533xMa1bv8yL6pYSf5esdGGKLUqfd1+VRYG9sFIwyyVyIGNHhWqc
        rtsaA0hsTB3G/kOchpOsqPo=
X-Google-Smtp-Source: ABdhPJz5DEC1wAoBtex4LT9IElo2CBGFpVXnoBC624ImThH9vwbdgqzTG8DSFj6Dl//QGBtQcBz6fA==
X-Received: by 2002:a05:6402:448c:: with SMTP id er12mr31464145edb.137.1643825222813;
        Wed, 02 Feb 2022 10:07:02 -0800 (PST)
Received: from localhost.localdomain (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.gmail.com with ESMTPSA id ee37sm3223005edb.106.2022.02.02.10.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:07:02 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, eugen.hristev@microchip.com,
        adrian.hunter@intel.com, nicolas.ferre@microchip.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 4/5] mmc: sdhci-of-at91: Use of_device_get_match_data() helper
Date:   Wed,  2 Feb 2022 19:06:47 +0100
Message-Id: <20220202180648.1252154-5-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202180648.1252154-1-huobean@gmail.com>
References: <20220202180648.1252154-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Only the device data is needed, not the entire struct of_device_id.
Use of_device_get_match_data() instead of open coding of_match_device().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index d1a1c548c515..10fb4cb2c731 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -308,17 +308,15 @@ static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
 
 static int sdhci_at91_probe(struct platform_device *pdev)
 {
-	const struct of_device_id	*match;
 	const struct sdhci_at91_soc_data	*soc_data;
 	struct sdhci_host		*host;
 	struct sdhci_pltfm_host		*pltfm_host;
 	struct sdhci_at91_priv		*priv;
 	int				ret;
 
-	match = of_match_device(sdhci_at91_dt_match, &pdev->dev);
-	if (!match)
+	soc_data = of_device_get_match_data(&pdev->dev);
+	if (!soc_data)
 		return -EINVAL;
-	soc_data = match->data;
 
 	host = sdhci_pltfm_init(pdev, soc_data->pdata, sizeof(*priv));
 	if (IS_ERR(host))
-- 
2.25.1

