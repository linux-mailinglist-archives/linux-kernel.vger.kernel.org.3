Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A22B4B9712
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiBQDt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:49:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiBQDtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:49:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB7BC5DA4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:51 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id a26so2205250iot.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14+i519RyXRhGHkk7y/NizorIrgQMa72y8v5Vs7LOmo=;
        b=oHx5SA+pA20pWvzGLkJ4yhng4E+IvjuoVEMElPdEpgwBAXZX8Ayc2SvfCLXwvFcehP
         o0AHme5wuSQ63YxgN3QSc0rUbOV/j/+6G6zQRS4NCVt/yEL1Crq/uwf9UDEKebgjg//9
         QjwYPtTiQ0qXnz1UoGaup0sTfsdK8RdEHeUiQduq7H62ZAi7uIXJLbm6AdTtwuFcGXuD
         HV1h9OqMqWbRjdNwm8pC+0EWihoDDr44lxgfi0RIrrwF4+9Cz21iiE95YFoJBmglrB4c
         uqhiYzFY7DXRbPHXJsC8Kzs9wY0qwRswwrK0gBC7Y2uHlx1hH59CcbFMZGDMbalV1nve
         ffkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14+i519RyXRhGHkk7y/NizorIrgQMa72y8v5Vs7LOmo=;
        b=fgx2EXdO7UwfcUOsRUAVkGAxShYZOhTIqY4knDoYFyV2Xd8YyrTaU19mBR6U/RzRc7
         f8Ypxi86UboyqJ1JsRss4HejeEPm+BBG2DJw5tUMLYCaFvcSqq7pU6MfAwOPU2Dbm2M8
         Kn3Mh9WHtnyIjTRTqj16pXMXwHv+WUHymBh6v15beAwSy4+N5RY+pMvSzsmXxTAwLHvC
         hMLu6fNFszkK22yUBTnZI+3M8BvbGeHwNiKkA+P4sNw1KpIIEPefZmtmuYV05nLSnVfE
         ytYRNh+poWSQkLBM1udu9EW4fwtO3paFlC0C69wnYHpkDG0EYhP5U1cb3Gpy8ps44k72
         2XUQ==
X-Gm-Message-State: AOAM533Z4P/PSBrNKDJsWfLLDe/PIjbHnosnS9YHpBkdNJwW0oWStvUx
        oSeoQXVQLKnYSvydxTrNELc=
X-Google-Smtp-Source: ABdhPJwQdM+YASo9bZwGxmAll7Ye37UoRGfnFLBMbW70/Q8CqJm3xpdtwTbFefjn4OZb9vDTlUFoSw==
X-Received: by 2002:a05:6638:1350:b0:314:7f2a:ab14 with SMTP id u16-20020a056638135000b003147f2aab14mr717303jad.215.1645069731093;
        Wed, 16 Feb 2022 19:48:51 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:50 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 10/13] drm_print: refine drm_debug_enabled for dyndbg+jump-label
Date:   Wed, 16 Feb 2022 20:48:26 -0700
Message-Id: <20220217034829.64395-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217034829.64395-1-jim.cromie@gmail.com>
References: <20220217034829.64395-1-jim.cromie@gmail.com>
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

In order to use dynamic-debug's jump-label optimization in drm-debug,
its clarifying to refine drm_debug_enabled into 3 uses:

1.   drm_debug_enabled - legacy, public
2. __drm_debug_enabled - optimized for dyndbg jump-label enablement.
3.  _drm_debug_enabled - pr_debug instrumented, observable

1. The legacy version always checks the bits.

2. is privileged, for use by __drm_dbg(), __drm_dev_dbg(), which do an
early return unless the category is enabled (free of call/NOOP side
effects).  For dyndbg builds, debug callsites are selectively
"pre-enabled", so __drm_debug_enabled() short-circuits to true there.
Remaining callers of 1 may be able to use 2, case by case.

3. is 1st wrapped in a macro, with a pr_debug, which reports each
usage in /proc/dynamic_debug/control, making it observable in the
logs.  The macro lets the pr_debug see the real caller, not an inline
function.

When plugged into 1, it identified ~10 remaining callers of the
function, leading to the follow-on cleanup patch, and would allow
activating the pr_debugs, estimating the callrate, and the potential
savings by using the wrapper macro.  It is unused ATM, but it fills
out the picture.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c |  4 ++--
 include/drm/drm_print.h     | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index e45ba224e57c..92e6e18026da 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -262,7 +262,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
@@ -285,7 +285,7 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 06f0ee06be1f..38ef044d786e 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -319,11 +319,39 @@ enum drm_debug_category {
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
+
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
+
 /*
  * struct device based logging
  *
-- 
2.35.1

