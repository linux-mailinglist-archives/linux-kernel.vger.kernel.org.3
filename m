Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADA4A7779
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiBBSHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbiBBSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:07:03 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A33C061714;
        Wed,  2 Feb 2022 10:07:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ah7so147719ejc.4;
        Wed, 02 Feb 2022 10:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ip+D+4jKDZ9eZzccWWkC2tZZAMJIHmVnZ4DotqyL+9Q=;
        b=WvZavXM5BasA5y4AJ64ENlaYbO06iiyfkI2ndwUeanWSXSaI/IHkkZ/0SXLKZgi4Zc
         bvRw5BReLIZohLrhhXCE4RnC48twGved0UieEha5mY3rwMV8b5lw3yp48SzGMcl+eCL+
         NS9AQFdOZK8oqlNHmX4+GyyfdY0+uvDgMZPZmGZ+ifk5SjDhPrELZUmpJVXQVlCDrnYl
         oe3GsurbvcjvJ6CP1C+iFRnjTQx2jFWgW6NBMzuF30mNBF6w3PvlNlqCtujotjkEFY+/
         MxI/GkJv5nxGVPfsNKQIVoOraFynObswwfKu/kql6detF7KoK4NsNSI7IK9AYEtBeWKB
         /erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ip+D+4jKDZ9eZzccWWkC2tZZAMJIHmVnZ4DotqyL+9Q=;
        b=8LXtSuYmehVofxe9nMe4F+xH+tEtsxHQAjQQeHBhPzR0I5BK6Zyeuc934D4WoQT82F
         CmC50NvRyYCtxRzMHr+U9HfJfQL5+KF8NtNMOZOeRR38kCc+vKMjCDHdKLPrxwcaG14A
         u2Z5CAPYwRqi0JaaMquojy+F4xN+wGsnysAVUFFJCj1KEkkp1qrADiCMUpN+Gh8lnPI1
         AfpNs0EmrJ0ivYuIfkiewmIZ+yjpKbdIK9sjyK+0qcODacyY/Az5WdBqw17/pV36KuKK
         P9Q7Mhqzn4qhHqJ78gstmrS++U9asP/FhTVCrkkhDkz6r2H61qx4fNXOQTMnRnufNFAD
         s0sg==
X-Gm-Message-State: AOAM532uX18Ka1XEXH5oFJtj1A4vYakpy4x+bR1Ke87GATlW8+0pGbOl
        Kv97SHTg/chhF9ItOWHwfaw=
X-Google-Smtp-Source: ABdhPJwsA+A/ne87WAL/7wGX88dCMjg5hbjYx4j317efSNdmO77fmmWzw9Rc2xNXIwoPHgKRzmgDsw==
X-Received: by 2002:a17:907:6d17:: with SMTP id sa23mr26004476ejc.164.1643825221082;
        Wed, 02 Feb 2022 10:07:01 -0800 (PST)
Received: from localhost.localdomain (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.gmail.com with ESMTPSA id ee37sm3223005edb.106.2022.02.02.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:07:00 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, eugen.hristev@microchip.com,
        adrian.hunter@intel.com, nicolas.ferre@microchip.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 2/5] mmc: sdhci-tegra: Use of_device_get_match_data() helper
Date:   Wed,  2 Feb 2022 19:06:45 +0100
Message-Id: <20220202180648.1252154-3-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202180648.1252154-1-huobean@gmail.com>
References: <20220202180648.1252154-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Only the device data is needed,not the whole struct of_device_id.
Use of_device_get_match_data() instead of open coding of of_match_device().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/sdhci-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 35ebba067e87..0c9f778ea860 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1618,7 +1618,6 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	const struct sdhci_tegra_soc_data *soc_data;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
@@ -1626,10 +1625,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int rc;
 
-	match = of_match_device(sdhci_tegra_dt_match, &pdev->dev);
-	if (!match)
+	soc_data = of_device_get_match_data(&pdev->dev);
+	if (!soc_data)
 		return -EINVAL;
-	soc_data = match->data;
 
 	host = sdhci_pltfm_init(pdev, soc_data->pdata, sizeof(*tegra_host));
 	if (IS_ERR(host))
-- 
2.25.1

