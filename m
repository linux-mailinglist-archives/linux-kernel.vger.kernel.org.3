Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE46504F28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiDRLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiDRLDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:03:48 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AB7BF73;
        Mon, 18 Apr 2022 04:01:09 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x18so4027172qtw.4;
        Mon, 18 Apr 2022 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwnN1oZ2LBUhFwxk5+UwL2jilzH2HcfZqt40jbuN85g=;
        b=Ew5aYmqoNZIBryg+/E0QMgxvgFLxw5e9Ojf7kgtsq/5GRadgfw/nNX3Qherv83WaDW
         iBDcTdV/wEpae8an3zhtaGa1aAKjwbgz7rCSSeWkuSBSgl8eDpwpk/+K8X2CExTtWjym
         6ZQ9//pDyCj+d7iYK1dyd/Df+NNcBEQhaXehiSxOlNcauhhznehaj21Qav9EkJdgRJ28
         8OOMy/GIvnbG2CrW9wqJu8HNgkKZx7LWSyVfu9OI5gX8Ll3KJVni/PLVhrWeRgs7E6Ox
         TUbgZuWPESrkP6rnfdVAYggWzS5oFQrksZzEh4NJTMaG23q19J36Hpi2Ixf1KOTki338
         IvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwnN1oZ2LBUhFwxk5+UwL2jilzH2HcfZqt40jbuN85g=;
        b=EKxMYztnX2LLaWCDiH9C1gNKw6fxwgt7qdxtNixJ4yJ0BaDcRpjRubSfuOHHWJ0Wf3
         mzofWq4b2GmwEeh6GCIEknkNFYKlK6buiAzivhj0NkeyEo3ZatxqNSGBPO4u3+rC0ny/
         pY18b7VY34ipFRGExVCkpT+S/rh2HVO27tw0YB0cKhy9GJ3/mhz+PnJnGkKP+Kx30gc7
         nxe6pCJ5WTCJvO6MA4wEL7H0fbbKLobU4+M1amH2vQTZYVvNah8e3h+WzoAP3n3N5AgB
         JeVmYgQaHb4koVym/RiHQNFnZdwxCbUGCJnTUgYYsIhD8Ub2snqKHs6jxiV/3nelbDZR
         vkGA==
X-Gm-Message-State: AOAM532EaVOGaxVeK92LccjLUlBMFHwxXJbvIoS9bZYiXDbJb9E3eXZL
        Z3qgsFL7gpkTqDb6ChI46awoddrIos0=
X-Google-Smtp-Source: ABdhPJx8bBnkbnz7qkrkHRfSsDkReqERjEpBnW0mYBmi7AnalzZJiv5KbdOiFZ5/5N+rhvABa73VGw==
X-Received: by 2002:ac8:7294:0:b0:2f1:e250:f21f with SMTP id v20-20020ac87294000000b002f1e250f21fmr6702394qto.526.1650279669141;
        Mon, 18 Apr 2022 04:01:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u129-20020a376087000000b0067e401d7177sm6753428qkb.3.2022.04.18.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:01:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     ldewangan@nvidia.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-tegra20-sflash: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 11:01:03 +0000
Message-Id: <20220418110103.2558955-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-tegra20-sflash.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 2888d8a8dc6d..220ee08c4a06 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -486,10 +486,9 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 			goto exit_pm_disable;
 	}
 
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
-		pm_runtime_put_noidle(&pdev->dev);
 		goto exit_pm_disable;
 	}
 
@@ -549,9 +548,8 @@ static int tegra_sflash_resume(struct device *dev)
 	struct tegra_sflash_data *tsd = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
 		dev_err(dev, "pm runtime failed, e = %d\n", ret);
 		return ret;
 	}
-- 
2.25.1


