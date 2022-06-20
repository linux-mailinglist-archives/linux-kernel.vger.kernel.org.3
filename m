Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5022555275A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbiFTXAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345985AbiFTW7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C2193ED;
        Mon, 20 Jun 2022 15:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C20FB81648;
        Mon, 20 Jun 2022 22:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4A6C3411C;
        Mon, 20 Jun 2022 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765899;
        bh=QB+6LQTkN+uqZYbqwmaKGD7m8QpRVVwgyBZwUwDHoxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OO54a6KIBy4pG/XzhjsMPffHPMlq5+fx7rjTjbeglGcTg02CKD0LKom2MH7EwFE2L
         50/WgmVWiPOqlELWWdoSDVkOM2rQPyQBzbrWm0WrrN5tCfr/UgBQvwVuwi+fR3sxxv
         8IdRGGgf2TXx2fn8H14yeWf8S2bd8Ir56HaqxlewHmn0DCdsnWtLJm98O19/wlKs3l
         VSJVRbHjn6B3Mt5TmZojKji26KioaMBlYE1QAV2r6iNdJttTRnblhQfOFvCZG3S5IB
         2eBIA9zeWUiNM3NINHQMUzV/A968dflvFdXqIGfZiNF8HwJedGSd6Qekr0ynPG2JPE
         KIFRuW3whfM0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 979055C05C8; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Benedikt Spranger <b.spranger@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/12] rcu/torture: Change order of warning and trace dump
Date:   Mon, 20 Jun 2022 15:58:07 -0700
Message-Id: <20220620225817.3843106-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
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

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

Dumping a big ftrace buffer could lead to a RCU stall. So there is the
ftrace buffer and the stall information which needs to be printed. When
there is additionaly a WARN_ON() which describes the reason for the ftrace
buffer dump and the WARN_ON() is executed _after_ ftrace buffer dump, the
information get lost in the middle of the RCU stall information.

Therefore print WARN_ON() message before dumping the ftrace buffer in
rcu_torture_writer().

[ paulmck: Add tracing_off() to avoid cruft from WARN(). ]

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7120165a93426..3032dd7c7ad35 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1321,8 +1321,9 @@ rcu_torture_writer(void *arg)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) !=
 				    &rcu_tortures[i]) {
-					rcu_ftrace_dump(DUMP_ALL);
+					tracing_off();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
+					rcu_ftrace_dump(DUMP_ALL);
 				}
 		if (stutter_waited)
 			sched_set_normal(current, oldnice);
-- 
2.31.1.189.g2e36527f23

