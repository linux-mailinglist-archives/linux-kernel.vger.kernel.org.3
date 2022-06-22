Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F80556EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376536AbiFVWwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358284AbiFVWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:46 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC274162A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:45 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i17so20760325qvo.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czRWmqXwJRiSEH25SM5GYb5Yl+/vPCw6VIvQPTxRUu8=;
        b=TffKA6dV8lgb0owObCDYZAoszUr3Wlohvc9Oe7lMyM8i3Tp+lw7j5I5jYbuBeUeBHr
         hw6rj2Ic8XvDgkEB7GWWhmAB28oH0ZodN41wjG+/n3WraZU8356yTc+2MMq9mW58RFg1
         SJPUS+ANKIuHUETM3nyiMJpm3QA/edyOhnM0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czRWmqXwJRiSEH25SM5GYb5Yl+/vPCw6VIvQPTxRUu8=;
        b=YFCJU0uXSCLQf+5HBRwBvaRJEFMWc0FDSMWafmryKoFAUSCK7Byf6rqr7fYUy0SFz9
         EuUI7fGknQEel9mIcsUDWCf7a4/Pvsnl4aK/av1sJL6dOueUwnajRD1wP2ovaDK8eMEC
         PNRjgLFbA8r3wnBW/5M08xXfjUL/f1wqTAQ03gzCXB7eW5WwhdAW+smuMfNoK4fBlgtf
         xBvmjV/wYaAnElcTl4LfggtKSIZiWQ7OvivroHNSOqvhPwwD3NRREyxG01NI3vF9aCQZ
         0ymsBZ1KF4plVrsnTdtGmhRZXIGbynXhLPexfRbo2PbtOuIdX5LIbQ0TzbJ8IgopDmRD
         +tog==
X-Gm-Message-State: AJIora8HlLTLBiocpLWhPk7LII2ojzCqxBfIMEscQrXXmQalpG6Mdmke
        ae0lKIt4nIOC2R2MgqHv+B+RAw==
X-Google-Smtp-Source: AGRyM1uo/5L9en8Zb8UJ/9q6iw0BqvqvJQYPuudXxkgc81Cjbz58Q0qLgY+GAxCRwsEEJphkgx2Ofg==
X-Received: by 2002:a05:6214:ac7:b0:470:6dd0:c3da with SMTP id g7-20020a0562140ac700b004706dd0c3damr3578574qvi.43.1655938304958;
        Wed, 22 Jun 2022 15:51:44 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:44 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 4/8] rcu/nocb: Add option to force all call_rcu() to lazy
Date:   Wed, 22 Jun 2022 22:50:58 +0000
Message-Id: <20220622225102.2112026-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used in the rcu scale test, to ensure that fly-by call_rcu()s do
no cause call_rcu_lazy() CBs to be flushed to the rdp ->cblist.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h  |  2 ++
 kernel/rcu/tree.c | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4916077119f3..71c0f45e70c3 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -472,6 +472,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c_old,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcu_force_call_rcu_to_lazy(bool force);
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 					  int *flags, unsigned long *gp_seq)
@@ -490,6 +491,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 	do { } while (0)
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
+static inline void rcu_force_call_rcu_to_lazy(bool force) { }
 #endif
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d2e3d6e176d2..711679d10cbb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3171,9 +3171,18 @@ void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func)
 EXPORT_SYMBOL_GPL(call_rcu_lazy);
 #endif
 
+static bool force_call_rcu_to_lazy;
+
+void rcu_force_call_rcu_to_lazy(bool force)
+{
+	if (IS_ENABLED(CONFIG_RCU_SCALE_TEST))
+		WRITE_ONCE(force_call_rcu_to_lazy, force);
+}
+EXPORT_SYMBOL_GPL(rcu_force_call_rcu_to_lazy);
+
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	return __call_rcu_common(head, func, false);
+	return __call_rcu_common(head, func, force_call_rcu_to_lazy);
 
 }
 EXPORT_SYMBOL_GPL(call_rcu);
-- 
2.37.0.rc0.104.g0611611a94-goog

