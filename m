Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECE2514526
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356331AbiD2JRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiD2JRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:17:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F32465F8E0;
        Fri, 29 Apr 2022 02:13:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC7F51063;
        Fri, 29 Apr 2022 02:13:56 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.14.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 474083F73B;
        Fri, 29 Apr 2022 02:13:54 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, lukasz.luba@arm.com,
        xuewen.yan@unisoc.com, linux-doc@vger.kernel.org
Subject: [PATCH] sched: thermal_load_avg: Change the raising/decaying period mechanism
Date:   Fri, 29 Apr 2022 10:12:45 +0100
Message-Id: <20220429091245.12423-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal pressure mechanism consists of two parts:
1) PELT-like signal with its own clock (rq_clock_thermal()) which is
   responsible for the raising/decaying characteristics
2) instantaneous information provided in 'thermal_pressure' variable,
   which is set by thermal framework or drivers to notify about
   the throttling.

Add a new mechanism which allows to change the raising/decaying
characteristics of the PELT-like thermal signal. To make this happen
modify how the rq_clock_thermal() counts. Instead of only slowing down the
clock, which results in longer raising/decaying periods, make it faster.
Thanks to that the information about throttling can faster arrive at the
right place in the scheduler. This faster propagation of information
is useful for the latency sensitive stuff, such as RT tasks. In
a situation of CPU capacity inversion, such task might suffer when
staying on the lower capacity CPU.

Change the boot parameter 'sched_thermal_decay_shift' allowed values
and use the negatives to speed up the thermal clock.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi all,

This patch addresses an issue of missing configuration for the
thermal pressure raising/decaying characteristic to be more instantaneous.
This more sharp signal might be better if the raw thermal signal
already has 'some logic' or doesn't change that often, like in IPA
(every 100ms).

I've prepared a notebook with experiments with different shifter
values [0, -2, -3, -4, 2, 4] for IPA thermal update periods:
50ms, 100ms (and also jumping between cooling states 0, 1 or 0, 3).
It presents two signals: instantaneous thermal update and thermal_load_avg().
It would be useful for discussion. I can provide more details if needed.

Regards,
Lukasz Luba

[1] https://nbviewer.org/github/lukaszluba-arm/lisa/blob/public_tests/thermal_pressure_delays-all-ipa.ipynb



 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++----
 kernel/sched/fair.c                             |  2 +-
 kernel/sched/sched.h                            | 17 +++++++++++++++--
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c2d1f8b5e8f3..ba32540f1fbf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5117,15 +5117,22 @@
 			pressure signal. Thermal pressure signal follows the
 			default decay period of other scheduler pelt
 			signals(usually 32 ms but configurable). Setting
-			sched_thermal_decay_shift will left shift the decay
-			period for the thermal pressure signal by the shift
-			value.
+			a positive value for sched_thermal_decay_shift will
+			left shift the decay period for the thermal pressure
+			signal by the shift value. This would make
+			raising/decaying characteristic longer. Setting
+			a negative value will right shift the decay period
+			by the shift value and make the raising/decaying
+			characteristic more sharp.
 			i.e. with the default pelt decay period of 32 ms
 			sched_thermal_decay_shift   thermal pressure decay pr
+				-2			8 ms
+				-1			16 ms
+				0			32 ms
 				1			64 ms
 				2			128 ms
 			and so on.
-			Format: integer between 0 and 10
+			Format: integer between -5 and 10
 			Default is 0.
 
 	scftorture.holdoff= [KNL]
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..93cb7db5939c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -100,7 +100,7 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 	if (kstrtoint(str, 0, &_shift))
 		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
 
-	sched_thermal_decay_shift = clamp(_shift, 0, 10);
+	sched_thermal_decay_shift = clamp(_shift, -5, 10);
 	return 1;
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be905739..cb453c0f3572 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1478,8 +1478,14 @@ static inline u64 rq_clock_task(struct rq *rq)
 /**
  * By default the decay is the default pelt decay period.
  * The decay shift can change the decay period in
- * multiples of 32.
+ * multiples of 32 to make it longer or to make it shorter using
+ * negative values as on the example below.
  *  Decay shift		Decay period(ms)
+ *	-5			1
+ *	-4			2
+ *	-3			4
+ *	-2			8
+ *	-1			16
  *	0			32
  *	1			64
  *	2			128
@@ -1490,7 +1496,14 @@ extern int sched_thermal_decay_shift;
 
 static inline u64 rq_clock_thermal(struct rq *rq)
 {
-	return rq_clock_task(rq) >> sched_thermal_decay_shift;
+	u64 thermal_clock = rq_clock_task(rq);
+
+	if (sched_thermal_decay_shift < 0)
+		thermal_clock <<= -sched_thermal_decay_shift;
+	else
+		thermal_clock >>= sched_thermal_decay_shift;
+
+	return thermal_clock;
 }
 
 static inline void rq_clock_skip_update(struct rq *rq)
-- 
2.17.1

