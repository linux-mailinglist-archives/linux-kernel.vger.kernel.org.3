Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A748A597C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiHRDqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243124AbiHRDqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:46:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E39568A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:46:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a22so442784pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FRKOdv3Syw9Tzig7kJCUcxunGx7WyPi3SKqsZ5Hh+4Q=;
        b=V87Pq/x7RLiRWbmQoXapUXLwX2aHbsl5PbZmlqq7R5HsQeaaYCkvUXR7oyFbYRy8Kt
         Z0e/ktl/zUA+3WmA3k25M0w00BMBPcRLC2V45bjZxY16cbstSYt7xfyLiiMvst40/p/Z
         sroebfYZxmqdOB/8pDDufM3okd6aFxL0gFvRR2H5dEOAURLBAadIPV+PntgkeLUNDTJ8
         NkkLKLjvmetKN6T9OczP9e4DncGGhLQGW/i32c9pHmRJNRaKHZY4KvayhJhkh3WxDerm
         hBx4t/g7NOFyYNC2SEtxD0aaW7Lp2TsqjvJLZROaKcmeuZ+xzNUq8+KJoaiQY+QoRtBO
         lFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FRKOdv3Syw9Tzig7kJCUcxunGx7WyPi3SKqsZ5Hh+4Q=;
        b=pzElRE5/Plh/EiOXP4rzuv6Wl9SjdU+Wo4dbXYsjdV85hO86je3ISImzo3skui7qWl
         52PWEpLl1/IYDzYFFKIC4OFkXaejaJJHa7lDhjSZclQB2tsJVOKmht3NGdxW1k/+DNmn
         FwRlNJ79mP268tcaqlNOh3lCRNjj17sQUm+M6VRwmcja4liGauG1JzxgV5KjtF7oxUgL
         8qxJEUU5tvPnQIBpi1g6N9lgk7NZdTq9/fbemwpX59Zud/FtSJFFsu9UXpqerc+baHv4
         tpsh1QIVUhBHcP2K7Zdivfg51J3eHv7UsayVuCwFkjkgBfTkESgaBAdl95t4xlsRL2f5
         FrNQ==
X-Gm-Message-State: ACgBeo1JFSHbc3fkXzL3HxBIDq2RHKC2A8MDxFVW1nmKfW1rTLKXWwPg
        cUyt9acWlNrHmr/4BU/l1LrEdA==
X-Google-Smtp-Source: AA6agR789RTZFWiTps6quGQP+dP1RBB+CEQ8OsIqCoTcDoX50n2+/ErOqb/pVZIk/1UMukCSjFA09w==
X-Received: by 2002:a63:d841:0:b0:427:e7f2:bef with SMTP id k1-20020a63d841000000b00427e7f20befmr1030819pgj.386.1660794364697;
        Wed, 17 Aug 2022 20:46:04 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:46:04 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 6/9] sched/fair: fix another detach on unattached task corner case
Date:   Thu, 18 Aug 2022 11:43:40 +0800
Message-Id: <20220818034343.87625-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818034343.87625-1-zhouchengming@bytedance.com>
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
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

commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
fixed two load tracking problems for new task, including detach on
unattached new task problem.

There still left another detach on unattached task problem for the task
which has been woken up by try_to_wake_up() and waiting for actually
being woken up by sched_ttwu_pending().

try_to_wake_up(p)
  cpu = select_task_rq(p)
  if (task_cpu(p) != cpu)
    set_task_cpu(p, cpu)
      migrate_task_rq_fair()
        remove_entity_load_avg()       --> unattached
        se->avg.last_update_time = 0;
      __set_task_cpu()
  ttwu_queue(p, cpu)
    ttwu_queue_wakelist()
      __ttwu_queue_wakelist()

task_change_group_fair()
  detach_task_cfs_rq()
    detach_entity_cfs_rq()
      detach_entity_load_avg()   --> detach on unattached task
  set_task_rq()
  attach_task_cfs_rq()
    attach_entity_cfs_rq()
      attach_entity_load_avg()

The reason of this problem is similar, we should check in detach_entity_cfs_rq()
that se->avg.last_update_time != 0, before do detach_entity_load_avg().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1eb3fb3d95c3..eba8a64f905a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11721,6 +11721,17 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+#ifdef CONFIG_SMP
+	/*
+	 * In case the task sched_avg hasn't been attached:
+	 * - A forked task which hasn't been woken up by wake_up_new_task().
+	 * - A task which has been woken up by try_to_wake_up() but is
+	 *   waiting for actually being woken up by sched_ttwu_pending().
+	 */
+	if (!se->avg.last_update_time)
+		return;
+#endif
+
 	/* Catch up with the cfs_rq and remove our load when we leave */
 	update_load_avg(cfs_rq, se, 0);
 	detach_entity_load_avg(cfs_rq, se);
-- 
2.37.2

