Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A34DB506
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbiCPPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbiCPPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:38:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502C76D1B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:37:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16BB51476;
        Wed, 16 Mar 2022 08:37:26 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.43.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 560793F7D7;
        Wed, 16 Mar 2022 08:37:24 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v2] cpu/hotplug: Set st->cpu earlier
Date:   Wed, 16 Mar 2022 15:36:37 +0000
Message-Id: <20220316153637.288199-1-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the 'cpu' member of struct cpuhp_cpu_state in cpuhp_create() is
too late as other callbacks can be made before that point. In particular
if one of the earlier callbacks fails and triggers a rollback that
rollback will be done with st->cpu==0 causing CPU0 to be erroneously set
to be dying, causing the scheduler to get mightily confused and throw
its toys out of the pram.

Move the assignment earlier before any callbacks have a chance to run.

Fixes: 2ea46c6fc945 ("cpumask/hotplug: Fix cpu_dying() state tracking")
Signed-off-by: Steven Price <steven.price@arm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
Changes since v1[1]:

 * Added a Fixes: tag.
 * Moved the assignment to just before cpuhp_set_state() which is the
   first place it is needed.

[1]: https://lore.kernel.org/r/20220225134918.105796-1-steven.price%40arm.com

 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35e..c1324c8677cf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -720,7 +720,6 @@ static void cpuhp_create(unsigned int cpu)
 
 	init_completion(&st->done_up);
 	init_completion(&st->done_down);
-	st->cpu = cpu;
 }
 
 static int cpuhp_should_run(unsigned int cpu)
@@ -1351,6 +1350,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 
 	cpuhp_tasks_frozen = tasks_frozen;
 
+	st->cpu = cpu;
 	cpuhp_set_state(st, target);
 	/*
 	 * If the current CPU state is in the range of the AP hotplug thread,
-- 
2.25.1

