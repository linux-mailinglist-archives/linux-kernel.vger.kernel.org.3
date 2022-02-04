Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACAE4AA484
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378549AbiBDXjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378269AbiBDXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B651E025B34;
        Fri,  4 Feb 2022 15:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14F00B83961;
        Fri,  4 Feb 2022 23:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7763CC340FF;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=Q0Hs9+xdt5kC0I4NW3DFLJXE6gilkL4WWu77Q0NgULo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPQYS/2yHEy5lqMaWQ3v73ycqTdQ4l/7422evQyMBa8ez3GmlR4LdHOjXQluVzmyj
         cCMn44aX+64HG1a9xsi3wJvmFYpSnBzwcxKdGtDwF2prNpcjXkQebXgyAOR4UCCNGj
         BER/+BePZGePl5csnYBc7HpIZzKNNsEkgQ7Dpp5kvLi3pNiFqe/wyK7h8D0zlLfQZg
         HWI5BdbxjItvCoD0H75Zr/fR+d6hn0XAsx17dLpBjdXCwesud0L9VXbaP0etrdDAGu
         ulMyr8AajqQv6s0CoOJDjLHuONTz/OyjEf3sRwHxhfWOjnAZ2TVrkAmhINXdJnwJiI
         VRQ9P6PzWm6bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 08DAA5C0E5E; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/19] srcu: Avoid NULL dereference in srcu_torture_stats_print()
Date:   Fri,  4 Feb 2022 15:38:55 -0800
Message-Id: <20220204233902.1902-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 62 ++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 4201815744d85..767487ad5440a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1448,37 +1448,43 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
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

