Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A74D9193
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbiCOAbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiCOAbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:31:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA825F79;
        Mon, 14 Mar 2022 17:30:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f8so16873255pfj.5;
        Mon, 14 Mar 2022 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FQ+NL1NN1x8pYLTJ+g3gU9ANpdXUS10s75AnCPDljs4=;
        b=b7rg5nnl1ZxAATjJ11QcboLu/pwe2mq/n7Uqk6P7gqqcTRZ1OH8lEbsZhV8n/I/Jsm
         Z/gWWt5o2LobP5+MPZU7oLLDBLPYZk9KOY20dItbg8u7CK/0smQ7G5PGLNcLP1I7aebA
         ts6AhkcMfX81AEBDV4cbgQ/KlsEEI7hoP6jhNs3VHJIuErI+wxNFdWr79KoSQ6XCYRdS
         TiFrd8Rrcr6PrRPliVFvvcnV2EsXqJoLRc7yS3pzfNGEFzoRJSZ8S3vja85uUZD2kDys
         j0ASK8s6J1jP93DYwXtPEUrOOBmJQLJFYOw0Iinw3bPoVElE+54vi7erPHefuaAYewO+
         bg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FQ+NL1NN1x8pYLTJ+g3gU9ANpdXUS10s75AnCPDljs4=;
        b=Q0PX/v/vu75KZTzrItRd3KK9vxissAr8g4sVbKQqREl9iIVlGD/5v4GmB8LsVjNQpG
         W/u2UHLKsar5Fc2XaVa0Pl4H/2PrOjrSxlwUxVhKLsWBuIADYVBVakgRhKz5G//H7QL9
         209tUWjOwLUYqNkMbc14pDK3fb0P8EF2BCC18PDpjcxHEwteQNtlj3KREpidsn8Pvkx6
         6LUu8JzQwOBwF8pfePW+ujMi0MHRvAn5iIpnuOOg6MgEbuS21JvHjar8y0E3fy5h0prQ
         pRqU8I18k+0PPvlyOtb76RDlnZsGDOA25qrOS06Kfo1MQUbrirS2pki0T0DPwxuxgSbe
         Dq/Q==
X-Gm-Message-State: AOAM533MvRrTnM8WnGcAIlDXlAr3Z6ac3J5yDzQWXWO+oX5Jd+zK9yFw
        u9yrSmWh35AXmixxmw1t1wE=
X-Google-Smtp-Source: ABdhPJwCfhELIM3jz3VRuEk47PsaRwT0E56T2oGNhQAu9nzHa86botOmhV120/HahGAB3gvOg25C1A==
X-Received: by 2002:a63:4e52:0:b0:380:7c35:fc9a with SMTP id o18-20020a634e52000000b003807c35fc9amr21731686pgl.376.1647304213596;
        Mon, 14 Mar 2022 17:30:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7972e000000b004f7b8b43d96sm7602198pfg.51.2022.03.14.17.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:30:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Mar 2022 14:30:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 for-5.18/block] block: don't merge across cgroup
 boundaries if blkcg is enabled
Message-ID: <Yi/eE/6zFNyWJ+qd@slm.duckdns.org>
References: <Yi71WZ3O9/YViHSb@slm.duckdns.org>
 <Yi/Us896/ftt5l4f@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi/Us896/ftt5l4f@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk-iocost and iolatency are cgroup aware rq-qos policies but they didn't
disable merges across different cgroups. This obviously can lead to
accounting and control errors but more importantly to priority inversions -
e.g. an IO which belongs to a higher priority cgroup or IO class may end up
getting throttled incorrectly because it gets merged to an IO issued from a
low priority cgroup.

Fix it by adding blk_cgroup_mergeable() which is called from merge paths and
rejects cross-cgroup and cross-issue_as_root merges.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Cc: stable@vger.kernel.org # v4.19+
Cc: Josef Bacik <jbacik@fb.com>
---
v2 was tagged for-5.18/block but was still based on block-for-5.17. Refresh
on top of for-5.18/block. My apologies about all the messiness.

v3: Actually rebased on top of block/for-5.18.

v2: Dropped conditional enabling. Always disallow cross-blkcg merges for
    simpilcity. While this may spuriously prevent some merges for cases
    where blkcg is enabled but no control is applied, that is a small cross
    section.

 block/blk-cgroup.h | 17 +++++++++++++++++
 block/blk-merge.c  | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 3e91803c4a555..47e1e38390c96 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -15,6 +15,7 @@
  */
 
 #include <linux/blk-cgroup.h>
+#include <linux/blk-mq.h>
 
 /* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
 #define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
@@ -428,6 +429,21 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
 }
 
+/**
+ * blk_cgroup_mergeable - Determine whether to allow or disallow merges
+ * @rq: request to merge into
+ * @bio: bio to merge
+ *
+ * @bio and @rq should belong to the same cgroup and their issue_as_root should
+ * match. The latter is necessary as we don't want to throttle e.g. a metadata
+ * update because it happens to be next to a regular IO.
+ */
+static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio)
+{
+	return rq->bio->bi_blkg == bio->bi_blkg &&
+		bio_issue_as_root_blkg(rq->bio) == bio_issue_as_root_blkg(bio);
+}
+
 void blk_cgroup_bio_start(struct bio *bio);
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 #else	/* CONFIG_BLK_CGROUP */
@@ -467,6 +483,7 @@ static inline void blkg_put(struct blkcg_gq *blkg) { }
 static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline void blk_cgroup_bio_start(struct bio *bio) { }
+static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { return true; }
 
 #define blk_queue_for_each_rl(rl, q)	\
 	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8d8177f71ebdb..ea6968313b4a8 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -9,6 +9,7 @@
 #include <linux/blk-integrity.h>
 #include <linux/scatterlist.h>
 #include <linux/part_stat.h>
+#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 
@@ -598,6 +599,9 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 		unsigned int nr_phys_segs)
 {
+	if (!blk_cgroup_mergeable(req, bio))
+		goto no_merge;
+
 	if (blk_integrity_merge_bio(req->q, req, bio) == false)
 		goto no_merge;
 
@@ -694,6 +698,9 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	if (total_phys_segments > blk_rq_get_max_segments(req))
 		return 0;
 
+	if (!blk_cgroup_mergeable(req, next->bio))
+		return 0;
+
 	if (blk_integrity_merge_rq(q, req, next) == false)
 		return 0;
 
@@ -902,6 +909,10 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (bio_data_dir(bio) != rq_data_dir(rq))
 		return false;
 
+	/* don't merge across cgroup boundaries */
+	if (!blk_cgroup_mergeable(rq, bio))
+		return false;
+
 	/* only merge integrity protected bio into ditto rq */
 	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
 		return false;
-- 
2.35.1

