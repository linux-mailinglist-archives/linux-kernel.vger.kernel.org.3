Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0FD4BB980
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiBRMyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:54:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbiBRMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:54:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC242B31BE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:54:16 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u2so13292124wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIVAoOOg4NGP65RtAGV7Gtb1/X/Y7aAy4iVU/DdUPBU=;
        b=kr78lElNNrGiyhkOL/Fg4V4KWV18OAddjGOKS6uBGXCcu1V8m6osewDBDF9n0FjLD3
         NrnxZvUWytPvi0G+yMcRlxEyPoGoBCz62DV032LgBXnA1BD/35exs6ZdpQ/PpMHTEKtW
         H9IiBvRj053Hhc0m8LXDZqx5YfylQvQEDBLPt+lRvga4sxu1MMJuG0tkr6SkGQY2jxDF
         sLqUEu3jqNRLhZCGIHd+pr3hBUZrStTo7P2Yz/CeJf1yke5SHItJSMTO7yJomYiMiBxE
         j3RDLrQX5MkUevsMMqE3axtavCC26LmBz3kR8sLMHPjYweiwDaovkT9+kEJqX+Evv4PX
         Qdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIVAoOOg4NGP65RtAGV7Gtb1/X/Y7aAy4iVU/DdUPBU=;
        b=kSf8QUvUG7zojcNDvRTYkMMu+/895UYOFsWCNqkMNwZ/Kthwou7415Rd8xM3Hqye74
         PeNruuc7LI0lprlgEYM01QS46a35jB7948VreMFcypBL8BFAPedCG5cdMt0GL03lV4MG
         YtoGkYukLuojHrDgHnXZaMBa1JR7ub0g5KlkFJAbZswWZ2cuTF8ukajROIittkfmPRmM
         MOHXnmrY9TEidlpF9Z7HIuU7glcxNL7BHChJSxk3Al0Hi041XHizIcKOYHYXzcg1vwSC
         eXeTuGZYaCwK/T1dEEaGnWwc3RWtdT+MzMibPKnjkm1CVQ7Gnc4s+ofBMVAtGEc7tsT3
         jsDQ==
X-Gm-Message-State: AOAM533fHc1CnJY/vZgujQ65Gd4gz9Ky6aa05vo7y7lyNxdm9wTK02xY
        iz0MyupOgHMFG+td0eP+9sb6OXnuXmvF7Q==
X-Google-Smtp-Source: ABdhPJyizVojKiD/J+cBD2Skjuo8paqjVla8HhVUwhyyE3ud+ekYjmtZJB0AcrqSdlnMnlr/SIOEGA==
X-Received: by 2002:a5d:52cb:0:b0:1e4:b8b5:6ce1 with SMTP id r11-20020a5d52cb000000b001e4b8b56ce1mr5938758wrv.268.1645188854884;
        Fri, 18 Feb 2022 04:54:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:5828:300b:5226:ef02])
        by smtp.gmail.com with ESMTPSA id p7sm17034011wrr.95.2022.02.18.04.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 04:54:14 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 2/4] tools/thermal: Add util library
Date:   Fri, 18 Feb 2022 13:53:32 +0100
Message-Id: <20220218125334.995447-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218125334.995447-1-daniel.lezcano@linaro.org>
References: <20220218125334.995447-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next changes will provide a couple of tools using some common
functions provided by this library.

It provides basic wrappers for:

 - mainloop
 - logging
 - timestamp

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/thermal/lib/Build                       |   3 +
 tools/thermal/lib/Makefile                    | 158 ++++++++++++++++++
 .../thermal/lib/libthermal_tools.pc.template  |  12 ++
 tools/thermal/lib/log.c                       |  77 +++++++++
 tools/thermal/lib/log.h                       |  31 ++++
 tools/thermal/lib/mainloop.c                  | 135 +++++++++++++++
 tools/thermal/lib/mainloop.h                  |  14 ++
 tools/thermal/lib/thermal-tools.h             |  10 ++
 tools/thermal/lib/uptimeofday.c               |  40 +++++
 tools/thermal/lib/uptimeofday.h               |  12 ++
 10 files changed, 492 insertions(+)
 create mode 100644 tools/thermal/lib/Build
 create mode 100644 tools/thermal/lib/Makefile
 create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
 create mode 100644 tools/thermal/lib/log.c
 create mode 100644 tools/thermal/lib/log.h
 create mode 100644 tools/thermal/lib/mainloop.c
 create mode 100644 tools/thermal/lib/mainloop.h
 create mode 100644 tools/thermal/lib/thermal-tools.h
 create mode 100644 tools/thermal/lib/uptimeofday.c
 create mode 100644 tools/thermal/lib/uptimeofday.h

diff --git a/tools/thermal/lib/Build b/tools/thermal/lib/Build
new file mode 100644
index 000000000000..06f22760a272
--- /dev/null
+++ b/tools/thermal/lib/Build
@@ -0,0 +1,3 @@
+libthermal_tools-y += mainloop.o
+libthermal_tools-y += log.o
+libthermal_tools-y += uptimeofday.o
diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
new file mode 100644
index 000000000000..bdf4659adfeb
--- /dev/null
+++ b/tools/thermal/lib/Makefile
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Most of this file is copied from tools/lib/perf/Makefile
+
+LIBTHERMAL_TOOLS_VERSION = 0
+LIBTHERMAL_TOOLS_PATCHLEVEL = 0
+LIBTHERMAL_TOOLS_EXTRAVERSION = 1
+
+MAKEFLAGS += --no-print-directory
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+# $(info Determined 'srctree' to be $(srctree))
+endif
+
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
+include $(srctree)/tools/scripts/Makefile.include
+include $(srctree)/tools/scripts/Makefile.arch
+
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
+
+ifeq ("$(origin V)", "command line")
+  VERBOSE = $(V)
+endif
+ifndef VERBOSE
+  VERBOSE = 0
+endif
+
+ifeq ($(VERBOSE),1)
+  Q =
+else
+  Q = @
+endif
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+INCLUDES = \
+-I/usr/include/libnl3 \
+-I$(srctree)/tools/lib/thermal/include \
+-I$(srctree)/tools/lib/ \
+-I$(srctree)/tools/include \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/ \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
+-I$(srctree)/tools/include/uapi
+
+# Append required CFLAGS
+override CFLAGS += $(EXTRA_WARNINGS)
+override CFLAGS += -Werror -Wall
+override CFLAGS += -fPIC
+override CFLAGS += $(INCLUDES)
+override CFGLAS += -Wl,-L.
+override CFGLAS += -Wl,-lthermal
+
+all:
+
+export srctree OUTPUT CC LD CFLAGS V
+export DESTDIR DESTDIR_SQ
+
+include $(srctree)/tools/build/Makefile.include
+
+PATCHLEVEL    = $(LIBTHERMAL_TOOLS_PATCHLEVEL)
+EXTRAVERSION  = $(LIBTHERMAL_TOOLS_EXTRAVERSION)
+VERSION       = $(LIBTHERMAL_TOOLS_VERSION).$(LIBTHERMAL_TOOLS_PATCHLEVEL).$(LIBTHERMAL_TOOLS_EXTRAVERSION)
+
+LIBTHERMAL_TOOLS_SO := $(OUTPUT)libthermal_tools.so.$(VERSION)
+LIBTHERMAL_TOOLS_A  := $(OUTPUT)libthermal_tools.a
+LIBTHERMAL_TOOLS_IN := $(OUTPUT)libthermal_tools-in.o
+LIBTHERMAL_TOOLS_PC := $(OUTPUT)libthermal_tools.pc
+
+LIBTHERMAL_TOOLS_ALL := $(LIBTHERMAL_TOOLS_A) $(OUTPUT)libthermal_tools.so*
+
+$(LIBTHERMAL_TOOLS_IN): FORCE
+	$(Q)$(MAKE) $(build)=libthermal_tools
+
+$(LIBTHERMAL_TOOLS_A): $(LIBTHERMAL_TOOLS_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBTHERMAL_TOOLS_IN)
+
+$(LIBTHERMAL_TOOLS_SO): $(LIBTHERMAL_TOOLS_IN)
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libthermal_tools.so $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libthermal_tools.so
+	@ln -sf $(@F) $(OUTPUT)libthermal_tools.so.$(LIBTHERMAL_TOOLS_VERSION)
+
+
+libs: $(LIBTHERMAL_TOOLS_A) $(LIBTHERMAL_TOOLS_SO) $(LIBTHERMAL_TOOLS_PC)
+
+all: fixdep
+	$(Q)$(MAKE) libs
+
+clean: 
+	$(call QUIET_CLEAN, libthermal_tools) $(RM) $(LIBTHERMAL_TOOLS_A) \
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBTHERMAL_TOOLS_VERSION) .*.d .*.cmd LIBTHERMAL_TOOLS-CFLAGS $(LIBTHERMAL_TOOLS_PC)
+
+$(LIBTHERMAL_TOOLS_PC):
+	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
+		-e "s|@LIBDIR@|$(libdir_SQ)|" \
+		-e "s|@VERSION@|$(VERSION)|" \
+		< libthermal_tools.pc.template > $@
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: libs
+	$(call QUIET_INSTALL, $(LIBTHERMAL_TOOLS_ALL)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBTHERMAL_TOOLS_ALL) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/thermal.h,$(prefix)/include/thermal,644); \
+
+install_pkgconfig: $(LIBTHERMAL_TOOLS_PC)
+	$(call QUIET_INSTALL, $(LIBTHERMAL_TOOLS_PC)) \
+		$(call do_install,$(LIBTHERMAL_TOOLS_PC),$(libdir_SQ)/pkgconfig,644)
+
+install_doc:
+	$(Q)$(MAKE) -C Documentation install-man install-html install-examples
+
+#install: install_lib install_headers install_pkgconfig install_doc
+install: install_lib install_headers install_pkgconfig
+
+FORCE:
+
+.PHONY: all install clean FORCE
diff --git a/tools/thermal/lib/libthermal_tools.pc.template b/tools/thermal/lib/libthermal_tools.pc.template
new file mode 100644
index 000000000000..6f3769731b59
--- /dev/null
+++ b/tools/thermal/lib/libthermal_tools.pc.template
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+prefix=@PREFIX@
+libdir=@LIBDIR@
+includedir=${prefix}/include
+
+Name: libthermal
+Description: thermal library
+Requires: libnl-3.0 libnl-genl-3.0
+Version: @VERSION@
+Libs: -L${libdir} -lnl-genl-3 -lnl-3
+Cflags: -I${includedir} -I{include}/libnl3
diff --git a/tools/thermal/lib/log.c b/tools/thermal/lib/log.c
new file mode 100644
index 000000000000..620df5b3220f
--- /dev/null
+++ b/tools/thermal/lib/log.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <syslog.h>
+#include "log.h"
+
+static const char *__ident = "unknown";
+static int __options = 0;
+
+static const char *loglvl[] = {
+	[LOG_DEBUG]	= "DEBUG",
+	[LOG_INFO]	= "INFO",
+	[LOG_NOTICE]	= "NOTICE",
+	[LOG_WARNING]	= "WARN",
+	[LOG_ERR]	= "ERROR",
+	[LOG_CRIT]	= "CRITICAL",
+	[LOG_ALERT]	= "ALERT",
+	[LOG_EMERG]	= "EMERG",
+};
+
+int log_str2level(const char *lvl)
+{
+	int i;
+
+	for (i = 0; i < sizeof(loglvl) / sizeof(loglvl[LOG_DEBUG]); i++)
+		if (!strcmp(lvl, loglvl[i]))
+			return i;
+
+	return LOG_DEBUG;
+}
+
+extern void logit(int level, const char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+	
+	if (__options & TO_SYSLOG)
+		vsyslog(level, format, args);
+
+	if (__options & TO_STDERR)
+		vfprintf(stderr, format, args);
+
+	if (__options & TO_STDOUT)
+		vfprintf(stdout, format, args);
+
+	va_end(args);
+}
+
+int log_init(int level, const char *ident, int options)
+{
+	if (!options)
+		return -1;
+
+	if (level > LOG_DEBUG)
+		return -1;
+
+	if (!ident)
+		return -1;
+
+	__ident = ident;
+	__options = options;
+	
+	if (options & TO_SYSLOG) {
+		openlog(__ident, options | LOG_NDELAY, LOG_USER);
+		setlogmask(LOG_UPTO(level));
+	}
+
+	return 0;
+}
+
+void log_exit(void)
+{
+	closelog();
+}
diff --git a/tools/thermal/lib/log.h b/tools/thermal/lib/log.h
new file mode 100644
index 000000000000..9ee945e0af57
--- /dev/null
+++ b/tools/thermal/lib/log.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_TOOLS_LOG_H
+#define __THERMAL_TOOLS_LOG_H
+
+#include <syslog.h>
+
+#ifndef __maybe_unused
+#define __maybe_unused		__attribute__((__unused__))
+#endif
+
+#define TO_SYSLOG 0x1
+#define TO_STDOUT 0x2
+#define TO_STDERR 0x4
+
+extern void logit(int level, const char *format, ...);
+
+#define DEBUG(fmt, ...)		logit(LOG_DEBUG, "%s(%d): " fmt, __FUNCTION__, __LINE__, ##__VA_ARGS__)
+#define INFO(fmt, ...)		logit(LOG_INFO, fmt, ##__VA_ARGS__)
+#define NOTICE(fmt, ...)	logit(LOG_NOTICE, fmt, ##__VA_ARGS__)
+#define WARN(fmt, ...)		logit(LOG_WARNING, fmt, ##__VA_ARGS__)
+#define ERROR(fmt, ...)		logit(LOG_ERR, fmt, ##__VA_ARGS__)
+#define CRITICAL(fmt, ...)	logit(LOG_CRIT, fmt, ##__VA_ARGS__)
+#define ALERT(fmt, ...)		logit(LOG_ALERT, fmt, ##__VA_ARGS__)
+#define EMERG(fmt, ...)		logit(LOG_EMERG, fmt, ##__VA_ARGS__)
+
+int log_init(int level, const char *ident, int options);
+int log_str2level(const char *lvl);
+void log_exit(void);
+
+#endif
diff --git a/tools/thermal/lib/mainloop.c b/tools/thermal/lib/mainloop.c
new file mode 100644
index 000000000000..182a9533445b
--- /dev/null
+++ b/tools/thermal/lib/mainloop.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/epoll.h>
+#include "mainloop.h"
+#include "log.h"
+
+static int epfd = -1;
+static unsigned short nrhandler;
+static sig_atomic_t exit_mainloop = 0;
+
+struct mainloop_data {
+	mainloop_callback_t cb;
+	void *data;
+	int fd;
+};
+
+static struct mainloop_data **mds;
+
+#define MAX_EVENTS 10
+
+static void sig_exit(__maybe_unused int sig)
+{
+	exit_mainloop = 1;
+}
+
+int mainloop(unsigned int timeout)
+{
+        int i, nfds;
+        struct epoll_event events[MAX_EVENTS];
+	struct mainloop_data *md;
+
+	if (epfd < 0)
+		return -1;
+
+	for (;;) {
+
+                nfds = epoll_wait(epfd, events, MAX_EVENTS, timeout);
+
+		if (exit_mainloop)
+			return 0;
+		
+                if (nfds < 0) {
+                        if (errno == EINTR)
+                                continue;
+                        return -1;
+                }
+
+		/* 
+		 * A timeout occured. Let's send to ourself a SIGWINCH
+		 * so the window get refreshed automatically. No need
+		 * to use exported functions and this code stay self
+		 * contained.
+		 */
+		if (!nfds) {
+			kill(getpid(), SIGWINCH);
+			continue;
+		}
+
+                for (i = 0; i < nfds; i++) {
+			md = events[i].data.ptr;
+
+			if (md->cb(md->fd, md->data) > 0)
+				return 0;
+		}
+
+	}
+}
+
+int mainloop_add(int fd, mainloop_callback_t cb, void *data)
+{
+	struct epoll_event ev = {
+		.events = EPOLLIN,
+	};
+
+	struct mainloop_data *md;
+
+	if (fd >= nrhandler) {
+		mds = realloc(mds, sizeof(*mds) * (fd + 1));
+		if (!mds)
+			return -1;
+		nrhandler = fd + 1;
+	}
+
+	md = malloc(sizeof(*md));
+	if (!md)
+		return -1;
+
+	md->data = data;
+	md->cb = cb;
+	md->fd = fd;
+
+	mds[fd] = md;
+	ev.data.ptr = md;
+
+        if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) < 0) {
+		free(md);
+		return -1;
+	}
+
+	return 0;
+}
+
+int mainloop_del(int fd)
+{
+	if (fd >= nrhandler)
+		return -1;
+
+        if (epoll_ctl(epfd, EPOLL_CTL_DEL, fd, NULL) < 0)
+		return -1;
+
+	free(mds[fd]);
+
+	return 0;
+}
+
+int mainloop_init(void)
+{
+        epfd = epoll_create(2);
+        if (epfd < 0)
+                return -1;
+
+	signal(SIGINT, sig_exit);
+	signal(SIGTERM, sig_exit);
+	
+        return 0;
+}
+
+void mainloop_fini(void)
+{
+	close(epfd);
+}
diff --git a/tools/thermal/lib/mainloop.h b/tools/thermal/lib/mainloop.h
new file mode 100644
index 000000000000..eb37977a83e7
--- /dev/null
+++ b/tools/thermal/lib/mainloop.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_TOOLS_MAINLOOP_H
+#define __THERMAL_TOOLS_MAINLOOP_H
+
+typedef int (*mainloop_callback_t)(int fd, void *data);
+
+extern int mainloop(unsigned int timeout);
+extern int mainloop_add(int fd, mainloop_callback_t cb, void *data);
+extern int mainloop_del(int fd);
+extern int mainloop_init(void);
+extern void mainloop_fini(void);
+
+#endif
diff --git a/tools/thermal/lib/thermal-tools.h b/tools/thermal/lib/thermal-tools.h
new file mode 100644
index 000000000000..f43939a468a3
--- /dev/null
+++ b/tools/thermal/lib/thermal-tools.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_TOOLS
+#define __THERMAL_TOOLS
+
+#include "log.h"
+#include "mainloop.h"
+#include "uptimeofday.h"
+
+#endif
diff --git a/tools/thermal/lib/uptimeofday.c b/tools/thermal/lib/uptimeofday.c
new file mode 100644
index 000000000000..7ccbb272debd
--- /dev/null
+++ b/tools/thermal/lib/uptimeofday.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <stdio.h>
+#include <sys/time.h>
+#include <linux/sysinfo.h>
+#include "thermal-tools.h"
+
+static unsigned long __offset;
+static struct timeval __tv;
+
+int uptimeofday_init(void)
+{
+	struct sysinfo info;
+
+	if (sysinfo(&info))
+		return -1;
+
+	gettimeofday(&__tv, NULL);
+
+	__offset = __tv.tv_sec - info.uptime;
+
+	return 0;
+}
+
+unsigned long getuptimeofday_ms(void)
+{
+	gettimeofday(&__tv, NULL);
+
+	return ((__tv.tv_sec - __offset) * 1000) + (__tv.tv_usec / 1000);
+}
+
+struct timespec msec_to_timespec(int msec)
+{
+        struct timespec tv = {
+                .tv_sec = (time_t)(msec / 1000),
+                .tv_nsec = (msec - tv.tv_sec) * 1000000,
+        };
+
+        return tv;
+}
diff --git a/tools/thermal/lib/uptimeofday.h b/tools/thermal/lib/uptimeofday.h
new file mode 100644
index 000000000000..c0da5de41325
--- /dev/null
+++ b/tools/thermal/lib/uptimeofday.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_TOOLS_UPTIMEOFDAY_H
+#define __THERMAL_TOOLS_UPTIMEOFDAY_H
+#include <sys/sysinfo.h>
+#include <sys/time.h>
+
+int uptimeofday_init(void);
+unsigned long getuptimeofday_ms(void);
+struct timespec msec_to_timespec(int msec);
+
+#endif
-- 
2.25.1

