Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC4550B502
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446575AbiDVKax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446548AbiDVKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E5B54BFE;
        Fri, 22 Apr 2022 03:27:46 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPXaOQL3NXUYE9kl7HHkpeh0vpgKQ6N6nf97xgsUtBE=;
        b=3AP9zqoS627EzmgRmmNR714tVe3DxXhlvYS3oKwA+7D2BGzYZ9EMAPi+MCBneQ9gSqOh8g
        Mkzs741RpGgmweALftxiCjX/wonqGXV3SgsngN9kq63/bQzPcE+ZpPC2HVl5OhOi3netya
        ceP75c2/edm1Di/OZ5Av0JfigIbp3pB+CG3SzaIk2ML+v9nf4LAajpNK8HhJGyk3RhwoQ6
        OeCrcMs35HmPY/6CzdbT4J/j9sNVXphUCXQ7T2Fmrx2+pdG3sUrsGkHTWyfdL3VD60H1UT
        AOovbQMrPvmBYQ1bxJH1x3NQRvRPtmXLhbW+hDLzETYPpK5VHCgV2HM4y5MRoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPXaOQL3NXUYE9kl7HHkpeh0vpgKQ6N6nf97xgsUtBE=;
        b=DMg7OC8Et3qE8fS1HS1zsb2kizd9iwnDowxK3DpjnvH95VkStsuLaVoEiKXvof57AyRDIj
        iuz9kJrf9gXqe7DQ==
From:   "tip-bot2 for zgpeng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Move calculate of avg_load to a better location
Cc:     zgpeng <zgpeng@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Samuel Liao <samuelliao@tencent.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1649239025-10010-1-git-send-email-zgpeng@tencent.com>
References: <1649239025-10010-1-git-send-email-zgpeng@tencent.com>
MIME-Version: 1.0
Message-ID: <165062326374.4207.14680824957826150562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     06354900787f25bf5be3c07a68e3cdbc5bf0fa69
Gitweb:        https://git.kernel.org/tip/06354900787f25bf5be3c07a68e3cdbc5bf0fa69
Author:        zgpeng <zgpeng.linux@gmail.com>
AuthorDate:    Wed, 06 Apr 2022 17:57:05 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:14:07 +02:00

sched/fair: Move calculate of avg_load to a better location

In calculate_imbalance function, when the value of local->avg_load is
greater than or equal to busiest->avg_load, the calculated sds->avg_load is
not used. So this calculation can be placed in a more appropriate position.

Signed-off-by: zgpeng <zgpeng@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Samuel Liao <samuelliao@tencent.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/1649239025-10010-1-git-send-email-zgpeng@tencent.com
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299..601f8bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9460,8 +9460,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		local->avg_load = (local->group_load * SCHED_CAPACITY_SCALE) /
 				  local->group_capacity;
 
-		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
-				sds->total_capacity;
 		/*
 		 * If the local group is more loaded than the selected
 		 * busiest group don't try to pull any tasks.
@@ -9470,6 +9468,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			env->imbalance = 0;
 			return;
 		}
+
+		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
+				sds->total_capacity;
 	}
 
 	/*
