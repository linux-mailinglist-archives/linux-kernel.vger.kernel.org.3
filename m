Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA4F4EE9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbiDAIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbiDAIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:52:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48B25AEF9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:50:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id yy13so4446791ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9x7o2rLsdGdAxSBmzyZSquoQkWzGlamlIyMjNJ2/kXM=;
        b=tXD9Pv+wScvr2/GUjRCTxoVgpkldyFDZ0La8O/WbIOLpRfPUMqtedcXpGrhPHOPRBV
         IWnuIUQlFRtRp6NgsNyF4rMGQCgx1VMEc3hxjcHmNAMsWuvzqzrtl9VpjBZzucTP3XgT
         cQQZevImh/EakoXIjUu7CaxOo3cW2hK+TdJ/sn4eA84GunSt5p7UkV1k75pCAZ/G9/ZK
         wxaFCfFfCPxKg9FYi8E7aHA71nXi1Yw4aa235SdI6ieKCF0J3os7PAaIDSXex6XwnpAN
         zABhFWY0rc8+lXhZT/eSGKKiVCbCQn3Zi/InqZFXYvEbtZjb3pq7W7bbDq6N1kuObN7A
         5GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9x7o2rLsdGdAxSBmzyZSquoQkWzGlamlIyMjNJ2/kXM=;
        b=51dhXh+InViNMawQlXrGwfJbZNdovvpLy5UmYgo4Ax90DViHPpHgAl+glz/HaUP8jO
         r/u+ACXYr/HfyAStjKcfi0q/iQEPuRkQwLyJf4mBUFJGD7f4onprYJGVGIoTCWMA+pQx
         x5O5UIc/FBB13kqcPtHFG7zkA8D5/gDJH5xzi8Laro5Y1skfDO0q9O/L4f3eReOxn+gl
         huHf13xvQ6ddnumBRfPlEF/zjs18lg1fj1JBx3s/3DdL4qh8cQ8fCzU36t9u1/9L8yaz
         jaQzrZSzcwJbikvsUzq2Ty1h9CQ0L/BM0FQQf6meSR8LZzxMvRtir5U7Af25QsbQs/R/
         gzIA==
X-Gm-Message-State: AOAM532qrAwuUckWyyWLj/VmVALteoGhQsSmJna18Mso7pPk3OXptLBQ
        V7rcicUFpjnPe+alNHk7UssB4Q==
X-Google-Smtp-Source: ABdhPJz9lwwu8guF/m3tbWNjUN7Bjgb5AqsPQGxOYOk5IVDomf+E8JlF5flFc2DXiRnsFI4zYiQkXQ==
X-Received: by 2002:a17:907:72cc:b0:6e0:2d3:bcba with SMTP id du12-20020a17090772cc00b006e002d3bcbamr8441706ejc.642.1648803054538;
        Fri, 01 Apr 2022 01:50:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id gt34-20020a1709072da200b006df6bb3db69sm786718ejc.158.2022.04.01.01.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:50:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] scsi: ufs: ufshcd-pltfrm: simplify usages of pdev->dev
Date:   Fri,  1 Apr 2022 10:50:50 +0200
Message-Id: <20220401085050.119323-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'struct device' pointer is already cached as local variable in
ufshcd_pltfrm_init(), so use it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/ufs/ufshcd-pltfrm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 87975d1a21c8..cca4b2181a81 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -341,7 +341,7 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	err = ufshcd_alloc_host(dev, &hba);
 	if (err) {
-		dev_err(&pdev->dev, "Allocation failed\n");
+		dev_err(dev, "Allocation failed\n");
 		goto out;
 	}
 
@@ -349,13 +349,13 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	err = ufshcd_parse_clock_info(hba);
 	if (err) {
-		dev_err(&pdev->dev, "%s: clock parse failed %d\n",
+		dev_err(dev, "%s: clock parse failed %d\n",
 				__func__, err);
 		goto dealloc_host;
 	}
 	err = ufshcd_parse_regulator_info(hba);
 	if (err) {
-		dev_err(&pdev->dev, "%s: regulator init failed %d\n",
+		dev_err(dev, "%s: regulator init failed %d\n",
 				__func__, err);
 		goto dealloc_host;
 	}
@@ -368,8 +368,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		goto dealloc_host;
 	}
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	return 0;
 
-- 
2.32.0

