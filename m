Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4D581E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbiG0DSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbiG0DS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:18:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432127150
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 20:18:25 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LszTF4Zz4zmVDR;
        Wed, 27 Jul 2022 11:16:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 11:18:22 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 11:18:21 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] mm: memory-failure: convert to pr_fmt()
Date:   Wed, 27 Jul 2022 11:25:11 +0800
Message-ID: <20220727032511.145506-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_fmt to prefix all pr_<level> output, but unpoison_memory()
and soft_offline_page() are used by error injection, which have
own prefixes like "Unpoison:" and "soft offline:", meanwhile,
soft_offline_page() could be used by memory hotremove, so undef
pr_fmt before unpoison_pr_info definition to keep the original
output for them.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2:
- add undef pr_fmt before unpoison_pr_info and update changelog
 mm/memory-failure.c | 57 +++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2bc1a47c3d46..fbb8a0143dcd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -33,6 +33,9 @@
  * are rare we hope to get away with this. This avoids impacting the core 
  * VM.
  */
+
+#define pr_fmt(fmt) "Memory failure: " fmt
+
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/page-flags.h>
@@ -258,7 +261,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	short addr_lsb = tk->size_shift;
 	int ret = 0;
 
-	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+	pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
 			pfn, t->comm, t->pid);
 
 	if ((flags & MF_ACTION_REQUIRED) && (t == current))
@@ -276,7 +279,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
 				      addr_lsb, t);  /* synchronous? */
 	if (ret < 0)
-		pr_info("Memory failure: Error sending signal to %s:%d: %d\n",
+		pr_info("Error sending signal to %s:%d: %d\n",
 			t->comm, t->pid, ret);
 	return ret;
 }
@@ -358,7 +361,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 
 	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
 	if (!tk) {
-		pr_err("Memory failure: Out of memory while machine check handling\n");
+		pr_err("Out of memory while machine check handling\n");
 		return;
 	}
 
@@ -385,7 +388,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	 * has a mapping for the page.
 	 */
 	if (tk->addr == -EFAULT) {
-		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
+		pr_info("Unable to find user space address %lx in %s\n",
 			page_to_pfn(p), tsk->comm);
 	} else if (tk->size_shift == 0) {
 		kfree(tk);
@@ -418,7 +421,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
 			 * signal and then access the memory. Just kill it.
 			 */
 			if (fail || tk->addr == -EFAULT) {
-				pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
+				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
 				       pfn, tk->tsk->comm, tk->tsk->pid);
 				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
 						 tk->tsk, PIDTYPE_PID);
@@ -431,7 +434,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
 			 * process anyways.
 			 */
 			else if (kill_proc(tk, pfn, flags) < 0)
-				pr_err("Memory failure: %#lx: Cannot send advisory machine check signal to %s:%d\n",
+				pr_err("%#lx: Cannot send advisory machine check signal to %s:%d\n",
 				       pfn, tk->tsk->comm, tk->tsk->pid);
 		}
 		put_task_struct(tk->tsk);
@@ -821,12 +824,10 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
 		int err = mapping->a_ops->error_remove_page(mapping, p);
 
 		if (err != 0) {
-			pr_info("Memory failure: %#lx: Failed to punch page: %d\n",
-				pfn, err);
+			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
 		} else if (page_has_private(p) &&
 			   !try_to_release_page(p, GFP_NOIO)) {
-			pr_info("Memory failure: %#lx: failed to release buffers\n",
-				pfn);
+			pr_info("%#lx: failed to release buffers\n", pfn);
 		} else {
 			ret = MF_RECOVERED;
 		}
@@ -838,8 +839,7 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
 		if (invalidate_inode_page(p))
 			ret = MF_RECOVERED;
 		else
-			pr_info("Memory failure: %#lx: Failed to invalidate\n",
-				pfn);
+			pr_info("%#lx: Failed to invalidate\n",	pfn);
 	}
 
 	return ret;
@@ -869,7 +869,7 @@ static bool has_extra_refcount(struct page_state *ps, struct page *p,
 		count -= 1;
 
 	if (count > 0) {
-		pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
+		pr_err("%#lx: %s still referenced by %d users\n",
 		       page_to_pfn(p), action_page_types[ps->type], count);
 		return true;
 	}
@@ -893,7 +893,7 @@ static int me_kernel(struct page_state *ps, struct page *p)
  */
 static int me_unknown(struct page_state *ps, struct page *p)
 {
-	pr_err("Memory failure: %#lx: Unknown page state\n", page_to_pfn(p));
+	pr_err("%#lx: Unknown page state\n", page_to_pfn(p));
 	unlock_page(p);
 	return MF_FAILED;
 }
@@ -1179,7 +1179,7 @@ static void action_result(unsigned long pfn, enum mf_action_page_type type,
 	trace_memory_failure_event(pfn, type, result);
 
 	num_poisoned_pages_inc();
-	pr_err("Memory failure: %#lx: recovery action for %s: %s\n",
+	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
 }
 
@@ -1254,8 +1254,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 		if (head == compound_head(page))
 			return 1;
 
-		pr_info("Memory failure: %#lx cannot catch tail\n",
-			page_to_pfn(page));
+		pr_info("%#lx cannot catch tail\n", page_to_pfn(page));
 		put_page(head);
 	}
 
@@ -1318,7 +1317,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 	}
 out:
 	if (ret == -EIO)
-		pr_err("Memory failure: %#lx: unhandlable page.\n", page_to_pfn(p));
+		pr_err("%#lx: unhandlable page.\n", page_to_pfn(p));
 
 	return ret;
 }
@@ -1417,13 +1416,12 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		return true;
 
 	if (PageKsm(p)) {
-		pr_err("Memory failure: %#lx: can't handle KSM pages.\n", pfn);
+		pr_err("%#lx: can't handle KSM pages.\n", pfn);
 		return false;
 	}
 
 	if (PageSwapCache(p)) {
-		pr_err("Memory failure: %#lx: keeping poisoned page in swap cache\n",
-			pfn);
+		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
 		ttu |= TTU_IGNORE_HWPOISON;
 	}
 
@@ -1441,7 +1439,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		} else {
 			kill = 0;
 			ttu |= TTU_IGNORE_HWPOISON;
-			pr_info("Memory failure: %#lx: corrupted page was clean: dropped without side effects\n",
+			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
 				pfn);
 		}
 	}
@@ -1470,14 +1468,14 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 			try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
 			i_mmap_unlock_write(mapping);
 		} else
-			pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
+			pr_info("%#lx: could not lock mapping for mapped huge page\n", pfn);
 	} else {
 		try_to_unmap(folio, ttu);
 	}
 
 	unmap_success = !page_mapped(hpage);
 	if (!unmap_success)
-		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
+		pr_err("%#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(hpage));
 
 	/*
@@ -1844,7 +1842,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		*hugetlb = 0;
 		return 0;
 	} else if (res == -EHWPOISON) {
-		pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
+		pr_err("%#lx: already hardware poisoned\n", pfn);
 		if (flags & MF_ACTION_REQUIRED) {
 			head = compound_head(p);
 			res = kill_accessing_process(current, page_to_pfn(head), flags);
@@ -2003,8 +2001,7 @@ int memory_failure(unsigned long pfn, int flags)
 				goto unlock_mutex;
 			}
 		}
-		pr_err("Memory failure: %#lx: memory outside kernel control\n",
-			pfn);
+		pr_err("%#lx: memory outside kernel control\n", pfn);
 		res = -ENXIO;
 		goto unlock_mutex;
 	}
@@ -2015,8 +2012,7 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 
 	if (TestSetPageHWPoison(p)) {
-		pr_err("Memory failure: %#lx: already hardware poisoned\n",
-			pfn);
+		pr_err("%#lx: already hardware poisoned\n", pfn);
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
@@ -2232,7 +2228,7 @@ void memory_failure_queue(unsigned long pfn, int flags)
 	if (kfifo_put(&mf_cpu->fifo, entry))
 		schedule_work_on(smp_processor_id(), &mf_cpu->work);
 	else
-		pr_err("Memory failure: buffer overflow when queuing memory failure at %#lx\n",
+		pr_err("buffer overflow when queuing memory failure at %#lx\n",
 		       pfn);
 	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
 	put_cpu_var(memory_failure_cpu);
@@ -2289,6 +2285,7 @@ static int __init memory_failure_init(void)
 }
 core_initcall(memory_failure_init);
 
+#undef pr_fmt
 #define unpoison_pr_info(fmt, pfn, rs)			\
 ({							\
 	if (__ratelimit(rs))				\
-- 
2.35.3

