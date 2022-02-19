Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E829B4BC430
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbiBSA54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:57:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbiBSAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA227993D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72DFF61FCC
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422F2C340FA;
        Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1q-0051cR-El;
        Fri, 18 Feb 2022 19:55:14 -0500
Message-ID: <20220219005514.286404647@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 11/16] user_events: Add self-test for ftrace integration
References: <20220219005430.848118506@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Tests basic functionality of registering/deregistering, status and
writing data out via ftrace mechanisms within user_events.

Link: https://lkml.kernel.org/r/20220118204326.2169-8-beaub@linux.microsoft.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/user_events/Makefile  |   9 +
 .../selftests/user_events/ftrace_test.c       | 387 ++++++++++++++++++
 tools/testing/selftests/user_events/settings  |   1 +
 3 files changed, 397 insertions(+)
 create mode 100644 tools/testing/selftests/user_events/Makefile
 create mode 100644 tools/testing/selftests/user_events/ftrace_test.c
 create mode 100644 tools/testing/selftests/user_events/settings

diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
new file mode 100644
index 000000000000..d66c551a6fe3
--- /dev/null
+++ b/tools/testing/selftests/user_events/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wl,-no-as-needed -Wall -I../../../../usr/include
+LDLIBS += -lrt -lpthread -lm
+
+TEST_GEN_PROGS = ftrace_test
+
+TEST_FILES := settings
+
+include ../lib.mk
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
new file mode 100644
index 000000000000..68010fd7b719
--- /dev/null
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * User Events FTrace Test Program
+ *
+ * Copyright (c) 2021 Beau Belgrave <beaub@linux.microsoft.com>
+ */
+
+#include <errno.h>
+#include <linux/user_events.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
+const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
+const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/enable";
+const char *trace_file = "/sys/kernel/debug/tracing/trace";
+const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
+
+static int trace_bytes(void)
+{
+	int fd = open(trace_file, O_RDONLY);
+	char buf[256];
+	int bytes = 0, got;
+
+	if (fd == -1)
+		return -1;
+
+	while (true) {
+		got = read(fd, buf, sizeof(buf));
+
+		if (got == -1)
+			return -1;
+
+		if (got == 0)
+			break;
+
+		bytes += got;
+	}
+
+	close(fd);
+
+	return bytes;
+}
+
+static int skip_until_empty_line(FILE *fp)
+{
+	int c, last = 0;
+
+	while (true) {
+		c = getc(fp);
+
+		if (c == EOF)
+			break;
+
+		if (last == '\n' && c == '\n')
+			return 0;
+
+		last = c;
+	}
+
+	return -1;
+}
+
+static int get_print_fmt(char *buffer, int len)
+{
+	FILE *fp = fopen(fmt_file, "r");
+	char *newline;
+
+	if (!fp)
+		return -1;
+
+	/* Read until empty line (Skip Common) */
+	if (skip_until_empty_line(fp) < 0)
+		goto err;
+
+	/* Read until empty line (Skip Properties) */
+	if (skip_until_empty_line(fp) < 0)
+		goto err;
+
+	/* Read in print_fmt: */
+	if (fgets(buffer, len, fp) == NULL)
+		goto err;
+
+	newline = strchr(buffer, '\n');
+
+	if (newline)
+		*newline = '\0';
+
+	fclose(fp);
+
+	return 0;
+err:
+	fclose(fp);
+
+	return -1;
+}
+
+static int clear(void)
+{
+	int fd = open(data_file, O_RDWR);
+
+	if (fd == -1)
+		return -1;
+
+	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
+		if (errno != ENOENT)
+			return -1;
+
+	close(fd);
+
+	return 0;
+}
+
+static int check_print_fmt(const char *event, const char *expected)
+{
+	struct user_reg reg = {0};
+	char print_fmt[256];
+	int ret;
+	int fd;
+
+	/* Ensure cleared */
+	ret = clear();
+
+	if (ret != 0)
+		return ret;
+
+	fd = open(data_file, O_RDWR);
+
+	if (fd == -1)
+		return fd;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)event;
+
+	/* Register should work */
+	ret = ioctl(fd, DIAG_IOCSREG, &reg);
+
+	close(fd);
+
+	if (ret != 0)
+		return ret;
+
+	/* Ensure correct print_fmt */
+	ret = get_print_fmt(print_fmt, sizeof(print_fmt));
+
+	if (ret != 0)
+		return ret;
+
+	return strcmp(print_fmt, expected);
+}
+
+FIXTURE(user) {
+	int status_fd;
+	int data_fd;
+	int enable_fd;
+};
+
+FIXTURE_SETUP(user) {
+	self->status_fd = open(status_file, O_RDONLY);
+	ASSERT_NE(-1, self->status_fd);
+
+	self->data_fd = open(data_file, O_RDWR);
+	ASSERT_NE(-1, self->data_fd);
+
+	self->enable_fd = -1;
+}
+
+FIXTURE_TEARDOWN(user) {
+	close(self->status_fd);
+	close(self->data_fd);
+
+	if (self->enable_fd != -1) {
+		write(self->enable_fd, "0", sizeof("0"));
+		close(self->enable_fd);
+	}
+
+	ASSERT_EQ(0, clear());
+}
+
+TEST_F(user, register_events) {
+	struct user_reg reg = {0};
+	int page_size = sysconf(_SC_PAGESIZE);
+	char *status_page;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
+
+	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
+			   self->status_fd, 0);
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_NE(0, reg.status_index);
+
+	/* Multiple registers should result in same index */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_NE(0, reg.status_index);
+
+	/* Ensure disabled */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, self->enable_fd);
+	ASSERT_NE(-1, write(self->enable_fd, "0", sizeof("0")))
+
+	/* MMAP should work and be zero'd */
+	ASSERT_NE(MAP_FAILED, status_page);
+	ASSERT_NE(NULL, status_page);
+	ASSERT_EQ(0, status_page[reg.status_index]);
+
+	/* Enable event and ensure bits updated in status */
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+	ASSERT_EQ(EVENT_STATUS_FTRACE, status_page[reg.status_index]);
+
+	/* Disable event and ensure bits updated in status */
+	ASSERT_NE(-1, write(self->enable_fd, "0", sizeof("0")))
+	ASSERT_EQ(0, status_page[reg.status_index]);
+
+	/* File still open should return -EBUSY for delete */
+	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSDEL, "__test_event"));
+	ASSERT_EQ(EBUSY, errno);
+
+	/* Delete should work only after close */
+	close(self->data_fd);
+	self->data_fd = open(data_file, O_RDWR);
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSDEL, "__test_event"));
+
+	/* Unmap should work */
+	ASSERT_EQ(0, munmap(status_page, page_size));
+}
+
+TEST_F(user, write_events) {
+	struct user_reg reg = {0};
+	struct iovec io[3];
+	__u32 field1, field2;
+	int before = 0, after = 0;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
+
+	field1 = 1;
+	field2 = 2;
+
+	io[0].iov_base = &reg.write_index;
+	io[0].iov_len = sizeof(reg.write_index);
+	io[1].iov_base = &field1;
+	io[1].iov_len = sizeof(field1);
+	io[2].iov_base = &field2;
+	io[2].iov_len = sizeof(field2);
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_NE(0, reg.status_index);
+
+	/* Write should fail on invalid slot with ENOENT */
+	io[0].iov_base = &field2;
+	io[0].iov_len = sizeof(field2);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(ENOENT, errno);
+	io[0].iov_base = &reg.write_index;
+	io[0].iov_len = sizeof(reg.write_index);
+
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
+	/* Write should make it out to ftrace buffers */
+	before = trace_bytes();
+	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	after = trace_bytes();
+	ASSERT_GT(after, before);
+}
+
+TEST_F(user, write_fault) {
+	struct user_reg reg = {0};
+	struct iovec io[2];
+	int l = sizeof(__u64);
+	void *anon;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event u64 anon";
+
+	anon = mmap(NULL, l, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, anon);
+
+	io[0].iov_base = &reg.write_index;
+	io[0].iov_len = sizeof(reg.write_index);
+	io[1].iov_base = anon;
+	io[1].iov_len = l;
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_NE(0, reg.status_index);
+
+	/* Write should work normally */
+	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
+
+	/* Faulted data should zero fill and work */
+	ASSERT_EQ(0, madvise(anon, l, MADV_DONTNEED));
+	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
+	ASSERT_EQ(0, munmap(anon, l));
+}
+
+TEST_F(user, print_fmt) {
+	int ret;
+
+	ret = check_print_fmt("__test_event __rel_loc char[] data",
+			      "print fmt: \"data=%s\", __get_rel_str(data)");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event __data_loc char[] data",
+			      "print fmt: \"data=%s\", __get_str(data)");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event s64 data",
+			      "print fmt: \"data=%lld\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event u64 data",
+			      "print fmt: \"data=%llu\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event s32 data",
+			      "print fmt: \"data=%d\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event u32 data",
+			      "print fmt: \"data=%u\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event int data",
+			      "print fmt: \"data=%d\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event unsigned int data",
+			      "print fmt: \"data=%u\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event s16 data",
+			      "print fmt: \"data=%d\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event u16 data",
+			      "print fmt: \"data=%u\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event short data",
+			      "print fmt: \"data=%d\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event unsigned short data",
+			      "print fmt: \"data=%u\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event s8 data",
+			      "print fmt: \"data=%d\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event u8 data",
+			      "print fmt: \"data=%u\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event char data",
+			      "print fmt: \"data=%d\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event unsigned char data",
+			      "print fmt: \"data=%u\", REC->data");
+	ASSERT_EQ(0, ret);
+
+	ret = check_print_fmt("__test_event char[4] data",
+			      "print fmt: \"data=%s\", REC->data");
+	ASSERT_EQ(0, ret);
+}
+
+int main(int argc, char **argv)
+{
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/user_events/settings b/tools/testing/selftests/user_events/settings
new file mode 100644
index 000000000000..ba4d85f74cd6
--- /dev/null
+++ b/tools/testing/selftests/user_events/settings
@@ -0,0 +1 @@
+timeout=90
-- 
2.34.1
