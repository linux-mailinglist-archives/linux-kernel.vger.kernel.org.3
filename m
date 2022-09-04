Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73565AC71E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiIDVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiIDVmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373592F008
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:25 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e195so5690483iof.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ygTuajbmVKRymZcTR8l4AYG1vTV31KkFalfQRqvEO70=;
        b=qb+eXUS2FeGvpVtJ7v+DpOZwxGybLXxNLvokvSQTdNFeUtdY8CsheY5eB/SHmPx4O9
         huSEsSDTQKrSj+0Puiw+lGBf49Y4J1xWJgf6Ap2MJoyUCbw2fAY5nQAAJERXo7vJ7beG
         uEy7TG4owjT8onLbXW0wMRyVFiQeDhNfDDdJsyJhbLqVj3VikXMuVtM2AfKuFTkruuIT
         ZEtn5PQ+tih96gGXNgsH2cVDPtvjPYgq/XfBF5eBzbkWlcn29wqz/HPJB8mdX0xxRHTF
         eqZ20NxASPafvwnESXcu++44WdfCGPEIGsJqdmjGZ4Ebkk3JbphMGW8Ilt+BN7LlYeLQ
         RQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ygTuajbmVKRymZcTR8l4AYG1vTV31KkFalfQRqvEO70=;
        b=v67MR2cLj+bZNLnZfdyhRe0FOso0QQlLE7VuB8SQnT+X7+zg3y/tUvl0tynz8rPLWQ
         maoqIIrvx/oQxRWkRNmXyqPz957kvuPYQ5gVTqg1Uq2m/OKbKQttQODLgN9emVJLkj8s
         bNHpxjZm2JdNxvSJ3A8XL3pX0Dn/AGwvLh8lIz7fteiTwEZDTfuJ8/OBY7P6xuOM8Ybe
         Tm/8TuVHWuyyBMeJD1SHswhOoTiUcfG446IIrpUDbzzKcDemp6i4jgwfCFwFRRzn/Nge
         k0EB9v68UxhIPAVztUNkEEw/N97gN5GRMI984pzCDntpOk8hXXq74PZQg92g3t2FX8Vs
         IS0A==
X-Gm-Message-State: ACgBeo14hpD8SsmitrE3GoCQEmsnXF5rCwy6rTWU3AFVYfvgH1H5Qvkm
        gHbWNEe6Wpv8Y2xcrW/mlUw=
X-Google-Smtp-Source: AA6agR6i2bEKl1Cs2088Bgc9CVI77OTinqvJI0IWGolf9NIA7tDBAIrKIIWBixVDBMgcEhK2nR9WNg==
X-Received: by 2002:a05:6638:4091:b0:342:e406:45d8 with SMTP id m17-20020a056638409100b00342e40645d8mr25310655jam.130.1662327744496;
        Sun, 04 Sep 2022 14:42:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 15/57] kernel/module: add __dyndbg_classes section
Date:   Sun,  4 Sep 2022 15:40:52 -0600
Message-Id: <20220904214134.408619-16-jim.cromie@gmail.com>
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

Add __dyndbg_classes section, using __dyndbg as a model. Use it:

vmlinux.lds.h:

KEEP the new section, which also silences orphan section warning on
loadable modules.  Add (__start_/__stop_)__dyndbg_classes linker
symbols for the c externs (below).

kernel/module/main.c:
- fill new fields in find_module_sections(), using section_objs()
- extend callchain prototypes
  to pass classes, length
  load_module(): pass new info to dynamic_debug_setup()
  dynamic_debug_setup(): new params, pass through to ddebug_add_module()

dynamic_debug.c:
- add externs to the linker symbols.

ddebug_add_module():
- It currently builds a debug_table, and *will* find and attach classes.

dynamic_debug_init():
- add class fields to the _ddebug_info cursor var: di.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 3 +++
 include/linux/dynamic_debug.h     | 2 ++
 kernel/module/main.c              | 2 ++
 lib/dynamic_debug.c               | 7 +++++++
 4 files changed, 14 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7515a465ec03..9b8bd5504ad9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -345,6 +345,9 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
+	__start___dyndbg_classes = .;					\
+	KEEP(*(__dyndbg_classes))					\
+	__stop___dyndbg_classes = .;					\
 	__start___dyndbg = .;						\
 	KEEP(*(__dyndbg))						\
 	__stop___dyndbg = .;						\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 98dbf1d49984..9073a43a2039 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -114,7 +114,9 @@ struct ddebug_class_map {
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
+	struct ddebug_class_map *classes;
 	unsigned int num_descs;
+	unsigned int num_classes;
 };
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 4c20bc3ff203..6aa6153aa6e0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2113,6 +2113,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 
 	info->dyndbg.descs = section_objs(info, "__dyndbg",
 					sizeof(*info->dyndbg.descs), &info->dyndbg.num_descs);
+	info->dyndbg.classes = section_objs(info, "__dyndbg_classes",
+					sizeof(*info->dyndbg.classes), &info->dyndbg.num_classes);
 
 	return 0;
 }
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c358ccdf4a39..fb31a1a2fc3f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -41,6 +41,8 @@
 
 extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
+extern struct ddebug_class_map __start___dyndbg_classes[];
+extern struct ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -1079,7 +1081,9 @@ static int __init dynamic_debug_init(void)
 
 	struct _ddebug_info di = {
 		.descs = __start___dyndbg,
+		.classes = __start___dyndbg_classes,
 		.num_descs = __stop___dyndbg - __start___dyndbg,
+		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
 	};
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
@@ -1122,6 +1126,9 @@ static int __init dynamic_debug_init(void)
 		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
 		 (int)((i * sizeof(struct _ddebug)) >> 10));
 
+	if (di.num_classes)
+		v2pr_info("  %d builtin ddebug class-maps\n", di.num_classes);
+
 	/* now that ddebug tables are loaded, process all boot args
 	 * again to find and activate queries given in dyndbg params.
 	 * While this has already been done for known boot params, it
-- 
2.37.2

