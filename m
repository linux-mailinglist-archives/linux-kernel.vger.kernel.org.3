Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319AF52946F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349996AbiEPW5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349915AbiEPW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:21 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE39424A4;
        Mon, 16 May 2022 15:57:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o190so17590308iof.10;
        Mon, 16 May 2022 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oowxXNKCjHWnLn3p6Ic/6Uo3PByaWnVU9pS3Z8uXSpQ=;
        b=laqZYh+7BRG4JmqbTRUuBXSeJoX3qpeXSKyN4W6lB9YEap+oHbdDxololCguGAMh5j
         nHo+iMbV1KgWacmGr6OLitd9c+OJnO/2tWVL5454+sTXI5fwoIeNvVDZP+BTxyk5yGlH
         ZjrvfoQIdRrFxg9V0mySCwKU+ZLqJSv6aNnoGqrEzRufoLC8tKnYJtycpQMjFWGmDDr3
         XyoPA0hWE6dcKb4E22Yos6Ma/DhT6NxLI9xKOdKQ8d4wyL2WZgmmBqcUF5zLa+EHROcJ
         OQLF0z+uPf11CatazTyEpY+D3XSh3bsCN33how5DTmDELfXhYvgRWRLTGHM4+RVfuC7n
         KmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oowxXNKCjHWnLn3p6Ic/6Uo3PByaWnVU9pS3Z8uXSpQ=;
        b=ce7tvR8j05hJ6XNjwfoxYbrrDl5HAkV1C5ACJLDB0lrEoKKqSIKl/gLQypeLELIpBh
         f/8PL6mGuNAZFQdUprLw9yRrAgyn8dfYruSnkt948+VshHTb9pIn8dMPlmevs8X/zawm
         wU1zy5uQ0hvaPZYeSUxrLr1AdeYKa5habTxRVNFWB9soztDszqEkpyCQviXUzt8rb5+k
         m4CvQBfMeESg3mQ9uvdHVxBrcE97U03BOeuHHfg1UH8T+wjkCef+7Ieuq3QUkxfKMVz6
         0ZW0oblDSNXtBrrV2Hup/JcF0G0TACcsoTBiFOe3t+CM9zBWv+WRhEkG16RKHAjtwyZq
         +zdg==
X-Gm-Message-State: AOAM533Kd1H84vUtDkuYr8aHEm/aQP9wIPqGyOLz5GZR9AuiVKi9yxzs
        2Hn0JdNLUwp1cxj3qqvgs3U=
X-Google-Smtp-Source: ABdhPJwp2CUlJ62GPweaP9pCG2DJx2i+qE3mjO0+Bwn7/YiIM+8Fh1IYWcLxvILiLSzZdTx4mDun4g==
X-Received: by 2002:a05:6638:504:b0:32e:55a0:dee9 with SMTP id i4-20020a056638050400b0032e55a0dee9mr162907jar.82.1652741828844;
        Mon, 16 May 2022 15:57:08 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:08 -0700 (PDT)
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
Subject: [PATCH v2 07/27] dyndbg: validate class FOO on module
Date:   Mon, 16 May 2022 16:56:20 -0600
Message-Id: <20220516225640.3102269-8-jim.cromie@gmail.com>
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

Add module-to-class validation, in

  #> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control

If a query has "class FOO", ddebug_validate_classname (called from
ddebug_change) requires that FOO is known to module X, otherwize X is
skipped entirely.

The choice of FOO is highly selective, giving isolation and/or
coordinated sharing of FOOs.  For example, only DRM modules should
know and respond to DRM_UT_KMS.

So this, combined with module's opt-in declaration of known classes,
effectively privatizes the .class_id space for each module (or
coordinated set of modules).

Ignoring a bad query, with dynamic_debug.verbose=3:
(lots of modules will not know other module's classes)

bash-5.1# echo module drm class FOO +p > /proc/dynamic_debug/control
[   54.507983] dyndbg: read 24 bytes from userspace
[   54.509549] dyndbg: query 0: "module drm class FOO +p" mod:*
[   54.511502] dyndbg: split into words: "module" "drm" "class" "FOO" "+p"
[   54.513672] dyndbg: op='+'
[   54.514575] dyndbg: flags=0x1
[   54.515547] dyndbg: *flagsp=0x1 *maskp=0xffffffff
[   54.517112] dyndbg: parsed: func="" file="" module="drm" format="" lineno=0-0 class=FOO
[   54.519707] dyndbg: class: drm.FOO unknown
[   54.521302] dyndbg: no matches for query
[   54.522581] dyndbg: no-match: func="" file="" module="drm" format="" lineno=0-0 class=FOO
[   54.525236] dyndbg: processed 1 queries, with 0 matches, 0 errs

Also add a new column to control-file output, displaying the
class-name when its not default.  If a module has pr_debugs with
non-default .class_id's, and has not registered them, "<unregistered>"
is issued.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
. split out validate_classnames()
---
 lib/dynamic_debug.c | 70 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8f600c13048a..b1aaf8893cdf 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -56,6 +56,7 @@ struct ddebug_query {
 	const char *module;
 	const char *function;
 	const char *format;
+	const char *class_string;
 	unsigned int first_lineno, last_lineno;
 };
 
@@ -136,13 +137,40 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
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
+}
+
+/* return <0 if class-name is unknown/invalid, 0..CLASS_DFLT otherwise */
+static int ddebug_validate_classname(struct ddebug_table *dt, const char *class_string)
+{
+	int query_class = -ENOENT;
+	int idx;
+
+	if (!class_string)
+		/* all queries w/o class given work only on default class */
+		return _DPRINTK_CLASS_DFLT;
+
+	/*
+	 * XXX single list will need to be a for-list
+	 * so that modules can have 2 sets of class-decls
+	 */
+	if (!dt->map)
+		return -ENOENT;
+
+	idx = match_string(dt->map->classes, dt->map->length, class_string);
+	if (idx < 0) {
+		v3pr_info("class: %s.%s unknown\n", dt->mod_name, class_string);
+		return -ENOENT;
+	}
+	query_class = idx + dt->map->base;
+
+	return query_class;
 }
 
 /*
@@ -159,6 +187,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
+	int query_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -169,9 +198,18 @@ static int ddebug_change(const struct ddebug_query *query,
 		    !match_wildcard(query->module, dt->mod_name))
 			continue;
 
+		/* validate class-string against module's known classes */
+		query_class = ddebug_validate_classname(dt, query->class_string);
+		if (query_class < 0)
+			continue;
+
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
+			/* match against query-class, either valid input or default */
+			if (query_class != dp->class_id)
+				continue;
+
 			/* match against the source filename */
 			if (query->filename &&
 			    !match_wildcard(query->filename, dp->filename) &&
@@ -424,6 +462,8 @@ static int ddebug_parse_query(char *words[], int nwords,
 		} else if (!strcmp(keyword, "line")) {
 			if (parse_linerange(query, arg))
 				return -EINVAL;
+		} else if (!strcmp(keyword, "class")) {
+			rc = check_set(&query->class_string, arg, "class");
 		} else {
 			pr_err("unknown keyword \"%s\"\n", keyword);
 			return -EINVAL;
@@ -851,6 +891,13 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	return dp;
 }
 
+static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+{
+	if (iter->table->map)
+		return iter->table->map->classes[dp->class_id];
+	return NULL;
+}
+
 /*
  * Seq_ops show method.  Called several times within a read()
  * call from userspace, with ddebug_lock held.  Formats the
@@ -862,6 +909,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
 	struct flagsbuf flags;
+	char const *class;
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
@@ -874,7 +922,13 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		   iter->table->mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
-	seq_puts(m, "\"\n");
+	seq_puts(m, "\"");
+
+	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
+		class = ddebug_class_name(iter, dp);
+		seq_printf(m, " class:%s", class ?: "<unregistered>");
+	}
+	seq_puts(m, "\n");
 
 	return 0;
 }
-- 
2.35.3

