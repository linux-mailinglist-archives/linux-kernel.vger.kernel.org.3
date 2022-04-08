Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADE14F957C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiDHMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiDHMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:21:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192D32F086
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:19:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b15so8236508pfm.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8uoGZ/zdKm46FPD8jLlw4/DdbIugQvQ3ge6j/WFY9I=;
        b=r9alONQrNmBKLORSXwRuoMc4FLWhD2ZEW1S4Sx08BDjBZhe3fkGDMOhwey34pOLBo9
         w5vnOiOY9Q0OZI2q476bg4QNmkjDYrSXUILeG7MXYmG7TFdYNuMzGtGudz0MIDDxH3x0
         eCxWsTvEXO6bBw+mTwzRUFkUdI8MpQbLkBUo6WLOfjILXCxEM2zl8iJjVCHIIHzEuCIW
         ZZeBO5o702zlvcd/6pZ0ndx7N2nYMnTMRol9lNpAw+0d6zSLBrtBd8KwjhzF0rxKBfaA
         rWDDy1eC1o0jKhswzYr++cjOD9Dcw5u0716tX8Tsf/u+qMjhKpy1OfrbkgaVgo49BEMU
         D9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8uoGZ/zdKm46FPD8jLlw4/DdbIugQvQ3ge6j/WFY9I=;
        b=n/+4t4hO3YufvwSAWrV0Z/aJSjyPDfV+sPIBv0lDc07czsZ5WT1hKJtl7ndsYoudZ9
         mglCYkiV5ouTwok+pMSQwTqLqAKNJ2fG5FBRhhnu1NCsHxuom1qWlP20s9+aUAWRngBY
         35xB4BmF2OZWvGzaWxfltIOV3uGQksY0FlE8HTPr+1x8voa4rOpp7RYZFjP9OL06VOmu
         hf0on1g3qOTlQ29EBoSQnPcsieRcassdp4GiI++sFrT+NLluTQrCvy/trwEwf7BEza1Y
         gyAXg1uFr4VtXcoG2nVPTMueal1c7OoK8SqoK3k+rpnZ7+ueBfoqcDm08rLO6GGu8j3k
         yVgA==
X-Gm-Message-State: AOAM5319pbGYpbwaL+imuoNDOwGK6QCLSR+Bp8GjsbZUUkzxYk/vtI/5
        8Iwy1y7b9JSrVH/zQ6T9+QwIYg==
X-Google-Smtp-Source: ABdhPJwB4KK92tFeRfcNQEfhh/5Cd25Z2vJ0y/DcPl7CAKdFpzx+NrRlyFuJcEfg4SBBO24NMGMACA==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr19511592pfm.3.1649420373481;
        Fri, 08 Apr 2022 05:19:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:a5e3:608e:7730:5b8e])
        by smtp.gmail.com with ESMTPSA id oo16-20020a17090b1c9000b001b89e05e2b2sm13438465pjb.34.2022.04.08.05.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 05:19:33 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     corbet@lwn.net, hannes@cmpxchg.org, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, ebiggers@google.com,
        zhouchengming@bytedance.com, songmuchun@bytedance.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
Subject: [PATCH RESEND v2] sched/psi: report zeroes for CPU full at the system level
Date:   Fri,  8 Apr 2022 20:19:14 +0800
Message-Id: <20220408121914.82855-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - report zeroes for CPU full at the system level, suggested
   by Johannes.
 - update doc about the zeroes in CPU full at the system level.
---
 Documentation/accounting/psi.rst |  9 ++++-----
 kernel/sched/psi.c               | 15 +++++++++------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index 860fe651d645..5e40b3f437f9 100644
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
index a4fa3aadfcba..ed9fb557dadd 100644
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
-- 
2.35.1

