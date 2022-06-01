Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75009539BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349529AbiFAD4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiFADzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:55:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64469CEC
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:55:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v15so700232pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9NBwI67BFRKSTeZG8G8b9I8aUw9IU7Kg6B3/Dpj227U=;
        b=sv3zlHJNusW9hIHm4OlSXz2OQvWqQVBRGFJmPu9aSyzXunTIdQ98/BgzaW48Fn0X56
         63hnOnG/eWD7QLPqBMYRavpnBxunopd2HwB9hCvkdUCxwU3R5tfqSymSyvoSCt5VSRKK
         /xKy95Ty8QUyczUoVDEba9YazQCiKR1025QWMQMfx+tLjaX+zAkhp5sf8jkMKLfpD2qD
         NEQTfh2jR0LAmbb4Nd37P29YJCZZ3pJMIZU1DIA74LwuhYT/jsDHUSy7jdDhgH/mIGmw
         dPuFqwalnI9xER5UleZrkj058Eky2YrX+YRYPdS0I5e2a9uUdkhcAxLSe48oInrazPx/
         zKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9NBwI67BFRKSTeZG8G8b9I8aUw9IU7Kg6B3/Dpj227U=;
        b=iVWDRkQpqtol5tun1ogBF0gVgdP9bZfHxorN4YgKRJLxttEzvDcOM5aySh2ulc7U0/
         LSKw7GYyl7AQX1ebR69o2RgIunJ9WSYEMHtW4rACoTY9VqWvC3XbkhiRZrFArqqRnPZ0
         VQ3lBE9rn21RtJDr+mAuk6qSgSftIlEwBeSXj2BkAd0mB+xDHH1znM2Ekhu3oVdjoC4N
         6zN8G37+1YuoJddyVkcFNuz2WvBuw8YEC/hDpCNJaYGMY4buBbvlTjqc//9UEI75CB2t
         scjyPOdV07nGNW6Vxzno3BG2GlyN6hb8eEjm3kzt84XPgsYi4trxwAA8ga+1ZuJ4IV/s
         zh5w==
X-Gm-Message-State: AOAM533Y1Hk8iZzELfg56Qo9hjmaUx3Ajxh1SBXV4O83gVe8Y+rQMNJr
        rc4UbrF4ueiys7dg9qHFw4u2fQ==
X-Google-Smtp-Source: ABdhPJxsY7rjudE0hhFWO2IJgmHuEF6Za41NLn2pGNQQzXWSoD9hO9FklQZTyrq57aTvN3NBtMUnDA==
X-Received: by 2002:a05:6a00:1305:b0:512:eb1e:7921 with SMTP id j5-20020a056a00130500b00512eb1e7921mr64935654pfu.13.1654055753883;
        Tue, 31 May 2022 20:55:53 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79049000000b0051829b1595dsm230669pfo.130.2022.05.31.20.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 20:55:53 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/fair: update comments in enqueue/dequeue_entity()
Date:   Wed,  1 Jun 2022 11:55:45 +0800
Message-Id: <20220601035545.82187-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3371fa40548..e0cd4052e32f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4348,7 +4348,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Add its load to cfs_rq->runnable_avg
+	 *   - For group_entity, update its runnable_weight to reflect the new
+	 *     h_nr_running of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -4433,7 +4434,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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

