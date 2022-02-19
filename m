Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFCA4BC432
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbiBSA6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:58:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbiBSAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CCA27AA08
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9260061F8A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700E8C340ED;
        Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1q-0051d1-Kp;
        Fri, 18 Feb 2022 19:55:14 -0500
Message-ID: <20220219005514.487353331@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 12/16] user_events: Add self-test for dynamic_events integration
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

Tests matching deletes, creation of basic and complex types. Ensures
common patterns work correctly when interacting with dynamic_events
file.

Link: https://lkml.kernel.org/r/20220118204326.2169-9-beaub@linux.microsoft.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.34.1
