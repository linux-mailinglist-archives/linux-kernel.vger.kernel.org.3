Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D1D46139D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377365AbhK2LNo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 06:13:44 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:58238 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234240AbhK2LLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:11:38 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-DQpqLd3dN4-5RzfkgwFkaQ-1; Mon, 29 Nov 2021 06:08:17 -0500
X-MC-Unique: DQpqLd3dN4-5RzfkgwFkaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3829D10144E1;
        Mon, 29 Nov 2021 11:08:16 +0000 (UTC)
Received: from x1.com (unknown [10.22.8.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D69EA5D9DE;
        Mon, 29 Nov 2021 11:08:11 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 01/14] rtla: Real-Time Linux Analysis tool
Date:   Mon, 29 Nov 2021 12:07:39 +0100
Message-Id: <f59acda8bc513c4a6c279a9bc3ad112a20690e68.1638182284.git.bristot@kernel.org>
In-Reply-To: <cover.1638182284.git.bristot@kernel.org>
References: <cover.1638182284.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtla is a meta-tool that includes a set of commands that aims
to analyze the real-time properties of Linux. But instead of testing
Linux as a black box, rtla leverages kernel tracing capabilities to
provide precise information about the properties and root causes of
unexpected results.

rtla --help works and provide information about the available options.

This is just the "main" and the Makefile, no function yet.

Cc: Steven Rostedt <rostedt@goodmis.org>
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
index 000000000000..d99ea2d8b87e
--- /dev/null
+++ b/tools/tracing/rtla/Makefile
@@ -0,0 +1,76 @@
+NAME	:=	rtla
+VERSION	:=	0.4
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
2.31.1

