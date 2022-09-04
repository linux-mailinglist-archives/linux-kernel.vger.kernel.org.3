Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A05AC726
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiIDVmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiIDVmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496ED2C661
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:20 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 62so5673882iov.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JzdXJQgZbXW3FjxRfc8LeNnI2jIQsEPwZbCx/pElNeM=;
        b=FUv8NBMgLulwhhEoMyLnxfYB3+uPNeLFEo5/TLMiSZjR94roddKbiqTTG31unDiBV2
         koej5AIOTpgc4Fj75xhV1jWGKl/5CM8q7EieivOlV5/b+BYdXa9pALtMLQe6QZEuohs8
         uc4jHbPW01pKLaccj4L/SBD9SF3hrWMDpeLoGgRrvCEUQKX8JmTlITp0J8QvdPavHfqS
         KpCN89/psw628tV7ylJY71laqV2x/K4y1PPoettY5lY6Kg7pmI05/DzTkiDbBqcz1dnc
         NsgFPB4IEgajS8Toc7/PVXqE2pPIC6p3Ibe6XKVfl3deYBS708mMbxWmh4z8Z7N8CYIi
         UccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JzdXJQgZbXW3FjxRfc8LeNnI2jIQsEPwZbCx/pElNeM=;
        b=C8P8iZWZk81ggH+/BxLOLwSrHcaRIip+CUrdb3URVAi/1dHW8/2gBZ9erUMuRQWsWm
         vGeI60tGw9eegoPVOgIYXNbqo5S5GofQTR9Z1rf5MnH/VxkYa/NoTvlYl5Vcbc0BwjqB
         4Gzf8kTf1u2FoOPaoDZdzJeLTjp5gCWD39Yr+JgdoCyTygHAMZJIZtidaxs2Us0ouoCF
         Ia9LJJj3L6u0gSuuhq2823zYeQ0OKS4Ojs0j3mAUpeo3VPg1YupwDFsy/BBCY/+fIFz/
         X5BlEzmp7HYQFWbHnFoKaUibKg/zo8/4Mf1zFwVSX2ioSWVg27IOsMm88SruC5fDn9Od
         Cz+g==
X-Gm-Message-State: ACgBeo0FP7CzRsPccR2OPeYIRKgRa0NJZlOCU1Aadf4Notf32Qajbjve
        ZhL7ilCIrYbjl+gDByyCnfM=
X-Google-Smtp-Source: AA6agR69LwdoHmp66Z3rxXxBJJ0Vec0ZLNH/n+zC6VNVydFgIRnTRHkjqAX0L8kf28KEk70mHqw2jw==
X-Received: by 2002:a5e:8414:0:b0:689:e3c:308a with SMTP id h20-20020a5e8414000000b006890e3c308amr21338651ioj.29.1662327739611;
        Sun, 04 Sep 2022 14:42:19 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:19 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 10/57] dyndbg: cleanup auto vars in dynamic_debug_init
Date:   Sun,  4 Sep 2022 15:40:47 -0600
Message-Id: <20220904214134.408619-11-jim.cromie@gmail.com>
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

rework var-names for clarity, regularity
rename variables
  - n to mod_sites - it counts sites-per-module
  - entries to i - display only
  - iter_start to iter_mod_start - marks start of each module's subrange
  - modct to mod_ct - stylistic

new iterator var:
  - site - cursor parallel to iter
    1st step towards 'demotion' of iter->site, for removal later

treat vars as iters:
  - drop init at top
    init just above for-loop, in a textual block

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e96dc216463b..2e8ebef3bd0d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1059,11 +1059,10 @@ static int __init dynamic_debug_init_control(void)
 
 static int __init dynamic_debug_init(void)
 {
-	struct _ddebug *iter, *iter_start;
-	const char *modname = NULL;
+	struct _ddebug *iter, *iter_mod_start;
+	int ret, i, mod_sites, mod_ct;
+	const char *modname;
 	char *cmdline;
-	int ret = 0;
-	int n = 0, entries = 0, modct = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1074,30 +1073,32 @@ static int __init dynamic_debug_init(void)
 		ddebug_init_success = 1;
 		return 0;
 	}
-	iter = __start___dyndbg;
+
+	iter = iter_mod_start = __start___dyndbg;
 	modname = iter->modname;
-	iter_start = iter;
-	for (; iter < __stop___dyndbg; iter++) {
-		entries++;
+	i = mod_sites = mod_ct = 0;
+
+	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
+
 		if (strcmp(modname, iter->modname)) {
-			modct++;
-			ret = ddebug_add_module(iter_start, n, modname);
+			mod_ct++;
+			ret = ddebug_add_module(iter_mod_start, mod_sites, modname);
 			if (ret)
 				goto out_err;
-			n = 0;
+
+			mod_sites = 0;
 			modname = iter->modname;
-			iter_start = iter;
+			iter_mod_start = iter;
 		}
-		n++;
 	}
-	ret = ddebug_add_module(iter_start, n, modname);
+	ret = ddebug_add_module(iter_mod_start, mod_sites, modname);
 	if (ret)
 		goto out_err;
 
 	ddebug_init_success = 1;
 	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
-		 entries, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
-		 (int)((entries * sizeof(struct _ddebug)) >> 10));
+		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
+		 (int)((i * sizeof(struct _ddebug)) >> 10));
 
 	/* now that ddebug tables are loaded, process all boot args
 	 * again to find and activate queries given in dyndbg params.
-- 
2.37.2

