Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6EA5AC70D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiIDVoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiIDVnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:43:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD302F64D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:40 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r141so5678569iod.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tmR8ChrylisxKKWzjN/Li/odfvtNSLNzyjwd4uQokF0=;
        b=YA6JGiqu4qnXHVqjxeqktp9+r4L0ElOdnkT68N+xlzo9ovLmKCzEp0/6pi8K8SxiDU
         KwjNYzCmK6I94RrfiBdEEofeg4VWstkfQy+pNcJcE38TAL+pwdl46PNNCBJq9ZaPrn+M
         33ZbFTernPGN1s7PslLH1V5BQcLd2PMYBAL+EoFjllsHeR8xFZK5WLR46dTOAwP0TnT8
         bt/FsSKVUbEDbMrLCkfwGdCNAWH8Ln1DNUBpcBawBvltIsAyilsUMDBqwiHRMVwbxjna
         NuT9XG9QpeIHCXfM3q7C9UUlbZKFIiyTINWnv7+ybnDtbVtD6WNa+Zzsrjxap3WT1/h0
         5ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tmR8ChrylisxKKWzjN/Li/odfvtNSLNzyjwd4uQokF0=;
        b=r0TlPGCJC68KQHIsrf2h+6MkEfkmOfvXQDF21/1Gqufv6G4w1vHE9yOozEawagWheK
         /R3vNbeigdncD+jp0ZD0N1jnBb8gj2GvNda9POwnnRzajYTDBAdbuJNL4mNLVzlkkT26
         eec8LDMnRVGcrG/yuDsqkZS3u2c7i8OAjm3bm85fovmdpRG1Y8+b2M2inLx2g8t9s6MZ
         R2nybLU7QZXHKLFGe7tD7+WEjWe4n0kjuYY9Uwf82q3C+JdpGncax5pZFOi/nAWbOnVC
         tib21jgGDrpkjkOKQ0YIaUkkyWrgUhzRY7EhFeD+gBf9oRG9W+BIj6W5+3C9lhQYNBsr
         mV1w==
X-Gm-Message-State: ACgBeo0fG4rY/71j+tMdjJOr9+KhMXg5tj9ZTbsggwmlPiulEuoRTFX5
        bj7QCh84X4LZoKkJNzbwL6I=
X-Google-Smtp-Source: AA6agR67W0JwMKVjGZ0XAZCtblPF2QCqY+yVd4ipB10+ywZ/x6+YYkZcz6CmYFni52Q8uttRgXx7og==
X-Received: by 2002:a05:6638:488a:b0:342:6d75:dfa6 with SMTP id ct10-20020a056638488a00b003426d75dfa6mr23007148jab.319.1662327758805;
        Sun, 04 Sep 2022 14:42:38 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 30/57] drm_print: add _ddebug descriptor to drm_*dbg prototypes
Date:   Sun,  4 Sep 2022 15:41:07 -0600
Message-Id: <20220904214134.408619-31-jim.cromie@gmail.com>
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
2.37.2

