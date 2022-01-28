Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E049F47E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346917AbiA1HkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346905AbiA1HkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:40:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C925FC06173B;
        Thu, 27 Jan 2022 23:40:17 -0800 (PST)
Date:   Fri, 28 Jan 2022 07:40:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643355616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmXHQtEq7/SaHugAgbLiB97VMudxzhVvg+DXkGd+oqc=;
        b=BCPWTB7cCmW4S9AOZ7rUaDj5g3OuRcUWC6/6YeHlXj/aZQP7QgjkWagFyhc8nGXEhB+F2Q
        DtdNEEPjWV0l1S/aAfVWbRVbe90Fs0Z8MQ50+lbYU0f7424RhIMoB9ITiuiyOLoM4AAEWy
        Ca+j9fSlnC5l8PqvMzkckjkk74ZiLF32tQCZRRL0D3Xp1cH7pcCnWfiZn69F1M48HgGzPS
        mhxhAc8UKxln42yrMeSr2VAY/CzxkbFeVZGv3lTIFyVYjh+z0rBJwpz0bxcAZ9SaRDHycM
        brSHGzXuS9LKJdV0iZt4rMzDkgqwxLZeG5p+1+7v4do0qY8MoSZFLcKn0Db3bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643355616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmXHQtEq7/SaHugAgbLiB97VMudxzhVvg+DXkGd+oqc=;
        b=mTnYYexxJ4Mh6eDf6LGev5Hf+QwjHog+eoXO22ajuwuy5wI3K4m4Yh0HoaSCvBW0cZehbw
        Pk9rCmGHyK87ZHBA==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix iowait boost escaping uclamp restriction
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211216225320.2957053-3-qais.yousef@arm.com>
References: <20211216225320.2957053-3-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <164335561519.16921.17934765661946426475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d37aee9018e68b0d356195caefbb651910e0bbfa
Gitweb:        https://git.kernel.org/tip/d37aee9018e68b0d356195caefbb651910e0bbfa
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 16 Dec 2021 22:53:20 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Jan 2022 12:57:19 +01:00

sched/uclamp: Fix iowait boost escaping uclamp restriction

iowait_boost signal is applied independently of util and doesn't take
into account uclamp settings of the rq. An io heavy task that is capped
by uclamp_max could still request higher frequency because
sugov_iowait_apply() doesn't clamp the boost via uclamp_rq_util_with()
like effective_cpu_util() does.

Make sure that iowait_boost honours uclamp requests by calling
uclamp_rq_util_with() when applying the boost.

Fixes: 982d9cdc22c9 ("sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20211216225320.2957053-3-qais.yousef@arm.com
---
 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 62d98b0..6d65ab6 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -289,6 +289,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 	 * into the same scale so we can compare.
 	 */
 	boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
+	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
 	if (sg_cpu->util < boost)
 		sg_cpu->util = boost;
 }
