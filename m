Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E555273B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345114AbiFTWy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbiFTWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5ABAA;
        Mon, 20 Jun 2022 15:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F4E6144F;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5FAC341D0;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=8h+rBmnZeQ4AuieFAaeisntZStUikWKJL2ok2dCqfHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeNKLVkLE/9+YnYH+ErEDr5KaiSmKPtKXTYhuSlDX8SGMhPlFjcLRyb7BkdfMqDRx
         txvLt8UKPlCHWc1/piuLCZSP8A2s5xCJXIRI9v60XjGC0R/zRegld9RhHJl2uARQ1W
         HqqeN6OYrRsgSsTDI4Gd9CocpUR18h4g6KK5TZmX5iHIF5EBbPoCu8APiBOWJTvbkL
         8J4e2JJRU4GWB4nVeCVFO8Zd0JKsaoYrdVUlPwUSCoLJrtp+CjCLIiuEFX1c30UB87
         BAmYZmyyOphf6mCY1e/HoxA5W5QyPlcmmpf53ogIsSDtMVDaoX1gDWBR5D8mO4okAC
         lfzlVsLI7Z07w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3D4C45C0DEB; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 11/32] rcu-tasks: Make rcu_note_context_switch() unconditionally call rcu_tasks_qs()
Date:   Mon, 20 Jun 2022 15:53:50 -0700
Message-Id: <20220620225411.3842519-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
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

This commit makes rcu_note_context_switch() unconditionally invoke the
rcu_tasks_qs() function, as opposed to doing so only when RCU (as opposed
to RCU Tasks Trace) urgently needs a grace period to end.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c8ba0fe17267c..c966d680b789e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -899,8 +899,8 @@ void rcu_note_context_switch(bool preempt)
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
 		rcu_momentary_dyntick_idle();
-	rcu_tasks_qs(current, preempt);
 out:
+	rcu_tasks_qs(current, preempt);
 	trace_rcu_utilization(TPS("End context switch"));
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
-- 
2.31.1.189.g2e36527f23

