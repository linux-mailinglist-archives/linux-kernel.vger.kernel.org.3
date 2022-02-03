Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBA4A869E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351752AbiBCOfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351320AbiBCOdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F465C06175C;
        Thu,  3 Feb 2022 06:33:36 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syUutp0w1EE9/WDnLShnHZRoAbLvsxwnkGM9FWJyhC8=;
        b=AdoDhzWHNN6hfxcFel02XPkF9QBUydM9jyR8F3Wvb5SHp+qEJtlaZcIT9i9NXrkQ1LzENG
        IZYitKbLOpHtd02zAaWIUCV00N+d78wuZh74rC4lMrV2DKf6p/P3rFN1xQkElg3tdJqiFZ
        ZFHdMAMDGicq6ev0YXSIpImPj1NflSaAUva+WYqExJbVgP6WuRtGdi6Go8X6Q+hVOauSH2
        ByZBhaEqK9EYcaFw3PgV1TpbCx3+GZzi1ZyZslRJhx9XjDKu5nlg2NwXeUaKTnafwMh4Tq
        if0NOTN8PlRlDu5gWb/hjd9QZZPO3JYwqyXMecMdGZV97QH2YWTJQPqz6QXX7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syUutp0w1EE9/WDnLShnHZRoAbLvsxwnkGM9FWJyhC8=;
        b=oKUKaCnudKncwHN20c7iQaLScpAqVQWYOEsunQGEW38Bba8yO5HlVzGr1V5BtaG5vQ0VJv
        +1HZz54hhGDQyaDA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Copy perf_event_attr::sig_data on modification
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131103407.1971678-1-elver@google.com>
References: <20220131103407.1971678-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <164389881392.16921.6632551424370921603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3c25fc97f5590060464cabfa25710970ecddbc96
Gitweb:        https://git.kernel.org/tip/3c25fc97f5590060464cabfa25710970ecddbc96
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 31 Jan 2022 11:34:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:40 +01:00

perf: Copy perf_event_attr::sig_data on modification

The intent has always been that perf_event_attr::sig_data should also be
modifiable along with PERF_EVENT_IOC_MODIFY_ATTRIBUTES, because it is
observable by user space if SIGTRAP on events is requested.

Currently only PERF_TYPE_BREAKPOINT is modifiable, and explicitly copies
relevant breakpoint-related attributes in hw_breakpoint_copy_attr().
This misses copying perf_event_attr::sig_data.

Since sig_data is not specific to PERF_TYPE_BREAKPOINT, introduce a
helper to copy generic event-type-independent attributes on
modification.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/r/20220131103407.1971678-1-elver@google.com
---
 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 76c754e..57c7197 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3238,6 +3238,15 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 	return err;
 }
 
+/*
+ * Copy event-type-independent attributes that may be modified.
+ */
+static void perf_event_modify_copy_attr(struct perf_event_attr *to,
+					const struct perf_event_attr *from)
+{
+	to->sig_data = from->sig_data;
+}
+
 static int perf_event_modify_attr(struct perf_event *event,
 				  struct perf_event_attr *attr)
 {
@@ -3260,10 +3269,17 @@ static int perf_event_modify_attr(struct perf_event *event,
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 
 	mutex_lock(&event->child_mutex);
+	/*
+	 * Event-type-independent attributes must be copied before event-type
+	 * modification, which will validate that final attributes match the
+	 * source attributes after all relevant attributes have been copied.
+	 */
+	perf_event_modify_copy_attr(&event->attr, attr);
 	err = func(event, attr);
 	if (err)
 		goto out;
 	list_for_each_entry(child, &event->child_list, child_list) {
+		perf_event_modify_copy_attr(&child->attr, attr);
 		err = func(child, attr);
 		if (err)
 			goto out;
