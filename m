Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5049BCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiAYUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:23:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58722 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiAYUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:23:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D4CDB81A2A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD945C340E6;
        Tue, 25 Jan 2022 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643142180;
        bh=ofAycFRhfggnQ8vC0SVr08d1Hq7S/JeroNDpfQa4dno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spiTYMZrR/hipoHCjyv2pboNqs5CtD0mXMXOqfK3MmXpZnjViOMQOS24FZrnqeX7V
         ogLwF0EA7iwCASRL+TbsGBuHoCmN37Ba/qL0OqiraktZkNjieZpDgRgV5GArMP4mPW
         HOxep14tpwnwQw3eJgpQKaC/0mI3H4EfVLVSk/R6DtrXQvRZE9Ik6R+OQDuPlcc5n5
         OpAdy6jM5NER+P1gEUzLkCWTKPogx4AOM+f9yUkce9fiklNzaYDDIl78aUMf+5lzDD
         57CAgJow841eOGaoGs6SVXtVt4j9B0OE5Lmv7/LQhxYhd1ZMQwkpGgVngDy45Z09Ps
         KlZHVY3HcXHlQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Konstantin Vyshetsky <vkon@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: expose discard related parameters in sysfs
Date:   Tue, 25 Jan 2022 12:22:54 -0800
Message-Id: <20220125202254.3111474-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220125202254.3111474-1-jaegeuk@kernel.org>
References: <20220125202254.3111474-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Vyshetsky <vkon@google.com>

This patch exposes max_discard_request, min_discard_issue_time,
mid_discard_issue_time, and max_discard_issue_time in sysfs. This will
allow the user to fine tune discard operations.

Signed-off-by: Konstantin Vyshetsky <vkon@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 27 +++++++++++++++++++++++++
 fs/f2fs/sysfs.c                         |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 2416b03ff283..87d3884c90ea 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -98,6 +98,33 @@ Description:	Controls the issue rate of discard commands that consist of small
 		checkpoint is triggered, and issued during the checkpoint.
 		By default, it is disabled with 0.
 
+What:		/sys/fs/f2fs/<disk>/max_discard_request
+Date:		December 2021
+Contact:	"Konstantin Vyshetsky" <vkon@google.com>
+Description:	Controls the number of discards a thread will issue at a time.
+		Higher number will allow the discard thread to finish its work
+		faster, at the cost of higher latency for incomming I/O.
+
+What:		/sys/fs/f2fs/<disk>/min_discard_issue_time
+Date:		December 2021
+Contact:	"Konstantin Vyshetsky" <vkon@google.com>
+Description:	Controls the interval the discard thread will wait between
+		issuing discard requests when there are discards to be issued and
+		no I/O aware interruptions occur.
+
+What:		/sys/fs/f2fs/<disk>/mid_discard_issue_time
+Date:		December 2021
+Contact:	"Konstantin Vyshetsky" <vkon@google.com>
+Description:	Controls the interval the discard thread will wait between
+		issuing discard requests when there are discards to be issued and
+		an I/O aware interruption occurs.
+
+What:		/sys/fs/f2fs/<disk>/max_discard_issue_time
+Date:		December 2021
+Contact:	"Konstantin Vyshetsky" <vkon@google.com>
+Description:	Controls the interval the discard thread will wait when there are
+		no discard operations to be issued.
+
 What:		/sys/fs/f2fs/<disk>/discard_granularity
 Date:		July 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 2bccdaedfb00..281bc0133ee6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -716,6 +716,10 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle, gc_mode);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent, gc_mode);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_request, max_discard_request);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_issue_time);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
@@ -832,6 +836,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(reclaim_segments),
 	ATTR_LIST(main_blkaddr),
 	ATTR_LIST(max_small_discards),
+	ATTR_LIST(max_discard_request),
+	ATTR_LIST(min_discard_issue_time),
+	ATTR_LIST(mid_discard_issue_time),
+	ATTR_LIST(max_discard_issue_time),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(pending_discard),
 	ATTR_LIST(batched_trim_sections),
-- 
2.35.0.rc0.227.g00780c9af4-goog

