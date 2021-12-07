Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC646C4A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhLGUfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhLGUfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:35:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89837C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:31:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k26so437715pfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=luCWywBAHn4KEwu7iiwOCSMXii0Bh7YSDjhuOykugKw=;
        b=CvURTtI2uXrbQpKuCtkSBSvTlR/HvnYtp7VMF462MjuTgBrSQQRNAuooEcz6JxbAss
         rvUs7oST1Q3w9qVaVrwbyqLox5+Fl/Z25nbwVwz/gLLdn1JTgYyh48d+b+51UacSC4px
         8N9Vqd5JJ4ycimNnGT71EWf/+ClWb12GGserDGVxnehuz9d//Lfs2CbH1vJjNlothvLC
         UiYQ1qPRUVW//yqSa8X1z3SYuUs6P2PZ904I6941WkHOcARM8Y9Ezm2YEjkAZWvqV8DG
         uDaz7vyHF7SrX977dKYOmrYZVHJVd+tfUlqH2j6/T+uJWwlzFYIcaiztuAgp8CsEN6sP
         uIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=luCWywBAHn4KEwu7iiwOCSMXii0Bh7YSDjhuOykugKw=;
        b=yomZzaFcXNODQVYulmN/4VPtw8KaIR9zebqEwP7yJhPKjvWSxC//h+FUjyqHVaTk6j
         Hwl1nZ1QtAvVVwb55XykCwMU0nZj0Awo4OPcgs0D44Tf3+FnFkcvq2NsSkRktXp0Y6A/
         +p8xBf6cc3nVTwKQhcHW/KxKGFoacGejLVwOYy3fwWkjGVELFP2/KFHzwFnqIpYu2/ce
         fINwi5LgPTKclCH6nA50d16UDhPMKu4cvZOOixDnKryfWh9On0IF2fO2pQ838v/xJ7cI
         cma8LIJ6cZm53ZtypEJCw8wL6/rIJ3Qkon/a7UghaLK2JPsRSPdHh8I42sYrHWICAtYW
         0brQ==
X-Gm-Message-State: AOAM532rRPrtPVuGank4nj//JhZhbWKcpBqhlmLEefe8GrLNw3XZ+1nm
        tSlVwIwd9LIfmtZ500YpKQsFBCec3kA=
X-Google-Smtp-Source: ABdhPJxFhFc024NfnOU07kNguCdgE7a4kVv2gG0dcrUOmD2uNU41iEFXAWE+Jmstos87uxDVBzEc+A==
X-Received: by 2002:a62:1a03:0:b0:494:64b5:3e01 with SMTP id a3-20020a621a03000000b0049464b53e01mr1422017pfa.35.1638909099896;
        Tue, 07 Dec 2021 12:31:39 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:e554:7a45:5de:729a])
        by smtp.gmail.com with ESMTPSA id y6sm631072pfi.154.2021.12.07.12.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:31:39 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add gc_urgent_high_remaining sysfs node
Date:   Tue,  7 Dec 2021 12:31:36 -0800
Message-Id: <20211207203136.1498796-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new sysfs node called gc_urgent_high_remaining. The user can
set the trial count limit for GC urgent high mode with this value. If
GC thread gets to the limit, the mode will turn back to GC normal mode.
By default, the value is zero, which means there is no limit like before.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++++
 fs/f2fs/f2fs.h                          |  3 +++
 fs/f2fs/gc.c                            | 12 ++++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         | 14 ++++++++++++++
 5 files changed, 37 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9f3c355bb70e..2416b03ff283 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -533,3 +533,10 @@ Description:	With "mode=fragment:block" mount options, we can scatter block allo
 		f2fs will allocate 1..<max_fragment_chunk> blocks in a chunk and make a hole
 		in the length of 1..<max_fragment_hole> by turns. This value can be set
 		between 1..512 and the default value is 4.
+
+What:		/sys/fs/f2fs/<disk>/gc_urgent_high_remaining
+Date:		December 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	You can set the trial count limit for GC urgent high mode with this value.
+		If GC thread gets to the limit, the mode will turn back to GC normal mode.
+		By default, the value is zero, which means there is no limit like before.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cbc73bd71dad..5da592286721 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1683,6 +1683,9 @@ struct f2fs_sb_info {
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
 	unsigned int next_victim_seg[2];	/* next segment in victim section */
+	spinlock_t gc_urgent_high_lock;
+	bool gc_urgent_high_limited;		/* indicates having limited trial count */
+	unsigned int gc_urgent_high_remaining;	/* remaining trial count for GC_URGENT_HIGH */
 
 	/* for skip statistic */
 	unsigned int atomic_files;		/* # of opened atomic file */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a946ce0ead34..bd4fb896b644 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -92,6 +92,18 @@ static int gc_thread_func(void *data)
 		 * So, I'd like to wait some time to collect dirty segments.
 		 */
 		if (sbi->gc_mode == GC_URGENT_HIGH) {
+			spin_lock(&sbi->gc_urgent_high_lock);
+			if (sbi->gc_urgent_high_limited) {
+				if (!sbi->gc_urgent_high_remaining) {
+					sbi->gc_urgent_high_limited = false;
+					spin_unlock(&sbi->gc_urgent_high_lock);
+					sbi->gc_mode = GC_NORMAL;
+					continue;
+				}
+				sbi->gc_urgent_high_remaining--;
+			}
+			spin_unlock(&sbi->gc_urgent_high_lock);
+
 			wait_ms = gc_th->urgent_sleep_time;
 			down_write(&sbi->gc_lock);
 			goto do_gc;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 040b6d02e1d8..9acd76ea09ca 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3548,6 +3548,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->seq_file_ra_mul = MIN_RA_MUL;
 	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
 	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
+	spin_lock_init(&sbi->gc_urgent_high_lock);
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 47c950f65b6f..e2c58d80b20c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -487,6 +487,18 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
+		if (t < 0)
+			return -EINVAL;
+
+		spin_lock(&sbi->gc_urgent_high_lock);
+		sbi->gc_urgent_high_limited = t == 0 ? false : true;
+		sbi->gc_urgent_high_remaining = t;
+		spin_unlock(&sbi->gc_urgent_high_lock);
+
+		return count;
+	}
+
 #ifdef CONFIG_F2FS_IOSTAT
 	if (!strcmp(a->attr.name, "iostat_enable")) {
 		sbi->iostat_enable = !!t;
@@ -742,6 +754,7 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
 #endif
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_high_remaining, gc_urgent_high_remaining);
 F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
@@ -855,6 +868,7 @@ static struct attribute *f2fs_attrs[] = {
 #endif
 	ATTR_LIST(data_io_flag),
 	ATTR_LIST(node_io_flag),
+	ATTR_LIST(gc_urgent_high_remaining),
 	ATTR_LIST(ckpt_thread_ioprio),
 	ATTR_LIST(dirty_segments),
 	ATTR_LIST(free_segments),
-- 
2.34.1.400.ga245620fadb-goog

