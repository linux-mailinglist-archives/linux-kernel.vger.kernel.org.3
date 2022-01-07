Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784D34872C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbiAGFbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346235AbiAGFaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:10 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E16C061245;
        Thu,  6 Jan 2022 21:30:10 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q5so5820701ioj.7;
        Thu, 06 Jan 2022 21:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYyJ2gcl34AtG+ZwzeuT+zalv5tvCFacm4aJJ3L+PFU=;
        b=n5cDKpY/cS3ddfduU75FLd0mm/XG5Pm3C7omvy4wXv3FY5Ljt7Dn096WxhuV01V/uR
         agjlDHLToD0Cg8Tc+m/rD0aVxrP3mLxB2DCAHY6VKw3DlGhz6uOzIMJCFLkFg/Fk6fQa
         m9kieutSbD75E/lHgv7lCWlrz7p9i+Jqkz2sxDfcRXkdx83cO+prvc5LWdXNmJWfjeCK
         QnPA+yX6Y8dW0FOO1MGgT6XRj2b6FzA56X4/L1wM8wzyddIVlrUX8cICTROh6Xc5PHCS
         2OhKsU+un9BbaB5LdDVwo5pAfJIOYGuGyHfic5lyoWk6pCAn/UGOkjfDYClncsTWpPd2
         VZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYyJ2gcl34AtG+ZwzeuT+zalv5tvCFacm4aJJ3L+PFU=;
        b=HswO1nOlGia+Sk5CnFktCyg//zJwV03nUI2gJPiYcSGSCma2ZlP2qy+t8xX61t/XdJ
         61H+RRjAgDj4nF7Uxz909Sicvxgt9jUjvtPkbRStABddnTm21c24j9+E6dxUxd78Mzrh
         spCuweMy0q8xuvz2hQkWieANl1xajDcDL6V/NcsUnNXXcxCswohtVNyL+nCop6hXzp5s
         kTzMQ1txo/BHWE7XLyEndLbk+8ZKiiUMVD8O5odvh6xAuubttQhblIZvkOpWVl6xpsPw
         DBOo+T29YtL21hXNYQe2d4LFEOnvrgiF966A1xtCzuEPPYPLxdsnjGBv8F890I35Rva5
         j4ww==
X-Gm-Message-State: AOAM533geoyJ5yZ8FMiQr3eA+WIwzkYU8wcmcbfsqIjq8VZsAdZ41AzL
        GVCtsPdWwCRwiXHi5X4TyEY=
X-Google-Smtp-Source: ABdhPJyZ2DQ/f+275CIjKbX91nJCLDE4hjHieIEqtncwcYdaOvFghGTgMmBnVGaYwBuweKjCTTGK8A==
X-Received: by 2002:a5d:8543:: with SMTP id b3mr29143476ios.11.1641533409455;
        Thu, 06 Jan 2022 21:30:09 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:09 -0800 (PST)
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
Subject: [PATCH v11 16/19] drm_print: add struct _ddebug desc to drm_*dbg
Date:   Thu,  6 Jan 2022 22:29:39 -0700
Message-Id: <20220107052942.1349447-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit adding trace-events to drm noted:

   trace_*() additions are strictly redundant with printks to syslog,
   not properly placed to reduce overall work.

That was because it didn't have the struct _ddebug *descriptor, whose
.flags specify TRACE and PRINTK actions on a controlled callsite.  So
it could only duplicate the stream (from the enabled callsites).

To issue TRACE, PRINTK selectively:

- add struct _ddebug * param to prototypes and functions:
  ___drm_dbg(), __drm_dev_dbg()
  add "struct _ddebug;" to name the ptr-type, to silence warning.

- adjust the forwarding macros: drm_dbg, drm_dev_dbg
  to provide a descriptor, or NULL.
  basically this is dropping the _no_desc_,
  ie using _dynamic_func_call_cls(), since the callee can now accept it.

- add if (desc->flags ...) TRACE / PRINTK actions.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 25 ++++++++++++++++---------
 include/drm/drm_print.h     | 20 ++++++++++----------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index b911f949af5b..8c33302212fc 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -258,8 +258,8 @@ void drm_dev_printk(const struct device *dev, const char *level,
 }
 EXPORT_SYMBOL(drm_dev_printk);
 
-void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		   const char *format, ...)
+void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
+		   enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -267,24 +267,31 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	if (!__drm_debug_enabled(category))
 		return;
 
+	/* we know we are printing for either syslog, tracefs, or both */
 	va_start(args, format);
 	vaf.fmt = format;
 	vaf.va = &args;
 
 	if (dev) {
-		dev_printk(KERN_DEBUG, dev, "[" DRM_NAME ":%ps] %pV",
-			   __builtin_return_address(0), &vaf);
-		trace_drm_devdbg(dev, category, &vaf);
+		if (desc->flags & _DPRINTK_FLAGS_PRINTK)
+			dev_printk(KERN_DEBUG, dev, "[" DRM_NAME ":%ps] %pV",
+				   __builtin_return_address(0), &vaf);
+
+		if (desc->flags & _DPRINTK_FLAGS_TRACE)
+			trace_drm_devdbg(dev, category, &vaf);
 	} else {
-		printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
-		       __builtin_return_address(0), &vaf);
-		trace_drm_debug(category, &vaf);
+		if (desc->flags & _DPRINTK_FLAGS_PRINTK)
+			printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
+			       __builtin_return_address(0), &vaf);
+
+		if (desc->flags & _DPRINTK_FLAGS_TRACE)
+			trace_drm_debug(category, &vaf);
 	}
 	va_end(args);
 }
 EXPORT_SYMBOL(__drm_dev_dbg);
 
-void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
+void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 0c704610c770..6d43b81a0ee4 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -360,9 +360,9 @@ static inline bool drm_debug_enabled(enum drm_debug_category category)
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
@@ -412,11 +412,11 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define drm_dev_dbg(dev, eCat, fmt, ...)				\
-	__drm_dev_dbg(dev, eCat, fmt, ##__VA_ARGS__)
+	__drm_dev_dbg(NULL, dev, eCat, fmt, ##__VA_ARGS__)
 #else
 #define drm_dev_dbg(dev, eCat, fmt, ...)				\
-	_dynamic_func_call_no_desc_cls(fmt, eCat, __drm_dev_dbg,	\
-				       dev, eCat, fmt, ##__VA_ARGS__)
+	_dynamic_func_call_cls(eCat, fmt, __drm_dev_dbg,		\
+			       dev, eCat, fmt, ##__VA_ARGS__)
 #endif
 
 /**
@@ -519,8 +519,8 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
  * Prefer drm_device based logging over device or prink based logging.
  */
 
-__printf(2, 3)
-void ___drm_dbg(enum drm_debug_category category, const char *format, ...);
+__printf(3, 4)
+void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const char *format, ...);
 __printf(1, 2)
 void __drm_err(const char *format, ...);
 
@@ -528,8 +528,8 @@ void __drm_err(const char *format, ...);
 #define __drm_dbg(fmt, ...)		___drm_dbg(NULL, fmt, ##__VA_ARGS__)
 #else
 #define __drm_dbg(eCat, fmt, ...)					\
-	_dynamic_func_call_no_desc_cls(fmt, eCat, ___drm_dbg,		\
-				       eCat, fmt, ##__VA_ARGS__)
+	_dynamic_func_call_cls(eCat, fmt, ___drm_dbg,			\
+			       eCat, fmt, ##__VA_ARGS__)
 #endif
 
 /* Macros to make printk easier */
-- 
2.33.1

