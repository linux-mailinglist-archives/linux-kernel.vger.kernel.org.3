Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF325AC7CB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiIDVqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiIDVoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:24 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E1C30558
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:52 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e7so3873365ilc.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Bp0ePs8qbV0UvEjRZpFwk6Hm/6e1kM/XXrwCCotNRwY=;
        b=XI+lDDMQn1sJTAtsYXCSCZllHbtd6NOelDveTu16Um2gjNpYLeMWEPdHoroi+WJR56
         k3PgFGFfbCQMOWVL4snzUZdVG+0cVnNUbfzxIKDLpC2iJQFgtJDx0CvxlhMkm+BuNHYM
         JOpIUa7zmX68L2U/aSqdB7PBn6ttAlQuheS/8IeqXuRiGsnhj+Lnu52QEV+kNwnXaeJD
         afRgsXfC7uf0JeApZ0fm2iin8GGl0CcHiwA1rJtoEcVABdqcneG5T6RL110N966WpM0o
         k1FblDutKG52QhJ9j7imv5ETtSUwiKKH84KtJRukZEMY244luC3ugPo7akWliqMbT+Gf
         LhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Bp0ePs8qbV0UvEjRZpFwk6Hm/6e1kM/XXrwCCotNRwY=;
        b=8QHK+ndyCc3ULphn7X+8yAfVmN/K8VHNeIKnKblt+9QGohCuUTqmIc0vAq71c+myWs
         CDHAR2vf3GlyK/GUGy4W/TE5etOlul3190KKv/gewOHsTT2TEgcc9AsD2TWd/xABQBi7
         2PkKBXwKYMe9Im0yyZwb3fW1yi//LYuH3db/aO+rzlt0DP8NImumKqxyNBSCCZgqegnu
         cpvcAlKVTcAktF+XMhJCjYZ7gS+gx1Wn3nn+WteGl6Sn9nXNpffm1EIvdKrWyq/QEtrb
         6Ie1EkWa98NjugP/8l4wBGhBgFvQFK9lGKNLcuOkvIO+RSVo40ccmK1PgP7ncivfw2Kr
         zChg==
X-Gm-Message-State: ACgBeo0TeBlVKXdvMtNvKAkwRyT4tbhz0CNXKY8o28Kiz4sLKYZZtSzC
        7/j1Gjg7/T18hDiwc3WdcJg=
X-Google-Smtp-Source: AA6agR6GJ3545nMVzxW2kytCo0sZT1XkmI6FXzQ5bdXfVdq6vQh7IQ0VQLKX9DkPjjjN1oLgs/PH0w==
X-Received: by 2002:a92:dcc2:0:b0:2e4:38f2:a9f6 with SMTP id b2-20020a92dcc2000000b002e438f2a9f6mr24500432ilr.130.1662327772508;
        Sun, 04 Sep 2022 14:42:52 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 44/57] dyndbg: extend __ddebug_add_module proto to allow packing sites
Date:   Sun,  4 Sep 2022 15:41:21 -0600
Message-Id: <20220904214134.408619-45-jim.cromie@gmail.com>
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

In order to actually reclaim useful blocks of memory, we need to
repack the vector of redundant site recs, not just detect the
duplicates.  To allow this, extend __ddebug_add_module()s prototype by
adding:

   struct _ddebug_site *packed_sites - address of empty "stack"
   unsigned int *packed_base - index of Top-of-Stack

This allows dynamic_debug_init() to tell __ddebug_add_module() where
to push the unique site recs it finds while de-duplicating, and to
communicate the new TOS back for the next iteration.

Since we know we are shrinking data, we can overwrite _ddebug_sites[],
for both builtins, and loadable modules, via ddebug_add_module().

For ddebug_add_module(), which is called from kernel/module/main, the
2 args: reuse the module.sites vector, with a 0 offset.  This will
allow de-duplication of the local vector.

No de-duplication is done yet, so no use of the stack.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 506a7e2e59d6..1b57e43e9c31 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1341,7 +1341,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt,
  * and add it to the global list.
  */
 static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
-			       const char *modname)
+			       const char *modname, struct _ddebug_site *packed_sites,
+			       unsigned int *packed_base)
 {
 	struct ddebug_table *dt;
 	int i;
@@ -1390,7 +1391,8 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 
 int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
-	return __ddebug_add_module(di, 0, modname);
+	unsigned int packed_base = 0;
+	return __ddebug_add_module(di, 0, modname, di->sites, &packed_base);
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
@@ -1506,7 +1508,7 @@ static int __init dynamic_debug_init(void)
 {
 	struct _ddebug *iter, *iter_mod_start;
 	struct _ddebug_site *site, *site_mod_start;
-	int ret, i, mod_sites, mod_ct;
+	int ret, i, mod_sites, mod_ct, site_base;
 	const char *modname;
 	char *cmdline;
 
@@ -1550,7 +1552,8 @@ static int __init dynamic_debug_init(void)
 			di.num_descs = mod_sites;
 			di.descs = iter_mod_start;
 			di.sites = site_mod_start;
-			ret = __ddebug_add_module(&di, i - mod_sites, modname);
+			ret = __ddebug_add_module(&di, i - mod_sites, modname,
+						  __start___dyndbg_sites, &site_base);
 			if (ret)
 				goto out_err;
 
@@ -1563,11 +1566,13 @@ static int __init dynamic_debug_init(void)
 	di.num_descs = mod_sites;
 	di.descs = iter_mod_start;
 	di.sites = site_mod_start;
-	ret = __ddebug_add_module(&di, i - mod_sites, modname);
+	ret = __ddebug_add_module(&di, i - mod_sites, modname,
+				  __start___dyndbg_sites, &site_base);
 	if (ret)
 		goto out_err;
 
 	ddebug_init_success = 1;
+
 	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
 		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
 		 (int)((i * sizeof(struct _ddebug)) >> 10));
-- 
2.37.2

