Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F15526E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiFTWVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiFTWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86F1BE83;
        Mon, 20 Jun 2022 15:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3414EB8164F;
        Mon, 20 Jun 2022 22:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A044BC385A5;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=omFpL6AjD/2c4cDtQPge8eB3hsr4UIqIh5fcwI+Snkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2aeUhfRA6yU94xu33SIBxrDD57PJ6/AHIPrCffkBFV5gVousgGB1b846unb/VpRy
         cMQP65ZV6scdrQ6TLcRXTdFEpb0GDzoUiMiwtP0n4FOTFknI0+spFUYlZ2gjbEB2Af
         TlPELayCfcl8at4ZRGrAN/4BGwnFhI/75T7Zuz5auaP/eWZTdIFnG+grDhBMwKOLqU
         kL3eHj6slDghDWmoJ+eCVddp9c/3E+Yj+KWjM7OGXBN6ZVprlz0IRHl8/D/XGyBFz6
         gl4AtLRBC6uFPyDovbpFpr43bVu6b39hiOaU517jCenTcgiLJPiHwtRGRV/MiTo0M1
         MROJ5LXCvK+zQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E8F25C0DAC; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 10/12] rcu: Initialize first_gp_fqs at declaration in rcu_gp_fqs()
Date:   Mon, 20 Jun 2022 15:20:30 -0700
Message-Id: <20220620222032.3839547-10-paulmck@kernel.org>
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

This commit saves a line of code by initializing the rcu_gp_fqs()
function's first_gp_fqs local variable in its declaration.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Reported-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7919d7b48fa6a..7d8e9cb852786 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1971,13 +1971,12 @@ static void rcu_gp_fqs(bool first_time)
  */
 static noinline_for_stack void rcu_gp_fqs_loop(void)
 {
-	bool first_gp_fqs;
+	bool first_gp_fqs = true;
 	int gf = 0;
 	unsigned long j;
 	int ret;
 	struct rcu_node *rnp = rcu_get_root();
 
-	first_gp_fqs = true;
 	j = READ_ONCE(jiffies_till_first_fqs);
 	if (rcu_state.cbovld)
 		gf = RCU_GP_FLAG_OVLD;
-- 
2.31.1.189.g2e36527f23

