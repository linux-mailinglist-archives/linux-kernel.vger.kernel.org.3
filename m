Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC12556EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376657AbiFVWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359771AbiFVWvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:49 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450FE41303
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:48 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id o43so27420978qvo.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oulAy7NlmqgAX/AG2BIWch0UpN6lWOBq/Xx+LqGxyiU=;
        b=Zd4Acj6vFejlAuM4LGySk0mn5EpwW09kqb0tPrWdZuUSIL1zdVj6CpnngjAG5CU35U
         9yra0A4qcuU3QelVy9Thq3pL7e37068nnzNVRkCJG9aRq+zBR8VCYjCfHgtlXa90Ue4H
         IGj41tdwPLrWondJBlm13KXtRnLZJprFieFjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oulAy7NlmqgAX/AG2BIWch0UpN6lWOBq/Xx+LqGxyiU=;
        b=dV1EhxEze450Ji2XM1P0ciQ7PP+9pflsDkGpUnFAHXHer7PC2KLsV/5jMNgVw3j9vc
         uKzU3sWD0m9cUrfu4gA1b4EjjbKH4Bkdnxqna2MCFriEVHAYQNcPb+IQ3+7WhtfKeprq
         lrdjT+nKwyq5fiHvB49YE4U6cMZjc5cJIJcA9dwyI+Wauem8A1jolkRuBdKiRaHat0J1
         +4duOkAM9FTA59SEyjby3pP1r+1iVZrEzej7GmqGmtCQaA8gN90FwYQdi2hqXCL+7fAy
         t79TCsjq5u766vNxlVurivMhPqI0zWxfkC26hMkWhCyq2QKwxBAqacG3y/JC06mWsPxL
         u/hw==
X-Gm-Message-State: AJIora8n79w+44bc67w6DrhfxSXF3/vcQROVWsLXx8DoGo+49l0CO/Rm
        m0QxeyINGCWEBuSAWHf2yskSXA==
X-Google-Smtp-Source: AGRyM1uNf6I5+fQ6KcX/9MOZDknEktSDE/Z0l3YRPxDg86JuWUz6QknaienDhYHazulLUj/lBR6DPA==
X-Received: by 2002:a0c:9066:0:b0:470:2b7a:2078 with SMTP id o93-20020a0c9066000000b004702b7a2078mr22020533qvo.51.1655938307947;
        Wed, 22 Jun 2022 15:51:47 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 7/8] rcu/nocb: Rewrite deferred wake up logic to be more clean
Date:   Wed, 22 Jun 2022 22:51:01 +0000
Message-Id: <20220622225102.2112026-9-joel@joelfernandes.org>
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

There are 2 things this function does:
1. modify the gp wake timer.
2. save the value of the strongest requested wake up so far.

The strongest is "wake force" and the weakest is "lazy".

The existing logic already does the following:
1. if the existing deferred wake is stronger than the requested one
   (requested in waketype), modify the gp timer to be more in the
   future. For example, if the existing one is WAKE and the new waketype
   requested is BYPASS, then the timer is made to expire later than
   earlier.

2. even though the timer is modified in #1, a weaker waketype does not
   end up changing rdp->nocb_gp_defer to be weaker. In other words,
   ->nocb_gp_defer records the strongest waketype requested so far,
   even though the timer may or may not be the soonest expiry possible.

For simplicity, we write this logic using switch statements and
consolidate some of the timer modification operations.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 255f2945b0fc..67b0bd5d233a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -282,6 +282,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	unsigned long mod_jif = 0;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
@@ -289,19 +290,31 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 * Bypass wakeup overrides previous deferments. In case
 	 * of callback storm, no need to wake up too early.
 	 */
-	if (waketype == RCU_NOCB_WAKE_LAZY) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
-	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
-	} else {
-		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
-			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
-		if (rdp_gp->nocb_defer_wakeup < waketype)
-			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+	switch (waketype) {
+		case RCU_NOCB_WAKE_LAZY:
+			mod_jif = jiffies_till_flush;
+			break;
+
+		case RCU_NOCB_WAKE_BYPASS:
+			mod_jif = 2;
+			break;
+
+		case RCU_NOCB_WAKE:
+		case RCU_NOCB_WAKE_FORCE:
+			// If the type of deferred wake is "stronger"
+			// than it was before, make it wake up the soonest.
+			if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
+				mod_jif = 1;
+			break;
 	}
 
+	if (mod_jif)
+		mod_timer(&rdp_gp->nocb_timer, jiffies + mod_jif);
+
+	// If new type of wake up is strong than before, promote.
+	if (rdp_gp->nocb_defer_wakeup < waketype)
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
-- 
2.37.0.rc0.104.g0611611a94-goog

