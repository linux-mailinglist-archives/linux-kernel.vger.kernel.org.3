Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD60452946D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350184AbiEPW6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349904AbiEPW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:21 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A2342EE8;
        Mon, 16 May 2022 15:57:08 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b11so7613047ilr.4;
        Mon, 16 May 2022 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCcwbojewkLsQYvkUKvi9ZnuSdibkB/9h3rl9AlklQ0=;
        b=BeGrZc1yYBGXRQAvCajroJY45Q74LlURa0Ayje5jv28R3leJsPJbbYx/29IHtflt0j
         snhm4cXg8IF3NJ9cpM7XtI9fLxm4NYgdEPjk4txQ8yQVjk2+O7jljjqETHuZUwtJDsm5
         xWAXYRuk38aNOHxOcKllwLmeH+zvd7FACklgZhNSsZ79osTKBjvhiXgVclwoZqc2bpjE
         yelTlxzX/Ql/41MYJXeVU+/+QDchf/5JfDBfBDt4HwmxBYj1dPE0ut/Ixz0jldDIZRKo
         1zhjm7O4XnQNVRj1apdu3bYwT5J19T4lgLOKFIY25c2+q1MCCblGLIfqkzd5MTcbODwR
         soNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCcwbojewkLsQYvkUKvi9ZnuSdibkB/9h3rl9AlklQ0=;
        b=jK6QbjJ/j/nMeW5SVFXvgBaP8+7vzP42QNawoPIfvLusojRIUmOdyOk5ouCndmOgMw
         smxrVJQdsy7rOMycFbwFeAXSdUrl8LeZN0oj8FeqdOyTeAiPzMHb+uARdsoe7cPWlvjU
         Jo8mq5H5YZCb32d7t1NoG5siruWQ6Q9qxtbtAXrIwOOFr8P+TfqvBZ4VJyi+4WaRYhUe
         F/GWHcwSOD8qoJQKswRQ/TwJsdG7fhaFOVkt5c9ysEXmlRBbS4yfeZ7lDA690pytJpEN
         SfXvv34KQgBiy98y6K+W7Glhd6/gLCsoNjxe6DZ0iR7DejO4GGnerhnvJi2RoLxkRxkR
         8hZw==
X-Gm-Message-State: AOAM5326V66hazUGCWqgUb0QAAP8gpKNkMPOA+Xu95n/AS83bd6rvvSm
        ltvrMOWstS6RK8htfHLk+ns=
X-Google-Smtp-Source: ABdhPJxVb768sz14W3aG69KflgqJ0KKyFVj6N0LZ3gnkCyX1Snc1VgNcUxaQiUqGSGOvtt6QMgsJEA==
X-Received: by 2002:a05:6e02:1187:b0:2cd:9df5:bfd2 with SMTP id y7-20020a056e02118700b002cd9df5bfd2mr11169744ili.121.1652741827704;
        Mon, 16 May 2022 15:57:07 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:07 -0700 (PDT)
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
Subject: [PATCH v2 06/27] dyndbg: add dynamic_debug_(un)register_classes
Date:   Mon, 16 May 2022 16:56:19 -0600
Message-Id: <20220516225640.3102269-7-jim.cromie@gmail.com>
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

Add dynamic_debug_register_classes() to API, allowing user modules
(builtin and loadable) to register class_names for the .class_id's
they are using.  Knowing classes is 1st step to validating with them.
Add dynamic_debug_unregister_classes() also.

Add struct ddebug_known_classes_map: maps known class_name strings to
.class_id[0..N], where N<31.  .base allows sharing of that range.

A wrapper macro: DYNAMIC_DEBUG_CLASSES(_var, _modmatch, _base,
classes) defines and initializes that struct var, _maybe_unused is
added so the decl doesn't draw warnings when dyndbg is not enabled; a
small list of classnames is tolerable wasted space.

_var: user passes this into dynamic_debug_register_classes(var).

_base: usually 0, it allows splitting 31 classes into subranges, so
that multiple sysfs-nodes can share the module's class-id space.

classes: list of strings with classnames, mapped to class-id=idx(+_base)

mod_name: KBUILD_MODNAME, available for builtins, loadables
mod:	  ref to loadable module. allows ==, distinguishing loadables.

When modules register known classnames, they opt-in to permit dyndbg
to allow "class <name>" queries to manipulate their class'd pr_debugs
(if any), default class_id pr_debugs are still controllable as before.

dynamic_debug_register_classes(&map) finds the module's ddebug_table
record, and attaches the map to it.  This makes it available to
ddebug_change(), which will use it to validate class'd commands.

Sharing class-names across multiple modules is how those modules
coordinate; all drm* and drivers would respond to:

  #> echo class DRM_UT_CORE +p > /proc/dynamic_debug/control

Therefore no class-name uniqueness check is useful.

TODO: Eventually we need a list of registered classes, not just the
zero-or-one implemented here.  This will support multiple sysfs-nodes,
one each for print-to-syslog, print-to-tracefs, or subranges using
_base.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
. fix register_classes() for !CONFIG_MODULES
. add maybe-unused to var decl in DYNAMIC_DEBUG_CLASSES
. kdoc for DYNAMIC_DEBUG_CLASSES
. add dynamic_debug_unregister_classes
---
 include/linux/dynamic_debug.h | 36 ++++++++++++++++++++++++
 lib/dynamic_debug.c           | 53 +++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 39550fefcf0f..328722ba2d8e 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -56,6 +56,34 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
+struct ddebug_known_classes_map {
+	struct list_head link;
+	struct module *mod;
+	const char *mod_name;	/* needed for builtins */
+	const int base;		/* index of 1st .class_id, allows split/shared space */
+	const int length;
+	const char *classes[];	/* index maps .class_id */
+};
+
+#define NUM_TYPE_ARGS(eltype, ...) \
+	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
+/**
+ * DYNAMIC_DEBUG_CLASSES - declare classnames known by a module
+ * @_var: passed to dynamic_debug_register_classes(_var)
+ * @_base: offset of 1st class-name. splits .class_id space
+ * @classes: class-names known/used by of .class_ids[_base.._base+length]
+ *
+ * @classes specifies names for the classids used by a module; dyndbg
+ * accepts "class <name>" commands if <name> is known and registered.
+ */
+#define DYNAMIC_DEBUG_CLASSES(_var, _base, ...)				\
+	static __maybe_unused struct ddebug_known_classes_map _var = {	\
+		.mod = THIS_MODULE,					\
+		.mod_name = KBUILD_MODNAME,				\
+		.base = _base,						\
+		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.classes = { __VA_ARGS__ }				\
+	}
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
@@ -206,6 +234,9 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 				   KERN_DEBUG, prefix_str, prefix_type,	\
 				   rowsize, groupsize, buf, len, ascii)
 
+int  dynamic_debug_register_classes(struct ddebug_known_classes_map *map);
+void dynamic_debug_unregister_classes(struct ddebug_known_classes_map *map);
+
 #else /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #include <linux/string.h>
@@ -247,6 +278,11 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 	} while (0)
 
 
+static inline int dynamic_debug_register_classes(const struct ddebug_known_classes_map *map)
+{ return 0; }
+static inline void dynamic_debug_unregister_classes(struct ddebug_known_classes_map *map)
+{}
+
 #endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cdc0b03b1148..8f600c13048a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -45,6 +45,8 @@ extern struct _ddebug __stop___dyndbg[];
 struct ddebug_table {
 	struct list_head link;
 	const char *mod_name;
+	/* a module can have multiple class-sets eventually, but not yet */
+	struct ddebug_known_classes_map const *map;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
 };
@@ -916,6 +918,57 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
+/**
+ * dynamic_debug_register_classes - register a module's known classes
+ * @map:  &struct ddebug_known_classes_map
+ *
+ * modules using non-default pr_debug.class_id's should call this to
+ * inform dyndbg which classes they use (0..N), and what their
+ * classnames are.  They are then usable in ```echo $cmd >control```
+ */
+int dynamic_debug_register_classes(struct ddebug_known_classes_map *map)
+{
+	struct ddebug_table *dt;
+	int rc = -ENOENT;
+
+	mutex_lock(&ddebug_lock);
+#ifdef CONFIG_MODULES
+	if (map->mod) {
+		/* loadable module */
+		list_for_each_entry(dt, &ddebug_tables, link) {
+			if (dt->mod_name == map->mod->name) {
+				rc = 0;
+				dt->map = map;
+				break;
+			}
+		}
+	}
+#endif
+	if (!map->mod) {
+		/* builtin module */
+		list_for_each_entry(dt, &ddebug_tables, link) {
+			if (!strcmp(dt->mod_name, map->mod_name)) {
+				rc = 0;
+				dt->map = map;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&ddebug_lock);
+	if (rc)
+		pr_warn("register_classes: module %s not found\n", map->mod_name);
+	else
+		vpr_info("register_classes: %s\n", map->mod_name);
+
+	return rc;
+}
+EXPORT_SYMBOL(dynamic_debug_register_classes);
+
+void dynamic_debug_unregister_classes(struct ddebug_known_classes_map *map)
+{
+	vpr_info("unregister_classes: %s\n", map->mod_name);
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
-- 
2.35.3

