Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785BA5AC6BE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiIDVm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiIDVmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:19 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959E2DA8E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:15 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d68so5628781iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=86ewCwjQW9i1kYjMVzcHXeBvyH4rTaXf6X7Uwlu5n+M=;
        b=GXl1s6xju+1eOoRqJRl5q8cmU4AqdZG79xuy+4LJGCEiw/Hpm6hcED/kqRFHo3q+gu
         qamuPL9FDFXp54vbLn1D/b404KlO7XolhPIJPAhLWpnmuPX+sSGTlZLE8h+zZqYnQIrO
         WQv5lca1ZofQjJIzLmrQTtiUPEYKCY216cU1ZnpHg+6ZUjNnIOjcVxlqwiL58RevVO8D
         pGUHsa6tvLQW+hC5jGjp1KE581rAtx4OqvJE4X3qwKJoz1fNkj+HyJpZ/66sdZUCD24D
         Mz7y6TAL9Xr3pr/ZW5qptrtm61mPi57w9KyBOC6mMX4UYP+bimaAR2CSopw3oHJTZyoA
         VPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=86ewCwjQW9i1kYjMVzcHXeBvyH4rTaXf6X7Uwlu5n+M=;
        b=XQTvhvS7H9ws2H9jYj98Jno0xHiuk4sqZ9B4h4wLgZ6jwkyCRepktvE2XIZyJ3pSCW
         PSIBIyLdBpls0RvohvHPoPs9MBivOWG0yLBpyN2ZNfNq+ihIcaK6P4KzkGci9xei00iX
         hXCLA3doOsxPaa31cPjjKDOjilDzTG/xdZww8L1+6TRb0OgI54KHsFaEgG0ORgGgK2mP
         Eku9YN00LpACi+5sxT/zcx3sIU373gwdk3C7+kAuhk3mX4r/x7XWQ7VnLoz6bvBjha+N
         C3U0TlGFf8QDr3AHw4j+nVLWp61TTwNAno62nQefhtm2arBIobnwICQuQbVQCRmrvCOt
         0CcQ==
X-Gm-Message-State: ACgBeo3B8WNoC5QSMbflp+laoDMrDN9B/FnFS9iE2+E+cRzAI0QbN4H2
        5EuSZgfMYJsBLSgwEgJcvww=
X-Google-Smtp-Source: AA6agR6667/lK+w05CI7BYagBtCSm/gCmvjQy5HHxRwHWCtcxf7YniB8McshMO9sqao4Jd/ymXysNA==
X-Received: by 2002:a05:6638:1607:b0:34a:105c:7204 with SMTP id x7-20020a056638160700b0034a105c7204mr24730394jas.216.1662327734786;
        Sun, 04 Sep 2022 14:42:14 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:14 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 05/57] dyndbg: reverse module.callsite walk in cat control
Date:   Sun,  4 Sep 2022 15:40:42 -0600
Message-Id: <20220904214134.408619-6-jim.cromie@gmail.com>
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

Walk the module's vector of callsites backwards; ie N..0.  This
"corrects" the backwards appearance of a module's prdbg vector when
walked 0..N.  I think this is due to linker mechanics, which I'm
inclined to treat as immutable, and the order is fixable in display.

No functional changes.

Combined with previous commit, which reversed tables-list, we get:

  :#> head -n7 /proc/dynamic_debug/control
  # filename:lineno [module]function flags format
  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\012"
  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\012"
  init/main.c:1424 [main]run_init_process =_ "  with arguments:\012"
  init/main.c:1426 [main]run_init_process =_ "    %s\012"
  init/main.c:1427 [main]run_init_process =_ "  with environment:\012"
  init/main.c:1429 [main]run_init_process =_ "    %s\012"

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 7fb99492c16f..8ff11977b8bd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -59,7 +59,7 @@ struct ddebug_query {
 
 struct ddebug_iter {
 	struct ddebug_table *table;
-	unsigned int idx;
+	int idx;
 };
 
 struct flag_settings {
@@ -805,13 +805,12 @@ static struct _ddebug *ddebug_iter_first(struct ddebug_iter *iter)
 {
 	if (list_empty(&ddebug_tables)) {
 		iter->table = NULL;
-		iter->idx = 0;
 		return NULL;
 	}
 	iter->table = list_entry(ddebug_tables.next,
 				 struct ddebug_table, link);
-	iter->idx = 0;
-	return &iter->table->ddebugs[iter->idx];
+	iter->idx = iter->table->num_ddebugs;
+	return &iter->table->ddebugs[--iter->idx];
 }
 
 /*
@@ -824,15 +823,16 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
 {
 	if (iter->table == NULL)
 		return NULL;
-	if (++iter->idx == iter->table->num_ddebugs) {
+	if (--iter->idx < 0) {
 		/* iterate to next table */
-		iter->idx = 0;
 		if (list_is_last(&iter->table->link, &ddebug_tables)) {
 			iter->table = NULL;
 			return NULL;
 		}
 		iter->table = list_entry(iter->table->link.next,
 					 struct ddebug_table, link);
+		iter->idx = iter->table->num_ddebugs;
+		--iter->idx;
 	}
 	return &iter->table->ddebugs[iter->idx];
 }
-- 
2.37.2

