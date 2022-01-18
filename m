Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F59492FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349638AbiARUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:44:28 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43836 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348663AbiARUnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:43:32 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88D6D20B9281;
        Tue, 18 Jan 2022 12:43:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88D6D20B9281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642538612;
        bh=qQeZEyXlr6ZK07nGwq0BUMOhF74ViprZftDqYTszTz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3TyAcO+uQIyJs7rOLJmI6Igyfpd/PEx/xVlodRb42j2/pRpxmyNN2BWSUAPrhC2z
         /5sKKPuII6VvWfcuIbDWt8BVt4K0ICSIPc/w9LZ7lzCDTbozGiB4Dgiyarfxhn4bwT
         847ERl5UZKPXKkT0gbtcPr/kbSUP5/1cFe6VhGCM=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v10 09/12] user_events: Add self-test for perf_event integration
Date:   Tue, 18 Jan 2022 12:43:23 -0800
Message-Id: <20220118204326.2169-10-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118204326.2169-1-beaub@linux.microsoft.com>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests perf can be attached to and written out correctly. Ensures attach
updates status bits in user programs.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 tools/testing/selftests/user_events/Makefile  |   2 +-
 .../testing/selftests/user_events/perf_test.c | 168 ++++++++++++++++++
 2 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/user_events/perf_test.c

diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
index e824b9c2cae7..c765d8635d9a 100644
--- a/tools/testing/selftests/user_events/Makefile
+++ b/tools/testing/selftests/user_events/Makefile
@@ -2,7 +2,7 @@
 CFLAGS += -Wl,-no-as-needed -Wall -I../../../../usr/include
 LDLIBS += -lrt -lpthread -lm
 
-TEST_GEN_PROGS = ftrace_test dyn_test
+TEST_GEN_PROGS = ftrace_test dyn_test perf_test
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
new file mode 100644
index 000000000000..26851d51d6bb
--- /dev/null
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * User Events Perf Events Test Program
+ *
+ * Copyright (c) 2021 Beau Belgrave <beaub@linux.microsoft.com>
+ */
+
+#include <errno.h>
+#include <linux/user_events.h>
+#include <linux/perf_event.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <asm/unistd.h>
+
+#include "../kselftest_harness.h"
+
+const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
+const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
+const char *id_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/id";
+const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
+
+struct event {
+	__u32 index;
+	__u32 field1;
+	__u32 field2;
+};
+
+static long perf_event_open(struct perf_event_attr *pe, pid_t pid,
+			    int cpu, int group_fd, unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, pe, pid, cpu, group_fd, flags);
+}
+
+static int get_id(void)
+{
+	FILE *fp = fopen(id_file, "r");
+	int ret, id = 0;
+
+	if (!fp)
+		return -1;
+
+	ret = fscanf(fp, "%d", &id);
+	fclose(fp);
+
+	if (ret != 1)
+		return -1;
+
+	return id;
+}
+
+static int get_offset(void)
+{
+	FILE *fp = fopen(fmt_file, "r");
+	int ret, c, last = 0, offset = 0;
+
+	if (!fp)
+		return -1;
+
+	/* Read until empty line */
+	while (true) {
+		c = getc(fp);
+
+		if (c == EOF)
+			break;
+
+		if (last == '\n' && c == '\n')
+			break;
+
+		last = c;
+	}
+
+	ret = fscanf(fp, "\tfield:u32 field1;\toffset:%d;", &offset);
+	fclose(fp);
+
+	if (ret != 1)
+		return -1;
+
+	return offset;
+}
+
+FIXTURE(user) {
+	int status_fd;
+	int data_fd;
+};
+
+FIXTURE_SETUP(user) {
+	self->status_fd = open(status_file, O_RDONLY);
+	ASSERT_NE(-1, self->status_fd);
+
+	self->data_fd = open(data_file, O_RDWR);
+	ASSERT_NE(-1, self->data_fd);
+}
+
+FIXTURE_TEARDOWN(user) {
+	close(self->status_fd);
+	close(self->data_fd);
+}
+
+TEST_F(user, perf_write) {
+	struct perf_event_attr pe = {0};
+	struct user_reg reg = {0};
+	int page_size = sysconf(_SC_PAGESIZE);
+	char *status_page;
+	struct event event;
+	struct perf_event_mmap_page *perf_page;
+	int id, fd, offset;
+	__u32 *val;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
+
+	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
+			   self->status_fd, 0);
+	ASSERT_NE(MAP_FAILED, status_page);
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_NE(0, reg.status_index);
+	ASSERT_EQ(0, status_page[reg.status_index]);
+
+	/* Id should be there */
+	id = get_id();
+	ASSERT_NE(-1, id);
+	offset = get_offset();
+	ASSERT_NE(-1, offset);
+
+	pe.type = PERF_TYPE_TRACEPOINT;
+	pe.size = sizeof(pe);
+	pe.config = id;
+	pe.sample_type = PERF_SAMPLE_RAW;
+	pe.sample_period = 1;
+	pe.wakeup_events = 1;
+
+	/* Tracepoint attach should work */
+	fd = perf_event_open(&pe, 0, -1, -1, 0);
+	ASSERT_NE(-1, fd);
+
+	perf_page = mmap(NULL, page_size * 2, PROT_READ, MAP_SHARED, fd, 0);
+	ASSERT_NE(MAP_FAILED, perf_page);
+
+	/* Status should be updated */
+	ASSERT_EQ(EVENT_STATUS_PERF, status_page[reg.status_index]);
+
+	event.index = reg.write_index;
+	event.field1 = 0xc001;
+	event.field2 = 0xc01a;
+
+	/* Ensure write shows up at correct offset */
+	ASSERT_NE(-1, write(self->data_fd, &event, sizeof(event)));
+	val = (void *)(((char *)perf_page) + perf_page->data_offset);
+	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);
+	/* Skip over header and size, move to offset */
+	val += 3;
+	val = (void *)((char *)val) + offset;
+	/* Ensure correct */
+	ASSERT_EQ(event.field1, *val++);
+	ASSERT_EQ(event.field2, *val++);
+}
+
+int main(int argc, char **argv)
+{
+	return test_harness_run(argc, argv);
+}
-- 
2.17.1

