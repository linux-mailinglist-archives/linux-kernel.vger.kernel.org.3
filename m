Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A925A8537
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiHaSN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiHaSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DFDD4D4;
        Wed, 31 Aug 2022 11:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7734CB82279;
        Wed, 31 Aug 2022 18:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A208C4315B;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=40Nnav/fNtUmhr+7K11apGq8VNSLD9p1jp36HWLtzQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwdrN3SGDh6mPT7Y+RXAIAjlKNRPsu9f3eECC/Pio7JTE7uYmovPPU8VEJnn/SaME
         qVj08MusyyJn7qJebM4oYA78qW/1HwbG4+MrL3LosvCL4QZmKyf+JN0MQvnhdIvhrR
         WaUjTqbCIAApySP+arURJVxjLNFTVYhdK6hqLIC5K0H1DfnsGcRQ9hZwX9D+SIm97Q
         5Rrt/Pf6ZkPzQ+BT2KCTdr+oEwI3CSrza8ORmyHA/wN39z6YwJYBA0od8hq6zx3PaM
         5NyxvK65qP1VsY/l9neu41lz8KDIPnoCIecti7XUipydP46KiZ+jqg5uiKauOVFksB
         1g3Xf47QMEfZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 82A365C0ED7; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 24/25] rcu: Add functions to compare grace-period state values
Date:   Wed, 31 Aug 2022 11:12:09 -0700
Message-Id: <20220831181210.2695080-24-paulmck@kernel.org>
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

This commit adds same_state_synchronize_rcu() and
same_state_synchronize_rcu_full() functions to compare grace-period state
values, for example, those obtained from get_state_synchronize_rcu()
and get_state_synchronize_rcu_full().  These functions allow small
structures to omit these state values by placing them in list headers for
lists containing structures with the same token value.  Presumably the
per-structure list pointers are the same ones used to link the structures
into whatever reader-accessible data structure was used.

This commit also adds both NUM_ACTIVE_RCU_POLL_OLDSTATE and
NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE, which define the maximum number of
distinct unsigned long values and rcu_gp_oldstate values, respectively,
corresponding to not-yet-completed grace periods.  These values can be
used to size arrays of the list headers described above.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 21 +++++++++++++++++++++
 include/linux/rcutiny.h  | 14 ++++++++++++++
 include/linux/rcutree.h  | 28 ++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index faaa174dfb27c..9941d5c3d5e19 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -47,6 +47,27 @@ struct rcu_gp_oldstate;
 unsigned long get_completed_synchronize_rcu(void);
 void get_completed_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
 
+// Maximum number of unsigned long values corresponding to
+// not-yet-completed RCU grace periods.
+#define NUM_ACTIVE_RCU_POLL_OLDSTATE 2
+
+/**
+ * same_state_synchronize_rcu - Are two old-state values identical?
+ * @oldstate1: First old-state value.
+ * @oldstate2: Second old-state value.
+ *
+ * The two old-state values must have been obtained from either
+ * get_state_synchronize_rcu(), start_poll_synchronize_rcu(), or
+ * get_completed_synchronize_rcu().  Returns @true if the two values are
+ * identical and @false otherwise.  This allows structures whose lifetimes
+ * are tracked by old-state values to push these values to a list header,
+ * allowing those structures to be slightly smaller.
+ */
+static inline bool same_state_synchronize_rcu(unsigned long oldstate1, unsigned long oldstate2)
+{
+	return oldstate1 == oldstate2;
+}
+
 #ifdef CONFIG_PREEMPT_RCU
 
 void __rcu_read_lock(void);
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 4405e9112cee8..768196a5f39d6 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -18,6 +18,20 @@ struct rcu_gp_oldstate {
 	unsigned long rgos_norm;
 };
 
+// Maximum number of rcu_gp_oldstate values corresponding to
+// not-yet-completed RCU grace periods.
+#define NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE 2
+
+/*
+ * Are the two oldstate values the same?  See the Tree RCU version for
+ * docbook header.
+ */
+static inline bool same_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp1,
+						   struct rcu_gp_oldstate *rgosp2)
+{
+	return rgosp1->rgos_norm == rgosp2->rgos_norm;
+}
+
 unsigned long get_state_synchronize_rcu(void);
 
 static inline void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 455a03bdce152..5efb51486e8af 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -46,6 +46,34 @@ struct rcu_gp_oldstate {
 	unsigned long rgos_exp;
 };
 
+// Maximum number of rcu_gp_oldstate values corresponding to
+// not-yet-completed RCU grace periods.
+#define NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE 4
+
+/**
+ * same_state_synchronize_rcu_full - Are two old-state values identical?
+ * @rgosp1: First old-state value.
+ * @rgosp2: Second old-state value.
+ *
+ * The two old-state values must have been obtained from either
+ * get_state_synchronize_rcu_full(), start_poll_synchronize_rcu_full(),
+ * or get_completed_synchronize_rcu_full().  Returns @true if the two
+ * values are identical and @false otherwise.  This allows structures
+ * whose lifetimes are tracked by old-state values to push these values
+ * to a list header, allowing those structures to be slightly smaller.
+ *
+ * Note that equality is judged on a bitwise basis, so that an
+ * @rcu_gp_oldstate structure with an already-completed state in one field
+ * will compare not-equal to a structure with an already-completed state
+ * in the other field.  After all, the @rcu_gp_oldstate structure is opaque
+ * so how did such a situation come to pass in the first place?
+ */
+static inline bool same_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp1,
+						   struct rcu_gp_oldstate *rgosp2)
+{
+	return rgosp1->rgos_norm == rgosp2->rgos_norm && rgosp1->rgos_exp == rgosp2->rgos_exp;
+}
+
 unsigned long start_poll_synchronize_rcu_expedited(void);
 void start_poll_synchronize_rcu_expedited_full(struct rcu_gp_oldstate *rgosp);
 void cond_synchronize_rcu_expedited(unsigned long oldstate);
-- 
2.31.1.189.g2e36527f23

