Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07885565691
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiGDNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGDNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:07:20 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386A120B3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:06:55 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id j19-20020a05600c191300b003a048196712so5328234wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7E+mHbx+TXjIxMVFYuwnu31M0ChayWxoprAttMBMYwc=;
        b=pwBUU2owB4C++Gq/yMhDoZq4EnYsnzxB1nZcpuPsc2bTLL/bgqIxD+UP+mECNk95Sb
         XQwSOlwsV7TcVTPNEB4yyqmkWyJanpPqB0dB+iVjSdc1AqVNyAeH2FyJzqD+mu1gBF8M
         fWwS7LSOaZmsLfTMfbcDrvtdtzaNX+cLvezmOxZTREqLeUbFiCxLXXV5m4onU9XBv9BH
         D98CbaeCKxO/LSEZLpjFT2nVGE1seIyd8Kelmup6ybyn7ib6Q7xD8E0MlNFoEzqpz1Ew
         UcCFrAEqME3/z9D23ZuuK/FWi4qJc35tdg1kNIdoKyyvPHg9hTyI7elIK8kUpqW7RC0W
         Iy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7E+mHbx+TXjIxMVFYuwnu31M0ChayWxoprAttMBMYwc=;
        b=bolRddZopEffsjb0NDk9k38DIVHksZHRqPl/gLgUrYymkJpCJOPLUMo//qvhFdbR2O
         IyJhjGMMm2SU8TouTDAjJq8E9JC7SfjS0vNxOhV2Iq0eL+QzidcdG+HrFKX7Wgbimgx6
         S8/s3kbbNI0uD8Xx9dEPM86DciiK/5k+spBv+mrXX560FtnF08EWzg+D0uzzDIc6D16b
         mhGybxywMz1u2BOBa9VXa56ww7hspQv80+qyAVSUzyvs268DBw9qY7Ll0PnBMvbz2vGl
         n0FZ56C2P/iXdszUSgvHaIIMYRBkmcCbb+w3u81hU6MnJiIcF9wez5hf5tr3Yj+NAZsK
         9YPg==
X-Gm-Message-State: AJIora+NjTPPpzJ1k38siJqoYy1AqbPmtj8zS8YvglegEPz07ZU3ZJNu
        hi32qcqUinvhGK+Im58TlH/DZf6GK1ZWtn9X
X-Google-Smtp-Source: AGRyM1vjy4gFL4sxqNAGVTDtu2zmgnrL4icsVVeJwwD3V3or1NB+NwJefKmWWa3sqCglPAacWWram55SZAphW3K4
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a7b:c3cd:0:b0:3a1:95b6:3fd0 with SMTP
 id t13-20020a7bc3cd000000b003a195b63fd0mr12693055wmj.75.1656940013805; Mon,
 04 Jul 2022 06:06:53 -0700 (PDT)
Date:   Mon,  4 Jul 2022 14:06:41 +0100
Message-Id: <20220704130641.2645456-1-vdonnefort@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3] cpu/hotplug: Do not bail-out in DYING/STARTING sections
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
453e41085183 (cpu/hotplug: Add cpuhp_invoke_callback_range())

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
Fixes: 453e41085183 (cpu/hotplug: Add cpuhp_invoke_callback_range())
Reported-by: Derek Dolney <z23@posteo.net>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Derek Dolney <z23@posteo.net>

---
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

