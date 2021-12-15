Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9D475FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbhLORtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhLORtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:49:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46070C061401;
        Wed, 15 Dec 2021 09:49:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id co15so1617800pjb.2;
        Wed, 15 Dec 2021 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcfVA2uBNe/X9h6wuhZ5EuU1xWQlNWZCg+pNTH+2meY=;
        b=kIp4kYBkdDDru9e4HJrZZx1Mqq/lPJBOIQxaWAsqiDdm5RVCVoj8s/WNVOAt2apkEx
         ehoLvfo0+fBHvEsFhC0tCoKyHUtmWXT/Ecsn1nSwftN1qUFJmUuEAQZ1jKtM3Xd3WTwa
         cnM8BMDTbbYcRQt61uaFQrp/TA68fpZv5INyMdhWf5322Jf/2TfxfXaTvCdmk4gU0Jpv
         ljXrNLt8ooqMdRZS95G+BM7KKfsmaGofA29Yl+FKKidVMQNBD7a7NtwUD1ePxcgFqOm2
         0EHLFM7xvi/1la+RR5HsxUEyIY+XvK32s/BtNI7ijOH5ufs2fpUvG8OntcmSw9UURLuy
         V9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcfVA2uBNe/X9h6wuhZ5EuU1xWQlNWZCg+pNTH+2meY=;
        b=61sE/vDM7tLLIN7OgCdzin72QdH6NR+gcQSy3T9pXUF5Ka8A1lBWAYhXBeAUbse5R6
         wHo/UO9v0az2Ni3NY+Zn+o3YIzyYdE5iE4vtQPbug+xXOCKsgOIVq7JUCAiZ/TtW0iA5
         gJyXyJvx2TX76JEHgRqIPEiJm2b6c+ssRCMo4DvPYB+voKnf4JLkc0gdJaIVOuRnUF/N
         BNXN+KpfDtMO62EnI2JNarYHPYJnW7gemKpx9UMummiRpGFaq6LLmeOPC27gp/tkbC9S
         xgvPwzc76JKpo28s/GrzuzKZ63SuzK758cgoDbytoB/h4JKu9pN64u14kegwpGWWxZtI
         W8dg==
X-Gm-Message-State: AOAM530izj2Xng7VgGa3a5OASxBGPgi8YjIiY8l26iiwNM2hgPM47Ovd
        EkxlSDSMB1PAfL4SjzNlU5E=
X-Google-Smtp-Source: ABdhPJx1Bx8yaUPuKlzM1Tz2ZDpWlyHvRiqC3BiqYmeoSCToMSDaurYg6b8JjJUEdJA2daCWrJD6wQ==
X-Received: by 2002:a17:902:e54d:b0:148:a2e8:278a with SMTP id n13-20020a170902e54d00b00148a2e8278amr5386218plf.145.1639590574740;
        Wed, 15 Dec 2021 09:49:34 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id n3sm2976279pgc.76.2021.12.15.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:49:33 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm/msm/debugfs: Add display/kms state snapshot
Date:   Wed, 15 Dec 2021 09:45:08 -0800
Message-Id: <20211215174524.1742389-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215174524.1742389-1-robdclark@gmail.com>
References: <20211215174524.1742389-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
v2: Drop unneeded msm_kms_show_priv [Dmitry B]

 drivers/gpu/drm/msm/msm_debugfs.c | 75 +++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 956b1efc3721..0804c31e8962 100644
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
@@ -109,6 +114,73 @@ static const struct file_operations msm_gpu_fops = {
 	.release = msm_gpu_release,
 };
 
+/*
+ * Display Snapshot:
+ */
+
+static int msm_kms_show(struct seq_file *m, void *arg)
+{
+	struct drm_printer p = drm_seq_file_printer(m);
+	struct msm_disp_state *state = m->private;
+
+	msm_disp_state_print(state, &p);
+
+	return 0;
+}
+
+static int msm_kms_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct msm_disp_state *state = m->private;
+
+	msm_disp_state_free(state);
+
+	return single_release(inode, file);
+}
+
+static int msm_kms_open(struct inode *inode, struct file *file)
+{
+	struct drm_device *dev = inode->i_private;
+	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_disp_state *state;
+	int ret;
+
+	if (!priv->kms)
+		return -ENODEV;
+
+	ret = mutex_lock_interruptible(&priv->kms->dump_mutex);
+	if (ret)
+		return ret;
+
+	state = msm_disp_snapshot_state_sync(priv->kms);
+
+	mutex_unlock(&priv->kms->dump_mutex);
+
+	if (IS_ERR(state)) {
+		return PTR_ERR(state);
+	}
+
+	ret = single_open(file, msm_kms_show, state);
+	if (ret) {
+		msm_disp_state_free(state);
+		return ret;
+	}
+
+	return 0;
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
@@ -239,6 +311,9 @@ void msm_debugfs_init(struct drm_minor *minor)
 	debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
 		dev, &msm_gpu_fops);
 
+	debugfs_create_file("kms", S_IRUSR, minor->debugfs_root,
+		dev, &msm_kms_fops);
+
 	debugfs_create_u32("hangcheck_period_ms", 0600, minor->debugfs_root,
 		&priv->hangcheck_period);
 
-- 
2.33.1

