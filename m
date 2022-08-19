Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC55059A723
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351832AbiHSUtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351462AbiHSUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:13 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7130EB5A6C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id w18so4100399qki.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lNcAKp5cSys1fGk6soAVHXz41xwD4aYJNt/yj8PSxMI=;
        b=Z5NOz5b17X7HfkZzJOmU+TrGq9k9v7VqVqcjqBeqEHaupK1YDx6isupnlPQZnlKJoi
         skTSm0cZbcoldx2512oPzJfb96Sm6Fkf1RxlhKRuXxSIirY3obUi/9OvTDhEwlG2rkKx
         olPINJzLr6/w6LKuFHLL3aqhVPRvriUt+oUZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lNcAKp5cSys1fGk6soAVHXz41xwD4aYJNt/yj8PSxMI=;
        b=IeUCF5xiVLRH1WlwcY0gc4v3AtnFQr1WNCwdjK+Y8y4k5eKVhTVf49nQ2w9EzN1cj1
         v3/M+RIMCO/HDzZVQKnN06RtvcyWDBEolNQ7Y8oIDNO+aQmn2WhhQT6oBuxjcZDx14j2
         uEBIPOchwhof12ajwxFBunNxs0euTp24vrxLQn/FKypIx/fyU7x8Ft99v7R9L5VFEXcK
         QocGk9W0nNlCDoc/DZm8cCfLb/spJxwX8AEVYJ0jfjINjeYGA/tVSu41+pfcDZf0XatV
         igNDvuV97nP2pCyLWbfQrbhBvh8kpvAClEzbKNK7GyckZz3442Z9VFcmLyDr//evNJXL
         m/0w==
X-Gm-Message-State: ACgBeo0VXmyId8XMozZ9XUX42zrCqmsIUgpWy/ukXDRcN19QmMkPi9De
        TeOGEjCX+sjxJanYse1BRChPv1f+fwx6hQ==
X-Google-Smtp-Source: AA6agR4Y+4r+MWffKODfxjuKe49rH8feKDIxdpzllu1ok0KwILGkckGGq/CDgdkru5b5f1OB/tBAUg==
X-Received: by 2002:a05:620a:290d:b0:6b5:cecc:1cab with SMTP id m13-20020a05620a290d00b006b5cecc1cabmr6185949qkp.465.1660942148400;
        Fri, 19 Aug 2022 13:49:08 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 06/14] debug: Toggle lazy at runtime and change flush jiffies
Date:   Fri, 19 Aug 2022 20:48:49 +0000
Message-Id: <20220819204857.3066329-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
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
index edb4e59dbf38..16621b32de46 100644
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
@@ -697,6 +703,9 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
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
2.37.2.609.g9ff673ca1a-goog

