Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1350F46CA2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbhLHBk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242908AbhLHBkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:40:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E89CC061746;
        Tue,  7 Dec 2021 17:36:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C8B0BCE1ECA;
        Wed,  8 Dec 2021 01:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8A7C341C3;
        Wed,  8 Dec 2021 01:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638927403;
        bh=pVSYJFJjUWHihPgtMfNgvlrUbotgtg4iSAeSHNRZ1no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFIpeISYhVhcRBrBue3sCuUtvi1j6SmrwgZ8W6aDRTmtMJ197iQqnTblsFBw8LpsV
         WxTrty86fCQCqeqmakObNulRHnrLH2Wg3XGwiwpHjotOtUFG75tpDlYnpgpK8HIrZ2
         uMsPvzHvZmDKE9Ungi3i/sr4ddllHuWKWsFWFLw9hPgfAkzzsQo4CaPBiWmd2gA0qw
         T5Miux73Vem0s/MdgkAhSmcFqvRTfcQXDv5b0lh5/UfVC2BM3HlyDEwVne6Nd1tF+C
         l3wuRX3gi5Y66lqEEoUpIZ2LmBvogzeGGpxHABtboRcPWMcyzSJMeXlN5SxQv/iAYo
         C8+hXq2U7C6Pw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 1/3] block: simplify calling convention of elv_unregister_queue()
Date:   Tue,  7 Dec 2021 17:35:32 -0800
Message-Id: <20211208013534.136590-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208013534.136590-1-ebiggers@kernel.org>
References: <20211208013534.136590-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make elv_unregister_queue() a no-op if q->elevator is NULL or is not
registered.

This simplifies the existing callers, as well as the future caller in
the error path of blk_register_queue().

Also don't bother checking whether q is NULL, since it never is.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-sysfs.c | 3 +--
 block/elevator.c  | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 3e6357321225f..3152d244e9b36 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -958,8 +958,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
-	if (q->elevator)
-		elv_unregister_queue(q);
+	elv_unregister_queue(q);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
diff --git a/block/elevator.c b/block/elevator.c
index ec98aed39c4f5..b062c5bc10b9a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -516,9 +516,11 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 
 void elv_unregister_queue(struct request_queue *q)
 {
+	struct elevator_queue *e = q->elevator;
+
 	lockdep_assert_held(&q->sysfs_lock);
 
-	if (q) {
+	if (e && e->registered) {
 		struct elevator_queue *e = q->elevator;
 
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
@@ -593,9 +595,7 @@ int elevator_switch_mq(struct request_queue *q,
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (q->elevator) {
-		if (q->elevator->registered)
-			elv_unregister_queue(q);
-
+		elv_unregister_queue(q);
 		ioc_clear_queue(q);
 		blk_mq_sched_free_rqs(q);
 		elevator_exit(q);
-- 
2.34.1

