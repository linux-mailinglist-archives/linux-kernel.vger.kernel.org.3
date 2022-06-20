Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7963555272D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbiFTWvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbiFTWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CAB1A80D;
        Mon, 20 Jun 2022 15:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA5A61378;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BE0C341C5;
        Mon, 20 Jun 2022 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=4G4xhoKc12qiOwxNZEkiwils26Lw6k3UWPCNhm+OVaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgCF2a3LZwzaoZLX1CZ2JJZ4zXx9lPMSosji41ZfahtZOlYcEad+5rFm6lDUyAdyE
         keskLfxkaAg0re3wE/qku8tn0+8rTxZZRNMm0EzUwlqfPsIWJl69P38ZiSaYpJwAP2
         k3GSf1jKv1zSr4L64/Y3Y484ky1M9FqATPOTdv54RN7SVK3aqna3I+SqyMgyWkB+YL
         02iLT1U79RB/EVYo6hefNb5Dd0qqO8q2e2LMx237bz9p2kY63b5XRltsAx9SGhqUTM
         hwlOtM4h9NJtbZ6wEjQV3vY9gWv7SXEAnW/rZ7Jibqt+CUmioiapd1rCBWyYSuCpbo
         W1f00ZgPK35jA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 96EAF5C0A15; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 03/12] rcutorture: Validate get_completed_synchronize_rcu()
Date:   Mon, 20 Jun 2022 15:51:19 -0700
Message-Id: <20220620225128.3842050-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
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

This commit verifies that the RCU grace-period state cookie returned
from get_completed_synchronize_rcu() causes poll_state_synchronize_rcu()
to return true, as required.

This commit is in preparation for polled expedited grace periods.

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7120165a93426..4ceec9f4169c7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -338,6 +338,7 @@ struct rcu_torture_ops {
 	void (*sync)(void);
 	void (*exp_sync)(void);
 	unsigned long (*get_gp_state)(void);
+	unsigned long (*get_gp_completed)(void);
 	unsigned long (*start_gp_poll)(void);
 	bool (*poll_gp_state)(unsigned long oldstate);
 	void (*cond_sync)(unsigned long oldstate);
@@ -504,6 +505,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.sync			= synchronize_rcu,
 	.exp_sync		= synchronize_rcu_expedited,
 	.get_gp_state		= get_state_synchronize_rcu,
+	.get_gp_completed	= get_completed_synchronize_rcu,
 	.start_gp_poll		= start_poll_synchronize_rcu,
 	.poll_gp_state		= poll_state_synchronize_rcu,
 	.cond_sync		= cond_synchronize_rcu,
@@ -1254,6 +1256,10 @@ rcu_torture_writer(void *arg)
 					  rcu_torture_writer_state_getname(),
 					  rcu_torture_writer_state,
 					  cookie, cur_ops->get_gp_state());
+				if (cur_ops->get_gp_completed) {
+					cookie = cur_ops->get_gp_completed();
+					WARN_ON_ONCE(!cur_ops->poll_gp_state(cookie));
+				}
 				cur_ops->readunlock(idx);
 			}
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
-- 
2.31.1.189.g2e36527f23

