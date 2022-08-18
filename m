Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8946A59836F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbiHRMtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244767AbiHRMsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270263A5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jl18so1429903plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fvKl2tnBqJmMcygYqKFkoFiYDs76K09gFVhZ/gWKaSc=;
        b=SN7hdB2jRksAJdHKQk9m76QrqW85j5Zfy+IP91zY/d3LxmxTB/B5zKFrnfJE3YlG2z
         VthStM5pIbohT20e7wIEJSBNJmXCV+QDuIJOKXiofI153SavMfFJpRSG/iH8VUF97khP
         Uoy317w1ouezpE+M/IwZKsU2pmgp3xHnzLNhaHF8z9WFn5RupF2ZV9+RLPntStl8qDK5
         JDDLFlsjswTBfKDIQMl9VyfTwh+plUlDv5zL8/SNvg5QSUuYl/KbppdXn+AHXQ26DT6a
         xDkLHTZjOKu2rBU38GW8cOX8Bv+NTOVOEbpFjwqbJQcA2zf+jHgarDRxxzD+Mx3roe7g
         ppbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fvKl2tnBqJmMcygYqKFkoFiYDs76K09gFVhZ/gWKaSc=;
        b=eMNw1OZPXYjih/VN/QPNNaUcLxcloE0huwIlDZmsNm4LegrPBwVZ6k/v8GyQkF5oV7
         uelc+/WF4DZ4iAG8C1kT0hEJ/VQFOwgOheEkKFACwkY/Mm0VZ8ghYBkAsM8LeBduJS6+
         jSv4EjpLVbjVsK49hLQaW9yuPnRrXZ6+lKT1JNqaf6WArTE96V4BmzzXSNo5u0ro9Jqq
         XnV1Z9XC2W/3tSnu5hYfR3DkBmdBZMUDRccEYDKVmOclaoch4IrrO32JNXOSLSu8GqUr
         88fiSw+5PK5q+RvJsMVISvtO+jqUnkx+HnBN8ilQAk9aZTmuGkomYIxpB08D+6zDM0IE
         QFYQ==
X-Gm-Message-State: ACgBeo0T5EkF7rt+3a6HMSmUvZroL/qvp+6D+2vJ8kbgabHE9jp8Vw+i
        /r5di/rJCPE9Oha86o0jIZx/PA==
X-Google-Smtp-Source: AA6agR5cWfPOi74lPtdmDsTJhWqZmGFZdT1YSfdSzldLnO1fTVOfUBnxuAAE6gCGV/mpNZBdKYN8qg==
X-Received: by 2002:a17:902:db12:b0:16e:e5fc:56db with SMTP id m18-20020a170902db1200b0016ee5fc56dbmr2544387plx.46.1660826932803;
        Thu, 18 Aug 2022 05:48:52 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:52 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 8/9] sched/fair: move task sched_avg attach to enqueue_task_fair()
Date:   Thu, 18 Aug 2022 20:48:04 +0800
Message-Id: <20220818124805.601-9-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818124805.601-1-zhouchengming@bytedance.com>
References: <20220818124805.601-1-zhouchengming@bytedance.com>
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

When wake_up_new_task(), we use post_init_entity_util_avg() to init
util_avg/runnable_avg based on cpu's util_avg at that time, and
attach task sched_avg to cfs_rq.

Since enqueue_task_fair() -> enqueue_entity() -> update_load_avg()
loop will do attach, we can move this work to update_load_avg().

wake_up_new_task(p)
  post_init_entity_util_avg(p)
    attach_entity_cfs_rq()  --> (1)
  activate_task(rq, p)
    enqueue_task() := enqueue_task_fair()
      enqueue_entity() loop
        update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
          if (!se->avg.last_update_time && (flags & DO_ATTACH))
            attach_entity_load_avg()  --> (2)

This patch move attach from (1) to (2), update related comments too.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c319b0bd2bc1..93d7c7b110dd 100644
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
@@ -4002,8 +3998,7 @@ static void migrate_se_pelt_lag(struct sched_entity *se) {}
  * @cfs_rq: cfs_rq to update
  *
  * The cfs_rq avg is the direct sum of all its entities (blocked and runnable)
- * avg. The immediate corollary is that all (fair) tasks must be attached, see
- * post_init_entity_util_avg().
+ * avg. The immediate corollary is that all (fair) tasks must be attached.
  *
  * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
  *
@@ -4236,8 +4231,8 @@ static void remove_entity_load_avg(struct sched_entity *se)
 
 	/*
 	 * tasks cannot exit without having gone through wake_up_new_task() ->
-	 * post_init_entity_util_avg() which will have added things to the
-	 * cfs_rq, so we can remove unconditionally.
+	 * enqueue_task_fair() which will have added things to the cfs_rq,
+	 * so we can remove unconditionally.
 	 */
 
 	sync_entity_load_avg(se);
-- 
2.37.2

