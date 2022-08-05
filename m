Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9116D58B18B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbiHEVzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbiHEVym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:42 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41E13F25;
        Fri,  5 Aug 2022 14:54:32 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id g14so1967673ile.11;
        Fri, 05 Aug 2022 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EnuR+keQjXA7ZwTiZJLhSmBlKaThlIrTj1y/b6sKDaY=;
        b=WV0zPfyg/e+rsqNwIWECvFc+AIdD4kBWBYrI3REAb15JmdHrO7Z4sZ+8Y98wIfVcNp
         6H4OUpTUflLeUpZqHc0qKyj0AuCamG+jV3B+T0/IcTG3KqfFKlTp7WK+FQaO1fOBKa+p
         fB+CyTyxfUEXySNwKwJ5RqkFU6dIOyNkirVrBk4EqcO2wEZBH8yvNpU0DCVkDsEZeH11
         BilrfS+JrpJV2XJlPcXEcafAT4MH4qkjF6J/6NuQxClOqon/i4Y6Sr4CHnI59ALSTq2u
         Zip4eCTxKfWCTC9KjWBePNFD9XrebuEVPMvsv6WMddjhuXe+NxkM0z/jJMAuoVnkY4Bg
         OBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EnuR+keQjXA7ZwTiZJLhSmBlKaThlIrTj1y/b6sKDaY=;
        b=rNLsia3cC7uVQ3apmU7bsymJoBS57aAAg3IA1VuL11UWDFBDPcof3opzDSbLW296gC
         IZEVao2jwotZQxGP9tnI8H3pyHlMjOv0afuXfdzlWT97ARxHM/FZ0N30yuqSzqmiK1E/
         ADmwYPUChCfRksEXBsaVuh3pPPqPALM26Hnq1ZAZ6s6SNEkQoeriyVTF6I1uImPO3ebv
         giUDzGMl/JUf6yuDcfUEKKM+tYG+P8lDekLxkS1PHT3ePe0QRiVs3QDjGDayLryT2JO+
         O6e6wNtFxxo28s+DlM6b2CzQjSkxtRH+ImNAvNo+gJ6PLeGd6v6hBG9SMRvFVpx427Qq
         0mhw==
X-Gm-Message-State: ACgBeo3v2GI/XBUD012VxE8H8wYxX2H9hv55h77Oq78UZLVOZFNNYNXU
        nZMOOvyluWZLC9AIXGBDfCtNFzzWSYKBQg==
X-Google-Smtp-Source: AA6agR7RQl6/i8GZ2VkpSGkaEeOT5qr6Gt8uEvpPBs6KmrImmuonAI1Jpb/Qf/zJbkDoHLbSiMTXzA==
X-Received: by 2002:a05:6e02:1a07:b0:2de:9742:a426 with SMTP id s7-20020a056e021a0700b002de9742a426mr4136925ild.274.1659736471616;
        Fri, 05 Aug 2022 14:54:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:31 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 10/33] dyndbg: cleanup local vars in ddebug_init
Date:   Fri,  5 Aug 2022 15:53:32 -0600
Message-Id: <20220805215355.3509287-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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
    this allows 'demotion' of iter->site (for removal later)

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
2.37.1

