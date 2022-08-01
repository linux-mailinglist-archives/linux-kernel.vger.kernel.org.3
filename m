Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8599586AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiHAMit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiHAMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:38:21 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCA9EC6E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:17:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VL6DdJj_1659356251;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VL6DdJj_1659356251)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 20:17:31 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     willy@infradead.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        keescook@chromium.org, xhao@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH V4 1/1] mm: add last level page table numa info to /proc/pid/numa_pgtable
Date:   Mon,  1 Aug 2022 20:17:27 +0800
Message-Id: <20220801121727.76186-2-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220801121727.76186-1-xhao@linux.alibaba.com>
References: <20220801121727.76186-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many data center servers, the shared memory architectures is
Non-Uniform Memory Access (NUMA), remote numa node data access
often brings a high latency problem, but what we are easy to ignore
is that the page table remote numa access, It can also leads to a
performance degradation.

So there add a new interface in /proc, This will help developers to
get more info about performance issues if they are caused by cross-NUMA.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 fs/proc/base.c     |  2 ++
 fs/proc/internal.h |  1 +
 fs/proc/task_mmu.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..487e82dd3275 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3224,6 +3224,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("maps",       S_IRUGO, proc_pid_maps_operations),
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
+	REG("numa_pgtable", S_IRUGO, proc_pid_numa_pgtable_operations),
 #endif
 	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",        proc_cwd_link),
@@ -3571,6 +3572,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_NUMA
 	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
+	REG("numa_pgtable", S_IRUGO, proc_pid_numa_pgtable_operations),
 #endif
 	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",       proc_cwd_link),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..e7ed9ef097b6 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -296,6 +296,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);

 extern const struct file_operations proc_pid_maps_operations;
 extern const struct file_operations proc_pid_numa_maps_operations;
+extern const struct file_operations proc_pid_numa_pgtable_operations;
 extern const struct file_operations proc_pid_smaps_operations;
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_clear_refs_operations;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2d04e3470d4c..77b7a49757f5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1999,4 +1999,91 @@ const struct file_operations proc_pid_numa_maps_operations = {
 	.release	= proc_map_release,
 };

+struct pgtable_numa_private {
+	struct proc_maps_private proc_maps;
+	unsigned long node[MAX_NUMNODES];
+};
+
+static int gather_pgtable_numa_stats(pmd_t *pmd, unsigned long addr,
+				     unsigned long end, struct mm_walk *walk)
+{
+	struct pgtable_numa_private *priv = walk->private;
+	struct page *page;
+	int nid;
+
+	if (pmd_huge(*pmd)) {
+		page = virt_to_page(pmd);
+	} else {
+		page = pmd_page(*pmd);
+	}
+
+	nid = page_to_nid(page);
+	priv->node[nid]++;
+
+	return 0;
+}
+
+static const struct mm_walk_ops show_numa_pgtable_ops = {
+	.pmd_entry = gather_pgtable_numa_stats,
+};
+
+/*
+ * Display the page talbe allocated per node via /proc.
+ */
+static int show_numa_pgtable(struct seq_file *m, void *v)
+{
+	struct pgtable_numa_private *numa_priv = m->private;
+	struct vm_area_struct *vma = v;
+	struct mm_struct *mm = vma->vm_mm;
+	struct file *file = vma->vm_file;
+	int nid;
+
+	if (!mm)
+		return 0;
+
+	memset(numa_priv->node, 0, sizeof(numa_priv->node));
+
+	seq_printf(m, "%08lx ", vma->vm_start);
+
+	if (file) {
+		seq_puts(m, " file=");
+		seq_file_path(m, file, "\n\t= ");
+	} else if (vma->vm_start <= mm->brk && vma->vm_end >= mm->start_brk) {
+		seq_puts(m, " heap");
+	} else if (is_stack(vma)) {
+		seq_puts(m, " stack");
+	}
+
+	/* mmap_lock is held by m_start */
+	walk_page_vma(vma, &show_numa_pgtable_ops, numa_priv);
+
+	for_each_node_state(nid, N_MEMORY) {
+		if (numa_priv->node[nid])
+			seq_printf(m, " N%d=%lu", nid, numa_priv->node[nid]);
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static const struct seq_operations proc_pid_numa_pgtable_op = {
+	.start  = m_start,
+	.next   = m_next,
+	.stop   = m_stop,
+	.show   = show_numa_pgtable,
+};
+
+static int pid_numa_pgtable_open(struct inode *inode, struct file *file)
+{
+	return proc_maps_open(inode, file, &proc_pid_numa_pgtable_op,
+			sizeof(struct pgtable_numa_private));
+}
+
+const struct file_operations proc_pid_numa_pgtable_operations = {
+	.open		= pid_numa_pgtable_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= proc_map_release,
+};
+
 #endif /* CONFIG_NUMA */
--
2.31.0
