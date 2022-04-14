Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C95003EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiDNCCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiDNCCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:02:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99543240AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:59:50 -0700 (PDT)
X-UUID: ec19f78ec60049d69c6b1757fdf4eea0-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:9808c48b-e824-455f-aba2-8ce9614fd2df,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-30
X-CID-META: VersionHash:faefae9,CLOUDID:b4df12a9-d103-4e36-82b9-b0e86991b3df,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:2,File:nil,QS:0,BEC:nil
X-UUID: ec19f78ec60049d69c6b1757fdf4eea0-20220414
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 332499502; Thu, 14 Apr 2022 09:59:43 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 14 Apr 2022 09:59:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 09:59:41 +0800
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, kuyo chang <kuyo.chang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] [PATCH v2]sched/pelt: Refine the enqueue_load_avg calculate method
Date:   Thu, 14 Apr 2022 09:59:36 +0800
Message-ID: <20220414015940.9537-1-kuyo.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kuyo chang <kuyo.chang@mediatek.com>

I meet the warning message at cfs_rq_is_decayed at below code.

SCHED_WARN_ON(cfs_rq->avg.load_avg ||
		    cfs_rq->avg.util_avg ||
		    cfs_rq->avg.runnable_avg)

Following is the calltrace.

Call trace:
__update_blocked_fair
update_blocked_averages
newidle_balance
pick_next_task_fair
__schedule
schedule
pipe_read
vfs_read
ksys_read

After code analyzing and some debug messages, I found it exits a corner
case at attach_entity_load_avg which will cause load_sum is null but
load_avg is not.
Consider se_weight is 88761 according by sched_prio_to_weight table.
And assume the get_pelt_divider() is 47742, se->avg.load_avg is 1.
By the calculating for se->avg.load_sum as following will become zero
as following.
se->avg.load_sum =
	div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
se->avg.load_sum = 1*47742/88761 = 0.

After enqueue_load_avg code as below.
cfs_rq->avg.load_avg += se->avg.load_avg;
cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;

Then the load_sum for cfs_rq will be 1 while the load_sum for cfs_rq is 0.
So it will hit the warning message.

In order to fix the corner case, make sure the se->load_avg|sum is correct
before enqueue_load_avg.

After long time testing, the kernel warning was gone and the system runs
as well as before.

Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
---

v1->v2:

(1)Thanks for suggestion from Peter Zijlstra & Vincent Guittot.
(2)By suggestion from Vincent Guittot,
rework the se->load_sum calculation method for fix the corner case, 
make sure the se->load_avg|sum is correct before enqueue_load_avg. 
(3)Rework changlog.

 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..159274482c4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3829,10 +3829,12 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	se->avg.runnable_sum = se->avg.runnable_avg * divider;
 
-	se->avg.load_sum = divider;
-	if (se_weight(se)) {
+	se->avg.load_sum = se->avg.load_avg * divider;
+	if (se_weight(se) < se->avg.load_sum) {
 		se->avg.load_sum =
-			div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
+			div_u64(se->avg.load_sum, se_weight(se));
+	} else {
+		se->avg.load_sum = 1;
 	}
 
 	enqueue_load_avg(cfs_rq, se);
-- 
2.18.0

