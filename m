Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934BE474981
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhLNReI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhLNReE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:34:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17CEC061574;
        Tue, 14 Dec 2021 09:34:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oa5-20020a17090b1bc500b001b0f8a5e6b7so1082163pjb.0;
        Tue, 14 Dec 2021 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUVtrCNnk8frIGlEAr3SuG1vPO7+KGLAqJYvYc4iy+A=;
        b=QYLlFH9FpeWFS2PwTDPc0EDINf2Id7qpanDiTq5Q+PuxvJI8hRirI+cHVv5MGojHZl
         AvLXg49z6SmaCDpHdvTISH0ku+8iDj2W2hrEmwldCkOKIx9IFrf7MZJ9mIoYxjVA/if2
         y8Vv5uuWgShUommqoK3oR1+j6P1nRema/5bbhydrFoHkFDKMdvHuGQQ4U26hEoBwP09i
         Nc3hEeEF7rfuY680wOGZXZy1xs+GVlGd1rIOkghSvnK18EDB6eSfkXP45ODiDIbuVIHs
         M3ebhAZIfocoY/QmhcXzFxqpTw/OUwdKU+4972frpQJ0X9ALfHOgChnJ9gXESwzEN2rF
         W43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUVtrCNnk8frIGlEAr3SuG1vPO7+KGLAqJYvYc4iy+A=;
        b=SDnhnGoVlHMqSc02T4PHEwhMZsv0PZ/b6Dx/6wS5KAV4cTejDDk6tjkifBMs3TO3IM
         b6iJJURD9AXfhGQFSy01/9a40+2BoDKOMgC7+jof8PMc1GSrc7uRRESrWQpmj3+/c4rY
         MgiQr7ZpauuJ7pDy9XKFvsQA/GV2+W/Fx7f3SfwdWG53rfEwOMdwf+SWiiPrS9hUHDYK
         VdF1hpQ0e5geQiDsxFb7bLwco6vZoccpCap/IG1UWaGCkDmAjbrnkFdt3f625ivRJBfr
         4q3eX04R7LSmXYiqEBqa1IJxXHuF8yaCQK539GyT2qewbiQ1z+oNSTgQ96TUteg7m2/M
         njgg==
X-Gm-Message-State: AOAM532aqav9MnVBcN9JeKvI5YnX5sTCj91q/5rxgf6fmWgcqwccp+68
        djvHPv8x6H8g0ZEoo/j4kRA=
X-Google-Smtp-Source: ABdhPJxAyllQpKMu/4CPDbcm2YjXlO5GMQ+PNFz4glkbUUosre2l6gEZOKb+tkDVGNMfOGN4INeIVQ==
X-Received: by 2002:a17:903:230d:b0:141:e3ce:2738 with SMTP id d13-20020a170903230d00b00141e3ce2738mr6835284plh.57.1639503243290;
        Tue, 14 Dec 2021 09:34:03 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id y18sm384629pfp.190.2021.12.14.09.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:34:02 -0800 (PST)
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
        Alexey Dobriyan <adobriyan@gmail.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Fernando Ramos <greenfoo@u92.eu>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/msm/disp: Tweak display snapshot to match gpu snapshot
Date:   Tue, 14 Dec 2021 09:38:59 -0800
Message-Id: <20211214173917.1496290-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211214173917.1496290-1-robdclark@gmail.com>
References: <20211214173917.1496290-1-robdclark@gmail.com>
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

