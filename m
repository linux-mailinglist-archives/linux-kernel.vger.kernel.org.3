Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8384E5095C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiDUEXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384088AbiDUEXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:23:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3C11A2A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:20:53 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o16-20020a17090aac1000b001d4a25f5e26so1506939pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=GnIL1wIqZyfgQgV0vypltggEybR8HjOpEbnmvrZXuR0=;
        b=WBCAQDjljU006RSC7oEa3p/yFUIgQmva56z8FRaH13b1cbehY7qWjkWsFQtBQuUJnU
         x4hMZZ4EcRLfxsDe27uZhtaR5BLLMdAI8ZL6b3HXlLiEA3fNGvQQ+gwagIVi0GWNsQqc
         WJQFBX44Ty5xSmKHOzv9agzQhbXnxnE1HaQSdBahgQ0NmnKWohxwaVDpmA5QJVixeFZP
         4y92P48R9Otdn4xgXOXZNtDAH3RLIpti+WKLuR/V12VCHHV9HIdoXbjyiN3g7IHTl9ob
         xQ2HIuu5S+zS1F5RA0O5R7rxXW7TRN3gs+th0oncSTDPe31tcTMUBbxv23UDC/RDa0Zf
         TxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=GnIL1wIqZyfgQgV0vypltggEybR8HjOpEbnmvrZXuR0=;
        b=NyeQjBv5uKAQcEgx9CiMM0b3Y2Fmd0yV2FdjfL5chbWJFjr6mX0mkS/QOGr/Rfjy6e
         CXEJgaiZOrsc3YR8vU4iYaoPj+zjCZH6LDboBCz8zjR9sNsRM4/5ei4XgU3NYkwV1YgM
         sieG/SZ+GcCzLvqxX6umRJrpCG+rAG9Uk0jU8c75tXLBHrBFfbUyYINpjJJYLxo11FP8
         c/BMD47wsknSYcAYdfH0Jd4Z3pXclZgoyvxlIe6SM2V5JmQN0YIXiEDH42Xsw9MYmX7D
         a63JfTD7Tu3gAnlQUWMw7VI/DbI8JH+jX+ZCInk/P9IVRio6PQAozh5nREjgqUWiBot4
         4gFA==
X-Gm-Message-State: AOAM530nk99EuYT6cC84N6amKfP5pTOyWvEbsMG+kSWhL6olk6NKTQtL
        wcgJ82VJa332tD3UBuU+ybeyXudTU8JG/Q==
X-Google-Smtp-Source: ABdhPJz2j9ojkkV6FnP+I2HkDR9nKkCRTM+hA+Wr+9dmFQf/z/Lo7hBVacdbMjVkRlsHJL3I/q5NaRH3iS63DQ==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:2384:b0:1cb:5223:9dc4 with SMTP
 id mr4-20020a17090b238400b001cb52239dc4mr260134pjb.1.1650514852797; Wed, 20
 Apr 2022 21:20:52 -0700 (PDT)
Date:   Thu, 21 Apr 2022 04:20:36 +0000
Message-Id: <20220421042040.759068-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH] binder: add BINDER_GET_EXTENDED_ERROR ioctl
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Carlos Llamas <cmllamas@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a userspace mechanism to pull precise error information upon
failed operations. Extending the current error codes returned by the
interfaces allows userspace to better determine the course of action.
This could be for instance, retrying a failed transaction at a later
point and thus offloading the error handling from the driver.

Some of the elements for logging failed transactions and similar are
folded into this new logic to avoid duplication. Such is the case for
error line numbers, which become irrelevant after assigning individual
error messages instead.

This patch also adds BINDER_GET_EXTENDED_ERROR to the binderfs feature
list, to help userspace determine if the new ioctl is supported by the
driver.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c            | 355 +++++++++++++++-------------
 drivers/android/binder_internal.h   |   9 +-
 drivers/android/binderfs.c          |   8 +
 include/uapi/linux/android/binder.h |  16 ++
 4 files changed, 219 insertions(+), 169 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..42a324634f25 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2697,6 +2697,54 @@ static struct binder_node *binder_get_node_refs_for_txn(
 	return target_node;
 }
 
+#define binder_txn_error(x...)		binder_transaction_error(0, x)
+#define binder_user_txn_error(x...)	binder_transaction_error(1, x)
+static __printf(6, 7) void binder_transaction_error(int user,
+				struct binder_transaction_log_entry *e,
+				struct binder_extended_error *ee,
+				uint32_t command, int32_t param,
+				const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	/* don't override previous error */
+	if (command != BR_OK && ee->command != BR_OK)
+		return;
+
+	ee->command = command;
+	ee->param = param;
+
+	va_start(args, format);
+	vsnprintf(e->strerr, sizeof(e->strerr), format, args);
+
+	vaf.va = &args;
+	vaf.fmt = format;
+	if (user)
+		binder_user_error("%d:%d %pV\n",
+			e->from_proc, e->from_thread, &vaf);
+	else
+		binder_debug(BINDER_DEBUG_FAILED_TRANSACTION, "%d:%d %pV\n",
+			e->from_proc, e->from_thread, &vaf);
+	va_end(args);
+}
+
+static void binder_set_txn_from_error(struct binder_transaction *txn,
+				      struct binder_extended_error *ee)
+{
+	struct binder_thread *from = binder_get_txn_from_and_acq_inner(txn);
+
+	if (!from)
+		return;
+
+	/* don't override previous error */
+	if (ee->command != BR_OK && from->ee.command == BR_OK)
+		from->ee = *ee;
+
+	binder_inner_proc_unlock(from->proc);
+	binder_thread_dec_tmpref(from);
+}
+
 static void binder_transaction(struct binder_proc *proc,
 			       struct binder_thread *thread,
 			       struct binder_transaction_data *tr, int reply,
@@ -2716,9 +2764,8 @@ static void binder_transaction(struct binder_proc *proc,
 	struct binder_node *target_node = NULL;
 	struct binder_transaction *in_reply_to = NULL;
 	struct binder_transaction_log_entry *e;
+	struct binder_extended_error ee;
 	uint32_t return_error = 0;
-	uint32_t return_error_param = 0;
-	uint32_t return_error_line = 0;
 	binder_size_t last_fixup_obj_off = 0;
 	binder_size_t last_fixup_min_off = 0;
 	struct binder_context *context = proc->context;
@@ -2741,32 +2788,30 @@ static void binder_transaction(struct binder_proc *proc,
 	e->data_size = tr->data_size;
 	e->offsets_size = tr->offsets_size;
 	strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
+	ee.id = t_debug_id;
+	ee.command = BR_OK;
+	ee.param = 0;
 
 	if (reply) {
 		binder_inner_proc_lock(proc);
 		in_reply_to = thread->transaction_stack;
 		if (in_reply_to == NULL) {
 			binder_inner_proc_unlock(proc);
-			binder_user_error("%d:%d got reply transaction with no transaction stack\n",
-					  proc->pid, thread->pid);
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EPROTO;
-			return_error_line = __LINE__;
+			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EPROTO,
+				"reply with no transaction stack");
 			goto err_empty_call_stack;
 		}
 		if (in_reply_to->to_thread != thread) {
 			spin_lock(&in_reply_to->lock);
-			binder_user_error("%d:%d got reply transaction with bad transaction stack, transaction %d has target %d:%d\n",
-				proc->pid, thread->pid, in_reply_to->debug_id,
+			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EPROTO,
+				"bad transaction stack in reply to %d %d:%d",
+				in_reply_to->debug_id,
 				in_reply_to->to_proc ?
 				in_reply_to->to_proc->pid : 0,
 				in_reply_to->to_thread ?
 				in_reply_to->to_thread->pid : 0);
 			spin_unlock(&in_reply_to->lock);
 			binder_inner_proc_unlock(proc);
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EPROTO;
-			return_error_line = __LINE__;
 			in_reply_to = NULL;
 			goto err_bad_call_stack;
 		}
@@ -2777,20 +2822,17 @@ static void binder_transaction(struct binder_proc *proc,
 		if (target_thread == NULL) {
 			/* annotation for sparse */
 			__release(&target_thread->proc->inner_lock);
-			return_error = BR_DEAD_REPLY;
-			return_error_line = __LINE__;
+			binder_txn_error(e, &ee, BR_DEAD_REPLY, 0,
+				"reply target not found");
 			goto err_dead_binder;
 		}
 		if (target_thread->transaction_stack != in_reply_to) {
-			binder_user_error("%d:%d got reply transaction with bad target transaction stack %d, expected %d\n",
-				proc->pid, thread->pid,
+			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EPROTO,
+				"bad target transaction stack %d vs %d",
 				target_thread->transaction_stack ?
 				target_thread->transaction_stack->debug_id : 0,
 				in_reply_to->debug_id);
 			binder_inner_proc_unlock(target_thread->proc);
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EPROTO;
-			return_error_line = __LINE__;
 			in_reply_to = NULL;
 			target_thread = NULL;
 			goto err_dead_binder;
@@ -2812,15 +2854,15 @@ static void binder_transaction(struct binder_proc *proc,
 			binder_proc_lock(proc);
 			ref = binder_get_ref_olocked(proc, tr->target.handle,
 						     true);
-			if (ref) {
+			if (ref)
 				target_node = binder_get_node_refs_for_txn(
 						ref->node, &target_proc,
 						&return_error);
-			} else {
-				binder_user_error("%d:%d got transaction to invalid handle, %u\n",
-						  proc->pid, thread->pid, tr->target.handle);
-				return_error = BR_FAILED_REPLY;
-			}
+			else
+				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
+					-EINVAL,
+					"invalid transaction handle %u",
+					tr->target.handle);
 			binder_proc_unlock(proc);
 		} else {
 			mutex_lock(&context->context_mgr_node_lock);
@@ -2833,11 +2875,9 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error = BR_DEAD_REPLY;
 			mutex_unlock(&context->context_mgr_node_lock);
 			if (target_node && target_proc->pid == proc->pid) {
-				binder_user_error("%d:%d got transaction to context manager from process owning it\n",
-						  proc->pid, thread->pid);
-				return_error = BR_FAILED_REPLY;
-				return_error_param = -EINVAL;
-				return_error_line = __LINE__;
+				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
+					-EINVAL,
+					"forbidden self transaction by context manager");
 				goto err_invalid_target_handle;
 			}
 		}
@@ -2845,22 +2885,20 @@ static void binder_transaction(struct binder_proc *proc,
 			/*
 			 * return_error is set above
 			 */
-			return_error_param = -EINVAL;
-			return_error_line = __LINE__;
+			binder_txn_error(e, &ee, return_error, -EINVAL,
+				"cannot find target node");
 			goto err_dead_binder;
 		}
 		e->to_node = target_node->debug_id;
 		if (WARN_ON(proc == target_proc)) {
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EINVAL;
-			return_error_line = __LINE__;
+			binder_txn_error(e, &ee, BR_FAILED_REPLY, -EINVAL,
+				"self transactions not allowed");
 			goto err_invalid_target_handle;
 		}
 		if (security_binder_transaction(proc->cred,
 						target_proc->cred) < 0) {
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EPERM;
-			return_error_line = __LINE__;
+			binder_txn_error(e, &ee, BR_FAILED_REPLY, -EPERM,
+				"transaction credentials failed");
 			goto err_invalid_target_handle;
 		}
 		binder_inner_proc_lock(proc);
@@ -2878,12 +2916,9 @@ static void binder_transaction(struct binder_proc *proc,
 			 * the transaction, and nothing is queued to the
 			 * todo list while the thread is on waiting_threads.
 			 */
-			binder_user_error("%d:%d new transaction not allowed when there is a transaction on thread todo\n",
-					  proc->pid, thread->pid);
+			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EPROTO,
+				"bad state for new transaction");
 			binder_inner_proc_unlock(proc);
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EPROTO;
-			return_error_line = __LINE__;
 			goto err_bad_todo_list;
 		}
 
@@ -2893,16 +2928,15 @@ static void binder_transaction(struct binder_proc *proc,
 			tmp = thread->transaction_stack;
 			if (tmp->to_thread != thread) {
 				spin_lock(&tmp->lock);
-				binder_user_error("%d:%d got new transaction with bad transaction stack, transaction %d has target %d:%d\n",
-					proc->pid, thread->pid, tmp->debug_id,
+				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
+					-EPROTO,
+					"bad transaction stack, %d has target %d:%d",
+					tmp->debug_id,
 					tmp->to_proc ? tmp->to_proc->pid : 0,
 					tmp->to_thread ?
 					tmp->to_thread->pid : 0);
 				spin_unlock(&tmp->lock);
 				binder_inner_proc_unlock(proc);
-				return_error = BR_FAILED_REPLY;
-				return_error_param = -EPROTO;
-				return_error_line = __LINE__;
 				goto err_bad_call_stack;
 			}
 			while (tmp) {
@@ -2929,9 +2963,8 @@ static void binder_transaction(struct binder_proc *proc,
 	/* TODO: reuse incoming transaction for reply */
 	t = kzalloc(sizeof(*t), GFP_KERNEL);
 	if (t == NULL) {
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -ENOMEM;
-		return_error_line = __LINE__;
+		binder_txn_error(e, &ee, BR_FAILED_REPLY, -ENOMEM,
+			"cannot allocate transaction");
 		goto err_alloc_t_failed;
 	}
 	INIT_LIST_HEAD(&t->fd_fixups);
@@ -2940,9 +2973,8 @@ static void binder_transaction(struct binder_proc *proc,
 
 	tcomplete = kzalloc(sizeof(*tcomplete), GFP_KERNEL);
 	if (tcomplete == NULL) {
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -ENOMEM;
-		return_error_line = __LINE__;
+		binder_txn_error(e, &ee, BR_FAILED_REPLY, -ENOMEM,
+			"cannot allocate work for transaction");
 		goto err_alloc_tcomplete_failed;
 	}
 	binder_stats_created(BINDER_STAT_TRANSACTION_COMPLETE);
@@ -2986,18 +3018,16 @@ static void binder_transaction(struct binder_proc *proc,
 		security_cred_getsecid(proc->cred, &secid);
 		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
 		if (ret) {
-			return_error = BR_FAILED_REPLY;
-			return_error_param = ret;
-			return_error_line = __LINE__;
+			binder_txn_error(e, &ee, BR_FAILED_REPLY, ret,
+				"failed to get security context");
 			goto err_get_secctx_failed;
 		}
 		added_size = ALIGN(secctx_sz, sizeof(u64));
 		extra_buffers_size += added_size;
 		if (extra_buffers_size < added_size) {
 			/* integer overflow of extra_buffers_size */
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EINVAL;
-			return_error_line = __LINE__;
+			binder_txn_error(e, &ee, BR_FAILED_REPLY, -EINVAL,
+				"extra buffers size overflow");
 			goto err_bad_extra_size;
 		}
 	}
@@ -3008,13 +3038,17 @@ static void binder_transaction(struct binder_proc *proc,
 		tr->offsets_size, extra_buffers_size,
 		!reply && (t->flags & TF_ONE_WAY), current->tgid);
 	if (IS_ERR(t->buffer)) {
-		/*
-		 * -ESRCH indicates VMA cleared. The target is dying.
-		 */
-		return_error_param = PTR_ERR(t->buffer);
-		return_error = return_error_param == -ESRCH ?
-			BR_DEAD_REPLY : BR_FAILED_REPLY;
-		return_error_line = __LINE__;
+		char *s;
+
+		ret = PTR_ERR(t->buffer);
+		s = (ret == -ESRCH) ? ": vma cleared, target dead or dying"
+			: (ret == -ENOSPC) ? ": no space left"
+			: (ret == -ENOMEM) ? ": memory allocation failed"
+			: "";
+
+		binder_txn_error(e, &ee,
+			ret == -ESRCH ? BR_DEAD_REPLY : BR_FAILED_REPLY,
+			ret, "cannot allocate buffer%s", s);
 		t->buffer = NULL;
 		goto err_binder_alloc_buf_failed;
 	}
@@ -3049,28 +3083,20 @@ static void binder_transaction(struct binder_proc *proc,
 				(const void __user *)
 					(uintptr_t)tr->data.ptr.offsets,
 				tr->offsets_size)) {
-		binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
-				proc->pid, thread->pid);
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -EFAULT;
-		return_error_line = __LINE__;
+		binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EFAULT,
+			"invalid offsets ptr");
 		goto err_copy_data_failed;
 	}
 	if (!IS_ALIGNED(tr->offsets_size, sizeof(binder_size_t))) {
-		binder_user_error("%d:%d got transaction with invalid offsets size, %lld\n",
-				proc->pid, thread->pid, (u64)tr->offsets_size);
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -EINVAL;
-		return_error_line = __LINE__;
+		binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EINVAL,
+			"invalid offsets size %lld",
+			(u64)tr->offsets_size);
 		goto err_bad_offset;
 	}
 	if (!IS_ALIGNED(extra_buffers_size, sizeof(u64))) {
-		binder_user_error("%d:%d got transaction with unaligned buffers size, %lld\n",
-				  proc->pid, thread->pid,
-				  (u64)extra_buffers_size);
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -EINVAL;
-		return_error_line = __LINE__;
+		binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EINVAL,
+			"unaligned buffers size %lld",
+			(u64)extra_buffers_size);
 		goto err_bad_offset;
 	}
 	off_start_offset = ALIGN(tr->data_size, sizeof(void *));
@@ -3093,9 +3119,8 @@ static void binder_transaction(struct binder_proc *proc,
 						  t->buffer,
 						  buffer_offset,
 						  sizeof(object_offset))) {
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EINVAL;
-			return_error_line = __LINE__;
+			binder_txn_error(e, &ee, BR_FAILED_REPLY, -EINVAL,
+				"copy offset from buffer failed");
 			goto err_bad_offset;
 		}
 
@@ -3110,24 +3135,17 @@ static void binder_transaction(struct binder_proc *proc,
 					t->buffer, user_offset,
 					user_buffer + user_offset,
 					copy_size))) {
-			binder_user_error("%d:%d got transaction with invalid data ptr\n",
-					proc->pid, thread->pid);
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EFAULT;
-			return_error_line = __LINE__;
+			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EFAULT,
+				"invalid buffer ptr");
 			goto err_copy_data_failed;
 		}
 		object_size = binder_get_object(target_proc, user_buffer,
 				t->buffer, object_offset, &object);
 		if (object_size == 0 || object_offset < off_min) {
-			binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
-					  proc->pid, thread->pid,
-					  (u64)object_offset,
-					  (u64)off_min,
-					  (u64)t->buffer->data_size);
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EINVAL;
-			return_error_line = __LINE__;
+			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EINVAL,
+				"invalid object or offset %lld min %lld max %lld",
+				(u64)object_offset, (u64)off_min,
+				(u64)t->buffer->data_size);
 			goto err_bad_offset;
 		}
 		/*
@@ -3151,9 +3169,8 @@ static void binder_transaction(struct binder_proc *proc,
 							t->buffer,
 							object_offset,
 							fp, sizeof(*fp))) {
-				return_error = BR_FAILED_REPLY;
-				return_error_param = ret;
-				return_error_line = __LINE__;
+				binder_txn_error(e, &ee, BR_FAILED_REPLY, ret,
+					"translate binder failed");
 				goto err_translate_failed;
 			}
 		} break;
@@ -3168,9 +3185,8 @@ static void binder_transaction(struct binder_proc *proc,
 							t->buffer,
 							object_offset,
 							fp, sizeof(*fp))) {
-				return_error = BR_FAILED_REPLY;
-				return_error_param = ret;
-				return_error_line = __LINE__;
+				binder_txn_error(e, &ee, BR_FAILED_REPLY, ret,
+					"translate handle failed");
 				goto err_translate_failed;
 			}
 		} break;
@@ -3188,9 +3204,8 @@ static void binder_transaction(struct binder_proc *proc,
 							t->buffer,
 							object_offset,
 							fp, sizeof(*fp))) {
-				return_error = BR_FAILED_REPLY;
-				return_error_param = ret;
-				return_error_line = __LINE__;
+				binder_txn_error(e, &ee, BR_FAILED_REPLY, ret,
+					"translate fd failed");
 				goto err_translate_failed;
 			}
 		} break;
@@ -3210,11 +3225,8 @@ static void binder_transaction(struct binder_proc *proc,
 						    &parent_offset,
 						    num_valid);
 			if (!parent) {
-				binder_user_error("%d:%d got transaction with invalid parent offset or type\n",
-						  proc->pid, thread->pid);
-				return_error = BR_FAILED_REPLY;
-				return_error_param = -EINVAL;
-				return_error_line = __LINE__;
+				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
+					-EINVAL, "bad parent offset or type");
 				goto err_bad_parent;
 			}
 			if (!binder_validate_fixup(target_proc, t->buffer,
@@ -3223,11 +3235,8 @@ static void binder_transaction(struct binder_proc *proc,
 						   fda->parent_offset,
 						   last_fixup_obj_off,
 						   last_fixup_min_off)) {
-				binder_user_error("%d:%d got transaction with out-of-order buffer fixup\n",
-						  proc->pid, thread->pid);
-				return_error = BR_FAILED_REPLY;
-				return_error_param = -EINVAL;
-				return_error_line = __LINE__;
+				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
+					-EINVAL, "out-of-order buffer fixup");
 				goto err_bad_parent;
 			}
 			/*
@@ -3238,13 +3247,10 @@ static void binder_transaction(struct binder_proc *proc,
 				binder_get_object(proc, user_buffer, t->buffer,
 						  parent_offset, &user_object);
 			if (user_parent_size != sizeof(user_object.bbo)) {
-				binder_user_error("%d:%d invalid ptr object size: %zd vs %zd\n",
-						  proc->pid, thread->pid,
-						  user_parent_size,
-						  sizeof(user_object.bbo));
-				return_error = BR_FAILED_REPLY;
-				return_error_param = -EINVAL;
-				return_error_line = __LINE__;
+				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
+					-EINVAL, "bad object size %zd vs %zd",
+					user_parent_size,
+					sizeof(user_object.bbo));
 				goto err_bad_parent;
 			}
 			ret = binder_translate_fd_array(&pf_head, fda,
@@ -3257,9 +3263,9 @@ static void binder_transaction(struct binder_proc *proc,
 								  object_offset,
 								  fda, sizeof(*fda));
 			if (ret) {
-				return_error = BR_FAILED_REPLY;
-				return_error_param = ret > 0 ? -EINVAL : ret;
-				return_error_line = __LINE__;
+				binder_txn_error(e, &ee, BR_FAILED_REPLY,
+					ret > 0 ? -EINVAL : ret,
+					"translate fd array failed");
 				goto err_translate_failed;
 			}
 			last_fixup_obj_off = parent_offset;
@@ -3273,20 +3279,16 @@ static void binder_transaction(struct binder_proc *proc,
 			size_t num_valid;
 
 			if (bp->length > buf_left) {
-				binder_user_error("%d:%d got transaction with too large buffer\n",
-						  proc->pid, thread->pid);
-				return_error = BR_FAILED_REPLY;
-				return_error_param = -EINVAL;
-				return_error_line = __LINE__;
+				binder_user_txn_error(e, &ee, BR_FAILED_REPLY,
+					-EINVAL, "buffer too large");
 				goto err_bad_offset;
 			}
 			ret = binder_defer_copy(&sgc_head, sg_buf_offset,
 				(const void __user *)(uintptr_t)bp->buffer,
 				bp->length);
 			if (ret) {
-				return_error = BR_FAILED_REPLY;
-				return_error_param = ret;
-				return_error_line = __LINE__;
+				binder_txn_error(e, &ee, BR_FAILED_REPLY, ret,
+					"deferred copy failed");
 				goto err_translate_failed;
 			}
 			/* Fixup buffer pointer to target proc address space */
@@ -3307,20 +3309,16 @@ static void binder_transaction(struct binder_proc *proc,
 							t->buffer,
 							object_offset,
 							bp, sizeof(*bp))) {
-				return_error = BR_FAILED_REPLY;
-				return_error_param = ret;
-				return_error_line = __LINE__;
+				binder_txn_error(e, &ee, BR_FAILED_REPLY, ret,
+					"failed to fixup parent");
 				goto err_translate_failed;
 			}
 			last_fixup_obj_off = object_offset;
 			last_fixup_min_off = 0;
 		} break;
 		default:
-			binder_user_error("%d:%d got transaction with invalid object type, %x\n",
-				proc->pid, thread->pid, hdr->type);
-			return_error = BR_FAILED_REPLY;
-			return_error_param = -EINVAL;
-			return_error_line = __LINE__;
+			binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EINVAL,
+				"bad object type %x", hdr->type);
 			goto err_bad_object_type;
 		}
 	}
@@ -3330,22 +3328,16 @@ static void binder_transaction(struct binder_proc *proc,
 				t->buffer, user_offset,
 				user_buffer + user_offset,
 				tr->data_size - user_offset)) {
-		binder_user_error("%d:%d got transaction with invalid data ptr\n",
-				proc->pid, thread->pid);
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -EFAULT;
-		return_error_line = __LINE__;
+		binder_user_txn_error(e, &ee, BR_FAILED_REPLY, -EFAULT,
+			"invalid data ptr");
 		goto err_copy_data_failed;
 	}
 
 	ret = binder_do_deferred_txn_copies(&target_proc->alloc, t->buffer,
 					    &sgc_head, &pf_head);
 	if (ret) {
-		binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
-				  proc->pid, thread->pid);
-		return_error = BR_FAILED_REPLY;
-		return_error_param = ret;
-		return_error_line = __LINE__;
+		binder_user_txn_error(e, &ee, BR_FAILED_REPLY, ret,
+			"deferred copy, invalid offsets ptr");
 		goto err_copy_data_failed;
 	}
 	if (t->buffer->oneway_spam_suspect)
@@ -3414,7 +3406,8 @@ static void binder_transaction(struct binder_proc *proc,
 	return;
 
 err_dead_proc_or_thread:
-	return_error_line = __LINE__;
+	binder_txn_error(e, &ee, return_error, -ESRCH,
+		"dead process or thread");
 	binder_dequeue_work(proc, tcomplete);
 err_translate_failed:
 err_bad_object_type:
@@ -3459,17 +3452,19 @@ static void binder_transaction(struct binder_proc *proc,
 	}
 
 	binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
-		     "%d:%d transaction failed %d/%d, size %lld-%lld line %d\n",
-		     proc->pid, thread->pid, return_error, return_error_param,
+		     "transaction %s from %d:%d to %d:%d failed, size %lld/%lld, error %d/%d/%d\n",
+		     reply ? "reply" :
+		     (tr->flags & TF_ONE_WAY ? "async" : "call"),
+		     proc->pid, thread->pid,
+		     target_proc ? target_proc->pid : 0,
+		     target_thread ? target_thread->pid : 0,
 		     (u64)tr->data_size, (u64)tr->offsets_size,
-		     return_error_line);
+		     ee.id, ee.command, ee.param);
 
 	{
 		struct binder_transaction_log_entry *fe;
 
-		e->return_error = return_error;
-		e->return_error_param = return_error_param;
-		e->return_error_line = return_error_line;
+		e->ee = ee;
 		fe = binder_transaction_log_add(&binder_transaction_log_failed);
 		*fe = *e;
 		/*
@@ -3483,11 +3478,15 @@ static void binder_transaction(struct binder_proc *proc,
 
 	BUG_ON(thread->return_error.cmd != BR_OK);
 	if (in_reply_to) {
+		binder_set_txn_from_error(in_reply_to, &ee);
 		thread->return_error.cmd = BR_TRANSACTION_COMPLETE;
 		binder_enqueue_thread_work(thread, &thread->return_error.work);
-		binder_send_failed_reply(in_reply_to, return_error);
+		binder_send_failed_reply(in_reply_to, ee.command);
 	} else {
-		thread->return_error.cmd = return_error;
+		thread->return_error.cmd = ee.command;
+		binder_inner_proc_lock(proc);
+		thread->ee = ee;
+		binder_inner_proc_unlock(proc);
 		binder_enqueue_thread_work(thread, &thread->return_error.work);
 	}
 }
@@ -4624,6 +4623,7 @@ static struct binder_thread *binder_get_thread_ilocked(
 	thread->return_error.cmd = BR_OK;
 	thread->reply_error.work.type = BINDER_WORK_RETURN_ERROR;
 	thread->reply_error.cmd = BR_OK;
+	thread->ee.command = BR_OK;
 	INIT_LIST_HEAD(&new_thread->waiting_thread_node);
 	return thread;
 }
@@ -5062,6 +5062,25 @@ static int binder_ioctl_get_freezer_info(
 	return 0;
 }
 
+static int binder_ioctl_get_extended_error(struct binder_thread *thread,
+					   void __user *ubuf)
+{
+	struct binder_extended_error *ee = &thread->ee;
+
+	binder_inner_proc_lock(thread->proc);
+	if (copy_to_user(ubuf, ee, sizeof(*ee))) {
+		binder_inner_proc_unlock(thread->proc);
+		return -EFAULT;
+	}
+
+	ee->id = 0;
+	ee->command = BR_OK;
+	ee->param = 0;
+	binder_inner_proc_unlock(thread->proc);
+
+	return 0;
+}
+
 static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int ret;
@@ -5270,6 +5289,11 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		binder_inner_proc_unlock(proc);
 		break;
 	}
+	case BINDER_GET_EXTENDED_ERROR:
+		ret = binder_ioctl_get_extended_error(thread, ubuf);
+		if (ret < 0)
+			goto err;
+		break;
 	default:
 		ret = -EINVAL;
 		goto err;
@@ -6172,13 +6196,12 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
 	 */
 	smp_rmb();
 	seq_printf(m,
-		   "%d: %s from %d:%d to %d:%d context %s node %d handle %d size %d:%d ret %d/%d l=%d",
+		   "%d: %s from %d:%d to %d:%d context %s node %d handle %d size %d:%d err %d/%d/%d: %s",
 		   e->debug_id, (e->call_type == 2) ? "reply" :
 		   ((e->call_type == 1) ? "async" : "call "), e->from_proc,
 		   e->from_thread, e->to_proc, e->to_thread, e->context_name,
 		   e->to_node, e->target_handle, e->data_size, e->offsets_size,
-		   e->return_error, e->return_error_param,
-		   e->return_error_line);
+		   e->ee.id, e->ee.command, e->ee.param, e->strerr);
 	/*
 	 * read-barrier to guarantee read of debug_id_done after
 	 * done printing the fields of the entry
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index d6b6b8cb7346..ab52743baf95 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -119,6 +119,7 @@ DEFINE_SHOW_ATTRIBUTE(binder_transactions);
 int binder_transaction_log_show(struct seq_file *m, void *unused);
 DEFINE_SHOW_ATTRIBUTE(binder_transaction_log);
 
+#define BINDER_STRERR_MAXLEN 63
 struct binder_transaction_log_entry {
 	int debug_id;
 	int debug_id_done;
@@ -131,9 +132,8 @@ struct binder_transaction_log_entry {
 	int to_node;
 	int data_size;
 	int offsets_size;
-	int return_error_line;
-	uint32_t return_error;
-	uint32_t return_error_param;
+	struct binder_extended_error ee;
+	char strerr[BINDER_STRERR_MAXLEN + 1];
 	char context_name[BINDERFS_MAX_NAME + 1];
 };
 
@@ -480,6 +480,8 @@ struct binder_proc {
  *                        (only accessed by this thread)
  * @reply_error:          transaction errors reported by target thread
  *                        (protected by @proc->inner_lock)
+ * @ee:                   extended error information from this thread
+ *                        (protected by @proc->inner_lock)
  * @wait:                 wait queue for thread work
  * @stats:                per-thread statistics
  *                        (atomics, no lock needed)
@@ -504,6 +506,7 @@ struct binder_thread {
 	bool process_todo;
 	struct binder_error return_error;
 	struct binder_error reply_error;
+	struct binder_extended_error ee;
 	wait_queue_head_t wait;
 	struct binder_stats stats;
 	atomic_t tmp_ref;
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e3605cdd4335..6c5e94f6cb3a 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -60,6 +60,7 @@ enum binderfs_stats_mode {
 
 struct binder_features {
 	bool oneway_spam_detection;
+	bool extended_error;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -75,6 +76,7 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
 
 static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
+	.extended_error = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -615,6 +617,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "extended_error",
+				      &binder_features_fops,
+				      &binder_features.extended_error);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 11157fae8a8e..e6ee8cae303b 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -236,6 +236,21 @@ struct binder_frozen_status_info {
 	__u32            async_recv;
 };
 
+/* struct binder_extened_error - extended error information
+ * @id:		identifier for the failed operation
+ * @command:	command as defined by binder_driver_return_protocol
+ * @param:	parameter holding a negative errno value
+ *
+ * Used with BINDER_GET_EXTENDED_ERROR. This extends the error information
+ * returned by the driver upon a failed operation. Userspace can pull this
+ * data to properly handle specific error scenarios.
+ */
+struct binder_extended_error {
+	__u32	id;
+	__u32	command;
+	__s32	param;
+};
+
 #define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
 #define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
 #define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
@@ -249,6 +264,7 @@ struct binder_frozen_status_info {
 #define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
 #define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_status_info)
 #define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
+#define BINDER_GET_EXTENDED_ERROR	_IOWR('b', 17, struct binder_extended_error)
 
 /*
  * NOTE: Two special error codes you should check for when calling
-- 
2.36.0.rc0.470.gd361397f0d-goog

