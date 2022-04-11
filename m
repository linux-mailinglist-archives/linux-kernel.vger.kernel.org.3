Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FFB4FC067
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347876AbiDKPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347841AbiDKPZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37F7F3B57F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:22:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEBEB169E;
        Mon, 11 Apr 2022 08:22:46 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.40.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 466053F73B;
        Mon, 11 Apr 2022 08:22:45 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
        Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 2/2] cpu/hotplug: Initialise all cpuhp_cpu_state structs earlier
Date:   Mon, 11 Apr 2022 16:22:33 +0100
Message-Id: <20220411152233.474129-3-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411152233.474129-1-steven.price@arm.com>
References: <20220411152233.474129-1-steven.price@arm.com>
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

Rather than waiting until a CPU is first brought online, do the
initialisation of the cpuhp_cpu_state structure for each CPU during the
__init phase. This saves a (small) amount of non-__init memory and
avoids potential confusion about when the cpuhp_cpu_state struct is
valid.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 kernel/cpu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5601216eb51b..65903cb10a55 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -715,14 +715,6 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 /*
  * The cpu hotplug threads manage the bringup and teardown of the cpus
  */
-static void cpuhp_create(unsigned int cpu)
-{
-	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
-
-	init_completion(&st->done_up);
-	init_completion(&st->done_down);
-}
-
 static int cpuhp_should_run(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
@@ -882,15 +874,27 @@ static int cpuhp_kick_ap_work(unsigned int cpu)
 
 static struct smp_hotplug_thread cpuhp_threads = {
 	.store			= &cpuhp_state.thread,
-	.create			= &cpuhp_create,
 	.thread_should_run	= cpuhp_should_run,
 	.thread_fn		= cpuhp_thread_fun,
 	.thread_comm		= "cpuhp/%u",
 	.selfparking		= true,
 };
 
+static __init void cpuhp_init_state(void)
+{
+	struct cpuhp_cpu_state *st;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		st = per_cpu_ptr(&cpuhp_state, cpu);
+		init_completion(&st->done_up);
+		init_completion(&st->done_down);
+	}
+}
+
 void __init cpuhp_threads_init(void)
 {
+	cpuhp_init_state();
 	BUG_ON(smpboot_register_percpu_thread(&cpuhp_threads));
 	kthread_unpark(this_cpu_read(cpuhp_state.thread));
 }
-- 
2.25.1

