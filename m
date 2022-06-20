Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24F45526DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbiFTWUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFTWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028991B7AA;
        Mon, 20 Jun 2022 15:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CAE5612FA;
        Mon, 20 Jun 2022 22:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9FBC341D1;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=i4CawKOFPTigQL0XBLAWhdlDe14tFZDYfSCVAPb/eQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hxy2vAPtAq1FfTBIh69lbVsfRHcnWpJEDM616wTrMIKYvbD/Krf/t2vibZC8Xms3x
         mUnqpdnPx6MS5H7LfSJH2haQKGxXMK2FGZEEep5svDSyI1Fu7Ziu9Y84b1d9DHc0a4
         SD243xJCmbm+U8Cf2gUuU59JaWEaUDpDrE3Ai6URyLAoQUZD5ALw9SP8DJ50tAPyde
         RJxmJvt3mLO8wdm7RP1QbEJSLISO4Mrj/ddUio5MTfpTVvYbQrUKM2Q0+XA2pCf5sf
         fEqGGMbJ58krhF7e7KmAUED2OltfR3FFig68Yh4mxAtKfnELzne4AJEAOLoI9gHgO5
         eQCNP43mfoCAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0AF785C0CCE; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/12] rcu: Cleanup RCU urgency state for offline CPU
Date:   Mon, 20 Jun 2022 15:20:28 -0700
Message-Id: <20220620222032.3839547-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

When a CPU is slow to provide a quiescent state for a given grace
period, RCU takes steps to encourage that CPU to get with the
quiescent-state program in a more timely fashion.  These steps
include these flags in the rcu_data structure:

1.	->rcu_urgent_qs, which causes the scheduling-clock interrupt to
	request an otherwise pointless context switch from the scheduler.

2.	->rcu_need_heavy_qs, which causes both cond_resched() and RCU's
	context-switch hook to do an immediate momentary quiscent state.

3.	->rcu_need_heavy_qs, which causes the scheduler-clock tick to
	be enabled even on nohz_full CPUs with only one runnable task.

These flags are of course cleared once the corresponding CPU has passed
through a quiescent state.  Unless that quiescent state is the CPU
going offline, which means that when the CPU comes back online, it will
needlessly consume additional CPU time and incur additional latency,
which constitutes a minor but very real performance bug.

This commit therefore adds the call to rcu_disable_urgency_upon_qs()
that clears these flags to the CPU-hotplug offlining code path.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f4a37f2032664..5445b19b48408 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4446,6 +4446,7 @@ void rcu_report_dead(unsigned int cpu)
 	rdp->rcu_ofl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
+		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
-- 
2.31.1.189.g2e36527f23

