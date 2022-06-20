Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8335A55273A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbiFTWyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344664AbiFTWyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCABC17E25;
        Mon, 20 Jun 2022 15:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 663FEB81655;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02ADC341D3;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=WT3ydZLwrS9QKcxWSaQdcdKseUshLVdNTcHoU+FZnqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRLkpVerHHxGabnp8uvut53d/DYzijWMyY+08wMHjtsCWyX4Gj3qpFEWCh6VnWjH7
         4Oa41nd2pphpJxUKcAlovIYK8obK3wT6NDruWtdeJfJn4/b20Kw2XEaPc0xLDSOAjJ
         o81qOTKoSLdPaXtZsEd8HYHipdhs+m1e5AHZX18WBlRwDBG4cEGyP1L6DjrK11n2FQ
         3OABBoi7URyO+tSm7wXPkdmJ4Pn7u4+T+4TzLtNoCUbCrjZqvao8NqioQAYu4qsLcj
         vflsquIGdy0D7MFmcYI4f4EOWc7bn5CKn9D0OwN6qlWGhVwJl0SWWKRvO4SbtkTu00
         J0s6A1LKq6qEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A8045C0DAC; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 10/32] rcu-tasks: RCU Tasks Trace grace-period kthread has implicit QS
Date:   Mon, 20 Jun 2022 15:53:49 -0700
Message-Id: <20220620225411.3842519-10-paulmck@kernel.org>
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

Because the task driving the grace-period kthread is in quiescent state
throughout, this commit excludes it from the list of tasks from which
a quiescent state is needed.

This does mean that attaching a sleepable BPF program to function in
kernel/rcu/tasks.h is a bad idea, by the way.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 414861d651964..554b2e59a1d5a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1433,8 +1433,9 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
 {
 	// During early boot when there is only the one boot CPU, there
-	// is no idle task for the other CPUs. Just return.
-	if (unlikely(t == NULL))
+	// is no idle task for the other CPUs.  Also, the grace-period
+	// kthread is always in a quiescent state.  Either way, just return.
+	if (unlikely(t == NULL) || t == current)
 		return;
 
 	rcu_st_need_qs(t, 0);
-- 
2.31.1.189.g2e36527f23

