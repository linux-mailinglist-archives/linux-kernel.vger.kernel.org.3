Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7349559B779
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiHVCPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiHVCPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:15:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84BF1ADB4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:15:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f4so6336403pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=x9NaAeROHZ7LhGtDm+xAwRDta8yhQJ2bsdPkhebtaWw=;
        b=pMEHVg3KR0sN9NGoqjvIgRr6fD7XlQcRjsdBCXfbEFn4iPueTdqI39iongNLewhgZm
         5Yl9Ix74qU/T2+HSYgmP5ZGBWOXYyxLBrBu/xr5O+ZfIQm1eBlhkQmCqNc5pRV4+iFec
         qJ/j5OCOCVKJbTmJm3l+1277BSCQ1B35i6/jvE+1S7o8WcZSHxPZRsHogWF7JqhkWXXJ
         kwdXYEX5ialtSx7SQgWrrvKOqG+XKcs+0ERhl9H0ViTXR+skSQfZPfFfjMLGFZikdL1L
         XIsyCNvBBYDIx+nQJy5sBAx6RMg4PzcXHRgdEoGcBARFp0TViruF7MiMk/KeO5nLndT/
         ne1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x9NaAeROHZ7LhGtDm+xAwRDta8yhQJ2bsdPkhebtaWw=;
        b=yYNP05iGrF+p3oUK9EOavAht8vwSPj9B2128O+ic9Z2BXF1fZkg8sOISmumhLUTaRf
         fU2bJeoDKX3l8BQ88/S34UOuEmwG3GZMDLF8dqLps1gy+MCzP6Sjde2+sH1mNaKnWZ0i
         eDDS/d4G0KKrcDDKq2TWI26lYhELRhsLPkHYcnt7UUWfJaa+7BXAwXxv5psCz+C/cfBk
         JLelQboHY1pt/knUun7rZ2D2aHpZMVZ4D3VkaiAZ7UStSXG3pEz0l0AOu7gEPHnXugyw
         QDLfN9VhVmOyX6Cnv6KpBYM6IgkJoxQuWRdRYQ6LDRM2avTc5xfMoNiky5MmbVk3hnuR
         uf2w==
X-Gm-Message-State: ACgBeo2DGuGKwnSytE1EhkvywG4fX76flTqLK1iqajNqFWVl1fmlVMOn
        7AM/7QXefUex7khI+AbTBWPpE79j8g==
X-Google-Smtp-Source: AA6agR7RX6fx2qhb0rc0+ZwauaxrA5pmHSuMao+E6pjhPa0oIdQZg0lPlRAGozGxhe9QjxOTvIsKcA==
X-Received: by 2002:a63:4d65:0:b0:419:d6ae:27df with SMTP id n37-20020a634d65000000b00419d6ae27dfmr15477909pgl.179.1661134537236;
        Sun, 21 Aug 2022 19:15:37 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:15:36 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC 01/10] cpu/hotplug: Make __cpuhp_kick_ap() ready for async
Date:   Mon, 22 Aug 2022 10:15:11 +0800
Message-Id: <20220822021520.6996-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, during the kexec reboot, the teardown of cpus can not run in
parallel. As the first step towards the parallel, it demands the
initiator to kick ap thread one by one instead of waiting for each ap
thread completion.

Change the prototype of __cpuhp_kick_ap() to cope with this demand.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>
Cc: "Peter Zijlstra
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
---
 kernel/cpu.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..338e1d426c7e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -526,7 +526,7 @@ cpuhp_reset_state(int cpu, struct cpuhp_cpu_state *st,
 }
 
 /* Regular hotplug invocation of the AP hotplug thread */
-static void __cpuhp_kick_ap(struct cpuhp_cpu_state *st)
+static void __cpuhp_kick_ap(struct cpuhp_cpu_state *st, bool sync)
 {
 	if (!st->single && st->state == st->target)
 		return;
@@ -539,20 +539,22 @@ static void __cpuhp_kick_ap(struct cpuhp_cpu_state *st)
 	smp_mb();
 	st->should_run = true;
 	wake_up_process(st->thread);
-	wait_for_ap_thread(st, st->bringup);
+	if (sync)
+		wait_for_ap_thread(st, st->bringup);
 }
 
 static int cpuhp_kick_ap(int cpu, struct cpuhp_cpu_state *st,
-			 enum cpuhp_state target)
+		enum cpuhp_state target, bool sync)
 {
 	enum cpuhp_state prev_state;
 	int ret;
 
 	prev_state = cpuhp_set_state(cpu, st, target);
-	__cpuhp_kick_ap(st);
-	if ((ret = st->result)) {
+	__cpuhp_kick_ap(st, sync);
+	ret = st->result;
+	if (sync && ret) {
 		cpuhp_reset_state(cpu, st, prev_state);
-		__cpuhp_kick_ap(st);
+		__cpuhp_kick_ap(st, true);
 	}
 
 	return ret;
@@ -583,7 +585,7 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	if (st->target <= CPUHP_AP_ONLINE_IDLE)
 		return 0;
 
-	return cpuhp_kick_ap(cpu, st, st->target);
+	return cpuhp_kick_ap(cpu, st, st->target, true);
 }
 
 static int bringup_cpu(unsigned int cpu)
@@ -835,7 +837,7 @@ cpuhp_invoke_ap_callback(int cpu, enum cpuhp_state state, bool bringup,
 	st->cb_state = state;
 	st->single = true;
 
-	__cpuhp_kick_ap(st);
+	__cpuhp_kick_ap(st, true);
 
 	/*
 	 * If we failed and did a partial, do a rollback.
@@ -844,7 +846,7 @@ cpuhp_invoke_ap_callback(int cpu, enum cpuhp_state state, bool bringup,
 		st->rollback = true;
 		st->bringup = !bringup;
 
-		__cpuhp_kick_ap(st);
+		__cpuhp_kick_ap(st, true);
 	}
 
 	/*
@@ -868,12 +870,29 @@ static int cpuhp_kick_ap_work(unsigned int cpu)
 	cpuhp_lock_release(true);
 
 	trace_cpuhp_enter(cpu, st->target, prev_state, cpuhp_kick_ap_work);
-	ret = cpuhp_kick_ap(cpu, st, st->target);
+	ret = cpuhp_kick_ap(cpu, st, st->target, true);
 	trace_cpuhp_exit(cpu, st->state, prev_state, ret);
 
 	return ret;
 }
 
+/* In the async case, trace is meaningless since ret value is not available */
+static int cpuhp_kick_ap_work_async(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+	int ret;
+
+	cpuhp_lock_acquire(false);
+	cpuhp_lock_release(false);
+
+	cpuhp_lock_acquire(true);
+	cpuhp_lock_release(true);
+
+	ret = cpuhp_kick_ap(cpu, st, st->target, false);
+
+	return ret;
+}
+
 static struct smp_hotplug_thread cpuhp_threads = {
 	.store			= &cpuhp_state.thread,
 	.thread_should_run	= cpuhp_should_run,
@@ -1171,7 +1190,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	if (ret && st->state < prev_state) {
 		if (st->state == CPUHP_TEARDOWN_CPU) {
 			cpuhp_reset_state(cpu, st, prev_state);
-			__cpuhp_kick_ap(st);
+			__cpuhp_kick_ap(st, true);
 		} else {
 			WARN(1, "DEAD callback error for CPU%d", cpu);
 		}
-- 
2.31.1

