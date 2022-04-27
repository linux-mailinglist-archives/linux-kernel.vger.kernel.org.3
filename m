Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA05119C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiD0OAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiD0N70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4963C737;
        Wed, 27 Apr 2022 06:56:13 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nD7wqaAXOKu9sWXG9e3/EczN5MVFaW4VaMKCsF1lfYo=;
        b=HuTPEjIJY3Gy3HA/+2khsW5JSlYGP1mYCc4E4FcxZLky2sYUFUQBzMa0rmeROxR7YKkAT7
        uRA9idZ/5QduqMoeO1gaF+pPif5RcwkgRxxbuHu/fKFutKfJkPzosNu6wRqM7grSy/ulXI
        qYlqs5GHVq9QKdcveBeIcB4uk9lQ/UdU+YnCn8vCMeSuzxAKc7/0djnEjDQJqQXfT4EbPg
        AtXVGXJt7dlB2aoRAkSmlzXCzgOWbE9TCCaAqjJR+wI+b3g2hzBzfyjDAlM/g2AE91jgFB
        ZcePY7qK8NvU2ULOxdkdSMhuyBk0KwwNvZWSnoZYuXeZqmsWwKfcDdunuUlq0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nD7wqaAXOKu9sWXG9e3/EczN5MVFaW4VaMKCsF1lfYo=;
        b=1vt+T052p8w7ZnzI02Jdv7TqGjfT9GJVuL7AU9JUSZxuZ36+W6uzOGdo/baZiNXpesR2aD
        cyaZXjkf/vAgljCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Restructure arch_scale_freq_tick()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.706185092@linutronix.de>
References: <20220415161206.706185092@linutronix.de>
MIME-Version: 1.0
Message-ID: <165106776964.4207.8880773870704437659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     76225ca3666c5b05afb8dcc18a73f002b097af24
Gitweb:        https://git.kernel.org/tip/76225ca3666c5b05afb8dcc18a73f002b097af24
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:19:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:08 +02:00

x86/aperfmperf: Restructure arch_scale_freq_tick()

Preparation for sharing code with the CPU frequency portion of the
aperf/mperf code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.706185092@linutronix.de

---
 arch/x86/kernel/cpu/aperfmperf.c | 36 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 6922c77..6220503 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -477,22 +477,9 @@ static DECLARE_WORK(disable_freq_invariance_work,
 
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
-void arch_scale_freq_tick(void)
+static void scale_freq_tick(u64 acnt, u64 mcnt)
 {
-	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
-	u64 aperf, mperf, acnt, mcnt, freq_scale;
-
-	if (!arch_scale_freq_invariant())
-		return;
-
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
-
-	acnt = aperf - s->aperf;
-	mcnt = mperf - s->mperf;
-
-	s->aperf = aperf;
-	s->mperf = mperf;
+	u64 freq_scale;
 
 	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
 		goto error;
@@ -514,4 +501,23 @@ error:
 	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
 	schedule_work(&disable_freq_invariance_work);
 }
+
+void arch_scale_freq_tick(void)
+{
+	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
+	u64 acnt, mcnt, aperf, mperf;
+
+	if (!arch_scale_freq_invariant())
+		return;
+
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+	acnt = aperf - s->aperf;
+	mcnt = mperf - s->mperf;
+
+	s->aperf = aperf;
+	s->mperf = mperf;
+
+	scale_freq_tick(acnt, mcnt);
+}
 #endif /* CONFIG_X86_64 && CONFIG_SMP */
