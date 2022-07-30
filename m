Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE1585B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiG3Qfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiG3Qfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 12:35:47 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3A9CE07
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 09:35:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VKrLbJS_1659198937;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VKrLbJS_1659198937)
          by smtp.aliyun-inc.com;
          Sun, 31 Jul 2022 00:35:39 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     adobriyan@gmail.com
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        xhao@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH] mm: add last level page table numa info to /proc/pid/numa_pgtable
Date:   Sun, 31 Jul 2022 00:35:28 +0800
Message-Id: <20220730163528.48377-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 fs/proc/base.c     |   6 ++-
 fs/proc/internal.h |   1 +
 fs/proc/task_mmu.c | 129 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..de60351813ec 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2626,7 +2626,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }

-static struct dentry *proc_pident_lookup(struct inode *dir,
+static struct dentry *proc_pident_lookup(struct inode *dir,
 					 struct dentry *dentry,
 					 const struct pid_entry *p,
 					 const struct pid_entry *end)
@@ -2839,7 +2839,7 @@ static const struct pid_entry attr_dir_stuff[] = {

 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
 {
-	return proc_pident_readdir(file, ctx,
+	return proc_pident_readdir(file, ctx,
 				   attr_dir_stuff, ARRAY_SIZE(attr_dir_stuff));
 }

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
index 2d04e3470d4c..a51befb47ea8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1999,4 +1999,133 @@ const struct file_operations proc_pid_numa_maps_operations = {
 	.release	= proc_map_release,
 };

+struct pgtable_numa_maps {
+	unsigned long node[MAX_NUMNODES];
+};
+
+struct pgtable_numa_private {
+	struct proc_maps_private proc_maps;
+	struct pgtable_numa_maps md;
+};
+
+static void gather_pgtable_stats(struct page *page, struct pgtable_numa_maps *md)
+{
+	md->node[page_to_nid(page)] += 1;
+}
+
+static struct page *can_gather_pgtable_numa_stats(pmd_t pmd, struct vm_area_struct *vma,
+		unsigned long addr)
+{
+	struct page *page;
+	int nid;
+
+	if (!pmd_present(pmd))
+		return NULL;
+
+	if (pmd_huge(pmd))
+		return NULL;
+
+	page = pmd_page(pmd);
+	nid = page_to_nid(page);
+	if (!node_isset(nid, node_states[N_MEMORY]))
+		return NULL;
+
+	return page;
+}
+
+static int gather_pgtable_numa_stats(pmd_t *pmd, unsigned long addr,
+		unsigned long end, struct mm_walk *walk)
+{
+	struct pgtable_numa_maps *md = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	struct page *page;
+
+	if (pmd_huge(*pmd)) {
+		struct page *pmd_page;
+
+		pmd_page = virt_to_page(pmd);
+		if (!pmd_page)
+			return 0;
+
+		if (!node_isset(page_to_nid(pmd_page), node_states[N_MEMORY]))
+			return 0;
+
+		gather_pgtable_stats(pmd_page, md);
+		goto out;
+	}
+
+	page = can_gather_pgtable_numa_stats(*pmd, vma, addr);
+	if (!page)
+		return 0;
+
+	gather_pgtable_stats(page, md);
+
+out:
+	cond_resched();
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
+	struct pgtable_numa_maps *md = &numa_priv->md;
+	struct mm_struct *mm = vma->vm_mm;
+	struct file *file = vma->vm_file;
+	int nid;
+
+	if (!mm)
+		return 0;
+
+	memset(md, 0, sizeof(*md));
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
+	walk_page_vma(vma, &show_numa_pgtable_ops, md);
+
+	for_each_node_state(nid, N_MEMORY) {
+		if (md->node[nid])
+			seq_printf(m, " N%d=%lu", nid, md->node[nid]);
+	}
+	seq_putc(m, '\n');
+
+	return 0;
+}
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
