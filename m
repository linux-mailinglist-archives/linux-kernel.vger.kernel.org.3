Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9824FFF60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiDMTfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiDMTe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:34:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788EB76585;
        Wed, 13 Apr 2022 12:32:36 -0700 (PDT)
Date:   Wed, 13 Apr 2022 19:32:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649878355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iorNaHWnmbP15mgEIAifHH7Nvn7KVWv7GrX/fT9Fhg=;
        b=SDjahuni5frp/d8eGi7NGXhKJJgca52DhTGRqJghvjGuWV+Z9wy6fjQ6agd/Bqrw8Xhr3A
        hDny/qzNpK2/EtHkDWOldghdoA1IPw8H6glb1XlwGZsaVSGncLRCHEebRpxuuJk8CvBTAQ
        26f+k6FOotwkeIyx/R2O0k2wsoYUHLSNgNitI7MAxcT3p3qU1TinmCWZqE5v3wJp0IWuiO
        eaKZn2y7OzAztjY5HYDnZW3XXumylhoYbNSAsGMzQevTx56TE4HJr5uCrmPjBlFIv1pSO+
        r4yx+of3qDHQhiI677H7IToPzYoJ2lojcGgm/FDLM0loFCDWcVJ+4JlDnHChZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649878355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iorNaHWnmbP15mgEIAifHH7Nvn7KVWv7GrX/fT9Fhg=;
        b=ZyTrxx0hkn5OjKVf4CJbN55grN1ixO4TyvBSLWRc1MgWVLGZYaZWk21rFyXa6CGCoZ4Y45
        4KnGQmf4FIutOQCg==
From:   "tip-bot2 for Steven Price" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Initialise all cpuhp_cpu_state structs earlier
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220411152233.474129-3-steven.price@arm.com>
References: <20220411152233.474129-3-steven.price@arm.com>
MIME-Version: 1.0
Message-ID: <164987835389.4207.2665456331757900114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     d308077e5e4dc8c93f97f5ebc70274e7c7a92d49
Gitweb:        https://git.kernel.org/tip/d308077e5e4dc8c93f97f5ebc70274e7c7a92d49
Author:        Steven Price <steven.price@arm.com>
AuthorDate:    Mon, 11 Apr 2022 16:22:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Apr 2022 21:27:41 +02:00

cpu/hotplug: Initialise all cpuhp_cpu_state structs earlier

Rather than waiting until a CPU is first brought online, do the
initialisation of the cpuhp_cpu_state structure for each CPU during the
__init phase. This saves a (small) amount of non-__init memory and
avoids potential confusion about when the cpuhp_cpu_state struct is
valid.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220411152233.474129-3-steven.price@arm.com

---
 kernel/cpu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0..02a77ac 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -716,14 +716,6 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
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
@@ -883,15 +875,27 @@ static int cpuhp_kick_ap_work(unsigned int cpu)
 
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
