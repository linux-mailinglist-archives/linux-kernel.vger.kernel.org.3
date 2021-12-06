Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078A946A062
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443887AbhLFQBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:01:31 -0500
Received: from unknown-3-146.windriver.com ([147.11.3.146]:10400 "EHLO
        mail1.wrs.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1390730AbhLFPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:44:07 -0500
X-Greylist: delayed 2388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 10:43:49 EST
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 1B6F0Ioe024972
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:00:18 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 1B6F05A3020397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:00:05 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 6 Dec 2021 07:00:04 -0800
Received: from hackbox.wrs.com (128.224.56.205) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 6 Dec 2021 07:00:04 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/2] tick/nohz: WARN_ON --> WARN_ON_ONCE to prevent console saturation
Date:   Mon, 6 Dec 2021 09:59:50 -0500
Message-ID: <20211206145950.10927-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211206145950.10927-1-paul.gortmaker@windriver.com>
References: <20211206145950.10927-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6bffe5af8cb1..19e6b861de97 100644
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

