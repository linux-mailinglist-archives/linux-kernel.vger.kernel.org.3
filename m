Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B7D5526EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbiFTWVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiFTWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D391BE85;
        Mon, 20 Jun 2022 15:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB9761302;
        Mon, 20 Jun 2022 22:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7EBC341D0;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=fOc9xTo9noQUtXSDMR5WJIHkNdSsrsFNVIlNlxZLH50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0KJoIJTBJ+Y5jVRE5E9CD1dTRHBWAelLTfseUbGLRi//UzfbXpIj2iU3U8ztQBA5
         vH3rIZ2w8GVUpAdInHNPSbUVl3whA41c94ptNMeNk5S/rkeCW8GGm1vr6zd9+wWrqL
         uerl/BEvUgOEKmTP6rECBCHPyh/UxUQw1pT+EdWUw9r2EP+D1taP4xHobKAfcqlPqJ
         fL6nhguLD4Swe9JLL3bI43S7ZVOgdXZipgjLqmYSDakQCR0ExaSdP1r38naqvNmDCJ
         F8KilofCaGy7EVh6o/K5wYDPSTOayGrQy2lWkpbgKiJZxT6ZV/1wP/4bxWwmW1n0H+
         qHinlt9FnH/FA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 122A85C0E3F; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH rcu 12/12] srcu: Block less aggressively for expedited grace periods
Date:   Mon, 20 Jun 2022 15:20:32 -0700
Message-Id: <20220620222032.3839547-12-paulmck@kernel.org>
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

Commit 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
from consuming CPU") fixed a problem where a long-running expedited SRCU
grace period could block kernel live patching.  It did so by giving up
on expediting once a given SRCU expedited grace period grew too old.

Unfortunately, this added excessive delays to boots of embedded systems
running on qemu that use the ARM IORT RMR feature.  This commit therefore
makes the transition away from expediting less aggressive, increasing
the per-grace-period phase number of non-sleeping polls of readers from
one to three and increasing the required grace-period age from one jiffy
(actually from zero to one jiffies) to two jiffies (actually from one
to two jiffies).

Fixes: 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reported-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reported-by: chenxiang (M)" <chenxiang66@hisilicon.com>
Cc: Shameerali Kolothum Thodi  <shameerali.kolothum.thodi@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/all/20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org/
---
 kernel/rcu/srcutree.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 50ba70f019dea..0db7873f4e95b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -513,7 +513,7 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 
 #define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
 #define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
-#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase consecutive no-delay instances.
+#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
 #define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
 
 /*
@@ -522,16 +522,22 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
  */
 static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 {
+	unsigned long gpstart;
+	unsigned long j;
 	unsigned long jbase = SRCU_INTERVAL;
 
 	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
 		jbase = 0;
-	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
-		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
-	if (!jbase) {
-		WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
-		if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
-			jbase = 1;
+	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
+		j = jiffies - 1;
+		gpstart = READ_ONCE(ssp->srcu_gp_start);
+		if (time_after(j, gpstart))
+			jbase += j - gpstart;
+		if (!jbase) {
+			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
+			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
+				jbase = 1;
+		}
 	}
 	return jbase > SRCU_MAX_INTERVAL ? SRCU_MAX_INTERVAL : jbase;
 }
-- 
2.31.1.189.g2e36527f23

