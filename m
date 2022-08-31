Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F465A8538
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiHaSOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiHaSNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43197E7243;
        Wed, 31 Aug 2022 11:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A803B82273;
        Wed, 31 Aug 2022 18:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD19C433B5;
        Wed, 31 Aug 2022 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969446;
        bh=RUFHG/k2inBKsfsfPIko0AaoBZnwqbkHwx1FvhaHJSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAbB+KfK+QjMTUCkFi6skSO/D3TFLksYWWsmQOAmZmYENp5U5nBxyqOKLwFZkTVxv
         WeXXBbJY9lbxu84Kvxbve9rHCMCWROyRH4uCa9ANhri4kycBE3hGVhsJWkJLrjYEZu
         KHP9aQEV0Ep6opmXfVhH+lEKPFecMWNzl2rk+wfaTDgOdmDglCa2S52XhnyF0K579l
         gRh8TomuqrfGIOOzJxq/6CYg09Ftivq5hVmDUqrGAAvYE9drIA52SjcP8rfroQYXbm
         hOZhLFJORAMQJv4zXiCando23xvZUarD0mjKInevcCWI+KeFKKOeQdpA+LIV0HgoOU
         RA110V6ahvERw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 081635C015D; Wed, 31 Aug 2022 11:10:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] rcu/nocb: Choose the right rcuog/rcuop kthreads to output
Date:   Wed, 31 Aug 2022 11:10:42 -0700
Message-Id: <20220831181044.2694488-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
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

The show_rcu_nocb_gp_state() function is supposed to dump out the rcuog
kthread and the show_rcu_nocb_state() function is supposed to dump out
the rcuo[ps] kthread.  Currently, both do a mixture, which is not optimal
for debugging, even though it does not affect functionality.

This commit therefore adjusts these two functions to focus on their
respective kthreads.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index a8f574d8850d2..f20aec4f4394b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1452,8 +1452,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		(long)rdp->nocb_gp_seq,
 		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
 		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
-		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
-		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
+		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		show_rcu_should_be_on_cpu(rdp->nocb_gp_kthread));
 }
 
 /* Dump out nocb kthread state for the specified rcu_data structure. */
@@ -1497,7 +1497,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
 		rcu_segcblist_n_cbs(&rdp->cblist),
 		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
-		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
 		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 
 	/* It is OK for GP kthreads to have GP state. */
-- 
2.31.1.189.g2e36527f23

