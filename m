Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17DE54552B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbiFITvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiFITvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:51:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2A226562
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:51:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gl15so35653229ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aabekdX1Xu6nGH+V0mihMdec0zOM722rNngzJgCXDQ4=;
        b=XTrue6mqPn+8RMjHht0tYm8c3g3Vcu0E4RvBDSWuAqxiHKqjV8KaaWrz+yBgD5FFgo
         hJ6p4kAsHBSIQlIXpku5l++l0jrcGB9ykN4J1qV1IQRCLaXnfMexL2YbvN42uzE1J0Cn
         Sf81tEYXivntzyNmDigF0bELfC7Ot8YXMFUhEqeZ9PMX1Ds4z3C4DvUgim9NaM8KRyw+
         GPuQ9dhIb9LJGZnkiKDliJWJBF4yNvICcQAEMN9099haY3bka4ZyYHEJfOyIsJPUMrQv
         62KPa/GRUXErixIbCW6VG1e7s8utVtIqZxoxUZBNu0h2CrJFEeXmnRiF7FFHY4NaVN2f
         jgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aabekdX1Xu6nGH+V0mihMdec0zOM722rNngzJgCXDQ4=;
        b=uBNZDg56HdoJ1xHb9mDHjK2Tq3HJ/jLEbV7nyZXVi5bcYuz4kkTA3ds6waRHzCF3cW
         kcdSgWXj848CuOl9HsL0ZlSdIMhc6TrxbveLQlQx+nL4xk8Zy8vC+BzQm+DYlJhIjZ8r
         VE6l7Iiv63GVZ/T8pQnyO+fiLR6yv41/X25Apw8aHx9RkhEW6LsAo0Z3jWlKxzFinzqZ
         14ISZ2+D5ae6Tv0/uK2WR6OQfdt8YBWDUZf6UqhKHELRmDEjg0b+WgoQJh80PiqffgYX
         C1nkakHEIKOhB6JO3BbcLy+73BqTSB0ynwe/FblPbeUzPprsBQab5upY4EqYKWHC9gaN
         30bw==
X-Gm-Message-State: AOAM530NNSGJwiH2p8mYoJ+GsgqhzT+nCbxzE6QoSSn0uvdxDCVRQSYO
        j/UvyYMar8C0qENsMvi3WBRlPA==
X-Google-Smtp-Source: ABdhPJxjZoPjPeZa5kkKqcWtwV5tyv/jwJjKvbDfrpxpoAuMGYNKBrKyvIafMQYtBaBbq1IlB38Z9Q==
X-Received: by 2002:a17:906:d8b8:b0:711:c73e:906b with SMTP id qc24-20020a170906d8b800b00711c73e906bmr23370395ejb.225.1654804270799;
        Thu, 09 Jun 2022 12:51:10 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id x14-20020a170906b08e00b006ff52dfccf3sm10977550ejy.211.2022.06.09.12.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:51:10 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: bam_dma: fix runtime PM underflow
Date:   Thu,  9 Jun 2022 20:50:43 +0100
Message-Id: <20220609195043.1544625-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PM runtime is disabled, pm_runtime_get() isn't called, but
pm_runtime_put() still is. Fix this by creating a matching wrapper
on pm_runtime_put_autosuspend().

Fixes: dbad41e7bb5f ("dmaengine: qcom: bam_dma: check if the runtime pm enabled")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 87f6ca1541cf..a36dedee262e 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -566,6 +566,14 @@ static int bam_pm_runtime_get_sync(struct device *dev)
 	return 0;
 }
 
+static int bam_pm_runtime_put_autosuspend(struct device *dev)
+{
+	if (pm_runtime_enabled(dev))
+		return pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
 /**
  * bam_free_chan - Frees dma resources associated with specific channel
  * @chan: specified channel
@@ -617,7 +625,7 @@ static void bam_free_chan(struct dma_chan *chan)
 
 err:
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	bam_pm_runtime_put_autosuspend(bdev->dev);
 }
 
 /**
@@ -793,7 +801,7 @@ static int bam_pause(struct dma_chan *chan)
 	bchan->paused = 1;
 	spin_unlock_irqrestore(&bchan->vc.lock, flag);
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	bam_pm_runtime_put_autosuspend(bdev->dev);
 
 	return 0;
 }
@@ -819,7 +827,7 @@ static int bam_resume(struct dma_chan *chan)
 	bchan->paused = 0;
 	spin_unlock_irqrestore(&bchan->vc.lock, flag);
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	bam_pm_runtime_put_autosuspend(bdev->dev);
 
 	return 0;
 }
@@ -936,7 +944,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 	}
 
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	bam_pm_runtime_put_autosuspend(bdev->dev);
 
 	return IRQ_HANDLED;
 }
@@ -1111,7 +1119,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 			bam_addr(bdev, bchan->id, BAM_P_EVNT_REG));
 
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	bam_pm_runtime_put_autosuspend(bdev->dev);
 }
 
 /**
-- 
2.36.1

