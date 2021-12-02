Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2E6466233
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbhLBLYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:24:12 -0500
Received: from foss.arm.com ([217.140.110.172]:33786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233453AbhLBLYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:24:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A530142F;
        Thu,  2 Dec 2021 03:20:47 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D1BC3F7D7;
        Thu,  2 Dec 2021 03:20:46 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>
Subject: [PATCH v2] sched/uclamp: Fix rq->uclamp_max not set on first enqueue
Date:   Thu,  2 Dec 2021 11:20:33 +0000
Message-Id: <20211202112033.1705279-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

Changes in v2:
  - Update commit message to be more descriptive (Valentin).
  - Added Reviewed-by and Tested-by from Valentin and Dietmar (Thanks!)

 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index beaa8be6241e..52b0c7513a32 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1929,7 +1929,7 @@ static void __init init_uclamp_rq(struct rq *rq)
 		};
 	}
 
-	rq->uclamp_flags = 0;
+	rq->uclamp_flags = UCLAMP_FLAG_IDLE;
 }
 
 static void __init init_uclamp(void)
-- 
2.25.1

