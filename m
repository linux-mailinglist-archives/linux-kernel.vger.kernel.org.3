Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818554FF3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiDMJjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiDMJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:38:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF8654199
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:36:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v12so1480338plv.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBck5kaS+8ySo+Y9DddXrQrFzgjIvN9VKWgdzVcVQZk=;
        b=ldiknisxlId9o4lGSkC2HrKfxrERDqQUFat1QoP1RPTrJJfytc1jO9Ry3JxT9LDvVH
         8lv1siAj/kqf+TwEOu1mwL8rFjZJwHHHPa4iAvSI7q/iUBwQsFEL5rX6lQSOyy7JHbSz
         mGudSyP9Ygj5mzIR6Y4duObPd972kc/OHy6VE1HwzjKBLCt7hwDawDr5EZNYmUyG47Iw
         O9R1t0hd6ji8LLirE2GFma3ye5q+iEafjn92kyWrwYcgj6n/Pb++qpLZv5tn13luHHNv
         Uzu6Y/AmtsqzHmfTxAbT8WWY4NPkMEWlfSjdXblDhNm3eMdznYozDWLpKc/TOEfpWXN/
         HfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBck5kaS+8ySo+Y9DddXrQrFzgjIvN9VKWgdzVcVQZk=;
        b=oAiCzVq26MUXeyKLiFIibwQG2JUQdxbi6aJj7VngtzoVxuYDqtP4chaiTBQRXSmoR3
         v+kxd3xYX+i5DM+gOxFghZsrJsRNUwI8Qjyxp8sMQdRNZ5ZdTvwEnL0zX1+s1UjuXcR2
         To+UzTPi2y0aI8qdspHHKNUxwP67mqJJFObxna6Y6+5+HhFEOehvRCn37hJuKY/x9doE
         KS3Lbilg6NKXbzed80hb7y0TdfaY7OjJCf0BAF5JxZDa5c8dNOFd6CRlAH2yy3Cc6q2k
         DIzWQk15S2WhCqBiZsnDOEnoznNATGBORCuWOoY7fU/21NQc6OYiGwwZ/sYK2qo9yEy1
         RHsw==
X-Gm-Message-State: AOAM533Jnk7WwzqxAt5P4wNRFR77WTYRlgd3Xd8Fbx+Ge8u0seNP7Hbp
        Re3RqaIh7owh5ZbwoHm5E4s=
X-Google-Smtp-Source: ABdhPJxvnVtlea8o8PHzNgPaRwsntTtc/f3oRZGoMc7XIVt/pFjpBupl6pxbVBb1ZhWBIlVrwyOg7w==
X-Received: by 2002:a17:902:ef46:b0:153:81f7:7fc2 with SMTP id e6-20020a170902ef4600b0015381f77fc2mr42038984plx.26.1649842591575;
        Wed, 13 Apr 2022 02:36:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 25-20020a631259000000b0039d353e6d75sm5641352pgs.57.2022.04.13.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:36:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     kishon@ti.com
Cc:     vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] phy/motorola: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Wed, 13 Apr 2022 09:36:27 +0000
Message-Id: <20220413093627.2538442-1-chi.minghao@zte.com.cn>
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
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 5172971f4c36..8738d512131d 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -253,12 +253,9 @@ static irqreturn_t phy_mdm6600_wakeirq_thread(int irq, void *data)
 		return IRQ_NONE;
 
 	dev_dbg(ddata->dev, "OOB wake on mode_gpio1: %i\n", wakeup);
-	error = pm_runtime_get_sync(ddata->dev);
-	if (error < 0) {
-		pm_runtime_put_noidle(ddata->dev);
-
+	error = pm_runtime_resume_and_get(ddata->dev);
+	if (error < 0)
 		return IRQ_NONE;
-	}
 
 	/* Just wake-up and kick the autosuspend timer */
 	pm_runtime_mark_last_busy(ddata->dev);
@@ -601,10 +598,9 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(ddata->dev,
 					 MDM6600_MODEM_IDLE_DELAY_MS);
 	pm_runtime_enable(ddata->dev);
-	error = pm_runtime_get_sync(ddata->dev);
+	error = pm_runtime_resume_and_get(ddata->dev);
 	if (error < 0) {
 		dev_warn(ddata->dev, "failed to wake modem: %i\n", error);
-		pm_runtime_put_noidle(ddata->dev);
 		goto cleanup;
 	}
 
-- 
2.25.1


