Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76DF4D909F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbiCNXv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242380AbiCNXvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:51:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3093D4B6;
        Mon, 14 Mar 2022 16:50:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n15so14890093plh.2;
        Mon, 14 Mar 2022 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=crombYJ601nj4GxQ3xHQzPJ7z/NJBxb1JF3DLVedxQE=;
        b=PV86yuimVLMGWO4GZy8A3lRf0zzlYVBgCDkUkU9IUYM5QfryKwq4UCdRrtFEaVqISH
         9I5kibB8SWNxJ9vSOCuKZ8U4FbRk5R7ikbuwuZZnmqv7UEGHviwOceISO89X7Ocsck2t
         W+cTzHeKc9gmjVUZfSUc3VpahqL8xlbjgsZBb65aQzFyLrTm9nRuDG9loABgofUBUc8h
         MoeMCxKVGaEprwpJZhuu97itFlBWJevr0T0IS2jPBkFwgKORfeJ8SQ3A2egJ63WuR7iF
         1dw1aiI6ZKpVe5b9MIlzMyiEh14GngM5EDevcRYtMRXo9y2ZHvn1TIAhKygGUwBX5ID5
         UNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=crombYJ601nj4GxQ3xHQzPJ7z/NJBxb1JF3DLVedxQE=;
        b=lOmIa1q+eJ9slCyXCJ38sqGdklLOnmlyaYxjvT8xvMhA+XzotujVIWHB45dHwWiWi1
         svxDnYsXtT9BCG6XDbcDJSADCrrazyuzIz433W/xIBdTWcjn/+fKkZFhnqGDdTrbNIFi
         I8deXLF25FVSSEB//J0/D5xzyEmaxEpNEJBP16vWLZ+4kor/Q+b5C4J5gft+Kzu02Lh2
         L9DcfPIPpfzN7QcZeypvg/l7IbZvFI7IAgowsPtCfAW6CiLPK7tNyTsDmim2LTtg5Amg
         5kXtQAwd2gZSKM9enX+6mdSwyqSFmOtS4RcQZMlZ70H7Ihap8DndI6sqC0i9rqkEi0AA
         Gyuw==
X-Gm-Message-State: AOAM530xKtbqcuxltyzsIyKPOTdoCCbKlsQU0dNgcc4W6H2M7ldsj1dS
        Pd0ijSlsitaBBxe+v6YhdLAW8NRIxdjQBg==
X-Google-Smtp-Source: ABdhPJz8CtyLQa/FarrI6mUF15g4DixSywAqrmAqoHeTPpxrXz53i4TfA7EnTyJGb6eSMTkyrIKzxA==
X-Received: by 2002:a17:902:d883:b0:153:51d5:445d with SMTP id b3-20020a170902d88300b0015351d5445dmr10941887plz.30.1647301813067;
        Mon, 14 Mar 2022 16:50:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f4-20020aa782c4000000b004f6f0334a51sm20409824pfn.126.2022.03.14.16.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 16:50:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Mar 2022 13:50:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 for-5.18/block] block: don't merge across cgroup
 boundaries if blkcg is enabled
Message-ID: <Yi/Us896/ftt5l4f@slm.duckdns.org>
References: <Yi71WZ3O9/YViHSb@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi71WZ3O9/YViHSb@slm.duckdns.org>
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

v2: Dropped conditional enabling. Always disallow cross-blkcg merges for
    simpilcity. While this may spuriously prevent some merges for cases
    where blkcg is enabled but no control is applied, that is a small cross
    section.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Cc: stable@vger.kernel.org # v4.19+
Cc: Josef Bacik <jbacik@fb.com>
---
 block/blk-merge.c          |   11 +++++++++++
 include/linux/blk-cgroup.h |   17 +++++++++++++++++
 2 files changed, 28 insertions(+)

--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -9,6 +9,7 @@
 #include <linux/blk-integrity.h>
 #include <linux/scatterlist.h>
 #include <linux/part_stat.h>
+#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 
@@ -600,6 +601,9 @@ static inline unsigned int blk_rq_get_ma
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 		unsigned int nr_phys_segs)
 {
+	if (!blk_cgroup_mergeable(req, bio))
+		goto no_merge;
+
 	if (blk_integrity_merge_bio(req->q, req, bio) == false)
 		goto no_merge;
 
@@ -696,6 +700,9 @@ static int ll_merge_requests_fn(struct r
 	if (total_phys_segments > blk_rq_get_max_segments(req))
 		return 0;
 
+	if (!blk_cgroup_mergeable(req, next->bio))
+		return 0;
+
 	if (blk_integrity_merge_rq(q, req, next) == false)
 		return 0;
 
@@ -904,6 +911,10 @@ bool blk_rq_merge_ok(struct request *rq,
 	if (bio_data_dir(bio) != rq_data_dir(rq))
 		return false;
 
+	/* don't merge across cgroup boundaries */
+	if (!blk_cgroup_mergeable(rq, bio))
+		return false;
+
 	/* only merge integrity protected bio into ditto rq */
 	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
 		return false;
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/radix-tree.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/atomic.h>
 #include <linux/kthread.h>
 #include <linux/fs.h>
@@ -604,6 +605,21 @@ static inline void blkcg_clear_delay(str
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
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
@@ -659,6 +675,7 @@ static inline void blkg_put(struct blkcg
 static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline void blk_cgroup_bio_start(struct bio *bio) { }
+static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { return true; }
 
 #define blk_queue_for_each_rl(rl, q)	\
 	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
