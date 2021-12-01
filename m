Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FC465565
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbhLAS3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:29:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48048 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352396AbhLAS2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:28:43 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id D8D5B20E61D0;
        Wed,  1 Dec 2021 10:25:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8D5B20E61D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638383122;
        bh=SqyYnQcvf7MyDNXcqWgsiVSGlLtQbs0OIC1cy+Yas/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDLveKwqx1vtd0bk1dyZrwHbsTNakGFaNMM39ZZhCSOTNQcPUvn2Hrc0NOETPxwGN
         YWxVAa3nA+hto2owKG32wVJGA7jtfp6qjC/f5/lUruLaWxo1nx/NNC+tJ+u3pJMSip
         lNY6TWu5rpESz4tI3L3RhDKFG0qtEa8pRxJ2CtuE=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v6 13/13] user_events: Use __get_rel_str for relative string fields
Date:   Wed,  1 Dec 2021 10:25:15 -0800
Message-Id: <20211201182515.2446-14-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201182515.2446-1-beaub@linux.microsoft.com>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch between __get_str and __get_rel_str within the print_fmt of
user_events. Add unit test to ensure print_fmt is correct on known
types.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c              |  24 ++-
 .../selftests/user_events/ftrace_test.c       | 166 ++++++++++++++++++
 2 files changed, 182 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b487d02acedf..2b47e7b11c3d 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -257,7 +257,7 @@ static int user_event_add_field(struct user_event *user, const char *type,
 	goto add_field;
 
 add_validator:
-	if (strstr(type, "char[") != 0)
+	if (strstr(type, "char") != 0)
 		validator_flags |= VALIDATOR_ENSURE_NULL;
 
 	validator = kmalloc(sizeof(*validator), GFP_KERNEL);
@@ -456,14 +456,21 @@ static const char *user_field_format(const char *type)
 	return "%llu";
 }
 
-static bool user_field_is_dyn_string(const char *type)
+static bool user_field_is_dyn_string(const char *type, const char **str_func)
 {
-	if (str_has_prefix(type, "__data_loc ") ||
-	    str_has_prefix(type, "__rel_loc "))
-		if (strstr(type, "char[") != 0)
-			return true;
+	if (str_has_prefix(type, "__data_loc ")) {
+		*str_func = "__get_str";
+		goto check;
+	}
+
+	if (str_has_prefix(type, "__rel_loc ")) {
+		*str_func = "__get_rel_str";
+		goto check;
+	}
 
 	return false;
+check:
+	return strstr(type, "char") != 0;
 }
 
 #define LEN_OR_ZERO (len ? len - pos : 0)
@@ -472,6 +479,7 @@ static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
 	struct ftrace_event_field *field, *next;
 	struct list_head *head = &user->fields;
 	int pos = 0, depth = 0;
+	const char *str_func;
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
@@ -488,9 +496,9 @@ static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
 	list_for_each_entry_safe_reverse(field, next, head, link) {
-		if (user_field_is_dyn_string(field->type))
+		if (user_field_is_dyn_string(field->type, &str_func))
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
-					", __get_str(%s)", field->name);
+					", %s(%s)", str_func, field->name);
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 					", REC->%s", field->name);
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 16aff1fb295a..b2e5c0765a68 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -20,6 +20,7 @@ const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
 const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
 const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/enable";
 const char *trace_file = "/sys/kernel/debug/tracing/trace";
+const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
 
 static int trace_bytes(void)
 {
@@ -47,6 +48,61 @@ static int trace_bytes(void)
 	return bytes;
 }
 
+static int get_print_fmt(char *buffer, int len)
+{
+	FILE *fp = fopen(fmt_file, "r");
+	int c, index = 0, last = 0;
+
+	if (!fp)
+		return -1;
+
+	/* Read until empty line (Skip Common) */
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
+	last = 0;
+
+	/* Read until empty line (Skip Properties) */
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
+	/* Read in print_fmt: */
+	while (len > 1) {
+		c = getc(fp);
+
+		if (c == EOF || c == '\n')
+			break;
+
+		buffer[index++] = c;
+
+		len--;
+	}
+
+	buffer[index] = 0;
+
+	fclose(fp);
+
+	return 0;
+}
+
 static int clear(void)
 {
 	int fd = open(data_file, O_RDWR);
@@ -63,6 +119,44 @@ static int clear(void)
 	return 0;
 }
 
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
 FIXTURE(user) {
 	int status_fd;
 	int data_fd;
@@ -282,6 +376,78 @@ TEST_F(user, write_validator) {
 	ASSERT_EQ(EFAULT, errno);
 }
 
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
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);
-- 
2.17.1

