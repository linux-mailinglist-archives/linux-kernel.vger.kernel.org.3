Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003635995B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346816AbiHSG6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiHSG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:58:31 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7889BCA0;
        Thu, 18 Aug 2022 23:58:18 -0700 (PDT)
Received: from grover.sesame ([133.106.49.178]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 27J6uUCN012757;
        Fri, 19 Aug 2022 15:56:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 27J6uUCN012757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660892193;
        bh=NhUP1vLNnfADibxISBC03SpUDFkdK73SDeWcDjzouOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0VLiN8PgP35sOrGjFCY4rF6Rc+YWUhvi1vAihvjdYE567Wc/V0zQ+b6WKiUaQNis
         c+I3LeB1kckoWnfhLm4G/6u3Zr7eVkEaWSfUWkuYrPlr8vSbyeU/1ZL5YTR2ilBA1L
         it7QDST4MJzMDBDTPNtyqfj/ku/g1IndEkHOp6jB4tlEBzw1N3U4OwfPZe02ZJDn50
         EhuvibAmzpbiiEESaUYzvk8b37srF7UhfTYIN3gWyHPBzN8S9jAjPNeFA8gVoozSf8
         /+ZxQVQ+0/A2yNwMP6Pw45JXH9XN/kNmef45fnmxOI0p6kmyGQXNulBdmpi1l7VsiN
         a7OSaBVdvEVYg==
X-Nifty-SrcIP: [133.106.49.178]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] kconfig: move declarations for prepossessing to internal.h
Date:   Fri, 19 Aug 2022 15:56:01 +0900
Message-Id: <20220819065604.295572-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819065604.295572-1-masahiroy@kernel.org>
References: <20220819065604.295572-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used by the kconfig core part.

The user interface part (conf, mconf, nconf, gconf, or xconf variants)
does not need them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c   |  1 +
 scripts/kconfig/internal.h   | 17 +++++++++++++++++
 scripts/kconfig/lexer.l      |  1 +
 scripts/kconfig/lkc_proto.h  | 13 -------------
 scripts/kconfig/preprocess.c |  1 +
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index c4340c90e172..aa8e73828de3 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -19,6 +19,7 @@
 #include <unistd.h>
 
 #include "lkc.h"
+#include "internal.h"
 
 /* return true if 'path' exists, false otherwise */
 static bool is_present(const char *path)
diff --git a/scripts/kconfig/internal.h b/scripts/kconfig/internal.h
index 2f7298c21b64..8e0e6d315b6c 100644
--- a/scripts/kconfig/internal.h
+++ b/scripts/kconfig/internal.h
@@ -1,4 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Declarations necessary for the kconfig core, but not for
+ * conf, mconf, nconf, gconf, or xconf variants.
+ */
 #ifndef INTERNAL_H
 #define INTERNAL_H
 
@@ -6,4 +10,17 @@ struct menu;
 
 extern struct menu *current_menu, *current_entry;
 
+/* preprocess.c */
+enum variable_flavor {
+	VAR_SIMPLE,
+	VAR_RECURSIVE,
+	VAR_APPEND,
+};
+void env_write_dep(FILE *f, const char *auto_conf_name);
+void variable_add(const char *name, const char *value,
+		  enum variable_flavor flavor);
+void variable_all_del(void);
+char *expand_dollar(const char **str);
+char *expand_one_token(const char **str);
+
 #endif /* INTERNAL_H */
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index cc386e443683..43e12d0945a7 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -14,6 +14,7 @@
 #include <string.h>
 
 #include "lkc.h"
+#include "internal.h"
 #include "parser.tab.h"
 
 #define YY_DECL		static int yylex1(void)
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index edd1e617b25c..7fb4953d16ca 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -35,18 +35,5 @@ const char * sym_get_string_value(struct symbol *sym);
 
 const char * prop_get_type_name(enum prop_type type);
 
-/* preprocess.c */
-enum variable_flavor {
-	VAR_SIMPLE,
-	VAR_RECURSIVE,
-	VAR_APPEND,
-};
-void env_write_dep(FILE *f, const char *auto_conf_name);
-void variable_add(const char *name, const char *value,
-		  enum variable_flavor flavor);
-void variable_all_del(void);
-char *expand_dollar(const char **str);
-char *expand_one_token(const char **str);
-
 /* expr.c */
 void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 748da578b418..aeb3fe362c04 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -11,6 +11,7 @@
 
 #include "list.h"
 #include "lkc.h"
+#include "internal.h"
 
 #define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
 
-- 
2.34.1

