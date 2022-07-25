Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E957FCCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiGYKBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:01:18 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E717050
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:01:17 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so3841844wmp.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=x6zj9dOUlwsktzeSDIEkLHb9SDr39sJpasZT1X33xZI=;
        b=WavWtNUzTBLkpi/s/5kacp5nCbQ35dPI5DhNPtn7NAc7Ez7xeWpgndhR1zr0X6EdnB
         XVFhbb1FwMULG9POCdVxZEcJ+1U2MBNSnmNn/LUv+x7LEQM3bM7ogGbGV6+JFqOAOrvT
         qukpGI6NwWYTp5x2eQ5ldBVr90cyX1M4v3TKA0q3KSfeQlbwhOM7eO/Pi+v/B+iyCALT
         MgJAIUtmawLOOMjanIrNMKRl+t2ouc6ZA/CAYZtyQ1N7L31yKfSouKUanrzA13++EprW
         2RUqWr0Gvi6XYut6RyAX9RzQRxSvCVGmUw5ZRCm1BAMGtPPbGaLTru+GwqDejYJqkMmK
         p5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=x6zj9dOUlwsktzeSDIEkLHb9SDr39sJpasZT1X33xZI=;
        b=IZRa/yX6UIHQn7SsJocl3GhR2bHAbWKvx3d+dSAgpsNNwRFeuD6eQv9Zv0wQQb8E5Q
         qVrWxK0h5edIi2U7Zo8yP1i8aStguLKdK7gtWnpcvm5i7Zn3mtz7x5v6DfJ9tOZWZhX3
         xItSDTRcQavobBFK7Rik/bMfMn+pQDb9qt7i/4HS6SU/uygHLgUt5Jkfm/4PG3NEmmZU
         lKP3ULjwf7+2Pd3PToVjcymM74iQKqVuawMpBDZSPgluVt2cn9aZpnzhXj4NLJo80A7l
         1X07FaV6/hZVTfeGU+6YjlIMgFLJDXH9kFE3SLQZsJ/C28rZ8dILRpJt2pgNo0HL9ZhQ
         sF/Q==
X-Gm-Message-State: AJIora9wWc0tjuCmM/xDoiq8yhBj2Gw73edhCjCJhNKoNL8jFZB6nIGc
        9vydg1vGV3aa3S0ZGYSwhsGA4gkDS5fH8g4G
X-Google-Smtp-Source: AGRyM1vikja+ct9HXN3TBKQE8K65Nty78FVtCMo6YooH6lpffxidNNiaiTdNPk1ALM9Hm0b5F8c1Z06vCuZELqDm
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP
 id a4-20020adffb84000000b0021a10f21661mr7032242wrr.2.1658743275571; Mon, 25
 Jul 2022 03:01:15 -0700 (PDT)
Date:   Mon, 25 Jul 2022 10:59:52 +0100
Message-Id: <20220725095952.206884-1-vdonnefort@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v5] cpu/hotplug: Do not bail-out in DYING/STARTING sections
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, vschneid@redhat.com,
        regressions@leemhuis.info, kernel-team@android.com,
        Vincent Donnefort <vdonnefort@google.com>,
        Derek Dolney <z23@posteo.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DYING/STARTING callbacks are not expected to fail. However, as reported
by Derek, drivers such as tboot are still free to return errors within
those sections, which halts the hot(un)plug and leaves the CPU in an
unrecoverable state.

No rollback being possible there, let's only log the failures and proceed
with the following steps. This restores the hotplug behaviour prior to
commit 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
Reported-by: Derek Dolney <z23@posteo.net>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Derek Dolney <z23@posteo.net>

v4 -> v5:
   - Remove WARN, only log broken states with pr_warn.
v3 -> v4:
   - Sorry ... wrong commit description style ...
v2 -> v3:
   - Tested-by tag.
   - Refine commit description.
   - Bugzilla link.
v1 -> v2:
   - Commit message rewording.
   - More details in the warnings.
   - Some variable renaming

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..621e5af42d57 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -663,21 +663,51 @@ static bool cpuhp_next_state(bool bringup,
 	return true;
 }
 
-static int cpuhp_invoke_callback_range(bool bringup,
-				       unsigned int cpu,
-				       struct cpuhp_cpu_state *st,
-				       enum cpuhp_state target)
+static int __cpuhp_invoke_callback_range(bool bringup,
+					 unsigned int cpu,
+					 struct cpuhp_cpu_state *st,
+					 enum cpuhp_state target,
+					 bool nofail)
 {
 	enum cpuhp_state state;
-	int err = 0;
+	int ret = 0;
 
 	while (cpuhp_next_state(bringup, &state, st, target)) {
+		int err;
+
 		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
-		if (err)
+		if (!err)
+			continue;
+
+		if (nofail) {
+			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
+				cpu, bringup ? "UP" : "DOWN",
+				cpuhp_get_step(st->state)->name,
+				st->state, err);
+			ret = -1;
+		} else {
+			ret = err;
 			break;
+		}
 	}
 
-	return err;
+	return ret;
+}
+
+static inline int cpuhp_invoke_callback_range(bool bringup,
+					      unsigned int cpu,
+					      struct cpuhp_cpu_state *st,
+					      enum cpuhp_state target)
+{
+	return __cpuhp_invoke_callback_range(bringup, cpu, st, target, false);
+}
+
+static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
+						      unsigned int cpu,
+						      struct cpuhp_cpu_state *st,
+						      enum cpuhp_state target)
+{
+	__cpuhp_invoke_callback_range(bringup, cpu, st, target, true);
 }
 
 static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
@@ -999,7 +1029,6 @@ static int take_cpu_down(void *_param)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int err, cpu = smp_processor_id();
-	int ret;
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
@@ -1012,13 +1041,11 @@ static int take_cpu_down(void *_param)
 	 */
 	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
 
-	/* Invoke the former CPU_DYING callbacks */
-	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
-
 	/*
+	 * Invoke the former CPU_DYING callbacks
 	 * DYING must not fail!
 	 */
-	WARN_ON_ONCE(ret);
+	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
 
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
@@ -1296,16 +1323,14 @@ void notify_cpu_starting(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
-	int ret;
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
-	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
 
 	/*
 	 * STARTING must not fail!
 	 */
-	WARN_ON_ONCE(ret);
+	cpuhp_invoke_callback_range_nofail(true, cpu, st, target);
 }
 
 /*
-- 
2.37.1.359.gd136c6c3e2-goog

