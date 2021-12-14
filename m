Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76A47498B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhLNReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbhLNReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:34:14 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B1C061574;
        Tue, 14 Dec 2021 09:34:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x131so18411009pfc.12;
        Tue, 14 Dec 2021 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGWQoMYzhBAB2IQM3xcDS7ekxQKFM3AGil27CIrS8Io=;
        b=kpOVXTp9O8u083FN0cDMv8QEMx6qzsDj6dhRCQ/hhAFstQHJz+m13Py9LbAYcWOiJ2
         Jb10Xbw3L64I2D5Mc6rCmDww4uuiEbqqLKjGomPdT8eU9aWjqThycArxhL8p0FpFGnxj
         7TeuJXz2xtmgM92cEOJpuTsZGAd5gaxpDgDAQmUr5iYPW2tPvkuofMtHCmKNl/A4uVYm
         0RygnF9/Idj3dNJ/o7DQIYDalTQVLM3R9magmlOc7M4nhp98HCs0+8UXUVS3WxvGfiFm
         v9SPZSqXk43i/19vMwrF/7iBM8TT3ef746SOVAn3YBnvf/0azyoON3+gSZVlajKZd5CI
         uxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGWQoMYzhBAB2IQM3xcDS7ekxQKFM3AGil27CIrS8Io=;
        b=XI4qcMOeZJehD98dE96MNi1uzqXvJPccSKWKGeV5o+Zbsnd9dtW1X/72V2+4WJ3OlW
         2YIgofLP2ZdISdbKxQosn1yIq4r/f+MyEnNHuYn1lYYzvgagQv17YcTMs5hDUTa6oDTR
         0uFUdX7aZKuFTRbqS/7Zj+zZVff5vpGsFEcCXVD6mFci1cQkNOi1CrrrOfnc5fvKF5VP
         VpjQGr0FdOHL9pbuVPu0NS2n+xdx62X7lkw+xbzBl3qLcyDKvKmxSJ8IJrY4aY11TWHy
         cKxPAfkuJJobAXz3vTnOP2nApRVdoKxcDA0/JEZak5//bB+TURUECKqIn4C+1Oz2TQtX
         QaGw==
X-Gm-Message-State: AOAM531vtrkh+24jkt77hGn3mi0ODxfenFt17eNCJNUPd8HB2SqVPgR1
        ynpJsD2sdxl/rZM4Xyt4AYM=
X-Google-Smtp-Source: ABdhPJxM83Psw3lwIth4QeOPBbLdhAmJzqzCXZCXy1ejGpDzB8vLX8oSXAQcnAmfPI6/Pk6VfdW1cQ==
X-Received: by 2002:aa7:93ce:0:b0:4a8:19fc:f024 with SMTP id y14-20020aa793ce000000b004a819fcf024mr5328681pff.10.1639503253926;
        Tue, 14 Dec 2021 09:34:13 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id y65sm310696pgd.79.2021.12.14.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:34:13 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/msm/debugfs: Add display/kms state snapshot
Date:   Tue, 14 Dec 2021 09:39:01 -0800
Message-Id: <20211214173917.1496290-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211214173917.1496290-1-robdclark@gmail.com>
References: <20211214173917.1496290-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 90 +++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 956b1efc3721..088f1160c892 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -15,6 +15,11 @@
 #include "msm_gpu.h"
 #include "msm_kms.h"
 #include "msm_debugfs.h"
+#include "disp/msm_disp_snapshot.h"
+
+/*
+ * GPU Snapshot:
+ */
 
 struct msm_gpu_show_priv {
 	struct msm_gpu_state *state;
@@ -109,6 +114,88 @@ static const struct file_operations msm_gpu_fops = {
 	.release = msm_gpu_release,
 };
 
+/*
+ * Display Snapshot:
+ */
+
+struct msm_kms_show_priv {
+	struct msm_disp_state *state;
+	struct drm_device *dev;
+};
+
+static int msm_kms_show(struct seq_file *m, void *arg)
+{
+	struct drm_printer p = drm_seq_file_printer(m);
+	struct msm_kms_show_priv *show_priv = m->private;
+
+	msm_disp_state_print(show_priv->state, &p);
+
+	return 0;
+}
+
+static int msm_kms_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct msm_kms_show_priv *show_priv = m->private;
+
+	msm_disp_state_free(show_priv->state);
+	kfree(show_priv);
+
+	return single_release(inode, file);
+}
+
+static int msm_kms_open(struct inode *inode, struct file *file)
+{
+	struct drm_device *dev = inode->i_private;
+	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_kms_show_priv *show_priv;
+	int ret;
+
+	if (!priv->kms)
+		return -ENODEV;
+
+	show_priv = kmalloc(sizeof(*show_priv), GFP_KERNEL);
+	if (!show_priv)
+		return -ENOMEM;
+
+	ret = mutex_lock_interruptible(&priv->kms->dump_mutex);
+	if (ret)
+		goto free_priv;
+
+	show_priv->state = msm_disp_snapshot_state_sync(priv->kms);
+
+	mutex_unlock(&priv->kms->dump_mutex);
+
+	if (IS_ERR(show_priv->state)) {
+		ret = PTR_ERR(show_priv->state);
+		goto free_priv;
+	}
+
+	show_priv->dev = dev;
+
+	ret = single_open(file, msm_kms_show, show_priv);
+	if (ret)
+		goto free_priv;
+
+	return 0;
+
+free_priv:
+	kfree(show_priv);
+	return ret;
+}
+
+static const struct file_operations msm_kms_fops = {
+	.owner = THIS_MODULE,
+	.open = msm_kms_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = msm_kms_release,
+};
+
+/*
+ * Other debugfs:
+ */
+
 static unsigned long last_shrink_freed;
 
 static int
@@ -239,6 +326,9 @@ void msm_debugfs_init(struct drm_minor *minor)
 	debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
 		dev, &msm_gpu_fops);
 
+	debugfs_create_file("kms", S_IRUSR, minor->debugfs_root,
+		dev, &msm_kms_fops);
+
 	debugfs_create_u32("hangcheck_period_ms", 0600, minor->debugfs_root,
 		&priv->hangcheck_period);
 
-- 
2.33.1

