Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5065A8546
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiHaSPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiHaSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E6EE6AB;
        Wed, 31 Aug 2022 11:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2851161C77;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AEEC433D7;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=2IUtHz4jkuLMZGxJz7R754/GACgS+v0YbUrl2b5jzbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4xO2XP1T7kYv98HPLEHDo7C3MA6RBFUE8NWVdTwBdgHnwzkbTz+LJPjyU1KIF/IL
         q7BDP3u+3LSxXiwpH/jc7bS2QSy9l9zDnleKDEK7TUnSAzhi1ifeaHKXb0RkURFy0V
         w8s2uuHIZeKOmDV/Gnd7jffBLHcTXT4LJe1B31pTJ5FmhHQluSbV4w7iQA0iWisUcV
         ExBjTeK4NE0fG2zDN3jZZFEeqZwyHFkiOnXFcmwgADneLFBHmqpkeiAiAaxSVFg7+x
         aEjRzSAXInHF2ZFGfaaz3liw1623CGErJXq1mYOEwScMWtPlp/dYtTocZyKuUYeSg8
         Vll6LS5eWJHWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7A1C75C0E68; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 19/25] rcu: Remove ->rgos_polled field from rcu_gp_oldstate structure
Date:   Wed, 31 Aug 2022 11:12:04 -0700
Message-Id: <20220831181210.2695080-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
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

Because both normal and expedited grace periods increment their respective
counters on their pre-scheduler early boot fastpaths, the rcu_gp_oldstate
structure no longer needs its ->rgos_polled field.  This commit therefore
removes this field, shrinking this structure so that it is the same size
as an rcu_head structure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutree.h | 1 -
 kernel/rcu/tree.c       | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 755b082f4ec62..455a03bdce152 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -44,7 +44,6 @@ bool rcu_gp_might_be_stalled(void);
 struct rcu_gp_oldstate {
 	unsigned long rgos_norm;
 	unsigned long rgos_exp;
-	unsigned long rgos_polled;
 };
 
 unsigned long start_poll_synchronize_rcu_expedited(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8fa5ec0f3d111..b9e8ed00536d4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3526,7 +3526,6 @@ void get_completed_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 {
 	rgosp->rgos_norm = RCU_GET_STATE_COMPLETED;
 	rgosp->rgos_exp = RCU_GET_STATE_COMPLETED;
-	rgosp->rgos_polled = RCU_GET_STATE_COMPLETED;
 }
 EXPORT_SYMBOL_GPL(get_completed_synchronize_rcu_full);
 
@@ -3575,7 +3574,6 @@ void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 	smp_mb();  /* ^^^ */
 	rgosp->rgos_norm = rcu_seq_snap(&rnp->gp_seq);
 	rgosp->rgos_exp = rcu_seq_snap(&rcu_state.expedited_sequence);
-	rgosp->rgos_polled = rcu_seq_snap(&rcu_state.gp_seq_polled);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu_full);
 
@@ -3727,9 +3725,7 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 	if (rgosp->rgos_norm == RCU_GET_STATE_COMPLETED ||
 	    rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
 	    rgosp->rgos_exp == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp) ||
-	    rgosp->rgos_polled == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rcu_state.gp_seq_polled, rgosp->rgos_polled)) {
+	    rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
-- 
2.31.1.189.g2e36527f23

