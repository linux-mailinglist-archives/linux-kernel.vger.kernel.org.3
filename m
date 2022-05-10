Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229052205A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbiEJQBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346208AbiEJPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:16 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F42AE1B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m1so6260426qkn.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ya/vdwdChlS+tAL1BwfCVBl0QMpJDdlIuc7UFyY3mko=;
        b=TlCC1FHeS9Vp7sRgrVJU6EDQc+dQs1Lvm3qZXexX4iAcPaDkDWQ4a3FtR2FSWjCDIm
         5YVZRmJaG/Nv41leZxxgqULfaZjhMneVrYRPDAkl2sQdsbEftNGM3AIaROuL5Wdafn4I
         WZ9o/4T5VzWixRbR4gMP2ZMrm82bLeKSpwEzYh5OZl3AqH1LBA9Ou/BSEu6wvNfNicV4
         4AOy9kIJ0/chNSK9noA79+b8sn4qeKt9zB2fXS/yGVQbG5SwYaIGpIjhqL75kqKtCQmB
         nOt/qBhGRKoO7S+PwiR4VDign1xYc5MjlGOGQuYnyRdLFh1ReKHE+wcJbHEVRHZGAJod
         +YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ya/vdwdChlS+tAL1BwfCVBl0QMpJDdlIuc7UFyY3mko=;
        b=KCtnbeOpSoFJYQXP3Ph/nkm+mU/kbhLPuGsXXHFk6ZMaerJ65nZHfXv+GQoTqi+RKj
         g8a88uXv5pSWbWlu5XydTkZPfrjEE8DGgrnfpTHL+N1PcX8YKnl65JhLx5GqCppoajQj
         Fbe0pkmhy7EgzAXcYS4hC/Ra+aVdxE6CECCGypMWe3ojzqeStKeUTxvQNhndnn4DIDtV
         +omGNF92SE23YZSmAxWv002mKvQ0qkCBYDckxblIpL05CeCCFzXsP3KiNs0y07ulagVS
         nlDovqMEjltToDRG7x2C05hOfe7c2P1OF818V2f9ai3XwPALv7ECMxhkjpiSXIcaXeIM
         oZ7g==
X-Gm-Message-State: AOAM5323TMjoe7s5uKFOQoA/Oe32s+U4wrY8Vk2I3IFbvODboHKHMuVV
        ajBMS6fsLHxRX0Viely1qdk=
X-Google-Smtp-Source: ABdhPJzj4In6E2K7mgcFdSROB32xJL8d3sEtetPOgoESLE4arPsqpmo93DwWFWTuroO0mHGo22+zOg==
X-Received: by 2002:a05:620a:1036:b0:69f:d57d:8136 with SMTP id a22-20020a05620a103600b0069fd57d8136mr15808970qkk.671.1652197697353;
        Tue, 10 May 2022 08:48:17 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id f3-20020ac84643000000b002f39b99f671sm9418292qto.11.2022.05.10.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:17 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 17/22] sched/core: fix opencoded cpumask_any_but()
Date:   Tue, 10 May 2022 08:47:45 -0700
Message-Id: <20220510154750.212913-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_core_cpu_starting() and sched_core_cpu_deactivate() implement
opencoded cpumask_any_but(). Fix it.

CC: Ben Segall <bsegall@google.com>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Valentin Schneider <vschneid@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/core.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5ebc392493d..9700001948d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6125,7 +6125,7 @@ static void queue_core_balance(struct rq *rq)
 static void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
-	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
+	struct rq *rq = cpu_rq(cpu), *core_rq;
 	unsigned long flags;
 	int t;
 
@@ -6138,19 +6138,16 @@ static void sched_core_cpu_starting(unsigned int cpu)
 		goto unlock;
 
 	/* find the leader */
-	for_each_cpu(t, smt_mask) {
-		if (t == cpu)
-			continue;
-		rq = cpu_rq(t);
-		if (rq->core == rq) {
-			core_rq = rq;
-			break;
-		}
-	}
+	t = cpumask_any_but(smt_mask, cpu);
+	if (t >= nr_cpu_ids)
+		goto unlock;
 
-	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
+	rq = cpu_rq(t);
+	if (WARN_ON_ONCE(rq->core != rq)) /* whoopsie */
 		goto unlock;
 
+	core_rq = rq;
+
 	/* install and validate core_rq */
 	for_each_cpu(t, smt_mask) {
 		rq = cpu_rq(t);
@@ -6168,7 +6165,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 static void sched_core_cpu_deactivate(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
-	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
+	struct rq *rq = cpu_rq(cpu), *core_rq;
 	unsigned long flags;
 	int t;
 
@@ -6185,16 +6182,12 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 		goto unlock;
 
 	/* find a new leader */
-	for_each_cpu(t, smt_mask) {
-		if (t == cpu)
-			continue;
-		core_rq = cpu_rq(t);
-		break;
-	}
-
-	if (WARN_ON_ONCE(!core_rq)) /* impossible */
+	t = cpumask_any_but(smt_mask, cpu);
+	if (t >= nr_cpu_ids)
 		goto unlock;
 
+	core_rq = cpu_rq(t);
+
 	/* copy the shared state to the new leader */
 	core_rq->core_task_seq             = rq->core_task_seq;
 	core_rq->core_pick_seq             = rq->core_pick_seq;
-- 
2.32.0

