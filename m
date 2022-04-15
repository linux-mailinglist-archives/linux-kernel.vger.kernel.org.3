Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3E502D66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350745AbiDOQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355691AbiDOQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:05:04 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E89D4CB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:02:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a10so6714047qvm.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DljWZKXAubVXqG1Ro0omqGdweveuV0cYgdZ65EqJ9s=;
        b=w/T5XzJUgWoGLquTxc3I8nvLvpbyCUQti/1pvnZJaqrBJghV4AuwUl1UM2MqzhauZm
         35gJC1bZ0ZbQcrJ4wSvSUoYUt2xjKnv6RQ6CbDkltUmFo36Jg0fArEv07L0Dvz8aT5Gb
         lPL+2udLzxV+RB6W714RhFqkMqsMLwSSirWD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DljWZKXAubVXqG1Ro0omqGdweveuV0cYgdZ65EqJ9s=;
        b=zD4qARYgJURqtn/mNBrTEG5mvFpECFa/Xdtt/ts5TM82qdKDFBHZE/wLz4BphbDehz
         PSR8emb7eJpKJFMSeZIcNC70Jj8oUNBGURFeRaIZ0HTeTbCY1XzDFrb62TtCS//kBTy2
         +kjpBRE+UWNXTsEGP1zgLEaz8YDI5jB+XlhEx7BHbT7aV/5OziW0IFdz3ey4n0mmSaIT
         1ZbXuUVxcD0+4KC5RPtW6fnRgTUEbiYDKAL2CJRF//pxxhnZXdGuZyCgc45qCo5fF7lq
         XTAvc0VniFoChWGtTq1Sfwh3v2Yuvyrh54opt4zonVGWtgThE443UQRQ05GAnCAo8bhb
         qX8w==
X-Gm-Message-State: AOAM532Y0/l8YGNEA1utSp/04lBEZNLJ7ODTdorjls2E1AsCH2PSgwZX
        cp5w8mf3358poo63Z1xdqKlmwefblnBc6w==
X-Google-Smtp-Source: ABdhPJwAzENcYv4aGYA8ZMIaha5k+ZD1mGr5UPM81CPNKLxpqywnC9WqLy4bR8wR5pAcj+CpJgOeLA==
X-Received: by 2002:a05:6214:d62:b0:446:2e4a:1f30 with SMTP id 2-20020a0562140d6200b004462e4a1f30mr5910873qvs.74.1650038554384;
        Fri, 15 Apr 2022 09:02:34 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bl22-20020a05620a1a9600b00680da570a5dsm2699890qkb.61.2022.04.15.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:02:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        rushikesh.s.kadam@intel.com, vineethrp@gmail.com, urezki@gmail.com
Subject: [PATCH v3] rcu/nocb: Add an option to offload all CPUs on boot
Date:   Fri, 15 Apr 2022 16:02:24 +0000
Message-Id: <20220415160224.1904505-1-joel@joelfernandes.org>
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
v2 was forcing the option to override no_cbs=
v3 is back to v1 but with a config option defaulting to 'n'.

 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 kernel/rcu/Kconfig                              | 13 +++++++++++++
 kernel/rcu/tree_nocb.h                          | 16 ++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..7648a7dd335e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4398,6 +4398,9 @@
 			no-callback mode from boot but the mode may be
 			toggled at runtime via cpusets.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
 			(specified by rcu_nocbs= above) explicitly
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bf8e341e75b4..2f8bd694ed85 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -223,6 +223,19 @@ config RCU_NOCB_CPU
 	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_DEFAULT_ALL
+	bool "Offload RCU callback processing from all CPUs by default"
+	depends on RCU_NOCB_CPU
+	default n
+	help
+	  Use this option to offload callback processing from all CPUs
+	  by default, in the absence of the rcu_nocbs boot parameter.
+	  This also avoids the need to use any boot parameters to achieve
+	  the effect of offloading all CPUs on boot.
+
+	  Say Y here if you want offload all CPUs by default on boot.
+	  Say N here if you are unsure.
+
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
 	depends on RCU_EXPERT
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eeafb546a7a0..673fa0d1f801 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1165,12 +1165,21 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = false;
+	bool need_rcu_nocb_mask = false, offload_all = false;
 	struct rcu_data *rdp;
 
+#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
+	if (!rcu_nocb_is_setup) {
+		need_rcu_nocb_mask = true;
+		offload_all = true;
+	}
+#endif
+
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
+	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask)) {
 		need_rcu_nocb_mask = true;
+		offload_all = false; /* NO_HZ_FULL has its own mask. */
+	}
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (need_rcu_nocb_mask) {
@@ -1191,6 +1200,9 @@ void __init rcu_init_nohz(void)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
+	if (offload_all)
+		cpumask_setall(rcu_nocb_mask);
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.36.0.rc0.470.gd361397f0d-goog

