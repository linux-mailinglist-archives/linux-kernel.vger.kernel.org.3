Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6434A8681
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351391AbiBCOeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53536 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351300AbiBCOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:35 -0500
Date:   Thu, 03 Feb 2022 14:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbUd0gk5G6Thq1OHej1eRDFykyMWYJlV4KGGTT5Ts0Q=;
        b=0N26AZ1tSnAbTzHUB3ItT6GbcibaGxWsQmUHfxg2Rovro0T56PYhC//QdHqcZI/ktPxwI3
        oiJ2sOKEKuIBBJgFvPJsoS2i5eD1Oaa2CIlfhY3ef5bXmaX6aVzRRmal98xkPrhtXb/cet
        1rmljMvvo3IM7IWXz8HcAgbjj+AZBei4AY3HJchH4004Jofs3bvahPsZsScEMtcOpZrKAB
        mMJVwH390So7TmIlVQm5d+tElf8/0VnvF9S3LnH4IDjq8Yg9kbgph7j6qvgSavnpD0K5uQ
        38ssb/5fSy/fFc93iAs0q13LYneTHNXh0IfT7VliO0eOq2mdANRWN6piGtxTLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbUd0gk5G6Thq1OHej1eRDFykyMWYJlV4KGGTT5Ts0Q=;
        b=vmLxMTOJGhttiJP2FxdbFwdVNmDR1yqujVr0H84wcZsvSMY0n+QcLKfqRVD2Ca8vjXcWTd
        Qi003yfwZSsEWjCw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] selftests/perf_events: Test modification of
 perf_event_attr::sig_data
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131103407.1971678-2-elver@google.com>
References: <20220131103407.1971678-2-elver@google.com>
MIME-Version: 1.0
Message-ID: <164389881313.16921.2602299709359828401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     95d29fa104523b1756323f7003294b1711c27808
Gitweb:        https://git.kernel.org/tip/95d29fa104523b1756323f7003294b1711c27808
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 31 Jan 2022 11:34:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:40 +01:00

selftests/perf_events: Test modification of perf_event_attr::sig_data

Test that PERF_EVENT_IOC_MODIFY_ATTRIBUTES correctly modifies
perf_event_attr::sig_data as well.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/r/20220131103407.1971678-2-elver@google.com
---
 tools/testing/selftests/perf_events/sigtrap_threads.c | 17 +++++-----
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 8e83cf9..6d849dc 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -44,9 +44,10 @@ static struct {
 } ctx;
 
 /* Unique value to check si_perf_data is correctly set from perf_event_attr::sig_data. */
-#define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
+#define TEST_SIG_DATA(addr, id) (~(unsigned long)(addr) + id)
 
-static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
+static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr,
+					      unsigned long id)
 {
 	struct perf_event_attr attr = {
 		.type		= PERF_TYPE_BREAKPOINT,
@@ -60,7 +61,7 @@ static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
 		.inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
 		.remove_on_exec = 1, /* Required by sigtrap. */
 		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
-		.sig_data	= TEST_SIG_DATA(addr),
+		.sig_data	= TEST_SIG_DATA(addr, id),
 	};
 	return attr;
 }
@@ -110,7 +111,7 @@ FIXTURE(sigtrap_threads)
 
 FIXTURE_SETUP(sigtrap_threads)
 {
-	struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on);
+	struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on, 0);
 	struct sigaction action = {};
 	int i;
 
@@ -165,7 +166,7 @@ TEST_F(sigtrap_threads, enable_event)
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
 	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
 
 	/* Check enabled for parent. */
 	ctx.iterate_on = 0;
@@ -175,7 +176,7 @@ TEST_F(sigtrap_threads, enable_event)
 /* Test that modification propagates to all inherited events. */
 TEST_F(sigtrap_threads, modify_and_enable_event)
 {
-	struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on);
+	struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on, 42);
 
 	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &new_attr), 0);
 	run_test_threads(_metadata, self);
@@ -184,7 +185,7 @@ TEST_F(sigtrap_threads, modify_and_enable_event)
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
 	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 42));
 
 	/* Check enabled for parent. */
 	ctx.iterate_on = 0;
@@ -204,7 +205,7 @@ TEST_F(sigtrap_threads, signal_stress)
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
 	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
 }
 
 TEST_HARNESS_MAIN
