Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A350A517F87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiECIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiECIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:14:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84866C48
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:11:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c14so5292761pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0k7GxLPIhyL0gTJPmTebLo5sk86kcYNxfTBPukwHWk=;
        b=wqk9tirp24ymGq2LY6Ox/38XRI3ezs+DSs5ZB0hX5L6VoonTH5M+cWn83oXFJUKnIX
         RaXWpKxGduurZtGEGIdengF/QY/2YgTXFecZeDhXEbUQt7EbWZnW0bimOyLEICRVfP+t
         rXt47/JGtHbztjhzPnvZOe/bOgRZIH1WlUMRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0k7GxLPIhyL0gTJPmTebLo5sk86kcYNxfTBPukwHWk=;
        b=duYaVjT5+5cX9+mI3pP8ly37dJOkMeu9R6CFSX5yksJ1PqU4ZpLCDflP3IwWER0MC7
         yPPtmGTzZBKJVCg5mJpzjSRRwLoOFxGIduRMju9v2AdRpMpNa00Kr+dHF+q96EtKQnnI
         ph90d7gPCn0BLeRMaX8kmOwxG04iH4kaGdd8Xq1HTnyMnrWhXpIVuZ8He2UuRN66fBB9
         oAu5NVqAyb2Pp4ZOvEgP9WdRypUE3gf/dl2FX3S9LU0TbmS8HHgpBav6FPJnoIOjNRzt
         zaXYQWgdy0JsBG7Gru9usZOVldNK3IH55DM5ZOy/5OT9ankpNX6T1HneCavRttNVb+Sy
         F0iA==
X-Gm-Message-State: AOAM531clMa7Kw18wVALCHl3YCJmw9e4O3D9l4WSnPWWh7Rg49GWqgDQ
        g5swa45yOv/FcwzbGjH+JS5rKQ==
X-Google-Smtp-Source: ABdhPJxD6DE1CrGCzrcKsj1Uel6j/vb8gBYFKmfwZalXNg1+0AreOVWCS2szt1dr5yaZY97Rem9E3w==
X-Received: by 2002:a63:a01:0:b0:39d:ac8f:d24f with SMTP id 1-20020a630a01000000b0039dac8fd24fmr12599285pgk.610.1651565471732;
        Tue, 03 May 2022 01:11:11 -0700 (PDT)
Received: from localhost.localdomain (99-0-82-137.lightspeed.sntcca.sbcglobal.net. [99.0.82.137])
        by smtp.gmail.com with ESMTPSA id h2-20020aa786c2000000b0050dc762815dsm5821069pfo.55.2022.05.03.01.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 01:11:11 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tycho Andersen <tycho@tycho.pizza>,
        Alban Crequy <alban@kinvolk.io>
Subject: [PATCH v4 1/3] seccomp: Add wait_killable semantic to seccomp user notifier
Date:   Tue,  3 May 2022 01:09:56 -0700
Message-Id: <20220503080958.20220-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503080958.20220-1-sargun@sargun.me>
References: <20220503080958.20220-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a per-filter flag (SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
that makes it so that when notifications are received by the supervisor the
notifying process will transition to wait killable semantics. Although wait
killable isn't a set of semantics formally exposed to userspace, the
concept is searchable. If the notifying process is signaled prior to the
notification being received by the userspace agent, it will be handled as
normal.

One quirk about how this is handled is that the notifying process
only switches to TASK_KILLABLE if it receives a wakeup from either
an addfd or a signal. This is to avoid an unnecessary wakeup of
the notifying task.

The reasons behind switching into wait_killable only after userspace
receives the notification are:
* Avoiding unncessary work - Often, workloads will perform work that they
  may abort (request racing comes to mind). This allows for syscalls to be
  aborted safely prior to the notification being received by the
  supervisor. In this, the supervisor doesn't end up doing work that the
  workload does not want to complete anyways.
* Avoiding side effects - We don't want the syscall to be interruptible
  once the supervisor starts doing work because it may not be trivial
  to reverse the operation. For example, unmounting a file system may
  take a long time, and it's hard to rollback, or treat that as
  reentrant.
* Avoid breaking runtimes - Various runtimes do not GC when they are
  during a syscall (or while running native code that subsequently
  calls a syscall). If many notifications are blocked, and not picked
  up by the supervisor, this can get the application into a bad state.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 .../userspace-api/seccomp_filter.rst          | 10 +++++
 include/linux/seccomp.h                       |  3 +-
 include/uapi/linux/seccomp.h                  |  2 +
 kernel/seccomp.c                              | 42 ++++++++++++++++++-
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index 539e9d4a4860..d1e2b9193f09 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -271,6 +271,16 @@ notifying process it will be replaced. The supervisor can also add an FD, and
 respond atomically by using the ``SECCOMP_ADDFD_FLAG_SEND`` flag and the return
 value will be the injected file descriptor number.
 
+The notifying process can be preempted, resulting in the notification being
+aborted. This can be problematic when trying to take actions on behalf of the
+notifying process that are long-running and typically retryable (mounting a
+filesytem). Alternatively, at filter installation time, the
+``SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV`` flag can be set. This flag makes it
+such that when a user notification is received by the supervisor, the notifying
+process will ignore non-fatal signals until the response is sent. Signals that
+are sent prior to the notification being received by userspace are handled
+normally.
+
 It is worth noting that ``struct seccomp_data`` contains the values of register
 arguments to the syscall, but does not contain pointers to memory. The task's
 memory is accessible to suitably privileged traces via ``ptrace()`` or
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 0c564e5d40ff..d31d76be4982 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -8,7 +8,8 @@
 					 SECCOMP_FILTER_FLAG_LOG | \
 					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
 					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
-					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH)
+					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH | \
+					 SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
 
 /* sizeof() the first published struct seccomp_notif_addfd */
 #define SECCOMP_NOTIFY_ADDFD_SIZE_VER0 24
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 78074254ab98..0fdc6ef02b94 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -23,6 +23,8 @@
 #define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
 #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
+/* Received notifications wait in killable state (only respond to fatal signals) */
+#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
 
 /*
  * All BPF programs must return a 32-bit value.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 2cb3bcd90eb3..8b416356bf43 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -201,6 +201,8 @@ static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
  *	   the filter can be freed.
  * @cache: cache of arch/syscall mappings to actions
  * @log: true if all actions except for SECCOMP_RET_ALLOW should be logged
+ * @wait_killable_recv: Put notifying process in killable state once the
+ *			notification is received by the userspace listener.
  * @prev: points to a previously installed, or inherited, filter
  * @prog: the BPF program to evaluate
  * @notif: the struct that holds all notification related information
@@ -221,6 +223,7 @@ struct seccomp_filter {
 	refcount_t refs;
 	refcount_t users;
 	bool log;
+	bool wait_killable_recv;
 	struct action_cache cache;
 	struct seccomp_filter *prev;
 	struct bpf_prog *prog;
@@ -894,6 +897,10 @@ static long seccomp_attach_filter(unsigned int flags,
 	if (flags & SECCOMP_FILTER_FLAG_LOG)
 		filter->log = true;
 
+	/* Set wait killable flag, if present. */
+	if (flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
+		filter->wait_killable_recv = true;
+
 	/*
 	 * If there is an existing filter, make it the prev and don't drop its
 	 * task reference.
@@ -1081,6 +1088,12 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
 	complete(&addfd->completion);
 }
 
+static bool should_sleep_killable(struct seccomp_filter *match,
+				  struct seccomp_knotif *n)
+{
+	return match->wait_killable_recv && n->state == SECCOMP_NOTIFY_SENT;
+}
+
 static int seccomp_do_user_notification(int this_syscall,
 					struct seccomp_filter *match,
 					const struct seccomp_data *sd)
@@ -1111,11 +1124,25 @@ static int seccomp_do_user_notification(int this_syscall,
 	 * This is where we wait for a reply from userspace.
 	 */
 	do {
+		bool wait_killable = should_sleep_killable(match, &n);
+
 		mutex_unlock(&match->notify_lock);
-		err = wait_for_completion_interruptible(&n.ready);
+		if (wait_killable)
+			err = wait_for_completion_killable(&n.ready);
+		else
+			err = wait_for_completion_interruptible(&n.ready);
 		mutex_lock(&match->notify_lock);
-		if (err != 0)
+
+		if (err != 0) {
+			/*
+			 * Check to see if the notifcation got picked up and
+			 * whether we should switch to wait killable.
+			 */
+			if (!wait_killable && should_sleep_killable(match, &n))
+				continue;
+
 			goto interrupted;
+		}
 
 		addfd = list_first_entry_or_null(&n.addfd,
 						 struct seccomp_kaddfd, list);
@@ -1485,6 +1512,9 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		mutex_lock(&filter->notify_lock);
 		knotif = find_notification(filter, unotif.id);
 		if (knotif) {
+			/* Reset the process to make sure it's not stuck */
+			if (should_sleep_killable(filter, knotif))
+				complete(&knotif->ready);
 			knotif->state = SECCOMP_NOTIFY_INIT;
 			up(&filter->notif->request);
 		}
@@ -1830,6 +1860,14 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	    ((flags & SECCOMP_FILTER_FLAG_TSYNC_ESRCH) == 0))
 		return -EINVAL;
 
+	/*
+	 * The SECCOMP_FILTER_FLAG_WAIT_KILLABLE_SENT flag doesn't make sense
+	 * without the SECCOMP_FILTER_FLAG_NEW_LISTENER flag.
+	 */
+	if ((flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV) &&
+	    ((flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) == 0))
+		return -EINVAL;
+
 	/* Prepare the new filter before holding any locks. */
 	prepared = seccomp_prepare_user_filter(filter);
 	if (IS_ERR(prepared))
-- 
2.25.1

