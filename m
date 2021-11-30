Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B712B463E22
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbhK3Sz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245650AbhK3Szh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:55:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9273DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:52:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so30946507ybt.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=of0clxo+OUXJ+D9ZQAgRKxW9x8/3qof7PuEyD5JF4z0=;
        b=V4Z5gcj0BYi4gx7/YsjqicwVo1l0VNNMxRonM2GjGzGw6k9NcPd1nW8lwTW4Xcalo0
         qndlcHRRimUz8jAL3AGwu21xTSx6fGAQFBHTx5QdUNiLV93dJxq+9tKZSpq6Um5AHyEv
         /v2gqA0HxEdQcryEhGG22ykkVgYrCOSIaT1h4mpzuRxErzfEAlkS7nKmXusruXye2KD5
         fnNWg1Pwi90P9fclLml3cD89IK6l2ANOHwPYQAFgLZ3wJRdb1cCvuWf2VqVfBzs6uCI0
         nsMm7D5feU+hGxoFBzFzLZJLqc9CwxnOitpnBuuO4B5yrs2YkX2DAa0BWzY9TYZPuXPY
         kV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=of0clxo+OUXJ+D9ZQAgRKxW9x8/3qof7PuEyD5JF4z0=;
        b=0ny1gu7cBnDyG4RkyLVJPcPP7lsHxNkHxt7ev57Wr+FSliRS1XGPL3h2pKgP2tt/T7
         bQlesLvBGv1XQPPTUFU9DWjXOsqT/cC/CtNG64H/3vtGYig7q91Mh3EY3hS6uMhbxEkR
         Wh/hIsP+yMJSo/Bf1qxAaGgD47dbubWpP0M4HoH+7QgIVCwgL8hJZrdHdpNjKgAMSOql
         KroUvJ2sBZwasLjM2R2tH4/V3m2ZRyZRSNlsd8239iRXBXSCqcXReqdJx379Fi3KoJuC
         7tRuTfm0WuBBEnsfY70ylvt+9paiZspQI6SIi9X+bdnvsRzVtuO6JshRrvuLLphKJwLe
         WWfw==
X-Gm-Message-State: AOAM530EQeHBJlzcDA2BIn652+EzF0TnA1BWuyRVFW4HC+syJlA2pjvO
        /Gvr64C6jCke0XD5Ji1QXk/C0oRibg==
X-Google-Smtp-Source: ABdhPJwtVbLnTCydZzXC3IHcaUyY3GTePtB88YcCxKR6GlEHVVb4quJRWNPr3ZLNIGkjLwxfgxoFjX2i9g==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:2355:b4ef:3d57:5d7d])
 (user=tkjos job=sendgmr) by 2002:a25:42:: with SMTP id 63mr1034493yba.218.1638298336836;
 Tue, 30 Nov 2021 10:52:16 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:51:50 -0800
In-Reply-To: <20211130185152.437403-1-tkjos@google.com>
Message-Id: <20211130185152.437403-3-tkjos@google.com>
Mime-Version: 1.0
References: <20211130185152.437403-1-tkjos@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 2/4] binder: avoid potential data leakage when copying txn
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com, avakj45@gmail.com,
        Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transactions are copied from the sender to the target
first and objects like BINDER_TYPE_PTR and BINDER_TYPE_FDA
are then fixed up. This means there is a short period where
the sender's version of these objects are visible to the
target prior to the fixups.

Instead of copying all of the data first, copy data only
after any needed fixups have been applied.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: addressed comments from Dan Carpenter
- added Fixes tag
- fixed incorrect handling of binder_alloc_copy_to_buffer() error
- fixed printk format for size_t

 drivers/android/binder.c | 94 ++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 24 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 984e6263dcc7..3cd3e82866aa 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1608,15 +1608,21 @@ static void binder_cleanup_transaction(struct binder_transaction *t,
 /**
  * binder_get_object() - gets object and checks for valid metadata
  * @proc:	binder_proc owning the buffer
+ * @u:		sender's user pointer to base of buffer
  * @buffer:	binder_buffer that we're parsing.
  * @offset:	offset in the @buffer at which to validate an object.
  * @object:	struct binder_object to read into
  *
- * Return:	If there's a valid metadata object at @offset in @buffer, the
+ * Copy the binder object at the given offset into @object. If @u is
+ * provided then the copy is from the sender's buffer. If not, then
+ * it is copied from the target's @buffer.
+ *
+ * Return:	If there's a valid metadata object at @offset, the
  *		size of that object. Otherwise, it returns zero. The object
  *		is read into the struct binder_object pointed to by @object.
  */
 static size_t binder_get_object(struct binder_proc *proc,
+				const void __user *u,
 				struct binder_buffer *buffer,
 				unsigned long offset,
 				struct binder_object *object)
@@ -1626,10 +1632,16 @@ static size_t binder_get_object(struct binder_proc *proc,
 	size_t object_size = 0;
 
 	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-	if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
-	    binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
-					  offset, read_size))
+	if (offset > buffer->data_size || read_size < sizeof(*hdr))
 		return 0;
+	if (u) {
+		if (copy_from_user(object, u + offset, read_size))
+			return 0;
+	} else {
+		if (binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
+						  offset, read_size))
+			return 0;
+	}
 
 	/* Ok, now see if we read a complete object. */
 	hdr = &object->hdr;
@@ -1702,7 +1714,7 @@ static struct binder_buffer_object *binder_validate_ptr(
 					  b, buffer_offset,
 					  sizeof(object_offset)))
 		return NULL;
-	object_size = binder_get_object(proc, b, object_offset, object);
+	object_size = binder_get_object(proc, NULL, b, object_offset, object);
 	if (!object_size || object->hdr.type != BINDER_TYPE_PTR)
 		return NULL;
 	if (object_offsetp)
@@ -1767,7 +1779,8 @@ static bool binder_validate_fixup(struct binder_proc *proc,
 		unsigned long buffer_offset;
 		struct binder_object last_object;
 		struct binder_buffer_object *last_bbo;
-		size_t object_size = binder_get_object(proc, b, last_obj_offset,
+		size_t object_size = binder_get_object(proc, NULL, b,
+						       last_obj_offset,
 						       &last_object);
 		if (object_size != sizeof(*last_bbo))
 			return false;
@@ -1882,7 +1895,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		if (!binder_alloc_copy_from_buffer(&proc->alloc, &object_offset,
 						   buffer, buffer_offset,
 						   sizeof(object_offset)))
-			object_size = binder_get_object(proc, buffer,
+			object_size = binder_get_object(proc, NULL, buffer,
 							object_offset, &object);
 		if (object_size == 0) {
 			pr_err("transaction release %d bad object at offset %lld, size %zd\n",
@@ -2455,6 +2468,7 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_size_t off_start_offset, off_end_offset;
 	binder_size_t off_min;
 	binder_size_t sg_buf_offset, sg_buf_end_offset;
+	binder_size_t user_offset = 0;
 	struct binder_proc *target_proc = NULL;
 	struct binder_thread *target_thread = NULL;
 	struct binder_node *target_node = NULL;
@@ -2469,6 +2483,8 @@ static void binder_transaction(struct binder_proc *proc,
 	int t_debug_id = atomic_inc_return(&binder_last_id);
 	char *secctx = NULL;
 	u32 secctx_sz = 0;
+	const void __user *user_buffer = (const void __user *)
+				(uintptr_t)tr->data.ptr.buffer;
 
 	e = binder_transaction_log_add(&binder_transaction_log);
 	e->debug_id = t_debug_id;
@@ -2780,19 +2796,6 @@ static void binder_transaction(struct binder_proc *proc,
 	t->buffer->clear_on_free = !!(t->flags & TF_CLEAR_BUF);
 	trace_binder_transaction_alloc_buf(t->buffer);
 
-	if (binder_alloc_copy_user_to_buffer(
-				&target_proc->alloc,
-				t->buffer, 0,
-				(const void __user *)
-					(uintptr_t)tr->data.ptr.buffer,
-				tr->data_size)) {
-		binder_user_error("%d:%d got transaction with invalid data ptr\n",
-				proc->pid, thread->pid);
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -EFAULT;
-		return_error_line = __LINE__;
-		goto err_copy_data_failed;
-	}
 	if (binder_alloc_copy_user_to_buffer(
 				&target_proc->alloc,
 				t->buffer,
@@ -2837,6 +2840,7 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t object_size;
 		struct binder_object object;
 		binder_size_t object_offset;
+		binder_size_t copy_size;
 
 		if (binder_alloc_copy_from_buffer(&target_proc->alloc,
 						  &object_offset,
@@ -2848,8 +2852,27 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error_line = __LINE__;
 			goto err_bad_offset;
 		}
-		object_size = binder_get_object(target_proc, t->buffer,
-						object_offset, &object);
+
+		/*
+		 * Copy the source user buffer up to the next object
+		 * that will be processed.
+		 */
+		copy_size = object_offset - user_offset;
+		if (copy_size && (user_offset > object_offset ||
+				binder_alloc_copy_user_to_buffer(
+					&target_proc->alloc,
+					t->buffer, user_offset,
+					user_buffer + user_offset,
+					copy_size))) {
+			binder_user_error("%d:%d got transaction with invalid data ptr\n",
+					proc->pid, thread->pid);
+			return_error = BR_FAILED_REPLY;
+			return_error_param = -EFAULT;
+			return_error_line = __LINE__;
+			goto err_copy_data_failed;
+		}
+		object_size = binder_get_object(target_proc, user_buffer,
+				t->buffer, object_offset, &object);
 		if (object_size == 0 || object_offset < off_min) {
 			binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
 					  proc->pid, thread->pid,
@@ -2861,6 +2884,11 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error_line = __LINE__;
 			goto err_bad_offset;
 		}
+		/*
+		 * Set offset to the next buffer fragment to be
+		 * copied
+		 */
+		user_offset = object_offset + object_size;
 
 		hdr = &object.hdr;
 		off_min = object_offset + object_size;
@@ -2956,9 +2984,14 @@ static void binder_transaction(struct binder_proc *proc,
 			}
 			ret = binder_translate_fd_array(fda, parent, t, thread,
 							in_reply_to);
-			if (ret < 0) {
+			if (!ret)
+				ret = binder_alloc_copy_to_buffer(&target_proc->alloc,
+								  t->buffer,
+								  object_offset,
+								  fda, sizeof(*fda));
+			if (ret) {
 				return_error = BR_FAILED_REPLY;
-				return_error_param = ret;
+				return_error_param = ret > 0 ? -EINVAL : ret;
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
@@ -3028,6 +3061,19 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_bad_object_type;
 		}
 	}
+	/* Done processing objects, copy the rest of the buffer */
+	if (binder_alloc_copy_user_to_buffer(
+				&target_proc->alloc,
+				t->buffer, user_offset,
+				user_buffer + user_offset,
+				tr->data_size - user_offset)) {
+		binder_user_error("%d:%d got transaction with invalid data ptr\n",
+				proc->pid, thread->pid);
+		return_error = BR_FAILED_REPLY;
+		return_error_param = -EFAULT;
+		return_error_line = __LINE__;
+		goto err_copy_data_failed;
+	}
 	if (t->buffer->oneway_spam_suspect)
 		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
 	else
-- 
2.34.0.rc2.393.gf8c9666880-goog

