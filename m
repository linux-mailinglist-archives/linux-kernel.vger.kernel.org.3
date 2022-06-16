Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2643154DD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376363AbiFPIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376340AbiFPIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:47:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F05DBC3;
        Thu, 16 Jun 2022 01:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F380AB822A8;
        Thu, 16 Jun 2022 08:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C79FC34114;
        Thu, 16 Jun 2022 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369204;
        bh=gBQRWBS65y6AvIyCwVqPSalZ1C7O6+dSSnUu2L6tC1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnPKHDm+hw0xeu3XjfXSFkk3nBbOw9zwMNEI5QYfS/YfXuEr07Oh9+Ng3UBULq8LH
         8fF0cBc1U/iBvFiJdWpI3QBGyzIH2mp6LjnH/jovSW4gNcIi8glxTm5y/BKlYVHjiw
         o/joIBUeGM9qpE9/Rr1Zn3lcDQBMl1hzy9b8CNWgJwL/EtVacBYqjyMptONl7Tz0fT
         X5gnWkdwuUNVnsHZqawBvhaenF7wSokk6ickmOiCr170mzCuBTtYIv/JNQhzd/8WpX
         d8zeMvGq9VRR0LLeM8ZuJeUOMLzdM90jDLzKb/Qgn3CR5/8W8BKfFzGbh9DP3Pw2JE
         iM7pBvT8px/yA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V4 19/20] rv/safety_app: Add a safety_app sample
Date:   Thu, 16 Jun 2022 10:45:01 +0200
Message-Id: <fd63dddbe0339ed471feb3c3c959c5c8122d7e40.1655368610.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sample code of a safety application that uses the
watchdog as a safety monitor and the RV monitors to monitor
this interaction/get feedback from kernel about the watchdog states.

This tool first creates a trace instance to follow the RV events
and then enables RV monitor. After that, the tool configures
the watchdog and starts running the main loop.

The main loop runs a use-case-specific function, like checking
the system. If the system is running as expected, it pings the
watchdog. After pinging the watchdog, the tool then collects
trace information to see if the RV monitor received the expected
events and is in a safe/safe_nwo state.

For further information, run safety_app --help

The safety-app specification was developed together with Gabriele Paoloni,
in the context of the Linux Foundation Elisa Project.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/safety_app/Makefile     |  51 ++
 tools/verification/safety_app/safety_app.c | 614 +++++++++++++++++++++
 2 files changed, 665 insertions(+)
 create mode 100644 tools/verification/safety_app/Makefile
 create mode 100644 tools/verification/safety_app/safety_app.c

diff --git a/tools/verification/safety_app/Makefile b/tools/verification/safety_app/Makefile
new file mode 100644
index 000000000000..002531022e45
--- /dev/null
+++ b/tools/verification/safety_app/Makefile
@@ -0,0 +1,51 @@
+NAME	:=	safety_app
+VERSION	:=	0.1
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
+CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(WOPTS) $(TRACEFS_HEADERS)
+LDFLAGS	:=	-ggdb
+LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
+FILES	:=	Makefile
+BINDIR	:=	/usr/bin
+
+OBJ	:=	$(NAME).o
+
+.PHONY:	all
+all:	$(OBJ)
+	$(CC) -o $(NAME) $(LDFLAGS) $(OBJ) $(LIBS)
+
+.PHONY: install
+install:
+	$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
+	$(INSTALL) $(NAME) -m 755 $(DESTDIR)$(BINDIR)
+	$(STRIP) $(DESTDIR)$(BINDIR)/$(NAME)
+
+.PHONY: clean
+clean:
+	@rm -rf *~ $(OBJ) $(NAME)
diff --git a/tools/verification/safety_app/safety_app.c b/tools/verification/safety_app/safety_app.c
new file mode 100644
index 000000000000..143ebe17dfc9
--- /dev/null
+++ b/tools/verification/safety_app/safety_app.c
@@ -0,0 +1,614 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * This is the starting point for a safety monitor.
+ *
+ * The safety_check() function is where you need to add your own code.
+ *
+ * Copyright: Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <linux/watchdog.h>
+#include <tracefs/tracefs.h>
+
+#define MAX_PATH	1024
+
+static int		config_watchdog_id;
+static char		config_watchdog_path[MAX_PATH];
+static int		config_nowayout;
+static char		config_nowayout_path[MAX_PATH];
+static long long	config_timeout = 10;
+static long		config_cycles;
+static long		config_monitor_period = 1;
+static char		*config_rv_monitor = "safe_wtd";
+static char		*config_rv_reactor = "panic";
+static int		config_stop_monitor = 0;
+static int		config_restart_monitor = 0;
+
+/*
+ * print_msg - print a message to stdout
+ */
+void print_msg(const char *fmt, ...)
+{
+	char message[1024];
+	va_list ap;
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stdout, "%s", message);
+	fflush(NULL);
+}
+
+/*
+ * ==================================================================
+ * The code section bellow is responsible for enabling the RV monitor.
+ * ==================================================================
+ */
+
+/*
+ * __disable_rv_monitor - disables the RV monitor
+ *
+ * Unconditionally disables the RV monitor and set the reactor to nop.
+ */
+static void __disable_rv_monitor(char *monitor)
+{
+	char path[MAX_PATH];
+	int retval;
+
+	snprintf(path, MAX_PATH, "rv/monitors/%s/enable", monitor);
+	retval = tracefs_instance_file_write(NULL, path, "0\n");
+	if (retval < 0) {
+		perror("Error disabling the RV monitor");
+		return;
+	}
+
+	snprintf(path, MAX_PATH, "rv/monitors/%s/reactors", monitor);
+	retval = tracefs_instance_file_write(NULL, path, "nop\n");
+	if (retval < 0) {
+		perror("Error disabling the RV reactor");
+		return;
+	}
+}
+
+/*
+ * disable_rv_monitor - conditionally disables the RV monitor
+ */
+static void disable_rv_monitor(char *monitor)
+{
+	if (!config_stop_monitor)
+		return;
+
+	__disable_rv_monitor(monitor);
+}
+
+/*
+ * enable_rv_monitor - sets the 'reactor' and enable RV 'monitor'
+ */
+static int enable_rv_monitor(char *monitor, char *reactor)
+{
+	char buffer[MAX_PATH];
+	char path[MAX_PATH];
+	int size = 2;
+	int retval;
+	char *on;
+
+	snprintf(path, MAX_PATH, "rv/monitors/%s/enable", monitor);
+	on = tracefs_instance_file_read(NULL, path, &size);
+	if (on && on[0] == '1') {
+		if (!config_restart_monitor)
+			return 0;
+		__disable_rv_monitor(monitor);
+	}
+
+	snprintf(path, MAX_PATH, "rv/monitors/%s/reactors", monitor);
+	snprintf(buffer, MAX_PATH, "%s\n", reactor);
+	retval = tracefs_instance_file_write(NULL, path, buffer);
+	if (retval < 0) {
+		perror("Error enabling the RV reactor");
+		return -1;
+	}
+
+	snprintf(path, MAX_PATH, "rv/monitors/%s/enable", monitor);
+	retval = tracefs_instance_file_write(NULL, path, "1\n");
+	if (retval < 0) {
+		perror("Error enabling the RV monitor");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * ==================================================================
+ * The code section bellow is responsible for parsing the RV monitor output.
+ * ==================================================================
+ */
+struct trace_instance {
+	struct tracefs_instance		*inst;
+	struct tep_handle		*tep;
+	struct trace_seq		*seq;
+};
+
+int ping_counter = 0;
+int last_state_running = 0;
+
+/*
+ * handle_safe_wtd_rv_event - parse events from the safe_wtd RV monitor
+ */
+static int
+handle_safe_wtd_rv_event(struct trace_seq *s, struct tep_record *record,
+			 struct tep_event *event, void *context)
+{
+	char *event_name;
+	char *state;
+	int len;
+
+	event_name = tep_get_field_raw(s, event, "event", record, &len, 1);
+	if (event_name && !strcmp(event_name, "ping"))
+		ping_counter++;
+
+	state = tep_get_field_raw(s, event, "next_state", record, &len, 0);
+	if (state && !strncmp(state, "safe", 4))
+		last_state_running = 1;
+	else
+		last_state_running = 0;
+
+	return 0;
+}
+
+/*
+ * collect_registered_events - call the existing callback function for the event
+ *
+ * If an event has a registered callback function, call it.
+ * Otherwise, ignore the event.
+ */
+static int
+collect_registered_events(struct tep_event *event, struct tep_record *record,
+			  int cpu, void *context)
+{
+	struct trace_instance *trace = context;
+	struct trace_seq *s = trace->seq;
+
+	if (!event->handler)
+		return 0;
+
+	event->handler(s, record, event, context);
+
+	return 0;
+}
+
+/*
+ * check_rv_events - parse trace events and check for the desired states
+ *
+ * Return 0 if success, 1 otherwise.
+ */
+static int check_rv_events(struct trace_instance *trace)
+{
+	int prev_ping_counter = ping_counter;
+	int retval;
+	int pings;
+
+	retval = tracefs_iterate_raw_events(trace->tep, trace->inst, NULL, 0,
+					    collect_registered_events, trace);
+	if (retval < 0) {
+		print_msg("Error iterating on events\n");
+		return 1;
+	}
+
+	pings = ping_counter - prev_ping_counter;
+	print_msg("RV read %d ping(s) and is %s the watchdog\n", pings,
+			last_state_running ? "running" : "not running");
+
+	/*
+	 * If there is exactly one ping and the last state is running,
+	 * it is safe.
+	 */
+	if (pings == 1 && last_state_running) {
+		/* reset the variable */
+		last_state_running = 0;
+		return 0;
+	} else {
+		return 1;
+	}
+}
+
+/*
+ * trace_instance_destroy - destroy and free a trace instance
+ */
+static void trace_instance_destroy(struct trace_instance *trace)
+{
+	if (!trace)
+		return;
+
+	if (trace->inst) {
+		tracefs_instance_destroy(trace->inst);
+		tracefs_instance_free(trace->inst);
+	}
+
+	if (trace->seq)
+		free(trace->seq);
+
+	if (trace->tep)
+		tep_free(trace->tep);
+
+	free(trace);
+}
+
+/*
+ * trace_instance_init - create a trace instance to read monitor's event
+ *
+ * It is more than the tracefs instance, as it contains other
+ * things required for the tracing, such as the local events and
+ * a seq file.
+ */
+static struct trace_instance *trace_instance_init(void)
+{
+	struct trace_instance *trace;
+
+	trace = calloc(1, sizeof(*trace));
+	if (!trace)
+		return NULL;
+
+	trace->seq = calloc(1, sizeof(*trace->seq));
+	if (!trace->seq)
+		goto destroy_instance;
+
+	trace_seq_init(trace->seq);
+
+	trace->inst = tracefs_instance_create("safety_app");
+	if (!trace->inst)
+		goto destroy_instance;
+
+	trace->tep = tracefs_local_events(NULL);
+	if (!trace->tep)
+		goto destroy_instance;
+
+	/*
+	 * register for both monitors, it is free.
+	 */
+	tep_register_event_handler(trace->tep, -1, "rv", "event_safe_wtd",
+				   handle_safe_wtd_rv_event, trace);
+	tracefs_event_enable(trace->inst, "rv", "event_safe_wtd");
+
+	return trace;
+
+destroy_instance:
+	trace_instance_destroy(trace);
+	return NULL;
+}
+
+/*
+ * ==================================================================
+ * The code section bellow are helper functions to use a watchdog device.
+ * ==================================================================
+ */
+
+/*
+ * set_nowayout - set the watchdog's nowayout option
+ */
+static int set_nowayout(char *nowayout_path)
+{
+	int nowayout_fd;
+	int retval;
+
+	print_msg("nowayout\n");
+
+	nowayout_fd = open(nowayout_path, O_WRONLY);
+	if (nowayout_path < 0) {
+		perror("Error opening nowayout fd");
+		return -1;
+	}
+
+	retval = write(nowayout_fd, "1", 1);
+	if (retval != 1) {
+		perror("Error setting nowayout");
+		close(nowayout_fd);
+		return -1;
+	}
+
+	close(nowayout_fd);
+	return 0;
+}
+
+/*
+ * open_watchdog - open watchdog at the watchdog_path
+ */
+static int open_watchdog(char *watchdog_path)
+{
+	int watchdog_fd;
+
+	print_msg("open %s\n", watchdog_path);
+
+	watchdog_fd = open(watchdog_path, O_WRONLY);
+	if (watchdog_fd < 0) {
+		perror("Error opening watchdog");
+		return -1;
+	}
+
+	return watchdog_fd;
+}
+
+/*
+ * set_timeout - set the timeout in seconds for the previously opened watchdog_fd
+ */
+static int set_timeout(int watchdog_fd, int timeout)
+{
+	int retval;
+
+	print_msg("set_timeout %d\n", timeout);
+
+	retval = ioctl(watchdog_fd, WDIOC_SETTIMEOUT, &timeout);
+	if (retval) {
+		perror("Error set_timeout");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * ping - ping (or pet) the watchdog
+ */
+static int ping(int watchdog_fd)
+{
+	int retval;
+
+	print_msg("ping\n");
+
+	retval = write(watchdog_fd, "1", 1);
+	if (retval != 1) {
+		perror("Error resseting watchdog");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * stop - try to the watchdog
+ *
+ * Writing "V" to the watchdog is a special case. Unless nowayout is set,
+ * it will stop the watchdog device.
+ */
+static void stop(int watchdog_fd)
+{
+	int retval;
+
+	print_msg("stop\n");
+
+	retval = write(watchdog_fd, "V", 1);
+	if (retval != 1)
+		perror("Error disabling the watchdog");
+}
+
+/*
+ * usage - print usage message
+ */
+static void usage(char *usage, int exitval)
+{
+	int i;
+
+	static const char * const msg[] = {
+		"  usage: safety_app [-i id] [-t timeout in seconds ] [-n nowayout_path] \\",
+		"			[-c cycles] [-p period] [-N] \\",
+		"			[-N] [-r reactor] [-s] [-R] \\",
+		"			[-h] \\",
+		"",
+		"Watchdog options",
+		"	-i/--id:		watchdog id",
+		"	-t/--timeout:		watchdog timeout",
+		"	-n/--nowayout:		set nowayout",
+		"",
+		"Safety monitor options",
+		"	-c/--cycles:		run cycle nr ping, 0 means forever (default)",
+		"	-p/--period:		monitor loop period",
+		"",
+		"RV monitor options",
+		"	-r/--reactor		set the reactor (panic is automatically set if no other reactor is passed)",
+		"	-s/--stop-mon		stop the rv monitor at the end of the execution",
+		"	-R/--restart-mon	restart the monitor if already started",
+		"",
+		"Generic options",
+		"	-h/--help:		print help message",
+		NULL,
+	};
+
+	if (usage)
+		fprintf(stderr, "%s\n", usage);
+
+	fprintf(stderr, "sample safety monitor (version %s)\n", VERSION);
+
+	for (i = 0; msg[i]; i++)
+		fprintf(stderr, "%s\n", msg[i]);
+	exit(exitval);
+}
+
+static long long get_long_from_str(char *start)
+{
+	long value;
+	char *end;
+
+	errno = 0;
+	value = strtoll(start, &end, 10);
+	if (errno || start == end) {
+		fprintf(stderr, "Invalid value '%s'", start);
+		return -1;
+	}
+
+	return value;
+}
+
+static int parse_args(int argc, char **argv)
+{
+	int c;
+
+	while (1) {
+		static struct option long_options[] = {
+			{"help",		no_argument,		0, 'h'},
+			{"id",			required_argument,	0, 'i'},
+			{"timeout",		required_argument,	0, 't'},
+			{"nowayout",		optional_argument,	0, 'n'},
+			{"cycles",		required_argument,	0, 'c'},
+			{"period",		required_argument,	0, 'p'},
+			{"reactor",		required_argument,	0, 'r'},
+			{"stop-mon",		no_argument,		0, 's'},
+			{"restart-mon",		no_argument,		0, 'R'},
+			{0, 0, 0, 0}
+		};
+
+		/* getopt_long stores the option index here. */
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, "hi:t:n::c:p:r:sR",
+				 long_options, &option_index);
+
+		/* Detect the end of the options. */
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'i':
+			config_watchdog_id = get_long_from_str(optarg);
+			break;
+		case 't':
+			config_timeout = get_long_from_str(optarg);
+			break;
+		case 'n':
+			config_nowayout = 1;
+			if (optarg)
+				strncpy(config_nowayout_path, optarg, MAX_PATH);
+			break;
+		case 'c':
+			config_cycles = get_long_from_str(optarg);
+			break;
+		case 'p':
+			config_monitor_period = get_long_from_str(optarg);
+			break;
+		case 'r':
+			config_rv_reactor = optarg;
+			break;
+		case 's':
+			config_stop_monitor = 1;
+			break;
+		case 'R':
+			config_restart_monitor = 1;
+			break;
+		case 'h':
+			usage("Help message", 0);
+			break;
+		default:
+			usage("Invalid option", 1);
+		}
+	}
+
+	if (!strlen(config_nowayout_path)) {
+		snprintf(config_nowayout_path, MAX_PATH,
+			 "/sys/devices/virtual/watchdog/watchdog%i/nowayout",
+			 config_watchdog_id);
+	}
+
+	if (config_monitor_period > config_timeout)
+		usage("Monitor period higher than the watchdog timeout.\n", 1);
+
+	snprintf(config_watchdog_path, MAX_PATH, "/dev/watchdog%d", config_watchdog_id);
+
+	return 0;
+}
+
+/*
+ * safety_check - check if the system is working properly
+ *
+ * This is the function where the system check will be actually done.
+ * It will be periodically called by the safety_app. If it returns
+ * true, the watchdog will be pinged and the system will continue running.
+ * If this function returns false, the safety_app will not ping the
+ * watchdog and will exit with an error.
+ */
+static int safety_check(void)
+{
+	/*
+	 * Add your code here.
+	 *
+	 * Return 0 to make the safety monitor to skip the watchdog ping and
+	 * exit with error, or just kill the system yourself.
+	 */
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	struct trace_instance *trace;
+	int exit_val = 1;
+	int watchdog_fd;
+	long cycles = 0;
+	int retval;
+
+	parse_args(argc, argv);
+
+	trace = trace_instance_init();
+
+	retval = enable_rv_monitor(config_rv_monitor, config_rv_reactor);
+	if (retval) {
+		perror("Cannot proceed without the RV monitor");
+		goto out_destroy_trace;
+	}
+
+	if (config_nowayout)
+		set_nowayout(config_nowayout_path);
+
+	watchdog_fd = open_watchdog(config_watchdog_path);
+	if (watchdog_fd < 0) {
+		perror("Error opening watchdog");
+		exit(1);
+	}
+
+	if (config_timeout) {
+		retval = set_timeout(watchdog_fd, config_timeout);
+		if (retval)
+			goto out_close_watchdog;
+	}
+
+	retval = check_rv_events(trace);
+	if (retval) {
+		print_msg("RV monitor returned a failure, it is not safe to continue\n");
+		goto out_close_watchdog;
+	}
+
+	do {
+		retval = safety_check();
+		if (!retval)
+			goto out_close_watchdog;
+
+		retval = ping(watchdog_fd);
+		if (retval)
+			goto out_close_watchdog;
+
+		retval = check_rv_events(trace);
+		if (retval) {
+			print_msg("RV monitor returned a failure, it is not safe to continue\n");
+			goto out_close_watchdog;
+		}
+
+		sleep(config_monitor_period);
+	} while (!config_cycles || ++cycles < config_cycles);
+
+	stop(watchdog_fd);
+
+	exit_val = 0;
+
+out_close_watchdog:
+	close(watchdog_fd);
+	disable_rv_monitor(config_rv_monitor);
+out_destroy_trace:
+	trace_instance_destroy(trace);
+	return exit_val;
+}
-- 
2.35.1

