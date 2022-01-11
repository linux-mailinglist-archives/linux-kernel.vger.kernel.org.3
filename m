Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6548B3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbiAKRb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbiAKRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B1C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:31:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78C50B81C3D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4015BC36AF4;
        Tue, 11 Jan 2022 17:31:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzL-0032AT-Do;
        Tue, 11 Jan 2022 12:31:15 -0500
Message-ID: <20220111173115.271910572@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinan Liu <yinan@linux.alibaba.com>
Subject: [for-next][PATCH 11/31] ftrace: Add test to make sure compiled time sorts work
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that ftrace function pointers are sorted at compile time, add a test
that makes sure they are sorted at run time. This test is only run if it is
configured in.

Link: https://lkml.kernel.org/r/20211206151858.4d21a24d@gandalf.local.home

Cc: Yinan Liu <yinan@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig  | 14 ++++++++++++++
 kernel/trace/ftrace.c | 23 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 420ff4bc67fd..f468767bc287 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -915,6 +915,20 @@ config EVENT_TRACE_TEST_SYSCALLS
 	 TBD - enable a way to actually call the syscalls as we test their
 	       events
 
+config FTRACE_SORT_STARTUP_TEST
+       bool "Verify compile time sorting of ftrace functions"
+       depends on DYNAMIC_FTRACE
+       depends on BUILDTIME_TABLE_SORT
+       help
+	 Sorting of the mcount_loc sections that is used to find the
+	 where the ftrace knows where to patch functions for tracing
+	 and other callbacks is done at compile time. But if the sort
+	 is not done correctly, it will cause non-deterministic failures.
+	 When this is set, the sorted sections will be verified that they
+	 are in deed sorted and will warn if they are not.
+
+	 If unsure, say N
+
 config RING_BUFFER_STARTUP_TEST
        bool "Ring buffer startup self test"
        depends on RING_BUFFER
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9ca63df6553a..403e485bf091 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6388,6 +6388,27 @@ static int ftrace_cmp_ips(const void *a, const void *b)
 	return 0;
 }
 
+#ifdef CONFIG_FTRACE_SORT_STARTUP_TEST
+static void test_is_sorted(unsigned long *start, unsigned long count)
+{
+	int i;
+
+	for (i = 1; i < count; i++) {
+		if (WARN(start[i - 1] > start[i],
+			 "[%d] %pS at %lx is not sorted with %pS at %lx\n", i,
+			 (void *)start[i - 1], start[i - 1],
+			 (void *)start[i], start[i]))
+			break;
+	}
+	if (i == count)
+		pr_info("ftrace section at %px sorted properly\n", start);
+}
+#else
+static void test_is_sorted(unsigned long *start, unsigned long count)
+{
+}
+#endif
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -6414,6 +6435,8 @@ static int ftrace_process_locs(struct module *mod,
 	if (!IS_ENABLED(CONFIG_BUILDTIME_TABLE_SORT) || mod) {
 		sort(start, count, sizeof(*start),
 		     ftrace_cmp_ips, NULL);
+	} else {
+		test_is_sorted(start, count);
 	}
 
 	start_pg = ftrace_allocate_pages(count);
-- 
2.33.0
