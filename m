Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1964BEA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiBUSwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:52:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiBUSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:51:39 -0500
Received: from mail1.wrs.com (unknown-3-146.windriver.com [147.11.3.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB72EDBA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:51:13 -0800 (PST)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 21LIKavP027190
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 21 Feb 2022 10:20:37 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 21LIKYlr026458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Feb 2022 10:20:36 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 21 Feb 2022 10:20:35 -0800
Received: from yow-pgortmak-d4.wrs.com (128.224.56.60) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 21 Feb 2022 10:20:34 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/2] tick/nohz: WARN_ON --> WARN_ON_ONCE to prevent console saturation
Date:   Mon, 21 Feb 2022 13:20:09 -0500
Message-ID: <20220221182009.1283-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220221182009.1283-1-paul.gortmaker@windriver.com>
References: <20220221182009.1283-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running some testing on code that happened to allow the variable
tick_nohz_full_running to get set but with no "possible" NOHZ cores to
back up that setting, I tripped this WARN:

        if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
                WARN_ON(tick_nohz_full_running);

The console was overwhemled with an endless stream of one WARN per tick
per core and there was no way to even see what was going on w/o using a
serial console to capture it and then trace it back to this guy.

Changing it to ONCE reveals that we get the message we need in a
civilized fashion, and the system can limp along until rebooted.

Fixes: 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full")
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 17a283ce2b20..5e80ee44c32a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -186,7 +186,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 */
 	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
-		WARN_ON(tick_nohz_full_running);
+		WARN_ON_ONCE(tick_nohz_full_running);
 #endif
 		tick_do_timer_cpu = cpu;
 	}
-- 
2.17.1

