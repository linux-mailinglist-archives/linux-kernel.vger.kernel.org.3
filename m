Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B2B4872C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346410AbiAGFav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346205AbiAGFaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:05 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F876C061212;
        Thu,  6 Jan 2022 21:30:05 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id h23so5776360iol.11;
        Thu, 06 Jan 2022 21:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0urLO3I3y9RJ2BqZiVIn4AxdODRtFQ4HWGOlAS/PKA=;
        b=EdMk5S4qxg+IvtCJJesbywIliZbPLs1Ba2Zuk+Chr0N/6pldmZrHxH6ql2FlgEiiUH
         FnNeUPOZyS0SPx2vf9zfWWylETk2T9iQqUXxiMvluDJ4ZFx7HEzDy/6qR7VwTWegKFEQ
         EkYg+mpmf7s+rQP5bwZWzVaFSWCJ44//tSJ+Ay67a7gAMMZu41gsxIs/FfPdQzxw5nu6
         o8b7YjJnM0VqQ6AI2zmZhsK12BCYNtAdMCgKDpkW5WUWpk7rMUwbq+Lpey9d7QKm/DI/
         zvb+FPkSR7wGjIg4c6HdyhGMjQqHp4bN/Csfc2TnL94i3DQfEWZ/PQ/mNaXckduheRyG
         7kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0urLO3I3y9RJ2BqZiVIn4AxdODRtFQ4HWGOlAS/PKA=;
        b=X6+106fxowPIqQ7SJYTfxXXIbD1hkm+pXkHZ9uPsCqxhiATvLeeZuhXYLQecLaTYCZ
         a2kpHAEY/nS85oqY/PPMbXE6LYut9rvDu+4m9YRKygOLnHvudSxvCraqqgHduu+KJFH6
         PyulpZ4zAflbQ6MxxNqWcJKTzC5IdYY8RpAaBZc56jR+OtWaMWPMoOf7pWuBNjroL7ro
         MhzVGuqZRuxTkr0f1stKAPCFGA3Vr5Ve0dH7awgSjHop/FHqGkhQawoKJ0cjNr6Zc7/q
         caXSqvBS8341L6bFFcjyQZxgdZnVp/9MWde5WaFAnqFaxUgQrWYRrpL/1olTXuuxSznG
         Eclg==
X-Gm-Message-State: AOAM5305rLp16XFTuyJKsrBvoM6rHRjFuy4Q6Rg0X0G8BHJVQVvjU32I
        70M7U8d4/HwJCbLFgi/XHJcI1RdAIuU=
X-Google-Smtp-Source: ABdhPJxQ+uyoXwjAObJKgimGggABXHR+0a+JXdXUWplJy2XxxqeRTe3P3YMMZ4MRonvQBUhFbE6T8g==
X-Received: by 2002:a05:6638:1442:: with SMTP id l2mr32029078jad.186.1641533404530;
        Thu, 06 Jan 2022 21:30:04 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:04 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v11 12/19] drm_print: wrap drm_dbg in _dynamic_func_call_no_desc
Date:   Thu,  6 Jan 2022 22:29:35 -0700
Message-Id: <20220107052942.1349447-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __drm_dbg() macro to be CONFIG_DRM_USE_DYNAMIC_DEBUG dependent:
  N- keep straight mapping to exported ___drm_dbg()
  Y- wrap ___drm_dbg() inside _dynamic_func_call_no_desc()

This patch places ~1/2 of drm.debug API messages behind dyndbg's
JUMP_LABEL/NOOP optimization.

The CONFIG_DRM_USE_DYNAMIC_DEBUG dependence is due to the .data
footprint cost of per-callsite control; 56 bytes/site * ~2k,3k
callsites (for i915, amdgpu), which is significant enough to make
optional.

bash-5.1# drms_load
[    7.489844] dyndbg: 239 debug prints in module drm
[    7.494010] ACPI: bus type drm_connector registered
[    7.546076] dyndbg:  81 debug prints in module drm_kms_helper
[    7.555723] dyndbg:   2 debug prints in module ttm
[    7.558920] dyndbg:   8 debug prints in module video
[    8.074699] dyndbg: 431 debug prints in module i915
[    8.158682] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[    8.574456] dyndbg: 3817 debug prints in module amdgpu
[    8.589962] [drm] amdgpu kernel modesetting enabled.
[    8.590548] amdgpu: CRAT table not found
[    8.590998] amdgpu: Virtual CRAT table created for CPU
[    8.591634] amdgpu: Topology: Add CPU node
[    8.636446] dyndbg:   3 debug prints in module wmi
[    8.768667] dyndbg:  24 debug prints in module nouveau

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 1eef315a0a65..8d6b74270c50 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -319,10 +319,36 @@ enum drm_debug_category {
 	DRM_UT_DRMRES
 };
 
+/*
+ * 3 name flavors of drm_debug_enabled:
+ *   drm_debug_enabled - public/legacy, always checks bits
+ *  _drm_debug_enabled - instrumented to observe call-rates, est overheads.
+ * __drm_debug_enabled - privileged - knows jump-label state, can short-circuit
+ */
 static inline bool drm_debug_enabled(enum drm_debug_category category)
 {
 	return unlikely(__drm_debug & BIT(category));
 }
+/*
+ * Wrap fn in macro, so that the pr_debug sees the actual caller, not
+ * the inline fn.  Using this name creates a callsite entry / control
+ * point in /proc/dynamic_debug/control.
+ */
+#define _drm_debug_enabled(category)				\
+	({							\
+		pr_debug("todo: maybe avoid via dyndbg\n");     \
+		drm_debug_enabled(category);			\
+	})
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+/*
+ * dyndbg is wrapping the drm.debug API, so as to avoid the runtime
+ * bit-test overheads of drm_debug_enabled() in those api calls.
+ * In this case, executed callsites are known enabled, so true.
+ */
+#define __drm_debug_enabled(category)	true
+#else
+#define __drm_debug_enabled(category)	drm_debug_enabled(category)
+#endif
 
 /*
  * struct device based logging
@@ -497,7 +523,13 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...);
 __printf(1, 2)
 void __drm_err(const char *format, ...);
 
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define __drm_dbg(fmt, ...)		___drm_dbg(fmt, ##__VA_ARGS__)
+#else
+#define __drm_dbg(eCat, fmt, ...)					\
+	_dynamic_func_call_no_desc(fmt, ___drm_dbg,			\
+				   eCat, fmt, ##__VA_ARGS__)
+#endif
 
 /* Macros to make printk easier */
 
@@ -569,7 +601,7 @@ void __drm_err(const char *format, ...);
 	static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);\
 	const struct drm_device *drm_ = (drm);							\
 												\
-	if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))			\
+	if (__drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))			\
 		drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);	\
 })
 
-- 
2.33.1

