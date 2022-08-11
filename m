Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4AC5905F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiHKRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiHKRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:36:10 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFE844FD
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v185so15159916ioe.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OD3thvJspbjKpd00bhtO6kDknAInrQ6Lun7qGbHZH1Q=;
        b=c/GYeQcyfv69PSJKLMN+mNwJLgIF82/e3GHJV5TCzt/e0/BTDgIoOPvpnv1QEJZ6EA
         ajkQhDiBlyR9PcqMO4/CgYDgNgeZkMKFudZ12/0ZOH+woJDdR+hqS5EbOiPHUwKmoX/2
         ZtytZI6bFnZP9zTXLYSXP7pb5FPPClx5JGJAjU5ruM9NVVp8+lofi0pp8ejqMX79Fw7P
         PaeUH48PJB+hTzt8N5SjWkz4BioCCDNuTY3BTy90LZbo2KtQrgafWWXZ30Vg4NGCPNfO
         KdgiXWg1R1SyR2IoN6Vk/B12kWncX3E8Z9VOiQzOce8SphUObp7o+3TDalb8hlSCTbDH
         fseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OD3thvJspbjKpd00bhtO6kDknAInrQ6Lun7qGbHZH1Q=;
        b=8LuAlNDuvQYisCY5A0pdlSsO0y1hPzesLxKB2Ys7PMVX0LFwOabyRE610DSPKg8nAz
         BRpd9VEuRlXeOcrnJM+DKHmblJsF5t4bT0m7+nMoW747+UEvHB3u3eYzOq4deCY2gU2S
         B2uyLYbyyvogTsPBg98C1PR8jaK6aBjacHJeLF6jR9payljBsDN0FeGjmd/jhjW3EQkw
         3q5Mdvqf2XaQ1BrUmbg03/Z6L6qEoSFJA1yQbxoqFuri9uCHoMFtIQA0KgTMhSpx1Ki6
         PYfIWgFpqQW149PDEkZMlPEDNyJEqF+4F5AOhOsyBLaMjGXuorJMBcQiBzdX/yhVsdMa
         GHXg==
X-Gm-Message-State: ACgBeo2gJiLzpzONPOYSvo4pvOZ1dZSye3GBuF9VZGDdXxp5wTnNAQeA
        4ilX1y1jgE9WOEZTwsZscGP1eX5w09A=
X-Google-Smtp-Source: AA6agR4ELAAJgAsso0m3DmVnlEjvIYKTvu9w9JzjOreer4QYk48WOYW4E6ScJaUE+Wf/XwZEUT2nEw==
X-Received: by 2002:a6b:1d5:0:b0:682:6df8:afc0 with SMTP id 204-20020a6b01d5000000b006826df8afc0mr160451iob.76.1660239363700;
        Thu, 11 Aug 2022 10:36:03 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:36:03 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 10/11] dyndbg: cleanup auto vars in dynamic_debug_init
Date:   Thu, 11 Aug 2022 11:35:40 -0600
Message-Id: <20220811173541.2901122-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
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
2.37.1

