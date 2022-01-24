Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9049A7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315672AbiAYCx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374421AbiAYARC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:17:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A198AC02B8D4;
        Mon, 24 Jan 2022 14:03:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67163B80CCF;
        Mon, 24 Jan 2022 22:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D571FC340E4;
        Mon, 24 Jan 2022 22:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643061829;
        bh=xrwemF3DoaZJ3THX4M5sDEyymgR1OJsmnN+8J59590A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISJiKyxxFowPXIBWWiPDolNLtJNFOguGCeoc7oUL5TCgnV4fJO+brTfSXz7JFTeDX
         HtCvbWJ6PHsp6/6UMOJAOnVD9+kxn3mnLceBX6kTuorlJwT23mbldhnua5m53/nhGA
         tOfk7uG+SIVGyGrO9diUepvGo47ymC6jjeTNm9ZDgnBZNpVYR8I8li2ZX1DbsZKzWb
         aTYx96+KhUmG0rtTf2EiczL/gKnZNqV4t2FIqsyCZLTfff3a2VDygyKRPL7vBfIylY
         tlMMSeX8xC4B7VkVN2TPZXzpzoFKfK9lRYcWE53uo/+fUH5jMl0qqTJIMNlF1fI9Ai
         VQ5ik8h7M8LCA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 1/3] block: simplify calling convention of elv_unregister_queue()
Date:   Mon, 24 Jan 2022 13:59:36 -0800
Message-Id: <20220124215938.2769-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124215938.2769-1-ebiggers@kernel.org>
References: <20220124215938.2769-1-ebiggers@kernel.org>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-sysfs.c | 3 +--
 block/elevator.c  | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9f32882ceb2f6..a02b42ad9a6e0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -960,8 +960,7 @@ void blk_unregister_queue(struct gendisk *disk)
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

