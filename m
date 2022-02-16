Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271E44B8309
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiBPIbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:31:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiBPIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:31:03 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F8222BF7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:30:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4cXjz7_1645000247;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V4cXjz7_1645000247)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 16:30:48 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 4/5] mm/damon/dbgfs: Add numa simulate switch
Date:   Wed, 16 Feb 2022 16:30:40 +0800
Message-Id: <20b2e1e1a60431e7d0f47df3ef9619db3bda2946.1645024354.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1645024354.git.xhao@linux.alibaba.com>
References: <cover.1645024354.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For applications that frequently access the memory area,
Doing numa simulation will cause a lot of pagefault and
tlb misses which will cause the applications performance
regression.

So there adds a switch to turn off the numa simulation
function by default, if you want to turn on this function
just do like below.
    # cd /sys/kernel/debug/damon/
    # echo on > numa_stat
    # cat numa_stat
    # on

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 include/linux/damon.h |  3 +++
 mm/damon/core.c       | 10 ++++++++-
 mm/damon/dbgfs.c      | 52 +++++++++++++++++++++++++++++++++++++++++--
 mm/damon/paddr.c      |  6 +++--
 mm/damon/vaddr.c      |  6 +++--
 5 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5bf1eb92584b..c7d7613e1a17 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -19,6 +19,9 @@
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
+/* Switch for NUMA fault */
+DECLARE_STATIC_KEY_FALSE(numa_stat_enabled_key);
+
 extern struct damon_ctx **dbgfs_ctxs;
 extern int dbgfs_nr_ctxs;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 970fc02abeba..4aa3c2d3895c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1060,7 +1060,8 @@ void damon_numa_fault(int page_nid, int node_id, struct vm_fault *vmf)
 	struct damon_target *t;
 	struct damon_region *r;
 
-	if (nr_online_nodes > 1) {
+	if (static_branch_unlikely(&numa_stat_enabled_key)
+			&& nr_online_nodes > 1) {
 		t = get_damon_target(current);
 		if (!t)
 			return;
@@ -1151,6 +1152,13 @@ static int kdamond_fn(void *data)
 	nr_running_ctxs--;
 	mutex_unlock(&damon_lock);
 
+	/*
+	 * when no kdamond threads are running, the
+	 * 'numa_stat_enabled_key' keeps default value.
+	 */
+	if (!nr_running_ctxs)
+		static_branch_disable(&numa_stat_enabled_key);
+
 	return 0;
 }
 
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index c7f4e95abc14..0ef35dbfda39 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -609,6 +609,49 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 	return len;
 }
 
+DEFINE_STATIC_KEY_FALSE(numa_stat_enabled_key);
+
+static ssize_t dbgfs_numa_stat_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	char numa_on_buf[5];
+	bool enable = static_branch_unlikely(&numa_stat_enabled_key);
+	int len;
+
+	len = scnprintf(numa_on_buf, 5, enable ? "on\n" : "off\n");
+
+	return simple_read_from_buffer(buf, count, ppos, numa_on_buf, len);
+}
+
+static ssize_t dbgfs_numa_stat_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	ssize_t ret = 0;
+	char *kbuf;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/* Remove white space */
+	if (sscanf(kbuf, "%s", kbuf) != 1) {
+		kfree(kbuf);
+		return -EINVAL;
+	}
+
+	if (!strncmp(kbuf, "on", count))
+		static_branch_enable(&numa_stat_enabled_key);
+	else if (!strncmp(kbuf, "off", count))
+		static_branch_disable(&numa_stat_enabled_key);
+	else
+		ret = -EINVAL;
+
+	if (!ret)
+		ret = count;
+	kfree(kbuf);
+	return ret;
+}
+
 static int damon_dbgfs_open(struct inode *inode, struct file *file)
 {
 	file->private_data = inode->i_private;
@@ -645,12 +688,17 @@ static const struct file_operations kdamond_pid_fops = {
 	.read = dbgfs_kdamond_pid_read,
 };
 
+static const struct file_operations numa_stat_ops = {
+	.write = dbgfs_numa_stat_write,
+	.read = dbgfs_numa_stat_read,
+};
+
 static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 {
 	const char * const file_names[] = {"attrs", "schemes", "target_ids",
-		"init_regions", "kdamond_pid"};
+		"init_regions", "kdamond_pid", "numa_stat"};
 	const struct file_operations *fops[] = {&attrs_fops, &schemes_fops,
-		&target_ids_fops, &init_regions_fops, &kdamond_pid_fops};
+		&target_ids_fops, &init_regions_fops, &kdamond_pid_fops, &numa_stat_ops};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(file_names); i++)
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b8feacf15592..9b9920784f22 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -30,14 +30,16 @@ static bool __damon_pa_mk_set(struct page *page, struct vm_area_struct *vma,
 		addr = pvmw.address;
 		if (pvmw.pte) {
 			damon_ptep_mkold(pvmw.pte, vma->vm_mm, addr);
-			if (nr_online_nodes > 1) {
+			if (static_branch_unlikely(&numa_stat_enabled_key) &&
+					nr_online_nodes > 1) {
 				result = damon_ptep_mknone(pvmw.pte, vma, addr);
 				if (result)
 					flush_tlb_page(vma, addr);
 			}
 		} else {
 			damon_pmdp_mkold(pvmw.pmd, vma->vm_mm, addr);
-			if (nr_online_nodes > 1) {
+			if (static_branch_unlikely(&numa_stat_enabled_key) &&
+					nr_online_nodes > 1) {
 				result = damon_pmdp_mknone(pvmw.pmd, vma, addr);
 				if (result) {
 					unsigned long haddr = addr & HPAGE_PMD_MASK;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 78b90972d171..5c2e2c2e29bb 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -371,7 +371,8 @@ static int damon_va_pmd_entry(pmd_t *pmd, unsigned long addr,
 		ptl = pmd_lock(walk->mm, pmd);
 		if (pmd_huge(*pmd)) {
 			damon_pmdp_mkold(pmd, walk->mm, addr);
-			if (nr_online_nodes > 1)
+			if (static_branch_unlikely(&numa_stat_enabled_key) &&
+					nr_online_nodes > 1)
 				result = damon_pmdp_mknone(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			if (result) {
@@ -392,7 +393,8 @@ static int damon_va_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 	damon_ptep_mkold(pte, walk->mm, addr);
-	if (nr_online_nodes > 1)
+	if (static_branch_unlikely(&numa_stat_enabled_key) &&
+			nr_online_nodes > 1)
 		result = damon_ptep_mknone(pte, walk->vma, addr);
 	pte_unmap_unlock(pte, ptl);
 	if (result)
-- 
2.27.0

