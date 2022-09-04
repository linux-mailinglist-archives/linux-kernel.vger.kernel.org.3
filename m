Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254755AC710
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiIDVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiIDVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:43:51 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E282FFE9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d68so5629192iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A2zndOeDRPgGOvwAIBa0JaD1rifqqeyYUM4/f4LglP8=;
        b=Dx7ob9YDExsS8kTSLfJMyPG66UA0U31lxKW3FyZ0OB7RnX+eTy24lpN15BN0uRCHgK
         iYRtls7LairgGBqQuWjOWGt5yV/5sReWPL8tJcxGLve+LNOB7TeMPm6iwWvkuf+Gq8oK
         Jg00USMN4Sx6FBVhr4RDt6XK444pORZc4ArmQjXr5Hi+BWDooYO/+r75wEMcyKAvmeXv
         ITokxmZrLFKj9FfRabOmhj5kw4y0bEhW59aTj3Y2WyYkmh3QI84/qPuQpnu2EEilo0M9
         03YBBWYjSQ9xaDCSkgVNC8OmCZZsemz9X0cEsj/0x82tX7xElqTn8iPg31QwPj3XtjyW
         ewQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A2zndOeDRPgGOvwAIBa0JaD1rifqqeyYUM4/f4LglP8=;
        b=DTl2D4aYw4gjKPnK1B0zZL7+uVj0pKNoh3oFzV0+Pz1SGdSM+pBPxgkt9NDgXQ6BG2
         UAdFpeB2WHC5d7dX0F+mR8LFGkTlISlIjV4cn9O0sYcuXfZ3QbeT7gi1pOEugI33i38Q
         keCMJbYHqNGhk+Q4kK5KogapcYFwhb5wtx9TLmaXF0LM038zUbuW5UaIgeS5hgkbpY8q
         NrTzaOfuEpuWdwXjtLoCxYwQ/3wzMkusU1Ke2OU5+EpFqAF0Ew1UyMJ3IGFBtey3+gPh
         qTvz3MM7t9zRJeacLfODvlLK9UQSv+61KoI6Sx2TK/gsiLTnPNN0N/R0gZup3amTytMq
         M7YA==
X-Gm-Message-State: ACgBeo16990pVFXA1TDB0W3T64SyE9/K4QdDK3K4wife+fXhOQhmUDrV
        OyFZi4WlI+W9mMJKlYdRqsuAHSzstFg=
X-Google-Smtp-Source: AA6agR5zZ3MpxOCe1Gv6PL9bbcItO9JKVZB4ZP+mJzEw4KEVnlCu6qXDvhLhCGEBE1WfgmU3fBenrw==
X-Received: by 2002:a05:6638:d10:b0:34c:10d8:4f7 with SMTP id q16-20020a0566380d1000b0034c10d804f7mr10894388jaj.246.1662327765640;
        Sun, 04 Sep 2022 14:42:45 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 37/57] dyndbg: add 2 trace-events: drm_debug, drm_devdbg
Date:   Sun,  4 Sep 2022 15:41:14 -0600
Message-Id: <20220904214134.408619-38-jim.cromie@gmail.com>
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

Recently added ddebug_trace() issues a single printk:console event.
Replace that event with 2 new ones, defined in a new header:
include/trace/events/dyndbg.h

- dyndbg:prdbg  - from trace_prdbg()  - if !dev
- dyndbg:devdbg - from trace_devdbg() - if !!dev

This links the legacy pr_debug API to tracefs, so pr_debug() and
dev_dbg() calls can add more debug context into the trace-logs, and
then at users option, less into syslog.

The new events allow enabling by event-type in tracefs, and dyndbg
allows individual enablement of prdbg callsites (via +T flag).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 25 ++++++++++++-----
 include/trace/events/drm.h  | 54 +++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 7 deletions(-)
 create mode 100644 include/trace/events/drm.h

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 5b93c11895bb..c50edbf443d3 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -35,6 +35,9 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_print.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/drm.h>
+
 /*
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
@@ -293,13 +296,19 @@ void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
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
+		if (desc->flags & _DPRINTK_FLAGS_PRINTK)
+			dev_printk(KERN_DEBUG, dev, "[" DRM_NAME ":%ps] %pV",
+				   __builtin_return_address(0), &vaf);
+		if (desc->flags & _DPRINTK_FLAGS_TRACE)
+			trace_drm_devdbg(dev, category, &vaf);
+	} else {
+		if (desc->flags & _DPRINTK_FLAGS_PRINTK)
+			printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
+			       __builtin_return_address(0), &vaf);
+		if (desc->flags & _DPRINTK_FLAGS_TRACE)
+			trace_drm_debug(category, &vaf);
+	}
 	va_end(args);
 }
 EXPORT_SYMBOL(__drm_dev_dbg);
@@ -319,6 +328,8 @@ void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const ch
 	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
 	       __builtin_return_address(0), &vaf);
 
+	trace_drm_debug(category, &vaf);
+
 	va_end(args);
 }
 EXPORT_SYMBOL(___drm_dbg);
diff --git a/include/trace/events/drm.h b/include/trace/events/drm.h
new file mode 100644
index 000000000000..589fa1e1f2c2
--- /dev/null
+++ b/include/trace/events/drm.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM drm
+
+#if !defined(_TRACE_DRM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DRM_H
+
+#include <linux/tracepoint.h>
+
+/* drm_debug() was called, pass its args */
+TRACE_EVENT(drm_debug,
+	    TP_PROTO(int drm_debug_category, struct va_format *vaf),
+
+	    TP_ARGS(drm_debug_category, vaf),
+
+	    TP_STRUCT__entry(
+		    __field(int, drm_debug_category)
+		    __vstring(msg, vaf->fmt, vaf->va)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->drm_debug_category = drm_debug_category;
+		    __assign_vstr(msg, vaf->fmt, vaf->va);
+		    ),
+
+	    TP_printk("%s", __get_str(msg))
+);
+
+/* drm_devdbg() was called, pass its args, preserving order */
+TRACE_EVENT(drm_devdbg,
+	    TP_PROTO(const struct device *dev, int drm_debug_category, struct va_format *vaf),
+
+	    TP_ARGS(dev, drm_debug_category, vaf),
+
+	    TP_STRUCT__entry(
+		    __field(const struct device*, dev)
+		    __field(int, drm_debug_category)
+		    __vstring(msg, vaf->fmt, vaf->va)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->drm_debug_category = drm_debug_category;
+		    __entry->dev = dev;
+		    __assign_vstr(msg, vaf->fmt, vaf->va);
+		    ),
+
+	    TP_printk("cat:%d, %s %s", __entry->drm_debug_category,
+		      dev_name(__entry->dev), __get_str(msg))
+);
+
+#endif /* _TRACE_DRM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.37.2

