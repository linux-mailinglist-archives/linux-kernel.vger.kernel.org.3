Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE84D2DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiCILPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiCILPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:15:53 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF67713CECA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:14:53 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q19so1689237pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsQsBuB2ms4XH7MMbYKCaAltmU40a94dVvRdCh2kPG8=;
        b=giQbAvpiNC6GgihtPUmX/gFcKXYFcGs5sk/zxjgS1mngiwkVPSv4j6HBatM0A6SLlD
         N8pUdXxYXl2dKA+Qime4DiOB5yxnMcG6y5PEEtMWzLJPHakjdt5TNPJ9vNIZBKiqfz5q
         FIS9Y3LvOE9bG3rek35JoAtOfqqZLFepdhsm2MbOwIMeEuLWd+7m0UBTr8YeUl9qIqwH
         DIMBlWDd/Hq4QUgfWKKEPdUYScu/rzE4O05+0ycytJSuR+bFfjPlArO5p5A6ZTAG0AFs
         kK1ckGlUZqDk+8DjcadQrClsK0k3ZPNAGZ5w3AzjGd8bBNPWttN+iWpfE5e3PCWow/PV
         ynGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsQsBuB2ms4XH7MMbYKCaAltmU40a94dVvRdCh2kPG8=;
        b=bvFQ0hif+Qtx5Zrrl4v+IUzKrk94mR5XJn5dDH4MjgzgCgkqPeyoF4IUtigmc14i5P
         Jnn0EV1TRciksEZqbKQYYH2Thl99tFl5LkHkufkWo5uuDXQF1GYBFmxOcrzRTxHHXbZe
         nH+Q69o/cYtlZ5YERSIJxo2mZqXDQiHjLCyjrKbKP4gh8383yYG7aoIDRnCr5He13c9O
         0EOcBdnDHNqsthice9MVXWTIpDG+M6PrimK1EGksfwInpcl8utD2ZEVmv8zoBBx5Jy0M
         PSEdJ5PXUtaQCn4N198PfLyQ980ZOzLwfFMRjRf7PgIClhpH/OP0YOYGs4wna3YwiWbN
         IqKQ==
X-Gm-Message-State: AOAM530AfrYqAMhWjhldGIJyaQzz5NYY5fLOpUhsFY6x+dj7ujIjnGZw
        Rc40Ox0j/8Uhf3SGQldfNJ5Gi86eYtVcdg==
X-Google-Smtp-Source: ABdhPJwBIGZHoRknu7XKYBKDZJFavSBHX1JbW99jXbsjdCSN8eEhyiUwRrZ9tgEjVnaIgmQI9H+4+g==
X-Received: by 2002:a63:204d:0:b0:378:c9e5:bea6 with SMTP id r13-20020a63204d000000b00378c9e5bea6mr17841111pgm.573.1646824493366;
        Wed, 09 Mar 2022 03:14:53 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b004f129e7767fsm2459618pfv.130.2022.03.09.03.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:14:52 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     corbet@lwn.net, hannes@cmpxchg.org, mingo@redhat.com,
        peterz@infradead.org, surenb@google.com, ebiggers@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
Subject: [PATCH v2] psi: report zeroes for CPU full at the system level
Date:   Wed,  9 Mar 2022 19:14:45 +0800
Message-Id: <20220309111445.86484-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Changes in v2:
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
index e14358178849..97fd85c5143c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1062,14 +1062,17 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
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
2.20.1

