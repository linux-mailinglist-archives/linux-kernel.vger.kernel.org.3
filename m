Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E46465560
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352021AbhLAS3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:29:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48026 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352379AbhLAS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:28:42 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id A417220E61A9;
        Wed,  1 Dec 2021 10:25:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A417220E61A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638383120;
        bh=Nsy28iBGd9K5KoEvpu/5fcI1CXQFpgeu6V0nNpVTY/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKQA0y5Y7DykAFgfqWBjvNz05m6gyT5FEaA5sDkbocK/KMKIm41Mvhj2FGwUNUDyk
         Y32hCDQLHQjBEqh9QzdiwGTAq8C9Zpx/WcXj2Qgr9gbQCMUclu7K8WXB0Idws9F33M
         iSeWj/wW/+BbuAMS6hf/uLbxrIBHoL3HlfXyNqmc=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v6 07/13] user_events: Add self-test for dynamic_events integration
Date:   Wed,  1 Dec 2021 10:25:09 -0800
Message-Id: <20211201182515.2446-8-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201182515.2446-1-beaub@linux.microsoft.com>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests matching deletes, creation of basic and complex types. Ensures
common patterns work correctly when interacting with dynamic_events
file.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 tools/testing/selftests/user_events/Makefile  |   2 +-
 .../testing/selftests/user_events/dyn_test.c  | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/user_events/dyn_test.c

diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
index d66c551a6fe3..e824b9c2cae7 100644
--- a/tools/testing/selftests/user_events/Makefile
+++ b/tools/testing/selftests/user_events/Makefile
@@ -2,7 +2,7 @@
 CFLAGS += -Wl,-no-as-needed -Wall -I../../../../usr/include
 LDLIBS += -lrt -lpthread -lm
 
-TEST_GEN_PROGS = ftrace_test
+TEST_GEN_PROGS = ftrace_test dyn_test
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
new file mode 100644
index 000000000000..d6265d14cd51
--- /dev/null
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * User Events Dyn Events Test Program
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
+const char *dyn_file = "/sys/kernel/debug/tracing/dynamic_events";
+const char *clear = "!u:__test_event";
+
+static int Append(const char *value)
+{
+	int fd = open(dyn_file, O_RDWR | O_APPEND);
+	int ret = write(fd, value, strlen(value));
+
+	close(fd);
+	return ret;
+}
+
+#define CLEAR() \
+do { \
+	int ret = Append(clear); \
+	if (ret == -1) \
+		ASSERT_EQ(ENOENT, errno); \
+} while (0)
+
+#define TEST_PARSE(x) \
+do { \
+	ASSERT_NE(-1, Append(x)); \
+	CLEAR(); \
+} while (0)
+
+#define TEST_NPARSE(x) ASSERT_EQ(-1, Append(x))
+
+FIXTURE(user) {
+};
+
+FIXTURE_SETUP(user) {
+	CLEAR();
+}
+
+FIXTURE_TEARDOWN(user) {
+	CLEAR();
+}
+
+TEST_F(user, basic_types) {
+	/* All should work */
+	TEST_PARSE("u:__test_event u64 a");
+	TEST_PARSE("u:__test_event u32 a");
+	TEST_PARSE("u:__test_event u16 a");
+	TEST_PARSE("u:__test_event u8 a");
+	TEST_PARSE("u:__test_event char a");
+	TEST_PARSE("u:__test_event unsigned char a");
+	TEST_PARSE("u:__test_event int a");
+	TEST_PARSE("u:__test_event unsigned int a");
+	TEST_PARSE("u:__test_event short a");
+	TEST_PARSE("u:__test_event unsigned short a");
+	TEST_PARSE("u:__test_event char[20] a");
+	TEST_PARSE("u:__test_event unsigned char[20] a");
+	TEST_PARSE("u:__test_event char[0x14] a");
+	TEST_PARSE("u:__test_event unsigned char[0x14] a");
+	/* Bad size format should fail */
+	TEST_NPARSE("u:__test_event char[aa] a");
+	/* Large size should fail */
+	TEST_NPARSE("u:__test_event char[9999] a");
+	/* Long size string should fail */
+	TEST_NPARSE("u:__test_event char[0x0000000000001] a");
+}
+
+TEST_F(user, loc_types) {
+	/* All should work */
+	TEST_PARSE("u:__test_event __data_loc char[] a");
+	TEST_PARSE("u:__test_event __data_loc unsigned char[] a");
+	TEST_PARSE("u:__test_event __rel_loc char[] a");
+	TEST_PARSE("u:__test_event __rel_loc unsigned char[] a");
+}
+
+TEST_F(user, size_types) {
+	/* Should work */
+	TEST_PARSE("u:__test_event struct custom a 20");
+	/* Size not specified on struct should fail */
+	TEST_NPARSE("u:__test_event struct custom a");
+	/* Size specified on non-struct should fail */
+	TEST_NPARSE("u:__test_event char a 20");
+}
+
+TEST_F(user, flags) {
+	/* Should work */
+	TEST_PARSE("u:__test_event:BPF_ITER u32 a");
+	/* Forward compat */
+	TEST_PARSE("u:__test_event:BPF_ITER,FLAG_FUTURE u32 a");
+}
+
+TEST_F(user, matching) {
+	/* Register */
+	ASSERT_NE(-1, Append("u:__test_event struct custom a 20"));
+	/* Should not match */
+	TEST_NPARSE("!u:__test_event struct custom b");
+	/* Should match */
+	TEST_PARSE("!u:__test_event struct custom a");
+	/* Multi field reg */
+	ASSERT_NE(-1, Append("u:__test_event u32 a; u32 b"));
+	/* Non matching cases */
+	TEST_NPARSE("!u:__test_event u32 a");
+	TEST_NPARSE("!u:__test_event u32 b");
+	TEST_NPARSE("!u:__test_event u32 a; u32 ");
+	TEST_NPARSE("!u:__test_event u32 a; u32 a");
+	/* Matching case */
+	TEST_PARSE("!u:__test_event u32 a; u32 b");
+	/* Register */
+	ASSERT_NE(-1, Append("u:__test_event u32 a; u32 b"));
+	/* Ensure trailing semi-colon case */
+	TEST_PARSE("!u:__test_event u32 a; u32 b;");
+}
+
+int main(int argc, char **argv)
+{
+	return test_harness_run(argc, argv);
+}
-- 
2.17.1

