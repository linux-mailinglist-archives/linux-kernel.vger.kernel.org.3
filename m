Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9280958CAE6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiHHO6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243542AbiHHO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:57:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635613D19
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659970660; x=1691506660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smWZqXtuGrkZm9PWI4t1Ng9axLN7SJF3zgimxq/DvoY=;
  b=jnVq964YeJsskxokORYCeVHyGtwWhbhwjQjcXigpJqF1kXQko7Rpoa03
   vc83sQHSOeFJCm0wF08JbU5X7dVF/pfxej8Hcg8HofXbocHvNSdEzCyNz
   PNgWS5h0LVbaYkTZn66vpkrEgw+PciRETGb3gxf/C9RJGIKZy2uEiFIgX
   OFYgRQf7LM8lm+o4G+H9F38ha0op68K02lD03MZRUsoi1fjNdVhzFUu9P
   fB8BUvzucvatr2ZU+OjyhOqqYnRkoU1B4FsQiaPBb7qERgLG6WceRjkGq
   3hrFRK01t41he4+aMz+bqx3ypMI8rdg2d3w+31/bjjbpqUngSYCRxMrpQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270996900"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270996900"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="663980524"
Received: from ziqianlu-desk2.sh.intel.com ([10.238.2.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:38 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [TEST NOT_FOR_MERGE 4/4] x86/mm/cpa: add a test interface to split direct map
Date:   Mon,  8 Aug 2022 22:56:49 +0800
Message-Id: <20220808145649.2261258-5-aaron.lu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808145649.2261258-1-aaron.lu@intel.com>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To test this functionality, a debugfs interface is added:
/sys/kernel/debug/x86/split_mapping

There are three test modes.
mode 0: allocate $page_nr pages and set each page's protection first
to RO and X and then back to RW and NX. This is used to test multiple
CPUs dealing with different address ranges.
mode 1: allocate several pages and create $nr_cpu kthreads to
simultaneously change those pages protection with a fixed pattern.
This is used to test multiple CPUs dealing with the same address range.
mode 2: same as mode 0 except using alloc_pages() instead of vmalloc()
because vmalloc space is too small on x86_32/pae.

On a x86_64 VM, I started mode0.sh and mode1.sh at the same time:

mode0.sh:
mode=0
page_nr=200000
nr_cpu=16

function test_one()
{
	echo $mode $page_nr > /sys/kernel/debug/x86/split_mapping
}

while true; do
	for i in `seq $nr_cpu`; do
		test_one &
	done
	wait
done

mode1.sh:
mode=1
page_nr=1
echo $mode $page_nr > /sys/kernel/debug/x86/split_mapping

After 5 hours, no problem occured with some millions of splits and merges.

For x86_32 and x86_pae, mode2 test is used and also no problem found.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 arch/x86/mm/pat/set_memory.c | 206 +++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1be9aab42c79..4deea4de73e7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -20,6 +20,9 @@
 #include <linux/kernel.h>
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/random.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -2556,6 +2559,209 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 	return retval;
 }
 
+static int split_mapping_mode0_test(int page_nr)
+{
+	void **addr_buff;
+	void *addr;
+	int i, j;
+
+	addr_buff = kvmalloc(sizeof(void *) * page_nr, GFP_KERNEL);
+	if (!addr_buff) {
+		pr_err("addr_buff: no memory\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < page_nr; i++) {
+		addr = vmalloc(PAGE_SIZE);
+		if (!addr) {
+			pr_err("no memory\n");
+			break;
+		}
+
+		set_memory_ro((unsigned long)addr, 1);
+		set_memory_x((unsigned long)addr, 1);
+
+		addr_buff[i] = addr;
+	}
+
+	for (j = 0; j < i; j++) {
+		set_memory_nx((unsigned long)addr_buff[j], 1);
+		set_memory_rw((unsigned long)addr_buff[j], 1);
+		vfree(addr_buff[j]);
+	}
+
+	kvfree(addr_buff);
+
+	return 0;
+}
+
+struct split_mapping_mode1_data {
+	unsigned long addr;
+	int page_nr;
+};
+
+static int split_mapping_set_prot(void *data)
+{
+	struct split_mapping_mode1_data *d = data;
+	unsigned long addr = d->addr;
+	int page_nr = d->page_nr;
+	int m;
+
+	m = get_random_int() % 100;
+	msleep(m);
+
+	while (!kthread_should_stop()) {
+		set_memory_ro(addr, page_nr);
+		set_memory_x(addr, page_nr);
+		set_memory_rw(addr, page_nr);
+		set_memory_nx(addr, page_nr);
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static int split_mapping_mode1_test(int page_nr)
+{
+	int nr_kthreads = num_online_cpus();
+	struct split_mapping_mode1_data d;
+	struct task_struct **kthreads;
+	int i, j, ret;
+	void *addr;
+
+	addr = vmalloc(PAGE_SIZE * page_nr);
+	if (!addr)
+		return -ENOMEM;
+
+	kthreads = kmalloc(nr_kthreads * sizeof(struct task_struct *), GFP_KERNEL);
+	if (!kthreads) {
+		vfree(addr);
+		return -ENOMEM;
+	}
+
+	d.addr = (unsigned long)addr;
+	d.page_nr = page_nr;
+	for (i = 0; i < nr_kthreads; i++) {
+		kthreads[i] = kthread_run(split_mapping_set_prot, &d, "split_mappingd%d", i);
+		if (IS_ERR(kthreads[i])) {
+			for (j = 0; j < i; j++)
+				kthread_stop(kthreads[j]);
+			ret = PTR_ERR(kthreads[i]);
+			goto out;
+		}
+	}
+
+	while (1) {
+		if (signal_pending(current)) {
+			for (i = 0; i < nr_kthreads; i++)
+				kthread_stop(kthreads[i]);
+			ret = 0;
+			break;
+		}
+		msleep(1000);
+	}
+
+out:
+	kfree(kthreads);
+	vfree(addr);
+	return ret;
+}
+
+static int split_mapping_mode2_test(int page_nr)
+{
+	struct page *p, *t;
+	unsigned long addr;
+	int i;
+
+	LIST_HEAD(head);
+
+	for (i = 0; i < page_nr; i++) {
+		p = alloc_pages(GFP_KERNEL | GFP_DMA32, 0);
+		if (!p) {
+			pr_err("no memory\n");
+			break;
+		}
+
+		addr = (unsigned long)page_address(p);
+		BUG_ON(!addr);
+
+		set_memory_ro(addr, 1);
+		set_memory_x(addr, 1);
+
+		list_add(&p->lru, &head);
+	}
+
+	list_for_each_entry_safe(p, t, &head, lru) {
+		addr = (unsigned long)page_address(p);
+		set_memory_nx(addr, 1);
+		set_memory_rw(addr, 1);
+
+		list_del(&p->lru);
+		__free_page(p);
+	}
+
+	return 0;
+}
+static ssize_t split_mapping_write_file(struct file *file, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	unsigned int mode = 0, page_nr = 0;
+	char buffer[64];
+	int ret;
+
+	if (count > 64)
+		return -EINVAL;
+
+	if (copy_from_user(buffer, buf, count))
+		return -EFAULT;
+	sscanf(buffer, "%u %u", &mode, &page_nr);
+
+	/*
+	 * There are 3 test modes.
+	 * mode 0: each thread allocates $page_nr pages and set each page's
+	 *         protection first to RO and X and then back to RW and NX.
+	 *         This is used to test multiple CPUs dealing with different
+	 *         pages.
+	 * mode 1: allocate several pages and create $nr_cpu kthreads to
+	 *         simultaneously change those pages protection to a fixed
+	 *         pattern. This is used to test multiple CPUs dealing with
+	 *         some same page's protection.
+	 * mode 2: like mode 0 but directly use alloc_pages() because vmalloc
+	 *         area on x86_32 is too small, only 128M.
+	 */
+	if (mode > 2)
+		return -EINVAL;
+
+	if (page_nr == 0)
+		return -EINVAL;
+
+	if (mode == 0)
+		ret = split_mapping_mode0_test(page_nr);
+	else if (mode == 1)
+		ret = split_mapping_mode1_test(page_nr);
+	else
+		ret = split_mapping_mode2_test(page_nr);
+
+	return ret ? ret : count;
+}
+
+static const struct file_operations split_mapping_fops = {
+	.write          = split_mapping_write_file,
+};
+
+static int __init split_mapping_init(void)
+{
+	struct dentry *d = debugfs_create_file("split_mapping", S_IWUSR, arch_debugfs_dir, NULL,
+			&split_mapping_fops);
+	if (IS_ERR(d)) {
+		pr_err("create split_mapping failed: %ld\n", PTR_ERR(d));
+		return PTR_ERR(d);
+	}
+
+	return 0;
+}
+late_initcall(split_mapping_init);
+
 /*
  * The testcases use internal knowledge of the implementation that shouldn't
  * be exposed to the rest of the kernel. Include these directly here.
-- 
2.37.1

