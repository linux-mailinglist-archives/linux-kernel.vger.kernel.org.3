Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC134A63F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiBASeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiBASeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:34:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9900C061714;
        Tue,  1 Feb 2022 10:34:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u15so33769189wrt.3;
        Tue, 01 Feb 2022 10:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sCvk2JEkTN7cJ4ViA/+Q1mWtijvqc6HlgVsE2fUttPE=;
        b=f9KQw0SsHC3XwbxZLFi5HTOVXULq8GAA1T7SheswJwe3Uh7T4s0oHTCBJ20O/+5/c0
         FENox8mAvJOm99Z1qV/+bR2axUNOfR68w/KjC7ClaWJIkwjtsW5vq71YHkz8AIsFzr+T
         cnzHsdUIwLH2eoQeln95eAHirPnE1Q9gbvOZG6DVwusrD38a47+n8RBqroFuywu59U9u
         iw/ME37+LwcIGcWpEBQnXM8PMGhX9exRPQYtq/32fa93yKENBWWy8h+JT4ATH0Hjtk8v
         19aIdSj/wpyMXDWZVr9FoyhtpxfPo6g6sIbNVklpmsQyXuQZV4IIQgKxOVVNp3iP810H
         W4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sCvk2JEkTN7cJ4ViA/+Q1mWtijvqc6HlgVsE2fUttPE=;
        b=sIauA3kl8RUNihqT9TaM4PYCMsI6lmASZPZgU+ICrU9KvKNB7IWVCUSSSSrFRwvb0s
         u67ONImFi3FNcITCBuLuOVoIKuxJpTP9jaNfYLhDvvtOclGYeH0rikGOfmudJ/+kgF1w
         Y8V2lU3b0hGHUIk0piqDFE6eU+VoO2+0DFAaZWqr50WMeRnllOgROlJyhHqCQrzdqqQ0
         hCPdtxVpe3OYMDKeVCoXbV5DxVZVwEk2+uvofTJcyFr0QaLeZQBuiPgbYK0no0DKjYiZ
         M69D+zAvc1pqEw6bjrS88GSicvz4nKytw2QTKEh/YM0x+sT0Yg9sJoZjlQ76T3BqJeLZ
         oebQ==
X-Gm-Message-State: AOAM533X4C1o91BxPWf+zySNqtLkHckHAB0YK2PtgtH3mkjZcnKIHSnz
        oEANCT0i1pfc59PS2dogEB4=
X-Google-Smtp-Source: ABdhPJxBKiYspzokfHzLalKSOyfp5oCM2yFNJiRRUv2fby6NHl0LPyRTYyGimtWMvaAdY7iHePaqKw==
X-Received: by 2002:adf:ef88:: with SMTP id d8mr21442184wro.419.1643740452368;
        Tue, 01 Feb 2022 10:34:12 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id x13sm15307236wru.28.2022.02.01.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:34:11 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, wens@csie.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: cedrus: Add watchdog for job completion
Date:   Tue,  1 Feb 2022 19:33:24 +0100
Message-Id: <20220201183324.493542-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if job is not completed for whatever reason, userspace
application can hang on ioctl and thus become unkillable.

In order to prevent that, implement watchdog, which will complete job
after 2 seconds with error state.

Concept is borrowed from hantro driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  2 ++
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  3 +++
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  4 +++
 .../staging/media/sunxi/cedrus/cedrus_hw.c    | 25 +++++++++++++++++++
 .../staging/media/sunxi/cedrus/cedrus_hw.h    |  2 ++
 5 files changed, 36 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 4a4b714b0f26..68b3dcdb5df3 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -439,6 +439,8 @@ static int cedrus_probe(struct platform_device *pdev)
 
 	mutex_init(&dev->dev_mutex);
 
+	INIT_DELAYED_WORK(&dev->watchdog_work, cedrus_watchdog);
+
 	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register V4L2 device\n");
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index c345f2984041..3bc094eb497f 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -24,6 +24,7 @@
 
 #include <linux/iopoll.h>
 #include <linux/platform_device.h>
+#include <linux/workqueue.h>
 
 #define CEDRUS_NAME			"cedrus"
 
@@ -194,6 +195,8 @@ struct cedrus_dev {
 	struct reset_control	*rstc;
 
 	unsigned int		capabilities;
+
+	struct delayed_work	watchdog_work;
 };
 
 extern struct cedrus_dec_ops cedrus_dec_ops_mpeg2;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index a16c1422558f..9c7200299465 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -97,4 +97,8 @@ void cedrus_device_run(void *priv)
 		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
 
 	dev->dec_ops[ctx->current_codec]->trigger(ctx);
+
+	/* Start the watchdog timer. */
+	schedule_delayed_work(&dev->watchdog_work,
+			      msecs_to_jiffies(2000));
 }
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index 2d7663726467..a6470a89851e 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -118,6 +118,13 @@ static irqreturn_t cedrus_irq(int irq, void *data)
 	enum vb2_buffer_state state;
 	enum cedrus_irq_status status;
 
+	/*
+	 * If cancel_delayed_work returns false it means watchdog already
+	 * executed and finished the job.
+	 */
+	if (!cancel_delayed_work(&dev->watchdog_work))
+		return IRQ_HANDLED;
+
 	ctx = v4l2_m2m_get_curr_priv(dev->m2m_dev);
 	if (!ctx) {
 		v4l2_err(&dev->v4l2_dev,
@@ -143,6 +150,24 @@ static irqreturn_t cedrus_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void cedrus_watchdog(struct work_struct *work)
+{
+	struct cedrus_dev *dev;
+	struct cedrus_ctx *ctx;
+
+	dev = container_of(to_delayed_work(work),
+			   struct cedrus_dev, watchdog_work);
+
+	ctx = v4l2_m2m_get_curr_priv(dev->m2m_dev);
+	if (!ctx)
+		return;
+
+	v4l2_err(&dev->v4l2_dev, "frame processing timed out!\n");
+	reset_control_reset(dev->rstc);
+	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
+					 VB2_BUF_STATE_ERROR);
+}
+
 int cedrus_hw_suspend(struct device *device)
 {
 	struct cedrus_dev *dev = dev_get_drvdata(device);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
index 45f641f0bfa2..7c92f00e36da 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
@@ -28,4 +28,6 @@ int cedrus_hw_resume(struct device *device);
 int cedrus_hw_probe(struct cedrus_dev *dev);
 void cedrus_hw_remove(struct cedrus_dev *dev);
 
+void cedrus_watchdog(struct work_struct *work);
+
 #endif
-- 
2.35.1

