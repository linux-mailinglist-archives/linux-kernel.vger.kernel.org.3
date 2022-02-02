Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449AD4A7786
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbiBBSHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiBBSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:07:03 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4241CC061714;
        Wed,  2 Feb 2022 10:07:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jx6so249774ejb.0;
        Wed, 02 Feb 2022 10:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAIcuwwi2BP4NiFyHqKe0BCgP8mtwzjUa/ZfXGkPZks=;
        b=GOMfXIy6GygS0cMun5y2V4/XiJph+7Lvpo1R7S60UziS3zp3BmAGhWPdW6ZLs2Vly7
         nb9b0ERNumAQEbrKKCVwZXd4PdGpmJJkPw+z/QmzTgklWLU3FtdMaHkQeFSLZlY79nmt
         NthTUFUQM7YS9Dt1UhqNsnYSsZ4CJrJu5REHsKB1LugbyQ+r7FVtww/eVJvKsD/bE583
         d8KvEHhislw3WdAx6KBholYbaGHcrSfCkBEONVjQCsP5duEbidt+vOQqsQ9pJw0EVpIy
         AVM25riavAnLOWFIB8FAafNXQTpBAUAupLu9f/jIxYv8DICIwwsjxsRv9ZpKMF7t/L6K
         ob0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAIcuwwi2BP4NiFyHqKe0BCgP8mtwzjUa/ZfXGkPZks=;
        b=xJ7bfI2jusJvqIevL/8dyAbMmgA6Uxh8OFEl57Kne+wi+lHofcEjmeQOUZEm21kw8P
         4IQWAjlbHJxZi94xWIaPzPvNmgR5oSfixGoTBlDPMlSM80Bls70mr1D/DVWPtuZpQ/sI
         QP6mevR/gxobE2hvL3B/n689cxi+engM2E7vLEMqVb8/xR0yMDM3oAo2J9itTnt15aHp
         HgXzm5GGN7ifOdm5R2aZyEJ7wf3fD4/UavaAYuKnYueH8IBbsuQyBWM7bfaMpIb1LVEJ
         QMqP4tPnNP5e9NIy4FkTC9yVSyTtUXeE7580R7+dqWof+N5+YuXwi9M7efdX5+JtKGpv
         NBjA==
X-Gm-Message-State: AOAM533bSn3R+NnFUZvuiSnsb2DT/T5QD+a3/C9tdy+prZ+6VJ34fN6+
        d4k/5AqZbwH1W/j4W4PnX0c=
X-Google-Smtp-Source: ABdhPJxXPFfWWd175RQTh36iz0OTKrKqHNDt2PC8RAWyRPjuvciz6Sl9XGdZYPtCr7t3wd2eaW7Bvg==
X-Received: by 2002:a17:907:7286:: with SMTP id dt6mr26104656ejc.285.1643825221869;
        Wed, 02 Feb 2022 10:07:01 -0800 (PST)
Received: from localhost.localdomain (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.gmail.com with ESMTPSA id ee37sm3223005edb.106.2022.02.02.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:07:01 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, eugen.hristev@microchip.com,
        adrian.hunter@intel.com, nicolas.ferre@microchip.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 3/5] mmc: sdhci-omap: Use of_device_get_match_data() helper
Date:   Wed,  2 Feb 2022 19:06:46 +0100
Message-Id: <20220202180648.1252154-4-huobean@gmail.com>
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
 drivers/mmc/host/sdhci-omap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 64e27c2821f9..676e3cbbfc95 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1219,16 +1219,11 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_omap_host *omap_host;
 	struct mmc_host *mmc;
-	const struct of_device_id *match;
 	struct sdhci_omap_data *data;
 	const struct soc_device_attribute *soc;
 	struct resource *regs;
 
-	match = of_match_device(omap_sdhci_match, dev);
-	if (!match)
-		return -EINVAL;
-
-	data = (struct sdhci_omap_data *)match->data;
+	data = of_device_get_match_data(&pdev->dev);
 	if (!data) {
 		dev_err(dev, "no sdhci omap data\n");
 		return -EINVAL;
-- 
2.25.1

