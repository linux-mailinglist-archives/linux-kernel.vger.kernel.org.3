Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7954445C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiFIG57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiFIG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 02:57:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570BE3D5DC5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 23:57:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x4so11741700pfj.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 23:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRNAmesR4+cTMptpbFNt+YaOGIoBBkd+PqfC3OZCCpU=;
        b=QLbGeqACvU0hy777goUhmL/8yrdTakysYibKRHkrJyIj4ZKfytYZRaAtq08gfS3NNN
         k4goriQscga1jlctxQ92rAJ8tY1qo/DIqKDikW2fROcsOO5VFXznEDAEz6jUdcP6Di1X
         ZWY+c7odsM0zEE4RCVvqE5ToTOVBxkiHITzDpDVB0NQPxgAUsWXjxtfYFHXBBR65uKSw
         PiT0g74qzxPIncKZVY9dOALv2fKE1XYarzupF7RHh/nihqWer+ItFf5FTMvGKiXcPe6G
         GsVTYB5p+QHuFwJNQHBuJf6GDQg3hisirVGtXtRxu8uOaEZAxh3eXA1giFwjwNF43j+6
         vMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRNAmesR4+cTMptpbFNt+YaOGIoBBkd+PqfC3OZCCpU=;
        b=u5Ytuwl4p/dTzBdYkf6JaOY0Xpt+MlNCPQyaBRWV4Yx8svRuUxDMjVAxlaztGqVnrr
         AMvQH/o2krOcHHnjuAzXW4cgaypkL9ygwP/misKqV8kmRUSfQGkBkUZaOQEfpaX0Nyqv
         sNNHVKAZwtOEi1zhgv6HHv9VoO6WiLFfQDAJGQ8RUE1sSi5c4uqpQIwhGN/MoDIWwC26
         7b7p/C3VxBDj49204cgc/NY2gUQJeIQ0EuUr46HI2ONPoTPlNH5cBN2bW+7bjlrIfCL4
         oX0573JobUTzcA2l/EB178mjIii6gkfopdxl5zb4mCtc2sa+9M5l7T23jtahCMXd/pAO
         bjCw==
X-Gm-Message-State: AOAM531ud46n6NHA4lJuqludym3ElHTtEkccStshGk+cnGOds5HM/Wt0
        uctShQ85svJXSRDb7ydIYm8=
X-Google-Smtp-Source: ABdhPJyZaEc4X21fbccLe82ROFpJVy5MUSdqI6KSHnvcmLi3Icumv+8uqk+wgDmctPbpEd82JXj2uw==
X-Received: by 2002:a63:1f17:0:b0:3fb:afd3:985d with SMTP id f23-20020a631f17000000b003fbafd3985dmr33544908pgf.396.1654757874624;
        Wed, 08 Jun 2022 23:57:54 -0700 (PDT)
Received: from longfanaikebuke.Dlink (36-236-186-165.dynamic-ip.hinet.net. [36.236.186.165])
        by smtp.gmail.com with ESMTPSA id l63-20020a632542000000b003fc4001fd5fsm16297349pgl.10.2022.06.08.23.57.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 23:57:53 -0700 (PDT)
From:   Steven Lung <1030steven@gmail.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, 1030steven@gmail.com
Subject: [PATCH] sched/fair: Make 'enqueue' spelling consistent
Date:   Thu,  9 Jun 2022 14:57:17 +0800
Message-Id: <20220609065717.81547-1-1030steven@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this file, there are two types of spelling for the word 'enqueue'
in present continuous: 'enqueueing' and 'enqueuing'. 'Enqueuing' is
used more than the other, so I replaced all the 'enqueueing' to
'enqueuing' for making the spelling in this file consistent.

Signed-off-by: Steven Lung <1030steven@gmail.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9..37317710d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1000,7 +1000,7 @@ update_stats_enqueue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
 		return;
 
 	/*
-	 * Are we enqueueing a waiting task? (for current tasks
+	 * Are we enqueuing a waiting task? (for current tasks
 	 * a dequeue/enqueue event is a NOP)
 	 */
 	if (se != cfs_rq->curr)
@@ -1018,7 +1018,7 @@ update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
 		return;
 
 	/*
-	 * Mark the end of the wait period if dequeueing a
+	 * Mark the end of the wait period if dequeuing a
 	 * waiting task:
 	 */
 	if (se != cfs_rq->curr)
@@ -3920,7 +3920,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 * !last_update_time means we've passed through
 		 * migrate_task_rq_fair() indicating we migrated.
 		 *
-		 * IOW we're enqueueing a task on a new CPU.
+		 * IOW we're enqueuing a task on a new CPU.
 		 */
 		attach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
-- 
2.35.1

