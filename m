Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F85856AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiG2Vwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 17:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbiG2Vwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 17:52:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB836715C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 14:52:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so4812242pjn.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SgHDJUiOkS7miIyL7LpVzR5WDmqzLdFMNFDQ4k5m+II=;
        b=S6IsfuP/AS5LnyXDjhqLEZhysQNh9np7P0PVtML73SC5YHnQ3RoeLeKKGnv3hKArSp
         2sJucdbqRlcFSXkLWcPNAwclYCIVQjWPyjN3UFjKle4a5FMYxfX6fN7huaNgS6+2ZfkH
         NfbkE7mO7evc4XtGYzbVHfAyONwvhloMY57l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SgHDJUiOkS7miIyL7LpVzR5WDmqzLdFMNFDQ4k5m+II=;
        b=SEFMyizcHP7FgZQGhAkYmC2KIzKtRKSRoqOAYXhDuTG3AkLLJnJQu+c8j0Xe5p9xd6
         tT0NuhrZ8tITuM4aG6SCY/tiJWFL1YUQG2D+jwkrtPHPlaaAd56gufSDRZ2EYD8MKPPF
         wO0xYosmLKJO4KWm4U3QgZI3BHiR6FyQn3STApmBazztV7Vsa8eCN8OJGWj52inf2NTV
         ovmtXILwiI32bj0h0kCnXVr1BE9sw+6YExJGc7dLtdZrRh6yuXpfaZS54rtO0aAbWiz6
         kzPSX6J07Gh3sKIGwv0OIfd25tCe/iUg44SeArBtszVTnhanvjG7Dki7womYE+DzoSvP
         e3bA==
X-Gm-Message-State: ACgBeo0Fs8t5Ikq8wgSe0m0GCeoog+Aiwcav6Lxes23VNi3bzgHCRKor
        0rFytPsY4+vRQoxMe2/oG9KiScFM8JUGEv8s
X-Google-Smtp-Source: AA6agR6eh/nvWxLzgIj3QH2UD39HgpPvwOF/Kd0gbiLoBuxJn5BFill6VJt0GRPS8r6JDRZHh//TdA==
X-Received: by 2002:a17:902:ca0b:b0:16d:d562:42dc with SMTP id w11-20020a170902ca0b00b0016dd56242dcmr3928192pld.26.1659131555937;
        Fri, 29 Jul 2022 14:52:35 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:3ea0:edff:78ae:d482])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a410400b001f2e20edd14sm6323609pjf.45.2022.07.29.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 14:52:35 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] writeback: check wb shutdown for bw_dwork
Date:   Fri, 29 Jul 2022 14:51:23 -0700
Message-Id: <20220729215123.1998585-1-khazhy@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a KASAN splat in timer interrupt after removing a device

Move wb->work_lock to be irq-safe, as complete may be called from irq

Fixes: 45a2966fd641 ("writeback: fix bandwidth estimate for spiky workload")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fs-writeback.c   | 12 ++++++------
 mm/backing-dev.c    | 10 +++++-----
 mm/page-writeback.c |  6 +++++-
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 05221366a16d..08a1993ab7fd 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -134,10 +134,10 @@ static bool inode_io_list_move_locked(struct inode *inode,
 
 static void wb_wakeup(struct bdi_writeback *wb)
 {
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
 		mod_delayed_work(bdi_wq, &wb->dwork, 0);
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 }
 
 static void finish_writeback_work(struct bdi_writeback *wb,
@@ -164,7 +164,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
 	if (work->done)
 		atomic_inc(&work->done->cnt);
 
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 
 	if (test_bit(WB_registered, &wb->state)) {
 		list_add_tail(&work->list, &wb->work_list);
@@ -172,7 +172,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
 	} else
 		finish_writeback_work(wb, work);
 
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 }
 
 /**
@@ -2082,13 +2082,13 @@ static struct wb_writeback_work *get_next_work_item(struct bdi_writeback *wb)
 {
 	struct wb_writeback_work *work = NULL;
 
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 	if (!list_empty(&wb->work_list)) {
 		work = list_entry(wb->work_list.next,
 				  struct wb_writeback_work, list);
 		list_del_init(&work->list);
 	}
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 	return work;
 }
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 95550b8fa7fe..de65cb1e5f76 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -260,10 +260,10 @@ void wb_wakeup_delayed(struct bdi_writeback *wb)
 	unsigned long timeout;
 
 	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
 		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 }
 
 static void wb_update_bandwidth_workfn(struct work_struct *work)
@@ -334,12 +334,12 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb);
 static void wb_shutdown(struct bdi_writeback *wb)
 {
 	/* Make sure nobody queues further work */
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 	if (!test_and_clear_bit(WB_registered, &wb->state)) {
-		spin_unlock_bh(&wb->work_lock);
+		spin_unlock_irq(&wb->work_lock);
 		return;
 	}
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 
 	cgwb_remove_from_bdi_list(wb);
 	/*
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 55c2776ae699..3c34db15cf70 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2867,6 +2867,7 @@ static void wb_inode_writeback_start(struct bdi_writeback *wb)
 
 static void wb_inode_writeback_end(struct bdi_writeback *wb)
 {
+	unsigned long flags;
 	atomic_dec(&wb->writeback_inodes);
 	/*
 	 * Make sure estimate of writeback throughput gets updated after
@@ -2875,7 +2876,10 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
 	 * that if multiple inodes end writeback at a similar time, they get
 	 * batched into one bandwidth update.
 	 */
-	queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
+	spin_lock_irqsave(&wb->work_lock, flags);
+	if (test_bit(WB_registered, &wb->state))
+		queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
+	spin_unlock_irqrestore(&wb->work_lock, flags);
 }
 
 bool __folio_end_writeback(struct folio *folio)
-- 
2.37.1.455.g008518b4e5-goog

