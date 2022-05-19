Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0452C856
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiESAGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiESAGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:06:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE8BC6FB
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:06:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a9so1535587pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnQRqfvUHTSGL+MLA9t/8T2xy8xvvnekkUHuEk3skW8=;
        b=jy3/fWxlPzVkBZwxU0Cb4D51NdFdrc8bCdHTjUK3AUyQ0SUzspVzcPPpcdWmtHcUT5
         VeTK8OA/6Jpr6rIy0/ZQL3c5JJXT8cmXbpj2+gxS9EoVkqR8DsqGxNlvoRwWb0KrLHlW
         MZQYy4milqvCLBP37GR4pOjeeVQfl9FAk32JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnQRqfvUHTSGL+MLA9t/8T2xy8xvvnekkUHuEk3skW8=;
        b=wN3x4Mx8yJEEj3JRk48ax0p4/r3F5q4QyO8/z92FMhyjjGIk70ny4E6gMqvLzxrJdC
         SO0t3WoBr8bIfUhEvCStLP7ps3/B3apOShmNy/4EpLRPEykgHEHew3wF9wsL5kCDD3Zf
         FxOc1o+7+qNWD+c84d8kOdcZWPwWNtTxMK8zBMwFzEXwTAkDGaVHE1VtLf9hK13BJGHS
         EgKw9C9aDrauUJgExoVK+GjHyoCMCHLvgZdMc+7QqgmAXza6trZTDIB9ik20Yl3rLo8C
         /Tz1vbjUXrHeS2EZp+UVA+o1Sxj1ShNFTcFCeh6lixo7eoTmEnhbdQ2pW2MVP5y30Ib1
         4Ovg==
X-Gm-Message-State: AOAM532bJJm+Vjf+BYVnJmtgMgZs0JJP0Y5+2EHPau07mgxc3xLXnhwm
        S9AoPd/z121cL/3IcFFQNNoHPA==
X-Google-Smtp-Source: ABdhPJznyLNFCnwPxfChQnnEr/3S2bvgHhOj2K0A+O1h8onFnWKBc9aQY6l71hDSxXudWQY1yx3HnQ==
X-Received: by 2002:a05:6a00:b56:b0:510:8107:5cf8 with SMTP id p22-20020a056a000b5600b0051081075cf8mr1870723pfo.2.1652918787205;
        Wed, 18 May 2022 17:06:27 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with ESMTPSA id k1-20020a628e01000000b0050dc76281b1sm2396787pfe.139.2022.05.18.17.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 17:06:27 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v1] Binder: add TF_UPDATE_TXN
Date:   Wed, 18 May 2022 17:06:23 -0700
Message-Id: <20220519000623.1715899-1-dualli@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Li <dualli@google.com>

When the target process is busy, incoming oneway transactions are
queued in the async_todo list. If the clients continue sending extra
oneway transactions while the target process is frozen, this queue can
become too large to accommodate new transactions. That's why binder
driver introduced ONEWAY_SPAM_DETECTION to detect this situation. It's
helpful to debug the async binder buffer exhausting issue, but the
issue itself isn't solved directly.

In real cases applications are designed to send oneway transactions
repeatedly, delivering updated inforamtion to the target process.
Typical examples are Wi-Fi signal strength and some real time sensor
data. Even if the apps might only care about the lastet information,
all outdated oneway transactions are still accumulated there until the
frozen process is thawed later. For this kind of situations, there's
no existing method to skip those outdated transactions and deliver the
latest one only.

This patch introduces a new transaction flag TF_UPDATE_TXN. To use it,
use apps can set this new flag along with TF_ONE_WAY. When such an
oneway transaction is to be queued into the async_todo list of a frozen
process, binder driver will check if any previous pending transactions
can be superseded by comparing their code, flags and target node. If
such an outdated pending transaction is found, the latest transaction
will supersede that outdated one. This effectively prevents the async
binder buffer running out and saves unnecessary binder read workloads.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c            | 90 ++++++++++++++++++++++++++++-
 drivers/android/binder_trace.h      |  4 ++
 include/uapi/linux/android/binder.h |  1 +
 3 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f3b639e89dd8..153486a32d69 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2594,6 +2594,60 @@ static int binder_fixup_parent(struct list_head *pf_head,
 	return binder_add_fixup(pf_head, buffer_offset, bp->buffer, 0);
 }
 
+/**
+ * binder_can_update_transaction() - Can a txn be superseded by an updated one?
+ * @t1: the pending async txn in the frozen process
+ * @t2: the new async txn to supersede the outdated pending one
+ *
+ * Return:  true if t2 can supersede t1
+ *          false if t2 can not supersede t1
+ */
+static bool binder_can_update_transaction(struct binder_transaction *t1,
+					  struct binder_transaction *t2)
+{
+	if ((t1->flags & t2->flags & (TF_ONE_WAY | TF_UPDATE_TXN))
+			!= (TF_ONE_WAY | TF_UPDATE_TXN)
+			|| t1->to_proc == NULL || t2->to_proc == NULL)
+		return false;
+	if (t1->to_proc->tsk == t2->to_proc->tsk && t1->code == t2->code
+			&& t1->flags == t2->flags
+			&& t1->buffer->pid == t2->buffer->pid
+			&& t1->buffer->target_node->ptr
+			== t2->buffer->target_node->ptr
+			&& t1->buffer->target_node->cookie
+			== t2->buffer->target_node->cookie)
+		return true;
+	return false;
+}
+
+/**
+ * binder_find_outdated_transaction_ilocked() - Find the outdated transaction
+ * @t:		 new async transaction
+ * @target_list: list to find outdated transaction
+ *
+ * Return: the outdated transaction if found
+ *         NULL if no outdated transacton can be found
+ *
+ * Requires the proc->inner_lock to be held.
+ */
+static struct binder_transaction *
+binder_find_outdated_transaction_ilocked(struct binder_transaction *t,
+					 struct list_head *target_list)
+{
+	struct binder_work *w;
+
+	list_for_each_entry(w, target_list, entry) {
+		struct binder_transaction *t_queued;
+
+		if (w->type != BINDER_WORK_TRANSACTION)
+			continue;
+		t_queued = container_of(w, struct binder_transaction, work);
+		if (binder_can_update_transaction(t_queued, t))
+			return t_queued;
+	}
+	return NULL;
+}
+
 /**
  * binder_proc_transaction() - sends a transaction to a process and wakes it up
  * @t:		transaction to send
@@ -2619,6 +2673,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 	struct binder_node *node = t->buffer->target_node;
 	bool oneway = !!(t->flags & TF_ONE_WAY);
 	bool pending_async = false;
+	struct binder_transaction *t_outdated = NULL;
 
 	BUG_ON(!node);
 	binder_node_lock(node);
@@ -2646,12 +2701,25 @@ static int binder_proc_transaction(struct binder_transaction *t,
 	if (!thread && !pending_async)
 		thread = binder_select_thread_ilocked(proc);
 
-	if (thread)
+	if (thread) {
 		binder_enqueue_thread_work_ilocked(thread, &t->work);
-	else if (!pending_async)
+	} else if (!pending_async) {
 		binder_enqueue_work_ilocked(&t->work, &proc->todo);
-	else
+	} else {
+		if ((t->flags & TF_UPDATE_TXN) && proc->is_frozen) {
+			t_outdated = binder_find_outdated_transaction_ilocked(
+					t, &node->async_todo);
+			if (t_outdated) {
+				binder_debug(BINDER_DEBUG_TRANSACTION,
+						"txn %d supersedes %d\n",
+						t->debug_id,
+						t_outdated->debug_id);
+				list_del_init(&t_outdated->work.entry);
+				proc->outstanding_txns--;
+			}
+		}
 		binder_enqueue_work_ilocked(&t->work, &node->async_todo);
+	}
 
 	if (!pending_async)
 		binder_wakeup_thread_ilocked(proc, thread, !oneway /* sync */);
@@ -2660,6 +2728,22 @@ static int binder_proc_transaction(struct binder_transaction *t,
 	binder_inner_proc_unlock(proc);
 	binder_node_unlock(node);
 
+	/*
+	 * To reduce potential contention, free the outdated transaction and
+	 * buffer after releasing the locks.
+	 */
+	if (t_outdated) {
+		struct binder_buffer *buffer = t_outdated->buffer;
+
+		t_outdated->buffer = NULL;
+		buffer->transaction = NULL;
+		trace_binder_transaction_update_buffer_release(buffer);
+		binder_transaction_buffer_release(proc, NULL, buffer, 0, 0);
+		binder_alloc_free_buf(&proc->alloc, buffer);
+		kfree(t_outdated);
+		binder_stats_deleted(BINDER_STAT_TRANSACTION);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 8eeccdc64724..5b544f2aff4b 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -311,6 +311,10 @@ DEFINE_EVENT(binder_buffer_class, binder_transaction_failed_buffer_release,
 	TP_PROTO(struct binder_buffer *buffer),
 	TP_ARGS(buffer));
 
+DEFINE_EVENT(binder_buffer_class, binder_transaction_update_buffer_release,
+	TP_PROTO(struct binder_buffer *buffer),
+	TP_ARGS(buffer));
+
 TRACE_EVENT(binder_update_page_range,
 	TP_PROTO(struct binder_alloc *alloc, bool allocate,
 		 void __user *start, void __user *end),
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 11157fae8a8e..0b291b1d29d1 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -271,6 +271,7 @@ enum transaction_flags {
 	TF_STATUS_CODE	= 0x08,	/* contents are a 32-bit status code */
 	TF_ACCEPT_FDS	= 0x10,	/* allow replies with file descriptors */
 	TF_CLEAR_BUF	= 0x20,	/* clear buffer on txn complete */
+	TF_UPDATE_TXN	= 0x40,	/* update the outdated pending async txn */
 };
 
 struct binder_transaction_data {
-- 
2.36.1.124.g0e6072fb45-goog

