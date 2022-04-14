Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CA501C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346080AbiDNUJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiDNUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:09:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2FE72BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:07:00 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a186so2248672qkc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVQjffk0zdFrlFy9d1t7mkrDpOeN4HI9CGLfF9WJi4I=;
        b=uQ07X8c4piH/ZIrhE89f40fnoVL45/1UfAUHhTvoR3FDA9zI7EoY8YOnvOSTf6PSN2
         19LSmqpQ4ctHuh5lWxitEjcgkUSCwJh8HLs39QQ8793OOhfuY137KAk73YZG+njkvMwP
         oG51OUWfHQQbR6UoHYb0WRglMSHWZuTUsDyQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVQjffk0zdFrlFy9d1t7mkrDpOeN4HI9CGLfF9WJi4I=;
        b=hUXdYxhcYOwcq6lm43XEmuKu4xhZLabl3kjSmHq8yFJ5GF0h9U5adv90/G5FgqOEzE
         gZahicIhhkXUL59sC0Y/2sMR5/7UKxHszbcuw0A7ArmLAXH1u5XjZmshIF22fqECVyvr
         vKZ7r0mEffXPHXjMq2UTSfF1EOeXJg76ZDichqh0+Qy5I+JiypxPQE4BG+yJT8RxnspQ
         JsNQpzz/pmpny83A2hNLkffsY8zKnjYsHTjPDP7BaqLcj+q+uxd7P1Xon/OZ4Mv5Uf6n
         fQRWdwLt84AXB4TKe5D5WxKQ4Y0h2bl/0XZV4IfAixWlW48SWWWH0ngCJogCJfa2W7zr
         X46w==
X-Gm-Message-State: AOAM532I/btV6iAvkpPdEfz6OykuPlnsqmfnHCP9dbK07S7N2I7QJf+R
        qRkQu1x4SkqWF8nfGkNCvI6hu479YdxqEA==
X-Google-Smtp-Source: ABdhPJzuv44il/wBJ41NU3pHox9b2DdV47fk3XIlBrf23loBkc3kI2T6cwl6Lrp8TFBkPD8JMhaaaQ==
X-Received: by 2002:a05:620a:440f:b0:67d:2133:ec26 with SMTP id v15-20020a05620a440f00b0067d2133ec26mr3245571qkp.658.1649966819426;
        Thu, 14 Apr 2022 13:06:59 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id f20-20020ac87f14000000b002f1d318efebsm1862081qtk.83.2022.04.14.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 13:06:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] rcu/nocb: Add an option to offload all CPUs on boot
Date:   Thu, 14 Apr 2022 20:06:42 +0000
Message-Id: <20220414200642.1778806-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
which ends up not offloading any CPU. This patch removes a dependency
from the bootloader having to know about RCU, about how many CPUs the
system has, and about how to provide the mask.

With the new option enabled, all CPUs will be offloaded on boot.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 kernel/rcu/Kconfig                              | 12 ++++++++++++
 kernel/rcu/tree_nocb.h                          | 11 +++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..fd8165237954 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4398,6 +4398,10 @@
 			no-callback mode from boot but the mode may be
 			toggled at runtime via cpusets.
 
+			Note that this argument has no effect if the kernel
+			is built with CONFIG_RCU_NOCB_CPU_ALL=y, in which case
+			all CPUs will be offloaded on boot.
+
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
 			(specified by rcu_nocbs= above) explicitly
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bf8e341e75b4..00a040f17b1d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -223,6 +223,18 @@ config RCU_NOCB_CPU
 	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_ALL
+	bool "Offload RCU callback processing from all CPUs"
+	depends on RCU_NOCB_CPU
+	default n
+	help
+	  Use this option to offload callback processing from all CPUs.
+	  This also avoids the need to use any boot arguments to achieve
+	  the same effect, when it is desired to offload all CPUs.
+
+	  Say Y here if you are sure you always want all CPUs offloaded.
+	  Say N here if you are unsure.
+
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
 	depends on RCU_EXPERT
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eeafb546a7a0..df2e4c0a6178 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1168,6 +1168,13 @@ void __init rcu_init_nohz(void)
 	bool need_rcu_nocb_mask = false;
 	struct rcu_data *rdp;
 
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_ALL)) {
+		if (rcu_nocb_is_setup) {
+			pr_info("Kernel is configured to offload all CPUs, rcu_nocbs= passed but has no effect.\n");
+		}
+		need_rcu_nocb_mask = true;
+	}
+
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
 		need_rcu_nocb_mask = true;
@@ -1191,6 +1198,10 @@ void __init rcu_init_nohz(void)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
+	/* Set all CPUs as offloaded if RCU_NOCB_CPU_ALL=y. */
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_ALL))
+		cpumask_setall(rcu_nocb_mask);
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.36.0.rc0.470.gd361397f0d-goog

