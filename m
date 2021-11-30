Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0214E46420F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbhK3XMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36604 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbhK3XMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:06 -0500
Date:   Tue, 30 Nov 2021 23:08:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=716Oj+CIqNUfO1Qkt26VSZKFtUKFYL1TeEuzBhEHt1g=;
        b=STEH4CWM1TygBmMR1SmJtC0+Ez0RllDKBb7sTYvTnY0p8Nm0vYaRPB80eI9sp4hAbtBnRM
        HoebZcmn9v0dsArv+ym381zQqkVcT8mICzghtwWakqhLLTpGyOyGzqbmW3RSzMf7DVBmYa
        pCbJps7sCFlvzyYWl9z1XU9qeEnsGCXLePbAuw0tvqDy7zk86lbMwvRn6lxNg8WggcBlBr
        Qr5SnT/YWZ64JB1jrI4AwPAJCuwnHT1Pqa8GkPTHsG+oczmSnHeEp9L20Tu2syFoFPuv+U
        MteXK+cj8XFVmVHuVrtQEGaiH5k3uasphWyi67hwEW9i1vdm5Dyi7tI/oCxk4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=716Oj+CIqNUfO1Qkt26VSZKFtUKFYL1TeEuzBhEHt1g=;
        b=rnyUVb5C2hKwpCQcP6gCmEJTCOok0J51XBgNoNM7EyHJgpv0kMUJuLaPxQxPmBHLgfCH7L
        hxUoDGUNe5ngT4BA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] sched: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-4-mark.rutland@arm.com>
References: <20211129130653.2037928-4-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831372463.11128.9131647749098346552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     0569b245132c40015281610353935a50e282eb94
Gitweb:        https://git.kernel.org/tip/0569b245132c40015281610353935a50e282eb94
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:45 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:43 +01:00

sched: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are disabled,
the flags can change under our feet. Generally this is unlikely to cause a
problem in practice, but it is somewhat unsound, and KCSAN will
legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

The READ_ONCE(ti->flags) .. cmpxchg(ti->flags) loop in
set_nr_if_polling() is left as-is for clarity.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20211129130653.2037928-4-mark.rutland@arm.com

---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 76f9dee..7042627 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8520,7 +8520,7 @@ void sched_show_task(struct task_struct *p)
 	rcu_read_unlock();
 	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
 		free, task_pid_nr(p), ppid,
-		(unsigned long)task_thread_info(p)->flags);
+		read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
