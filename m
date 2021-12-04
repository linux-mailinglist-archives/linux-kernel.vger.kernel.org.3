Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0028468516
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385046AbhLDNng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355050AbhLDNnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:43:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7FBC0613F8;
        Sat,  4 Dec 2021 05:40:07 -0800 (PST)
Date:   Sat, 04 Dec 2021 13:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638625204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiFn0Zt7tRhKubu76IlAixV7MelnV7yQVyafuhDi/5s=;
        b=RKYz6O1J9iTcgZtUUyhoPiuY2xvfPbx5cBVnhrmzC7Mm15lPQSJ1DjVIJzKCvVHGTmeeov
        72vFKQjaNhezwDQHLCsq/SyNsU9Q0hRbgawbGRFKqS9R6SnIaLyvGHF45qFfnuJl6KApBV
        8jk/UR1cUYLBo2eVhTogF10D2fe1HkAhigY0Q6KFML5rs6Fbg36pl07/0uuW/Vmce/YEI4
        rCxXtbCeZYcc0JXT4lKG/rsBCDZ29b7xqBZPZxWE2vilQcv0brQ3hxz8jQ95xbN015o5/F
        FqC83zos18iIMTrZbBuPZXDotA6bkKS3tWMNTGT6So3ni097c1I0pu3wEtZDMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638625204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiFn0Zt7tRhKubu76IlAixV7MelnV7yQVyafuhDi/5s=;
        b=OiEl8LYhOgK+5/0ErU2ARl7WDAIBw8LJQjoA6OgWQvv9Lv5Mj+aLEhY/g2ZqsorT9Ad3Yy
        bYG7JSCIw4Brl/DQ==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/uclamp: Fix rq->uclamp_max not set on first enqueue
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202112033.1705279-1-qais.yousef@arm.com>
References: <20211202112033.1705279-1-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <163862520343.11128.4390187951358390879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     315c4f884800c45cb6bd8c90422fad554a8b9588
Gitweb:        https://git.kernel.org/tip/315c4f884800c45cb6bd8c90422fad554a8b9588
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 02 Dec 2021 11:20:33 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:18 +01:00

sched/uclamp: Fix rq->uclamp_max not set on first enqueue

Commit d81ae8aac85c ("sched/uclamp: Fix initialization of struct
uclamp_rq") introduced a bug where uclamp_max of the rq is not reset to
match the woken up task's uclamp_max when the rq is idle.

The code was relying on rq->uclamp_max initialized to zero, so on first
enqueue

	static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
					    enum uclamp_id clamp_id)
	{
		...

		if (uc_se->value > READ_ONCE(uc_rq->value))
			WRITE_ONCE(uc_rq->value, uc_se->value);
	}

was actually resetting it. But since commit d81ae8aac85c changed the
default to 1024, this no longer works. And since rq->uclamp_flags is
also initialized to 0, neither above code path nor uclamp_idle_reset()
update the rq->uclamp_max on first wake up from idle.

This is only visible from first wake up(s) until the first dequeue to
idle after enabling the static key. And it only matters if the
uclamp_max of this task is < 1024 since only then its uclamp_max will be
effectively ignored.

Fix it by properly initializing rq->uclamp_flags = UCLAMP_FLAG_IDLE to
ensure uclamp_idle_reset() is called which then will update the rq
uclamp_max value as expected.

Fixes: d81ae8aac85c ("sched/uclamp: Fix initialization of struct uclamp_rq")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20211202112033.1705279-1-qais.yousef@arm.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 814c52d..7756310 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1918,7 +1918,7 @@ static void __init init_uclamp_rq(struct rq *rq)
 		};
 	}
 
-	rq->uclamp_flags = 0;
+	rq->uclamp_flags = UCLAMP_FLAG_IDLE;
 }
 
 static void __init init_uclamp(void)
