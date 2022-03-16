Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6324DA936
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 05:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353506AbiCPEPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 00:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbiCPEPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 00:15:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A158396B1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:14:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f8so2237378pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzuWL6o0DF3V9st4MUXpcR2KC82QXxZwMyLTf+Y/vP8=;
        b=TtT4yaa2JYA+5X6SVpMCnKL7vaOub1+iFmV4t4Xm6gWENvYixJauFiUtgEsN1EHwDZ
         8m5wHzLfUWpicyo6jHx9Dz8jzEEj8dmVZVe4tBnvgwLeBCZJFmVWw8wroY4CopW+fPM7
         qziSdRnESmjamEWIo3EcDgE2pmO+UfFARduxG5ifA/KgEe9KaJYbeeNhUaUnKYhzk2wf
         E8zsp2sSbHc9xh0NAgwUneqH6brR39/833Xn+QlmgqQ+r39oI6Amc7+dXdqRHApaWk7j
         DeX0i5T+pcBF9wv1Iv2UDT5xaAmW0yvecVQFakAU9bGOCZze0ygEwmlbP/7+i/9CS3D7
         Qg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzuWL6o0DF3V9st4MUXpcR2KC82QXxZwMyLTf+Y/vP8=;
        b=iIC6LdPA+tL+v4ddWNcxoLCqrvcqzmJDehU8ofr50q2VNDrK2fPXCLVP6/DkoD51cB
         m46fxz/rTJctAwZC5F3laCnK9TNUQzCTWS311MfX9IKvLRo4a2xUtEnRYdgW0SrIgb5X
         Q5xZgKwEdlRlzMkpPMi8tEVQbq09LXLe2qEfpX2ITNjF9mrDtLl1FVDeLUPt2+vUkaA4
         pbOIlfDVrIknnV7G7VksVHQdeYEx1F4RmXgtvdxaW+zv5xXoebyoelrGbk3qcY9GUevN
         yjSErz81Dm4tRt1g9NQ63VgTPzL5+31jK6ouVQpZp6oR3GJOyyfEG8Mt02FfBdLqZpBz
         gFKA==
X-Gm-Message-State: AOAM531JDUWrLQ5+KInwdGEz0pTl11R3CTZVLoSyMaQi0wxmauTGAEQd
        xbdT8ICXkQA7gzi36la2dpuwHwQYi0s=
X-Google-Smtp-Source: ABdhPJySC//1oZybPrimb/CkkLprQEOaM4wYq3HIKqZow2rXa2QJbyEn2RZjEZPGaH/HKCYKNM1ERQ==
X-Received: by 2002:a63:c50:0:b0:381:5118:62d6 with SMTP id 16-20020a630c50000000b00381511862d6mr7572791pgm.420.1647404061376;
        Tue, 15 Mar 2022 21:14:21 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:39e:7334:dc1e:1a0a])
        by smtp.gmail.com with ESMTPSA id f31-20020a631f1f000000b003742e45f7d7sm784668pgf.32.2022.03.15.21.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 21:14:21 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: introduce gc_urgent_mid mode
Date:   Tue, 15 Mar 2022 21:14:14 -0700
Message-Id: <20220316041414.1738616-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We need a mid level of gc urgent mode to do GC forcibly in a period
of given gc_urgent_sleep_time, but not like using greedy GC approach
and switching to SSR mode such as gc urgent high mode. This can be
used for more aggressive periodic storage clean up.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 17 +++++++++++------
 fs/f2fs/debug.c                         |  4 +++-
 fs/f2fs/f2fs.h                          |  4 ++++
 fs/f2fs/gc.c                            |  3 +++
 fs/f2fs/sysfs.c                         |  7 +++++++
 5 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 5a5f3c5445f6..9b583dd0298b 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -297,11 +297,16 @@ Description:	Shows current reserved blocks in system, it may be temporarily
 What:		/sys/fs/f2fs/<disk>/gc_urgent
 Date:		August 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:	Do background GC aggressively when set. When gc_urgent = 1,
-		background thread starts to do GC by given gc_urgent_sleep_time
-		interval. When gc_urgent = 2, F2FS will lower the bar of
-		checking idle in order to process outstanding discard commands
-		and GC a little bit aggressively. It is set to 0 by default.
+Description:	Do background GC aggressively when set. Set to 0 by default.
+		gc urgent high(1): does GC forcibly in a period of given
+		gc_urgent_sleep_time and ignores I/O idling check. uses greedy
+		GC approach and turns SSR mode on.
+		gc urgent low(2): lowers the bar of checking I/O idling in
+		order to process outstanding discard commands and GC a
+		little bit aggressively. uses cost benefit GC approach.
+		gc urgent mid(3): does GC forcibly in a period of given
+		gc_urgent_sleep_time and executes a mid level of I/O idling check.
+		uses cost benefit GC approach.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent_sleep_time
 Date:		August 2017
@@ -532,7 +537,7 @@ Date:		July 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Show how many segments have been reclaimed by GC during a specific
 		GC mode (0: GC normal, 1: GC idle CB, 2: GC idle greedy,
-		3: GC idle AT, 4: GC urgent high, 5: GC urgent low)
+		3: GC idle AT, 4: GC urgent high, 5: GC urgent low 6: GC urgent mid)
 		You can re-initialize this value to "0".
 
 What:		/sys/fs/f2fs/<disk>/gc_segment_mode
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 6d26872c7364..fcdf253cd211 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -476,12 +476,14 @@ static int stat_show(struct seq_file *s, void *v)
 				si->node_segs, si->bg_node_segs);
 		seq_printf(s, "  - Reclaimed segs : Normal (%d), Idle CB (%d), "
 				"Idle Greedy (%d), Idle AT (%d), "
-				"Urgent High (%d), Urgent Low (%d)\n",
+				"Urgent High (%d), Urgent Mid (%d), "
+				"Urgent Low (%d)\n",
 				si->sbi->gc_reclaimed_segs[GC_NORMAL],
 				si->sbi->gc_reclaimed_segs[GC_IDLE_CB],
 				si->sbi->gc_reclaimed_segs[GC_IDLE_GREEDY],
 				si->sbi->gc_reclaimed_segs[GC_IDLE_AT],
 				si->sbi->gc_reclaimed_segs[GC_URGENT_HIGH],
+				si->sbi->gc_reclaimed_segs[GC_URGENT_MID],
 				si->sbi->gc_reclaimed_segs[GC_URGENT_LOW]);
 		seq_printf(s, "Try to move %d blocks (BG: %d)\n", si->tot_blks,
 				si->bg_data_blks + si->bg_node_blks);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index da729f53daa8..3016b6354a68 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1313,6 +1313,7 @@ enum {
 	GC_IDLE_AT,
 	GC_URGENT_HIGH,
 	GC_URGENT_LOW,
+	GC_URGENT_MID,
 	MAX_GC_MODE,
 };
 
@@ -2784,6 +2785,9 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 	if (is_inflight_io(sbi, type))
 		return false;
 
+	if (sbi->gc_mode == GC_URGENT_MID)
+		return true;
+
 	if (sbi->gc_mode == GC_URGENT_LOW &&
 			(type == DISCARD_TIME || type == GC_TIME))
 		return true;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2d53ef121e76..ea5b93b689cd 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -103,7 +103,10 @@ static int gc_thread_func(void *data)
 				sbi->gc_urgent_high_remaining--;
 			}
 			spin_unlock(&sbi->gc_urgent_high_lock);
+		}
 
+		if (sbi->gc_mode == GC_URGENT_HIGH ||
+				sbi->gc_mode == GC_URGENT_MID) {
 			wait_ms = gc_th->urgent_sleep_time;
 			f2fs_down_write(&sbi->gc_lock);
 			goto do_gc;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 47efcf233afd..fe29bcb70f46 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -468,6 +468,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			}
 		} else if (t == 2) {
 			sbi->gc_mode = GC_URGENT_LOW;
+		} else if (t == 3) {
+			sbi->gc_mode = GC_URGENT_MID;
+			if (sbi->gc_thread) {
+				sbi->gc_thread->gc_wake = 1;
+				wake_up_interruptible_all(
+					&sbi->gc_thread->gc_wait_queue_head);
+			}
 		} else {
 			return -EINVAL;
 		}
-- 
2.35.1.723.g4982287a31-goog

