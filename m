Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72497474983
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhLNReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbhLNReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:34:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACD2C061574;
        Tue, 14 Dec 2021 09:34:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id oa5-20020a17090b1bc500b001b0f8a5e6b7so1082610pjb.0;
        Tue, 14 Dec 2021 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TKn9BEzW+NQEp96roozEjZVgCiZc4QtW5+v79OS1QU=;
        b=IX7MQPa9jV3smphAxA9+bp9TECF4Hsp5W/Ab79KnhP7ylXRd78v3wf1zgGgi1p26ue
         il9d6VnYxzw0+aqW857C4l3Ym+635Poc98wVk4QPZntFsRLvl+GZNiyrwwV/eGlYUVCB
         CgW6F7tfDpXNo7RlXdRdnF7tIlbikbAy6MiavksxujqOJkrhgUquSo+w7jiW7qZxt0ju
         7GRBW1fCRbdRakmYhDonrHKqz8dfMbneZuqPuaJQ9FENfviec17UvnSsevAW4pYqCx0H
         9x4tqzcbix4TWBHBxenFFhi3sZs1xM5v+DDspB8tG33RSUNcYIwoPqxy8pHFXhi5VODH
         OVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TKn9BEzW+NQEp96roozEjZVgCiZc4QtW5+v79OS1QU=;
        b=r/Zah9KD8/t4t0XxoX+Z5kkbjJA5F7Hq6aUAnjKO78wbunz4WuIDYnljeGcaeQVFID
         anw90aBoH0Xzpg8oQIl8y70BYVWrjgL9ZYiW/whO/wIW/Prm0SKmZHV2llWjPNAAlRCK
         RliqB8elnamu1SK2SsQVbMdx7xDI1XWjtLVgjqPnXXj2bTLsTQnyRL/LrNeidlo8m3Ks
         YJGiMGLIjGjJUIK7F9dxqj0oCJqzZQuNE7KT85d1u6a863CwTypHryU1U5lS1f5yUNEN
         qgG9UG6/f/cVkDH/CeqfR56FQwNxwPh6RfW+Ed8y9IYCiOHYxe47qtQw7mCIqUMZftVI
         ahjw==
X-Gm-Message-State: AOAM530OsiNoR62dvhHdwrE1AEm1SZHQNdpDyGxfa0e/gkLRwIuuxhLO
        go3IYT9oIjznOCWELugAsNo=
X-Google-Smtp-Source: ABdhPJyI1ocy09TalCTGQgEActZJ6yyfVRJ2uUV35cURRdHsIPafebqn+w8KFuzJHwYZZxumdCIerg==
X-Received: by 2002:a17:90a:bf8a:: with SMTP id d10mr7061487pjs.67.1639503251776;
        Tue, 14 Dec 2021 09:34:11 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id fs21sm2531167pjb.1.2021.12.14.09.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:34:10 -0800 (PST)
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/msm/disp: Export helper for capturing snapshot
Date:   Tue, 14 Dec 2021 09:39:00 -0800
Message-Id: <20211214173917.1496290-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211214173917.1496290-1-robdclark@gmail.com>
References: <20211214173917.1496290-1-robdclark@gmail.com>
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

