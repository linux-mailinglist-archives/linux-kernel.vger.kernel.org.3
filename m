Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEDC46DFA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhLIApa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhLIAp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:45:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DEC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 16:41:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so3167897pjr.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 16:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ijiKIHpqa1p+fmHpOYx6rJWPeD9sqjri033CKdnXxM=;
        b=TCtS+vWTx6xPRXjz/Gcu4cpBbSDmjIfwaby6QX/nq15ktT1xpufVi8oHKqiA8ojO0y
         ZEt2HKJgtHsF/t/nQowyHTX8UAuVoE+7vNUuMqyFLGX7rbCN/x/7Ug3aojI6nE68jGdm
         9eb+d7DLSJwzzj5jAlIQvwpPkuMMbV138+O9vB77j2Z9IgbbDjkTeOP/cwIxnY69Jkzx
         Ovr9NuMhJMiyNJamSFJyhTEictAL/1RNDGQTc1wt/LbHbuXEEMI1YoqkEMsUR2f8ra3N
         pmIU6Sah8B4nvM4PR6O1qBzTT7wihX48tzgdiYHJCTUYHUShRY3eFvlickIMu1/K2ulR
         IfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ijiKIHpqa1p+fmHpOYx6rJWPeD9sqjri033CKdnXxM=;
        b=zGAuUVa2yakhd2XYCNluPKbZ9/w82IzsSqIV+lk3jcPuFtg2jUo4kA1Md/XVcYiSEP
         JZF+51Knz/jN0/8AIb/WN56O3ulHaorqD7i7zIGQVoQFhzvc78+bFO+mSeQR9xAcR1Fb
         Aw8yIb5biRxpG9behitdqTueib/f62GjHbaUA7f7z5Q82GGmTfOrCP5t78OCOJ/veXES
         tmtwhhGtbs/HRGxd7CGrfv/yLPOCiRYrTIK5+QElEMQFw05VvhWEUMlKpmNSSJj3ygL6
         /IoF59uuSxoJ+qF/DcHkL0awK8HrNcQ8hNN+AtuVSJwTPRIpozWShEC2CsaZu4fiUOIO
         YAxQ==
X-Gm-Message-State: AOAM531tfqfxcDdbKjD2VcOXjPxHYNRS1166tZHz30ujgM4M/P3AeKCf
        P446fc4VjSWebDZHa0lILa5h5ZayFVM=
X-Google-Smtp-Source: ABdhPJyRjXuKt0oO2/yWkr7DRxIg1TxoC0ozYuonMePfdSIAWKIQdU74sar00TI4zN4AuTLe1smwaw==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr11465818pjb.232.1639010515785;
        Wed, 08 Dec 2021 16:41:55 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:1fe1:fbc:dcdf:dfd6])
        by smtp.gmail.com with ESMTPSA id kk7sm8375149pjb.19.2021.12.08.16.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 16:41:55 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: add gc_urgent_high_remaining sysfs node
Date:   Wed,  8 Dec 2021 16:41:51 -0800
Message-Id: <20211209004151.2469697-1-daeho43@gmail.com>
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
v2: remove untouched condition reported by kernel test robot
    <lkp@intel.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++++
 fs/f2fs/f2fs.h                          |  3 +++
 fs/f2fs/gc.c                            | 12 ++++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         | 11 +++++++++++
 5 files changed, 34 insertions(+)

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
index 47c950f65b6f..55a7df17d5f3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -487,6 +487,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
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
@@ -742,6 +751,7 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
 #endif
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_high_remaining, gc_urgent_high_remaining);
 F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
@@ -855,6 +865,7 @@ static struct attribute *f2fs_attrs[] = {
 #endif
 	ATTR_LIST(data_io_flag),
 	ATTR_LIST(node_io_flag),
+	ATTR_LIST(gc_urgent_high_remaining),
 	ATTR_LIST(ckpt_thread_ioprio),
 	ATTR_LIST(dirty_segments),
 	ATTR_LIST(free_segments),
-- 
2.34.1.400.ga245620fadb-goog

