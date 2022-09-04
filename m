Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAACD5AC71B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiIDVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiIDVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B035F2EF1B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:25 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 62so5673946iov.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bV2pbi1NEnXBIYceq2iCnojYvMw47Sm5P0bDatZE/qY=;
        b=DRCAFhL8qizXn9QBOsMZO6CWk737/iorbRJ4AxHGEgMlW1XjBcP+vkmFKNoyTUK0Mj
         RgDgR2Ync4KORGyKwN45XuxZ3LCgDHh7aM7gIcdOLcttBFR6Un79bJyvT2V/T+t1uwET
         tHeAl0kEFnMLN5umqFTSN7rOVhAj0XWVzl/y6lz8DsbMtgZKngpwCHlWQPaVdjC6LyHL
         qSLUkoUXTZ6m9J5MpZDXz12M3aHFBVeTnL/qP7lUD45vpjehf2aOfxyxGF8UMp8S8D8U
         hKvmKb7U5FALDSB3abvwTeqDsOg4bgbNnzuU9E1pJLb4XrIdrdIzUyRn++u3pSGOKqBq
         6ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bV2pbi1NEnXBIYceq2iCnojYvMw47Sm5P0bDatZE/qY=;
        b=occVs2iPNgKpwi+93QaEZ22NN2UXfda/NFNHfwdb5tPENYVLAq+A1Kx2H4loBCguhd
         X4RNcCkIaA2+q1t9G0Nr+FuAAw9Fy4s++d0fqbdlVpuHb5XQfRAsmDjBNFucE/gHwHAt
         2vxsdky8bFzW9hOAZffpqA+XHX6TST3qK4SPePX3b7oiZquPmEAXP1TszMpbKWiGEDtu
         vtnxOqiy4gVRm253zLgEM5x6qakqj4adqeZitOLJ9yykRXdOT/oWkoJG9tIWs2eQ7x4k
         B8hyXNDgHp3edycrsqk2xG4/6MSJk4DHawV19GmFT1Evr3Y5ATqERO7DweWOOYBgrMDv
         XoHg==
X-Gm-Message-State: ACgBeo2nBSo2sXAa9dqUa+I/SuMRqtSiSit2Gjn2sv68/zkNJaWv8i1y
        muCARip2Y46SonVLfWx/6Bg=
X-Google-Smtp-Source: AA6agR4Eiudl3FZhHqIH1u+1kjDcwObHAsibzo+7iq3K3aAIOXK9LPSM3GGiI3JaBRbAwyq3KZU0rA==
X-Received: by 2002:a6b:3e06:0:b0:68b:7524:f342 with SMTP id l6-20020a6b3e06000000b0068b7524f342mr15398868ioa.149.1662327745421;
        Sun, 04 Sep 2022 14:42:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 16/57] dyndbg: add ddebug_attach_module_classes
Date:   Sun,  4 Sep 2022 15:40:53 -0600
Message-Id: <20220904214134.408619-17-jim.cromie@gmail.com>
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

Add ddebug_attach_module_classes(), call it from ddebug_add_module().
It scans the classes/section its given, finds records where the
module-name matches the module being added, and adds them to the
module's maps list.  No locking here, since the record
isn't yet linked into the ddebug_tables list.

It is called indirectly from 2 sources:

 - from load_module(), where it scans the module's __dyndbg_classes
   section, which contains DYNAMIC_DEBUG_CLASSES definitions from just
   the module.

 - from dynamic_debug_init(), where all DYNAMIC_DEBUG_CLASSES
   definitions of each builtin module have been packed together.
   This is why ddebug_attach_module_classes() checks module-name.

NOTES

Its (highly) likely that builtin classes will be ordered by module
name (just like prdbg descriptors are in the __dyndbg section).  So
the list can be replaced by a vector (ptr + length), which will work
for loaded modules too.  This would imitate whats currently done for
the _ddebug descriptors.

That said, converting to vector,len is close to pointless; a small
minority of modules will ever define a class-map, and almost all of
them will have only 1 or 2 class-maps, so theres only a couple dozen
pointers to save.  TODO: re-evaluate for lines removable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v6
. fix compile err due to reorderd commits, and missed lkp report.
. init dt->maps in ddebug_add_module, prior to ddebug_attach_module_classes
---
 lib/dynamic_debug.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fb31a1a2fc3f..b71efd0b491d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -45,7 +45,7 @@ extern struct ddebug_class_map __start___dyndbg_classes[];
 extern struct ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
-	struct list_head link;
+	struct list_head link, maps;
 	const char *mod_name;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
@@ -921,6 +921,32 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
+static void ddebug_attach_module_classes(struct ddebug_table *dt,
+					 struct ddebug_class_map *classes,
+					 int num_classes)
+{
+	struct ddebug_class_map *cm;
+	int i, j, ct = 0;
+
+	for (cm = classes, i = 0; i < num_classes; i++, cm++) {
+
+		if (!strcmp(cm->mod_name, dt->mod_name)) {
+
+			v2pr_info("class[%d]: module:%s base:%d len:%d ty:%d\n", i,
+				  cm->mod_name, cm->base, cm->length, cm->map_type);
+
+			for (j = 0; j < cm->length; j++)
+				v3pr_info(" %d: %d %s\n", j + cm->base, j,
+					  cm->class_names[j]);
+
+			list_add(&cm->link, &dt->maps);
+			ct++;
+		}
+	}
+	if (ct)
+		vpr_info("module:%s attached %d classes\n", dt->mod_name, ct);
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -952,6 +978,10 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
+	INIT_LIST_HEAD(&dt->maps);
+
+	if (di->classes && di->num_classes)
+		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
-- 
2.37.2

