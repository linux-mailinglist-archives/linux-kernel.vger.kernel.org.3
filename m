Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32EB462B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhK3EIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbhK3EIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:08:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81B0C061714;
        Mon, 29 Nov 2021 20:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A7EFB816D6;
        Tue, 30 Nov 2021 04:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBA5C53FCB;
        Tue, 30 Nov 2021 04:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638245122;
        bh=M0sQRTxbyS0q3abkpmgvNfkIhDxP38RRMZpip4Rf994=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9gV/YgK6uofnNU7EwGYWKR0A7JaSfTqv062khzJ44S5rbCDQXzm5ZAwoXIDlDLSD
         RzDuNN4UKB2cWFwsNtlYUVsMDAe3cjwMRszHLS1+mkJt/kA+E7EimokcfItSGTopxF
         ACsMkA1BWWj3QnUR0vJM1aKNnvVXGm2cyCbD9v5Gpn2MGz1QgbLCCfd+QcOBp+Mfc1
         kxoz/VX0wCc3Af/IOM59nycq197z0sWKUUjOgN6jPM7oO7/EpuN9ALuEW2bK8gsmG9
         n2BKhoPOvjMitx532ps3aY6BQqvzrEtjzYP7HNOWmQEDRbIkkX/WPNpAwKjlL+JBqc
         ZQjRhRFe/TJpw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/3] block: don't delete queue kobject before its children
Date:   Mon, 29 Nov 2021 20:03:05 -0800
Message-Id: <20211130040306.148925-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211130040306.148925-1-ebiggers@kernel.org>
References: <20211130040306.148925-1-ebiggers@kernel.org>
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
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 91d3805a6ec6b..1368dfe3ee500 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -951,15 +951,17 @@ void blk_unregister_queue(struct gendisk *disk)
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

