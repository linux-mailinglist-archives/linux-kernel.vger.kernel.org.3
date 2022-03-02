Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15374CAAA2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiCBQlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243299AbiCBQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:40:49 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA3CEA1F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:40:05 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfvBgrtiG9LxjqkuYus7pXkmugj62NhRZroC7mYbdoA=;
        b=THIJtJGDx8c6x+4JQpn2g1iQhzIDsWS/5VO7QzZGjLDo01uIBOCrChB4ZwgGPBwTPlHGev
        xXHLCbncZrgFyeUIjdf3mTUK10EXxvJLRLJyvp8BnnakIwuMiW8z8u0wXBHT1GzaCglHU6
        pbbL0cwlGXse4K05c9u6n5xLIKgmCZI=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 22/22] kasan: disable LOCKDEP when printing reports
Date:   Wed,  2 Mar 2022 17:36:42 +0100
Message-Id: <c48a2a3288200b07e1788b77365c2f02784cfeb4.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

If LOCKDEP detects a bug while KASAN is printing a report and if
panic_on_warn is set, KASAN will not be able to finish.
Disable LOCKDEP while KASAN is printing a report.

See https://bugzilla.kernel.org/show_bug.cgi?id=202115 for an example
of the issue.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c9bfffe931b4..199d77cce21a 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -13,6 +13,7 @@
 #include <linux/ftrace.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/mm.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
@@ -148,6 +149,8 @@ static void start_report(unsigned long *flags, bool sync)
 	disable_trace_on_warning();
 	/* Update status of the currently running KASAN test. */
 	update_kunit_status(sync);
+	/* Do not allow LOCKDEP mangling KASAN reports. */
+	lockdep_off();
 	/* Make sure we don't end up in loop. */
 	kasan_disable_current();
 	spin_lock_irqsave(&report_lock, *flags);
@@ -160,12 +163,13 @@ static void end_report(unsigned long *flags, void *addr)
 		trace_error_report_end(ERROR_DETECTOR_KASAN,
 				       (unsigned long)addr);
 	pr_err("==================================================================\n");
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
 	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
 		panic("panic_on_warn set ...\n");
 	if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
 		panic("kasan.fault=panic set ...\n");
+	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+	lockdep_on();
 	kasan_enable_current();
 }
 
-- 
2.25.1

