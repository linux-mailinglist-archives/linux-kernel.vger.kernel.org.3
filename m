Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA1C4FDC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbiDLKPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378006AbiDLJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:59:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586021EEF8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:06:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k29so91864pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q0V0iY7dr2lRVb8OvfSaWvww3uLXhqUgjXUdAVt87g=;
        b=RHIu8/Bnc+30R/gAERf2/UYCIWBSwrHm5GXZKku4GxndzoI2eCqzOTfBGecViIUSNC
         mJWkcdgMIJEMKvdtbSxtTVtxRk1syy0oWmSAtp37ims2++OrvHLQnPXDSN2x3eCq3ST5
         fBuPJp83/Ee4mSm3soCfPfy2nU9lhPrcMl8SDVxALArLtpUzmjS9qdbgb3jjsgVeI8dV
         2vbamPGU922L5AQgemxZlw9/jaJyAggEzKQcVPJTkES3fDSs9cSszKh87fCyfQw3Nb4F
         VPEWz5+iTztDcFoQPegKz8RKMpnn8FbltAyMnlEqts3ED2UadA1tBPpd76CAsuYmV+R1
         DO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q0V0iY7dr2lRVb8OvfSaWvww3uLXhqUgjXUdAVt87g=;
        b=tgnB4rU+8wVLeKlY3+OjEg+YHCvnxpPY2F8A4lmkpzLTo7rPeW5lptgSI/SgR5i5P+
         wuZTre26NeHdhm+bSXwwAFion5qz87yPgT6vT/By/bRkIxwfkOOj5I3M8kT13H6mL5x0
         Gr5wYBC/HFSJHYWTSFVvvdtXY7sn2303dYuSrrnJ1dNM223PI2rIUcS8pgNQCpwLygh6
         JkS/E74AiAuJvMukTQblXvYay4uCdG3rF0Gc+MIqENg1Hm9w5UAwIW1oT0Ew3P5u1+ew
         eA8bt8tSyv+AhTfHJsrc28Me0sbZXkMu33HGGmnZujE7GZqca+8nyBH4cPMZtWF6HIx1
         crSQ==
X-Gm-Message-State: AOAM533U+Gu2XbW0I50kcpAfqj/SAAw3w9PUyEPZ4ZOGQxwhdJNrPLoD
        Eju57gn6zLuMZte0hQjZntA=
X-Google-Smtp-Source: ABdhPJz+nAInByt3ZGBpbAZ62WbZwYw/t8OZe4q2LY3JMlTscgFFwVLyADnpGFDDw10xbOKsBbgIAQ==
X-Received: by 2002:a65:57cc:0:b0:384:3370:e161 with SMTP id q12-20020a6557cc000000b003843370e161mr29584202pgr.364.1649754363701;
        Tue, 12 Apr 2022 02:06:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm2179835pgc.50.2022.04.12.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 02:06:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] w1: omap-hdq: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 12 Apr 2022 09:06:00 +0000
Message-Id: <20220412090600.2533461-1-chi.minghao@zte.com.cn>
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
 drivers/w1/masters/omap_hdq.c | 38 ++++++++++-------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index bf2ec59c1f9d..f325fe35a8f7 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -372,12 +372,9 @@ static u8 omap_w1_triplet(void *_hdq, u8 bdir)
 		  OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK;
 	u8 mask = ctrl | OMAP_HDQ_CTRL_STATUS_DIR;
 
-	err = pm_runtime_get_sync(hdq_data->dev);
-	if (err < 0) {
-		pm_runtime_put_noidle(hdq_data->dev);
-
+	err = pm_runtime_resume_and_get(hdq_data->dev);
+	if (err < 0)
 		return err;
-	}
 
 	err = mutex_lock_interruptible(&hdq_data->hdq_mutex);
 	if (err < 0) {
@@ -463,12 +460,9 @@ static u8 omap_w1_reset_bus(void *_hdq)
 	struct hdq_data *hdq_data = _hdq;
 	int err;
 
-	err = pm_runtime_get_sync(hdq_data->dev);
-	if (err < 0) {
-		pm_runtime_put_noidle(hdq_data->dev);
-
+	err = pm_runtime_resume_and_get(hdq_data->dev);
+	if (err < 0)
 		return err;
-	}
 
 	omap_hdq_break(hdq_data);
 
@@ -485,12 +479,9 @@ static u8 omap_w1_read_byte(void *_hdq)
 	u8 val = 0;
 	int ret;
 
-	ret = pm_runtime_get_sync(hdq_data->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(hdq_data->dev);
-
+	ret = pm_runtime_resume_and_get(hdq_data->dev);
+	if (ret < 0)
 		return -1;
-	}
 
 	ret = hdq_read_byte(hdq_data, &val);
 	if (ret)
@@ -509,12 +500,9 @@ static void omap_w1_write_byte(void *_hdq, u8 byte)
 	int ret;
 	u8 status;
 
-	ret = pm_runtime_get_sync(hdq_data->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(hdq_data->dev);
-
+	ret = pm_runtime_resume_and_get(hdq_data->dev);
+	if (ret < 0)
 		return;
-	}
 
 	/*
 	 * We need to reset the slave before
@@ -605,10 +593,9 @@ static int omap_hdq_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 300);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
-		dev_dbg(&pdev->dev, "pm_runtime_get_sync failed\n");
+		dev_dbg(&pdev->dev, "pm_runtime_resume_and_get failed\n");
 		goto err_w1;
 	}
 
@@ -659,10 +646,7 @@ static int omap_hdq_remove(struct platform_device *pdev)
 {
 	int active;
 
-	active = pm_runtime_get_sync(&pdev->dev);
-	if (active < 0)
-		pm_runtime_put_noidle(&pdev->dev);
-
+	active = pm_runtime_resume_and_get(&pdev->dev);
 	w1_remove_master_device(&omap_w1_master);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.25.1

