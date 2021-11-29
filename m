Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F204613A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377161AbhK2LPE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 06:15:04 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:31433 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238600AbhK2LMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:12:30 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-R0t8g8bhM6aeAscfdAYVag-1; Mon, 29 Nov 2021 06:09:07 -0500
X-MC-Unique: R0t8g8bhM6aeAscfdAYVag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A56FD81CCB4;
        Mon, 29 Nov 2021 11:09:05 +0000 (UTC)
Received: from x1.com (unknown [10.22.8.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A620C5D9DE;
        Mon, 29 Nov 2021 11:08:59 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V8 08/14] rtla: Add Documentation
Date:   Mon, 29 Nov 2021 12:07:46 +0100
Message-Id: <66edf7af207dfe69fabae10575f42d73d92f07c4.1638182284.git.bristot@kernel.org>
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

Adds the basis for rtla documentation. This patch also
includes the rtla(1) man page.

As suggested by Jonathan Corbet, we are placing these man
pages at Documentation/tools/rtla, using rst format. It
is not linked to the official documentation, though.

The Makefile is based on bpftool's Documentation one.

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
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
index f254cfbe4fa3..8b9bee124eb3 100644
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
2.31.1

