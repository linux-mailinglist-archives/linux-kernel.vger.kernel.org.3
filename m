Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0581B46CA29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbhLHBkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:40:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41020 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbhLHBkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:40:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C132B81F41;
        Wed,  8 Dec 2021 01:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE75FC341C8;
        Wed,  8 Dec 2021 01:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638927404;
        bh=FI94LMs/MZJPMgKuwfnYxQnphmZIYFclD5XbAtx6RLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAzUPWu+sIK0xH4jCplrLoSifKPKAIsgwtSCy9mcc+8EeZMjkFJD6n+pVLj9LQG4l
         06CK/ThJ57ooSO0jW1r/9HDD3xJcNFgHZhvBjmV4B5bfXAS4s3SyIV5nwJ7TTZyMdm
         g63qM3GODicvqrInsrNrupAn+Q5M8tDXsAAzcToZ3iEakn2e0rURhjWg8whHu95dJg
         szPrP8IcHk1wYjAVAZggSagPDCmWag/qAXTot0v7eHTZC496G2qQYhCpPTjypDE1kc
         8a9830bcOU/jUM8bI0l2vy956CdaXZ5pjSCJG0rBis/ishQwgOBnGohxUPPcTSPkhU
         RIsieU9/nPd0g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 2/3] block: don't delete queue kobject before its children
Date:   Tue,  7 Dec 2021 17:35:33 -0800
Message-Id: <20211208013534.136590-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208013534.136590-1-ebiggers@kernel.org>
References: <20211208013534.136590-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

kobjects aren't supposed to be deleted before their child kobjects are
deleted.  Apparently this is usually benign; however, a WARN will be
triggered if one of the child kobjects has a named attribute group:

    sysfs group 'modes' not found for kobject 'crypto'
    WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:278 sysfs_remove_group+0x72/0x80
    ...
    Call Trace:
      sysfs_remove_groups+0x29/0x40 fs/sysfs/group.c:312
      __kobject_del+0x20/0x80 lib/kobject.c:611
      kobject_cleanup+0xa4/0x140 lib/kobject.c:696
      kobject_release lib/kobject.c:736 [inline]
      kref_put include/linux/kref.h:65 [inline]
      kobject_put+0x53/0x70 lib/kobject.c:753
      blk_crypto_sysfs_unregister+0x10/0x20 block/blk-crypto-sysfs.c:159
      blk_unregister_queue+0xb0/0x110 block/blk-sysfs.c:962
      del_gendisk+0x117/0x250 block/genhd.c:610

Fix this by moving the kobject_del() and the corresponding
kobject_uevent() to the correct place.

Fixes: 2c2086afc2b8 ("block: Protect less code with sysfs_lock in blk_{un,}register_queue()")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 3152d244e9b36..c11242ef88558 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -952,15 +952,17 @@ void blk_unregister_queue(struct gendisk *disk)
 	 */
 	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
-
-	kobject_uevent(&q->kobj, KOBJ_REMOVE);
-	kobject_del(&q->kobj);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
 	elv_unregister_queue(q);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
+
+	/* Now that all child objects were deleted, the queue can be deleted. */
+	kobject_uevent(&q->kobj, KOBJ_REMOVE);
+	kobject_del(&q->kobj);
+
 	mutex_unlock(&q->sysfs_dir_lock);
 
 	kobject_put(&disk_to_dev(disk)->kobj);
-- 
2.34.1

