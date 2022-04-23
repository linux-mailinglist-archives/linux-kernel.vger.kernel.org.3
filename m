Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E966F50CDEB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 00:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiDWWTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 18:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiDWWTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 18:19:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4E14DEAA;
        Sat, 23 Apr 2022 15:16:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so22735766ejd.9;
        Sat, 23 Apr 2022 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUchkhWvkEdTq0frz8pj3bluHZsr2d70PH8hnHJ4qQE=;
        b=pIR+fGp4CoBhD71wEothWHCI3q8bux9vPYD9xiKAVLynsPNi2U7WW44Iea0uOJjVwl
         kx/wRp8bDOZ+OHMc0VSp8M3hOY89/Dbb8Gr+GQ3G+2nXKGsDa2/4FshSgxk1N63IOPrK
         YDyVKdM2cTF1usMdnndU1VezA0ViJy7ARYYt0d4RtofpUxdBxBxU+ic9lGDZAUwdOu0S
         c16tEJzCyFSMLiowBc8Pk2zh/ySOmfJQh2cztQgVMQRoMyRovmDRHEBZrDLRREue1Yj5
         vvbgACIIcL3yTTCJSLrJbBZ5+b06h1jXq+d6sArkrjrsqWXrXb5rvxcfi3LaUJJw0pwM
         ULSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUchkhWvkEdTq0frz8pj3bluHZsr2d70PH8hnHJ4qQE=;
        b=BKwgjYOgbZB0fuKs45ejNRU7C2o5tBu8oNGxqkCkegqpz9lJXJ5WY4yO1GdGivHEbr
         2l6H5qtVtZaD9AAgl8my3dPV8LXy3Dthcnn4V1mxCLkGwyu6UV8MSVQHXlE1DcCwRzGK
         2ITbnxSbiTMA0rWYytAITHhzOVpF78nxKAIJgQjHT5mFuynunHAWpf4lq0RGSz9VgyB5
         l3LiAezcVQexDztNAiTb7dU1P56qrVLMcnyIcBQ5ZE2r2a6bzciw/pGsuSHfqDmrjUar
         RFn4rJNJnRuM4L/uWybXusZoIgCQQpAJkOfNcvn76h8Y5RQDAtFlrQayNCs2iBhp9vKi
         9WKQ==
X-Gm-Message-State: AOAM533rqmXe//1xDy0ewzslOKqio2wqDsC9rgxL5qbH5w1GjKTJBYiE
        U5fbES8T4FHVXC+Y3omDuvq5DJt3CVC7Zw==
X-Google-Smtp-Source: ABdhPJzoZs+jikSWzpDyWjVfhyKV/vsg4M3aq9tJEtl8OBYl0wk8FuSfrjaG4fy2yRx42jUVs1VsuA==
X-Received: by 2002:a17:906:6a0d:b0:6e8:c927:663 with SMTP id qw13-20020a1709066a0d00b006e8c9270663mr9953431ejc.394.1650752193821;
        Sat, 23 Apr 2022 15:16:33 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402036100b004240a3fc6b4sm2669484edw.82.2022.04.23.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 15:16:33 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linus.walleij@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 1/2] mmc: sdhci-omap: Use of_device_get_match_data() helper
Date:   Sun, 24 Apr 2022 00:16:22 +0200
Message-Id: <20220423221623.1074556-2-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220423221623.1074556-1-huobean@gmail.com>
References: <20220423221623.1074556-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Only the device data is needed, not the entire struct of_device_id.
Use of_device_get_match_data() instead of open coding of_match_device().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/sdhci-omap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 64e27c2821f9..86e867ffbb10 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1219,16 +1219,11 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_omap_host *omap_host;
 	struct mmc_host *mmc;
-	const struct of_device_id *match;
-	struct sdhci_omap_data *data;
+	const struct sdhci_omap_data *data;
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
2.34.1

