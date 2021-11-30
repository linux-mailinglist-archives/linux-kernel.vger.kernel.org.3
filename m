Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE5C462B73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhK3EIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhK3EIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:08:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61076C061574;
        Mon, 29 Nov 2021 20:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2516DB811FF;
        Tue, 30 Nov 2021 04:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9180C53FC1;
        Tue, 30 Nov 2021 04:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638245121;
        bh=a1liu2Lo3sMfRhCcP9f3gWfgoXAydt5G60CI7Sx/zkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUR9YgE8gOCFkseE2T9VubdkQlpzKqiCFRjZhcDlQ0ajPbaD2bYnY9Lmk63AZCJcw
         KqpoGKRUwVGuU+eFvEhp44poaIzAR/wl0xODYqy1BmRaLZlXAzDLFGMYqQ2WU9A/mu
         pIkSNRvWYGAPGNSZ0y5spllEimYnzwa08wYwtfC+pNi2cBiIuLqMHbRPesTNAQ8cEh
         OhJZqXlGYIm0Iu/kaWdQRUE0bmk3qESF4pTijllTvnPXNxxhotag/kYP0pFkw58TMv
         20ONYzB2fXvOHl/cY+L8YivHKBCynSc87nEpvvJFLKYwTg9dr0ESMyuZys+VjVmU3z
         IdV7YhScBC9BA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/3] block: simplify calling convention of elv_unregister_queue()
Date:   Mon, 29 Nov 2021 20:03:04 -0800
Message-Id: <20211130040306.148925-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211130040306.148925-1-ebiggers@kernel.org>
References: <20211130040306.148925-1-ebiggers@kernel.org>
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

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-sysfs.c | 3 +--
 block/elevator.c  | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4622da4bb9927..91d3805a6ec6b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -957,8 +957,7 @@ void blk_unregister_queue(struct gendisk *disk)
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

