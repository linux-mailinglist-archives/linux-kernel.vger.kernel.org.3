Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17248A395
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbiAJXZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:25:13 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:17684 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242568AbiAJXZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:25:10 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4JXqg83mb5zTV;
        Tue, 11 Jan 2022 00:25:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1641857108; bh=MB6GYqMnIJqaSehj5vsXun7wNlpiLvI9viu/bUczrIk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=b40T9LXyVE3lzFcQ/CfAQ9+fbYIYU7KL2fYOmtbj8UAdZ+61jpnsGtMGV2yJDjNwQ
         vOMMp7UKrhqE+HoB4cVykuqthxCQZj2ujnvyyQpATyucdHVR9123MBSuqPmjwZvAyc
         zayQ+Wx8OjUSWIgU1iyvUU17VqhDEnywigMP12kfkVHi7MBu2CQUEIypG/aWkVYe5O
         9g7tIPwWzt1SOI+5VMcvdGqpvjqIviS0yjcI+UqIfzaVC9HySWvZcDUrwHPaBCy3hy
         7rfhHvzY3dVotIRNhz7COYDPYELB1KjbSH6IzEdiM6SrgcYEAo5TgKikLj7p9GItBt
         6t69HtOSSu9JQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.4 at mail
Date:   Tue, 11 Jan 2022 00:25:08 +0100
Message-Id: <21a208d4b72f04a75cc5f4a81e3402dd13fadad7.1641857023.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <87ddcac4c4e017a42e20dbbfcb8343468a0efc12.1641857023.git.mirq-linux@rere.qmqm.pl>
References: <87ddcac4c4e017a42e20dbbfcb8343468a0efc12.1641857023.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] dm integrity: mark workqueues with device they belong to
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device name to workqueue names to help debugging CPU usage per
device mapper target.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/md/dm-integrity.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 6dc9aebf8487..cd60488938ea 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3958,6 +3958,7 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
  */
 static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 {
+	const char *devname = dm_table_device_name(ti->table);
 	struct dm_integrity_c *ic;
 	char dummy;
 	int r;
@@ -4200,8 +4201,8 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		goto bad;
 	}
 
-	ic->metadata_wq = alloc_workqueue("dm-integrity-metadata",
-					  WQ_MEM_RECLAIM, METADATA_WORKQUEUE_MAX_ACTIVE);
+	ic->metadata_wq = alloc_workqueue("dm-integrity-metadata/%s", WQ_MEM_RECLAIM,
+					  METADATA_WORKQUEUE_MAX_ACTIVE, devname);
 	if (!ic->metadata_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
@@ -4212,22 +4213,22 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	 * If this workqueue were percpu, it would cause bio reordering
 	 * and reduced performance.
 	 */
-	ic->wait_wq = alloc_ordered_workqueue("dm-integrity-wait", WQ_MEM_RECLAIM);
+	ic->wait_wq = alloc_ordered_workqueue("dm-integrity-wait/%s", WQ_MEM_RECLAIM, devname);
 	if (!ic->wait_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
 		goto bad;
 	}
 
-	ic->offload_wq = alloc_workqueue("dm-integrity-offload", WQ_MEM_RECLAIM,
-					  METADATA_WORKQUEUE_MAX_ACTIVE);
+	ic->offload_wq = alloc_workqueue("dm-integrity-offload/%s", WQ_MEM_RECLAIM,
+					  METADATA_WORKQUEUE_MAX_ACTIVE, devname);
 	if (!ic->offload_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
 		goto bad;
 	}
 
-	ic->commit_wq = alloc_workqueue("dm-integrity-commit", WQ_MEM_RECLAIM, 1);
+	ic->commit_wq = alloc_workqueue("dm-integrity-commit/%s", WQ_MEM_RECLAIM, 1, devname);
 	if (!ic->commit_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
@@ -4236,7 +4237,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	INIT_WORK(&ic->commit_work, integrity_commit);
 
 	if (ic->mode == 'J' || ic->mode == 'B') {
-		ic->writer_wq = alloc_workqueue("dm-integrity-writer", WQ_MEM_RECLAIM, 1);
+		ic->writer_wq = alloc_workqueue("dm-integrity-writer/%s", WQ_MEM_RECLAIM, 1, devname);
 		if (!ic->writer_wq) {
 			ti->error = "Cannot allocate workqueue";
 			r = -ENOMEM;
@@ -4395,7 +4396,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 
 	if (ic->internal_hash) {
-		ic->recalc_wq = alloc_workqueue("dm-integrity-recalc", WQ_MEM_RECLAIM, 1);
+		ic->recalc_wq = alloc_workqueue("dm-integrity-recalc/%s", WQ_MEM_RECLAIM, 1, devname);
 		if (!ic->recalc_wq ) {
 			ti->error = "Cannot allocate workqueue";
 			r = -ENOMEM;
-- 
2.30.2

