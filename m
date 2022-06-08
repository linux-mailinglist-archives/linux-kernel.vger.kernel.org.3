Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F02542CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiFHKLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiFHKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:10:25 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3060D1F4FC2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:55:14 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-189-245.tukw.qwest.net [174.21.189.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 49F51516;
        Wed,  8 Jun 2022 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1654682114;
        bh=K00ITh9PLAuc6uSQaSvaQXWcKqLm2Zi5hLcCQu5/Dg8=;
        h=From:To:Cc:Subject:Date:From;
        b=WXpvEE7dTqersteTvIhJl+dZUqW4Bmk23WuPCqjq/oiHNcATCkrt/HUENuo1ClYCQ
         hel/csTCLAJBo8vk2Rj6Pi4u2L6aiscaOS3vJnY0dHxY/YTr8uU2yj1VjKHR3MMvbw
         vasMtjRyIxHWLZ1dQ762QUx/WwWyxbcDEifBBTYE=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: Add findconf script and helper program
Date:   Wed,  8 Jun 2022 02:54:56 -0700
Message-Id: <20220608095456.27479-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/findconf provides menuconfig's search functionality as a
standalone, non-interactive command, somewhat in the spirit of
scripts/config.  It is meant to be useful for tasks like getting a
quick overview of symbol dependencies or determining which Kconfig
file to edit for a given symbol, without having to fire up one of the
interactive config programs.

It accepts a single command-line flag, '-v', which causes it to also
print the help text of each matching result.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

This works a bit differently from [gmnq]conf in that it accepts (and
requires) arguments, but I couldn't see an easy/obvious way of passing
command-line args through the makefile infrastructure that invokes
those, so the wrapper script passes things to it via environment
variables instead.  Suggestions welcome if there's a nicer way of
achieving that.

 scripts/findconf           | 22 ++++++++++++
 scripts/kconfig/.gitignore |  1 +
 scripts/kconfig/Makefile   |  7 +++-
 scripts/kconfig/findconf.c | 74 ++++++++++++++++++++++++++++++++++++++
 scripts/kconfig/lkc.h      |  1 +
 scripts/kconfig/menu.c     |  2 +-
 6 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100755 scripts/findconf
 create mode 100644 scripts/kconfig/findconf.c

diff --git a/scripts/findconf b/scripts/findconf
new file mode 100755
index 000000000000..c59132548082
--- /dev/null
+++ b/scripts/findconf
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Find Kconfig symbols matching one or more regexen.  Pass '-v' to
+# also show help text.
+
+if [ "$1" = "-v" ]; then
+	export FINDCONF_SHOW_HELP=1
+	shift
+fi
+
+if [ $# = 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
+	echo >&$(($# ? 1 : 2)) "Usage: $(basename $0) [-v] REGEX [REGEX ...]"
+	exit $((!$#))
+fi
+
+n=0
+for q in "$@"; do
+	export FINDCONF_QUERY_$((n++))="$q"
+done
+
+exec make findconfig
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 500e7424b3ef..a3ea0600c731 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /conf
+/findconf
 /[gmnq]conf
 /[gmnq]conf-cfg
 /qconf-moc.cc
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index b8ef0fb4bbef..99e48b2d8563 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -35,6 +35,7 @@ menuconfig-prog	:= mconf
 nconfig-prog	:= nconf
 gconfig-prog	:= gconf
 xconfig-prog	:= qconf
+findconfig-prog	:= findconf
 
 define config_rule
 PHONY += $(1)
@@ -45,7 +46,7 @@ PHONY += build_$(1)
 build_$(1): $(obj)/$($(1)-prog)
 endef
 
-$(foreach c, config menuconfig nconfig gconfig xconfig, $(eval $(call config_rule,$(c))))
+$(foreach c, config menuconfig nconfig gconfig xconfig findconfig, $(eval $(call config_rule,$(c))))
 
 PHONY += localmodconfig localyesconfig
 localyesconfig localmodconfig: $(obj)/conf
@@ -155,6 +156,10 @@ HOSTCFLAGS_parser.tab.o	:= -I $(srctree)/$(src)
 hostprogs	+= conf
 conf-objs	:= conf.o $(common-objs)
 
+# findconf: standalone non-interactive config-symbol search
+hostprogs	+= findconf
+findconf-objs	:= findconf.o $(common-objs)
+
 # nconf: Used for the nconfig target based on ncurses
 hostprogs	+= nconf
 nconf-objs	:= nconf.o nconf.gui.o $(common-objs)
diff --git a/scripts/kconfig/findconf.c b/scripts/kconfig/findconf.c
new file mode 100644
index 000000000000..786408c97eab
--- /dev/null
+++ b/scripts/kconfig/findconf.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Zev Weiss <zev@bewilderbeest.net>
+ *
+ * Kconfig symbol search a la carte.
+ */
+#include "lkc.h"
+
+static bool query(const char *q)
+{
+	unsigned int i;
+	const char *help;
+	struct gstr res;
+	struct symbol **sym_arr, *sym;
+	struct property *prop;
+
+	sym_arr = sym_re_search(q);
+
+	if (!sym_arr) {
+		printf("%s: no matches found.\n", q);
+		return false;
+	}
+
+	for (i = 0; sym_arr[i]; i++) {
+		sym = sym_arr[i];
+		res = str_new();
+		get_symbol_str(&res, sym, NULL);
+		printf("%s", str_get(&res));
+		str_free(&res);
+
+		if (getenv("FINDCONF_SHOW_HELP")) {
+			for_all_properties(sym, prop, P_SYMBOL) {
+				if (prop->menu) {
+					help = menu_get_help(prop->menu);
+					if (help && *help)
+						printf("%s\n", help);
+				}
+			}
+		}
+	}
+
+	free(sym_arr);
+
+	return true;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned int i = 0;
+	char qvar[32];
+	bool found = false;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s KCONFIG\n", argv[0]);
+		exit(1);
+	}
+
+	conf_parse(argv[1]);
+	conf_read(NULL);
+
+	for (;;) {
+		snprintf(qvar, sizeof(qvar), "FINDCONF_QUERY_%u", i++);
+		if (!getenv(qvar))
+			break;
+		found = query(getenv(qvar)) || found;
+	}
+
+	if (i == 1) {
+		fprintf(stderr, "FINDCONF_QUERY_0 not set\n");
+		return 1;
+	}
+
+	return !found;
+}
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index fa8c010aa683..b4730f580dee 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -102,6 +102,7 @@ struct menu *menu_get_root_menu(struct menu *menu);
 struct menu *menu_get_parent_menu(struct menu *menu);
 bool menu_has_help(struct menu *menu);
 const char *menu_get_help(struct menu *menu);
+void get_symbol_str(struct gstr *r, struct symbol *sym, struct list_head *head);
 struct gstr get_relations_str(struct symbol **sym_arr, struct list_head *head);
 void menu_get_ext_help(struct menu *menu, struct gstr *help);
 
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 3d6f7cba8846..4b990c73e431 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -800,7 +800,7 @@ static void get_symbol_props_str(struct gstr *r, struct symbol *sym,
 /*
  * head is optional and may be NULL
  */
-static void get_symbol_str(struct gstr *r, struct symbol *sym,
+void get_symbol_str(struct gstr *r, struct symbol *sym,
 		    struct list_head *head)
 {
 	struct property *prop;
-- 
2.36.1

