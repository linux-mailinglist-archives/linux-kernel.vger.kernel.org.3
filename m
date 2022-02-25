Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8264C46E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiBYNuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiBYNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:49:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02A441DDFC3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:49:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1E0712FC;
        Fri, 25 Feb 2022 05:49:27 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.32.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7F093F5A1;
        Fri, 25 Feb 2022 05:49:25 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH] cpu/hotplug: Set st->cpu earlier
Date:   Fri, 25 Feb 2022 13:49:18 +0000
Message-Id: <20220225134918.105796-1-steven.price@arm.com>
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

Signed-off-by: Steven Price <steven.price@arm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
This was initially triggered by a VM which didn't have enough memory for
its VCPUs, but an easier way of triggering it is to make a change like
below in __smpboot_create_thread (as suggested by Dietmar Eggemann) to
pretend the memory allocation fails for a particular CPU:

 	td = kzalloc_node(sizeof(*td), GFP_KERNEL, cpu_to_node(cpu));
-	if (!td)
+	if (!td || cpu == 1)
 		return -ENOMEM;

I'm not entirely sure quite where the best place to set st->cpu is, so
please do let me know if there's a better place to do the assignment.
---
 kernel/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35e..49c3ef6067e5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -720,7 +720,6 @@ static void cpuhp_create(unsigned int cpu)
 
 	init_completion(&st->done_up);
 	init_completion(&st->done_down);
-	st->cpu = cpu;
 }
 
 static int cpuhp_should_run(unsigned int cpu)
@@ -1333,6 +1332,8 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 		goto out;
 	}
 
+	st->cpu = cpu;
+
 	/*
 	 * The caller of cpu_up() might have raced with another
 	 * caller. Nothing to do.
-- 
2.25.1

