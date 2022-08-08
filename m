Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4258C8E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbiHHM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbiHHM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D2FD0A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z187so7994497pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0S4/uQg7L4l7ka3/Aeqj7n7hkrnKAJNq6+H/S+7bfUs=;
        b=TtKbF2yVWmPUjJZAKRkNmDD2Rx3GAjkV5oDtXp/5pqozM7Yt4zKH1NdY8OUn+ytGAG
         Zf5n2QIsAlBGD762sAXWh+BwQ26kuv41OF6+//UrSZNKBjpkhQfQPJmTIRkaLyowiNMv
         laT+ky+EunvlCBfcrkMd5J05galqhlY9S7FL5IMFj8gL8VkrMTC3xfgBVxwyIrdIFQfy
         oR7xBXokgV2/CHcm3mUJCgtfLSSN6vtg7CA7K0WMyqMj/ugv8/G3lnZzNiZLBXbdPLFB
         SItmorAtTPJHTp6vEBs95yK+TDAwctBYomAMDNXXHPvkGRixIQpa557BSf71vZueAalQ
         NmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0S4/uQg7L4l7ka3/Aeqj7n7hkrnKAJNq6+H/S+7bfUs=;
        b=o4I65brbenL2MJIDb0Fs3mJenA4pfiCIYobWlDeJHYt7jQLZ3NllCagXWgJKJA/tZS
         zn4adMK15S/sMWkKMVrbkdfLvwr5jVO8fQ6l87UrHfiEi2raIxbTQAlTxoUBF8s8wknE
         FpFnN1BXzbQ4Z/gA5mzVcygFZvGK7Hca6d1aYf1NC0/PTuA5Nu5nYO5kouHMqwXFmOEE
         p/o3hPDGC5nMf7ifUFujACS3X/iB7aFNqTp1erkwi6Y3T1iFLzkP9qtmN+gOI8lr0V8i
         rbPuStwVRr2Z1ZbqWmrkM+YqHL11Wt1yZOs+/WZ5v0wswBLYqIamtz9/jbVdtsARXx3u
         GAGQ==
X-Gm-Message-State: ACgBeo3o0H4W3egqet8/6lPOMSMpPbTpmjSNy2K3qtkOFL+urV94vWL9
        +gImgC2d/K5f20R497X3YoAQug==
X-Google-Smtp-Source: AA6agR5XJ94BdTwgi+yCsDLTSQQxveikvUrql5X8ZTtWNAoRismFWu9BP/Ixul6SqvEMtWOsjoI21g==
X-Received: by 2002:a65:5683:0:b0:41c:b103:6037 with SMTP id v3-20020a655683000000b0041cb1036037mr15169870pgs.367.1659963517359;
        Mon, 08 Aug 2022 05:58:37 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:36 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 8/9] sched/fair: defer task sched_avg attach to enqueue_entity()
Date:   Mon,  8 Aug 2022 20:57:44 +0800
Message-Id: <20220808125745.22566-9-zhouchengming@bytedance.com>
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
index 90aba33a3780..2063e30b2a8f 100644
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
2.36.1

