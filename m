Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C33506088
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiDSAH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiDSAGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06C1FA7E;
        Mon, 18 Apr 2022 17:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61FA1B81142;
        Tue, 19 Apr 2022 00:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5655AC385CB;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=UYudwu1QrF7TbcsMmA2KTg1pYLeL053zgVc8k9emey8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0KjUbQ6RmtdKOR9u22u/p1b8WtaU3OW9MgNbw68SjOFVxyrgJ14FEVxnqaJTDdkm
         IeFMPr7qYL1SN4hcRLnBT0kKRKSVltLRibOhKu9HYwf+HVI1NIl3jk9eKOTV0GpsYO
         6wZoWy6NeAsN4tYzLXbYhcKyqSYcc63GaANK/+DGz6DuSAgdVIUgs+E5ljAzbuwnQ4
         9N/2I9aIRJkAxZtRV+vp/1NQqOg3E6jeLSWcSbYvB261tkxR0Uettttmrzzc5nnwl2
         CFx/iFR1vwiGQ93Nvhcd6ZjPeBHvJnNiIAyvlxEVni1mgYf4QnDRIkbtMKpY4AIICA
         HxMheCjm7gRDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 72BA55C30EA; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 21/21] srcu: Drop needless initialization of sdp in srcu_gp_start()
Date:   Mon, 18 Apr 2022 17:03:22 -0700
Message-Id: <20220419000322.3948903-21-paulmck@kernel.org>
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

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Commit 9c7ef4c30f12 ("srcu: Make Tree SRCU able to operate without
snp_node array") initializes the local variable sdp differently depending
on the srcu's state in srcu_gp_start().  Either way, this initialization
overwrites the value used when sdp is defined.

This commit therefore drops this pointless definition-time initialization.
Although there is no functional change, compiler code generation may
be affected.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6dd44e759f12..50ba70f019de 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -620,7 +620,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 static void srcu_gp_start(struct srcu_struct *ssp)
 {
-	struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
+	struct srcu_data *sdp;
 	int state;
 
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-- 
2.31.1.189.g2e36527f23

