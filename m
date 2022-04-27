Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D519512163
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiD0SqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiD0SqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:46:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C72E7A998;
        Wed, 27 Apr 2022 11:27:25 -0700 (PDT)
Date:   Wed, 27 Apr 2022 18:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651084044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeSoISKEydPM4LAhn8UqmgfRicAEvFi1E2X9P5Nf5xI=;
        b=TUa51QK1AefrxkP2b8m0e72wdlGIXdgvfJ3fOVutoEAbrrxykzXcQ4lL6+5+1c9xJEzCK+
        4t4V04pUL/wHTZ5kxqQoJue6sEM7Xguqx7yUTq8BMyzoFJY4BmtunoeqBShjuJ9mZvZD2I
        OyKDjWGZuKKSO684LkrP/tiAKLWZALIFWDyd3NYxFw0GaX5MHbfaXPrxcb+UAU/AJoDWBA
        Kk16JjNvgpTEGUnSSSzAbemuOPi8cxSsJmxWI7m5NaRL4KaNU8CrxBPraKyJcDDZJO906G
        jfZyTCz8Agd6x3Aac+ue2OW97F4SdpD5/5IhwZA75Zn+xJOvW5QizYrIrqdPkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651084044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeSoISKEydPM4LAhn8UqmgfRicAEvFi1E2X9P5Nf5xI=;
        b=wRCVNkaHB/5gPsrykRXg7w+Rw+xjaiZl+fmTyahZBOAKpakkegt7Z+YpbvvQC1bnii/S0o
        GiZ1YO24fZzl+xBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Store aperf/mperf data for cpu
 frequency reads
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.817702355@linutronix.de>
References: <20220415161206.817702355@linutronix.de>
MIME-Version: 1.0
Message-ID: <165108404302.4207.11864273936460943270.tip-bot2@tip-bot2>
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

Commit-ID:     cd8c0e142daf9de9ce594e61b75509b0af7bfb26
Gitweb:        https://git.kernel.org/tip/cd8c0e142daf9de9ce594e61b75509b0af7bfb26
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:20:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 20:22:19 +02:00

x86/aperfmperf: Store aperf/mperf data for cpu frequency reads

Now that the MSR readout is unconditional, store the results in the per CPU
data structure along with a jiffies timestamp for the CPU frequency readout
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.817702355@linutronix.de

---
 arch/x86/kernel/cpu/aperfmperf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index df528a4..963c069 100644
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
 
