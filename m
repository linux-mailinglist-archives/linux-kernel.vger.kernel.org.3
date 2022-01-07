Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F67B4872BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbiAGFae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbiAGFaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:11 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56282C061201;
        Thu,  6 Jan 2022 21:30:11 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id m4so3844914ilf.0;
        Thu, 06 Jan 2022 21:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXP101OBKmlnLofCkQPbu2Mn+KOJTGfJ6b+NIiHZLS4=;
        b=D0dcLl/Cn+05vmbxEjZI4ubBfvPU4FZ8FgYhK/JyJWNyoH+7qZpiKJfVRL5ulKNTRy
         jFDcUxZ91EN16Ibemv9vUXdY1ReZQaflP4hcZQHEHRJOjkVNQ5W9khjmIANSER/NtbMP
         I4e1dlHmX0Z6WSZAvdoJ45Sber5oXYOi2xew3LlQ/9tbieVU8eWL59q2mMsc1wpwOtd1
         khuF/ia6OakQnXTmlFRLOh0StIV+ANTNdh7eDyd44bVKYA02wrjMsxD16+I9JEcpjPHa
         2Kwykx0kyqSEmt2NAzQrL+9zCN6drsk+OR194QbU7V6JD8Hd2GYg0XtH/YYP+ALyhuej
         BSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXP101OBKmlnLofCkQPbu2Mn+KOJTGfJ6b+NIiHZLS4=;
        b=1aX70N8snm1bfKwWatIfivx2P4ZDzMAhiP8lLSjfa2MjTuGbap04Z1x4ZX52rSRRYs
         XIbuOA0zTHk+wSDiB3AVQxKn/EhaOH+L2FApmbJcdUsCRkIZMoJkAzpCep7H8Shv1dcu
         Tkm9tX4xJ+pSu6jePvE8ZC77t0zaddY5b/VvmnaeluHNNOrS5If3vtV62ZTwokgqBZRy
         cai3cPQNgeQ2EPW1Nwk8gi3q5XvKx2se6Wf2t3wmJpT8t0EVoV1PZdau7wtba7kL3kv8
         9b6NQbVpjaLuhAN/EjlR7dsLxa9gQ9YrdLExnF+/Ks9ahyoBLv0AchbN2A9XiLgzk0SZ
         70Sg==
X-Gm-Message-State: AOAM530Wv0+IaAXqTzJXu6DbwoMrXjN7Ot/PV6+ShQa3tNe7wwJ2ZWnC
        A4A7ajb17WR6irQBI3ETw2w=
X-Google-Smtp-Source: ABdhPJyJV+ie8tIgRKUsxFge8djV88zEG6NNzur6iycvq7O0pB1HrKdK6LcPy9o+zi6LoQYAKFNbXA==
X-Received: by 2002:a92:c685:: with SMTP id o5mr29675045ilg.152.1641533410743;
        Thu, 06 Jan 2022 21:30:10 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:10 -0800 (PST)
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
Subject: [PATCH v11 17/19] drm_print: add struct _ddebug *desc to trace-drm-*() params
Date:   Thu,  6 Jan 2022 22:29:40 -0700
Message-Id: <20220107052942.1349447-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace trace-drm-*()s category param with struct _ddebug *desc; it
has .classid field, which is the category.

This brings the events closer in line with those added for dyndbg; at
least the 1st param, and possibly the struct device (tb-checked).
There are still differences in the tail of the prototypes; vaf vs
text + len, which probably breaks CLASS sharing.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c |  6 +++---
 include/trace/events/drm.h  | 36 ++++++++++++++++++------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 8c33302212fc..0a15a4ec5ead 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -278,14 +278,14 @@ void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
 				   __builtin_return_address(0), &vaf);
 
 		if (desc->flags & _DPRINTK_FLAGS_TRACE)
-			trace_drm_devdbg(dev, category, &vaf);
+			trace_drm_devdbg(dev, desc, &vaf);
 	} else {
 		if (desc->flags & _DPRINTK_FLAGS_PRINTK)
 			printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
 			       __builtin_return_address(0), &vaf);
 
 		if (desc->flags & _DPRINTK_FLAGS_TRACE)
-			trace_drm_debug(category, &vaf);
+			trace_drm_debug(desc, &vaf);
 	}
 	va_end(args);
 }
@@ -306,7 +306,7 @@ void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const ch
 	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
 	       __builtin_return_address(0), &vaf);
 
-	trace_drm_debug(category, &vaf);
+	trace_drm_debug(desc, &vaf);
 
 	va_end(args);
 }
diff --git a/include/trace/events/drm.h b/include/trace/events/drm.h
index 944aedaf6aa6..bfe1fff923d8 100644
--- a/include/trace/events/drm.h
+++ b/include/trace/events/drm.h
@@ -9,25 +9,25 @@
 
 /* drm_debug() was called, pass its args */
 TRACE_EVENT(drm_debug,
-	TP_PROTO(int drm_debug_category, struct va_format *vaf),
+	TP_PROTO(struct _ddebug *desc, struct va_format *vaf),
 
-	TP_ARGS(drm_debug_category, vaf),
+	TP_ARGS(desc, vaf),
 
 	TP_STRUCT__entry(
-		__field(int, drm_debug_category)
+		__field(struct _ddebug *, desc)
 		__dynamic_array(char, msg, 256)
 	),
 
 	TP_fast_assign(
 		int len;
+		char *p = __get_str(msg);
 
-		__entry->drm_debug_category = drm_debug_category;
-		vsnprintf(__get_str(msg), 256, vaf->fmt, *vaf->va);
+		__entry->desc = desc;
+		len = vsnprintf(p, 256, vaf->fmt, *vaf->va);
 
-		len = strlen(__get_str(msg));
-		if ((len > 0) && (__get_str(msg)[len-1] == '\n'))
+		if ((len > 0) && (len < 256) && p[len-1] == '\n')
 			len -= 1;
-		__get_str(msg)[len] = 0;
+		p[len] = 0;
 	),
 
 	TP_printk("%s", __get_str(msg))
@@ -35,30 +35,30 @@ TRACE_EVENT(drm_debug,
 
 /* drm_devdbg() was called, pass its args, preserving order */
 TRACE_EVENT(drm_devdbg,
-	TP_PROTO(const struct device *dev, int drm_debug_category, struct va_format *vaf),
+	TP_PROTO(const struct device *dev, struct _ddebug *desc, struct va_format *vaf),
 
-	TP_ARGS(dev, drm_debug_category, vaf),
+	TP_ARGS(dev, desc, vaf),
 
 	TP_STRUCT__entry(
-		__field(const struct device*, dev)
-		__field(int, drm_debug_category)
+		__field(const struct device *, dev)
+		__field(struct _ddebug *, desc)
 		__dynamic_array(char, msg, 256)
 	),
 
 	TP_fast_assign(
 		int len;
+		char *p = __get_str(msg);
 
-		__entry->drm_debug_category = drm_debug_category;
+		__entry->desc = desc;
 		__entry->dev = dev;
-		vsnprintf(__get_str(msg), 256, vaf->fmt, *vaf->va);
+		len = vsnprintf(p, 256, vaf->fmt, *vaf->va);
 
-		len = strlen(__get_str(msg));
-		if ((len > 0) && (__get_str(msg)[len-1] == '\n'))
+		if ((len > 0) && (len < 256) && p[len-1] == '\n')
 			len -= 1;
-		__get_str(msg)[len] = 0;
+		p[len] = 0;
 	),
 
-	TP_printk("cat:%d, %s %s", __entry->drm_debug_category,
+	TP_printk("cat:%d, %s %s", __entry->desc->class_id,
 		  dev_name(__entry->dev), __get_str(msg))
 );
 
-- 
2.33.1

