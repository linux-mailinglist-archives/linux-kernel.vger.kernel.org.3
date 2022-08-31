Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E585A85A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiHaSap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiHaSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:30:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31011A24;
        Wed, 31 Aug 2022 11:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0288AB82220;
        Wed, 31 Aug 2022 18:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9089DC433D7;
        Wed, 31 Aug 2022 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969758;
        bh=vAqwYNsiS6egYw7ZedEOtoVgOp435w0oQaSAHoj18bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8ujJA9VEAg5qDXZG560Dml6+TqsFiw5tWVN4V3aFk5s8aUIN89fb9vgHH1IFNvVC
         i8nKfYtAS0xBTI+Dgrh371CC4Q/WUGtM1dLKaMaynkl7Xs7wiU87o96fNivnsvEzoY
         1hg6FO+Rzg13ASnThr4F3mGh93BFBfhciHJrqOnB+xSsmr79OkI7reqhroceB9XGkX
         eMzdngAtEwJhfTFsH6/iVLDy80P0AUCdSCbtcuKScMgYcX/3GPR7cx4ttAR3QvhVsV
         1uPrPbfk42WwsNWIHxDsOoSi/HVC19AlOb5ywDxhtuPggk60zogIjsdy3pjW9ExLEN
         6VMz6bcemZwmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5142A5C015D; Wed, 31 Aug 2022 11:15:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] rcu-tasks: Convert RCU_LOCKDEP_WARN() to WARN_ONCE()
Date:   Wed, 31 Aug 2022 11:15:54 -0700
Message-Id: <20220831181556.2696404-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181553.GA2696186@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181553.GA2696186@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

Kernels built with CONFIG_PROVE_RCU=y and CONFIG_DEBUG_LOCK_ALLOC=y
attempt to emit a warning when the synchronize_rcu_tasks_generic()
function is called during early boot while the rcu_scheduler_active
variable is RCU_SCHEDULER_INACTIVE.  However the warnings is not
actually be printed because the debug_lockdep_rcu_enabled() returns
false, exactly because the rcu_scheduler_active variable is still equal
to RCU_SCHEDULER_INACTIVE.

This commit therefore replaces RCU_LOCKDEP_WARN() with WARN_ONCE()
to force these warnings to actually be printed.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 83c7e6620d403..469bf2a3b505e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -560,7 +560,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 {
 	/* Complain if the scheduler has not started.  */
-	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
 			 "synchronize_rcu_tasks called too soon");
 
 	// If the grace-period kthread is running, use it.
-- 
2.31.1.189.g2e36527f23

