Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4364D5FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245467AbiCKKqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbiCKKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:46:14 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD581BD987
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646995511; x=1678531511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=C12/qIJCuMb8jP6JyjtJ1oqtbsaCGfsZS+dgXzGtAdU=;
  b=mTHmrzDuhsw2kAB9x8HJZGQaBPXA5Ldhiid13Fp4SpcxH+KS6pDHEMOx
   QyfZIbbFNcbCwET2edZToKhM94dqVW/3Yz41+vIL0iQ9jM82TUW07GPMT
   lW/0ehxM318OjzAmyl0HhcJxwa8O4TQMRcJ7hXEIMy1XOAOwK/vULlprd
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 Mar 2022 02:45:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:45:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Mar 2022 02:45:09 -0800
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Mar 2022 02:45:05 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <markhemm@googlemail.com>, <vbabka@suse.cz>, <rientjes@google.com>,
        <mhocko@suse.com>, <surenb@google.com>, <shakeelb@google.com>,
        <willy@infradead.org>, <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V5,2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
Date:   Fri, 11 Mar 2022 16:13:52 +0530
Message-ID: <94fce97600df1402fad9f109ea34467d612be448.1646987674.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1646987674.git.quic_charante@quicinc.com>
References: <cover.1646987674.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
objects which are currently allocated and managed through shmem files
can use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
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

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
Changes in V5:
  -- Moved the 'endbyte' calculations to a helper function which is also needed for shmem_fadvise.
  -- Addressed comments from Suren.

Changes in V4:
  -- Changed the code to use reclaim_pages() to writeout the shmem pages to swap and then reclaim.
  -- Addressed comments from Mark Hemment and Matthew.
  -- fadvise() on shmem file may even unmap a page.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1644572051-24091-1-git-send-email-quic_charante@quicinc.com/

Changes in V3:
  -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identified by Matthew.
  -- xarray used properly, as identified by Matthew.
  -- Excluded mapped pages as it requires unmapping and the man pages of fadvise don't talk about them.
  -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defined.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1641488717-13865-1-git-send-email-quic_charante@quicinc.com/

Changes in V2:
  -- Rearranged the code to not to sleep with rcu_lock while using xas_() functionality.
  -- Addressed the comments from Suren.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-1591-1-git-send-email-quic_charante@quicinc.com/

changes in V1:
  -- Created the interface for fadvise(2) to work on shmem files.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-22302-1-git-send-email-charante@codeaurora.org/


 mm/shmem.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index a09b29e..5fc2600 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -38,6 +38,9 @@
 #include <linux/hugetlb.h>
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
+#include <linux/mm_inline.h>
+#include <linux/fadvise.h>
+#include <linux/page_idle.h>
 
 static struct vfsmount *shm_mnt;
 
@@ -2241,6 +2244,125 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
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
+
+		if (!get_page_unless_zero(page))
+			continue;
+		if (isolate_lru_page(page)) {
+			put_page(page);
+			continue;
+		}
+		put_page(page);
+
+		if (PageUnevictable(page) || page_mapcount(page) > 1) {
+			putback_lru_page(page);
+			continue;
+		}
+
+		/*
+		 * Prepare the page to be passed to the reclaim_pages().
+		 * VM couldn't reclaim the page unless we clear PG_young.
+		 * Also, to ensure that the pages are written before
+		 * reclaiming, page is set to dirty.
+		 * Since we are not clearing the pte_young in the mapped
+		 * page pte's, its reclaim may not be attempted.
+		 */
+		ClearPageReferenced(page);
+		test_and_clear_page_young(page);
+		list_add(&page->lru, list);
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
+	LIST_HEAD(list);
+
+	if (!shmem_mapping(mapping))
+		return -EINVAL;
+
+	if (!total_swap_pages)
+		return 0;
+
+	lru_add_drain();
+	shmem_isolate_pages_range(mapping, start, end, &list);
+	reclaim_pages(&list);
+
+	return 0;
+}
+
+static int shmem_fadvise_willneed(struct address_space *mapping,
+				 pgoff_t start, pgoff_t long end)
+{
+	struct page *page;
+	pgoff_t index;
+
+	xa_for_each_range(&mapping->i_pages, index, page, start, end) {
+		if (!xa_is_value(page))
+			continue;
+		page = shmem_read_mapping_page(mapping, index);
+		if (!IS_ERR(page))
+			put_page(page);
+	}
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
+	endbyte = fadvise_calc_endbyte(offset, len);
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
@@ -3777,6 +3899,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
 #endif
+	.fadvise	= shmem_fadvise,
 };
 
 static const struct inode_operations shmem_inode_operations = {
-- 
2.7.4

