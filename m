Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3140F52D85B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiESPoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiESPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:43:45 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73151689B8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:43:13 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id p24-20020a1c5458000000b003945d2ffc6eso2180780wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LDnjINTdrLmSbH/oDg0tv0BqLkkxPNd2bF0UCJnpHSE=;
        b=dOziocArW4d3s7LtNCyzgr0YXDIQVWYBCOJ5hB2qeEDLDQ/DzUQhZQFjI/tqddYJtR
         jtHCMwDRr2I4bNb04T+vcaCM5XsfIc5XvU1uOBM6XRUiLcS9jsl3pj3GD1ex/wPFbHpu
         P3V+rKn9GasA1agX/1Xhdh1Dk8MkwUdItgvHQdVsY4sTNvmBxMR7weI9jVgxvS/l+rcJ
         BWKnq5n8G+EAwMlOkSMvSR6Cj9jqQkPPOwfwH4pa8oNk+9hsp8g2RILfGqpvJ6H88OTo
         2MggzQg6WWuHubYWrY1qxbI6og4vYwiW1T57XPN9QFQcs7ca81tyK02UZ1Q9kafsYFta
         BHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LDnjINTdrLmSbH/oDg0tv0BqLkkxPNd2bF0UCJnpHSE=;
        b=fe5I+58OsmzqCikXZO0RkT6wj8LikbheeR1My4zlRBzhVpZwDKOLv/wANya1J4FB7Q
         /dhkORreidY16jVV6Ajjw7v0INoFXd6x3J0o4xzfhNZF1R7nyCoi9Zy1SGTFm5amSDfD
         SwWZiQk87Spk39xNcGnWMG4/2C3MdTYX+CuZcgF4RIS00d9IpGa1nG20e/nWtsWzabUj
         yE2ujFBD6oq37yYjMZ0BA8s68/cExCV8KqQv32GBkp2WAfpj5sXHfvazpF3D3NWYndv0
         VVUNJxA0Wf3nwThd3ZpaXkIdER91tK+grafPngYr/knjF6X0a2mDv4a5g2a+n8kzzO8R
         a1mg==
X-Gm-Message-State: AOAM533YzhsQiM/g2TnSnQ2jZ4wxhx7WCMeZTgHOoG74+p92bCcHlpa2
        X45OMQAaOTVH7fdYDU26rEXxN7kENicGFqm8
X-Google-Smtp-Source: ABdhPJzjwtHaUMLATeXxDzeE6kaNW9goZVfjjcn0eLsTT4A/aPfTFC8UriyZVRyooLFZDR6awuVQAD+gq2kDj6/s
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:618f:0:b0:20c:ffa0:95a8 with SMTP
 id j15-20020a5d618f000000b0020cffa095a8mr4591604wru.306.1652974991948; Thu,
 19 May 2022 08:43:11 -0700 (PDT)
Date:   Thu, 19 May 2022 16:42:57 +0100
Message-Id: <20220519154257.1464081-1-vdonnefort@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH] cpu/hotplug: Do not bail-out during DYING/STARTING sections
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

The DYING/STARTING callbacks are not expected to fail. However, callbacks
registered in those sections can still report errors. There's nothing the
hotplug machinery can do, so let's just proceed and log the failures.

Fixes: 453e41085183 (cpu/hotplug: Add cpuhp_invoke_callback_range())
Reported-by: Derek Dolney <z23@posteo.net>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..b23a83d869a9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -663,21 +663,52 @@ static bool cpuhp_next_state(bool bringup,
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
+					bool no_fail)
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
+		if (no_fail) {
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
+static inline void
+cpuhp_invoke_callback_range_nofail(bool bringup,
+				   unsigned int cpu,
+				   struct cpuhp_cpu_state *st,
+				   enum cpuhp_state target)
+{
+	WARN_ON_ONCE(_cpuhp_invoke_callback_range(bringup, cpu, st, target, true));
 }
 
 static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
@@ -999,7 +1030,6 @@ static int take_cpu_down(void *_param)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int err, cpu = smp_processor_id();
-	int ret;
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
@@ -1012,13 +1042,11 @@ static int take_cpu_down(void *_param)
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
@@ -1296,16 +1324,14 @@ void notify_cpu_starting(unsigned int cpu)
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

