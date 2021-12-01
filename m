Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4D94647BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347158AbhLAHTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:19:00 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51983 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347128AbhLAHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:18:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Uz-4nDx_1638342935;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uz-4nDx_1638342935)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Dec 2021 15:15:36 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/pelt: fix code alignment problem
Date:   Wed,  1 Dec 2021 15:15:34 +0800
Message-Id: <20211201071534.35488-1-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

link:https://lore.kernel.org/lkml/20200219135442.18107-8-mgorman@techsingularity.net/

runnable_load_avg is no more used and it is removed by this patch.
It makes extra spaces appear in the code.

before
	shares   = calc_group_shares(gcfs_rq);
	runnable = calc_group_runnable(gcfs_rq, shares);

current
	shares   = calc_group_shares(gcfs_rq);

The original three spaces were meant to be aligned, but
it doesn't make sense now.

Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44c452072a1b..a344117d5aaf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3219,7 +3219,7 @@ static void update_cfs_group(struct sched_entity *se)
 	if (likely(se->load.weight == shares))
 		return;
 #else
-	shares   = calc_group_shares(gcfs_rq);
+	shares = calc_group_shares(gcfs_rq);
 #endif
 
 	reweight_entity(cfs_rq_of(se), se, shares);
-- 
2.19.1.6.gb485710b

