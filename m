Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68EE475FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbhLORtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbhLORtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:49:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3EC061574;
        Wed, 15 Dec 2021 09:49:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so19959975pjb.1;
        Wed, 15 Dec 2021 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TKn9BEzW+NQEp96roozEjZVgCiZc4QtW5+v79OS1QU=;
        b=nGDCosfqZCu/zS/RAlfY8elb53ao7fxGZPqQw0tWcg5ogCCqlzg+UdxtJhGTgyf0aQ
         ufbS+/DJdChk2dD2DiarbEQicN+vgumN4cA36W92TZywuANIlIj5h3conY79G8hJ1ZJE
         YrZz1jleDN8f2gnsGXE00YLIIEb50fxeQShvOXqeRDZTlW/ACxqJFU0AtuxpyN+8LlYo
         5qhiuhDiy86MFNHil1YdxetlB+BRgGF9g/i6vCxo+4S3lwP2SY6x2GkbDXBD5VmL3Fzz
         17qi37CJt3OY/er5jljgspVCpFpzKSSnVqVEuRDOSuXN8XefhSNFO0jBVjtwCp2rFSfC
         QNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TKn9BEzW+NQEp96roozEjZVgCiZc4QtW5+v79OS1QU=;
        b=EPnZndVsQl+dWCpv53p38YY4ilX8kSUIYgtG2rnbhZ+soHqOgTj/V27b/vvfhx3gx4
         R/zEWosbuJgOEFryf2VAg0dJMZt4rxHXj4mCeaasNUQty6lwwP6kBdwA86avZpaPnX02
         Gk0mbwb92JKkAME/n29yg2nL98WKknvGMRe1RapTA30/7ghXDwvn/mOPkv1kq+nmJAGv
         WztaMU3+/koBK8cG5oPih2UPLhc7RdP29yTfOltYPTwqPLLZWovdunJ6r5wK+rNlGrhZ
         i4vJxBb46yOQZJDwF8Hl9kf5JSXLFjxj8OBf/lHrBHwjeg0U3skO8SBJJhpx9eq+m0b+
         /P7A==
X-Gm-Message-State: AOAM530ygCrSHRdAagVs5aCC6vKJghzRSLnmO6TBk4rD1SkzAuu+Vct7
        NY9Svs5BG8ozE8eAPppILD8=
X-Google-Smtp-Source: ABdhPJwIokaKODcNaYVxdUhtojJD2kgv43r1kdDbhVUxeVvjlOIrG+/EfYyaui0AYEGeRB6RlSOggw==
X-Received: by 2002:a17:902:c215:b0:148:af14:6e96 with SMTP id 21-20020a170902c21500b00148af146e96mr2284357pll.80.1639590572674;
        Wed, 15 Dec 2021 09:49:32 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id k91sm3853810pja.1.2021.12.15.09.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:49:31 -0800 (PST)
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
        Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/msm/disp: Export helper for capturing snapshot
Date:   Wed, 15 Dec 2021 09:45:07 -0800
Message-Id: <20211215174524.1742389-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215174524.1742389-1-robdclark@gmail.com>
References: <20211215174524.1742389-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

We'll re-use this for debugfs.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 28 +++++++++++++++-----
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.h | 10 +++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
index a4a7cb06bc87..580ea01b13ab 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
@@ -28,29 +28,43 @@ static ssize_t __maybe_unused disp_devcoredump_read(char *buffer, loff_t offset,
 	return count - iter.remain;
 }
 
-static void _msm_disp_snapshot_work(struct kthread_work *work)
+struct msm_disp_state *
+msm_disp_snapshot_state_sync(struct msm_kms *kms)
 {
-	struct msm_kms *kms = container_of(work, struct msm_kms, dump_work);
 	struct drm_device *drm_dev = kms->dev;
 	struct msm_disp_state *disp_state;
-	struct drm_printer p;
+
+	WARN_ON(!mutex_is_locked(&kms->dump_mutex));
 
 	disp_state = kzalloc(sizeof(struct msm_disp_state), GFP_KERNEL);
 	if (!disp_state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
 	disp_state->dev = drm_dev->dev;
 	disp_state->drm_dev = drm_dev;
 
 	INIT_LIST_HEAD(&disp_state->blocks);
 
-	/* Serialize dumping here */
-	mutex_lock(&kms->dump_mutex);
-
 	msm_disp_snapshot_capture_state(disp_state);
 
+	return disp_state;
+}
+
+static void _msm_disp_snapshot_work(struct kthread_work *work)
+{
+	struct msm_kms *kms = container_of(work, struct msm_kms, dump_work);
+	struct drm_device *drm_dev = kms->dev;
+	struct msm_disp_state *disp_state;
+	struct drm_printer p;
+
+	/* Serialize dumping here */
+	mutex_lock(&kms->dump_mutex);
+	disp_state = msm_disp_snapshot_state_sync(kms);
 	mutex_unlock(&kms->dump_mutex);
 
+	if (IS_ERR(disp_state))
+		return;
+
 	if (MSM_DISP_SNAPSHOT_DUMP_IN_CONSOLE) {
 		p = drm_info_printer(disp_state->drm_dev->dev);
 		msm_disp_state_print(disp_state, &p);
diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
index 31ad68be3391..b5f452bd7ada 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
@@ -84,6 +84,16 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev);
  */
 void msm_disp_snapshot_destroy(struct drm_device *drm_dev);
 
+/**
+ * msm_disp_snapshot_state_sync - synchronously snapshot display state
+ * @kms:  the kms object
+ *
+ * Returns state or error
+ *
+ * Must be called with &kms->dump_mutex held
+ */
+struct msm_disp_state *msm_disp_snapshot_state_sync(struct msm_kms *kms);
+
 /**
  * msm_disp_snapshot_state - trigger to dump the display snapshot
  * @drm_dev:	handle to drm device
-- 
2.33.1

