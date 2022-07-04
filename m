Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A311C5650F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiGDJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiGDJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:32:54 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A0BFBC99
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:31:50 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 530D81E80CD1;
        Mon,  4 Jul 2022 17:29:53 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lDAh5dXbYv1W; Mon,  4 Jul 2022 17:29:50 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id CB6061E80C90;
        Mon,  4 Jul 2022 17:29:49 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, hannes@cmpxchg.org,
        surenb@google.com
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] sched: remove unnecessary type castings.
Date:   Mon,  4 Jul 2022 17:30:41 +0800
Message-Id: <20220704093041.18697-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 kernel/sched/membarrier.c | 2 +-
 kernel/sched/psi.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 0c5be7ebb1dc..08b120f11180 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -198,7 +198,7 @@ static void ipi_rseq(void *info)
 
 static void ipi_sync_rq_state(void *info)
 {
-	struct mm_struct *mm = (struct mm_struct *) info;
+	struct mm_struct *mm = info;
 
 	if (current->mm != mm)
 		return;
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a337f3e35997..9a67538e4403 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -634,7 +634,7 @@ static void psi_poll_work(struct psi_group *group)
 
 static int psi_poll_worker(void *data)
 {
-	struct psi_group *group = (struct psi_group *)data;
+	struct psi_group *group = data;
 
 	sched_set_fifo_low(current);
 
-- 
2.11.0

