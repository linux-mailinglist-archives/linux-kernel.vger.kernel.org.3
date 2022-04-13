Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0784C4FF285
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiDMIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiDMIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:47:07 -0400
Received: from support.corp-email.com (support.corp-email.com [222.73.234.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793584D616
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:44:46 -0700 (PDT)
Received: from ([114.119.32.142])
        by support.corp-email.com ((D)) with ASMTP (SSL) id IEG00038;
        Wed, 13 Apr 2022 16:44:38 +0800
Received: from localhost.localdomain (172.16.35.4) by GCY-MBS-28.TCL.com
 (10.136.3.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 13 Apr
 2022 16:44:38 +0800
From:   Rokudo Yan <wu-yan@tcl.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <tang.ding@tcl.com>,
        <wu-yan@tcl.com>
Subject: [PATCH] f2fs: avoid deadlock in gc thread under low memory
Date:   Wed, 13 Apr 2022 16:44:32 +0800
Message-ID: <20220413084432.1312900-1-wu-yan@tcl.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.35.4]
X-ClientProxiedBy: GCY-EXS-27.TCL.com (10.74.128.67) To GCY-MBS-28.TCL.com
 (10.136.3.28)
tUid:   2022413164438f383f1451cf81c4bc895e3d2271acda2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential deadlock in gc thread may happen
under low memory as below:

gc_thread_func
 -f2fs_gc
  -do_garbage_collect
   -gc_data_segment
    -move_data_block
     -set_page_writeback(fio.encrypted_page);
     -f2fs_submit_page_write
as f2fs_submit_page_write try to do io merge when possible, so the
encrypted_page is marked PG_writeback but may not submit to block
layer immediately, if system enter low memory when gc thread try
to move next data block, it may do direct reclaim and enter fs layer
as below:
   -move_data_block
    -f2fs_grab_cache_page(index=?, for_write=false)
     -grab_cache_page
      -find_or_create_page
       -pagecache_get_page
        -__page_cache_alloc --  __GFP_FS is set
         -alloc_pages_node
          -__alloc_pages
           -__alloc_pages_slowpath
            -__alloc_pages_direct_reclaim
             -__perform_reclaim
              -try_to_free_pages
               -do_try_to_free_pages
                -shrink_zones
                 -mem_cgroup_soft_limit_reclaim
                  -mem_cgroup_soft_reclaim
                   -mem_cgroup_shrink_node
                    -shrink_node_memcg
                     -shrink_list
                      -shrink_inactive_list
                       -shrink_page_list
                        -wait_on_page_writeback -- the page is marked
                       writeback during previous move_data_block call

the gc thread wait for the encrypted_page writeback complete,
but as gc thread held sbi->gc_lock, the writeback & sync thread
may blocked waiting for sbi->gc_lock, so the bio contain the
encrypted_page may nerver submit to block layer and complete the
writeback, which cause deadlock. To avoid this deadlock condition,
we mark the gc thread with PF_MEMALLOC_NOFS flag, then it will nerver
enter fs layer when try to alloc cache page during move_data_block.

Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
---
 fs/f2fs/gc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e020804f7b07..cc71f77b98c8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -38,6 +38,12 @@ static int gc_thread_func(void *data)
 
 	wait_ms = gc_th->min_sleep_time;
 
+	/*
+	 * Make sure that no allocations from gc thread will ever
+	 * recurse to the fs layer to avoid deadlock as it will
+	 * hold sbi->gc_lock during garbage collection
+	 */
+	memalloc_nofs_save();
 	set_freezable();
 	do {
 		bool sync_mode, foreground = false;
-- 
2.25.1

