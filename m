Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9895B506083
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiDSAGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbiDSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0572317E;
        Mon, 18 Apr 2022 17:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20FB1612D0;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CF9C385BA;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=yD8/2f4i74rv4I75fc7QN5JRO3/GVs7/E4TdpFpPISc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8q1Cv0Vkp9q/MSz5wqfJReVoVMUwgvmUz05/uY8RS055LvWx/W+JI1bSz3Is/ZF3
         IUxNeKNZ+Mhn0pvn4N3ww4zCDyaRswoa5ikzO8JKIMYKKnssJEVK62xfx9Fz8zvuoz
         9Tdzzv4U7sIanHJZPGP83cSVCq9WSvhhTR0b+s9M9FTWDjwG1drc51ncTX8wh794Ho
         3HKIUl5pjft6Iltsrdko7douITCeRHpiscJ3Clug/FV35HF0ga/bnFWXx0JbpqlAdq
         lz4PGDv0xOOXhLNxtxrb6bsJlAHxUGp+C0mHhAP7yyvFYLtnhzYZUnlvn2PWsjxq6o
         DHcOvA7ZRgF4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 644845C23F4; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 13/21] srcu: Avoid NULL dereference in srcu_torture_stats_print()
Date:   Mon, 18 Apr 2022 17:03:14 -0700
Message-Id: <20220419000322.3948903-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

You really shouldn't invoke srcu_torture_stats_print() after invoking
cleanup_srcu_struct(), but there is really no reason to get a
compiler-obfuscated per-CPU-variable NULL pointer dereference as the
diagnostic.  This commit therefore checks for NULL ->sda and makes a
more polite console-message complaint in that case.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 62 ++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9dd048989027..b7138dbe1a2d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1477,37 +1477,43 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 	idx = ssp->srcu_idx & 0x1;
 	if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
 		ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;
-	pr_alert("%s%s Tree SRCU g%ld state %d (%s) per-CPU(idx=%d):",
+	pr_alert("%s%s Tree SRCU g%ld state %d (%s)",
 		 tt, tf, rcu_seq_current(&ssp->srcu_gp_seq), ss_state,
-		 srcu_size_state_name[ss_state_idx], idx);
-	for_each_possible_cpu(cpu) {
-		unsigned long l0, l1;
-		unsigned long u0, u1;
-		long c0, c1;
-		struct srcu_data *sdp;
-
-		sdp = per_cpu_ptr(ssp->sda, cpu);
-		u0 = data_race(sdp->srcu_unlock_count[!idx]);
-		u1 = data_race(sdp->srcu_unlock_count[idx]);
+		 srcu_size_state_name[ss_state_idx]);
+	if (!ssp->sda) {
+		// Called after cleanup_srcu_struct(), perhaps.
+		pr_cont(" No per-CPU srcu_data structures (->sda == NULL).\n");
+	} else {
+		pr_cont(" per-CPU(idx=%d):", idx);
+		for_each_possible_cpu(cpu) {
+			unsigned long l0, l1;
+			unsigned long u0, u1;
+			long c0, c1;
+			struct srcu_data *sdp;
 
-		/*
-		 * Make sure that a lock is always counted if the corresponding
-		 * unlock is counted.
-		 */
-		smp_rmb();
-
-		l0 = data_race(sdp->srcu_lock_count[!idx]);
-		l1 = data_race(sdp->srcu_lock_count[idx]);
-
-		c0 = l0 - u0;
-		c1 = l1 - u1;
-		pr_cont(" %d(%ld,%ld %c)",
-			cpu, c0, c1,
-			"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]);
-		s0 += c0;
-		s1 += c1;
+			sdp = per_cpu_ptr(ssp->sda, cpu);
+			u0 = data_race(sdp->srcu_unlock_count[!idx]);
+			u1 = data_race(sdp->srcu_unlock_count[idx]);
+
+			/*
+			 * Make sure that a lock is always counted if the corresponding
+			 * unlock is counted.
+			 */
+			smp_rmb();
+
+			l0 = data_race(sdp->srcu_lock_count[!idx]);
+			l1 = data_race(sdp->srcu_lock_count[idx]);
+
+			c0 = l0 - u0;
+			c1 = l1 - u1;
+			pr_cont(" %d(%ld,%ld %c)",
+				cpu, c0, c1,
+				"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]);
+			s0 += c0;
+			s1 += c1;
+		}
+		pr_cont(" T(%ld,%ld)\n", s0, s1);
 	}
-	pr_cont(" T(%ld,%ld)\n", s0, s1);
 	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 2)
 		WRITE_ONCE(ssp->srcu_size_state, SRCU_SIZE_ALLOC);
 }
-- 
2.31.1.189.g2e36527f23

