Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C16D589809
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbiHDHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHDHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:04:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15561B32
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:04:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4609873pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 00:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cUekWLrPgUEora35ZdVnAqX5JYjKG5HOy4KX6css4CI=;
        b=QPO+zLIiCdmFGdf/XWvBwyiS74mJt7wWSWl/C1ThRN6z4CyoZ+YzKXLOG9CYCsOAjy
         pESDAeAFpsVGCvuIACoBHEOBvMwPGxXvc5yO6Wr3q9iGjJwyJ5zLP7Q9p+TkOefWw6al
         zJBo0i3wk/92Gc3Nb6ozQbEkCj9VfGbYi2QTRoswBWTdJOX//nypLbW8qH4yFPzlpawz
         yi4e+FEq2T2jAODZYN2cvvAGll6sip2cNdqR79wVVBhS9GjDOOODiJLDQj0R8KtjRP9j
         nayWhNosU4lTYTHksc8+67b1WRT34vHgiWphrmq3UQcOKNP4Uf3LkpKsWuZOyCNLeee7
         jV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cUekWLrPgUEora35ZdVnAqX5JYjKG5HOy4KX6css4CI=;
        b=GC+uiYpf0/rgjZJA4SYz0N1WM9RVmwsMVf0KVbQzJN4+pWI+JuMuV1oKM9gt4C6eLB
         ABzvx79lWXLnO447pmjPEdhKktMWh03xd+djHcUbVW+kEPDLOLHEHSKKUxQVAtMGUthg
         i+LxlbfZJwlRSMA4WJ0GKsbVh091/CuS9DtIkIKlHETTZgB4NUoSQf4yIhi9dJqcoAxX
         vARegwspRSE9HngB4PrDMlI7cJ/eX3O19qCDGOqvpuyFyv4EEZ8y/6J+Y/GCc4fBS9XT
         /GhjmVCtxhO8qGkmO1sB4lZSN+nvUk5da4H7JJhSDJcHATkYgUdzVyFXC9SjfwaCqJl3
         bARQ==
X-Gm-Message-State: ACgBeo2lrj2JgjioKFU+iyLTblrMqWFvPwxfaAKX9ecbFsRi/4Y+r8BH
        f/D6JZtT6a05tEmU3IClZr9dNA==
X-Google-Smtp-Source: AA6agR4RBR5A2LMFu7WVTBT4OJEIU6wrU9QOyMc26cyjcb3TqU3U+3skQ8herBu/NW1aJZW+cOuUlQ==
X-Received: by 2002:a17:90b:164d:b0:1f0:31c1:9e88 with SMTP id il13-20020a17090b164d00b001f031c19e88mr596853pjb.206.1659596653619;
        Thu, 04 Aug 2022 00:04:13 -0700 (PDT)
Received: from MacBook-Pro.local.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id ik4-20020a170902ab0400b0016da68b09b3sm58692plb.87.2022.08.04.00.04.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 00:04:13 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        yuanzhu@bytedance.com, lizhe.67@bytedance.com
Subject: [RFC] x86/mm/dump_pagetables: Allow dumping pagetables by pid
Date:   Thu,  4 Aug 2022 15:04:01 +0800
Message-Id: <20220804070401.86524-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

