Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9C4F3863
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376533AbiDELWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiDEIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C22AE38;
        Tue,  5 Apr 2022 01:36:50 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcaaisSy7yoGqMENp3XASjYCIhZ1dy0KEhiOvSml/rM=;
        b=0+SAgssOSJBn+nuIEtoTZh2t3SMHH76grHmTrE+JG6cLr4j7fmaKvodTnlZwqlMxVZNG3/
        dg/vl4flXx7hZ1Kxn2g5NZpABNluW9kMeexO5i1bWyIpcbXK5V9axoOWMliPxsgogaBLDT
        +FBzQJzC4rmZiKgQPcmSNt9hj1mY1974KFODffLbhJ8qJf4mIzazLSDXmmXQ3mvQK1srOF
        tAPiRWJjhIym2eA6KYRAieb3aYbZqjsVkeFPhMklFkkkc2KCMM6MCMaqECWMqP7ZRuAJu1
        D++hvFbmcm3B8tsl885hJZKaCYSKkhCwSIzPJNqwn9YS6Ci+WG+OUyZ8Z0hgkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcaaisSy7yoGqMENp3XASjYCIhZ1dy0KEhiOvSml/rM=;
        b=Lrw4YWtFGKUJUYLf7CQe8NhuxeFh7h8YldBEND6+NV1Jkm+l2BfsR7bMaQ1ArbH3dGU3Am
        ffEEZ6uJgmJAg/CQ==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] ACPI: Add perf low power callback
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322221517.2510440-9-eranian@google.com>
References: <20220322221517.2510440-9-eranian@google.com>
MIME-Version: 1.0
Message-ID: <164914779839.389.6423225128965385864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2a606a18cd672a16343d146a126721b34cc6adbd
Gitweb:        https://git.kernel.org/tip/2a606a18cd672a16343d146a126721b34cc6adbd
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Tue, 22 Mar 2022 15:15:12 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:38 +02:00

ACPI: Add perf low power callback

Add an optional callback needed by some PMU features, e.g., AMD
BRS, to give a chance to the perf_events code to change its state before
a CPU goes to low power and after it comes back.

The callback is void when the PERF_NEEDS_LOPWR_CB flag is not set.
This flag must be set in arch specific perf_event.h header whenever needed.
When not set, there is no impact on the ACPI code.

Signed-off-by: Stephane Eranian <eranian@google.com>
[peterz: build fix]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220322221517.2510440-9-eranian@google.com
---
 drivers/acpi/acpi_pad.c       | 7 +++++++
 drivers/acpi/processor_idle.c | 5 +++++
 include/linux/perf_event.h    | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index f45979a..ec0e22a 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -17,6 +17,7 @@
 #include <linux/tick.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/perf_event.h>
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
@@ -164,6 +165,9 @@ static int power_saving_thread(void *data)
 				tsc_marked_unstable = 1;
 			}
 			local_irq_disable();
+
+			perf_lopwr_cb(true);
+
 			tick_broadcast_enable();
 			tick_broadcast_enter();
 			stop_critical_timings();
@@ -172,6 +176,9 @@ static int power_saving_thread(void *data)
 
 			start_critical_timings();
 			tick_broadcast_exit();
+
+			perf_lopwr_cb(false);
+
 			local_irq_enable();
 
 			if (time_before(expire_time, jiffies)) {
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 32b20ef..05dc0e1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -21,6 +21,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
 #include <linux/minmax.h>
+#include <linux/perf_event.h>
 #include <acpi/processor.h>
 
 /*
@@ -549,6 +550,8 @@ static void wait_for_freeze(void)
  */
 static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 {
+	perf_lopwr_cb(true);
+
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
 		acpi_processor_ffh_cstate_enter(cx);
@@ -559,6 +562,8 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 		inb(cx->address);
 		wait_for_freeze();
 	}
+
+	perf_lopwr_cb(false);
 }
 
 /**
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a411080..da75956 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1676,4 +1676,10 @@ typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *entries,
 					   unsigned int cnt);
 DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
 
+#ifndef PERF_NEEDS_LOPWR_CB
+static inline void perf_lopwr_cb(bool mode)
+{
+}
+#endif
+
 #endif /* _LINUX_PERF_EVENT_H */
