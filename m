Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9900B4BC464
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiBSA56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:57:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbiBSAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA7E27AA2B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C16B261FD6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02CFC340F1;
        Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1q-0051da-Qs;
        Fri, 18 Feb 2022 19:55:14 -0500
Message-ID: <20220219005514.665980288@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 13/16] user_events: Add self-test for perf_event integration
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

Tests perf can be attached to and written out correctly. Ensures attach
updates status bits in user programs.

Link: https://lkml.kernel.org/r/20220118204326.2169-10-beaub@linux.microsoft.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.34.1
