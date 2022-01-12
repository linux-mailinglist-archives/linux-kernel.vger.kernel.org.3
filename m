Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B3348CCC0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiALUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:02:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44034 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357195AbiALUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:00:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07C4EB820E5;
        Wed, 12 Jan 2022 20:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B223FC36AE5;
        Wed, 12 Jan 2022 20:00:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7jnN-003EN2-G0;
        Wed, 12 Jan 2022 15:00:33 -0500
Message-ID: <20220112200033.323596162@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jan 2022 14:58:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [for-next][PATCH 01/14] rtla: Real-Time Linux Analysis tool
References: <20220112195843.098894945@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

The rtla is a meta-tool that includes a set of commands that aims
to analyze the real-time properties of Linux. But instead of testing
Linux as a black box, rtla leverages kernel tracing capabilities to
provide precise information about the properties and root causes of
unexpected results.

rtla --help works and provide information about the available options.

This is just the "main" and the Makefile, no function yet.

Link: https://lkml.kernel.org/r/bf9118ed43a09e6c054c9a491cbe7411ad1acd89.1639158831.git.bristot@kernel.org

Cc: Tao Zhou <tao.zhou@linux.dev>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile   | 76 +++++++++++++++++++++++++++++++++++
 tools/tracing/rtla/README.txt | 36 +++++++++++++++++
 tools/tracing/rtla/src/rtla.c | 72 +++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 tools/tracing/rtla/Makefile
 create mode 100644 tools/tracing/rtla/README.txt
 create mode 100644 tools/tracing/rtla/src/rtla.c

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
new file mode 100644
index 000000000000..56b1bdd60c96
--- /dev/null
+++ b/tools/tracing/rtla/Makefile
@@ -0,0 +1,76 @@
+NAME	:=	rtla
+VERSION	:=	0.5
+
+# From libtracefs:
+# Makefiles suck: This macro sets a default value of $(2) for the
+# variable named by $(1), unless the variable has been set by
+# environment or command line. This is necessary for CC and AR
+# because make sets default values, so the simpler ?= approach
+# won't work as expected.
+define allow-override
+  $(if $(or $(findstring environment,$(origin $(1))),\
+            $(findstring command line,$(origin $(1)))),,\
+    $(eval $(1) = $(2)))
+endef
+
+# Allow setting CC and AR, or setting CROSS_COMPILE as a prefix.
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+$(call allow-override,AR,$(CROSS_COMPILE)ar)
+$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+$(call allow-override,PKG_CONFIG,pkg-config)
+$(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
+$(call allow-override,LDCONFIG,ldconfig)
+
+INSTALL	=	install
+FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
+		-fasynchronous-unwind-tables -fstack-clash-protection
+WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
+
+TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
+
+CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS)
+LDFLAGS	:=	-ggdb
+LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs) -lprocps
+
+SRC	:=	$(wildcard src/*.c)
+HDR	:=	$(wildcard src/*.h)
+OBJ	:=	$(SRC:.c=.o)
+DIRS	:=	src
+FILES	:=	Makefile README.txt
+CEXT	:=	bz2
+TARBALL	:=	$(NAME)-$(VERSION).tar.$(CEXT)
+TAROPTS	:=	-cvjf $(TARBALL)
+BINDIR	:=	/usr/bin
+DATADIR	:=	/usr/share
+DOCDIR	:=	$(DATADIR)/doc
+MANDIR	:=	$(DATADIR)/man
+LICDIR	:=	$(DATADIR)/licenses
+
+.PHONY:	all
+all:	rtla
+
+rtla: $(OBJ)
+	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
+
+static: $(OBJ)
+	$(CC) -o rtla-static $(LDFLAGS) --static $(OBJ) $(LIBS) -lpthread -ldl
+
+.PHONY: install
+install:
+	$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
+	$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
+	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
+
+.PHONY: clean tarball
+clean:
+	@test ! -f rtla || rm rtla
+	@test ! -f rtla-static || rm rtla-static
+	@test ! -f src/rtla.o || rm src/rtla.o
+	@test ! -f $(TARBALL) || rm -f $(TARBALL)
+	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
+
+tarball:  clean
+	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
+	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
+	tar $(TAROPTS) --exclude='*~' $(NAME)-$(VERSION)
+	rm -rf $(NAME)-$(VERSION)
diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
new file mode 100644
index 000000000000..6c88446f7e74
--- /dev/null
+++ b/tools/tracing/rtla/README.txt
@@ -0,0 +1,36 @@
+RTLA: Real-Time Linux Analysis tools
+
+The rtla is a meta-tool that includes a set of commands that
+aims to analyze the real-time properties of Linux. But, instead of
+testing Linux as a black box, rtla leverages kernel tracing
+capabilities to provide precise information about the properties
+and root causes of unexpected results.
+
+Installing RTLA
+
+RTLA depends on some libraries and tools. More precisely, it depends on the
+following libraries:
+
+ - libtracefs
+ - libtraceevent
+ - procps
+
+It also depends on python3-docutils to compile man pages.
+
+For development, we suggest the following steps for compiling rtla:
+
+  $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
+  $ cd libtraceevent/
+  $ make
+  $ sudo make install
+  $ cd ..
+  $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git
+  $ cd libtracefs/
+  $ make
+  $ sudo make install
+  $ cd ..
+  $ cd $rtla_src
+  $ make
+  $ sudo make install
+
+For further information, please refer to the rtla man page.
diff --git a/tools/tracing/rtla/src/rtla.c b/tools/tracing/rtla/src/rtla.c
new file mode 100644
index 000000000000..5ae2664ed47d
--- /dev/null
+++ b/tools/tracing/rtla/src/rtla.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#include <getopt.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+
+/*
+ * rtla_usage - print rtla usage
+ */
+static void rtla_usage(void)
+{
+	int i;
+
+	static const char *msg[] = {
+		"",
+		"rtla version " VERSION,
+		"",
+		"  usage: rtla COMMAND ...",
+		"",
+		"  commands:",
+		"",
+		NULL,
+	};
+
+	for (i = 0; msg[i]; i++)
+		fprintf(stderr, "%s\n", msg[i]);
+	exit(1);
+}
+
+/*
+ * run_command - try to run a rtla tool command
+ *
+ * It returns 0 if it fails. The tool's main will generally not
+ * return as they should call exit().
+ */
+int run_command(int argc, char **argv, int start_position)
+{
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int retval;
+
+	/* is it an alias? */
+	retval = run_command(argc, argv, 0);
+	if (retval)
+		exit(0);
+
+	if (argc < 2)
+		goto usage;
+
+	if (strcmp(argv[1], "-h") == 0) {
+		rtla_usage();
+		exit(0);
+	} else if (strcmp(argv[1], "--help") == 0) {
+		rtla_usage();
+		exit(0);
+	}
+
+	retval = run_command(argc, argv, 1);
+	if (retval)
+		exit(0);
+
+usage:
+	rtla_usage();
+	exit(1);
+}
-- 
2.33.0
