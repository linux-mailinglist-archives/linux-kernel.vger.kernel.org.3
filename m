Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD044F0B43
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359437AbiDCQfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349759AbiDCQf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:35:28 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FDA11140
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:33:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649003607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rj22f0kFZ7NUcXO468exbIwbC8edz8OwX/wtkMZHahM=;
        b=YGfztAsTroxPMmfd7BhFy+VreKT9Cj3uBXpixs7sK5SIUG2AkJWzDMHF5LgxD/4x+R8bHf
        rPUdjv3duUMwAOU2DH7L7rE01gyF5nHWx3f63zaMeaHpiB6eN8sglGc6MUE/IAVxekWTb4
        QX/xbsBQpm7zcAGD7hWyBk6OxOEdVTk=
From:   Tao Zhou <tao.zhou@linux.dev>
To:     linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: [PATCH] sched/fair: Minor making update_blocked_load_status() be able to set has_blocked_load to 1
Date:   Mon,  4 Apr 2022 00:33:38 +0800
Message-Id: <20220403163338.6341-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I realize that newidle_balance() can not set rq->has_blocked_load to 1
when it has block load. When no task pulled then nohz_newidle_balance()
will set flag NOHZ_NEWILB_KICK to trigger ILB. In do_idle(),
nohz_run_idle_balance() will call _nohz_idle_balance() to update status
using update_nohz_stats() to make sure there has blocked load. If it is
not set in newidle_balance(), update_nohz_stats() will exit early and do
not do update_blocked_averages()(time spent from newidle_balance() to
update_nohz_stats will not be used to update load avg). There has
chance to call cpuidle_idle_call() to set  has_blocked_load to 1 and
can also update later but if cpuidle_idle_call() is not called, the
lost update in nohz_run_idle_balance() will not be permitted that me not
thoroughly think. I know this is likely a invalid commit log.
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..fc8765792a77 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8091,7 +8091,9 @@ static inline void update_blocked_load_tick(struct rq *rq)
 
 static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
 {
-	if (!has_blocked)
+	if (has_blocked)
+		rq->has_blocked_load = 1;
+	else
 		rq->has_blocked_load = 0;
 }
 #else
@@ -10597,7 +10599,7 @@ void nohz_balance_enter_idle(int cpu)
 	 * If a clear happens, it will have evaluated last additions because
 	 * rq->lock is held during the check and the clear
 	 */
-	rq->has_blocked_load = 1;
+	update_blocked_load_status(rq, 1);
 
 	/*
 	 * The tick is still stopped but load could have been added in the
-- 
2.35.1

