Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AB4CE22C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 03:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiCECPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 21:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiCECPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 21:15:09 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B6E1DED7A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 18:14:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t14so8954192pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 18:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1gJQr+FTDZ4M1UygRfcjeFTuDAI/oNr3Uxq3pS6131Q=;
        b=4HVvPT9IUNfcSAn6wxI/76TaxpvEYn6rTAQVdwGPQbVrdZgpcNvs0YDxiuW+Enfo2S
         kp/s0SvhqHrXOjB+G7PHbq6O25fg89N3/WV9jkkKC1DCsxA7dmahL1HmDWixbgTYsUkr
         Srzwj2GmyjTlYa73tU/yXMPITQ0vikQR8RmJDtqOBPS6IdWBYeaQGYkbX9EKdVhz4mnt
         If4fEP54ZZypHXci6eYKitLvPN3oydpB5yqwLT+S4g4gR8QhVM7dHn1JdyQb4abQvug3
         UEfmVa87vjsYyXJtkvBg01AHbWxdSOJT52EJeGoRwDV5ITRakCwlpZiA8icRobwaCDNN
         4KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1gJQr+FTDZ4M1UygRfcjeFTuDAI/oNr3Uxq3pS6131Q=;
        b=EX7KKykGjpZS0WeAx/vhXFEzTfCFAh8RvVAtl6gtuxMWL8lbEKW4QJlWuTdor7sNV7
         Xi3S0BKz+mT5fXS4mqgoRKqAcDw6lwXBCKbtMaZQ7isDyW2omn19fWAgFpgt5q8FSly0
         WKmH414hKdUIJcmJBPNQEcJUwDPxh6sN0IA0s7EF8YCftF4AV51ySuUY33AP0Bppv1he
         deqUCnd2yjlGsEa0/kC4nBfl7z+J8SEKmLKr9+FCbRgme5CRahBz4BV2lhVwdnB3V+4t
         +TBAaw1j+a1yrh7Ggs1F0nGbu8+9nsgFuIrks9wCkTH07yb9XRA6QlurUKadaPm19a1q
         hxbg==
X-Gm-Message-State: AOAM533h8A3h8mqdzwiWKR1mYPaF0uF9wggeHwuxQ83lb8DECWMbKQp0
        WVl9kawJ8ngDXkKF1gASaCnENw==
X-Google-Smtp-Source: ABdhPJya+LIXcDq4e1JBgbqkMj3zOIEN+Yv4z+hQh464a/ErocbEZZyEbWbmJaWopBSyec6ytb9RtQ==
X-Received: by 2002:a05:6a00:2166:b0:4f6:67fe:a336 with SMTP id r6-20020a056a00216600b004f667fea336mr1527165pff.17.1646446459795;
        Fri, 04 Mar 2022 18:14:19 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e6d:cc00:d089:89fd:5c33:f12])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a001ad100b004f0ec1cbc4fsm6886691pfv.109.2022.03.04.18.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:14:19 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     corbet@lwn.net, hannes@cmpxchg.org, mingo@redhat.com,
        peterz@infradead.org, ebiggers@google.com, surenb@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
Subject: [PATCH] psi: report zeroes for CPU full at the system level
Date:   Sat,  5 Mar 2022 10:13:29 +0800
Message-Id: <20220305021329.54119-1-zhouchengming@bytedance.com>
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
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 Documentation/accounting/psi.rst |  6 +-----
 kernel/sched/psi.c               | 15 +++++++++------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index 860fe651d645..7e15e37d3179 100644
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

