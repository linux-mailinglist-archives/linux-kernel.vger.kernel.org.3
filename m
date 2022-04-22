Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C650B512
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446567AbiDVKap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446541AbiDVKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF954BDA;
        Fri, 22 Apr 2022 03:27:43 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghxrLJ2tOeaJNHyvxM17SdM8t/7rVcm0oYkLm7OfjPU=;
        b=edk8UiQdooYuINh7DvcMBRzvzqIOh6BlqFfSZ1JctdMhkrnkcVBS2W/JRmsSAsS/U+K9tF
        4BTzS4jNb/LAXfj0Br3PXBSP16gNbITCEt1LOCsfqCq848vZB7+DeCvpYFZheuHRfheXxC
        VQU+9mtYoATCtb845zGz0PebJaKCayXtXVF4DrHdjwy1wQngbG73600/c3FW2drTbuQjpe
        l6K2BlMPrCM8F5iQ5Y/qWYEuwfRhfb2aJbZ6JqCAceVb0/qNA/ecyk10GldrvNWRCfcJua
        zMS2Dud4xp4xuUUyAJGclsRfbw7j0l8LF7jMgctPACenRtDGg3hwW6GPpIczWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghxrLJ2tOeaJNHyvxM17SdM8t/7rVcm0oYkLm7OfjPU=;
        b=WuYepgY5s8ttQUiSRgyuT3Xn0eAf7UYVVxAeg0J/waP6qCPWLlfxn/IB86WNCLIe7MjuR+
        zMxse4C3lOHO4zBw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: report zeroes for CPU full at the system level
Cc:     Martin Steigerwald <Martin.Steigerwald@proact.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408121914.82855-1-zhouchengming@bytedance.com>
References: <20220408121914.82855-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <165062326115.4207.12801633890427061202.tip-bot2@tip-bot2>
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

Commit-ID:     890d550d7dbac7a31ecaa78732aa22be282bb6b8
Gitweb:        https://git.kernel.org/tip/890d550d7dbac7a31ecaa78732aa22be282bb6b8
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 08 Apr 2022 20:19:14 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:14:08 +02:00

sched/psi: report zeroes for CPU full at the system level

Martin find it confusing when look at the /proc/pressure/cpu output,
and found no hint about that CPU "full" line in psi Documentation.

% cat /proc/pressure/cpu
some avg10=0.92 avg60=0.91 avg300=0.73 total=933490489
full avg10=0.22 avg60=0.23 avg300=0.16 total=358783277

The PSI_CPU_FULL state is introduced by commit e7fcd7622823
("psi: Add PSI_CPU_FULL state"), which mainly for cgroup level,
but also counted at the system level as a side effect.

Naturally, the FULL state doesn't exist for the CPU resource at
the system level. These "full" numbers can come from CPU idle
schedule latency. For example, t1 is the time when task wakeup
on an idle CPU, t2 is the time when CPU pick and switch to it.
The delta of (t2 - t1) will be in CPU_FULL state.

Another case all processes can be stalled is when all cgroups
have been throttled at the same time, which unlikely to happen.

Anyway, CPU_FULL metric is meaningless and confusing at the
system level. So this patch will report zeroes for CPU full
at the system level, and update psi Documentation accordingly.

Fixes: e7fcd7622823 ("psi: Add PSI_CPU_FULL state")
Reported-by: Martin Steigerwald <Martin.Steigerwald@proact.de>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20220408121914.82855-1-zhouchengming@bytedance.com
---
 Documentation/accounting/psi.rst |  9 ++++-----
 kernel/sched/psi.c               | 15 +++++++++------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index 860fe65..5e40b3f 100644
--- a/Documentation/accounting/psi.rst
+++ b/Documentation/accounting/psi.rst
@@ -37,11 +37,7 @@ Pressure interface
 Pressure information for each resource is exported through the
 respective file in /proc/pressure/ -- cpu, memory, and io.
 
-The format for CPU is as such::
-
-	some avg10=0.00 avg60=0.00 avg300=0.00 total=0
-
-and for memory and IO::
+The format is as such::
 
 	some avg10=0.00 avg60=0.00 avg300=0.00 total=0
 	full avg10=0.00 avg60=0.00 avg300=0.00 total=0
@@ -58,6 +54,9 @@ situation from a state where some tasks are stalled but the CPU is
 still doing productive work. As such, time spent in this subset of the
 stall state is tracked separately and exported in the "full" averages.
 
+CPU full is undefined at the system level, but has been reported
+since 5.13, so it is set to zero for backward compatibility.
+
 The ratios (in %) are tracked as recent trends over ten, sixty, and
 three hundred second windows, which gives insight into short term events
 as well as medium and long term trends. The total absolute stall time
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 5a49a8c..a337f3e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1060,14 +1060,17 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	mutex_unlock(&group->avgs_lock);
 
 	for (full = 0; full < 2; full++) {
-		unsigned long avg[3];
-		u64 total;
+		unsigned long avg[3] = { 0, };
+		u64 total = 0;
 		int w;
 
-		for (w = 0; w < 3; w++)
-			avg[w] = group->avg[res * 2 + full][w];
-		total = div_u64(group->total[PSI_AVGS][res * 2 + full],
-				NSEC_PER_USEC);
+		/* CPU FULL is undefined at the system level */
+		if (!(group == &psi_system && res == PSI_CPU && full)) {
+			for (w = 0; w < 3; w++)
+				avg[w] = group->avg[res * 2 + full][w];
+			total = div_u64(group->total[PSI_AVGS][res * 2 + full],
+					NSEC_PER_USEC);
+		}
 
 		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
 			   full ? "full" : "some",
