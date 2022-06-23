Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A63557C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiFWNDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiFWNDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:03:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D74A3C4BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:03:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a17so16140995pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKyyV3GoHjuKDN7lETkfF7quBQx99v7fa63UbhHjioA=;
        b=sP620C4MwMyJ0AbCEbs5/xsWT0FvBTvtDyyRX6VfxaEQhehIpVD7TVpZ/+73qIuu2z
         v2FOJhyAh64MmdbO/5LzTHOblVcrjw3grOxg3FDuJnZGkLcS3qyVl5fhtDtI419JoPtf
         3KhBKJE5FSaH3l9uvSCQtLuGoEWPeJ2lYW0djMGGzddwlP9Gc7qmH9uWUxTtszMPmKUI
         wdPOkoaawkRPXWBQssn3LHwD234+854/eg5FSJzhHuP2jcRFxf+eNpEZOuKqY7UIBhhA
         YLD9y9xP7i1wJ/xlLwot3vTiCaHq4IDmlc67ez5NPA+BxlHKNwkgngabBpxvcwYoshhB
         hekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKyyV3GoHjuKDN7lETkfF7quBQx99v7fa63UbhHjioA=;
        b=uOFMZ/ylxyCWd/iUo5UK21ILG9qckWolVpBgdGs3b76rcXJt0b+9tgThwG4ZiAbVPE
         YKvEPusGwm++nVnC6pQMbCdDCIXr0+D6stQIOJrFieJHYgQGDiRJizzQvrHJDuG1HAL8
         U7nheNU2MeAq1mBDWKYigb7ue308BPmwGqyF3lyCnpve6emduc0jPN1pKkX7AgQJAroh
         v1gsp94KVRBbx05lH7yWpxnNMH98hXKboIMDs1qF4Pue8mkfB5QRWhJMU1WDXnj1wxeb
         Z0vKsVh2ZXzW0dKn4thhcSzKlVy+MVGuYyyHx4AC30HS49YFAJj6Li2oFT7ZOQMTnmpv
         fDOw==
X-Gm-Message-State: AJIora/CCwPpHJ/1keHQnDPvo6s6e8oOcXthUmzpT8uGPw8bwHAJ223t
        YhkMx195GorGPs/CnXvLafTxIw==
X-Google-Smtp-Source: AGRyM1t7HruSKN9mlrAY5crrm6TXD0mwodSU/Rz5CnaBBrzfMPDx8fufH+6ZK98Qs8+m860ixew2hg==
X-Received: by 2002:a17:902:f544:b0:16a:2b62:ef77 with SMTP id h4-20020a170902f54400b0016a2b62ef77mr17858118plf.134.1655989415611;
        Thu, 23 Jun 2022 06:03:35 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b00518d06efbc8sm16758194pfl.98.2022.06.23.06.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 06:03:34 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/fair: move nohz definition to where it's used
Date:   Thu, 23 Jun 2022 21:03:25 +0800
Message-Id: <20220623130325.49813-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nohz definition is too far from where it's used, just move it
to the right place. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8bed75757e65..01f7047c41d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5842,19 +5842,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 
-#ifdef CONFIG_NO_HZ_COMMON
-
-static struct {
-	cpumask_var_t idle_cpus_mask;
-	atomic_t nr_cpus;
-	int has_blocked;		/* Idle CPUS has blocked load */
-	int needs_update;		/* Newly idle CPUs need their next_balance collated */
-	unsigned long next_balance;     /* in jiffy units */
-	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
-} nohz ____cacheline_aligned;
-
-#endif /* CONFIG_NO_HZ_COMMON */
-
 static unsigned long cpu_load(struct rq *rq)
 {
 	return cfs_rq_load_avg(&rq->cfs);
@@ -10374,6 +10361,14 @@ static inline int on_null_domain(struct rq *rq)
  * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED not set
  *   anywhere yet.
  */
+static struct {
+	cpumask_var_t idle_cpus_mask;
+	atomic_t nr_cpus;
+	int has_blocked;		/* Idle CPUS has blocked load */
+	int needs_update;		/* Newly idle CPUs need their next_balance collated */
+	unsigned long next_balance;     /* in jiffy units */
+	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
+} nohz ____cacheline_aligned;
 
 static inline int find_new_ilb(void)
 {
-- 
2.36.1

