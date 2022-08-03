Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8636058872A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiHCGLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiHCGLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:11:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F11FCE5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:11:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g12so15595934pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hArGsep6w0XB1WHGT+Gmkg3i/QE/wzavCdCkpGkoxac=;
        b=byyHuqw5AjLIJsJ97Gx1MKa0/Rl4jOk6meIJgq4wXQFPt8qKBWBp2JA83QLGFyMgjc
         xAsY8pPn/uAPtsims6qlsBH+QoubyeUhdRmQz7B8iCnb4CDYx6TdaJ2MLMHIEKAwBTlY
         +Yv06UH/cuevggFpTe94gj1u6bLbKamLMRTPIiGIlTnC6GdUqpzsBEvvs7AZiACWLpFE
         VnxjE+/MLqcGNPOvE8Ez/dKlDoccr4lWLeakIBY3OOZQRaETsmCHvPkYlpqMRVdbWOf+
         zywdwi9ZnNBJDYb4RLHl+k2IBu4zXtAwuftvJAqlefyzQx+opkq/43KGVuhZsmxOQjJ4
         +AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hArGsep6w0XB1WHGT+Gmkg3i/QE/wzavCdCkpGkoxac=;
        b=Eobo41OiFcVrTMQftAWKAqEixJm6T8jUqEQ/U/GcHRwlRbI24gCkEhsSNjEYF5wST+
         86LoThG92iWuL6Z/IQIccbbk9PRhzAUMsD8RtNXsxM+eISS5H55lsgfzAjQzn6EiGUTZ
         kHZ1ZrRXlXWNdUKNT2shH7v6IfohvTxWffIgZo4lmXH479tI7yqQlqk7rG7DnILkmW3D
         AZTClFPlXU4uMcoybReHviP90+kgAAkg60iBr9sk1L1O8HwlpyONT6fBDTzrvmc9pAz6
         05mUFuqsgmp98ysZojo1+oxtmNlAfg+ODay21pq4QXdCi689JFsrRcbTOfw6+hyj4ux5
         rfBQ==
X-Gm-Message-State: ACgBeo0DjkP8v6hh60CbHzVPfSlCkQUsY+sjSSV/gAQlgRhCgYEig/4v
        XB2wHIvmjLLIPNaobmXSczbaJKLl5o8=
X-Google-Smtp-Source: AA6agR6OON8xYV30qq9idigkbOKyKiDwpBQFgenrQzHAWtwrDYvpYN5ZDCrRQadXcU4VbqZ5gxkv6g==
X-Received: by 2002:a63:5a08:0:b0:41b:df3c:fd6c with SMTP id o8-20020a635a08000000b0041bdf3cfd6cmr14088534pgb.35.1659507099634;
        Tue, 02 Aug 2022 23:11:39 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w128-20020a626286000000b0052d7606d144sm5711690pfb.74.2022.08.02.23.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 23:11:39 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     zbr@ioremap.net, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] w1: omap-hdq:using the pm_runtime_resume_and_get to simplify the code
Date:   Wed,  3 Aug 2022 06:11:35 +0000
Message-Id: <20220803061135.1650266-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of
 pm_runtime_get_sync and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/w1/masters/omap_hdq.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index bf2ec59c1f9d..ec4292bc0458 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -372,9 +372,8 @@ static u8 omap_w1_triplet(void *_hdq, u8 bdir)
 		  OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK;
 	u8 mask = ctrl | OMAP_HDQ_CTRL_STATUS_DIR;
 
-	err = pm_runtime_get_sync(hdq_data->dev);
+	err = pm_runtime_resume_and_get(hdq_data->dev);
 	if (err < 0) {
-		pm_runtime_put_noidle(hdq_data->dev);
 
 		return err;
 	}
@@ -463,9 +462,8 @@ static u8 omap_w1_reset_bus(void *_hdq)
 	struct hdq_data *hdq_data = _hdq;
 	int err;
 
-	err = pm_runtime_get_sync(hdq_data->dev);
+	err = pm_runtime_resume_and_get(hdq_data->dev);
 	if (err < 0) {
-		pm_runtime_put_noidle(hdq_data->dev);
 
 		return err;
 	}
@@ -485,9 +483,8 @@ static u8 omap_w1_read_byte(void *_hdq)
 	u8 val = 0;
 	int ret;
 
-	ret = pm_runtime_get_sync(hdq_data->dev);
+	ret = pm_runtime_resume_and_get(hdq_data->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(hdq_data->dev);
 
 		return -1;
 	}
@@ -509,9 +506,8 @@ static void omap_w1_write_byte(void *_hdq, u8 byte)
 	int ret;
 	u8 status;
 
-	ret = pm_runtime_get_sync(hdq_data->dev);
+	ret = pm_runtime_resume_and_get(hdq_data->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(hdq_data->dev);
 
 		return;
 	}
@@ -605,9 +601,8 @@ static int omap_hdq_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 300);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
 		dev_dbg(&pdev->dev, "pm_runtime_get_sync failed\n");
 		goto err_w1;
 	}
@@ -659,9 +654,8 @@ static int omap_hdq_remove(struct platform_device *pdev)
 {
 	int active;
 
-	active = pm_runtime_get_sync(&pdev->dev);
+	active = pm_runtime_resume_and_get(&pdev->dev);
 	if (active < 0)
-		pm_runtime_put_noidle(&pdev->dev);
 
 	w1_remove_master_device(&omap_w1_master);
 
-- 
2.25.1
