Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A6B58C720
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbiHHLEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbiHHLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:04:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB05140ED
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:04:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u133so7769691pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hPrlmdp1+V2T+kE3vc+RCj17IKZw6QBjGZGzgKFOvkI=;
        b=Kb18Kkz/FcTk+kpvnWEWXxWKUiHWjU/a38UAe0J9oi34EDsm6Co1bo3Zqvx9ylNFpi
         zSy8zc6Gy9HN623y5k2Zm0+SIs424CxyWxlwpiF+qPhBebYmNbPMIF9wfMaUreHm0fRd
         hwQq0i47LAlZqSdcPgzP6BRJBE1EM8QefCU2z9kmajjawcOBYhzyEljrQ7va+ajt1x79
         uvBKqQg31+mXaZ5PEP4feNkSwcXNpug/23Q8jXHuVOOcGsxoeJAe8uIfSZY3Ou/FKr4H
         Mgd+HJ2nZsK1RIFHmMGpbh1bK90rLlVNnZShq/GMo8EzgL7CzOCJy7/vE7xoD586s+0f
         XMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPrlmdp1+V2T+kE3vc+RCj17IKZw6QBjGZGzgKFOvkI=;
        b=me6+WyVeQmmDBGP4CmBKHcAXQ5oJPCn9+mRxatcvdOdiQcxrWogEb4xz67BKYQWIk3
         XnVfT/nsEKd3GVwLnb+36fpGJgd1Yo3/QLAvqnSzLKhEmJ2rudukj6mNy2Nl36ITwNCh
         8m7WstXismsTfmQpSwvzvqwsjb0gYDy2BLdNyVZJrf1ST4OwcgrE92CLMYbby+MNOAKW
         Q2bAuFNJvrnUyyhqFkqFrRMyhW5C16Bw+cHIoZrGEia3U4r894vsmFvHo9z6z2A/eWzs
         JGN/XKV8S546yKHR9zjGI+s4RwKIti7aw8Izzukxn0tmBlfhXG+Sbjf688K/czkfe+77
         fFiA==
X-Gm-Message-State: ACgBeo1GAFZMX5n2UctM1eFPN3KIR0cUOORiefIFc0ZXPrbevbywQw68
        YsImQegOFcOTZLyuXkb0qlQlOw==
X-Google-Smtp-Source: AA6agR4pOivxoStasMf24iM7IcGaku9J/jzQvjDl167AhLiVLSfuj4vW2FifEAlTjhzroMzfcG5ilA==
X-Received: by 2002:a63:8548:0:b0:41b:f048:1761 with SMTP id u69-20020a638548000000b0041bf0481761mr15269871pgd.10.1659956677049;
        Mon, 08 Aug 2022 04:04:37 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:04:36 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 02/10] sched/psi: optimize task switch inside shared cgroups again
Date:   Mon,  8 Aug 2022 19:03:33 +0800
Message-Id: <20220808110341.15799-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808110341.15799-1-zhouchengming@bytedance.com>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
defer prev task sleep handling to psi_task_switch(), so we don't need
to clear and set TSK_ONCPU state for common cgroups.

    A
    |
    B
   / \
  C   D
 /     \
prev   next

After that commit psi_task_switch() do:
1. psi_group_change(next, .set=TSK_ONCPU) for D
2. psi_group_change(prev, .clear=TSK_ONCPU | TSK_RUNNING) for C
3. psi_group_change(prev, .clear=TSK_RUNNING) for B, A

But there is a limitation "prev->psi_flags == next->psi_flags" that
if not satisfied, will make this cgroups optimization unusable for both
sleep switch or running switch cases. For example:

prev->in_memstall != next->in_memstall when sleep switch:
1. psi_group_change(next, .set=TSK_ONCPU) for D, B, A
2. psi_group_change(prev, .clear=TSK_ONCPU | TSK_RUNNING) for C, B, A

prev->in_memstall != next->in_memstall when running switch:
1. psi_group_change(next, .set=TSK_ONCPU) for D, B, A
2. psi_group_change(prev, .clear=TSK_ONCPU) for C, B, A

The reason why this limitation exist is that we consider a group is
PSI_MEM_FULL if the CPU is actively reclaiming and nothing productive
could run even if it were runnable. So when CPU curr changed from prev
to next and their in_memstall status is different, we have to change
PSI_MEM_FULL status for their common cgroups.

This patch remove this limitation by making psi_group_change() change
PSI_MEM_FULL status depend on CPU curr->in_memstall status.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/psi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 115a7e52fa23..9e8c5d9e585c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -823,8 +823,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
-		bool identical_state;
-
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
 		 * When switching between tasks that have an identical
@@ -832,11 +830,9 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * we reach the first common ancestor. Iterate @next's
 		 * ancestors only until we encounter @prev's ONCPU.
 		 */
-		identical_state = prev->psi_flags == next->psi_flags;
 		iter = NULL;
 		while ((group = iterate_groups(next, &iter))) {
-			if (identical_state &&
-			    per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
 				common = group;
 				break;
 			}
@@ -883,7 +879,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
 		 * with dequeuing too, finish that for the rest of the hierarchy.
 		 */
-		if (sleep) {
+		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
 				psi_group_change(group, cpu, clear, set, now, wake_clock);
-- 
2.36.1

