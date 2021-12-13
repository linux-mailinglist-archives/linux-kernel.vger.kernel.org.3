Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394324720A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhLMFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:44:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhLMFok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:44:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F2D43210F9;
        Mon, 13 Dec 2021 05:44:38 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3E2713310;
        Mon, 13 Dec 2021 05:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lpw4EMTdtmEiVAAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 13 Dec 2021 05:44:36 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     axboe@kernel.dk
Cc:     bigeasy@linutronix.de, tglx@linutronix.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] blk-mq: make synchronous hw_queue runs RT friendly
Date:   Sun, 12 Dec 2021 21:44:25 -0800
Message-Id: <20211213054425.28121-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling preemption for the synchronous part of __blk_mq_delay_run_hw_queue()
is to ensure that the hw queue runs in the correct CPU. This does not play
well with PREEMPT_RT as regular spinlocks can be taken at this time (such as
the hctx->lock), triggering scheduling while atomic scenarios.

Introduce regions to mark starting and ending such cases and allow RT to
instead disable migration. While this actually better documents what is
occurring (as it is not about preemption but CPU locality), doing so for the
regular non-RT case can be too expensive. Similarly, instead of relying on
preemption or migration tricks, the task could also be affined to the valid
cpumask, but that too would be unnecessarily expensive.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 block/blk-mq.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8874a63ae952..d44b851fffba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1841,6 +1841,30 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	return next_cpu;
 }
 
+/*
+ * Mark regions to ensure that a synchronous hardware queue
+ * runs on a correct CPU.
+ */
+#ifndef CONFIG_PREEMPT_RT
+static inline void blk_mq_start_sync_run_hw_queue(void)
+{
+	preempt_disable();
+}
+static inline void blk_mq_end_sync_run_hw_queue(void)
+{
+	preempt_enable();
+}
+#else
+static inline void blk_mq_start_sync_run_hw_queue(void)
+{
+	migrate_disable();
+}
+static inline void blk_mq_end_sync_run_hw_queue(void)
+{
+	migrate_enable();
+}
+#endif
+
 /**
  * __blk_mq_delay_run_hw_queue - Run (or schedule to run) a hardware queue.
  * @hctx: Pointer to the hardware queue to run.
@@ -1857,14 +1881,14 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		int cpu = get_cpu();
-		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+		blk_mq_start_sync_run_hw_queue();
+		if (cpumask_test_cpu(smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
-			put_cpu();
+			blk_mq_end_sync_run_hw_queue();
 			return;
 		}
 
-		put_cpu();
+		blk_mq_end_sync_run_hw_queue();
 	}
 
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
-- 
2.26.2

