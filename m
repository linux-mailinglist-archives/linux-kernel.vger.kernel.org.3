Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5929D4C90C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiCAQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbiCAQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:41 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B143D37A18
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:46:59 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d62so19073599iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEgu+Ofez++Uoa48K1+2ND2BjCIRiQBeP9KERq1IVJk=;
        b=SGMp0SOcz7owiggI/NOG9AwUqWuY3WHOdlY2OGCh5F/TYFEM2fwwXAdKj6sqz21oGb
         6ijQil2ZV5qIEOwn3P3eEiaoBAVmRRUWcqMYc9nuR4fdhXx1K0Y53Ua2G1/U1Jx5MvSK
         TWd6g6MnQUAkcYcfHbaXaO3gi/f7JGcZFVrzmt3Fp6AYxUbSEFozYjmoR0Ozv1kkdTIz
         bT0DgSs6/M7zvCeiZFj3NZejf9fKNELzgv7gg/JY5HL1V01l5wbt+1FNuZqM1l2Vk5p5
         cfPOHYK6402xHwms11aXn4SOWJc6T0G0J7X+j5y2w4YbGGlxsWQ/Ve8WuYR0azZe2iCS
         Yi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEgu+Ofez++Uoa48K1+2ND2BjCIRiQBeP9KERq1IVJk=;
        b=4mURlo4LAk7OnesIvzylnO3t40YGbSaZzf3rfKyKwC8XhCNNKgP2mEgEPzYcB699oT
         aRGeJcvoNU4CsIHeg62iTVMJUZ2gf2tVf2sxtNZ7qvrnYojEVXQj0pfI0IWToOxOcBhc
         s40ugnI7B2YJA09T277YSd4ZNf5AfpBqA4WqwQ6aNs/JgK/dYl4Oq8SgeA6Ih6w0VJQR
         lqMoQcOTvsS/rI99aDQh2rQCCJk0aWvGuk6u6siSLRmI1uwuFSEEmBsfyFlKOkYG05iS
         m+0zxfyj2vTRAeTHySO2ESTFpv7zez1+iNimK45SdV9ZRQduJlSSGN7HLuML9m7qXmLn
         ds3A==
X-Gm-Message-State: AOAM531rtyULVmgI2TkjL9qzNKnuf0SFL7RyemR1LrarrshcO3cMX3pj
        LInRGGwR87Ol+eGoPiPfbc0=
X-Google-Smtp-Source: ABdhPJwQtRT66y/VO028x0oItbv2Me7FXE+5HFxgf3gbLT46jXc9mytuAJ/FLenQ38OHlfr0Q0QC5w==
X-Received: by 2002:a02:3503:0:b0:314:c32d:edd4 with SMTP id k3-20020a023503000000b00314c32dedd4mr22646020jaa.36.1646153219049;
        Tue, 01 Mar 2022 08:46:59 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id o3-20020a6b5a03000000b00640a33c5b0dsm7272411iob.17.2022.03.01.08.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:46:58 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 12/13] drm_print: add _ddebug desc to drm_*dbg prototypes
Date:   Tue,  1 Mar 2022 09:46:28 -0700
Message-Id: <20220301164629.3814634-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301164629.3814634-1-jim.cromie@gmail.com>
References: <20220301164629.3814634-1-jim.cromie@gmail.com>
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

