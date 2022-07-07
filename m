Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6556AE0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiGGV66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiGGV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:58:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4CAA1FCF0;
        Thu,  7 Jul 2022 14:58:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9F35D20A898B;
        Thu,  7 Jul 2022 14:58:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F35D20A898B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657231113;
        bh=5eRwg6MlWo573EnBgxRRM6VTU+gEpz5q8Hd5iRDGIg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAGaH+zJux+CTe5wuTi7Z0Z5bZ/tsNOE6BjHn6cXeCLhHJKrFSelBUlCabQk8dV3K
         UVb6/MO1pybGObD9Nr/RwBFtQIVA/xdQ9i16PN2Eu9HDGCENTEqQv8xyAaCkUgXr5u
         ecRlkZFOn1uJCoGAQm04dMC2UKG45SAzPUFk4CC4=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] tracing/user_events: Add self-test for namespace integration
Date:   Thu,  7 Jul 2022 14:58:28 -0700
Message-Id: <20220707215828.2021-8-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707215828.2021-1-beaub@linux.microsoft.com>
References: <20220707215828.2021-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests to ensure namespace cases are working correctly. Ensures that
namespaces work as before for status/write cases and validates removing
a namespace with open files, tracing enabled, etc.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 .../selftests/user_events/ftrace_test.c       | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 404a2713dcae..5d384c1b31c4 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -22,6 +22,16 @@ const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_e
 const char *trace_file = "/sys/kernel/debug/tracing/trace";
 const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
 
+const char *namespace_dir = "/sys/kernel/debug/tracing/namespaces/self_test";
+const char *ns_data_file = "/sys/kernel/debug/tracing/namespaces/self_test/"
+			   "root/user_events_data";
+const char *ns_status_file = "/sys/kernel/debug/tracing/namespaces/self_test/"
+			     "root/user_events_status";
+const char *ns_enable_file = "/sys/kernel/debug/tracing/events/"
+			     "user_events.self_test/__test_event/enable";
+const char *ns_options_file = "/sys/kernel/debug/tracing/namespaces/self_test/"
+			      "options";
+
 static inline int status_check(char *status_page, int status_bit)
 {
 	return status_page[status_bit >> 3] & (1 << (status_bit & 7));
@@ -160,6 +170,53 @@ static int check_print_fmt(const char *event, const char *expected)
 	return strcmp(print_fmt, expected);
 }
 
+FIXTURE(ns) {
+	int status_fd;
+	int data_fd;
+	int enable_fd;
+	int options_fd;
+};
+
+FIXTURE_SETUP(ns) {
+	if (mkdir(namespace_dir, 770)) {
+		ASSERT_EQ(EEXIST, errno);
+	}
+
+	self->status_fd = open(ns_status_file, O_RDONLY);
+	ASSERT_NE(-1, self->status_fd);
+
+	self->data_fd = open(ns_data_file, O_RDWR);
+	ASSERT_NE(-1, self->data_fd);
+
+	self->options_fd = open(ns_options_file, O_RDWR);
+	ASSERT_NE(-1, self->options_fd);
+
+	self->enable_fd = -1;
+}
+
+FIXTURE_TEARDOWN(ns) {
+	if (self->status_fd != -1)
+		close(self->status_fd);
+
+	if (self->data_fd != -1)
+		close(self->data_fd);
+
+	if (self->options_fd != -1)
+		close(self->options_fd);
+
+	if (self->enable_fd != -1) {
+		write(self->enable_fd, "0", sizeof("0"));
+		close(self->enable_fd);
+		self->enable_fd = -1;
+	}
+
+	ASSERT_EQ(0, clear());
+
+	if (rmdir(namespace_dir)) {
+		ASSERT_EQ(ENOENT, errno);
+	}
+}
+
 FIXTURE(user) {
 	int status_fd;
 	int data_fd;
@@ -477,6 +534,99 @@ TEST_F(user, print_fmt) {
 	ASSERT_EQ(0, ret);
 }
 
+TEST_F(ns, namespaces) {
+	struct user_reg reg = {0};
+	struct iovec io[3];
+	__u32 field1, field2;
+	int before = 0, after = 0;
+	int page_size = sysconf(_SC_PAGESIZE);
+	char *status_page;
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
+	/* Limit to 1 event */
+	ASSERT_NE(-1, write(self->options_fd,
+			    "user_events_limit=1\n",
+			    sizeof("user_events_limit=1\n") - 1));
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_NE(0, reg.status_bit);
+
+	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
+			   self->status_fd, 0);
+
+	/* MMAP should work and be zero'd */
+	ASSERT_NE(MAP_FAILED, status_page);
+	ASSERT_NE(NULL, status_page);
+	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
+
+	/* Enable event (start tracing) */
+	self->enable_fd = open(ns_enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
+	/* Event should now be enabled */
+	ASSERT_NE(0, status_check(status_page, reg.status_bit));
+
+	/* Write should make it out to ftrace buffers */
+	before = trace_bytes();
+	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	after = trace_bytes();
+	ASSERT_GT(after, before);
+
+	/* Register above limit should fail */
+	reg.name_args = (__u64)"__test_event_nope u32 field1; u32 field2";
+	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(EMFILE, errno);
+
+	/* Removing namespace while files open should fail */
+	ASSERT_EQ(-1, rmdir(namespace_dir));
+
+	close(self->options_fd);
+	self->options_fd = -1;
+
+	/* Removing namespace while files open should fail */
+	ASSERT_EQ(-1, rmdir(namespace_dir));
+
+	close(self->status_fd);
+	self->status_fd = -1;
+
+	/* Removing namespace while files open should fail */
+	ASSERT_EQ(-1, rmdir(namespace_dir));
+
+	close(self->data_fd);
+	self->data_fd = -1;
+
+	/* Removing namespace while mmaps are open should fail */
+	ASSERT_EQ(-1, rmdir(namespace_dir));
+
+	/* Unmap */
+	ASSERT_EQ(0, munmap(status_page, page_size));
+
+	/* Removing namespace with no files but tracing should fail */
+	ASSERT_EQ(-1, rmdir(namespace_dir));
+
+	/* Disable event (stop tracing) */
+	ASSERT_NE(-1, write(self->enable_fd, "0", sizeof("0")))
+	close(self->enable_fd);
+	self->enable_fd = -1;
+
+	/* Removing namespace should now work */
+	ASSERT_EQ(0, rmdir(namespace_dir));
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);
-- 
2.25.1

