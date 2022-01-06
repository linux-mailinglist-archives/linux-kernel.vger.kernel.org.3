Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7790486821
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiAFRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:06:37 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62173 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241500AbiAFRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641488796; x=1673024796;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0Om1XFUlGd3CTNSK5EHsdaWuRS9pVMnTkDAr2gouZXQ=;
  b=J60Z+OJlSkS9cJYe/ka9sFec2o9vfAidB0/oZiZGllDI1vrqMh7HBYUt
   7gf9e4rLdq7fEBHqVfWv3nBKaFJZTkc5ksDEAgeI38X7tlHxy1EcZ58ji
   FdEaqDiMP5PFMm13T3mfhgw52F9VA82nubB843fAvJuUb+e9HHVvsJvgw
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jan 2022 09:06:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 09:06:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 6 Jan 2022 09:06:34 -0800
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 6 Jan 2022 09:06:31 -0800
From:   Charan Teja Reddy <quic_charante@quicinc.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <vbabka@suse.cz>, <rientjes@google.com>,
        <mhocko@suse.com>, <surenb@google.com>, <shakeelb@google.com>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Subject: [PATCH v3 RESEND] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
Date:   Thu, 6 Jan 2022 22:35:17 +0530
Message-ID: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charan Teja Reddy <charante@codeaurora.org>

Currently fadvise(2) is supported only for the files that doesn't
associated with noop_backing_dev_info thus for the files, like shmem,
fadvise results into NOP. But then there is file_operations->fadvise()
that lets the file systems to implement their own fadvise
implementation. Use this support to implement some of the POSIX_FADV_XXX
functionality for shmem files.

This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
advices to shmem files which can be helpful for the drivers who may want
to manage the shmem pages of the files that are created through
shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
can create the shmem file of the size equal to its requirements and
map the pages for DMA and then pass the fd to user. The user who knows
well about the usage of these pages can now decide when these pages are
not required push them to swap through DONTNEED thus free up memory well
in advance rather than relying on the reclaim and use WILLNEED when it
decide that they are useful in the near future. IOW, it lets the clients
to free up/read the memory when it wants to. Another usecase is that GEM
objets which are currenlty allocated and managed through shmem files can
use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
know(like through some hints from user space) that GEM objects are not
going to use/will need in the near future.

Some questions asked while reviewing this patch:

Q) Can the same thing be achieved with FD mapped to user and use
madvise?
A) All drivers are not mapping all the shmem fd's to user space and want
to manage them with in the kernel. Ex: shmem memory can be mapped to the
other subsystems and they fill in the data and then give it to other
subsystem for further processing, where, the user mapping is not at all
required.  A simple example, memory that is given for gpu subsystem
which can be filled directly and give to display subsystem. And the
respective drivers know well about when to keep that memory in ram or
swap based on may be a user activity.

Q) Should we add the documentation section in Manual pages?
A) The man[1] pages for the fadvise() whatever says is also applicable
for shmem files. so couldn't feel it correct to add specific to shmem
files separately.
[1] https://linux.die.net/man/2/fadvise

Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
and this difference will cause confusion?
A) man pages [1] says that "POSIX_FADV_DONTNEED attempts to free cached
pages associated with the specified region." This means on issuing this
FADV, it is expected to free the file cache pages. And it is
implementation defined If the dirty pages may be attempted to writeback.
And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
covers the semantics of MADV_PAGEOUT for file pages and there is no
purpose of PAGEOUT for file pages.
[1] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>
---

Changes in V3:
  -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identified by Matthew.
  -- xarray used properly, as identified by Matthew.
  -- Excluded mapped pages as it requires unmapping and the man pages of fadvise don't talk about them.
  -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defined.

Changes in V2:
  -- Rearranged the code to not to sleep with rcu_lock while using xas_() functionality.
  -- Addressed the comments from Suren.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-1591-1-git-send-email-quic_charante@quicinc.com/

changes in V1:
  -- Created the interface for fadvise(2) to work on shmem files.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-22302-1-git-send-email-charante@codeaurora.org/

 mm/shmem.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 23c91a8..dd3ac2e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -39,6 +39,8 @@
 #include <linux/frontswap.h>
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
+#include <linux/mm_inline.h>
+#include <linux/fadvise.h>
 
 static struct vfsmount *shm_mnt;
 
@@ -2275,6 +2277,175 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
+				loff_t end, struct list_head *list)
+{
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct page *page;
+
+	rcu_read_lock();
+	xas_for_each(&xas, page, end) {
+		if (xas_retry(&xas, page))
+			continue;
+		if (xa_is_value(page))
+			continue;
+		if (!get_page_unless_zero(page))
+			continue;
+		if (isolate_lru_page(page))
+			continue;
+
+		list_add(&page->lru, list);
+		__mod_node_page_state(page_pgdat(page),
+				NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
+		put_page(page);
+		if (need_resched()) {
+			xas_pause(&xas);
+			cond_resched_rcu();
+		}
+	}
+	rcu_read_unlock();
+}
+
+static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
+				loff_t end)
+{
+	int ret;
+	struct page *page;
+	LIST_HEAD(list);
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_NONE,
+		.nr_to_write = LONG_MAX,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
+		.for_reclaim = 1,
+	};
+
+	if (!shmem_mapping(mapping))
+		return -EINVAL;
+
+	if (!total_swap_pages)
+		return 0;
+
+	lru_add_drain();
+	shmem_isolate_pages_range(mapping, start, end, &list);
+
+	while (!list_empty(&list)) {
+		page = lru_to_page(&list);
+		list_del(&page->lru);
+		if (page_mapped(page))
+			goto keep;
+		if (!trylock_page(page))
+			goto keep;
+		if (unlikely(PageTransHuge(page))) {
+			if (split_huge_page_to_list(page, &list))
+				goto keep;
+		}
+
+		clear_page_dirty_for_io(page);
+		SetPageReclaim(page);
+		ret = shmem_writepage(page, &wbc);
+		if (ret || PageWriteback(page)) {
+			if (ret)
+				unlock_page(page);
+			goto keep;
+		}
+
+		if (!PageWriteback(page))
+			ClearPageReclaim(page);
+
+		/*
+		 * shmem_writepage() place the page in the swapcache.
+		 * Delete the page from the swapcache and release the
+		 * page.
+		 */
+		__mod_node_page_state(page_pgdat(page),
+				NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
+		lock_page(page);
+		delete_from_swap_cache(page);
+		unlock_page(page);
+		put_page(page);
+		continue;
+keep:
+		putback_lru_page(page);
+		__mod_node_page_state(page_pgdat(page),
+				NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
+	}
+
+	return 0;
+}
+
+static int shmem_fadvise_willneed(struct address_space *mapping,
+				 pgoff_t start, pgoff_t long end)
+{
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct page *page;
+
+	rcu_read_lock();
+	xas_for_each(&xas, page, end) {
+		if (!xa_is_value(page))
+			continue;
+		xas_pause(&xas);
+		rcu_read_unlock();
+
+		page = shmem_read_mapping_page(mapping, xas.xa_index);
+		if (!IS_ERR(page))
+			put_page(page);
+
+		rcu_read_lock();
+		if (need_resched()) {
+			xas_pause(&xas);
+			cond_resched_rcu();
+		}
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	loff_t endbyte;
+	pgoff_t start_index;
+	pgoff_t end_index;
+	struct address_space *mapping;
+	int ret = 0;
+
+	mapping = file->f_mapping;
+	if (!mapping || len < 0)
+		return -EINVAL;
+
+	endbyte = (u64)offset + (u64)len;
+	if (!len || endbyte < len)
+		endbyte = -1;
+	else
+		endbyte--;
+
+
+	start_index = offset >> PAGE_SHIFT;
+	end_index   = endbyte >> PAGE_SHIFT;
+	switch (advice) {
+	case POSIX_FADV_DONTNEED:
+		ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
+		break;
+	case POSIX_FADV_WILLNEED:
+		ret = shmem_fadvise_willneed(mapping, start_index, end_index);
+		break;
+	case POSIX_FADV_NORMAL:
+	case POSIX_FADV_RANDOM:
+	case POSIX_FADV_SEQUENTIAL:
+	case POSIX_FADV_NOREUSE:
+		/*
+		 * No bad return value, but ignore advice. May have to
+		 * implement in future.
+		 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
 				     umode_t mode, dev_t dev, unsigned long flags)
 {
@@ -3826,6 +3997,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
 #endif
+	.fadvise	= shmem_fadvise,
 };
 
 static const struct inode_operations shmem_inode_operations = {
-- 
2.7.4

