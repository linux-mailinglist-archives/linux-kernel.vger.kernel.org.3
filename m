Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1E47EA20
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbhLXBWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:22:44 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:53614 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S245155AbhLXBWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:22:43 -0500
X-UUID: d1b0cde0f1974c7b9b841b7003a60278-20211224
X-UUID: d1b0cde0f1974c7b9b841b7003a60278-20211224
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yt.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1894363230; Fri, 24 Dec 2021 09:22:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 24 Dec 2021 09:22:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Dec 2021 09:22:40 +0800
From:   YT Chang <yt.chang@mediatek.com>
To:     YT Chang <yt.chang@mediatek.com>, Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH 1/1] sched: Add update_rq_clock() in sched_rt_rq_enqueue()
Date:   Fri, 24 Dec 2021 09:22:39 +0800
Message-ID: <20211224012239.4694-1-yt.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add update_rq_clock() in sched_rt_rq_enqueue() to
prevent the warning "rq->clock_update_flags < RQCF_ACT_SKIP"
when call rq_clock() in cpufreq_update_util().

sched_rt_rq_enqueue ->
   enqueue_top_rt_rq ->
      cpufreq_update_util ->
         rq_clock ->
            assert_clock_updated

Signed-off-by: YT Chang <yt.chang@mediatek.com>
Change-Id: I4fba5a561b7064aafa991d7f1a34431607779cb4
---
 kernel/sched/rt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b48baaba2fc2..faf1a68c0723 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -539,6 +539,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 
 	int cpu = cpu_of(rq);
 
+	update_rq_clock(rq);
 	rt_se = rt_rq->tg->rt_se[cpu];
 
 	if (rt_rq->rt_nr_running) {
-- 
2.18.0

