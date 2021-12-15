Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71151475FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbhLORtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbhLORtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:49:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE2AC061574;
        Wed, 15 Dec 2021 09:49:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mj19so3181689pjb.3;
        Wed, 15 Dec 2021 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUVtrCNnk8frIGlEAr3SuG1vPO7+KGLAqJYvYc4iy+A=;
        b=oR3XGnx9gCRa5TXzS6XuouNT73Q+DQrbcvCbV+G11ig8CVDwOJmo44XZdAbLNw0aNf
         VbzyawLm6ABNu32UCmSm+FxcnJhbuZveJN17i59QPevj5udq/Ea6lt5T18nayrzHVk2M
         nTjMH6TFuRjPZPbJq/pbceH8JyKyUoOcqUSKde+39Z1qMGG1/6CEsy2FVD/hn2jF2tEP
         5TLoAj2lfj05JdJZ5fQpsfVZLgG01gaWfrqETAYPUrCY/mbmwrR5C5mHTRvsq1OeMxkl
         ZTh2TOZUWgfKKFJYLWvya0K6lm/veHmka8g/NY09MeOLLKjURMEc9qFMNXQIufSIaGK4
         1Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUVtrCNnk8frIGlEAr3SuG1vPO7+KGLAqJYvYc4iy+A=;
        b=wDU7+CJ54uPWVRD2+Qj+D2ZAotxraxTgJc/aEZSahWcv6iWcYp6LoxyJUQvf5wp8ml
         4qWoczGhbIPWiqi7Uwf1UrzKi0MkBl62ns9OIo+mWRQ0+1us0i1IZnF4BAjl4rIf81i/
         s+UDYqncBFJE+EmpxRRoeuEJwAVdo/uoMC6+oj8CyPU444d1gcaAV1xWN3bLhnjZEAMn
         Kg25dmxqZ8fK8LS52ow61UumUSQA4R9P1NfdACkt+VLoCuPRoRBmcjLPlrF4ndwT1JMG
         +b/BPK+lCcK0WWo2I5+vBIX8ou+B1McBt59vK6Z0nN5Yd0KCqRPMm4R4eIIRWqX2yOH8
         QpLg==
X-Gm-Message-State: AOAM532mHnJd5LVva2ChelrJcELMDjSl9Q5sFbNyhm05VDxNd6hgyTQQ
        W+3bjhPzsuiNtTitQo4aDDs=
X-Google-Smtp-Source: ABdhPJwqNMBqOZRqgL+tKj9rMhgWUHk026wb4PMY2y1lsuvGhmFoFrvfA0flILUcmfYhaUC1gPLJTw==
X-Received: by 2002:a17:90a:ac0b:: with SMTP id o11mr933541pjq.143.1639590563579;
        Wed, 15 Dec 2021 09:49:23 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id y31sm3892176pfa.92.2021.12.15.09.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:49:22 -0800 (PST)
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
        Guo Zhengkui <guozhengkui@vivo.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fernando Ramos <greenfoo@u92.eu>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] drm/msm/disp: Tweak display snapshot to match gpu snapshot
Date:   Wed, 15 Dec 2021 09:45:06 -0800
Message-Id: <20211215174524.1742389-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215174524.1742389-1-robdclark@gmail.com>
References: <20211215174524.1742389-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add UTS_RELEASE and show timestamp the same way for consistency.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.h      | 4 ++--
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
index 4c619307612c..31ad68be3391 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
@@ -39,7 +39,7 @@
  * @dev: device pointer
  * @drm_dev: drm device pointer
  * @atomic_state: atomic state duplicated at the time of the error
- * @timestamp: timestamp at which the coredump was captured
+ * @time: timestamp at which the coredump was captured
  */
 struct msm_disp_state {
 	struct device *dev;
@@ -49,7 +49,7 @@ struct msm_disp_state {
 
 	struct drm_atomic_state *atomic_state;
 
-	ktime_t timestamp;
+	struct timespec64 time;
 };
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 2e1acb1bc390..5d2ff6791058 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -5,6 +5,8 @@
 
 #define pr_fmt(fmt)	"[drm:%s:%d] " fmt, __func__, __LINE__
 
+#include <generated/utsrelease.h>
+
 #include "msm_disp_snapshot.h"
 
 static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *base_addr)
@@ -79,10 +81,11 @@ void msm_disp_state_print(struct msm_disp_state *state, struct drm_printer *p)
 	}
 
 	drm_printf(p, "---\n");
-
+	drm_printf(p, "kernel: " UTS_RELEASE "\n");
 	drm_printf(p, "module: " KBUILD_MODNAME "\n");
 	drm_printf(p, "dpu devcoredump\n");
-	drm_printf(p, "timestamp %lld\n", ktime_to_ns(state->timestamp));
+	drm_printf(p, "time: %lld.%09ld\n",
+		state->time.tv_sec, state->time.tv_nsec);
 
 	list_for_each_entry_safe(block, tmp, &state->blocks, node) {
 		drm_printf(p, "====================%s================\n", block->name);
@@ -100,7 +103,7 @@ static void msm_disp_capture_atomic_state(struct msm_disp_state *disp_state)
 	struct drm_device *ddev;
 	struct drm_modeset_acquire_ctx ctx;
 
-	disp_state->timestamp = ktime_get();
+	ktime_get_real_ts64(&disp_state->time);
 
 	ddev = disp_state->drm_dev;
 
-- 
2.33.1

