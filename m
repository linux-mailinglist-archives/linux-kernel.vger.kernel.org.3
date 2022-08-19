Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF05995BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346853AbiHSG6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbiHSG6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:58:34 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D02764F;
        Thu, 18 Aug 2022 23:58:31 -0700 (PDT)
Received: from grover.sesame ([133.106.49.178]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 27J6uUCO012757;
        Fri, 19 Aug 2022 15:56:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 27J6uUCO012757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660892195;
        bh=FLXSTnFwujGa3rCeIE2bMjhYjFgNU8XCFwv3G9iMhZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8Bd90crOnL14/xeeuc1U1N2lGENAclPMqXwT2iEYn7EVgcdQCPnLberVdMw3uYtz
         wHeBNo5JuYXDwGHar0S/TIAUXtyi88Zofef0rn0wgpfahb55KVADojoTNCCzxpg2e3
         x0tPJ/Z282CjRLpxl1xCGIA4T4e8WXbGHSDqlXfu9DfNnK4Jbz+J4xtb8BzudBuro3
         Wyz2ywK/+bug/Io/SLCrkiBZVbKxDF45Gcd7NY3sCtowfDv1NPk7DbaLjdW35dwBKr
         Stv7K3JOx9hA8g1Ho8BsaQrfKWXFIYfRZfLtBmtTzdnC11aGT6tolMrRMbNHHe+7i7
         oyDEVjrPjywKw==
X-Nifty-SrcIP: [133.106.49.178]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] kconfig: allow to choose the shell for $(shell ) functions
Date:   Fri, 19 Aug 2022 15:56:02 +0900
Message-Id: <20220819065604.295572-3-masahiroy@kernel.org>
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

GNU Make uses /bin/sh by default for running recipe lines and $(shell )
functions. You can change the shell by setting the 'SHELL' variable.
Unlike most variables, 'SHELL' is never set from the environment. [1]

Currently, Kconfig does not provide any way to change the default shell.
/bin/sh is always used for running $(shell,...) because do_shell() is
implemented by using popen(3).

This commit allows users to change the shell for Kconfig in a similar
way to GNU Make; you can set the 'SHELL' variable in a Kconfig file to
override the default shell. It is not taken from the environment. The
change is effective only for $(shell,...) invocations called after the
'SHELL' assignment.

[1]: https://www.gnu.org/software/make/manual/html_node/Choosing-the-Shell.html

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .../kbuild/kconfig-macro-language.rst         |  4 ++
 scripts/kconfig/internal.h                    |  1 +
 scripts/kconfig/parser.y                      |  1 +
 scripts/kconfig/preprocess.c                  | 65 +++++++++++++++----
 4 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/Documentation/kbuild/kconfig-macro-language.rst b/Documentation/kbuild/kconfig-macro-language.rst
index 6163467f6ae4..fe8c6982179e 100644
--- a/Documentation/kbuild/kconfig-macro-language.rst
+++ b/Documentation/kbuild/kconfig-macro-language.rst
@@ -112,6 +112,10 @@ Kconfig currently supports the following built-in functions.
   replaced with a space. Any trailing newlines are deleted. The standard error
   is not returned, nor is any program exit status.
 
+  The program used as the shell is taken from the variable SHELL. If it is not
+  set anywhere in your Kconfig file, /bin/sh is used as the shell.
+  Unlike most variables, the variable SHELL is never set from the environment.
+
  - $(info,text)
 
   The "info" function takes a single argument and prints it to stdout.
diff --git a/scripts/kconfig/internal.h b/scripts/kconfig/internal.h
index 8e0e6d315b6c..c18017650e54 100644
--- a/scripts/kconfig/internal.h
+++ b/scripts/kconfig/internal.h
@@ -19,6 +19,7 @@ enum variable_flavor {
 void env_write_dep(FILE *f, const char *auto_conf_name);
 void variable_add(const char *name, const char *value,
 		  enum variable_flavor flavor);
+void variable_init(void);
 void variable_all_del(void);
 char *expand_dollar(const char **str);
 char *expand_one_token(const char **str);
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 2af7ce4e1531..436afaef9228 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -483,6 +483,7 @@ void conf_parse(const char *name)
 	zconf_initscan(name);
 
 	_menu_init();
+	variable_init();
 
 	if (getenv("ZCONF_DEBUG"))
 		yydebug = 1;
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index aeb3fe362c04..608a84e7f5d6 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 
 #include "list.h"
 #include "lkc.h"
@@ -141,24 +142,59 @@ static char *do_lineno(int argc, char *argv[])
 
 static char *do_shell(int argc, char *argv[])
 {
-	FILE *p;
+	int pipefd[2];
+	pid_t pid;
 	char buf[4096];
-	char *cmd;
-	size_t nread;
+	ssize_t nread;
 	int i;
 
-	cmd = argv[0];
-
-	p = popen(cmd, "r");
-	if (!p) {
-		perror(cmd);
+	if (pipe(pipefd) < 0) {
+		perror("pipe");
+		exit(1);
+	}
+	pid = fork();
+	if (pid < -1) {
+		perror("fork");
 		exit(1);
 	}
 
-	nread = fread(buf, 1, sizeof(buf), p);
+	if (pid == 0) { /* child */
+		char *shell;
+
+		/* duplicate the write end to stdout */
+		if (dup2(pipefd[1], STDOUT_FILENO) < 0) {
+			perror("dup2");
+			_exit(1);
+		}
+
+		/*
+		 * Do not leak file descriptors to the child process
+		 * (including the read end of the pipe).
+		 * Closing up to 15 is enough for us?
+		 */
+		for (i = STDERR_FILENO + 1; i < 16; i++)
+			close(i);
+
+		shell = expand_string("$(SHELL)");
+
+		execl(shell, shell, "-c", argv[0], NULL);
+		perror("execl");
+
+		free(shell);
+
+		_exit(1);
+	}
+
+	/* parent */
+
+	close(pipefd[1]);	/* the write end is unneeded */
+
+	nread = read(pipefd[0], buf, sizeof(buf));
 	if (nread == sizeof(buf))
 		nread--;
 
+	close(pipefd[0]);	/* now close the read end */
+
 	/* remove trailing new lines */
 	while (nread > 0 && buf[nread - 1] == '\n')
 		nread--;
@@ -171,11 +207,6 @@ static char *do_shell(int argc, char *argv[])
 			buf[i] = ' ';
 	}
 
-	if (pclose(p) == -1) {
-		perror(cmd);
-		exit(1);
-	}
-
 	return xstrdup(buf);
 }
 
@@ -330,6 +361,12 @@ static void variable_del(struct variable *v)
 	free(v);
 }
 
+void variable_init(void)
+{
+	/* Set the default shell */
+	variable_add("SHELL", "/bin/sh", VAR_RECURSIVE);
+}
+
 void variable_all_del(void)
 {
 	struct variable *v, *tmp;
-- 
2.34.1

