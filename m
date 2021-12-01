Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7073946574B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352923AbhLAUpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352977AbhLAUoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35075C06174A;
        Wed,  1 Dec 2021 12:41:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7F036CE1DED;
        Wed,  1 Dec 2021 20:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44CDC53FCD;
        Wed,  1 Dec 2021 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391272;
        bh=fg9HL5x9TTG1Jo2tV+0s1T0gAtxsJ85PiqajQWHSV4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZlraEEuhPFP/uYxAbfvg1jz+y1IaluV42juj/hSTKDQPUWnuE6HXyGEntEOzSJ0P/
         VkT212io1cY2RCEn3w5BT1TkVYs4st9aykVqiGRTayBWdEWDKyUvgT30JWhRbUg1Eo
         6FXtE7pdKphfMLL1DCzzU+taBaRXwalae52KySmUu2rX3kh+fiZ6o0ev3Zjz67Joa3
         atY7aZhjNf830qnNgVQEJDK+smVQNz04+j1zAiuJU+Ls0vV9hzqtEeL6fRfl9rlEH5
         QIanr9GU4Bp8d1z66kATwalbR05UvBCHNs+0eG7d1JL1KcIw2Bw8UqKUzT1Seg7WEa
         v0ZWAOgwH7Wfw==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     stable-rt@vger.kernel.org
Subject: [PATCH RT 2/8] sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
Date:   Wed,  1 Dec 2021 14:41:02 -0600
Message-Id: <d6548fb5636c3b12c604a9e3252d81ba13fbae25.1638391253.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.4.161-rt67-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 39609ed79d420e0b966e16a1d695733c2d3b9a7f ]

With PREEMPT_RT enabled all hrtimers callbacks will be invoked in
softirq mode unless they are explicitly marked as HRTIMER_MODE_HARD.
During boot kthread_bind() is used for the creation of per-CPU threads
and then hangs in wait_task_inactive() if the ksoftirqd is not
yet up and running.
The hang disappeared since commit
   26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")

but enabling function trace on boot reliably leads to the freeze on boot
behaviour again.
The timer in wait_task_inactive() can not be directly used by an user
interface to abuse it and create a mass wake of several tasks at the
same time which would to long sections with disabled interrupts.
Therefore it is safe to make the timer HRTIMER_MODE_REL_HARD.

Switch the timer to HRTIMER_MODE_REL_HARD.

Cc: stable-rt@vger.kernel.org
Link: https://lkml.kernel.org/r/20210826170408.vm7rlj7odslshwch@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9b32fbded588..022c7b78642d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2158,7 +2158,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
 
-- 
2.17.1

