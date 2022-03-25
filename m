Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800574E7D05
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiCYX0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiCYX0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:26:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A01EC50
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:25:11 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s5-20020a170902b18500b00155d6fbf4d4so1407954plr.18
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=218M8S6rpN1tjWPlLmu1BZS8TBOjoxxjsC4IIudMMHc=;
        b=ZbX2N7U15fyZlsRUp56vc9Adeb4z13lrInglE6IwMq+W78XXyK2GGnBdYYSGka0b7E
         egahMoomYDJcLwcZSSNryg12n9TpHk6+p3A5NnrSqFjUiugncqryCUlUfg4RpPPHovX3
         4oJkd9dp+i/j//ljDnTZGa2i6L45yoQB1pX3ugypUUrpNynYSOcjH6jff7RVO1y/GvnS
         wdEqcDBrW96kWTyvVCjW3YlwczfkTIKhrOlZy1LyffQ69lteohVYAJXEnApJUBwrd/Gc
         R5w/OOV+j54U/YFgF5Qgnh1fTngiCK61f3ivO54N6WKjTtbcB0jZqK8CcjwXYVJ89Gm7
         qHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=218M8S6rpN1tjWPlLmu1BZS8TBOjoxxjsC4IIudMMHc=;
        b=EF83sCmm7/WdanXxJ3mfXNawdTQvoY0cKzOOAfNrbKr8DraKub4pW4mXSM2B16NL76
         gmwV3qRyCI1tirIEtInC+1bV4+Ks/1PYM9rmr4GJ0//kaBzh9boNxcY+Bh4rxWD8O2yz
         g9LK7yzwMlVk7QuLIF9CZ7ZPRaItFxnnI/8OQNnDrDlUtbubnqeFyP4w8qSP2xStTpF8
         rmeK/yhy3/tp8o+WQAyWD5sKLLh/NU5eIHAL363FTSzfUizI+C7/4buVIDRDTfKET7E0
         w2/9J7fzpXrFHHR0+4IbJz3Jg6GNd2ODxHRGWtqTSYua4hc8tUhQWOrmdXM+6UEk30P0
         xgkw==
X-Gm-Message-State: AOAM53374wKpozxcTw8VUaNeTeCIMkQUOxu7qSqt5NiI9O4zELySMsIj
        bcebT39fN98htfp7eGqI6xMzJxRk46GhOA==
X-Google-Smtp-Source: ABdhPJzT3aT6Rh5BRrXhl8dxnjFUbcWyPERL8lMjcEoXdjV+TkBFuevDmGB0IZSjyrFOZlD3YUGN4r5ZyQw+Og==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:aa7:88d2:0:b0:4f7:78d4:de98 with SMTP id
 k18-20020aa788d2000000b004f778d4de98mr11889500pff.25.1648250710576; Fri, 25
 Mar 2022 16:25:10 -0700 (PDT)
Date:   Fri, 25 Mar 2022 23:24:54 +0000
Message-Id: <20220325232454.2210817-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] binder: hold fd_install until allocating fds first
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al noted in [1] that fd_install can't be undone, so it must come last in
the fd translation sequence, only after we've successfully reserved all
descriptors and copied them into the transaction buffer.

This patch takes Al's proposed fix in [2] and makes a few tweaks to fold
the traversal of t->fd_fixups during release.

[1] https://lore.kernel.org/driverdev-devel/YHnJwRvUhaK3IM0l@zeniv-ca.linux.org.uk
[2] https://lore.kernel.org/driverdev-devel/YHo6Ln9VI1T7RmLK@zeniv-ca.linux.org.uk

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c          | 34 ++++++++++++-------------------
 drivers/android/binder_internal.h |  2 ++
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..bfadc0c4a442 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1481,6 +1481,8 @@ static void binder_free_txn_fixups(struct binder_transaction *t)
 
 	list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
 		fput(fixup->file);
+		if (fixup->target_fd >= 0)
+			put_unused_fd(fixup->target_fd);
 		list_del(&fixup->fixup_entry);
 		kfree(fixup);
 	}
@@ -2220,6 +2222,7 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 	}
 	fixup->file = file;
 	fixup->offset = fd_offset;
+	fixup->target_fd = -1;
 	trace_binder_transaction_fd_send(t, fd, fixup->offset);
 	list_add_tail(&fixup->fixup_entry, &t->fd_fixups);
 
@@ -4067,10 +4070,9 @@ static int binder_wait_for_work(struct binder_thread *thread,
  * Now that we are in the context of the transaction target
  * process, we can allocate and install fds. Process the
  * list of fds to translate and fixup the buffer with the
- * new fds.
+ * new fds first and only then install the files.
  *
- * If we fail to allocate an fd, then free the resources by
- * fput'ing files that have not been processed and ksys_close'ing
+ * If we fail to allocate an fd, skip the install and release
  * any fds that have already been allocated.
  */
 static int binder_apply_fd_fixups(struct binder_proc *proc,
@@ -4087,41 +4089,31 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
 				     "failed fd fixup txn %d fd %d\n",
 				     t->debug_id, fd);
 			ret = -ENOMEM;
-			break;
+			goto err;
 		}
 		binder_debug(BINDER_DEBUG_TRANSACTION,
 			     "fd fixup txn %d fd %d\n",
 			     t->debug_id, fd);
 		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
-		fd_install(fd, fixup->file);
-		fixup->file = NULL;
+		fixup->target_fd = fd;
 		if (binder_alloc_copy_to_buffer(&proc->alloc, t->buffer,
 						fixup->offset, &fd,
 						sizeof(u32))) {
 			ret = -EINVAL;
-			break;
+			goto err;
 		}
 	}
 	list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
-		if (fixup->file) {
-			fput(fixup->file);
-		} else if (ret) {
-			u32 fd;
-			int err;
-
-			err = binder_alloc_copy_from_buffer(&proc->alloc, &fd,
-							    t->buffer,
-							    fixup->offset,
-							    sizeof(fd));
-			WARN_ON(err);
-			if (!err)
-				binder_deferred_fd_close(fd);
-		}
+		fd_install(fixup->target_fd, fixup->file);
 		list_del(&fixup->fixup_entry);
 		kfree(fixup);
 	}
 
 	return ret;
+
+err:
+	binder_free_txn_fixups(t);
+	return ret;
 }
 
 static int binder_thread_read(struct binder_proc *proc,
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index d6b6b8cb7346..cf70a104594d 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -515,6 +515,7 @@ struct binder_thread {
  * @fixup_entry:          list entry
  * @file:                 struct file to be associated with new fd
  * @offset:               offset in buffer data to this fixup
+ * @target_fd:            fd to use by the target to install @file
  *
  * List element for fd fixups in a transaction. Since file
  * descriptors need to be allocated in the context of the
@@ -525,6 +526,7 @@ struct binder_txn_fd_fixup {
 	struct list_head fixup_entry;
 	struct file *file;
 	size_t offset;
+	int target_fd;
 };
 
 struct binder_transaction {
-- 
2.35.1.1021.g381101b075-goog

