Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9967F4FDB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377674AbiDLJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356678AbiDLHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:13 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91937527D7;
        Tue, 12 Apr 2022 00:09:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x20so6206857qvl.10;
        Tue, 12 Apr 2022 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYsKfoGqtSHG7ncqqXsmjssryH5B9bgQ3YJHMg/wmuE=;
        b=QwBDdndai0tHYI8OV/Ip9QYF6T4RV900qy1HIIeJzWQNOf8+SSUQGhtUdJC1ZhkXn/
         PKIqCEKeJ9PSo/gMIYsj1AMK+l3XvGfdG5JVPtMEC9ehRqStvb3iyPJQtq7mscCUg7Ly
         seZ68CyLmRp0Bf9hQGi8QMDLMpWTa4EoznfeGzSX/fChsLWaoY1+tjlzhoRxSYOtcgOn
         bL6vDdOE5b9u8VvD04vAPkJQ3Dq+HMFSikrmGAwemVEDsIxek9lFVGHe/IvKIymk+b93
         ZEiRMXLsAm/M00k7TbMYXGHMbhIdYrmsSsfrpjAkFVY15T+2VK4SImqlVnwoCTK7Dbxp
         eLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYsKfoGqtSHG7ncqqXsmjssryH5B9bgQ3YJHMg/wmuE=;
        b=KxOpgrIqWrlde4w6rh/KNB6CE79BOq6BFbzswe8A7Qbht3MzzMERyc7UFyme6v4e9N
         JOco/Mt/qqroPyLnPfPY4hpbwH/rH/gzOsmQ9d5jHoKngmKjT2z1J6gqLrBUtvppuwqr
         5DRLYxg1IG82D7QhTCoWgxLKoV6/jFDe2bUd574Pt2KmEB5qJj+NeXt7PaPP/kGnLGoA
         rQgq05MupMjIBigwd5cxaqrKQkIDDKEXeEFx5kpEQpFszA+QVGukdrPTW+Spf260hcAr
         5kq9Cm14IWyCXhopYBYxGW338kY4IB29oJOeoH9njDR5NiEY2X5Dtw9skB8synBIXXci
         v4fg==
X-Gm-Message-State: AOAM5318iC+LxTonk2b6oN3YuqfyA4RtpyTLO4D/6TxMth8ykGFmTYuR
        N6ydE1Ogm2B8uQtyl+RAukY=
X-Google-Smtp-Source: ABdhPJxD82QyXzIXC49kCu0uQhNuZRAkgzW0/Y+DmjAjzd5Op7VFc9g/56donMlX6v9f4IhUqwGMdQ==
X-Received: by 2002:a05:6214:2301:b0:435:38af:2f87 with SMTP id gc1-20020a056214230100b0043538af2f87mr30014186qvb.83.1649747398424;
        Tue, 12 Apr 2022 00:09:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t3-20020a05622a148300b002ef8ff7afa1sm2317660qtx.21.2022.04.12.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:09:58 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     ldewangan@nvidia.com
Cc:     broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-tegra114: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 12 Apr 2022 07:09:51 +0000
Message-Id: <20220412070951.2532157-1-chi.minghao@zte.com.cn>
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
 drivers/spi/spi-tegra114.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8f345247a8c3..d9be80e3e1bc 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -964,9 +964,8 @@ static int tegra_spi_setup(struct spi_device *spi)
 		spi->controller_data = cdata;
 	}
 
-	ret = pm_runtime_get_sync(tspi->dev);
+	ret = pm_runtime_resume_and_get(tspi->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(tspi->dev);
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
 		if (cdata)
 			tegra_spi_cleanup(spi);
@@ -1394,10 +1393,9 @@ static int tegra_spi_probe(struct platform_device *pdev)
 			goto exit_pm_disable;
 	}
 
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
-		pm_runtime_put_noidle(&pdev->dev);
 		goto exit_pm_disable;
 	}
 
@@ -1476,9 +1474,8 @@ static int tegra_spi_resume(struct device *dev)
 	struct tegra_spi_data *tspi = spi_master_get_devdata(master);
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

