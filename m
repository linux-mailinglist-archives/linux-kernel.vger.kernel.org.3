Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF558B1C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiHEV42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241706AbiHEVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A4E03;
        Fri,  5 Aug 2022 14:54:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id l9so1989720ilq.1;
        Fri, 05 Aug 2022 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1ntMBXwA74iBC/RlqNBXTIaWrG+kFWcB6AY7njBN2E8=;
        b=jiKbznWqsXjnP+nUkACFEuo9GLpsV4w0LdDV6VR+64VxU20bBIs5H1qHWsVZDNnjN1
         HDUPyXqV/Y2/BskBxpheQi66GlAwE/961ySm+A219innWXJt45tTwZm3VuxopmsfcM3v
         nAie1r+MpIJi0S65HzrNouziXi7fJ38ivEz+K2pqmZTiBVHUL0YkCJmkdqSh3KRgT4qG
         8FsLCQXdb8UShevAQtwj2f5jLTZADYZBdDhWRJuJXLLHljHmiPWAqZ/BSBx6IDeQKSHR
         WU3Vwgi/no7/5L8PslPYr3HxGPN1G9ib8tq+ktEbHnj/qVx5iPoBXgAdClcnwv8OHcih
         0KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1ntMBXwA74iBC/RlqNBXTIaWrG+kFWcB6AY7njBN2E8=;
        b=vPx7bSTFXtU4lj/Kp4qhC+5H25V7IuwwhXFflTD53KdEK/hjBfWy/JX761+0uj12Xn
         2Iefgp6DsvNvGZ6RsU7LhKnQeI7uiA7rN4SaBfeciS6RPFami1wOtkdr4bop5EE/QSW9
         LfSq/hdh5CvCCceR4pdxSnnPMdkD1DKnTJfqIGCM9tw8C9Y6CnSoxRqQKB9nczCK01wz
         mXj4PGHR87se4xo0vCM1jd3IzC+H53HN+3cG9pN7EQpGds6trSNtw5Qfr6rk4jfkZH7v
         5VRGLy7lza7H5MVkGZKUmZtmSqwjLiWm9TK+TIf/rMO2u3NlofcQxUAy3wb7q4eLe86a
         m6jg==
X-Gm-Message-State: ACgBeo3CqnSJcvjDor5ojfTZVhtVtcV3ragSVMMzeGNO+J+R3dzz6GwE
        1mY3rITWe7LtI44Z+aqar3WydBaA8ZziXw==
X-Google-Smtp-Source: AA6agR48s5NPRt1YhcAWvCagIn/BS0C0y8WsvLDToFTnMGHjigtHrLFLYeGrlXnsnMUiteVk8NR1bQ==
X-Received: by 2002:a92:cd84:0:b0:2df:52fa:30c4 with SMTP id r4-20020a92cd84000000b002df52fa30c4mr3727235ilb.314.1659736479367;
        Fri, 05 Aug 2022 14:54:39 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 17/33] dyndbg: validate class FOO by checking with module
Date:   Fri,  5 Aug 2022 15:53:39 -0600
Message-Id: <20220805215355.3509287-18-jim.cromie@gmail.com>
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

Add module-to-class validation:

  #> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control

If a query has "class FOO", then ddebug_find_valid_class(), called
from ddebug_change(), requires that FOO is known to module X,
otherwize the query is skipped entirely for X.  This protects each
module's class-space, other than the default:31.

The authors' choice of FOO is highly selective, giving isolation
and/or coordinated sharing of FOOs.  For example, only DRM modules
should know and respond to DRM_UT_KMS.

So this, combined with module's opt-in declaration of known classes,
effectively privatizes the .class_id space for each module (or
coordinated set of modules).

Notes:

For all "class FOO" queries, ddebug_find_valid_class() is called, it
returns the map matching the query, and sets valid_class via an
*outvar).

If no "class FOO" is supplied, valid_class = _CLASS_DFLT.  This
insures that legacy queries do not trample on new class'd callsites,
as they get added.

Also add a new column to control-file output, displaying non-default
class-name (when found) or the "unknown _id:", if it has not been
(correctly) declared with one of the declarator macros.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 76 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a3ace5866f1b..eb410b412f0d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -56,6 +56,7 @@ struct ddebug_query {
 	const char *module;
 	const char *function;
 	const char *format;
+	const char *class_string;
 	unsigned int first_lineno, last_lineno;
 };
 
@@ -136,15 +137,33 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 			fmtlen--;
 	}
 
-	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
-		 msg,
-		 query->function ?: "",
-		 query->filename ?: "",
-		 query->module ?: "",
-		 fmtlen, query->format ?: "",
-		 query->first_lineno, query->last_lineno);
+	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u class=%s\n",
+		  msg,
+		  query->function ?: "",
+		  query->filename ?: "",
+		  query->module ?: "",
+		  fmtlen, query->format ?: "",
+		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
+							  const char *class_string, int *class_id)
+{
+	struct ddebug_class_map *map;
+	int idx;
+
+	list_for_each_entry(map, &dt->maps, link) {
+		idx = match_string(map->class_names, map->length, class_string);
+		if (idx >= 0) {
+			*class_id = idx + map->base;
+			return map;
+		}
+	}
+	*class_id = -ENOENT;
+	return NULL;
+}
+
+#define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -159,6 +178,8 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
+	struct ddebug_class_map *map = NULL;
+	int __outvar valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -169,9 +190,22 @@ static int ddebug_change(const struct ddebug_query *query,
 		    !match_wildcard(query->module, dt->mod_name))
 			continue;
 
+		if (query->class_string) {
+			map = ddebug_find_valid_class(dt, query->class_string, &valid_class);
+			if (!map)
+				continue;
+		} else {
+			/* constrain query, do not touch class'd callsites */
+			valid_class = _DPRINTK_CLASS_DFLT;
+		}
+
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
+			/* match site against query-class */
+			if (dp->class_id != valid_class)
+				continue;
+
 			/* match against the source filename */
 			if (query->filename &&
 			    !match_wildcard(query->filename, dp->filename) &&
@@ -420,6 +454,8 @@ static int ddebug_parse_query(char *words[], int nwords,
 		} else if (!strcmp(keyword, "line")) {
 			if (parse_linerange(query, arg))
 				return -EINVAL;
+		} else if (!strcmp(keyword, "class")) {
+			rc = check_set(&query->class_string, arg, "class");
 		} else {
 			pr_err("unknown keyword \"%s\"\n", keyword);
 			return -EINVAL;
@@ -854,6 +890,20 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	return dp;
 }
 
+#define class_in_range(class_id, map)					\
+	(class_id >= map->base && class_id < map->base + map->length)
+
+static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+{
+	struct ddebug_class_map *map;
+
+	list_for_each_entry(map, &iter->table->maps, link)
+		if (class_in_range(dp->class_id, map))
+			return map->class_names[dp->class_id - map->base];
+
+	return NULL;
+}
+
 /*
  * Seq_ops show method.  Called several times within a read()
  * call from userspace, with ddebug_lock held.  Formats the
@@ -865,6 +915,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
 	struct flagsbuf flags;
+	char const *class;
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
@@ -877,7 +928,16 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		   iter->table->mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
-	seq_puts(m, "\"\n");
+	seq_puts(m, "\"");
+
+	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
+		class = ddebug_class_name(iter, dp);
+		if (class)
+			seq_printf(m, " class:%s", class);
+		else
+			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+	}
+	seq_puts(m, "\n");
 
 	return 0;
 }
-- 
2.37.1

