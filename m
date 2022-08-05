Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550B158B1DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbiHEV5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiHEVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158817D1DD;
        Fri,  5 Aug 2022 14:54:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p82so2865313iod.2;
        Fri, 05 Aug 2022 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2ptm0C+TAgay7iDeZMdRBvd/IWOnljmKY3NHUsB11LE=;
        b=XN3wX4KJsZDlX/MycOJGDI6oN6r8wbmHJB5E4szTDTi/t4qGngJEwX2oEZEzR7Z0Pi
         pvJapAQwgPtqFmakcn3lcGCaDVe1UYJGmTzDMvrYLrNjdZlf8W+kSGJt3DQ/7d9kWRCT
         yzDXmBMr6n1LNloRiHqaI9tUWBTJZ3j6TZGkg6ps9rZJKUz+ATmejEaGLuQdtNJS5m5I
         SBcvhfAllufZZSizfZazMLWLt43fZbv2uKcgLJgPWxSrB5oo0hMsKfFZ6Zac20mFprLQ
         Ke0APEiVp2sNLHmcN0Tk5GXxxpoW3WRqnpP/umQASxQEN+jJByg2OpUmMHpqRrkgQ0Q3
         WgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2ptm0C+TAgay7iDeZMdRBvd/IWOnljmKY3NHUsB11LE=;
        b=AFvEYco4gYBw96xxnICzsN/cMvfQSEEAaC5gE62ok6NfSdtx/XBHebeWssvFPPGv78
         ffx/hoG8n4i3OWSgPllq7t47CBgjYugNOQdeoWzlx1gMTtUNj3ECSrQW3C5+zl3mgVsu
         WFM3bxiKv+WKzDNgN55OitlC3kc1/qp3RqiKIXOt3YYa6lbeO1zcy+O9fEecHbDT/2Zw
         r763MqU1tMfF+xBQEqydUXeWOInpVZSjDFKjRXsoHTUaKGx6INlilVkNML2MPATs6XoW
         A6l18Ysc/DYlu9zEe90Fd9gXaigyp/pW3gow2OpN53a1s3WPDRu7OP8IuLdbWX2ZyH5P
         40rw==
X-Gm-Message-State: ACgBeo0chTxvoNZdaqpLfSsT9GgEFGk/u1sHIc4jalyOxVTi0/JcnxEh
        KPbL/TD8xzDuYAnrPiLgjPpN64OeRuK1qQ==
X-Google-Smtp-Source: AA6agR5iMxMPyUfhGJL9gITVCdPNGp9SnJZ3GtjVfFx6SKPwl38f+VGrOLtvj/rgLCMPyC4RHMXj6Q==
X-Received: by 2002:a05:6602:29d1:b0:669:428e:8c59 with SMTP id z17-20020a05660229d100b00669428e8c59mr3607080ioq.85.1659736492081;
        Fri, 05 Aug 2022 14:54:52 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:51 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 28/33] drm_print: refine drm_debug_enabled for jump-label
Date:   Fri,  5 Aug 2022 15:53:50 -0600
Message-Id: <20220805215355.3509287-29-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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
2.37.1

