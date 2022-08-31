Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4445A8505
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiHaSIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiHaSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C49E3943;
        Wed, 31 Aug 2022 11:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A03161C19;
        Wed, 31 Aug 2022 18:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9652FC4314A;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=DfIvCam7iGu1hPFxklqGzZcjvwrU/yGB++vrN26Fk/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usadxwQdhiAWoS7zwJlmjAdFT4pokIH1Cu8Mo3ttdlp2zJrrjagbSh+VdgzIfZwN8
         InzRn01jWX3tPupYsaaLmuwGw7LTxgI5+yjriSfPlpihQdwzQGZ55JMcBgoliwX1KC
         ebuJsMurLgWMi7cNPHLftgYsD55dED0XcKw/WCYowCbLPsIu75PchFH9Oiv1yCdi8F
         pQGonP9uEKTXvG6O64VoQcUAV4RAzrTgwFbjvzakmuCmhlFr0oQq2/0U0MqLFeZEmw
         hnWwykXblNuPhnetUaYWUskEo+UuTbY2FTMAOl4BDAvUeW7/lnso5+Ci0QWVfYU+ic
         g1ZO69gIeugxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 061E25C09C2; Wed, 31 Aug 2022 11:08:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/10] rcu: Avoid triggering strict-GP irq-work when RCU is idle
Date:   Wed, 31 Aug 2022 11:08:04 -0700
Message-Id: <20220831180805.2693546-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
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

Kernels built with PREEMPT_RCU=y and RCU_STRICT_GRACE_PERIOD=y trigger
irq-work from rcu_read_unlock(), and the resulting irq-work handler
invokes rcu_preempt_deferred_qs_handle().  The point of this triggering
is to force grace periods to end quickly in order to give tools like KASAN
a better chance of detecting RCU usage bugs such as leaking RCU-protected
pointers out of an RCU read-side critical section.

However, this irq-work triggering is unconditional.  This works, but
there is no point in doing this irq-work unless the current grace period
is waiting on the running CPU or task, which is not the common case.
After all, in the common case there are many rcu_read_unlock() calls
per CPU per grace period.

This commit therefore triggers the irq-work only when the current grace
period is waiting on the running CPU or task.

This change was tested as follows on a four-CPU system:

	echo rcu_preempt_deferred_qs_handler > /sys/kernel/debug/tracing/set_ftrace_filter
	echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
	insmod rcutorture.ko
	sleep 20
	rmmod rcutorture.ko
	echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
	echo > /sys/kernel/debug/tracing/set_ftrace_filter

This procedure produces results in this per-CPU set of files:

	/sys/kernel/debug/tracing/trace_stat/function*

Sample output from one of these files is as follows:

  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  rcu_preempt_deferred_qs_handle      838746    182650.3 us     0.217 us        0.004 us

The baseline sum of the "Hit" values (the number of calls to this
function) was 3,319,015.  With this commit, that sum was 1,140,359,
for a 2.9x reduction.  The worst-case variance across the CPUs was less
than 25%, so this large effect size is statistically significant.

The raw data is available in the Link: URL.

Link: https://lore.kernel.org/all/20220808022626.12825-1-qiang1.zhang@intel.com/
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c46b3c74dad1f..207617f69aa56 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -641,7 +641,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 
 		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
 			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-			   IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
+			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
+			   ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node)) ||
 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
 			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
-- 
2.31.1.189.g2e36527f23

