Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101E5526DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbiFTWUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243870AbiFTWUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD371B796;
        Mon, 20 Jun 2022 15:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C93611D9;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415DAC3411B;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=jG3hNc3HY7o8s2RFDc2C+XAxckGdI/PbpjhwaH1AXKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXh1cizEODZ4SMedxiPCazh6QGP5XJe+ddgxpEMuYmJ7YyDrh8UglNT2xW5j7mB19
         DY8TvVoI9SwRXzF354hU/qLIUlY1JEk0CYtiaFHsB33lZUdS6xWlDUPEd2hTq+leNJ
         TGvtgjGHXU42yI41xTbYXRtkiHNWaOVK/MMG6XqYQF1HvnXU1C9C+XVUmSzf5UMtd2
         c1uKiHRF1NHTl50JRyXFZC8HiqWj69y+TleFGWEAtEfLS3L6f1in3Vv5MZFozPT4/3
         yIJ7C5ycqtulJ3+J+ex53zm8FmPehhnd2q+ml/i7kTvl1DC2SAMGZ+oNARhWvvC73B
         YeKVhUjonEthg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F13D25C05B9; Mon, 20 Jun 2022 15:20:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/12] rcu: Decrease FQS scan wait time in case of callback overloading
Date:   Mon, 20 Jun 2022 15:20:21 -0700
Message-Id: <20220620222032.3839547-1-paulmck@kernel.org>
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

The force-quiesce-state loop function rcu_gp_fqs_loop() checks for
callback overloading and does an immediate initial scan for idle CPUs
if so.  However, subsequent rescans will be carried out at as leisurely a
rate as they always are, as specified by the rcutree.jiffies_till_next_fqs
module parameter.  It might be tempting to just continue immediately
rescanning, but this turns the RCU grace-period kthread into a CPU hog.
It might also be tempting to reduce the time between rescans to a single
jiffy, but this can be problematic on larger systems.

This commit therefore divides the normal time between rescans by three,
rounding up.  Thus a small system running at HZ=1000 that is suffering
from callback overload will wait only one jiffy instead of the normal
three between rescans.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c25ba442044a6..c19d5926886fb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1993,6 +1993,11 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 				   jiffies + (j ? 3 * j : 2));
 		}
+		if (rcu_state.cbovld) {
+			j = (j + 2) / 3;
+			if (j <= 0)
+				j = 1;
+		}
 		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 				       TPS("fqswait"));
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
-- 
2.31.1.189.g2e36527f23

