Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282F34974BC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbiAWSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiAWSmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17971C06175C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j16so2930422plx.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yBVTc0LoZqur4BtqWgAdcYwOfT8OtJjDGCNTNKx2gqc=;
        b=BpTXbSran70GJvWk28mflzE3lOWqBzL9WlsOPmyujYXLky3/zviqDe6o9eB402S4S/
         V3BnWpazygS/UkW7qo7GNtpMVydp5uYemx8V6egaZqakcdxd9l4GIk7VYR9ux5lLCsnF
         O83Uk7z0WfZlgm2+AXjRQVfmRoqihYzoD8ye2B29+Mfj6INENzwW3GybQLMLgDFxF5F2
         +/MWhDu3yUulDDeraRVcOukdPtfeisksDDO+cbnLBpsHbyNxM9zDDn2lSf4iXd0/VCZ+
         gFP9iGGvINdI4UKIyi0fywypj0BQCrPQfDN/23G3H+6xKIRZFpDr4RnVni5pEFL8FPo4
         URug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBVTc0LoZqur4BtqWgAdcYwOfT8OtJjDGCNTNKx2gqc=;
        b=cfxb9Ys1k4w3RiO5qqylazz5exKni3zh8eAuDssuExsDQAiwwF61oDQcrCRNL2GNZ7
         Dr2X4tl2klYuSK+Wl2vaEVLkgw/bpW1RYGdI/nzvDEm4h7lZNRCU0QNlrC905JCv0Zvl
         cMbmKc5+sMFpHBmd3mVua2RTBBq7qA4ZwfdUZzJbmQ0SILrDYoR9AZ/HZLdQrBHTRLQv
         sbEVO3Z8IVybagsZKZFDmkxAQRHzQg2MznjPNGhkua5T6mSxdTKVoZ7k2xOmAbMUVnsK
         RpUulUS/ZORf7ivm+NczlEF4TN3NFQ/6Tzk0u1+S9Bj2j36OAN07W9k9VY8mVirAUNeL
         olGw==
X-Gm-Message-State: AOAM533n3u6+4UsR5+W8gpD97xkDUEf7qWbyp5kmrC+5tuA+6C2e4i6+
        QuisoIUFxtSQKmzgAKxjTjI=
X-Google-Smtp-Source: ABdhPJywhYuhKLgnMzPTf9A7fvWBjv4S4zdCMWrco5pL1xBowXW5LN4ta8sRs0d4CAHiU3t6zZJvYw==
X-Received: by 2002:a17:90a:5210:: with SMTP id v16mr9917205pjh.107.1642963335556;
        Sun, 23 Jan 2022 10:42:15 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x7sm13943517pfh.178.2022.01.23.10.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:15 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 47/54] sched: replace cpumask_weight with cpumask_weight_eq where appropriate
Date:   Sun, 23 Jan 2022 10:39:18 -0800
Message-Id: <20220123183925.1052919-48-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/sched code uses cpumask_weight() to compare the weight of
cpumask with a given number. We can do it more efficiently with
cpumask_weight_eq because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/core.c     | 8 ++++----
 kernel/sched/topology.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 918d0bdc2ea8..7494f51a3608 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6006,7 +6006,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 	WARN_ON_ONCE(rq->core != rq);
 
 	/* if we're the first, we'll be our own leader */
-	if (cpumask_weight(smt_mask) == 1)
+	if (cpumask_weight_eq(smt_mask, 1))
 		goto unlock;
 
 	/* find the leader */
@@ -6047,7 +6047,7 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	sched_core_lock(cpu, &flags);
 
 	/* if we're the last man standing, nothing to do */
-	if (cpumask_weight(smt_mask) == 1) {
+	if (cpumask_weight_eq(smt_mask, 1)) {
 		WARN_ON_ONCE(rq->core != rq);
 		goto unlock;
 	}
@@ -9045,7 +9045,7 @@ int sched_cpu_activate(unsigned int cpu)
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight_eq(cpu_smt_mask(cpu), 2))
 		static_branch_inc_cpuslocked(&sched_smt_present);
 #endif
 	set_cpu_active(cpu, true);
@@ -9120,7 +9120,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+	if (cpumask_weight_eq(cpu_smt_mask(cpu), 2))
 		static_branch_dec_cpuslocked(&sched_smt_present);
 
 	sched_core_cpu_deactivate(cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8478e2a8cd65..79395571599f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -169,7 +169,7 @@ static const unsigned int SD_DEGENERATE_GROUPS_MASK =
 
 static int sd_degenerate(struct sched_domain *sd)
 {
-	if (cpumask_weight(sched_domain_span(sd)) == 1)
+	if (cpumask_weight_eq(sched_domain_span(sd), 1))
 		return 1;
 
 	/* Following flags need at least 2 groups */
-- 
2.30.2

