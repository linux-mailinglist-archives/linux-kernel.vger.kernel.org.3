Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638935AC7C3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiIDVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbiIDVpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:45:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525A3056B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b142so5642581iof.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0iGLn9xqCpcC4gcXCQSb7q1CfO8AItXp+UrSrC23ofg=;
        b=c4Kq7xloZvvHFQ9epBPNdcfT88slUONFGhsZx5MMGEMETHKqfUD9s2gzih6ALSi3wD
         RrSDXPBRasBgiwo4/u96iVTFZBqUgPsrGJ215FEXB49z7jnLyWi457WMuaGNd/EON1XH
         GyjBZNFnOS45dRu6gLJPWVkFsKVueCkOjPTRK+IINcSb2jbyp3YwEPuMkYNSzl/rirQM
         d5EwuNynlS8h4OY8pAJTaF7QeWBKZcUVuMJzzAnk0maYPeDvxCRYSxmx7XIOTzxGp1yV
         PLaexfCoB2wQoSDMH+kN17KC+TwYCpQd6YSNc7LXPW74NfB8khKnhZvXekFB8EQPRMeQ
         pFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0iGLn9xqCpcC4gcXCQSb7q1CfO8AItXp+UrSrC23ofg=;
        b=JpYUBZRUMdd4BztQ7N/0XRDInqLHaIrNoFtJ3UHdvqAdSxaSr6sO9j7WTz3YeXL+72
         hN0SuVGC5R93c5UGg4UffFEQ5nwX+VCrMFpPMDZ0Vxu8cLPUITnPimeW7KIhs377pGI1
         okByBvZcAuNhu5fzK081A6aRxDfbW4cQxsuTf8rP/OAYvm3g198g3ioZrw6G/eILehxK
         x3oX1i7Hzee/r7NIGR/JA3lUFZqRU2z1etijx8NS/Y0dM7YP2bBEYJ8BG4kWWE+eT7CX
         cjHAgSbKTo/nWTHrXxGJQlgOAUfpu3rejs8fiI5uqjSLIL/HotD0YSl0mGXpiMhjfceZ
         MS4Q==
X-Gm-Message-State: ACgBeo0pvWakI2eycTfZ4oDKeWFUfc8yYFtw6alQ05RhaVj8xv0QdY9Y
        aZusjuX5QZu1gsKGuWbI2PHpo/ZmUsU=
X-Google-Smtp-Source: AA6agR5hVc9DnYKL0ZIAQuzKxXKG0S5DufyPzrHmQJwD8MfDjPFuhObXx/a4iT1L7ykoRUbvzDY2Pw==
X-Received: by 2002:a05:6638:1350:b0:349:f94d:5ea7 with SMTP id u16-20020a056638135000b00349f94d5ea7mr24681226jad.129.1662327777931;
        Sun, 04 Sep 2022 14:42:57 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:57 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 50/57] dyndbg: count unique callsites
Date:   Sun,  4 Sep 2022 15:41:27 -0600
Message-Id: <20220904214134.408619-51-jim.cromie@gmail.com>
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

Count de-duplicated callsites.  Since the _ddebug_site excludes
lineno, all callsites in a function are identical, and this
effectively counts functions in the module with callsites.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 91fe7fb5dda9..891d70d7fed4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1348,7 +1348,7 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 			       unsigned int *packed_base)
 {
 	struct ddebug_table *dt;
-	int i;
+	int i, num_funcs = 0;
 
 	v3pr_info("add-module: %s %d/%d sites, start: %d\n", modname, di->num_descs, di->num_sites, base);
 	if (!di->num_descs) {
@@ -1381,12 +1381,11 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	//BUG_ON(di->num_descs != di->num_sites);
 
 	for (i = 0; i < di->num_descs; i++) {
-
-		if (di->sites[i]._function != packed_sites[(*packed_base)]._function)
-
+		if (di->sites[i]._function != packed_sites[(*packed_base)]._function) {
+			num_funcs++;
 			memcpy((void *) &packed_sites[++(*packed_base)],
 			       (void *) &di->sites[i], sizeof(struct _ddebug_site));
-
+		}
 		di->descs[i]._index = i + base;
 		di->descs[i]._map = *packed_base;
 
@@ -1397,7 +1396,7 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->num_descs, modname);
+	vpr_info("%3u debug prints in %d functions, in module %s\n", di->num_descs, num_funcs, modname);
 	return 0;
 }
 
-- 
2.37.2

