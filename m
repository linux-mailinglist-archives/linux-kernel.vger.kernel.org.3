Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2849431E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357595AbiASWjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357581AbiASWju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:39:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:39:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k4-20020a252404000000b00613504b364fso7772067ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zGMELfrIVM+EAw3yoydJ3GHCMZPedcXyHHuf1LPcDBc=;
        b=EV4ynsdAh7Xb21dmr4vVrCYocLWMDrkTGq0uJH0tDRwQKhQ2TG4JtCnLA5QXR/m1/P
         8G7Nhb9lByBfynRBenVh/+Om9m+SnA0M3KRWGm5J3YJLhGV6lxXaJQ5Oyq+aQ6YzE5f/
         ZohpJfNlaaZghDuQkRSGETR3Hkg194ptrOY0zfR05E36d1NImDTFkrlYJz7mCu/pQDVb
         SlhAIAyhGD2yuRT1lf+CoN2KbcgrWHVyB2I3G+nFN/1GNOWQHZnQmmDLulZxyhQJtfbM
         pWqKLrr2PjjyMJJ0TBP5npP3FPS0R1I/10YqGk/8unK6n/jSofYCngdQqZ9as2FubjkB
         zuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zGMELfrIVM+EAw3yoydJ3GHCMZPedcXyHHuf1LPcDBc=;
        b=oS7zsj5Oqf0sGtbc1RYgVf4IIBb+udioiNdHb7sBHgr1KkoD8hJUqecwwV5rMoqZ7L
         KKSVcrLBAZKnOw+tGVXwmfNKhsYjRDL6F7SZrhV5fBQEvTwKINVBSgLUDR2Xg88QXfDE
         FQ2O4Szcv5LDFE/N+cSrF4E7oAR0o3zBBL7WzQ89cUEgta3hZPdYcBuqpdQi9ICnWNYT
         XkBmuyLzpj60JgIXCKSlDpLej5EiYhWyp3vpKHFar1ulDb7AKpjDBOKWclWVoCjf4SnD
         HVG9zgGzJs7o4zEY2PDjoByURFlaaNHoeTKtDVQO+FA1eeZ/CU9iG6OUcGUc7IlGhq/p
         5PUA==
X-Gm-Message-State: AOAM530V4Db+Bsfa8CPcM+NjygOcCaJ94uFL06xgF2ysoZwez4/UbpYg
        kfPbkVfBMHt6bp0qULXLcSUSNO5DgyQ=
X-Google-Smtp-Source: ABdhPJx8KSrCejfZZRnk86Q6Is0dlXe7MPeo6XZf3Lc6T7Z0SyWa8zEt9M43GKIPfNJknShYtzJe7uPyc7o=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5c51:e66a:40e8:adec])
 (user=surenb job=sendgmr) by 2002:a25:343:: with SMTP id 64mr8435779ybd.497.1642631989508;
 Wed, 19 Jan 2022 14:39:49 -0800 (PST)
Date:   Wed, 19 Jan 2022 14:39:40 -0800
In-Reply-To: <20220119223940.787748-1-surenb@google.com>
Message-Id: <20220119223940.787748-3-surenb@google.com>
Mime-Version: 1.0
References: <20220119223940.787748-1-surenb@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 2/2] psi: Fix "defined but not used" warnings when CONFIG_PROC_FS=n
From:   Suren Baghdasaryan <surenb@google.com>
To:     hannes@cmpxchg.org
Cc:     peterz@infradead.org, mingo@redhat.com, ebiggers@kernel.org,
        tj@kernel.org, willy@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS is disabled psi code generates the following warnings:

kernel/sched/psi.c:1364:30: warning: 'psi_cpu_proc_ops' defined but not used [-Wunused-const-variable=]
    1364 | static const struct proc_ops psi_cpu_proc_ops = {
         |                              ^~~~~~~~~~~~~~~~
kernel/sched/psi.c:1355:30: warning: 'psi_memory_proc_ops' defined but not used [-Wunused-const-variable=]
    1355 | static const struct proc_ops psi_memory_proc_ops = {
         |                              ^~~~~~~~~~~~~~~~~~~
kernel/sched/psi.c:1346:30: warning: 'psi_io_proc_ops' defined but not used [-Wunused-const-variable=]
    1346 | static const struct proc_ops psi_io_proc_ops = {
         |                              ^~~~~~~~~~~~~~~

Make definitions of these structures and related functions conditional on
CONFIG_PROC_FS config.

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/sched/psi.c | 79 ++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index c137c4d6983e..e14358178849 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1082,44 +1082,6 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	return 0;
 }
 
-static int psi_io_show(struct seq_file *m, void *v)
-{
-	return psi_show(m, &psi_system, PSI_IO);
-}
-
-static int psi_memory_show(struct seq_file *m, void *v)
-{
-	return psi_show(m, &psi_system, PSI_MEM);
-}
-
-static int psi_cpu_show(struct seq_file *m, void *v)
-{
-	return psi_show(m, &psi_system, PSI_CPU);
-}
-
-static int psi_open(struct file *file, int (*psi_show)(struct seq_file *, void *))
-{
-	if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
-		return -EPERM;
-
-	return single_open(file, psi_show, NULL);
-}
-
-static int psi_io_open(struct inode *inode, struct file *file)
-{
-	return psi_open(file, psi_io_show);
-}
-
-static int psi_memory_open(struct inode *inode, struct file *file)
-{
-	return psi_open(file, psi_memory_show);
-}
-
-static int psi_cpu_open(struct inode *inode, struct file *file)
-{
-	return psi_open(file, psi_cpu_show);
-}
-
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			char *buf, size_t nbytes, enum psi_res res)
 {
@@ -1278,6 +1240,45 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	return ret;
 }
 
+#ifdef CONFIG_PROC_FS
+static int psi_io_show(struct seq_file *m, void *v)
+{
+	return psi_show(m, &psi_system, PSI_IO);
+}
+
+static int psi_memory_show(struct seq_file *m, void *v)
+{
+	return psi_show(m, &psi_system, PSI_MEM);
+}
+
+static int psi_cpu_show(struct seq_file *m, void *v)
+{
+	return psi_show(m, &psi_system, PSI_CPU);
+}
+
+static int psi_open(struct file *file, int (*psi_show)(struct seq_file *, void *))
+{
+	if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
+	return single_open(file, psi_show, NULL);
+}
+
+static int psi_io_open(struct inode *inode, struct file *file)
+{
+	return psi_open(file, psi_io_show);
+}
+
+static int psi_memory_open(struct inode *inode, struct file *file)
+{
+	return psi_open(file, psi_memory_show);
+}
+
+static int psi_cpu_open(struct inode *inode, struct file *file)
+{
+	return psi_open(file, psi_cpu_show);
+}
+
 static ssize_t psi_write(struct file *file, const char __user *user_buf,
 			 size_t nbytes, enum psi_res res)
 {
@@ -1392,3 +1393,5 @@ static int __init psi_proc_init(void)
 	return 0;
 }
 module_init(psi_proc_init);
+
+#endif /* CONFIG_PROC_FS */
-- 
2.34.1.703.g22d0c6ccf7-goog

