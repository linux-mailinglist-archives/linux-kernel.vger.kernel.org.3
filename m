Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85242529470
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbiEPW56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349884AbiEPW50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:26 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2682C4476F;
        Mon, 16 May 2022 15:57:16 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j7so2188204ila.1;
        Mon, 16 May 2022 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Wk014TwyjnrOaQ2i3WNMMRKpv2e+mMH/KYOzUNpIOE=;
        b=NbC3sbmxQ0gNlrzlR6q30F5DeIDupJtg/rWawsgTFkINjdCXcKwcQjJ+80AMWIsf38
         8LFB7eLOgSryfGffVVoVbm6DUrrP/Ea2cEe2zYmQCl5zQw04DDTNTUdyoN/Z1QUuFMPC
         tC7D4LPtwPgOaRl6JXoEqld602TZ50DbL8yu61BZUzG6TQ4Dv+vC+K35WGFouu1Elsbu
         eeVoIPCbMW7zL3ymZ6nhdNZ+j+U2ej6XMf6WKb0i63W9YVL7MgNCv4nTLgDywQnl8irm
         ow6CNlSYNmujeLBprx1idrRFeRo6Nj9U1IyTMWAvarnXzuWDJDI1xLEIfdhu0yDJjf9C
         q41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Wk014TwyjnrOaQ2i3WNMMRKpv2e+mMH/KYOzUNpIOE=;
        b=jy5qZvTJoMpc5E3ccPTkGyWGK1GgxXbTnII/s3+MObvVMopExlKTyXYTz9aAXeeaEG
         EdlCkJyd9fuCBX/Oy0kl5MWubxlK8Ou5W7v1/TVtESwt4AAcvxZ2OQxde0BBWAwbbiMc
         z9Cu92/rn7M2GuWP3fw2gK0LilHBpHuCCvBgSp+6pTBY9y0NRRwJYV6Lr+4fRu85U7Ra
         3/NqILQP9I1LyKHrUcYGhI/iLQRQ0Y9yEpplLdfuGj3BLPY9cd++Wz9mdtZ/eEHWnP3r
         rgsHPYugrHqaXoJ44iHqjBHUlBQ0is5w8wMzD2Yrcj9YCcSXddNywei+Hcwvugew14mF
         yhGA==
X-Gm-Message-State: AOAM532M1pb31xfPpkR2cQlcNQXE+va+JMg43fDwsi0+vv6FygfXe0kH
        Xa8dctWo8AlM1lTBWILSlIU=
X-Google-Smtp-Source: ABdhPJzsYhdemnsNa7jolhgES0cXpVtGwAcCj/g475kUSD5yZiac8pvgAJmKVJyqTCsdFP4vD4XH9A==
X-Received: by 2002:a05:6e02:1788:b0:2cf:3150:f26c with SMTP id y8-20020a056e02178800b002cf3150f26cmr10109037ilu.214.1652741835464;
        Mon, 16 May 2022 15:57:15 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:15 -0700 (PDT)
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
Subject: [PATCH v2 12/27] dyndbg: change zero-or-one classes-map to maps list
Date:   Mon, 16 May 2022 16:56:25 -0600
Message-Id: <20220516225640.3102269-13-jim.cromie@gmail.com>
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

Upgrade single classes-map to list of them:

This allows multiple DYNAMIC_DEBUG_CLASSES(class-map)s per module,
using _base to segment the 0..30 classid space.

alter struct ddebug table:
 replace .classes (a &map) with maps (list-head)

dynamic_debug_register_classes(map) - adds new map to maps list.

dynamic_debug_unregister_classes(map) - deletes map after ID-check.

ddebug_validate_classname() - check all maps in list before failing.

ddebug_class_name() - which supports ```cat control``` now walks maps
list, finds the map whose sub-range of .class_id's spans the one in
the callsite, and returns that class-name.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
. split out validate_classnames()
. fold in fixes for multi class-maps
---
 lib/dynamic_debug.c | 76 +++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8e1b9159e881..f9c5bbf9d43b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -43,10 +43,8 @@ extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
 
 struct ddebug_table {
-	struct list_head link;
+	struct list_head link, maps;
 	const char *mod_name;
-	/* a module can have multiple class-sets eventually, but not yet */
-	struct ddebug_known_classes_map const *map;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
 };
@@ -149,28 +147,18 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 /* return <0 if class-name is unknown/invalid, 0..CLASS_DFLT otherwise */
 static int ddebug_validate_classname(struct ddebug_table *dt, const char *class_string)
 {
-	int query_class = -ENOENT;
+	struct ddebug_known_classes_map *map;
 	int idx;
 
 	if (!class_string)
-		/* all queries w/o class given work only on default class */
 		return _DPRINTK_CLASS_DFLT;
 
-	/*
-	 * XXX single list will need to be a for-list
-	 * so that modules can have 2 sets of class-decls
-	 */
-	if (!dt->map)
-		return -ENOENT;
-
-	idx = match_string(dt->map->classes, dt->map->length, class_string);
-	if (idx < 0) {
-		v3pr_info("class: %s.%s unknown\n", dt->mod_name, class_string);
-		return -ENOENT;
+	list_for_each_entry(map, &dt->maps, link) {
+		idx = match_string(map->classes, map->length, class_string);
+		if (idx >= 0)
+			return idx + map->base;
 	}
-	query_class = idx + dt->map->base;
-
-	return query_class;
+	return -ENOENT;
 }
 
 /*
@@ -1032,8 +1020,14 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	if (iter->table->map)
-		return iter->table->map->classes[dp->class_id];
+	struct ddebug_known_classes_map *map;
+
+	list_for_each_entry(map, &iter->table->maps, link) {
+		if (dp->class_id < map->base ||
+		    dp->class_id >= map->base + map->length)
+			continue;
+		return map->classes[dp->class_id - map->base];
+	}
 	return NULL;
 }
 
@@ -1124,6 +1118,7 @@ int dynamic_debug_register_classes(struct ddebug_known_classes_map *map)
 	struct ddebug_table *dt;
 	int rc = -ENOENT;
 
+	INIT_LIST_HEAD(&map->link);
 	mutex_lock(&ddebug_lock);
 #ifdef CONFIG_MODULES
 	if (map->mod) {
@@ -1131,7 +1126,7 @@ int dynamic_debug_register_classes(struct ddebug_known_classes_map *map)
 		list_for_each_entry(dt, &ddebug_tables, link) {
 			if (dt->mod_name == map->mod->name) {
 				rc = 0;
-				dt->map = map;
+				list_add(&map->link, &dt->maps);
 				break;
 			}
 		}
@@ -1142,7 +1137,7 @@ int dynamic_debug_register_classes(struct ddebug_known_classes_map *map)
 		list_for_each_entry(dt, &ddebug_tables, link) {
 			if (!strcmp(dt->mod_name, map->mod_name)) {
 				rc = 0;
-				dt->map = map;
+				list_add(&map->link, &dt->maps);
 				break;
 			}
 		}
@@ -1159,8 +1154,38 @@ EXPORT_SYMBOL(dynamic_debug_register_classes);
 
 void dynamic_debug_unregister_classes(struct ddebug_known_classes_map *map)
 {
-	vpr_info("unregister_classes: %s\n", map->mod_name);
+	int rc = -ENOENT;
+
+	mutex_lock(&ddebug_lock);
+#ifdef CONFIG_MODULES
+	if (map->mod) {
+		struct ddebug_known_classes_map *dmap;
+		struct ddebug_table *dt;
+
+		list_for_each_entry(dt, &ddebug_tables, link) {
+			if (dt->mod_name != map->mod->name)
+				continue;
+			list_for_each_entry(dmap, &dt->maps, link) {
+				if (dmap != map)
+					continue;
+				rc = 0;
+				list_del(&map->link);
+				break;
+			}
+		}
+	}
+#endif
+	if (!map->mod) {
+		pr_err("shouldn't be unloading a builtin module: %s\n",
+		       map->mod_name);
+	}
+	mutex_unlock(&ddebug_lock);
+	if (rc)
+		pr_warn("unregister_classes: module %s not found\n", map->mod_name);
+	else
+		vpr_info("unregister_classes: %s\n", map->mod_name);
 }
+EXPORT_SYMBOL(dynamic_debug_unregister_classes);
 
 /*
  * Allocate a new ddebug_table for the given module
@@ -1186,6 +1211,9 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->num_ddebugs = n;
 	dt->ddebugs = tab;
 
+	INIT_LIST_HEAD(&dt->link);
+	INIT_LIST_HEAD(&dt->maps);
+
 	mutex_lock(&ddebug_lock);
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
-- 
2.35.3

