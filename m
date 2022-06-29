Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917425601F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiF2ODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiF2ODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:03:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640DC29819
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:03:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n8so8394353eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Fm2QBWRMAcf2SqfXkovtfoitzjHh0Xu8DtDfFRKdko=;
        b=WE0ux5jIlaFg4gsQbxItLzp5FFtBXMzl1rQaeggZCsOcNFK23ToF4N5Ahxi1xs4fsB
         kvw6CyeG0YngZ7zEsWP0n/K2Jxul0VCPriuQmqpaBoVpzAO6ed7VHpwPIQEzm8rWIZWz
         rR4v8PJIrak1HHpJ0coFqXZcjR7950OBwvXjAheWWzbyunZlyz1hxJiBOskN8OESjB65
         tv1ml8dXftsGEpEO13BXu7FVqjbmrxa1uHSBr1kFvaovTyNFg1HMYsTdPCloCXCQbfKH
         1tsNgvHKJ7eSDjb6zKTiMlYNdeRSgNBNJZrFxKOUk6KQWKmwFQoWbIqssAB6/dsue/RC
         OfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Fm2QBWRMAcf2SqfXkovtfoitzjHh0Xu8DtDfFRKdko=;
        b=4WGQFl82u8tl6RpfegGCWfLQH+jTF9t5+WRXsL8I2UC7RVesP/uHbjenqL1/8BYCKr
         CWuD3D3BJXMSzQfATxEMCO2whsc33wD6qMHar99N382qnrfZuVE1peIwQuSLeXYwlNiY
         XaY+GF9lMbRo60Haps/j6H0rUqeuodP3E3E0DIDcs9gQLg/hKc6sOfb2TB7uUekfzia2
         sm+LkfBYrILgmMarmKO4n1JrED24DGdVrrUr94+JZofEMVl7P+r0YQkX4nIYHBQIB0ku
         QcWYADdi/NNSprOfcFrd5Vm/9U/tC1JUcYAt/Sqf7QeZ45qFK4tBAsyzjvyuciJwByMJ
         ve6Q==
X-Gm-Message-State: AJIora+IGDDx+xCKrzaMlAp9BQ0nlmsNmasi5tdoFwioXmfeGV3rWQwT
        ZraVjDxCxW9nwjsEE8UffbbJ5Q==
X-Google-Smtp-Source: AGRyM1sXo01E7PomYrFjczxvDI2c1Y8J1q7hLBW6UtX+TBb9e4omxuFhlvhkJIPJF8FB43noub0UnQ==
X-Received: by 2002:a05:6402:501d:b0:437:e000:a898 with SMTP id p29-20020a056402501d00b00437e000a898mr1307482eda.265.1656511416959;
        Wed, 29 Jun 2022 07:03:36 -0700 (PDT)
Received: from localhost.localdomain (88-107-17-60.dynamic.dsl.as9105.com. [88.107.17.60])
        by smtp.gmail.com with ESMTPSA id x2-20020aa7d382000000b00435640c141esm11377343edq.93.2022.06.29.07.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:03:36 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2] dmaengine: qcom: bam_dma: fix runtime PM underflow
Date:   Wed, 29 Jun 2022 15:03:23 +0100
Message-Id: <20220629140323.116981-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dbad41e7bb5f ("dmaengine: qcom: bam_dma: check if the runtime pm enabled")
caused unbalanced pm_runtime_get/put() calls when the bam is
controlled remotely. This commit reverts it and just enables pm_runtime
in all cases, the clk_* functions already just nop the clock is NULL.

Also clean up a bit by removing unnecessary bamclk null checks.

Suggested-by: Stephan Gerhold <stephan@gerhold.net>
Fixes: dbad41e7bb5f ("dmaengine: qcom: bam_dma: check if the runtime pm enabled")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Boot tested on a OnePlus 6

v1 can be found here:
https://lore.kernel.org/linux-arm-msm/20220609195043.1544625-1-caleb.connolly@linaro.org/

 drivers/dma/qcom/bam_dma.c | 39 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 87f6ca1541cf..2ff787df513e 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -558,14 +558,6 @@ static int bam_alloc_chan(struct dma_chan *chan)
 	return 0;
 }
 
-static int bam_pm_runtime_get_sync(struct device *dev)
-{
-	if (pm_runtime_enabled(dev))
-		return pm_runtime_get_sync(dev);
-
-	return 0;
-}
-
 /**
  * bam_free_chan - Frees dma resources associated with specific channel
  * @chan: specified channel
@@ -581,7 +573,7 @@ static void bam_free_chan(struct dma_chan *chan)
 	unsigned long flags;
 	int ret;
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return;
 
@@ -784,7 +776,7 @@ static int bam_pause(struct dma_chan *chan)
 	unsigned long flag;
 	int ret;
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -810,7 +802,7 @@ static int bam_resume(struct dma_chan *chan)
 	unsigned long flag;
 	int ret;
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -919,7 +911,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 	if (srcs & P_IRQ)
 		tasklet_schedule(&bdev->task);
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return IRQ_NONE;
 
@@ -1037,7 +1029,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 	if (!vd)
 		return;
 
-	ret = bam_pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
 		return;
 
@@ -1374,11 +1366,6 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_dma;
 
-	if (!bdev->bamclk) {
-		pm_runtime_disable(&pdev->dev);
-		return 0;
-	}
-
 	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, BAM_DMA_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1462,10 +1449,8 @@ static int __maybe_unused bam_dma_suspend(struct device *dev)
 {
 	struct bam_device *bdev = dev_get_drvdata(dev);
 
-	if (bdev->bamclk) {
-		pm_runtime_force_suspend(dev);
-		clk_unprepare(bdev->bamclk);
-	}
+	pm_runtime_force_suspend(dev);
+	clk_unprepare(bdev->bamclk);
 
 	return 0;
 }
@@ -1475,13 +1460,11 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
 	struct bam_device *bdev = dev_get_drvdata(dev);
 	int ret;
 
-	if (bdev->bamclk) {
-		ret = clk_prepare(bdev->bamclk);
-		if (ret)
-			return ret;
+	ret = clk_prepare(bdev->bamclk);
+	if (ret)
+		return ret;
 
-		pm_runtime_force_resume(dev);
-	}
+	pm_runtime_force_resume(dev);
 
 	return 0;
 }
-- 
2.36.1

