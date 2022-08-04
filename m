Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE7B589C73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbiHDNSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiHDNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3098D6D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659619088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zqYcdlmHUUwquW0dxoj7mBY8myWwdX9cNcFb5HKeTQs=;
        b=VXtZ12689/nDeShSf1dCwQxzMk8Sf5SWZ6yqz85m+qRQLuxARypBJTl3tJfoHgKMvvhNZ1
        vsotcKIEsfnIq1OXKhOw29jQUZLsaNcuJXkFeBHFcjOCbLWLtJdXCHI/Dh17n+yk79dYxD
        q2nTnC6v0OO7sYLR29qCIondgn8gzdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-oSXp58leMg-WIr6svVffCA-1; Thu, 04 Aug 2022 09:18:05 -0400
X-MC-Unique: oSXp58leMg-WIr6svVffCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D1188032F6;
        Thu,  4 Aug 2022 13:18:05 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.35.206.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B2C40CF8EA;
        Thu,  4 Aug 2022 13:18:01 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com, pauld@redhat.com,
        frederic@kernel.org, ggherdovich@suse.cz,
        linux-kernel@vger.kernel.org, lenb@kernel.org, vschneid@redhat.com,
        jlelli@redhat.com, mtosatti@redhat.com, ppandit@redhat.com,
        alougovs@redhat.com, lcapitul@redhat.com, nsaenz@kernel.org
Cc:     ypodemsk@redhat.com
Subject: [PATCH] x86/aperfmperf: Fix arch_scale_freq_tick() on tickless systems
Date:   Thu,  4 Aug 2022 16:17:28 +0300
Message-Id: <20220804131728.58513-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the scheduler to be frequency invariant we measure the
ratio between the maximum cpu frequency and the actual cpu frequency.
During long tickless periods of time the calculations that keep track
of that might overflow, in the function scale_freq_tick():

if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
»       goto error;

eventually forcing the kernel to disable the feature with the
message "Scheduler frequency invariance went wobbly, disabling!".
Let's avoid that by detecting long tickless periods and bypassing
the calculation for that tick.

This calculation updates the value of arch_freq_scale, used by the
capacity-aware scheduler to correct cpu duty cycles:
task_util_freq_inv(p) = duty_cycle(p) * (curr_frequency(cpu) /
max_frequency(cpu))

However Consider a long tickless period, It takes should take 60 minutes
for a tickless CPU running at 5GHz to trigger the acnt overflow,
pick 10 minutes as a staleness threshold to be on the safe side,
In our testing it took over 30 minutes for the overflow to happen,
but since it's frequency/platform dependent we choose a smaller value
to be on the safe side.

Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 1f60a2b27936..dfe356034a60 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -23,6 +23,13 @@
 
 #include "cpu.h"
 
+/*
+ * Samples older then 10 minutes should not be proccessed,
+ * This time is long enough to prevent unneeded drops of data
+ * But short enough to prevent overflows
+ */
+#define MAX_SAMPLE_AGE_NOHZ	((unsigned long)HZ * 600)
+
 struct aperfmperf {
 	seqcount_t	seq;
 	unsigned long	last_update;
@@ -373,6 +380,7 @@ static inline void scale_freq_tick(u64 acnt, u64 mcnt) { }
 void arch_scale_freq_tick(void)
 {
 	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
+	unsigned long last  = s->last_update;
 	u64 acnt, mcnt, aperf, mperf;
 
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
@@ -392,7 +400,12 @@ void arch_scale_freq_tick(void)
 	s->mcnt = mcnt;
 	raw_write_seqcount_end(&s->seq);
 
-	scale_freq_tick(acnt, mcnt);
+	/*
+	 * Avoid calling scale_freq_tick() when the last update was too long ago,
+	 * as it might overflow during calulation.
+	 */
+	if ((jiffies - last) <= MAX_SAMPLE_AGE_NOHZ)
+		scale_freq_tick(acnt, mcnt);
 }
 
 /*
-- 
2.31.1

