Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2264D4D1080
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245260AbiCHGwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiCHGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:52:39 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E5D3B56E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:51:43 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q11so16201627pln.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 22:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Py+/2I82hZgEAkzSNSpXO9rRa8ve5Nzd4Q+/tF/AJDI=;
        b=quQDtSanY/xkOr+rnfdJl2C5tTWTwrM6rsprMT0fGu9LlRlc6WsGTRUP0ERsDmqVKD
         GROfQ5PjhPkqn4/ZVJRltl9qXS1Jzvtsfx/yp+pmGqEm4klJ62xWpGjx6fbWD9p/FgIA
         VhBpUf/zvKw4dZLUQsx8i4pl33PetEj2Ri5fYI24zErTAsDfPnjDSPd3KmPsmEPfPi0/
         I7sfPOJ1wAcZQZY2FxW5NSxbB0R5CaZMv36mEjEKmyGcPUWzm57g5Q1reBlHIjX6hgN2
         qZrRfwWkq5FoH5nvcCFJm6aFy5+V3fAGoX5QyGhVvt0RaZ9K7Wku19xNrqD0UMWr0LcI
         JZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Py+/2I82hZgEAkzSNSpXO9rRa8ve5Nzd4Q+/tF/AJDI=;
        b=1sFU301ySfVmV7Hg2NRZiEy3Jsle9iEszn4SSQbWgiVKDySMaCyvaa9LWEw7MDb9Gm
         O+n8nbc38ejI5eJFxFZVAe+w9bv+1qRpP19bgOsT/hjIVJaULtqHycQvgpzF3rYo0TF1
         +txLlLVwYqpUMyTeq617a62n6W0Vr7NeKJU0QEHaeylduOTxdi2V4Dhdl/tu2rw2Jja/
         r7V/uEguDca+CjiGWPbQPvFk4XmfxJKGD8M53vikUDi3VK8Z8ypQC4RPJ+P8f57kMtQY
         1TAQDRoOeSEesmn8i1mUwSSxhlU8aPv19rErOauLWOSYSXxJ/qJk2tjCigso4o3mxWvh
         KPYg==
X-Gm-Message-State: AOAM533OWwHpIiqBEe4sG9u5C18RmdJB9iv1DSeTuETf4kA1t0Axyr1W
        SKo7TW3eANsTPv/fZME4EBQ=
X-Google-Smtp-Source: ABdhPJyhEGWdmRLKPGqjmx0lekjgL8qJXKCrWTJXz665516vdJmldwaZzzkoA0MKTG3fGG1VMdeehw==
X-Received: by 2002:a17:902:e54a:b0:151:d21c:7e8e with SMTP id n10-20020a170902e54a00b00151d21c7e8emr14515066plf.1.1646722303076;
        Mon, 07 Mar 2022 22:51:43 -0800 (PST)
Received: from mi.xiaomi.com ([43.224.245.250])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm17166446pfl.24.2022.03.07.22.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:51:42 -0800 (PST)
From:   Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Jian Wen <wenjian1@xiaomi.com>
Subject: [PATCH 1/2] sched: explicitly distinguish between TASK_INTERRUPTIBLE and TASK_UNINTERRUPTIBLE
Date:   Tue,  8 Mar 2022 14:51:09 +0800
Message-Id: <20220308065110.636947-2-wenjian1@xiaomi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308065110.636947-1-wenjian1@xiaomi.com>
References: <20220308065110.636947-1-wenjian1@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is impossible to be a task of two different states, which are
TASK_UNINTERRUPTIBLE and TASK_INTERRUPTIBLE, at the same time.

This patch makes the next one easier to review.

Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
---
 kernel/sched/deadline.c | 3 +--
 kernel/sched/fair.c     | 2 +-
 kernel/sched/rt.c       | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b0ef01..e6fe3b46432a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1543,8 +1543,7 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 		if (state & TASK_INTERRUPTIBLE)
 			__schedstat_set(p->stats.sleep_start,
 					rq_clock(rq_of_dl_rq(dl_rq)));
-
-		if (state & TASK_UNINTERRUPTIBLE)
+		else if (state & TASK_UNINTERRUPTIBLE)
 			__schedstat_set(p->stats.block_start,
 					rq_clock(rq_of_dl_rq(dl_rq)));
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..fcfb22c835e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -989,7 +989,7 @@ update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
 		if (state & TASK_INTERRUPTIBLE)
 			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
-		if (state & TASK_UNINTERRUPTIBLE)
+		else if (state & TASK_UNINTERRUPTIBLE)
 			__schedstat_set(tsk->stats.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fbbb404..5c4160f8cb23 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1387,8 +1387,7 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 		if (state & TASK_INTERRUPTIBLE)
 			__schedstat_set(p->stats.sleep_start,
 					rq_clock(rq_of_rt_rq(rt_rq)));
-
-		if (state & TASK_UNINTERRUPTIBLE)
+		else if (state & TASK_UNINTERRUPTIBLE)
 			__schedstat_set(p->stats.block_start,
 					rq_clock(rq_of_rt_rq(rt_rq)));
 	}
-- 
2.25.1

