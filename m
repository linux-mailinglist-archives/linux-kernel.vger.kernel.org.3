Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F82485AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244463AbiAEVbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbiAEVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:31:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F6C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:31:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i65-20020a252244000000b0060b2e5fd54cso1167763ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VaVcglQQWQyd+D8xYsm++asUm3d2zSMstiXGMzeYRRg=;
        b=kj1vfpt24GWSpAOGOWS2UytnuxnopwczjTyCX+z1ZrjgUheyWTWtg6bWynnkzj2fdm
         UV/+xl5xP7XCi3+G620jWUFNsXvmh6yWWJUy+T8DPzCplzJF/jcKxtj6sYGqhhZZPQ2u
         bwSrItZeQTwHivQqCl0xHBjbhSexP5bvjfQo2uQVMIHWdsUCavQ0dOic24pxkbFR4/oQ
         lnzYS2teYKOSK0hzWIXv/yjLgvZD9YFNFoj+8OOcrRSBbLSHZIBbdjB9u34C048e7sjV
         odg2R5dJ25nrJ2DVgJSp8IOhnZHskaPs4w2cPfd/L0DkR6BwogtRzbkP2KPJUziJ86Bh
         B0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VaVcglQQWQyd+D8xYsm++asUm3d2zSMstiXGMzeYRRg=;
        b=b91NrzVsSZuBddvhugPQ9S15iSzx7sC849x/dM034rDh3gkICvZeoPS1uIhl3G9+bz
         xm7A/Bn3VGoe6c+Kq444B0BqjjPbgP2ykKVa3QG07ttFGzhDOryerEYrzWTDIX1FuWS4
         EgVJU4OPSwux0EKphC0LUeWHYLUCcrtj3SnUlWCylbTQRcao/T/SE638yTI8pG32odTo
         zoU1+F4zhRAhNwuEIMoG7tYtuageDfKRaWY/jDwAA5bjL02gw0QPRCfhegjerz6L43uJ
         cU6aziCBiwWCqSl+j7ScFa9DW9S8k/4HghDhDU/mDccf4SjbxnB1q+VHdrRE3UJfpZWz
         5adQ==
X-Gm-Message-State: AOAM531f5HFRBrnSdfp2mvb8Ys96Iwum65LyO2REXmtTc4GwN9emyUPI
        8KRAndXCd3oYy9fUh22mon7cRWHn
X-Google-Smtp-Source: ABdhPJyC91nLMMhW+wKBzgEuZ5ccUrlcKq4EblaVq/f9QvMsMSM37Xu5zlM1VyNMQqEBZIkJOt3ocfaP
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:3ab7:a23:e07a:5e22])
 (user=brho job=sendgmr) by 2002:a25:c385:: with SMTP id t127mr41305535ybf.562.1641418290619;
 Wed, 05 Jan 2022 13:31:30 -0800 (PST)
Date:   Wed,  5 Jan 2022 16:28:27 -0500
In-Reply-To: <20220105212828.197013-1-brho@google.com>
Message-Id: <20220105212828.197013-3-brho@google.com>
Mime-Version: 1.0
References: <20220105212828.197013-1-brho@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 2/3] prlimit: make do_prlimit() static
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

