Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D883E597C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243169AbiHRDqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbiHRDqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:46:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9069411D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:46:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso613549pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NxxucBO4QrVt96mM1hHKarI4sR940EM9ZXnYf+M0A98=;
        b=HkNkehnITQZloctQe8RnTDYTs+3zO+4QF0s1Eydaku5Nepp0g0LKBTkoR78aENSZzh
         STuAAKgf3EJYuv4q63nmg3ezGlCTptrHUwWrT3S+66oxcjDPSrW5GMQjml/YIM/hmSln
         mM8o3CEEy114kR9m003e/ZdL5VvDKSe94wjKKgwmgJ0lY+Ex2yLJrZ2BOzGgL2Lg6FfN
         S9kk6D2rHxZ+WHSFQ9Fb9ZYoZTnOHOGF+uBasXTjkC4fVHtzykVemDyREAqOvsJBqlud
         AtrZO7BArjObwaZLHQ0ETGfaq2Y8GTDQTZKzoPDBKsTj5acrx51dqlfSiuwZaW8OY99W
         B+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NxxucBO4QrVt96mM1hHKarI4sR940EM9ZXnYf+M0A98=;
        b=BZDM7NxoHZeqnC/4wibuE6Qqc3bsIEog3wKEe02pF0Jhs0TLe73g+LnguOmA8MNSbD
         AnmyVLtWHd5jMlGffg7/hqlzOPmwOEsJOp/r9Z1JLm79cgYDEh530ugLPY+Yk6c6R2Cq
         aYYqb5IN29xI34+Kj3LViLpgcgR5jeW8ei4LbYCpLnK8LGMWdjGAVuNFy5CGISKaJgGx
         zh85Kl14vA8W9pnZ12ACUGchYdVPvS3RiRxRYCMYj/WJD6ID0//DZbSZvLvDOQSzuIpI
         ZxGaxriJpavwUeJYZe3MbkFsTcqkUwJUEBIL5WqLdNH9r+6qf/guRChApOjLgXZE8QpJ
         +coQ==
X-Gm-Message-State: ACgBeo1rnFVaHvTBNic3+JSN/y14BNSeDHZvWnSrg/Ho8m/UbDZ9lWbq
        TBY3i70VdDGtzNvKZoYaySKwog==
X-Google-Smtp-Source: AA6agR7x7lXSj5gijX30ittT8hKx+Po6pLby8DjpClfykm5ZCN5EUCgbfiBMYeQ2o/iZvlB59ImmbQ==
X-Received: by 2002:a17:902:b207:b0:16f:2349:6116 with SMTP id t7-20020a170902b20700b0016f23496116mr934512plr.80.1660794373030;
        Wed, 17 Aug 2022 20:46:13 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:46:12 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 8/9] sched/fair: defer task sched_avg attach to enqueue_entity()
Date:   Thu, 18 Aug 2022 11:43:42 +0800
Message-Id: <20220818034343.87625-9-zhouchengming@bytedance.com>
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

When wake_up_new_task(), we would use post_init_entity_util_avg()
to init util_avg/runnable_avg based on cpu's util_avg at that time,
then attach task sched_avg to cfs_rq.

Since enqueue_entity() would always attach any unattached task entity,
so we can defer this work to enqueue_entity().

post_init_entity_util_avg(p)
  attach_entity_cfs_rq()  --> (1)
activate_task(rq, p)
  enqueue_task() := enqueue_task_fair()
  enqueue_entity()
    update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
      if (!se->avg.last_update_time && (flags & DO_ATTACH))
        attach_entity_load_avg()  --> (2)

This patch defer attach from (1) to (2)

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e0d34ecdabae..aacf38a72714 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -799,8 +799,6 @@ void init_entity_runnable_average(struct sched_entity *se)
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
 
-static void attach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
@@ -863,8 +861,6 @@ void post_init_entity_util_avg(struct task_struct *p)
 		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 		return;
 	}
-
-	attach_entity_cfs_rq(se);
 }
 
 #else /* !CONFIG_SMP */
-- 
2.37.2

