Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F5463E23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbhK3S4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245663AbhK3Szi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:55:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86292C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:52:19 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h15-20020a17090a648f00b001a96c2c97abso7260696pjj.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/x4shhy8P1gipGO2qyj7usThSAMQkMN2iF2OByB0V/o=;
        b=Cm70hsrsrudib05kVHncJdIXwt6nBgtVsgNJLvRu5+nP7ySNiBQHA6knfFo5Zo0P7P
         RQd5P7GtM4j5zTf0V8XMRWtPa88Z0mu5ESP1SKG2dBgb0R7GEP/zLsJ45fyZRBITs+56
         TEYjZ06WFKNSOdRakC2H1MTsxQ4fuQGd4aqxw96wjnS4s4RGNsLFjuKzBBZpbmXiEVjU
         9oU+hprXKEytuQRgSzyVsNCGZQa5fLxFSocGhRmOSOKFN0C+Vpo+YX50RFNF538hjl+z
         j9MBs3VMuuZEqwSKi+dDa8xaeAWq8Fq67dZ+iVDWihBwUoIYZ1VCJsn1tIBRy/Z7mlKT
         yxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/x4shhy8P1gipGO2qyj7usThSAMQkMN2iF2OByB0V/o=;
        b=JOMoLL9OTMu/1ZUf8q5rAwY/EVTJFUT7Tj0+Duh95M5PZKrXe31g+FOppvkrlXq+vG
         +gEzge2arcneBLd6BQZHTuVeED6S9gfLHmHanunuVQkQTiFDfDUNyHCPs1xilGqQ5eFB
         HQzJJh3HkIJXj6utqBAdRa44oBMmd5kjcGRFoxEPA3+M1sftTm3/4ns1AFkaaZWZbldn
         TcJi6nR5ZuRnLAgxaceqR+gPYEbvhnmDo9sw9JZmVbu9c0VpBhrr/vVuvXfX9fwY4TOC
         Btk0zc3K7SZTsUdWfMkLxd6ckzbbaitcludCMtVGa0oZIvR89XrhkxbX84/5zxPmsaJG
         34ng==
X-Gm-Message-State: AOAM5324TvNvpe5by2wJMCzSRHKJKP6TG1UZuXMW9CFt1EMwR9RvK9oo
        3CHLYKFKIFDDgwCXLgNlNkIUyaHo9w==
X-Google-Smtp-Source: ABdhPJztoFBmzaSNYWw1ElKlHnlfHYTXIpGjHCyNGky8A6Kva9DQSRjCflRUk31qgXugJ4QQE9QH3npnWw==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:2355:b4ef:3d57:5d7d])
 (user=tkjos job=sendgmr) by 2002:aa7:9575:0:b0:49f:ddab:dcdb with SMTP id
 x21-20020aa79575000000b0049fddabdcdbmr818875pfq.13.1638298339025; Tue, 30 Nov
 2021 10:52:19 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:51:51 -0800
In-Reply-To: <20211130185152.437403-1-tkjos@google.com>
Message-Id: <20211130185152.437403-4-tkjos@google.com>
Mime-Version: 1.0
References: <20211130185152.437403-1-tkjos@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 3/4] binder: read pre-translated fds from sender buffer
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

This patch is to prepare for an up coming patch where we read
pre-translated fds from the sender buffer and translate them before
copying them to the target.  It does not change run time.

The patch adds two new parameters to binder_translate_fd_array() to
hold the sender buffer and sender buffer parent.  These parameters let
us call copy_from_user() directly from the sender instead of using
binder_alloc_copy_from_buffer() to copy from the target.  Also the patch
adds some new alignment checks.  Previously the alignment checks would
have been done in a different place, but this lets us print more
useful error messages.

Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: Addressed comments from Dan Carpenter
- Re-wrote commit message as suggested
- renamed "u" and "user" locals to "sender_*" for clarity
- fixed printk format for size_t

 drivers/android/binder.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 3cd3e82866aa..9eb24d8a4d2f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2234,15 +2234,17 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 }
 
 static int binder_translate_fd_array(struct binder_fd_array_object *fda,
+				     const void __user *sender_ubuffer,
 				     struct binder_buffer_object *parent,
+				     struct binder_buffer_object *sender_uparent,
 				     struct binder_transaction *t,
 				     struct binder_thread *thread,
 				     struct binder_transaction *in_reply_to)
 {
 	binder_size_t fdi, fd_buf_size;
 	binder_size_t fda_offset;
+	const void __user *sender_ufda_base;
 	struct binder_proc *proc = thread->proc;
-	struct binder_proc *target_proc = t->to_proc;
 
 	fd_buf_size = sizeof(u32) * fda->num_fds;
 	if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
@@ -2266,7 +2268,10 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 	 */
 	fda_offset = (parent->buffer - (uintptr_t)t->buffer->user_data) +
 		fda->parent_offset;
-	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32))) {
+	sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
+
+	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32)) ||
+	    !IS_ALIGNED((unsigned long)sender_ufda_base, sizeof(u32))) {
 		binder_user_error("%d:%d parent offset not aligned correctly.\n",
 				  proc->pid, thread->pid);
 		return -EINVAL;
@@ -2275,10 +2280,9 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 		u32 fd;
 		int ret;
 		binder_size_t offset = fda_offset + fdi * sizeof(fd);
+		binder_size_t sender_uoffset = fdi * sizeof(fd);
 
-		ret = binder_alloc_copy_from_buffer(&target_proc->alloc,
-						    &fd, t->buffer,
-						    offset, sizeof(fd));
+		ret = copy_from_user(&fd, sender_ufda_base + sender_uoffset, sizeof(fd));
 		if (!ret)
 			ret = binder_translate_fd(fd, offset, t, thread,
 						  in_reply_to);
@@ -2951,6 +2955,8 @@ static void binder_transaction(struct binder_proc *proc,
 		case BINDER_TYPE_FDA: {
 			struct binder_object ptr_object;
 			binder_size_t parent_offset;
+			struct binder_object user_object;
+			size_t user_parent_size;
 			struct binder_fd_array_object *fda =
 				to_binder_fd_array_object(hdr);
 			size_t num_valid = (buffer_offset - off_start_offset) /
@@ -2982,8 +2988,27 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_bad_parent;
 			}
-			ret = binder_translate_fd_array(fda, parent, t, thread,
-							in_reply_to);
+			/*
+			 * We need to read the user version of the parent
+			 * object to get the original user offset
+			 */
+			user_parent_size =
+				binder_get_object(proc, user_buffer, t->buffer,
+						  parent_offset, &user_object);
+			if (user_parent_size != sizeof(user_object.bbo)) {
+				binder_user_error("%d:%d invalid ptr object size: %zd vs %zd\n",
+						  proc->pid, thread->pid,
+						  user_parent_size,
+						  sizeof(user_object.bbo));
+				return_error = BR_FAILED_REPLY;
+				return_error_param = -EINVAL;
+				return_error_line = __LINE__;
+				goto err_bad_parent;
+			}
+			ret = binder_translate_fd_array(fda, user_buffer,
+							parent,
+							&user_object.bbo, t,
+							thread, in_reply_to);
 			if (!ret)
 				ret = binder_alloc_copy_to_buffer(&target_proc->alloc,
 								  t->buffer,
-- 
2.34.0.rc2.393.gf8c9666880-goog

