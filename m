Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0A4729F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhLMK23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbhLMK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:26:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E65C08EB3F;
        Mon, 13 Dec 2021 02:01:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q3so26022621wru.5;
        Mon, 13 Dec 2021 02:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9PqIToAjBgk14clYxLRRS2A0PQ+nML9zqgIg86sYx8=;
        b=ZdiqsrugQIz6eFUGLe60DhEwEcR21/aME5FdWdH8X3uROPwcLRY+W3M8Khs3NTbcQm
         kwqL0yv7ZViGmGs6QbrM+arTQGCXXP0d70vgp24o9ie0rStun9jE6SO2ZqUirdYMzUp0
         iK6m69Lw0D3ErWFfN0EvNP18vvLLBldpc4+YoprDomch+/M/c4RD2tCQnYRYsSQQRnom
         4AMpSQejMhFrpjiZcJYo8etF5354unywlBArpZBEmqp9NXZYmlqIDpy1dXeqLVUMGn5a
         CfS6L6G0KG1nLxsqRUGEHE3VvXGHtdlt8/w6mB9oQO8wDW8yarSP2JjAyi8S0/u6ZXJH
         rr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9PqIToAjBgk14clYxLRRS2A0PQ+nML9zqgIg86sYx8=;
        b=5xGI4Gh3tPzbtJZsCGXJvlQ0fmGSttTWQrgLK57rFl/Q43E+YviAfKeTv1uRV6Mqft
         rc2gq6t3Xvhiw1WNtUPJuTHQAJ5NWTWcZxZ6/AQlMOSLgQgxTuQDzJolm7uHt989+r9h
         7UczLqr0d9+Wac2VL5Fo2RYiRhYlWl4Sh/2Udr0/gL3FulFNhIjw9vMROscpjXXPxAlr
         uK5gYEn67b8ZZwXdQeKPLkhAJ1Bs9aHqg7iwXVZChoXbx3WsicNNa1poBnJLitrAB2GR
         VCJHQJGGgtpseh1mQnCUEuCimuhR3ssAHNLpaXcuKt3elKLFp8o7CaOsOAmKGGCdUpH7
         XFZw==
X-Gm-Message-State: AOAM53267KsNKOiucuLeQgLfqXXl4Oi3jKEvZ2GaYloUA15HwhsuGdtj
        cqf6qrc6m2MW/Fof3TUL+Zo=
X-Google-Smtp-Source: ABdhPJzBACNC9hXGBSdzgJSVqIFLyDoE8W+NZyYoA4+Tj6Y3PdjAmufpXBqXeXF4QUffNgMqb7fCJg==
X-Received: by 2002:a05:6000:1085:: with SMTP id y5mr15991168wrw.653.1639389658590;
        Mon, 13 Dec 2021 02:00:58 -0800 (PST)
Received: from localhost.localdomain ([2a00:a040:197:458f:acc5:ce9c:f048:f197])
        by smtp.googlemail.com with ESMTPSA id s8sm11826590wra.9.2021.12.13.02.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:00:58 -0800 (PST)
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ariel Marcovitch <arielmarcovitch@gmail.com>
Subject: [PATCH 1/2] kconfig: Show menuconfigs as menus in the .config file
Date:   Mon, 13 Dec 2021 12:00:42 +0200
Message-Id: <20211213100043.45645-2-arielmarcovitch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213100043.45645-1-arielmarcovitch@gmail.com>
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, menuconfigs were considered configs because they had non-zero
sym attribute. This meant that instead of having the nice menu comment
block in the .config output file, they were merely shown as single
configs.

For example:
```Kconfig
menu "Foo"
endmenu

menuconfig BAR
	bool "Bar"

config OTHER
	bool "Other"
	depends on BAR
```

Will be shown as:
```.config
 #
 # Foo
 #
 # end of Foo

 CONFIG_BAR=y
 CONFIG_OTHER=y
```

Instead of using the sym attribute to decide whether or not to print the
menu block comment, check menu->prompt->type explicitly (after checking
that menu_is_visible(menu) which means menu->prompt is not none). The
only prompt types we actually show as menus are P_MENU and P_COMMENT. At
the end of the menu we need to show the end of block only for P_MENU
(although P_COMMENT prompts will not get to this flow because they don't
have children).

Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
---
 scripts/kconfig/confdata.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 42bc56ee238c..9f2c22f46ee0 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -874,16 +874,21 @@ int conf_write(const char *name)
 	menu = rootmenu.list;
 	while (menu) {
 		sym = menu->sym;
-		if (!sym) {
-			if (!menu_is_visible(menu))
-				goto next;
-			str = menu_get_prompt(menu);
-			fprintf(out, "\n"
-				     "#\n"
-				     "# %s\n"
-				     "#\n", str);
-			need_newline = false;
-		} else if (!(sym->flags & SYMBOL_CHOICE) &&
+
+		if (menu_is_visible(menu)) {
+			enum prop_type type = menu->prompt->type;
+
+			if (type == P_MENU || type == P_COMMENT) {
+				str = menu_get_prompt(menu);
+				fprintf(out, "\n"
+					"#\n"
+					"# %s\n"
+					"#\n", str);
+				need_newline = false;
+			}
+		}
+
+		if (sym && !(sym->flags & SYMBOL_CHOICE) &&
 			   !(sym->flags & SYMBOL_WRITTEN)) {
 			sym_calc_value(sym);
 			if (!(sym->flags & SYMBOL_WRITE))
@@ -904,7 +909,8 @@ int conf_write(const char *name)
 		if (menu->next)
 			menu = menu->next;
 		else while ((menu = menu->parent)) {
-			if (!menu->sym && menu_is_visible(menu) &&
+			if (menu_is_visible(menu) &&
+			    menu->prompt->type == P_MENU &&
 			    menu != &rootmenu) {
 				str = menu_get_prompt(menu);
 				fprintf(out, "# end of %s\n", str);
-- 
2.25.1

