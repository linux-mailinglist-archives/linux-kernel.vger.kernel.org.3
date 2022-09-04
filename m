Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C55AC713
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiIDVoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiIDVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:43:24 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B382F3B8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k2so3867811ilu.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Yz1nHWqmg1d//jI5WL7ehO+9XBH0wkH/Bsd6VUk2Nqk=;
        b=AK+43dpGRirTw4nNfvr173iCsOdOocOg1R4PrjXeYFMuE6BHzNx4/JyS2/Hs12JMwR
         arAb0AoFD3lLvnp+XMkj+nWBX4byPR8fWvDR9CUjvDV5RC/AcQEP8uncq985GYHJU6ZV
         Y1NZeglyoj+4PmVpyOb5acskIwIX7OJWl0g7dKKda3S5vGjIzl3tKiY/y8lQr42zk5mL
         0kqpDAV5CIhV4bkqTSSNFO+cqJYPRqlUFUEUtUB21hy9TbrmlNQfyn3Yfv+pNchiW5lP
         omQ1D670173DGSz8AJfJF3mWC72dET7qdHGew94KumgAoocW1dkvnKB5l0zMBDpdb6qQ
         wgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Yz1nHWqmg1d//jI5WL7ehO+9XBH0wkH/Bsd6VUk2Nqk=;
        b=wrWdD5DCeuwxIKmi8edwooIcWywqt3OjpL8zqDahPx8JbsVW9NE6o54pZNBz375bvW
         UOeQ9pMC3GvOkyXHSHc6XnrhcPD1AqXd+eONzfXyPH3oluJItvjBh5PoBXTHV3slO8O0
         nWUQW3w/nx+pF7dhWWr7nHhpaOc3Tc5luANf8KAq3jLnMr5rO3FrR/tE0k0gT+GphOHI
         NiONNrfcvo0RcNqdk/UL/+RGPnqqG+N4Xy3SOAZ/7rCXTOc3WxJK3kMesv31u1KTMsUG
         qSaVOj0DePbh/B6f7o2V76koDWvI0CoI9lPABCtfbDShGwR2LOfDEWkTrtEd5vIZs530
         Fdwg==
X-Gm-Message-State: ACgBeo0f7DPyUuXftzdLJXOms4AwPerT2SWMn1DxGIW0XX7etICLcSbM
        t4ydKY3LtGQxh+lW0YhEVrQ=
X-Google-Smtp-Source: AA6agR7r6U93/s1yKE4uP9xLO0qO4rTXytRbBRYsXbjE4vP4auvFXzNw8l/Z1/hxoQSGO8wQE4MxOA==
X-Received: by 2002:a92:d708:0:b0:2eb:603a:f6fc with SMTP id m8-20020a92d708000000b002eb603af6fcmr12394161iln.225.1662327757031;
        Sun, 04 Sep 2022 14:42:37 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 28/57] drm_print: refine drm_debug_enabled for jump-label
Date:   Sun,  4 Sep 2022 15:41:05 -0600
Message-Id: <20220904214134.408619-29-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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
early return unless the category is enabled.  For dyndbg builds, debug
callsites are selectively "pre-enabled", so __drm_debug_enabled()
short-circuits to true there.  Remaining callers of 1 may be able to
use 2, case by case.

3. is 1st wrapped in a macro, with a pr_debug, which reports each
usage in /proc/dynamic_debug/control, making it observable in the
logs.  The macro lets the pr_debug see the real caller, not an inline
function.

When plugged into 1, 3 identified ~10 remaining callers of the
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
index 29a29949ad0b..cb203d63b286 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -285,7 +285,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
@@ -308,7 +308,7 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index dfdd81c3287c..7631b5fb669e 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -321,11 +321,39 @@ enum drm_debug_category {
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
2.37.2

