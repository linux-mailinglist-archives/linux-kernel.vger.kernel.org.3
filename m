Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDBC48B406
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiAKRcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344388AbiAKRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E0C061759;
        Tue, 11 Jan 2022 09:31:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7747B81C3B;
        Tue, 11 Jan 2022 17:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B27C36AF3;
        Tue, 11 Jan 2022 17:31:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzN-0032HF-LO;
        Tue, 11 Jan 2022 12:31:17 -0500
Message-ID: <20220111173117.491473727@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:54 -0500
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
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 23/31] rtla: Add Documentation
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Adds the basis for rtla documentation. This patch also
includes the rtla(1) man page.

As suggested by Jonathan Corbet, we are placing these man
pages at Documentation/tools/rtla, using rst format. It
is not linked to the official documentation, though.

The Makefile is based on bpftool's Documentation one.

Link: https://lkml.kernel.org/r/66edf7af207dfe69fabae10575f42d73d92f07c4.1638182284.git.bristot@kernel.org

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
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/tools/rtla/Makefile            | 41 +++++++++++++++++
 Documentation/tools/rtla/common_appendix.rst | 12 +++++
 Documentation/tools/rtla/rtla.rst            | 48 ++++++++++++++++++++
 tools/tracing/rtla/Makefile                  | 30 ++++++++++--
 4 files changed, 127 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/tools/rtla/Makefile
 create mode 100644 Documentation/tools/rtla/common_appendix.rst
 create mode 100644 Documentation/tools/rtla/rtla.rst

diff --git a/Documentation/tools/rtla/Makefile b/Documentation/tools/rtla/Makefile
new file mode 100644
index 000000000000..9f2b84af1a6c
--- /dev/null
+++ b/Documentation/tools/rtla/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Based on bpftool's Documentation Makefile
+
+INSTALL		?= install
+RM		?= rm -f
+RMDIR		?= rmdir --ignore-fail-on-non-empty
+
+PREFIX		?= /usr/share
+MANDIR		?= $(PREFIX)/man
+MAN1DIR		= $(MANDIR)/man1
+
+MAN1_RST	= $(wildcard rtla*.rst)
+
+_DOC_MAN1	= $(patsubst %.rst,%.1,$(MAN1_RST))
+DOC_MAN1	= $(addprefix $(OUTPUT),$(_DOC_MAN1))
+
+RST2MAN_DEP	:= $(shell command -v rst2man 2>/dev/null)
+RST2MAN_OPTS	+= --verbose
+
+$(OUTPUT)%.1: %.rst
+ifndef RST2MAN_DEP
+	$(error "rst2man not found, but required to generate man pages")
+endif
+	rst2man $(RST2MAN_OPTS) $< > $@
+
+man1: $(DOC_MAN1)
+man: man1
+
+clean:
+	$(RM) $(DOC_MAN1)
+
+install: man
+	$(INSTALL) -d -m 755 $(DESTDIR)$(MAN1DIR)
+	$(INSTALL) -m 644 $(DOC_MAN1) $(DESTDIR)$(MAN1DIR)
+
+uninstall:
+	$(RM) $(addprefix $(DESTDIR)$(MAN1DIR)/,$(_DOC_MAN1))
+	$(RMDIR) $(DESTDIR)$(MAN1DIR)
+
+.PHONY: man man1 clean install uninstall
+.DEFAULT_GOAL := man
diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.rst
new file mode 100644
index 000000000000..b494084acccd
--- /dev/null
+++ b/Documentation/tools/rtla/common_appendix.rst
@@ -0,0 +1,12 @@
+REPORTING BUGS
+==============
+Report bugs to <lkml@vger.kernel.org>
+
+LICENSE
+=======
+**rtla** is Free Software licensed under the GNU GPLv2
+
+COPYING
+=======
+Copyright \(C) 2021 Red Hat, Inc. Free use of this software is granted under
+the terms of the GNU Public License (GPL).
diff --git a/Documentation/tools/rtla/rtla.rst b/Documentation/tools/rtla/rtla.rst
new file mode 100644
index 000000000000..fc0d233efcd5
--- /dev/null
+++ b/Documentation/tools/rtla/rtla.rst
@@ -0,0 +1,48 @@
+=========
+rtla
+=========
+--------------------------------
+Real-time Linux Analysis tool
+--------------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rtla** *COMMAND* [*OPTIONS*]
+
+DESCRIPTION
+===========
+The **rtla** is a meta-tool that includes a set of commands that aims to
+analyze the real-time properties of Linux. But instead of testing Linux
+as a black box, **rtla** leverages kernel tracing capabilities to provide
+precise information about the properties and root causes of unexpected
+results.
+
+COMMANDS
+========
+**osnoise**
+
+        Gives information about the operating system noise (osnoise).
+
+**timerlat**
+
+        Measures the IRQ and thread timer latency.
+
+OPTIONS
+=======
+**-h**, **--help**
+
+        Display the help text.
+
+For other options, see the man page for the corresponding command.
+
+SEE ALSO
+========
+**rtla-osnoise**\(1), **rtla-timerlat**\(1)
+
+AUTHOR
+======
+Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 9631a98976a8..72c002406bff 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -45,18 +45,28 @@ DATADIR	:=	/usr/share
 DOCDIR	:=	$(DATADIR)/doc
 MANDIR	:=	$(DATADIR)/man
 LICDIR	:=	$(DATADIR)/licenses
+SRCTREE	:=	$(if $(BUILD_SRC),$(BUILD_SRC),$(CURDIR))
+
+# If running from the tarball, man pages are stored in the Documentation
+# dir. If running from the kernel source, man pages are stored in
+# Documentation/tools/rtla/.
+ifneq ($(wildcard Documentation/.*),)
+DOCSRC	=	Documentation/
+else
+DOCSRC	=	$(SRCTREE)/../../../Documentation/tools/rtla/
+endif
 
 .PHONY:	all
 all:	rtla
 
-rtla: $(OBJ)
+rtla: $(OBJ) doc
 	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
 
 static: $(OBJ)
 	$(CC) -o rtla-static $(LDFLAGS) --static $(OBJ) $(LIBS) -lpthread -ldl
 
 .PHONY: install
-install:
+install: doc_install
 	$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
 	$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
 	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
@@ -66,15 +76,27 @@ install:
 	ln -s $(DESTDIR)$(BINDIR)/rtla $(DESTDIR)$(BINDIR)/timerlat
 
 .PHONY: clean tarball
-clean:
+clean: doc_clean
 	@test ! -f rtla || rm rtla
 	@test ! -f rtla-static || rm rtla-static
 	@test ! -f src/rtla.o || rm src/rtla.o
 	@test ! -f $(TARBALL) || rm -f $(TARBALL)
 	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
 
-tarball:  clean
+tarball: clean
 	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
 	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
+	mkdir $(NAME)-$(VERSION)/Documentation/
+	cp -rp $(SRCTREE)/../../../Documentation/tools/rtla/* $(NAME)-$(VERSION)/Documentation/
 	tar $(TAROPTS) --exclude='*~' $(NAME)-$(VERSION)
 	rm -rf $(NAME)-$(VERSION)
+
+.PHONY: doc doc_clean doc_install
+doc:
+	$(MAKE) -C $(DOCSRC)
+
+doc_clean:
+	$(MAKE) -C $(DOCSRC) clean
+
+doc_install:
+	$(MAKE) -C $(DOCSRC) install
-- 
2.33.0
