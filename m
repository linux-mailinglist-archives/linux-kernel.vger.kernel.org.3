Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5541556A1F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiGGMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiGGMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:30:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B3D18B2C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:30:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 73so2815486pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WpJSj+10jDxel+mpKutSYvc+nWQYQ3afAUsJ/It2YN0=;
        b=nirKL1QWHP36hMwqbfs7j/3M3CnFOdyU/mhq6mjzaNOZVW8BJhiMuFxnDbifijLiv2
         EU6RLfK8UYogFyr6hO57mF6rQ2LcQPznrIJ+WoCCADtotE105rv5ly07PyR/sPehMWpn
         JiDpSPcxYzoGeevzVUxFzoBhc7Es+fnpAWlMTYQhM+9gVj2ErKPIhF7aTQZIvy3L1BkX
         prLdikSsA/noeiCaShNHE0E5dYn2Aa+xzRQPnAaN0n5WGo1ulKGTDVLAiB4vOb8YVk84
         VabbgRlpFN5/hLdDxGunqNQ/DbcICvb+B3MQa/M2pBn8ozzLx5u97X4erW4whBY3ZOlD
         UReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WpJSj+10jDxel+mpKutSYvc+nWQYQ3afAUsJ/It2YN0=;
        b=wWiUK5Igc4+RNWMrjP5GPYQvoRCm3qiFipqJDLFY6CaknZcyKEYNE9tX1lKXm3cw36
         3voutLS/VdlowFwcNmn8jkW5pxZ9oKxWUQwMtHg66cNVeF6neJhFFJ7R+eYXCjDZdDk2
         oBNhyUyCDUVSurJYH1WI2BfXfgpmVIxyq0m/QzBlIOjjzHp6otWyva/x3ugHla4Z8vee
         TZSwGojyAiR4fEXUx9CgCeiYQsKJLs+4rlqDXrqaesir9Mh2YB2Xiw85LbiE3NVvI58w
         q+fzh5R6PagCl2RHUd2RXe0r3/rHJnRFUarTraWug2u9U6j7UvxZhTwM1Z0c/k1EEukO
         bmkg==
X-Gm-Message-State: AJIora824mq2WaHokXumscvtTqhpSeBOp6x9aufgozARsxtMBY9D1heB
        EAGWpqJZZcGwfZ7AO7qnZDc=
X-Google-Smtp-Source: AGRyM1shHuIiMyP1DQPGo092XN38rExXflU8JvJ88A9rk6HCbBx7m2Zz0/KEEA62b1u3b9+vSTZwFQ==
X-Received: by 2002:a17:90b:48c7:b0:1ef:a692:9593 with SMTP id li7-20020a17090b48c700b001efa6929593mr5010948pjb.184.1657197045039;
        Thu, 07 Jul 2022 05:30:45 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id l18-20020a635b52000000b003fba1a97c49sm25884833pgm.61.2022.07.07.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:30:44 -0700 (PDT)
From:   Guowei Du <duguoweisz@gmail.com>
To:     richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        duguowei <duguowei@xiaomi.com>
Subject: [PATCH] ubifs: sequence each shrink task
Date:   Thu,  7 Jul 2022 20:30:33 +0800
Message-Id: <20220707123033.29042-1-duguoweisz@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: duguowei <duguowei@xiaomi.com>

Because of 'list_move_tail', if two or more tasks are shrinking, there
will be different results for them.

For example:
After the first round, if shrink_run_no of entry equals run_no of task,
task will break directly at the beginning of next round; if they are
not equal, task will continue to shrink until encounter one entry
which has the same number.

It is difficult to confirm the real results of all tasks, so add a lock
to only allow one task to shrink at the same time.

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/ubifs/shrinker.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/shrinker.c b/fs/ubifs/shrinker.c
index d00a6f20ac7b..900644ef432d 100644
--- a/fs/ubifs/shrinker.c
+++ b/fs/ubifs/shrinker.c
@@ -42,6 +42,9 @@ static unsigned int shrinker_run_no;
 /* Protects 'ubifs_infos' list */
 DEFINE_SPINLOCK(ubifs_infos_lock);
 
+/* Sequence each shrink task*/
+DEFINE_SPINLOCK(ubifs_shrink_lock);
+
 /* Global clean znode counter (for all mounted UBIFS instances) */
 atomic_long_t ubifs_clean_zn_cnt;
 
@@ -145,13 +148,12 @@ static int shrink_tnc_trees(int nr, int age, int *contention)
 {
 	struct ubifs_info *c;
 	struct list_head *p;
-	unsigned int run_no;
 	int freed = 0;
 
 	spin_lock(&ubifs_infos_lock);
-	do {
-		run_no = ++shrinker_run_no;
-	} while (run_no == 0);
+	shrinker_run_no++;
+	if (shrinker_run_no == 0)
+		shrinker_run_no = 1;
 	/* Iterate over all mounted UBIFS file-systems and try to shrink them */
 	p = ubifs_infos.next;
 	while (p != &ubifs_infos) {
@@ -160,7 +162,7 @@ static int shrink_tnc_trees(int nr, int age, int *contention)
 		 * We move the ones we do to the end of the list, so we stop
 		 * when we see one we have already done.
 		 */
-		if (c->shrinker_run_no == run_no)
+		if (c->shrinker_run_no == shrinker_run_no)
 			break;
 		if (!mutex_trylock(&c->umount_mutex)) {
 			/* Some un-mount is in progress, try next FS */
@@ -183,7 +185,7 @@ static int shrink_tnc_trees(int nr, int age, int *contention)
 		 * OK, now we have TNC locked, the file-system cannot go away -
 		 * it is safe to reap the cache.
 		 */
-		c->shrinker_run_no = run_no;
+		c->shrinker_run_no = shrinker_run_no;
 		freed += shrink_tnc(c, nr, age, contention);
 		mutex_unlock(&c->tnc_mutex);
 		spin_lock(&ubifs_infos_lock);
@@ -283,7 +285,9 @@ unsigned long ubifs_shrink_scan(struct shrinker *shrink,
 	int contention = 0;
 	unsigned long freed;
 	long clean_zn_cnt = atomic_long_read(&ubifs_clean_zn_cnt);
+	int ret = 0;
 
+	spin_lock(&ubifs_shrink_lock);
 	if (!clean_zn_cnt) {
 		/*
 		 * No clean znodes, nothing to reap. All we can do in this case
@@ -293,7 +297,9 @@ unsigned long ubifs_shrink_scan(struct shrinker *shrink,
 		 * later.
 		 */
 		dbg_tnc("no clean znodes, kick a thread");
-		return kick_a_thread();
+		ret = kick_a_thread();
+		spin_unlock(&ubifs_shrink_lock);
+		return ret;
 	}
 
 	freed = shrink_tnc_trees(nr, OLD_ZNODE_AGE, &contention);
@@ -310,10 +316,12 @@ unsigned long ubifs_shrink_scan(struct shrinker *shrink,
 
 	if (!freed && contention) {
 		dbg_tnc("freed nothing, but contention");
+		spin_unlock(&ubifs_shrink_lock);
 		return SHRINK_STOP;
 	}
 
 out:
 	dbg_tnc("%lu znodes were freed, requested %lu", freed, nr);
+	spin_unlock(&ubifs_shrink_lock);
 	return freed;
 }
-- 
2.36.1

