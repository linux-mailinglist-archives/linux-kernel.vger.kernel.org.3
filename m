Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B73049F480
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346934AbiA1HkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbiA1HkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:40:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9212C061714;
        Thu, 27 Jan 2022 23:40:17 -0800 (PST)
Date:   Fri, 28 Jan 2022 07:40:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643355615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aml8tBFI+nLezrilw2evb9ESY9QnHpsuSOvRgZDwPrw=;
        b=y07/33IHWrtPd1eBNjrJ9em19qvyJYcATzrC7Qj5sENPfkFyZlEYOK3SsW249d4AM1TUGc
        +a1/Dt3xZI0ywpZsTmQacaJpMtzMhwcoxFLvmHyvUASi0Xph/vUesKzAIB9Q8Px0uCgS5O
        cOJT4NUm1cf8mjhdF2fqm1Y6vwOulqpNDMyBNNjCZ4AkAP8zfE3O3daA7oK6ROzXUQaHTT
        ltGh/v1B4kmWngGStJAgXymxHozEuBPUCAciSa5xRHipjSGpzqH3g7dze5rNnqtbr8p8uv
        jPQsGiXUlTlDf+s2Z0D7jscT5wZqFLDD+lA29NLhhb5SGYpy1vLw2D040laW2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643355615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aml8tBFI+nLezrilw2evb9ESY9QnHpsuSOvRgZDwPrw=;
        b=HgHQb7kumXXBFprH/GSqbrCPRv0I7CdOCz+qDf65SeXmhNXFN0gxK60oCOvlMkAS0AZBf/
        GsfAjl0lnrhnFBAA==
From:   "tip-bot2 for Suren Baghdasaryan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Fix "defined but not used" warnings when
 CONFIG_PROC_FS=n
Cc:     kernel test robot <lkp@intel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220119223940.787748-3-surenb@google.com>
References: <20220119223940.787748-3-surenb@google.com>
MIME-Version: 1.0
Message-ID: <164335561425.16921.13950988057345520817.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5102bb1c9f82857a3164af9d7ab7ad628cb783ed
Gitweb:        https://git.kernel.org/tip/5102bb1c9f82857a3164af9d7ab7ad628cb783ed
Author:        Suren Baghdasaryan <surenb@google.com>
AuthorDate:    Wed, 19 Jan 2022 14:39:40 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Jan 2022 12:57:19 +01:00

psi: Fix "defined but not used" warnings when CONFIG_PROC_FS=n

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220119223940.787748-3-surenb@google.com
---
 kernel/sched/psi.c | 79 +++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a679613..cfe76f7 100644
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
@@ -1296,6 +1258,45 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
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
@@ -1400,3 +1401,5 @@ static int __init psi_proc_init(void)
 	return 0;
 }
 module_init(psi_proc_init);
+
+#endif /* CONFIG_PROC_FS */
