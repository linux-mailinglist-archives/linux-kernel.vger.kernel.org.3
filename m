Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8008146555C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352435AbhLAS3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:29:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48014 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352374AbhLAS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:28:41 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 719A420E581E;
        Wed,  1 Dec 2021 10:25:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 719A420E581E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638383120;
        bh=+mXlG14gdSajYN3+Eq9v1QgIph4+8rvSCzU2C5qR0zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fiu+8YkKdGTyVK+BxwOmc23aanCDqFRtV6QSnwPZuWny3cwFDN47ABD2nmT/Yt6iN
         jnyVGPdQsZz1AjX2yWzq/Xc3563IMmOOAwG3+6fovMgrsXxYN0z9UjXaZudhOVQtDq
         dWkUfBex70NVEzRUypuoEi+KYfLNlFdpuXQN79CY=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v6 06/13] user_events: Add self-test for ftrace integration
Date:   Wed,  1 Dec 2021 10:25:08 -0800
Message-Id: <20211201182515.2446-7-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201182515.2446-1-beaub@linux.microsoft.com>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests basic functionality of registering/deregistering, status and
writing data out via ftrace mechanisms within user_events.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 tools/testing/selftests/user_events/Makefile  |   9 +
 .../selftests/user_events/ftrace_test.c       | 205 ++++++++++++++++++
 tools/testing/selftests/user_events/settings  |   1 +
 3 files changed, 215 insertions(+)
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
index 000000000000..9d53717139e6
--- /dev/null
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -0,0 +1,205 @@
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
2.17.1

