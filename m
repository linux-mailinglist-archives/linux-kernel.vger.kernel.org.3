Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAC50606F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiDSADV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiDSAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701013CC8;
        Mon, 18 Apr 2022 17:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72B3B61297;
        Tue, 19 Apr 2022 00:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFF2C385B6;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=xBCTSb1Zw5agh9IQQuLKEyNN49GdD9FsTkuxc17sgcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmxi/26iXVhEk9jWuQSEXWR1R26p63ZIJDTLiIMzRxUilfYLXMeLtDEOyCe0wIxFh
         JHU3Fp4DEodko8v5TqKbv4SKkR80D3f0JlLU+WCw9YOXZM/jijzmYyPYtDB4O401BG
         4o2iLuXPKIQfu72gSxGJC+XJXTAvE7swIcDRf/FX3Nz9dz5fjzvBhUhGUGn04HRSqe
         Dy3Ivh4hWvpFaHmleMfRvFQ2P1rE6dvAwq1y1t/+2Q73jkZ/+weVjW2PBHk+C24ucH
         OP+JYjfuWLADk+EnUsZYqY32fgg9eCUVAGFp2+2VG2/XWpaGf3fkqSdL652ayQBJFg
         CBKrZFaOeQ65g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E2F6F5C0DFD; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/9] rcu-tasks: Make show_rcu_tasks_generic_gp_kthread() check all CPUs
Date:   Mon, 18 Apr 2022 17:00:12 -0700
Message-Id: <20220419000014.3948512-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
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

Currently, the show_rcu_tasks_generic_gp_kthread() function only looks
at CPU 0's callback lists.  Although this is not fatal, it can confuse
debugging efforts in cases where any of the Tasks RCU flavors are in
per-CPU queueing mode.  This commit therefore causes this function to
scan all CPUs' callback queues.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 405614039515..3aad0dfbfaf4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -582,7 +582,17 @@ static void __init rcu_tasks_bootup_oddness(void)
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
-	struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, 0); // for_each...
+	int cpu;
+	bool havecbs = false;
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+
+		if (!data_race(rcu_segcblist_empty(&rtpcp->cblist))) {
+			havecbs = true;
+			break;
+		}
+	}
 	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
@@ -590,7 +600,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		data_race(rcu_seq_current(&rtp->tasks_gp_seq)),
 		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
-		".C"[!data_race(rcu_segcblist_empty(&rtpcp->cblist))],
+		".C"[havecbs],
 		s);
 }
 #endif // #ifndef CONFIG_TINY_RCU
-- 
2.31.1.189.g2e36527f23

