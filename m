Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C992592ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiHOMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiHOMRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:17:52 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0C42654B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:17:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 130so6228058pfy.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cUekWLrPgUEora35ZdVnAqX5JYjKG5HOy4KX6css4CI=;
        b=4490P2xkuOisHhUpa77ZcnlGEiu9BU+0wE3DXUw6UgYeooZH/Q0uKWsbb5HekhPAQH
         0qTx7VNR/K72+n0Pde9baHkJO7jpE/5pdIeG2AkyL4MJ1A9PlaWEUxQQquHaGMdp5jEB
         mPva3RUUbF3RsFufeTvDc3KxYVgykafRAu7/LG9yjWlVS649JlYLghXT/E96Ftw36pzN
         mggTSwH6fD+I8jrFf5u/Cno9p1LHwtB7/2kWfk1WK9z5Uqbphl+08s0zMVmGICh6cWoK
         hQa9Njc2737trbwWn1moWR06/fDUgm3e44ZEMgC1QX78r63WgZ3kDqwet9rpd0BjEy04
         tihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cUekWLrPgUEora35ZdVnAqX5JYjKG5HOy4KX6css4CI=;
        b=YBUyN3ubkCgoD0jlWJk36Y9O0W9f7TzuSPm68z6wDJ08xWq2aPHDTequ07E6T7vjRx
         Y5nYwznVK8WSc8Mro8uyd5HL1IjswW1222VuCR7BbHLS6NaufozuKXqs91jSLqzT35GV
         HnSRziSoBPg+6WF7y7MiASouFMC7kfNP+aqomVowVyR+qBfNPvEcGq08rJTmJPs7fpMJ
         1UXo2nw4Mi6+Tf0scMgbwtiIhN5Uzh6jpuh46Ef4QP1caFQ+AL6CDITsTa6f/5+Db4un
         uUeVOAGpPLAHsAD0fQa1XOXwqkK3aHS+NtkZGP+PidGWCDL17UVj6us6buyJ01SMOS6p
         lthg==
X-Gm-Message-State: ACgBeo1/0hzPD8AE+bMj0f0D+OQQkEsLDdcfUAjI8hTUrJbmAZOdcIE4
        92g0uIIS5o4H5dqYpvpZ7+Cn8g==
X-Google-Smtp-Source: AA6agR5kwbs9Z7t2h+8pZnKXZrAu5actb4HMToutdOX1VQTm2BfRzIJG3FSxfbyavyKEKtkQXRBdIw==
X-Received: by 2002:a05:6a00:88f:b0:530:dec:81fd with SMTP id q15-20020a056a00088f00b005300dec81fdmr16349134pfj.64.1660565871335;
        Mon, 15 Aug 2022 05:17:51 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b0016be596c8afsm6821222plh.282.2022.08.15.05.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2022 05:17:51 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        yuanzhu@bytedance.com, lizhe.67@bytedance.com
Subject: [PATCH] x86/mm/dump_pagetables: Allow dumping pagetables by pid
Date:   Mon, 15 Aug 2022 20:17:37 +0800
Message-Id: <20220815121737.66687-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhe <lizhe.67@bytedance.com>

In current kernel we can only dump a user task's pagetable
by task itself. Sometimes we need to inspect the page table
attributes of different memory maps to user space to meet
the relevant development and debugging requirements. This
patch helps us to make our works easier. It add two file
named 'pid' and 'pid_pgtable_show'. We can use 'pid' to
input the task we want to inspect and get pagetable info
from 'pid_pgtable_show'.

User space can use file 'pid' and 'pid_pgtable_show' as follows.
====
$ echo $pid > /sys/kernel/debug/page_tables/pid
$ cat /sys/kernel/debug/page_tables/pid_pgtable_show

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/mm/debug_pagetables.c | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index 092ea436c7e6..53a8ced44080 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -4,6 +4,8 @@
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/pgtable.h>
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
@@ -31,6 +33,84 @@ static int ptdump_curusr_show(struct seq_file *m, void *v)
 }
 
 DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
+
+static pid_t trace_pid;
+static int ptdump_pid_pgtable_show(struct seq_file *m, void *v)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+
+	if (trace_pid == 0)
+		return 0;
+
+	rcu_read_lock();
+	task = find_task_by_vpid(trace_pid);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+	mm = get_task_mm(task);
+	rcu_read_unlock();
+
+	if (mm && mm->pgd)
+		ptdump_walk_pgd_level_debugfs(m, mm, true);
+
+	if (mm)
+		mmput(mm);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(ptdump_pid_pgtable);
+
+static ssize_t ptdump_pid_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *f_pos)
+{
+	pid_t pid;
+	int ret = -ENOMEM;
+	char *tmp = kzalloc(count, GFP_KERNEL);
+
+	if (!tmp)
+		return ret;
+
+	if (copy_from_user(tmp, buffer, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = kstrtoint(tmp, 0, &pid);
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+	kfree(tmp);
+	trace_pid = pid;
+	return count;
+
+out:
+	kfree(tmp);
+	return ret;
+}
+
+static int ptdump_show_pid(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", trace_pid);
+	return 0;
+}
+
+static int ptdump_open_pid(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, ptdump_show_pid, NULL);
+}
+
+static const struct file_operations ptdump_pid_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ptdump_open_pid,
+	.write		= ptdump_pid_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 #endif
 
 #if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
@@ -57,6 +137,8 @@ static int __init pt_dump_debug_init(void)
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	debugfs_create_file("current_user", 0400, dir, NULL,
 			    &ptdump_curusr_fops);
+	debugfs_create_file("pid_pgtable_show", 0400, dir, NULL, &ptdump_pid_pgtable_fops);
+	debugfs_create_file("pid", 0400, dir, NULL, &ptdump_pid_fops);
 #endif
 #if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
 	debugfs_create_file("efi", 0400, dir, NULL, &ptdump_efi_fops);
-- 
2.20.1

