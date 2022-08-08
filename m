Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDDC58C8D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbiHHM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243035AbiHHM61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AE0BC3F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id u133so8008076pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXG6GzAhlyf+jWwAIQ3mUoNzaPNS4py+noaXNcGTmPE=;
        b=mzJ7sHm0h18OCrfewJPIf0UuhQN3ziHZndPoqwqGGmG5APGXHS+mCQBrCozvZH38NB
         10x5tL/dh+TOG9zQ2Wj4hBqub+jjokNSWV3zpVLIIAPoVT+X73xZGznzuC8ipq44g2cU
         uKDrVYFX0qnUTEPdZwI4ovN7F30jpF1H3EepDD/LAEy3lj3rTlTgZKAqHB6IwMVxzJEC
         sRqm7WjKj2+Rf75EXrT8XET2s0Y3Cpjy93MRmPsUEX4aJGKQQ+VIm0oet9iWJHG8vlKO
         WoEcg86+Pymx9iB4hPmZT+6G6kVWHkjhTWBIOHQ8jgBMIZUVi2igF/WCjD5r8mR+Ul8K
         tOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXG6GzAhlyf+jWwAIQ3mUoNzaPNS4py+noaXNcGTmPE=;
        b=OmnPYU/5Y1Vrco0eVIG6VFcHF7UeSaPaXp9vhNBqtLsdToPotetJ8MU/Nx4/ixwhye
         1Wf/j2DfYcIZhouImudJfSBhaI3soq95KhXFjWgL9ylF89kI4gz7Nk7t8zT+eM9wxkWH
         M97Kwf33kcoh1wYytAlAkgNgw0lf4OpPqmtukTto9r7lhIkrvKPPcW0Zmi4YOt4acXPR
         kPD8/PkAP+s1cZLKlwiw4QwnvH/ufudYO3T9Ra383WqaGuU6UjIfXiMOajPl8es3cDU6
         M1zKvXo8WuhYlrT6zZo/T/p4drHeLiC5ictW7DwlAKJx3XfpDPbBEpEErKV5qP3Qz/kH
         6aBw==
X-Gm-Message-State: ACgBeo3MTuRF+v2nHfVfoURzltTDJV5JXhv/6WrZl/FABM3IpZr3IrMt
        YN6KAqJTZf48UEaSGK3tvvpQ/w==
X-Google-Smtp-Source: AA6agR75kPDC8xQZY9sliJtcC4y7lU3vJnIyYQWg8muGIlmooHCMb7S/DEHLv6R3a2PiciTXrxH2XQ==
X-Received: by 2002:a05:6a00:1145:b0:52b:78c:fa26 with SMTP id b5-20020a056a00114500b0052b078cfa26mr18258641pfm.27.1659963498268;
        Mon, 08 Aug 2022 05:58:18 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:17 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 4/9] sched/fair: update comments in enqueue/dequeue_entity()
Date:   Mon,  8 Aug 2022 20:57:40 +0800
Message-Id: <20220808125745.22566-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808125745.22566-1-zhouchengming@bytedance.com>
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the sched_avg related code, I found the comments in
enqueue/dequeue_entity() are not updated with the current code.

We don't add/subtract entity's runnable_avg from cfs_rq->runnable_avg
during enqueue/dequeue_entity(), those are done only for attach/detach.

This patch updates the comments to reflect the current code working.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4c0929a6e71..52de8302b336 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4434,7 +4434,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Add its load to cfs_rq->runnable_avg
+	 *   - For group_entity, update its runnable_weight to reflect the new
+	 *     h_nr_running of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -4519,7 +4520,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Subtract its load from the cfs_rq->runnable_avg.
+	 *   - For group_entity, update its runnable_weight to reflect the new
+	 *     h_nr_running of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
-- 
2.36.1

