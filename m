Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0762F502F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350058AbiDOTXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349213AbiDOTWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759C4ECDF;
        Fri, 15 Apr 2022 12:20:02 -0700 (PDT)
Message-ID: <20220415161206.817702355@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qYlJQfHkHU3OcbS1sZiLCAQudGl6ztMYHcAA/fZFZtk=;
        b=LGrEszF/kAbRdvl567m34oAJJwz6dSvwrSujKNtfqxO5EjZbvxWHXoa7KE4CADQ81/OLF+
        RW5qo5WMfL3b5HhfId8wAF/jGnftRn0wRUX1Ua4lA9yUqDXMYMlEcjJy1LKezycjjGGSgv
        ZetZKg6MxikTsS2pZrIkn/z86aqmMDTPIz1He9z6zajGmttD2jaWoNifRxOIl6brLYYBH2
        ws9U79kWuK4WGwDDRJNQdL0QJQFFV21//V9+fTxdT1C9JEZW+1l8Msv1tFAOv71/7UhgXN
        4x2hI2Rj5H/9Bb/D+kJdUTU04zYVIqolE0sMvLohIvfaMmx3puYP5rythOfPRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qYlJQfHkHU3OcbS1sZiLCAQudGl6ztMYHcAA/fZFZtk=;
        b=xY8Yx/ZD3ZaZx9KpDsiElK70nuaf4eZgpdAo75DVNrviEEvSAVT7PUlS2wbwCiCLjZ4pwl
        cYiTgYGA3aULu3Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 08/10] x86/aperfmperf: Store aperf/mperf data for cpu frequency reads
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 21:20:01 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the MSR readout is unconditional, store the results in the per CPU
data structure along with a jiffies timestamp for the CPU frequency readout
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/aperfmperf.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -24,11 +24,17 @@
 #include "cpu.h"
 
 struct aperfmperf {
+	seqcount_t	seq;
+	unsigned long	last_update;
+	u64		acnt;
+	u64		mcnt;
 	u64		aperf;
 	u64		mperf;
 };
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct aperfmperf, cpu_samples);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct aperfmperf, cpu_samples) = {
+	.seq = SEQCNT_ZERO(cpu_samples.seq)
+};
 
 struct aperfmperf_sample {
 	unsigned int	khz;
@@ -515,6 +521,12 @@ void arch_scale_freq_tick(void)
 	s->aperf = aperf;
 	s->mperf = mperf;
 
+	raw_write_seqcount_begin(&s->seq);
+	s->last_update = jiffies;
+	s->acnt = acnt;
+	s->mcnt = mcnt;
+	raw_write_seqcount_end(&s->seq);
+
 	scale_freq_tick(acnt, mcnt);
 }
 

