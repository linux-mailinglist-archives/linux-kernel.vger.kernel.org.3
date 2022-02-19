Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B92F4BC469
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiBSA4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:56:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiBSAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA427AA37
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE8A361FEE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC17DC340ED;
        Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1r-0051e9-0j;
        Fri, 18 Feb 2022 19:55:15 -0500
Message-ID: <20220219005514.857711157@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 14/16] user_events: Add self-test for validator boundaries
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

Tests to ensure validator boundary cases are working correctly within
close and far bounds. Ensures __data_loc and __rel_loc strings are
null terminated and within range. Ensures min size checks work as
expected.

Link: https://lkml.kernel.org/r/20220118204326.2169-11-beaub@linux.microsoft.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.34.1
