Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8614B96EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiBQDs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:48:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiBQDsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:48:55 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A51C114A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:41 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id t6so2173585ioj.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdwOLzD+GmHRt6StUBsL48/C/2vAmKHyntzDsiIEmgk=;
        b=c/0f2VPHTS0ofL2B4J92kixIqQ2iZlmvNWO1wPcUvzX/DITA7vcpA8jR0EizNqT1JZ
         xD8qtSIYsbh86Nt8HtjMUoqXMczzlOSacQOKClBJ1f/sRP3PsUlM8skyV7fs2/5HE7fi
         aCgS3/oZd5KREbhsmXbZLuG+UuGzLXIPSTAHxecCCSefjxRikJb5B/UCclZd4Wf2DzSF
         prtqhGfMWmogWLrPZEyKkFm0QG0tGC1GiBROMYtLhvKC5LX4NaireehHbr/HEqJKQXat
         6+aesh4TPNr6lhImkvQwjyTI3Dr3/cJ7biN+l2XhwNeLgNSBjUtlRXbir82PfKHZmiQp
         7pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdwOLzD+GmHRt6StUBsL48/C/2vAmKHyntzDsiIEmgk=;
        b=CQvMgX+fH1B+Tmr0kuVphxljYWyxyJ0jwQeihMQw7Eq4O0rtGt0Q24hN4jJl+NXlvs
         x4TBjtRZkOPreULBvNUg68Qd6CejJc4R251vCusJ6wJb7L0MBROHjplsGFh/VuMHsfjT
         egy3n6fTsQJ2odYtCJQYtAjuyumw5V6bgRb7a0JL88yql6f17TKJaoUxvkavKg80rbFD
         h988c7UTY8lisb36LnY5FpGZyC7FaifhKIaODgs4yB8Qybd2a7vWKUo7WnmZCPG3Z8fc
         fVuB/A9+MvisliKdf8VE/MGjYXNl6SNO5KjP5uM41gOn6JWjPdJ/IZBaeEJgajec9rDF
         5xAA==
X-Gm-Message-State: AOAM533YvNy5N4uUvHIYMzPgcPsXjYh2JW7IzYRWjjewiFtoi10eXAna
        jzDFZ/hCmztpqfruYQTfGF4=
X-Google-Smtp-Source: ABdhPJxEqQ0IPmsI5sQzrNorPS0wtFkC0MQn3KAyUwKrC1nFlagr1jAC5TG7jGUiw4LETuYqKpJ76Q==
X-Received: by 2002:a05:6638:1315:b0:314:85c1:f99b with SMTP id r21-20020a056638131500b0031485c1f99bmr613188jad.269.1645069720478;
        Wed, 16 Feb 2022 19:48:40 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:40 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 02/13] dyndbg: add class_id field and query support
Date:   Wed, 16 Feb 2022 20:48:18 -0700
Message-Id: <20220217034829.64395-3-jim.cromie@gmail.com>
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

DRM defines/uses 10 enum drm_debug_category's to create exclusive
classes of debug messages.  To support this directly in dynamic-debug,
add the following:

- struct _ddebug.class_id:4 - 4 bits is enough
- define _DPRINTK_SITE_UNCLASSED 15 - see below

and the query support:
- struct _ddebug_query.class_id
- ddebug_parse_query	- looks for "class" keyword, then calls..
- parse_class		- accepts uint: 0-15, sets query.class_id and marker
- vpr_info_dq		- displays new field
- ddebug_proc_show	- append column with "cls:%d" if !UNCLASSED

With the patch, this command enables current/unclassed callsites:

  #> echo drm class 15 +p > /proc/dynamic_debug/control

parse_class() accepts 0 .. _DPRINTK_SITE_UNCLASSED, which allows the
>control interface to explicitly manipulate unclassed callsites.

After parsing keywords, ddebug_parse_query() sets .class_id=15, iff it
wasnt explicitly set.  This allows future classed/categorized
callsites to be untouched by legacy (class unaware) queries.

DEFINE_DYNAMIC_DEBUG_METADATA gets _CLS(cls,) suffix and arg, and
initializes the new .class_id=cls field.  The old name gets the default.

Then, these _CLS(cls,...) modifications are repeated up through the
stack of *dynamic_func_call* macros that use the METADATA initializer,
so as to actually supply the category into it.

NOTES:

_DPRINTK_SITE_UNCLASSED: this symbol is used to initialize all
existing/unclassed pr-debug callsites.  Normally, the default would be
zero, but DRM_UT_CORE "uses" that value, in the sense that 0 is
exposed as a bit position in drm.debug.  Using 15 allows identity
mapping from category to class, avoiding fiddly offsets.

CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

fixup class-id preset

fix2
---
 .../admin-guide/dynamic-debug-howto.rst       |  7 +++
 include/linux/dynamic_debug.h                 | 54 ++++++++++++++-----
 lib/dynamic_debug.c                           | 38 +++++++++++--
 3 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index a89cfa083155..8ef8d7dcd140 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -35,6 +35,7 @@ Dynamic debug has even more useful features:
    - line number (including ranges of line numbers)
    - module name
    - format string
+   - class number:0-15
 
  * Provides a debugfs control file: ``<debugfs>/dynamic_debug/control``
    which can be read to display the complete list of known debug
@@ -143,6 +144,7 @@ against.  Possible keywords are:::
 		 'module' string |
 		 'format' string |
 		 'line' line-range
+		 'class' integer:[0-15]
 
   line-range ::= lineno |
 		 '-'lineno |
@@ -217,6 +219,11 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
+class
+    This expects a single integer in range: 0-15.
+    15 is used/reserved for existing/unclassed callsites,
+    and is defaulted in unless specified to >control
+
 The flags specification comprises a change operation followed
 by one or more flag characters.  The change operation is one
 of the characters::
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dce631e678dd..d4b48f3cc6e8 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -6,6 +6,8 @@
 #include <linux/jump_label.h>
 #endif
 
+#include <linux/build_bug.h>
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -21,6 +23,9 @@ struct _ddebug {
 	const char *filename;
 	const char *format;
 	unsigned int lineno:18;
+#define CLS_BITS 4
+	unsigned int class_id:CLS_BITS;
+#define _DPRINTK_SITE_UNCLASSED		((1 << CLS_BITS) - 1)
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -87,7 +92,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const struct ib_device *ibdev,
 			 const char *fmt, ...);
 
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
+#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
 		.modname = KBUILD_MODNAME,			\
@@ -96,8 +101,14 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
+		.class_id = cls,				\
 		_DPRINTK_KEY_INIT				\
-	}
+	};							\
+	BUILD_BUG_ON_MSG(cls > _DPRINTK_SITE_UNCLASSED,		\
+			 "classid value overflow")
+
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
+	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_SITE_UNCLASSED, fmt)
 
 #ifdef CONFIG_JUMP_LABEL
 
@@ -128,18 +139,26 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #endif /* CONFIG_JUMP_LABEL */
 
-#define __dynamic_func_call(id, fmt, func, ...) do {	\
-	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);		\
-	if (DYNAMIC_DEBUG_BRANCH(id))			\
-		func(&id, ##__VA_ARGS__);		\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
+	if (DYNAMIC_DEBUG_BRANCH(id))				\
+		func(&id, ##__VA_ARGS__);			\
 } while (0)
 
-#define __dynamic_func_call_no_desc(id, fmt, func, ...) do {	\
-	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);			\
-	if (DYNAMIC_DEBUG_BRANCH(id))				\
-		func(__VA_ARGS__);				\
+#define __dynamic_func_call_no_desc_cls(id, cls, fmt, func, ...) do {	\
+	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
+	if (DYNAMIC_DEBUG_BRANCH(id))					\
+		func(__VA_ARGS__);					\
 } while (0)
 
+#define __dynamic_func_call(id, fmt, func, ...)				\
+	__dynamic_func_call_cls(id, _DPRINTK_SITE_UNCLASSED,		\
+				fmt, func, ##__VA_ARGS__)
+
+#define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
+	__dynamic_func_call_no_desc_cls(id, _DPRINTK_SITE_UNCLASSED,	\
+					fmt, func, ##__VA_ARGS__)
+
 /*
  * "Factory macro" for generating a call to func, guarded by a
  * DYNAMIC_DEBUG_BRANCH. The dynamic debug descriptor will be
@@ -148,15 +167,24 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * the varargs. Note that fmt is repeated in invocations of this
  * macro.
  */
+#define _dynamic_func_call_cls(cls, fmt, func, ...)			\
+	__dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
 #define _dynamic_func_call(fmt, func, ...)				\
-	__dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
+	_dynamic_func_call_cls(_DPRINTK_SITE_UNCLASSED, fmt, func, ##__VA_ARGS__)
+
 /*
  * A variant that does the same, except that the descriptor is not
  * passed as the first argument to the function; it is only called
  * with precisely the macro's varargs.
  */
-#define _dynamic_func_call_no_desc(fmt, func, ...)	\
-	__dynamic_func_call_no_desc(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call_no_desc_cls(fmt, cat, func, ...)		\
+	__dynamic_func_call_no_desc_cls(__UNIQUE_ID(ddebug), cat,	\
+					fmt, func, ##__VA_ARGS__)
+
+#define _dynamic_func_call_no_desc(fmt, func, ...)			\
+	__dynamic_func_call_no_desc_cls(__UNIQUE_ID(ddebug),		\
+					_DPRINTK_SITE_UNCLASSED,	\
+					fmt, func, ##__VA_ARGS__)
 
 #define dynamic_pr_debug(fmt, ...)				\
 	_dynamic_func_call(fmt,	__dynamic_pr_debug,		\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a56c1286ffa4..eb3209a7aef0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -55,6 +55,8 @@ struct ddebug_query {
 	const char *function;
 	const char *format;
 	unsigned int first_lineno, last_lineno;
+	unsigned int class_id;
+	unsigned int class_marked:1;
 };
 
 struct ddebug_iter {
@@ -134,13 +136,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 			fmtlen--;
 	}
 
-	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
+	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u class=%u\n",
 		 msg,
 		 query->function ?: "",
 		 query->filename ?: "",
 		 query->module ?: "",
 		 fmtlen, query->format ?: "",
-		 query->first_lineno, query->last_lineno);
+		 query->first_lineno, query->last_lineno, query->class_id);
 }
 
 /*
@@ -170,6 +172,10 @@ static int ddebug_change(const struct ddebug_query *query,
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
+			/* match against the class_id, either given or default */
+			if (query->class_id != dp->class_id)
+				continue;
+
 			/* match against the source filename */
 			if (query->filename &&
 			    !match_wildcard(query->filename, dp->filename) &&
@@ -308,6 +314,21 @@ static inline int parse_lineno(const char *str, unsigned int *val)
 	return 0;
 }
 
+static inline int parse_class(struct ddebug_query *query, const char *str)
+{
+	int rc;
+	unsigned int val;
+
+	rc = kstrtouint(str, 10, &val);
+	if (rc < 0 || val > _DPRINTK_SITE_UNCLASSED) {
+		pr_err("expecting class:[0-%d], not %s\n", _DPRINTK_SITE_UNCLASSED, str);
+		return -EINVAL;
+	}
+	query->class_id = val;
+	query->class_marked = 1;
+	return 0;
+}
+
 static int parse_linerange(struct ddebug_query *query, const char *first)
 {
 	char *last = strchr(first, '-');
@@ -421,6 +442,9 @@ static int ddebug_parse_query(char *words[], int nwords,
 		} else if (!strcmp(keyword, "line")) {
 			if (parse_linerange(query, arg))
 				return -EINVAL;
+		} else if (!strcmp(keyword, "class")) {
+			if (parse_class(query, arg))
+				return -EINVAL;
 		} else {
 			pr_err("unknown keyword \"%s\"\n", keyword);
 			return -EINVAL;
@@ -428,6 +452,10 @@ static int ddebug_parse_query(char *words[], int nwords,
 		if (rc)
 			return rc;
 	}
+	/* post-validate the query, set default */
+	if (!query->class_marked)
+		query->class_id = _DPRINTK_SITE_UNCLASSED;
+
 	vpr_info_dq(query, "parsed");
 	return 0;
 }
@@ -900,7 +928,11 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		   iter->table->mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
-	seq_puts(m, "\"\n");
+	seq_puts(m, "\"");
+
+	if (dp->class_id != _DPRINTK_SITE_UNCLASSED)
+		seq_printf(m, " cls:%u", dp->class_id);
+	seq_puts(m, "\n");
 
 	return 0;
 }
-- 
2.35.1

