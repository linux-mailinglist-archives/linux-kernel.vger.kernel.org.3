Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B7531467
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiEWQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbiEWQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:05:42 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BDB427D4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:05:41 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id k35-20020a05600c1ca300b003946a9764baso10785068wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/WdtMIUmyyQ0wzVn9eTkFE7BwdXKVqWgYYHPBjXthEc=;
        b=aF1rBAAykQt59VR7BYd6nkyLaBIQSGBXyzfISv9DxoOtFD2zCgbi034usAav8b99KM
         zXxuDdBuQ3Eg2qCtx6+F2WpzCOk9wNuVEuWZoB8Mco6OwvXb8vVTN/VvQzwYZj9WRVKL
         b78W6A6PB7SYl5IGKfkltq78cuhZLmYm3djxXhBkmnrwmi6YEdrCb/y57XYdiKFO3Gt0
         O4pKtg76UjepkhK1Hzdag1VMp6Grp1y4aFbbTaeOewMqXEMw/gSnuM/nkJYSPpKyRslM
         0eQuGXa7zf6x7CX2xjHsb7n5yWkdiR42UogzHTREsfn7GaQWSy5etBOdP0qjo8fxs7yN
         Dftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/WdtMIUmyyQ0wzVn9eTkFE7BwdXKVqWgYYHPBjXthEc=;
        b=JyKB/uAeMjmjAqF6wIKck9kOok1xtxyTAGbwoaCgE7vCcKeWMp/kK+rq8awlzAXKhO
         u7NGD3apMH4Tc/M5uz3/DVjPgNI00BI9fvPsmgMoDQLIOvRA0aVj/hxO7gqXRB6IyzYX
         nLWqr9OWaDM9pR2vHl+5X/JI1kYbwPiJBxr1mO9s6ql7KdK/48qrn8dej5bCnuuB0bB2
         kEuQS3w28QfO0BsWNXdQamZJihY3R1rRkMLNpiJtsamicy0EXkg+WDnfxT0xaXAMvOYa
         wkyW9WSH0u4+ElYEom9RUixTr0gj0vs+6UwsuxaIpDmORJbwDFDUTSscqfzfAEjM/tSa
         upVQ==
X-Gm-Message-State: AOAM531tSw9/NzQpH5z8v30U3v3mtAXJpKaRkA9AgTxIQUSkjUvUDI4H
        rt05m8epRXXBgWb0aynMn+CqYUG5rpJ8DTLe
X-Google-Smtp-Source: ABdhPJwBU+i7aJ9y/GOxT2EfsL3WPaeoum5y5IqzOO1JGSwgBrVvZAjtkzW1IP3luHrQOwgawj4qzP+rSQv0yW5x
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1c91:b0:397:4711:e2a8 with
 SMTP id k17-20020a05600c1c9100b003974711e2a8mr8261188wms.82.1653321939883;
 Mon, 23 May 2022 09:05:39 -0700 (PDT)
Date:   Mon, 23 May 2022 17:05:36 +0100
Message-Id: <20220523160536.2889162-1-vdonnefort@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING sections
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, vschneid@redhat.com,
        kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>,
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
those sections. In that case, there's nothing the hotplug machinery can do,
so let's just proceed and log the failures.

Fixes: 453e41085183 (cpu/hotplug: Add cpuhp_invoke_callback_range())
Reported-by: Derek Dolney <z23@posteo.net>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

---

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
2.36.1.124.g0e6072fb45-goog

