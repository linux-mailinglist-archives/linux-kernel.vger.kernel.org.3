Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDC14F07F6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbiDCFvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbiDCFvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:51:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA37A19E;
        Sat,  2 Apr 2022 22:49:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w21so5683003pgm.7;
        Sat, 02 Apr 2022 22:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FmtIu4Pls8Ojb/aaUXocXJF0tN/1qMyxMF56b2SiIYk=;
        b=pMOT+eXyKvyQNEYJONFSNHX+R6GBmJgYwKQHiadpqbUtimS4b2PDi4qlQeOrRPqkyi
         1/ugL643s604Puo7tRf9eKhTztPf87JyX3erM9aNgdTrpHlpuYqO4X/cuxY/yzeKHffu
         pd2RHwP3gERRylVBl+UyAYZL5WbRdUXSFtYQwoM7JXK+GAhWg1glzfk4pnfxk9vDjEef
         hDJmiSKsptpx6KuPJC4jGtxKUB876Yg8vm3h2Czgh3/sIYcyGOlZHjd6R0i2zVfkXOq6
         TRjjY6SZcS01HG6Yukk4E+9ulQDAyiESQaRAwkFAlerAUDJh6HfBqptjdLRTvHb3C6ex
         paKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FmtIu4Pls8Ojb/aaUXocXJF0tN/1qMyxMF56b2SiIYk=;
        b=ZsxUbEFZrKdDelOXXVDJNun5IFNykqsvAEa8/2xHMcYaKvKD8AqxAV9aY3CSWo+a6r
         57t5vNwtdo5JoyBkZMtU9jKIVbC6ntdZ+LKH13nvYe7GqS7uwa3BZItHK0emDJo/CVoE
         HqTHg/5DGP9iImsSep272Z+fWzLuIvE/YnbWlzrVdLh9nuqNQUYrHX6daAvzmT2GMuRs
         9SfkwVi3M2t9dXxTpOgvRjyJRcQKVq4VM9bq1DwMqS/mmw61Hr28CiLOjnu/FOpPiLVq
         5eINsV98QsuzjKYZCBN3k3zaZioUFGkAFeNtMaLwAWX9RjrGXs94T2HQD9Uyn/oOLdH5
         YKCA==
X-Gm-Message-State: AOAM531xKn5IhTU1p+28EfVAfNXPqDXL9lYFKwiAMyh7EbivXwauyOQR
        nwDngQYIOiE9qbVDjMx3nKo=
X-Google-Smtp-Source: ABdhPJyNGXn4TOUxCtHsDteWG+OIl68bV+vIcGmkG52HDh/dOmBsojpcEzsUKqeCfj+2RuhQtDidcw==
X-Received: by 2002:a65:434b:0:b0:382:4fa9:3be6 with SMTP id k11-20020a65434b000000b003824fa93be6mr21127660pgq.459.1648964962007;
        Sat, 02 Apr 2022 22:49:22 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm7742460pfc.190.2022.04.02.22.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 22:49:21 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] rtc: ftrtc010: Fix error handling in ftrtc010_rtc_probe
Date:   Sun,  3 Apr 2022 05:49:12 +0000
Message-Id: <20220403054912.31739-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error handling path, the clk_prepare_enable() function
call should be balanced by a corresponding 'clk_disable_unprepare()'
call , as already done in the remove function.

clk_disable_unprepare calls clk_disable() and clk_unprepare().
They will use IS_ERR_OR_NULL to check the argument.

Fixes: ac05fba39cc5 ("rtc: gemini: Add optional clock handling")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/rtc/rtc-ftrtc010.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index 53bb08fe1cd4..25c6e7d9570f 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -137,26 +137,34 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(rtc->extclk);
 		if (ret) {
 			dev_err(dev, "failed to enable EXTCLK\n");
-			return ret;
+			goto err_disable_pclk;
 		}
 	}
 
 	rtc->rtc_irq = platform_get_irq(pdev, 0);
-	if (rtc->rtc_irq < 0)
-		return rtc->rtc_irq;
+	if (rtc->rtc_irq < 0) {
+		ret = rtc->rtc_irq;
+		goto err_disable_extclk;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto err_disable_extclk;
+	}
 
 	rtc->rtc_base = devm_ioremap(dev, res->start,
 				     resource_size(res));
-	if (!rtc->rtc_base)
-		return -ENOMEM;
+	if (!rtc->rtc_base) {
+		ret = -ENOMEM;
+		goto err_disable_extclk;
+	}
 
 	rtc->rtc_dev = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
+	if (IS_ERR(rtc->rtc_dev)) {
+		ret = PTR_ERR(rtc->rtc_dev);
+		goto err_disable_extclk;
+	}
 
 	rtc->rtc_dev->ops = &ftrtc010_rtc_ops;
 
@@ -172,9 +180,15 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
 	if (unlikely(ret))
-		return ret;
+		goto err_disable_extclk;
 
 	return devm_rtc_register_device(rtc->rtc_dev);
+
+err_disable_extclk:
+	clk_disable_unprepare(rtc->extclk);
+err_disable_pclk:
+	clk_disable_unprepare(rtc->pclk);
+	return ret;
 }
 
 static int ftrtc010_rtc_remove(struct platform_device *pdev)
-- 
2.17.1

