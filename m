Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25F15119E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiD0N7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiD0N70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9DD3BA79;
        Wed, 27 Apr 2022 06:56:10 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4Jo1stc5NQwG0wIBJ90XoQtjZXwg8qeTJ2C81OpCFA=;
        b=CyqHFrbhxzN+4pmGAu83C09/EzG/EbFLdEvY/xJgsjdGUsvvIe59Pet7SST1wY0d9qvXc6
        4wtev2MFpmrl3wL6+rMnwrZpsLBCyTeKgDTB8y+coJx7cqyj8BxSTk20rm00tyDLD5p1Y1
        t2GkJG03X++PG3vAtOjsS/aVK7JRT95YLNHUguzzBYGMVZCPiKi4EnyDVE7OMfQyFlqklY
        bIKlgWjdFOrjVXD2zZbGZO2I7RzVfPqnRsjhjDH7AFrCXegVenylI9qj3TfpCn6DsOeS+T
        RNOtpS5TQgQ82lIXGivWbFr+EiVwvW3BcGuBT3EIE2mbyOhBRzVArY51ixTE0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4Jo1stc5NQwG0wIBJ90XoQtjZXwg8qeTJ2C81OpCFA=;
        b=fn2XBbtKhuhb5KtNlvF/UObpw1tpA3rhYOkkfQG423LS4zSwxbEIweEuELN93rgH0arM1o
        RDimetpNCQLMpVAg==
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
Message-ID: <165106776778.4207.11312672097188195289.tip-bot2@tip-bot2>
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

Commit-ID:     3b1fc17f635164d74934f67d3bb46cdf877fb67f
Gitweb:        https://git.kernel.org/tip/3b1fc17f635164d74934f67d3bb46cdf877fb67f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:20:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:08 +02:00

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
 
