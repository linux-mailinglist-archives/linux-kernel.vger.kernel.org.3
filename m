Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04C25A8C01
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 05:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiIADpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 23:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiIADpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:45:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F022B6FA24
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:45:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n8-20020a17090a73c800b001fd832b54f6so1309515pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date;
        bh=RRQcS6YOiQrT7W3soQAH1RCHMOwkP0wAZt0LcaapkYM=;
        b=WzK339MzLX+U/lfEGltakgYN5MDWfeK714Y5mgS4if153zCpWSbvhKFduM3jaHSxep
         egmwi40WKacotUUPSfJSwdbQ1DafYIWG6yytlI1Xuk9kjsExbcFIOq6DY4TOV2HnrPCF
         TaJZtHhG3Dmvc1NkKQSf/V9wCoZviWiCa//iUBzEC+BmGFrpqsaMfbPI9jz7NfVW0Yew
         y9OHYr3OaE4vt1hZWqVdnLgG/iK9IFMTf4EQ8BMtAENbUWaH/nLc5uj4z4F3jUWno0kT
         YEoB/NMlGiyr5pu+PmPoMhhfocS+zpZJREF6NLgIGCQoNxbK8NdiWsvld60CM+XKmmdP
         z6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RRQcS6YOiQrT7W3soQAH1RCHMOwkP0wAZt0LcaapkYM=;
        b=whP+NrW66HWePtHRWrmUnrI6T3yFOt/SXcCrzWJV4LWsl3NN8Ksi2UXklGMQ7YIJah
         Natv/nxWvYwxAmbRVh+njauAVRxgVljno9TrGoBPw0iOPbUsWnpeeo2/83RRVD0Inapl
         MprC7hYayQR4lTm9+Oqmy/Ka7iS2v/tKAtG2SzFhIvQfm8sW1VlKwaCdvkGp1rVV13+U
         wJH661S53CmYg/c00wUJSHc9bfPtE6lv9x5NxjtfmzxfIWJJ3AAgnZo6iOjQzdqSDOrO
         7VZYYSluZMisanF0jYy9V0PcJRUnSq+JqkJsFGHI7cmko9tz8P1SrkNWZ5xy2airmdl8
         oemQ==
X-Gm-Message-State: ACgBeo1EQadyuN6OJ4j2/Uhqyt6D+ZNoOgoi9KhUxau5GsAK9UlsS+3v
        54TlnnIYFkc23M9iMBq2rWTCVD1b95A=
X-Google-Smtp-Source: AA6agR7hlfHz8t8+9Pcyl+mlx2O5Jo+PLzGY7gqq407z+71GK8CyE90lXLnNbYi/tA+2OJzFN4Jo1Q==
X-Received: by 2002:a17:902:b086:b0:171:2632:cd3b with SMTP id p6-20020a170902b08600b001712632cd3bmr29705568plr.111.1662003933132;
        Wed, 31 Aug 2022 20:45:33 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902f60a00b001714853e503sm12457643plg.36.2022.08.31.20.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 20:45:32 -0700 (PDT)
Date:   Wed, 31 Aug 2022 20:45:30 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Izbyshev <izbyshev@ispras.ru>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
Message-ID: <YxAq2jYvGG8QOypu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CANaxB-xqpZcVObpGCBsBXNVN7a2CZ7=_CaPZp4mG50Bi0oVDmA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 6:18 PM Andrei Vagin <avagin@gmail.com> wrote:
>On Tue, Aug 30, 2022 at 10:49:43PM +0300, Alexey Izbyshev wrote:
<snip>
>> @@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
>>         tsk->mm->vmacache_seqnum = 0;
>>         vmacache_flush(tsk);
>>         task_unlock(tsk);
>> +
>> +       if (vfork)
>> +               timens_on_fork(tsk->nsproxy, tsk);
>> +
>> 
>> Similarly, even after a normal vfork(), time namespace switch could be
>> silently skipped if the parent dies before "tsk->vfork_done" is read. Again,
>> I don't know whether anybody cares, but this behavior seems non-obvious and
>> probably unintended to me.
> This is the more interesting case. I will try to find out how we can
> handle it properly.

It might not be a good idea to use vfork_done in this case. Let's
think about what we have and what we want to change. We don't want to
allow switching timens if a process mm is used by someone else. But we
forgot to handle execve that creates a new mm, and we can't change this
behavior right now because it can affect current users. Right?

So maybe the best choice, in this case, is to change behavior by adding
a new control that enables it. The first interface that comes to my mind
is to introduce a new ioctl for a namespace file descriptor. Here is a
draft patch below that should help to understand what I mean.

---
 fs/exec.c                                   |  4 +---
 fs/nsfs.c                                   |  3 +++
 include/linux/proc_ns.h                     |  1 +
 include/linux/time_namespace.h              |  1 +
 include/uapi/linux/nsfs.h                   |  2 ++
 kernel/fork.c                               |  3 ++-
 kernel/time/namespace.c                     | 15 +++++++++++++++
 tools/testing/selftests/timens/vfork_exec.c | 14 +++++++++++++-
 8 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9a5ca7b82bfc..961348084257 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -979,12 +979,10 @@ static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
 	struct mm_struct *old_mm, *active_mm;
-	bool vfork;
 	int ret;
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
-	vfork = !!tsk->vfork_done;
 	old_mm = current->mm;
 	exec_mm_release(tsk, old_mm);
 	if (old_mm)
@@ -1030,7 +1028,7 @@ static int exec_mmap(struct mm_struct *mm)
 	vmacache_flush(tsk);
 	task_unlock(tsk);
 
-	if (vfork)
+	if (READ_ONCE(tsk->nsproxy->time_ns_for_children->switch_on_exec))
 		timens_on_fork(tsk->nsproxy, tsk);
 
 	if (old_mm) {
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..723ab5f69bcd 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -11,6 +11,7 @@
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
+#include <linux/nsfs.h>
 
 #include "internal.h"
 
@@ -210,6 +211,8 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
 		return put_user(uid, argp);
 	default:
+		if (ns->ops->ioctl)
+			return ns->ops->ioctl(ns, ioctl,  arg);
 		return -ENOTTY;
 	}
 }
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 75807ecef880..b690eb1a3468 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -22,6 +22,7 @@ struct proc_ns_operations {
 	int (*install)(struct nsset *nsset, struct ns_common *ns);
 	struct user_namespace *(*owner)(struct ns_common *ns);
 	struct ns_common *(*get_parent)(struct ns_common *ns);
+	long (*ioctl)(struct ns_common *ns, unsigned int ioctl, unsigned long arg);
 } __randomize_layout;
 
 extern const struct proc_ns_operations netns_operations;
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 3146f1c056c9..6569300d68ce 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -24,6 +24,7 @@ struct time_namespace {
 	struct page		*vvar_page;
 	/* If set prevents changing offsets after any task joined namespace. */
 	bool			frozen_offsets;
+	bool			switch_on_exec;
 } __randomize_layout;
 
 extern struct time_namespace init_time_ns;
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index a0c8552b64ee..ce3a9f9b1bcf 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -16,4 +16,6 @@
 /* Get owner UID (in the caller's user namespace) for a user namespace */
 #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
 
+#define TIMENS_SET_SWITCH_ON_EXEC _IO(NSIO, 0x100)
+
 #endif /* __LINUX_NSFS_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..1f7bf2a087e9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2050,7 +2050,8 @@ static __latent_entropy struct task_struct *copy_process(
 	 * On vfork, the child process enters the target time namespace only
 	 * after exec.
 	 */
-	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
+	if ((clone_flags & CLONE_THREAD) ||
+	    (clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
 		if (nsp->time_ns != nsp->time_ns_for_children)
 			return ERR_PTR(-EINVAL);
 	}
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index aec832801c26..9966e0bdefa7 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -17,6 +17,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/nsfs.h>
 
 #include <vdso/datapage.h>
 
@@ -439,6 +440,18 @@ int proc_timens_set_offset(struct file *file, struct task_struct *p,
 	return err;
 }
 
+static long timens_ioctl(struct ns_common *ns, unsigned int ioctl, unsigned long arg)
+{
+	struct time_namespace *time_ns = to_time_ns(ns);
+
+	switch (ioctl) {
+	case TIMENS_SET_SWITCH_ON_EXEC:
+		WRITE_ONCE(time_ns->switch_on_exec, true);
+		return 0;
+	}
+	return -ENOTTY;
+}
+
 const struct proc_ns_operations timens_operations = {
 	.name		= "time",
 	.type		= CLONE_NEWTIME,
@@ -446,6 +459,7 @@ const struct proc_ns_operations timens_operations = {
 	.put		= timens_put,
 	.install	= timens_install,
 	.owner		= timens_owner,
+	.ioctl		= timens_ioctl,
 };
 
 const struct proc_ns_operations timens_for_children_operations = {
@@ -456,6 +470,7 @@ const struct proc_ns_operations timens_for_children_operations = {
 	.put		= timens_put,
 	.install	= timens_install,
 	.owner		= timens_owner,
+	.ioctl		= timens_ioctl,
 };
 
 struct time_namespace init_time_ns = {
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index e6ccd900f30a..5f4e2043e0a7 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -12,6 +12,11 @@
 #include <time.h>
 #include <unistd.h>
 #include <string.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/nsfs.h>
+
+#define TIMENS_SET_SWITCH_ON_EXEC _IO(NSIO, 0x100)
 
 #include "log.h"
 #include "timens.h"
@@ -21,7 +26,7 @@
 int main(int argc, char *argv[])
 {
 	struct timespec now, tst;
-	int status, i;
+	int status, i, nsfd;
 	pid_t pid;
 
 	if (argc > 1) {
@@ -45,6 +50,13 @@ int main(int argc, char *argv[])
 	if (unshare_timens())
 		return 1;
 
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("open");
+	if (ioctl(nsfd, TIMENS_SET_SWITCH_ON_EXEC))
+		return pr_perror("ioctl");
+	close(nsfd);
+
 	if (_settime(CLOCK_MONOTONIC, OFFSET))
 		return 1;
 
-- 
2.37.2

