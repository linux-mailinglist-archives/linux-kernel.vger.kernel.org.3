Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4BB5AC7C2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiIDVqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiIDVoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:25 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729982F01E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:54 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r7so3867495ile.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2DUNNF4TyZPmUhIDyquoFTYgxu+2+I569ry9sz7h+V8=;
        b=mQmCZeXOpRyxBBvjbWVrCXsXx7gHTM8N/UQTvxQw6KuXSPexo1h3FD1ucxeyNJT+xH
         FCrl38VbY4XTggjAdID94f6qwWEzanDmr/mM2z9ppbD2bi++cdR0KFPdSDwIzMEdviuE
         T7rb8LW++Dfbale5om0KJkTeWydx42PLJzEbIaIRUShArRNRdH3N5bm567jsKFUoVvyE
         yNkTMgfq+82gXrYwwjc07JfVO8XbjrtDoDwJo5YA9vGk40vjd+duz80CzMwmFoM7NXkY
         5BL2wv2zhIlR6b9Vj7PAu5z7gJVid5GmJmcNvK4vsfDXHVxr7IqKWTFLJl2NVdYInAfp
         DlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2DUNNF4TyZPmUhIDyquoFTYgxu+2+I569ry9sz7h+V8=;
        b=kDEQrpzPoAggHxQfaOLEpucylxTdXNDPgTNZWq5trsghEtp4yPCfSCXrMColDJLANp
         ZS5x/oeSsSjhk1TyaO2rWC4q1w85dypgjMkw1yO83cwjUsUZeTj8SJdPJHuudP1PucQF
         fCk1E/IY52S86nHtXqb4ml6os0M2wYpzguRC5TqageUnCKyMgVxjNYGkApSR4nnuIyPI
         1LQHdM50G3ejgJvf8pJRU4YzyK4Ccikv42tdEE7Wv7oKkkYI6k2Ornwyu8g1FHSJwW4O
         v+9k28kJUEqJnCDLEEqmJqHs2+Z0VwruykeYjG/6k+p9ls9i2OzF6//0eK6SkwnQnK50
         R6/Q==
X-Gm-Message-State: ACgBeo1TXAXlUIeQi/B3brcuMb/d6LpmaU2ptbVVoNR/P68yq8B3av6j
        waY0ml4LntRligUQBV00TX8=
X-Google-Smtp-Source: AA6agR7R7ppBFr3r3vC4WEGb4c102hUehmHvwf5LRPNlvppZUrjQH2NK84HPqLyTxmmaZ5tAXemtqA==
X-Received: by 2002:a05:6e02:b2d:b0:2ec:b5eb:cd63 with SMTP id e13-20020a056e020b2d00b002ecb5ebcd63mr9305275ilu.291.1662327773546;
        Sun, 04 Sep 2022 14:42:53 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:53 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 45/57] dyndbg: de-duplicate sites
Date:   Sun,  4 Sep 2022 15:41:22 -0600
Message-Id: <20220904214134.408619-46-jim.cromie@gmail.com>
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

In __ddebug_add_module(), detect repeated site records (by function
name changes), and push changes onto the stack/vector passed in
from dynamic_debug_init().

For ddebug_add_module(), this transparently de-duplicates the local
sites vector (passed in recently added stack-base, and offset 0).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1b57e43e9c31..41c23ec979f4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1347,7 +1347,7 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	struct ddebug_table *dt;
 	int i;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
+	v3pr_info("add-module: %s.%d sites, start: %d\n", modname, di->num_descs, base);
 	if (!di->num_descs) {
 		v3pr_info(" skip %s\n", modname);
 		return 0;
@@ -1376,11 +1376,19 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
 
 	for (i = 0; i < di->num_descs; i++) {
-		di->descs[i]._index = base + i;
-		v3pr_info(" %d %d %s.%s.%d\n", i, base, modname,
-			  di->descs[i].site->_function, di->descs[i].lineno);
-	}
 
+		if (di->descs[i].site->_function != packed_sites[(*packed_base)]._function)
+			memcpy((void *) &packed_sites[++(*packed_base)],
+			       (void *) di->descs[i].site, sizeof(struct _ddebug_site));
+		else
+			di->descs[i].site = &packed_sites[(*packed_base)];
+
+		di->descs[i]._index = i + base;
+		di->descs[i]._map = *packed_base;
+
+		v3pr_info(" %d %d %s.%s.%d - %d\n", i, *packed_base, modname,
+			  di->descs[i].site->_function, di->descs[i].lineno, *packed_base);
+	}
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1539,7 +1547,7 @@ static int __init dynamic_debug_init(void)
 	iter = iter_mod_start = __start___dyndbg;
 	site = site_mod_start = __start___dyndbg_sites;
 	modname = iter->site->_modname;
-	i = mod_sites = mod_ct = 0;
+	i = mod_sites = mod_ct = site_base = 0;
 
 	for (; iter < __stop___dyndbg; iter++, site++, i++, mod_sites++) {
 
-- 
2.37.2

