Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18CB586213
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 02:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiHAAm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 20:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHAAmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 20:42:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAD611178
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 17:42:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x23so430862pll.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 17:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RbadYO9E/asHxUYJikjza7R0dOsDISfb5MjlorKw2oc=;
        b=H1ZiojRFbDNAVIzmBrO4nbe2XA9r3pCBrYFADRVvas4QcDgtYUzHjB3jdKa/Lple6Q
         rPjIspdvep0qyE+55lRFf9yUKKSDaLvgNZ8cAtUHQ5bUIIfh5cYKRrpCQhUDv4UISRRI
         HQhdiiShg7vCw2v08MfWD+uq4QhLi3TgwhREB8zIT5kkDCo5TuPtdOSfMDQrJtJUm+M7
         Yjh3f4dT29uttttcUUxKbaqm49vns3oOB9LvyhoS1wXNLnzt2QJ0jepq3Hc0nAAovglT
         DexYCT3BcuRKRIfqXqO2/fJy05fr6Z4udGb+bMBgM+4+r0x77HuTu3sYhoyCN2zKrzIM
         7CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RbadYO9E/asHxUYJikjza7R0dOsDISfb5MjlorKw2oc=;
        b=lE744u5xT6L7JQ4njPMVTgrIe5Z0yfCM+mKnyZw7wxl69z9pi4+ydl/cXQSSpDLTcn
         bdruRs2vHX2IHjtrTg2a6hnPaZHfaEAOP7Pjwc6BcyIaNyRcUfVeBe9XLWxLc1X1CYwn
         eJpxsCuFAWod0Wc5rxSuLAywO3I/DP/PRPYklEYm4fboQq9LKjcRbO11TwBMzpSnQwPk
         sxZH9i+5F8T9ILUqsxwwjn7IZj0R9EManrpyLvUWm1ECsZAZKOpQfMGD0Sak8al3Si9I
         fJ2P1wO6BF+B2khVjWnThMI58wDt6U65VbPVgqJ1h/FrVzYeBVaZcFydSv19me7/5Qz1
         bfoA==
X-Gm-Message-State: ACgBeo2FLMjCg0PRnneTCIUSkJIaB3H42kO3j6tUZMUkimi660srODsP
        n2Fs1e/zNsS9cJ7LwI8+aI4=
X-Google-Smtp-Source: AA6agR5MVhPWpD890K6kq56we5BsMb7LTXXDUY9lUvPd73p1N6Ho7hg1gLBHnjfeUmWt+KP9VACGZg==
X-Received: by 2002:a17:90a:530d:b0:1f4:d38a:503d with SMTP id x13-20020a17090a530d00b001f4d38a503dmr9840456pjh.180.1659314537279;
        Sun, 31 Jul 2022 17:42:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q6-20020a656846000000b0041c04286010sm1255471pgt.83.2022.07.31.17.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 17:42:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org,
        axboe@kernel.dk, vdavydov.dev@gmail.com
Cc:     ran.xiaokai@zte.com.cn, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgel <cgel@zte.com.cn>
Subject: [RFC PATCH 2/2] psi: account for memory stall types
Date:   Mon,  1 Aug 2022 00:42:05 +0000
Message-Id: <20220801004205.1593100-2-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801004205.1593100-1-ran.xiaokai@zte.com.cn>
References: <20220801004205.1593100-1-ran.xiaokai@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cgel <cgel@zte.com.cn>

As psi can tell the reason of the memstall, add a
second argumnet of psi_memstall_enter() to identify
the reason of the memstall.

Signed-off-by: cgel <cgel@zte.com.cn>
---
 block/blk-cgroup.c        | 4 ++--
 block/blk-core.c          | 4 ++--
 include/linux/psi_types.h | 6 +++---
 mm/compaction.c           | 4 ++--
 mm/filemap.c              | 4 ++--
 mm/memcontrol.c           | 4 ++--
 mm/page_alloc.c           | 8 ++++----
 mm/vmscan.c               | 8 ++++----
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3d34ac0..857898f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1732,7 +1732,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	delay_nsec = min_t(u64, delay_nsec, 250 * NSEC_PER_MSEC);
 
 	if (use_memdelay)
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, TSK_MEMSTALL_WORKINGSET);
 
 	exp = ktime_add_ns(now, delay_nsec);
 	tok = io_schedule_prepare();
@@ -1744,7 +1744,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	io_schedule_finish(tok);
 
 	if (use_memdelay)
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, TSK_MEMSTALL_WORKINGSET);
 }
 
 /**
diff --git a/block/blk-core.c b/block/blk-core.c
index d221322..ebbbe49 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1185,12 +1185,12 @@ blk_qc_t submit_bio(struct bio *bio)
 	 * submission can be a significant part of overall IO time.
 	 */
 	if (workingset_read)
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, TSK_MEMSTALL_WORKINGSET);
 
 	ret = generic_make_request(bio);
 
 	if (workingset_read)
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, TSK_MEMSTALL_WORKINGSET);
 
 	return ret;
 }
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 194ea78..8200623 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -174,9 +174,9 @@ struct psi_group {
 	u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES - 1];
 	unsigned long avg[NR_PSI_STATES - 1][3];
 
-	u64 total_mems[PSI_MEM_STATES - 1];
-	unsigned long avg_mems[PSI_MEM_STATES - 1][3];
-	u64 avg_total_mems[PSI_MEM_STATES - 1];
+	u64 total_mems[PSI_MEM_STATES];
+	unsigned long avg_mems[PSI_MEM_STATES][3];
+	u64 avg_total_mems[PSI_MEM_STATES];
 
 	/* Monitor work control */
 	atomic_t poll_scheduled;
diff --git a/mm/compaction.c b/mm/compaction.c
index 903aea9..62d1416 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2664,9 +2664,9 @@ static int kcompactd(void *p)
 		wait_event_freezable(pgdat->kcompactd_wait,
 				kcompactd_work_requested(pgdat));
 
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, TSK_MEMSTALL_KCOMPACTED);
 		kcompactd_do_work(pgdat);
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, TSK_MEMSTALL_KCOMPACTED);
 	}
 
 	return 0;
diff --git a/mm/filemap.c b/mm/filemap.c
index 3d43769..cf08388 100755
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1151,7 +1151,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 			delayacct_thrashing_start();
 			delayacct = true;
 		}
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, TSK_MEMSTALL_WORKINGSET);
 		thrashing = true;
 	}
 
@@ -1210,7 +1210,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	if (thrashing) {
 		if (delayacct)
 			delayacct_thrashing_end();
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, TSK_MEMSTALL_WORKINGSET);
 	}
 
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 94e9a1c..fab06b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2589,9 +2589,9 @@ void mem_cgroup_handle_over_high(void)
 	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
 	 * need to account for any ill-begotten jiffies to pay them off later.
 	 */
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_MEMSTALL_CGROUP);
 	schedule_timeout_killable(penalty_jiffies);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_MEMSTALL_CGROUP);
 
 out:
 	css_put(&memcg->css);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef077b8..52d86c2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3988,7 +3988,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	if (!order)
 		return NULL;
 
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_MEMSTALL_DCOMPACT);
 	delayacct_compact_start();
 	noreclaim_flag = memalloc_noreclaim_save();
 
@@ -3996,7 +3996,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 								prio, &page);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_MEMSTALL_DCOMPACT);
 	delayacct_compact_end();
 
 	/*
@@ -4212,7 +4212,7 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 
 	/* We now go into synchronous reclaim */
 	cpuset_memory_pressure_bump();
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_MEMSTALL_DRECLAIM);
 	fs_reclaim_acquire(gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
 
@@ -4221,7 +4221,7 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(gfp_mask);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_MEMSTALL_DRECLAIM);
 
 	cond_resched();
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 075da44..c2038b4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3416,13 +3416,13 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 
 	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
 
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_MEMSTALL_CGROUP);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_MEMSTALL_CGROUP);
 
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 	set_task_reclaim_state(current, NULL);
@@ -3794,7 +3794,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_MEMSTALL_KSWAPD);
 	__fs_reclaim_acquire();
 
 	count_vm_event(PAGEOUTRUN);
@@ -3973,7 +3973,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 
 	snapshot_refaults(NULL, pgdat);
 	__fs_reclaim_release();
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_MEMSTALL_KSWAPD);
 	set_task_reclaim_state(current, NULL);
 
 	/*
-- 
2.15.2


