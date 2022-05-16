Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFB52948A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350026AbiEPW7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350032AbiEPW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:30 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4EC4664B;
        Mon, 16 May 2022 15:57:26 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e4so2302460ils.12;
        Mon, 16 May 2022 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=it6bLhFwPCS9KNMNbVAc9u0r1hyTQEpcTOU7DVjaIzc=;
        b=cLcNGP066hHaVqlFNtXCmZ1CGCDAlRmjr8Ddi2wGeCAS0G188epVjNoMgFTsYz1FhS
         KwC/fi5w0MCKcVhAzgWTaAyw+jbVNB24fPtZqpyM2QJFQ425pkWWyCI9IkbK/sjrV1Nr
         VH0wWrWNzvvR6xEjBnwkVSgs88cMc3hP8dkgdaIQ1LrtD/VWN/UO2s3FRnPa5oMd5so8
         fSnTqRZENTyoMjCDNvkBUwdEdImN8cxny/1EuyBgylEspCk+qlkkMhhF7mjiK7FL010n
         kgcvXTfvTotxDueX1P4iF6MOjOgVE7J7E3ZeBWAm2Cih8qFLTTugQGWmxTynuy+uGziA
         gtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=it6bLhFwPCS9KNMNbVAc9u0r1hyTQEpcTOU7DVjaIzc=;
        b=dFOHme8VL5erZQ2qp59ibzPSqVdwFpmTUBwGuvFlSAFN02CLOMVifg7fb08CxuVAAH
         Qsbm6/TBr3m4v7ogGc33t+EtdQt9odUPfRiaGgQwuEGQvRiEzN40q9P/GWVexd8UgFiU
         EBpdlL3iehsZyA0YoSDuKYimqqWbq4BubRH30UAhuJOI/AgPdZb7cGAiPuMMoZ5/jh1l
         WaTMfFOb67aU23jxAO/TAywKKAcoF/53JKE42a6e9bjVMF+/MO35MHNuftqFRgCxXa25
         kLLs3rDYB+s7L04iC5GldJRMQjM9NGvqwh+vR46QFcx6M3NUYGJY067agtMrjrbCyS2R
         zk6w==
X-Gm-Message-State: AOAM530YQhyhzKSz6I/hizRFBs+a480ZvReJOIWYf1hP7fQX3QCUWBUK
        1Cm+/JovxEcSpt37Ao88Jok=
X-Google-Smtp-Source: ABdhPJxL66r9um/Qj19jzq2i+w5GjaE1kV2BNicea7CTlLXB+S6WjzXBR8GSASV1PB+CpOnfV72D2w==
X-Received: by 2002:a05:6e02:1d8a:b0:2cd:fa75:6395 with SMTP id h10-20020a056e021d8a00b002cdfa756395mr10067705ila.294.1652741845777;
        Mon, 16 May 2022 15:57:25 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v2 20/27] drm_print: refine drm_debug_enabled for jump-label
Date:   Mon, 16 May 2022 16:56:33 -0600
Message-Id: <20220516225640.3102269-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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
index 5192533794a2..22b7ab1c5c40 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -272,7 +272,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
@@ -295,7 +295,7 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 5c39bacac2b3..ccd177236ab3 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -324,11 +324,39 @@ enum drm_debug_category {
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
2.35.3

