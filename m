Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7867B486852
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbiAFRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241684AbiAFRU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:20:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9BCC0611FF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:20:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b10-20020a251b0a000000b0060a7fbb7a64so6133586ybb.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VaVcglQQWQyd+D8xYsm++asUm3d2zSMstiXGMzeYRRg=;
        b=Hr6WeOoUTwdN4ffE+1b6oJc7c04qmGPJdYFf0sYZD1i9sdfRJczM+1F+Kfgnf+lg/W
         KWlsdvHQbnmd7MH4BT3RkNEKKZYntVTPT2vWczi/C+KRN7wYleegIKyEjw+V7sQ9DTBa
         Eg6nvFvrgO0PMFFEd5aDpVLm6mBK07R6SsKQQzoV/+RsiE8tWb+NBfcUV/hAWE+3zEx2
         tZ7aPdpYNL8KZlXU0fQcvKIOfWQXA0WWV781zdRtCa0c5RdpvbjZW51Bq8BVgzBfbDwd
         bzNlxfzC0n95SzUBwU0LS2nAh0CCxYM2dUBmyIxP+hOQu+au14MCb2hcr+Usk9MR9D1c
         HWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VaVcglQQWQyd+D8xYsm++asUm3d2zSMstiXGMzeYRRg=;
        b=6jBD/rSP5xfENgYG9VfbETb/IEDh8ELe+cC0lK0Dg67PR5LX42rZvkKt8k73TeoVPy
         3q/65BDg217nnPx3mB4pb2qPKBW5LN36a3pVsPMuIxw8IujeYx4HnOtDgz9VWnqP14CZ
         AVLlYptHanNGQPEjyTI6moitLRXl4Pn4A40esD6NiAjPOOrc99c4W6Ll7L7puvfaIj57
         nv/cwm/sUmYLEOW87ItZPD+A8WVgs/8dkkCFa1NdfdAsbzhqwDLeIEg9nbrN4G2i/MEA
         BBm7hMUqQMRpXxQqSRAWt6397Ryuf8MVHmp9oCXelfhHXylRWJ4QK31YPs3XZbNGuFis
         QlhQ==
X-Gm-Message-State: AOAM531J9/I2alsGrco5eE65evbEkh2tfbPtaAOqu1KqSbVQiqbCVFSW
        qtKO1BkSSl8v1p1+kThlfinR6gp+
X-Google-Smtp-Source: ABdhPJxH4wialPDTtm2tQJ8QBYOiePs4jx8BQYI3Lan0gm90jVSj+a/A8LSxPT+6XdO30SQsiWBFyYSN
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:f130:19b6:8678:c9d1])
 (user=brho job=sendgmr) by 2002:a5b:74b:: with SMTP id s11mr22180493ybq.90.1641489656140;
 Thu, 06 Jan 2022 09:20:56 -0800 (PST)
Date:   Thu,  6 Jan 2022 12:20:40 -0500
In-Reply-To: <20220106172041.522167-1-brho@google.com>
Message-Id: <20220106172041.522167-3-brho@google.com>
Mime-Version: 1.0
References: <20220106172041.522167-1-brho@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 2/3] prlimit: make do_prlimit() static
From:   Barret Rhoden <brho@google.com>
To:     ebiederm@xmission.com
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no other callers in the kernel.

Fixed up a comment format and whitespace issue when moving do_prlimit()
higher in sys.c.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 include/linux/resource.h |   2 -
 kernel/sys.c             | 116 ++++++++++++++++++++-------------------
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/include/linux/resource.h b/include/linux/resource.h
index bdf491cbcab7..4fdbc0c3f315 100644
--- a/include/linux/resource.h
+++ b/include/linux/resource.h
@@ -8,7 +8,5 @@
 struct task_struct;
 
 void getrusage(struct task_struct *p, int who, struct rusage *ru);
-int do_prlimit(struct task_struct *tsk, unsigned int resource,
-		struct rlimit *new_rlim, struct rlimit *old_rlim);
 
 #endif
diff --git a/kernel/sys.c b/kernel/sys.c
index 558e52fa5bbd..fb2a5e7c0589 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1415,6 +1415,65 @@ SYSCALL_DEFINE2(setdomainname, char __user *, name, int, len)
 	return errno;
 }
 
+/* make sure you are allowed to change @tsk limits before calling this */
+static int do_prlimit(struct task_struct *tsk, unsigned int resource,
+		      struct rlimit *new_rlim, struct rlimit *old_rlim)
+{
+	struct rlimit *rlim;
+	int retval = 0;
+
+	if (resource >= RLIM_NLIMITS)
+		return -EINVAL;
+	if (new_rlim) {
+		if (new_rlim->rlim_cur > new_rlim->rlim_max)
+			return -EINVAL;
+		if (resource == RLIMIT_NOFILE &&
+				new_rlim->rlim_max > sysctl_nr_open)
+			return -EPERM;
+	}
+
+	/* protect tsk->signal and tsk->sighand from disappearing */
+	read_lock(&tasklist_lock);
+	if (!tsk->sighand) {
+		retval = -ESRCH;
+		goto out;
+	}
+
+	rlim = tsk->signal->rlim + resource;
+	task_lock(tsk->group_leader);
+	if (new_rlim) {
+		/*
+		 * Keep the capable check against init_user_ns until cgroups can
+		 * contain all limits.
+		 */
+		if (new_rlim->rlim_max > rlim->rlim_max &&
+				!capable(CAP_SYS_RESOURCE))
+			retval = -EPERM;
+		if (!retval)
+			retval = security_task_setrlimit(tsk, resource, new_rlim);
+	}
+	if (!retval) {
+		if (old_rlim)
+			*old_rlim = *rlim;
+		if (new_rlim)
+			*rlim = *new_rlim;
+	}
+	task_unlock(tsk->group_leader);
+
+	/*
+	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not
+	 * infinite. In case of RLIM_INFINITY the posix CPU timer code
+	 * ignores the rlimit.
+	 */
+	if (!retval && new_rlim && resource == RLIMIT_CPU &&
+	    new_rlim->rlim_cur != RLIM_INFINITY &&
+	    IS_ENABLED(CONFIG_POSIX_TIMERS))
+		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
+out:
+	read_unlock(&tasklist_lock);
+	return retval;
+}
+
 SYSCALL_DEFINE2(getrlimit, unsigned int, resource, struct rlimit __user *, rlim)
 {
 	struct rlimit value;
@@ -1558,63 +1617,6 @@ static void rlim64_to_rlim(const struct rlimit64 *rlim64, struct rlimit *rlim)
 		rlim->rlim_max = (unsigned long)rlim64->rlim_max;
 }
 
-/* make sure you are allowed to change @tsk limits before calling this */
-int do_prlimit(struct task_struct *tsk, unsigned int resource,
-		struct rlimit *new_rlim, struct rlimit *old_rlim)
-{
-	struct rlimit *rlim;
-	int retval = 0;
-
-	if (resource >= RLIM_NLIMITS)
-		return -EINVAL;
-	if (new_rlim) {
-		if (new_rlim->rlim_cur > new_rlim->rlim_max)
-			return -EINVAL;
-		if (resource == RLIMIT_NOFILE &&
-				new_rlim->rlim_max > sysctl_nr_open)
-			return -EPERM;
-	}
-
-	/* protect tsk->signal and tsk->sighand from disappearing */
-	read_lock(&tasklist_lock);
-	if (!tsk->sighand) {
-		retval = -ESRCH;
-		goto out;
-	}
-
-	rlim = tsk->signal->rlim + resource;
-	task_lock(tsk->group_leader);
-	if (new_rlim) {
-		/* Keep the capable check against init_user_ns until
-		   cgroups can contain all limits */
-		if (new_rlim->rlim_max > rlim->rlim_max &&
-				!capable(CAP_SYS_RESOURCE))
-			retval = -EPERM;
-		if (!retval)
-			retval = security_task_setrlimit(tsk, resource, new_rlim);
-	}
-	if (!retval) {
-		if (old_rlim)
-			*old_rlim = *rlim;
-		if (new_rlim)
-			*rlim = *new_rlim;
-	}
-	task_unlock(tsk->group_leader);
-
-	/*
-	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not
-	 * infinite. In case of RLIM_INFINITY the posix CPU timer code
-	 * ignores the rlimit.
-	 */
-	 if (!retval && new_rlim && resource == RLIMIT_CPU &&
-	     new_rlim->rlim_cur != RLIM_INFINITY &&
-	     IS_ENABLED(CONFIG_POSIX_TIMERS))
-		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
-out:
-	read_unlock(&tasklist_lock);
-	return retval;
-}
-
 /* rcu lock must be held */
 static int check_prlimit_permission(struct task_struct *task,
 				    unsigned int flags)
-- 
2.34.1.448.ga2b2bfdf31-goog

