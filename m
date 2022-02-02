Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AB4A7780
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346543AbiBBSHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbiBBSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:07:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E3FC06173B;
        Wed,  2 Feb 2022 10:07:04 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m11so251817edi.13;
        Wed, 02 Feb 2022 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdNoO+0JES8dypYccGmpRy+mfWGQ7BG4TFVZPkHwt0k=;
        b=qUTIybu3JdNyGhZcyTKiqhGmVbuXefceqr9jzgLMKZh47ybfHa7MHRtJx6EcHGutpe
         qzJG9facXuolXfaDZSPpPEMKaIY0rAbtjDV+iSRR3eGWGCi+tMKNmSq692TnkQWadU+n
         1XZzDAsfZJCPPkJ+qKL1YcZhpIHhLcVh8I99mILd1sOopogfJN1fmh5F1c1BMEjay9V5
         gbQGtK5gkDpuWfSvbBGzoZSIoEC42am9yvXLkWN2IMrcvOMJjhWSRGk1UX5zfI0u7JSq
         2ep3xKhrXQRlpG5WqUxtOePEbVTNzQsoZ1SSsHaspsy/A5o/OUVrjJL/DIOl7MyEAmud
         jkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdNoO+0JES8dypYccGmpRy+mfWGQ7BG4TFVZPkHwt0k=;
        b=LlrKH07w1Q+9K3P/vAQ7Zealvhi5sQcE45C0b8OC58aObmWtk8VwZiDDnDwPYVi74+
         WEabOyJmyNGM5wSSYSi+EEOlPyZ5pJUhYY2OgR/Dq26oisSCJKxYcZTeKrF/CofilAUG
         OgI0dLGO9VWZwLxWwDt4zOgYYturT8kVQjWXlTRN7cBiG16ihM3+w9jjPCep4cpH38zn
         TWHcq5v5J1jP3RgMBbI5uLBQCPhHfaWE35ImbjrvxHxQtvIkqJ7l9vbSdSf8sSooyM+1
         f1aAgJBBKUKq5K109217fqfnx2QkEhPhpsiPzdOGFvs+RxxCELHxuyhgMJ9pTkEWKfpD
         YuMw==
X-Gm-Message-State: AOAM531lbyCQ9EbFo2yyKHpFi14eGj8rMWdnd4Ok8PtdsUxFvycBDcWf
        DpHzKDOO3o2tNOjFIBYm+2k=
X-Google-Smtp-Source: ABdhPJw7Uing6mDjKEv7mKYBUgrEE/xCQOm1tXwNrv5PCY8iz1M3OafxhmqHvlUpfPdOUvaxoBU1ng==
X-Received: by 2002:a05:6402:430a:: with SMTP id m10mr31084761edc.67.1643825223423;
        Wed, 02 Feb 2022 10:07:03 -0800 (PST)
Received: from localhost.localdomain (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.gmail.com with ESMTPSA id ee37sm3223005edb.106.2022.02.02.10.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:07:03 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, eugen.hristev@microchip.com,
        adrian.hunter@intel.com, nicolas.ferre@microchip.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 5/5] mmc: davinci: Use of_device_get_match_data() helper
Date:   Wed,  2 Feb 2022 19:06:48 +0100
Message-Id: <20220202180648.1252154-6-huobean@gmail.com>
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
Use of_device_get_match_data() instead of of_match_device().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/davinci_mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 2a757c88f9d2..0cf646ec9a80 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1189,7 +1189,6 @@ static int mmc_davinci_parse_pdata(struct mmc_host *mmc)
 
 static int davinci_mmcsd_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct mmc_davinci_host *host = NULL;
 	struct mmc_host *mmc = NULL;
 	struct resource *r, *mem = NULL;
@@ -1235,9 +1234,8 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
-	match = of_match_device(davinci_mmc_dt_ids, &pdev->dev);
-	if (match) {
-		pdev->id_entry = match->data;
+	pdev->id_entry = of_device_get_match_data(&pdev->dev);
+	if (pdev->id_entry) {
 		ret = mmc_of_parse(mmc);
 		if (ret) {
 			dev_err_probe(&pdev->dev, ret,
-- 
2.25.1

