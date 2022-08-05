Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E330558B1E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiHEV5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241798AbiHEVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:40 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7267D1F5;
        Fri,  5 Aug 2022 14:54:54 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z8so680774ile.0;
        Fri, 05 Aug 2022 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rhstsuI95lREfusErhrTk68nX+Dr7udLDeW32bVJVIQ=;
        b=XGnW/7bt8k5/WnH1ZJrhaNks82fne43rzLfggY++cfGqGkNO7N04Q6pM/aefcAwSnz
         bhx4eA4Kg+Rx33oCassystD9UIlUfL307qMl2xJ+/sBlW6jLib81QvUk4p8X2jcWi5XU
         lcKnIb2onIcPeRmc8TUFn75ty2IegRXoSGHnppJPzqhmfFnGBkQYQqcAmu+SxYtoLTHX
         TT1doWwOHbOyhvFpX05x+oIN8nynn7nypjQpEsKWAk+R1IRi7GWQmS5Oj+LHbwlz4n2t
         nFD0FUzGlMoe+5+JX6OVu2P8Fl4n5GfW6B0hlwpadFQzuGl8MVBz3FQOyDpe0B24EHLd
         oYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rhstsuI95lREfusErhrTk68nX+Dr7udLDeW32bVJVIQ=;
        b=l6YpN24ulrEiE9QUztFc58862Lgu0EP1R18mbbW/OFvu52imOQyLz/hFWRsDdaDiyL
         ChA8o0kMm4AwJ16ZAvyWVsUP8FpCrWbnjbWYey3n8JU/kKbiS9OCLW8Zv1zt6HpbcEVB
         ipnbJ5A5A2zrNpZNz1c0mzl4fP1UAAJypIhSGrf0EN+TwDTE0FdfRhHo1Y0G05N2rues
         bvPN5QmnaFxQx5T/WlDf1Q0OKuZaU0BL//+NVFSmDLCrRp0HsaABNXdHVCXulJviCEY5
         hlyvwpgveuAJLdAUdAUy2DpRZCdhPgx40QbGoPNRqUZFmCxxDQIsG7AyQyaCAlWc03vv
         /kNQ==
X-Gm-Message-State: ACgBeo0T0SygIfQulh14g9nFPg0plGbJXYF91AFqFaPu0K5mLKhigyU8
        tdIlbMe6zn1HtrZu6B0V16REaKcYmO3vUA==
X-Google-Smtp-Source: AA6agR4X7Nq9JKgyjKcqMdMxGSP8stb+bWFZn/5Vd2W4x67FwUhYwsBWRuuqGgUfbUhlier1eqdSow==
X-Received: by 2002:a05:6e02:1847:b0:2dd:18c7:51c3 with SMTP id b7-20020a056e02184700b002dd18c751c3mr4127528ilv.29.1659736494120;
        Fri, 05 Aug 2022 14:54:54 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:53 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 30/33] drm_print: add _ddebug descriptor to drm_*dbg prototypes
Date:   Fri,  5 Aug 2022 15:53:52 -0600
Message-Id: <20220805215355.3509287-31-jim.cromie@gmail.com>
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

upgrade the callchain to drm_dbg() and drm_dev_dbg(); add a struct
_ddebug ptr parameter to them, and supply that additional param by
replacing the '_no_desc' flavor of dyndbg Factory macro currently used
with the flavor that supplies the descriptor.

NOTES:

The descriptor gives these fns access to the decorator flags, but does
none of the dynamic-prefixing done by __dynamic_emit_prefix().

DRM already has conventions for logging/messaging; just tossing
optional decorations on top may not help.  Instead, existing flags (or
new ones) can be used to make current conventions optional.

For CONFIG_DRM_USE_DYNAMIC_DEBUG=N, just pass null.

Note: desc->class_id is redundant with category parameter, but its
availability is dependent on desc.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c |  8 +++++---
 include/drm/drm_print.h     | 23 ++++++++++++-----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ec477c44a784..5b93c11895bb 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -29,6 +29,7 @@
 #include <linux/moduleparam.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm.h>
 #include <drm/drm_drv.h>
@@ -278,8 +279,8 @@ void drm_dev_printk(const struct device *dev, const char *level,
 }
 EXPORT_SYMBOL(drm_dev_printk);
 
-void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		   const char *format, ...)
+void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
+		   enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -287,6 +288,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	if (!__drm_debug_enabled(category))
 		return;
 
+	/* we know we are printing for either syslog, tracefs, or both */
 	va_start(args, format);
 	vaf.fmt = format;
 	vaf.va = &args;
@@ -302,7 +304,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 }
 EXPORT_SYMBOL(__drm_dev_dbg);
 
-void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
+void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 7631b5fb669e..46f14cfb401e 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -363,9 +363,10 @@ static inline bool drm_debug_enabled(enum drm_debug_category category)
 __printf(3, 4)
 void drm_dev_printk(const struct device *dev, const char *level,
 		    const char *format, ...);
-__printf(3, 4)
-void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		 const char *format, ...);
+struct _ddebug;
+__printf(4, 5)
+void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
+		   enum drm_debug_category category, const char *format, ...);
 
 /**
  * DRM_DEV_ERROR() - Error output.
@@ -415,11 +416,11 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define drm_dev_dbg(dev, cat, fmt, ...)				\
-	__drm_dev_dbg(dev, cat, fmt, ##__VA_ARGS__)
+	__drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
 #else
 #define drm_dev_dbg(dev, cat, fmt, ...)				\
-	_dynamic_func_call_no_desc(fmt, __drm_dev_dbg,			\
-				   dev, cat, fmt, ##__VA_ARGS__)
+	_dynamic_func_call_cls(cat, fmt, __drm_dev_dbg,		\
+			       dev, cat, fmt, ##__VA_ARGS__)
 #endif
 
 /**
@@ -523,17 +524,17 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
  * Prefer drm_device based logging over device or prink based logging.
  */
 
-__printf(2, 3)
-void ___drm_dbg(enum drm_debug_category category, const char *format, ...);
+__printf(3, 4)
+void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const char *format, ...);
 __printf(1, 2)
 void __drm_err(const char *format, ...);
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-#define __drm_dbg(fmt, ...)		___drm_dbg(fmt, ##__VA_ARGS__)
+#define __drm_dbg(fmt, ...)		___drm_dbg(NULL, fmt, ##__VA_ARGS__)
 #else
 #define __drm_dbg(cat, fmt, ...)					\
-	_dynamic_func_call_no_desc(fmt, ___drm_dbg,			\
-				   cat, fmt, ##__VA_ARGS__)
+	_dynamic_func_call_cls(cat, fmt, ___drm_dbg,			\
+			       cat, fmt, ##__VA_ARGS__)
 #endif
 
 /* Macros to make printk easier */
-- 
2.37.1

