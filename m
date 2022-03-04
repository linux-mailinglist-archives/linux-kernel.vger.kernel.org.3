Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA54CCC81
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiCDES2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCDESZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:18:25 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB555F5E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:17:30 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so8218007ooi.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 20:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version;
        bh=F9TbYxR+R1nD8tLe/duorfWnJfxcUFTIrqLdJSGb4Nw=;
        b=Dhw2j6g25MRVPJ2osvZqZK0aEhXCSSRvVX169xe/KD4YZdQSTRPYqA+/SI2HPy/LKI
         5LyimD2XdETUJqVoLsP9NJnvV+3cU/OK5yk5TcX8GFU1/DN1VdW6M7uFMBBkhgyDxkao
         p/OcdaXLNWfCO+teu08XSjeJ4TVq7nCmb4egR9eHr0R1crd+LrLpUlrOo3NkbMC6/qW3
         NUcEjBlZSXRJAL975bI73irCvwMknOcWT+N1L975dTtkGgMDdxv/KjOJ/7nV5zqLf2Ei
         5+07pCBwUvUyrlCj7prS8SxPo7qjc+BXul9Dm3n8wxbb+3wmOqGMIIEC5Z3q3EfQF96O
         18PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version;
        bh=F9TbYxR+R1nD8tLe/duorfWnJfxcUFTIrqLdJSGb4Nw=;
        b=Jdfg7RJGWBpMd1QW2g4bOZ7hRkvrbn0o60lzeAGvxRmn1KviatTqzFFMQHvW+C59+x
         Nvy5tW/hwdRfZKobE1KAut99Wdpst3zHnNn1ZIcFS7mHGo87BQGOygEnFma/AFl2YOqL
         rxvAVswLWD3Kzjllq2MAYgjhNatNgDDZ9zsr+Ld3NaHbwpqQO/YIAqaNigjVkY1QCb3J
         FzExZ3w4JkIaXzERoWC5a/2YDka1GgYeLNKxAHPJixM5orcMcaMU6Eyba2JpoU5Nyxh9
         qpbfGhqss1a6SOIYZkQelXsoXXWUsJv/al5jpqkUA3WUySEAn8I7s9j9MAp1CTBNJl7F
         7MzQ==
X-Gm-Message-State: AOAM5338975Kb/9XIUpDiPY0YLplhFf4atwaMfgOE3ycZ7YyFjGTQEDW
        JVw052g7JmtkmI8tYSkCUaUSS15OkQ+J2g==
X-Google-Smtp-Source: ABdhPJxmbCnDBMDplAs+h3hW25CdTHsVll96/gK4uz8Nbr8b4iD3mhsPX+rv+D8Zj+WxdXkp1IZxdA==
X-Received: by 2002:a4a:cf03:0:b0:31d:79a5:ac51 with SMTP id l3-20020a4acf03000000b0031d79a5ac51mr13881806oos.35.1646367448827;
        Thu, 03 Mar 2022 20:17:28 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm2171961oiv.21.2022.03.03.20.17.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:17:27 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:17:26 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     linux-kernel@vger.kernel.org
Subject: [PATCH mmotm] mm/fs: delete PF_SWAPWRITE (fwd)
Message-ID: <f8accd65-a5a0-2057-add-eeb3277f7e10@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
Date: Thu, 3 Mar 2022 20:12:42 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.de>,
    Darrick J. Wong <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
    Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kerne.org, linux-mm@kvack.org
Subject: [PATCH mmotm] mm/fs: delete PF_SWAPWRITE

PF_SWAPWRITE has been redundant since v3.2 commit ee72886d8ed5
("mm: vmscan: do not writeback filesystem pages in direct reclaim").

Coincidentally, NeilBrown's current patch "remove inode_congested()"
deletes may_write_to_inode(), which appeared to be the one function
which took notice of PF_SWAPWRITE.  But if you study the old logic,
and the conditions under which may_write_to_inode() was called, you
discover that flag and function have been pointless for a decade.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 fs/fs-writeback.c         | 3 ---
 fs/xfs/libxfs/xfs_btree.c | 2 +-
 include/linux/sched.h     | 1 -
 mm/migrate.c              | 7 -------
 mm/vmscan.c               | 8 ++------
 5 files changed, 3 insertions(+), 18 deletions(-)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2196,7 +2196,6 @@ void wb_workfn(struct work_struct *work)
 	long pages_written;
 
 	set_worker_desc("flush-%s", bdi_dev_name(wb->bdi));
-	current->flags |= PF_SWAPWRITE;
 
 	if (likely(!current_is_workqueue_rescuer() ||
 		   !test_bit(WB_registered, &wb->state))) {
@@ -2225,8 +2224,6 @@ void wb_workfn(struct work_struct *work)
 		wb_wakeup(wb);
 	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
 		wb_wakeup_delayed(wb);
-
-	current->flags &= ~PF_SWAPWRITE;
 }
 
 /*
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2818,7 +2818,7 @@ struct xfs_btree_split_args {
 	 * in any way.
 	 */
 	if (args->kswapd)
-		new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
+		new_pflags |= PF_MEMALLOC | PF_KSWAPD;
 
 	current_set_flags_nested(&pflags, new_pflags);
 	xfs_trans_set_context(args->cur->bc_tp);
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1700,7 +1700,6 @@ static inline int is_global_init(struct task_struct *tsk)
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1350,7 +1350,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	bool is_thp = false;
 	struct page *page;
 	struct page *page2;
-	int swapwrite = current->flags & PF_SWAPWRITE;
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(thp_split_pages);
@@ -1359,9 +1358,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 	trace_mm_migrate_pages_start(mode, reason);
 
-	if (!swapwrite)
-		current->flags |= PF_SWAPWRITE;
-
 thp_subpage_migration:
 	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
 		retry = 0;
@@ -1516,9 +1512,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
 			       nr_thp_failed, nr_thp_split, mode, reason);
 
-	if (!swapwrite)
-		current->flags &= ~PF_SWAPWRITE;
-
 	if (ret_succeeded)
 		*ret_succeeded = nr_succeeded;
 
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4468,7 +4468,7 @@ static int kswapd(void *p)
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
+	tsk->flags |= PF_MEMALLOC | PF_KSWAPD;
 	set_freezable();
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
@@ -4519,7 +4519,7 @@ static int kswapd(void *p)
 			goto kswapd_try_sleep;
 	}
 
-	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
+	tsk->flags &= ~(PF_MEMALLOC | PF_KSWAPD);
 
 	return 0;
 }
@@ -4760,11 +4760,8 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	fs_reclaim_acquire(sc.gfp_mask);
 	/*
 	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
-	 * and we also need to be able to write out pages for RECLAIM_WRITE
-	 * and RECLAIM_UNMAP.
 	 */
 	noreclaim_flag = memalloc_noreclaim_save();
-	p->flags |= PF_SWAPWRITE;
 	set_task_reclaim_state(p, &sc.reclaim_state);
 
 	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
@@ -4778,7 +4775,6 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	}
 
 	set_task_reclaim_state(p, NULL);
-	current->flags &= ~PF_SWAPWRITE;
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(sc.gfp_mask);
 	psi_memstall_leave(&pflags);
