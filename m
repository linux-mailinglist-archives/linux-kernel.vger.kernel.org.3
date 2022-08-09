Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F138058D273
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiHIDpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiHIDpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:45:31 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6210AD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:45:28 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id ct13so7734180qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 20:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZzA9Rd0b00OZfxFV02Gdeuv+mOqvteNupyd1eAzxjU=;
        b=sERCSp1rUYikGtTBwh5MQzjCjB1LzA2rs2s5QtWfVFE+XUCMCKh+v/6aIYlIM7flQl
         GLJkKUzeQejKxqq21U1Xfx/KoXwuLC4ik/379JpuFELG+xJUBjzW6SePOEhHJpX392fj
         vfVhTW5h5yjXTkTAP7XvPLkSAsYS8Izfw6RL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZzA9Rd0b00OZfxFV02Gdeuv+mOqvteNupyd1eAzxjU=;
        b=iMrH5ByOkyAPGVmYto6kX6KyvtZIN7fovbnvxuVqLm476SSadF3/+oMnVrjNbRS2+Q
         B9v8lrqbs8/jJKNNLTdaoOQDhV+6A9tZDfZA3SlungfaVk2W9AnXWgSuAAe9SSfNmm9Y
         takFhqYe8MjyHahkSrwefPEpexPh0EqMOiW0jCCtqvZ8hpA33iRRG4YLfX6gBqDPVn7O
         /x3bGSYm71+63rz+5k1/G2UfhCqZWrBLknReEy3cy5chUTwyRjEqtHjNaRw8SEfKb85T
         1LWWoBAPAY0OBDfgouBVEqSYJC7kXKotHmEi3tJHA2r/4k7bS/WRH0rFT8LQKGDK1m19
         sorw==
X-Gm-Message-State: ACgBeo2ysIGweX2kkDlsLzwz+bk0KfbsvcP2r5h5+ueCj7xW9p0wqkQN
        LHzUIUU/IVF9iIK1s2wxd+nhs/l8g8XA9Q==
X-Google-Smtp-Source: AA6agR5aKZXeJfbaZZ3ItM7XgSTBgJmmzURarQWH5BG+HYK/fZ4cz8gqycXq6VSywJjEYZBpYSRqUg==
X-Received: by 2002:a05:6214:d82:b0:477:3d7c:1081 with SMTP id e2-20020a0562140d8200b004773d7c1081mr17987737qve.28.1660016727340;
        Mon, 08 Aug 2022 20:45:27 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ca8-20020a05622a1f0800b0031f0b43629dsm9170979qtb.23.2022.08.08.20.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 20:45:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Subject: [PATCH v3 resend 6/6] debug: Toggle lazy at runtime and change flush jiffies
Date:   Tue,  9 Aug 2022 03:45:17 +0000
Message-Id: <20220809034517.3867176-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
In-Reply-To: <20220809034517.3867176-1-joel@joelfernandes.org>
References: <20220809034517.3867176-1-joel@joelfernandes.org>
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

Enable/Disable this feature by writing 1 or 0 /proc/sys/vm/rcu_lazy.

Change value of /proc/sys/vm/rcu_lazy_jiffies to change max duration before
flush.

Do not merge, only for debug for reviewers.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Change-Id: Ia733937531f7a75e75f7b6807319e18c94d70750
---
 include/linux/sched/sysctl.h |  3 +++
 kernel/rcu/tree_nocb.h       |  9 +++++++++
 kernel/sysctl.c              | 17 +++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 2cd928f15df6..54610f9cd962 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -14,6 +14,9 @@ extern unsigned long sysctl_hung_task_timeout_secs;
 enum { sysctl_hung_task_timeout_secs = 0 };
 #endif
 
+extern unsigned int sysctl_rcu_lazy;
+extern unsigned int sysctl_rcu_lazy_jiffies;
+
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
 	SCHED_TUNABLESCALING_LOG,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f8d7255f4f0a..2b7d3d87e70b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -266,6 +266,9 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 #define LAZY_FLUSH_JIFFIES (10 * HZ)
 unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
 
+unsigned int sysctl_rcu_lazy_jiffies = LAZY_FLUSH_JIFFIES;
+unsigned int sysctl_rcu_lazy = 1;
+
 #ifdef CONFIG_RCU_LAZY
 // To be called only from test code.
 void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
@@ -292,6 +295,9 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 	unsigned long mod_jif = 0;
 
+	/* debug: not for merge */
+	rcu_lazy_set_jiffies_till_flush(sysctl_rcu_lazy_jiffies);
+
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
 	/*
@@ -687,6 +693,9 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
 	bool wasempty = false;
 
+	/* debug: not for merge */
+	rcu_lazy_set_jiffies_till_flush(sysctl_rcu_lazy_jiffies);
+
 	/*
 	 * Each pass through the following loop checks for CBs and for the
 	 * nearest grace period (if any) to wait for next.  The CB kthreads
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b00f92df0af5..bbe25d635dc0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2450,6 +2450,23 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#ifdef CONFIG_RCU_LAZY
+	{
+		.procname	= "rcu_lazy",
+		.data		= &sysctl_rcu_lazy,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "rcu_lazy_jiffies",
+		.data		= &sysctl_rcu_lazy_jiffies,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif
+
 	{ }
 };
 
-- 
2.37.1.559.g78731f0fdb-goog

