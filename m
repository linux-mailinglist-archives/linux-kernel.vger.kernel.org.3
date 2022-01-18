Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACB492F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349560AbiARUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:44:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348787AbiARUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:43:33 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id BFEF720B9282;
        Tue, 18 Jan 2022 12:43:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFEF720B9282
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642538612;
        bh=4rS/OSFoB8cwnQ1Ju8K30aEaSCCMQ6qX3sGGO0R79Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1aDFagqaP0r3NhbB/8mOF7fwCX70uLL9b8jEdORxR7E0amxumgvrbGLEpbXP3hwU
         PJbVjqv9E6zbLdn9ciMXa0X5qe35QC9PlAfNQas03Zf88CWl8i8L6IBgPvVRxHoT8e
         C2MnZ457CR5fwVx8MHxdtkz+z/TITXyKw8mD4Yyo=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v10 10/12] user_events: Add self-test for validator boundaries
Date:   Tue, 18 Jan 2022 12:43:24 -0800
Message-Id: <20220118204326.2169-11-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118204326.2169-1-beaub@linux.microsoft.com>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests to ensure validator boundary cases are working correctly within
close and far bounds. Ensures __data_loc and __rel_loc strings are
null terminated and within range. Ensures min size checks work as
expected.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 .../selftests/user_events/ftrace_test.c       | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 68010fd7b719..a80fb5ef61d5 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -309,6 +309,71 @@ TEST_F(user, write_fault) {
 	ASSERT_EQ(0, munmap(anon, l));
 }
 
+TEST_F(user, write_validator) {
+	struct user_reg reg = {0};
+	struct iovec io[3];
+	int loc, bytes;
+	char data[8];
+	int before = 0, after = 0;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event __rel_loc char[] data";
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_NE(0, reg.status_index);
+
+	io[0].iov_base = &reg.write_index;
+	io[0].iov_len = sizeof(reg.write_index);
+	io[1].iov_base = &loc;
+	io[1].iov_len = sizeof(loc);
+	io[2].iov_base = data;
+	bytes = snprintf(data, sizeof(data), "Test") + 1;
+	io[2].iov_len = bytes;
+
+	/* Undersized write should fail */
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 1));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
+	/* Full in-bounds write should work */
+	before = trace_bytes();
+	loc = DYN_LOC(0, bytes);
+	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	after = trace_bytes();
+	ASSERT_GT(after, before);
+
+	/* Out of bounds write should fault (offset way out) */
+	loc = DYN_LOC(1024, bytes);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+
+	/* Out of bounds write should fault (offset 1 byte out) */
+	loc = DYN_LOC(1, bytes);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+
+	/* Out of bounds write should fault (size way out) */
+	loc = DYN_LOC(0, bytes + 1024);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+
+	/* Out of bounds write should fault (size 1 byte out) */
+	loc = DYN_LOC(0, bytes + 1);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+
+	/* Non-Null should fault */
+	memset(data, 'A', sizeof(data));
+	loc = DYN_LOC(0, bytes);
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EFAULT, errno);
+}
+
 TEST_F(user, print_fmt) {
 	int ret;
 
-- 
2.17.1

