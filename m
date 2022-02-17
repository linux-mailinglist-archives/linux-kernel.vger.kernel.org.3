Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25A44B9711
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiBQDte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:49:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiBQDtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:49:17 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF29C6242
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:53 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id h11so1361991ilq.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEgu+Ofez++Uoa48K1+2ND2BjCIRiQBeP9KERq1IVJk=;
        b=c1JeYHRFs5svhKtU+Ma4tZuA1JP1VGAyb5UJut5hn3b+E/pkz4W6ai6Wi07gw9nx0u
         IJlaKZ1JgaK+etmpo8bVgK993gcuAQTJ85hKZNvC7mbhzNti3nrRKPiMeA5cy+BRNPXn
         q+7FmioValLExz+ZdCNnxwwsoXMa2G4dtMO7YG1oXpyH4HDMwlppdpOMwt8l8BATxVtu
         D5e063IVeRG46r9SCc3fM59VGWiK5172LjkMtGK13zLg09HTaAmMkaTMEB72l+5RvYV/
         HlHFzFSqBHJ/GmG2G9sNcd/lWFFlzJlqrO5TGL4sAVzk2p+at9nmsgBlhy7IgHUVzEqO
         z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEgu+Ofez++Uoa48K1+2ND2BjCIRiQBeP9KERq1IVJk=;
        b=kkIgF7ziiG3oWHjHIiFCELLjT6rQTBvkDb4G3psemRgMvZmeU8Z48Ah8R3jU99/eW/
         krn/uVeZT5gabLOFLcMV8HuzBzcMU0B95C0ay9KbANfdxfHFFQ9Y8ZhXMXroMJY64E5k
         8jBp2XBc4lv6jhwEiEsNl0WpvQqUnO1cToa9VO4k5sUaHHu/DCvNxVnYo4/hJBDBo4hm
         B14gtQR3im+WLaeBb1NgxoarSRbIxFfQU18xQMxYHfTc7YIrvHDZY8OTtwJ0ezKNLKnQ
         7wks7zoYad30gLWjhhPveikv0P5Lejix8FuDjoflUEsSJ9yEumJDtnawlkWMhft1hJpa
         aFbQ==
X-Gm-Message-State: AOAM530HXDzegHVzmUccUGySnfTuSjfmnyDt8WnyxK+wviiOwirbWvOX
        QbAsA+vlKfte/ZN0M5XNKcc=
X-Google-Smtp-Source: ABdhPJyyUYLLjO/ZjDmiQ2qjpAZbgsdUUcVllJavrIsnuUX4/fgc6pmjbTxk2ccQkswLRYw9SI0fLw==
X-Received: by 2002:a92:ca4a:0:b0:2ba:878e:fd12 with SMTP id q10-20020a92ca4a000000b002ba878efd12mr743076ilo.139.1645069732854;
        Wed, 16 Feb 2022 19:48:52 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:52 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 12/13] drm_print: add _ddebug desc to drm_*dbg prototypes
Date:   Wed, 16 Feb 2022 20:48:28 -0700
Message-Id: <20220217034829.64395-13-jim.cromie@gmail.com>
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

Add a struct _ddebug ptr to drm_dbg() and drm_dev_dbg() protos.

And upgrade the current use of _dynamic_func_call_no_desc(); ie drop
the '_no_desc', since the factory macro's callees (these 2 functions)
are now expecting the arg.

This lets those functions act more like pr_debug().  It also means
that these functions don't just get the decorations from an underlying
implementation.  DRM already has standards for logging/messaging;
tossing optional decorations on top may not help.

use that info

provide it to dyndbg [1], which can then
control debug enablement and decoration for all those drm.debug
callsites.

For CONFIG_DRM_USE_DYNAMIC_DEBUG=N, just pass null.
NB: desc->class_id is redundant with category, but !!desc dependent.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 23 +++++++++++++----------
 include/drm/drm_print.h     | 23 ++++++++++++-----------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 24c57b92dc69..c9b2a2ab0d3d 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -255,8 +255,8 @@ void drm_dev_printk(const struct device *dev, const char *level,
 }
 EXPORT_SYMBOL(drm_dev_printk);
 
-void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		   const char *format, ...)
+void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
+		   enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -264,22 +264,25 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	if (!__drm_debug_enabled(category))
 		return;
 
+	/* we know we are printing for either syslog, tracefs, or both */
 	va_start(args, format);
 	vaf.fmt = format;
 	vaf.va = &args;
 
-	if (dev)
-		dev_printk(KERN_DEBUG, dev, "[" DRM_NAME ":%ps] %pV",
-			   __builtin_return_address(0), &vaf);
-	else
-		printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
-		       __builtin_return_address(0), &vaf);
-
+	if (dev) {
+		if (dyndbg_site_is_printing(desc))
+			dev_printk(KERN_DEBUG, dev, "[" DRM_NAME ":%ps] %pV",
+				   __builtin_return_address(0), &vaf);
+	} else {
+		if (dyndbg_site_is_printing(desc))
+			printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
+			       __builtin_return_address(0), &vaf);
+	}
 	va_end(args);
 }
 EXPORT_SYMBOL(__drm_dev_dbg);
 
-void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
+void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 38ef044d786e..13d52b60f388 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm.h>
 
@@ -361,9 +362,9 @@ static inline bool drm_debug_enabled(enum drm_debug_category category)
 __printf(3, 4)
 void drm_dev_printk(const struct device *dev, const char *level,
 		    const char *format, ...);
-__printf(3, 4)
-void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		 const char *format, ...);
+__printf(4, 5)
+void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
+		   enum drm_debug_category category, const char *format, ...);
 
 /**
  * DRM_DEV_ERROR() - Error output.
@@ -413,11 +414,11 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
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
@@ -520,17 +521,17 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
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
2.35.1

