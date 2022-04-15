Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE0502F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349959AbiDOTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiDOTW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A749F3E5F2;
        Fri, 15 Apr 2022 12:19:59 -0700 (PDT)
Message-ID: <20220415161206.706185092@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FTV8lnVO85bSeErs2BRV8ovYyYYdf2QvdWY7WdpkMVY=;
        b=QM69v4F9Rs7cCn1x18m1a4OxD9Wo9tW8sYaLQpsfNJhJvEsCvtaLjIf5wzAxmtOiOs/z29
        be1ejBwTW5za5cEagfS/MuWS107TDCk+dD33oL8ZJ1XRejRxFNyf50ex3dh10ZDLa15V2t
        uj96a8RxvryGzp69MlN9pLDIdCzMLleQdoll5JS2qfV2Eeh7QkWPIyc6CLAaMw0KE2QnST
        NJ0ieovXJEuI21z12g1JXJTfI59dBXPpJ0AFLH3jFh8qU55Sf30JQdcYCc33b3YIb2qXt6
        r1zS6b/oZK6rsqCw7n71TdURWVLJVzylhpzydkN4Ua9tBZkfLAJd8fa2biePhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FTV8lnVO85bSeErs2BRV8ovYyYYdf2QvdWY7WdpkMVY=;
        b=F+kg3SLCvyNvc7RHgfJ3DzCpfJqGJFaGISAoYOFiYoLzj4TyGiKBd75Ir9QVn1X2RYGjEp
        T4pRaaZcFoxqKXCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 06/10] x86/aperfmperf: Restructure arch_scale_freq_tick()
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 21:19:57 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparation for sharing code with the CPU frequency portion of the
aperf/mperf code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/aperfmperf.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -477,22 +477,9 @@ static DECLARE_WORK(disable_freq_invaria
 
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
@@ -514,4 +501,23 @@ void arch_scale_freq_tick(void)
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

