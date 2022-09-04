Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CBE5AC7BD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiIDVqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiIDVor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:47 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38122FFEA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:55 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b17so3907090ilh.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H201e8MxjjTWEZ5tX/zGuFZYDJJzszurQVKd2l3pA3I=;
        b=D5hVd8nWFbqRRkXkdpXZg4jOmNIfneov3THSYEMdUbvWnNl8Ne1nblV6QviWBWEGUg
         2zMyuA7+zIirnNTNheDbR8jO4BMAl558jaE/EZxKR7+4koCB4I8+25Qe/kL8kQDF2Sho
         9kDP0guazA6Lb4dxbqmjP5mGHurmuwBcuEMnuT3go1J7kq5fY3n584tb1fc7uABf1zin
         bHRRoPHY51s4kfci15ECF8xV6cBQQdgXuN4xECAP+d7JlGSq0KHUrs/nvlXcdLRTejSg
         qoOn5DPm1HXTaLGGK4GTAQmXYSy4e+uxehju05I6ClOoAcojZ1q7+CbFrz/rCbP0Qb06
         zY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H201e8MxjjTWEZ5tX/zGuFZYDJJzszurQVKd2l3pA3I=;
        b=sLoCRiJ7cNIV8/AmeXVHmR2lt21+mRtkNBAN9WQiuRuZEKcHPWq+pqJJS4bHUNxmQ1
         YhXZ8U0x2PTC5wIzkwo4nrKW/JslaIJEju/SabqmMPb+QQnq8/qgB2Oaj1lsB2D/3SMF
         oEBRALux4M5YYTSOKQBluRDnG3RyTFmCF2zF1lPzWthHIoW1OAZoji9ItWvuzof3/1hP
         GUVibBctKr7Dms5yLYFDnynxdWHz/VLVe0zsrpRFxQlUHwULEtxE7D/Si9Iy2C5HmCl4
         UB5HaW/wDzp/rbsrPo1N+Ft5MusItWx3vfJbVgYk4feyc23lJ8JpFZL4RgcgsZqgHLRL
         a2Tw==
X-Gm-Message-State: ACgBeo2ocjUdluGoqpqcKEv3E/frSD6fR6/UrQ6B6InO5zGqP18sgIzD
        0aNHgoObssUtuCbgd8Do9CM=
X-Google-Smtp-Source: AA6agR6fMqZIkP1YOEGKlykQp2j5uHw/5o/cVx4vJBZLBlUDQYIi3bLhanGx4QpvBqJmpIkwB4O4Nw==
X-Received: by 2002:a05:6e02:19ca:b0:2df:68c:4a6d with SMTP id r10-20020a056e0219ca00b002df068c4a6dmr24133939ill.32.1662327774363;
        Sun, 04 Sep 2022 14:42:54 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 46/57] dyndbg: drop site-> in add-module, more needed
Date:   Sun,  4 Sep 2022 15:41:23 -0600
Message-Id: <20220904214134.408619-47-jim.cromie@gmail.com>
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

---
 lib/dynamic_debug.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 41c23ec979f4..059212df68f9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1347,7 +1347,7 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	struct ddebug_table *dt;
 	int i;
 
-	v3pr_info("add-module: %s.%d sites, start: %d\n", modname, di->num_descs, base);
+	v3pr_info("add-module: %s %d/%d sites, start: %d\n", modname, di->num_descs, di->num_sites, base);
 	if (!di->num_descs) {
 		v3pr_info(" skip %s\n", modname);
 		return 0;
@@ -1375,19 +1375,20 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	if (di->classes && di->num_classes)
 		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
 
+	//BUG_ON(di->num_descs != di->num_sites);
+
 	for (i = 0; i < di->num_descs; i++) {
 
-		if (di->descs[i].site->_function != packed_sites[(*packed_base)]._function)
+		if (di->sites[i]._function != packed_sites[(*packed_base)]._function)
+
 			memcpy((void *) &packed_sites[++(*packed_base)],
-			       (void *) di->descs[i].site, sizeof(struct _ddebug_site));
-		else
-			di->descs[i].site = &packed_sites[(*packed_base)];
+			       (void *) &di->sites[i], sizeof(struct _ddebug_site));
 
 		di->descs[i]._index = i + base;
 		di->descs[i]._map = *packed_base;
 
-		v3pr_info(" %d %d %s.%s.%d - %d\n", i, *packed_base, modname,
-			  di->descs[i].site->_function, di->descs[i].lineno, *packed_base);
+		v3pr_info(" %d %d %s.%s.%d\n", i, *packed_base, modname,
+			  packed_sites[*packed_base]._function, di->descs[i].lineno);
 	}
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
-- 
2.37.2

