Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84304574C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiGNLf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiGNLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:35:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BDA5927B;
        Thu, 14 Jul 2022 04:35:25 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:35:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657798524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lyytb82cHSEU/hH2o7kuQh+9vqNnK4SAy+yvsPV+az0=;
        b=iTGSL+9xwc6aL0eS1hwCak4RHxJhAuVN8Wezxu29a0SlZhka16ZOsRjqoLBaTfRdzFS7Fp
        Aral1A7AWILCfAINjFwyWtjeQ4+Em6jnT/iPqirpYztKUmoXOL+MUPOLnZPQIY1+c5v3Tf
        pGRGfrCc+FyVfkLFWziZWL/v1LzHwMOjqAJAHh3DX60ugoMAwzWs8YBTx/0+iXL9ilyIm2
        jZ9sGZgxnYI7NJg2uVpZMFE/V6nFeajheKI8y+TtshzNYSDyydcy/F4r6LHi5cU9F/9LNq
        2MXALdD+KARM+m2vxDeE+Xmk4AA/l0huVfo6BNxwyYPVFHvfD6pMPiauoVvafQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657798524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lyytb82cHSEU/hH2o7kuQh+9vqNnK4SAy+yvsPV+az0=;
        b=daldFeg1uz1U5BMf1uMc8qCvR8VzBhVlL6/NiYDVykgtWi2LjZ7dCXnGw2UbNr25lQmwCA
        FVxOprLuHbpSJrCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix data race between
 perf_event_set_output() and perf_mmap_close()
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YsQ3jm2GR38SW7uD@worktop.programming.kicks-ass.net>
References: <YsQ3jm2GR38SW7uD@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165779852269.15455.12378628877885813176.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     68e3c69803dada336893640110cb87221bb01dcf
Gitweb:        https://git.kernel.org/tip/68e3c69803dada336893640110cb87221bb01dcf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 05 Jul 2022 15:07:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 13 Jul 2022 11:29:12 +02:00

perf/core: Fix data race between perf_event_set_output() and perf_mmap_close()

Yang Jihing reported a race between perf_event_set_output() and
perf_mmap_close():

	CPU1					CPU2

	perf_mmap_close(e2)
	  if (atomic_dec_and_test(&e2->rb->mmap_count)) // 1 - > 0
	    detach_rest = true

						ioctl(e1, IOC_SET_OUTPUT, e2)
						  perf_event_set_output(e1, e2)

	  ...
	  list_for_each_entry_rcu(e, &e2->rb->event_list, rb_entry)
	    ring_buffer_attach(e, NULL);
	    // e1 isn't yet added and
	    // therefore not detached

						    ring_buffer_attach(e1, e2->rb)
						      list_add_rcu(&e1->rb_entry,
								   &e2->rb->event_list)

After this; e1 is attached to an unmapped rb and a subsequent
perf_mmap() will loop forever more:

	again:
		mutex_lock(&e->mmap_mutex);
		if (event->rb) {
			...
			if (!atomic_inc_not_zero(&e->rb->mmap_count)) {
				...
				mutex_unlock(&e->mmap_mutex);
				goto again;
			}
		}

The loop in perf_mmap_close() holds e2->mmap_mutex, while the attach
in perf_event_set_output() holds e1->mmap_mutex. As such there is no
serialization to avoid this race.

Change perf_event_set_output() to take both e1->mmap_mutex and
e2->mmap_mutex to alleviate that problem. Additionally, have the loop
in perf_mmap() detach the rb directly, this avoids having to wait for
the concurrent perf_mmap_close() to get around to doing it to make
progress.

Fixes: 9bb5d40cd93c ("perf: Fix mmap() accounting hole")
Reported-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yang Jihong <yangjihong1@huawei.com>
Link: https://lkml.kernel.org/r/YsQ3jm2GR38SW7uD@worktop.programming.kicks-ass.net
---
 kernel/events/core.c | 45 +++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cd..d2b3549 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6253,10 +6253,10 @@ again:
 
 		if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
 			/*
-			 * Raced against perf_mmap_close() through
-			 * perf_event_set_output(). Try again, hope for better
-			 * luck.
+			 * Raced against perf_mmap_close(); remove the
+			 * event and try again.
 			 */
+			ring_buffer_attach(event, NULL);
 			mutex_unlock(&event->mmap_mutex);
 			goto again;
 		}
@@ -11825,14 +11825,25 @@ err_size:
 	goto out;
 }
 
+static void mutex_lock_double(struct mutex *a, struct mutex *b)
+{
+	if (b < a)
+		swap(a, b);
+
+	mutex_lock(a);
+	mutex_lock_nested(b, SINGLE_DEPTH_NESTING);
+}
+
 static int
 perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 {
 	struct perf_buffer *rb = NULL;
 	int ret = -EINVAL;
 
-	if (!output_event)
+	if (!output_event) {
+		mutex_lock(&event->mmap_mutex);
 		goto set;
+	}
 
 	/* don't allow circular references */
 	if (event == output_event)
@@ -11870,8 +11881,15 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	    event->pmu != output_event->pmu)
 		goto out;
 
+	/*
+	 * Hold both mmap_mutex to serialize against perf_mmap_close().  Since
+	 * output_event is already on rb->event_list, and the list iteration
+	 * restarts after every removal, it is guaranteed this new event is
+	 * observed *OR* if output_event is already removed, it's guaranteed we
+	 * observe !rb->mmap_count.
+	 */
+	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
 set:
-	mutex_lock(&event->mmap_mutex);
 	/* Can't redirect output if we've got an active mmap() */
 	if (atomic_read(&event->mmap_count))
 		goto unlock;
@@ -11881,6 +11899,12 @@ set:
 		rb = ring_buffer_get(output_event);
 		if (!rb)
 			goto unlock;
+
+		/* did we race against perf_mmap_close() */
+		if (!atomic_read(&rb->mmap_count)) {
+			ring_buffer_put(rb);
+			goto unlock;
+		}
 	}
 
 	ring_buffer_attach(event, rb);
@@ -11888,20 +11912,13 @@ set:
 	ret = 0;
 unlock:
 	mutex_unlock(&event->mmap_mutex);
+	if (output_event)
+		mutex_unlock(&output_event->mmap_mutex);
 
 out:
 	return ret;
 }
 
-static void mutex_lock_double(struct mutex *a, struct mutex *b)
-{
-	if (b < a)
-		swap(a, b);
-
-	mutex_lock(a);
-	mutex_lock_nested(b, SINGLE_DEPTH_NESTING);
-}
-
 static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 {
 	bool nmi_safe = false;
