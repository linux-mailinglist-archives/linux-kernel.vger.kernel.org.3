Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB455656B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiGDNOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiGDNOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:14:08 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0416310
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:14:01 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so5343679wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ONCXgNCOtImX0AhNIxHUhslQR7t5rZ6vcHB5inKBUBs=;
        b=b4CmB9R52qp6rkn3CJ5+u40v7Bk1hPNLw6ClXDSES56lC8aHfeOSI2Cy1YaCH58GKd
         1GZs0WeWnhKcLTjjSYVe82JdqsdEmjRBnakZ3izLQiHWispiCIuCHuG4muUf7qsBDp9d
         6AIwAyWdHT/lhM5XSPGAxR2t10G7VTu9xGkRBt2GMZK/YBf3q5EcqacDqmDqYtLqSZEc
         2qiG2BbJKIFaXMAH3UNgzZkAezDf++ZJizQCdRKyKN+Y1BHyj7Mjbqt1vMZDobvxSoqk
         pIZ1+XDEX9WI1XMNJwM3hWijB54tHL79x0QidSlsvl0aA8rUUNvtNBz4RKQqX2pmlBWb
         Pe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ONCXgNCOtImX0AhNIxHUhslQR7t5rZ6vcHB5inKBUBs=;
        b=y6Gpbht9FLIcbGqZW+mo/UP9q2ibTofmP3zq2ybuT9PTCO2GxG7lqCGrqyn8DdlGu8
         59c0WqLsZmG8LCmMo76iKQec+a3xw435uzUgHkE4Vulro4UU5jhxH3yeyOVQCT5sEG86
         t13GwMwM20Na8mz4DUMLSBtcAu9TAD4r1CWNsygNBhILwVaoPds9S5Xwq8qGr238olZ0
         3u6G9JWZ9GGmibxuTOSO+7XxWTz4ambEuYeEJAra+qninmE2en44DjF1x7Ep5Dc1Rjr4
         3yfUuoKbfiK5vt/FMqJWTMJZlNAb8e0CJG8F+7PVI5zGpBGaUzsfINqUnQiwPk+shKYh
         l0+g==
X-Gm-Message-State: AJIora8v/LaMJhdBWuS+rxyVWn4uQPx9Ax2TVgYQlL9yjUTks1CLl/dM
        NC8+5NSwQpzt/g7yY9cGTYj5wChCURu4AFha
X-Google-Smtp-Source: AGRyM1sek8DA6kuVdp7drJ56jHIEwXnHAeq1PdUq74BIIsdk4xjWpHP+sP8zw+l450wkN8hNaasGDuwX4/8ukCwF
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1c0d:b0:3a0:503a:9c9c with
 SMTP id j13-20020a05600c1c0d00b003a0503a9c9cmr30997697wms.2.1656940440320;
 Mon, 04 Jul 2022 06:14:00 -0700 (PDT)
Date:   Mon,  4 Jul 2022 14:13:46 +0100
Message-Id: <20220704131346.2650163-1-vdonnefort@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4] cpu/hotplug: Do not bail-out in DYING/STARTING sections
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, vschneid@redhat.com,
        regressions@leemhuis.info, kernel-team@android.com,
        Vincent Donnefort <vdonnefort@google.com>,
        Derek Dolney <z23@posteo.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

---
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
index bbad5e375d3b..c3617683459e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -663,21 +663,51 @@ static bool cpuhp_next_state(bool bringup,
 	return true;
 }
 
-static int cpuhp_invoke_callback_range(bool bringup,
-				       unsigned int cpu,
-				       struct cpuhp_cpu_state *st,
-				       enum cpuhp_state target)
+static int _cpuhp_invoke_callback_range(bool bringup,
+					unsigned int cpu,
+					struct cpuhp_cpu_state *st,
+					enum cpuhp_state target,
+					bool nofail)
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
+	return _cpuhp_invoke_callback_range(bringup, cpu, st, target, false);
+}
+
+static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
+						      unsigned int cpu,
+						      struct cpuhp_cpu_state *st,
+						      enum cpuhp_state target)
+{
+	WARN_ON_ONCE(_cpuhp_invoke_callback_range(bringup, cpu, st, target, true));
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
2.37.0.rc0.161.g10f37bed90-goog

