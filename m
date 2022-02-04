Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B9E4AA4AA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378498AbiBDXxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378372AbiBDXxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5360CC06C947;
        Fri,  4 Feb 2022 15:53:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E226B61CD2;
        Fri,  4 Feb 2022 23:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32A5C340FB;
        Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018810;
        bh=DMOYvBAXRRoyhUBWRSAHpF/K+fQJIPweBMqt5Vj1ut4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBYslGhwBQmT+Vmi/yvglKk9gle9XuyxAV9Hu8qw8KkKubmzitiBFmK3HWguDf5t7
         oASQMjriPISvy+9Ucl5DzJEGyNlBRSkJ07H4FCosb1SPcot3euRLOebTIvOMMBeEbM
         hVaj+S4sGQP8jWpAL7kHRMKR4TjatpxTy+Ff364TPtbUUA53XXFVR9r6JKLOO5W+Tj
         XSuf83pCL1TwbLqLXv9pR6vzs5cYx++tLfqZWto45n2mHQknl1Bn7wj/3ja+JRtJ9+
         YtwCzjyGgKMMRhOxXv4URAxe+aiZAmiUDeiSJ+pWMm0sA0/4OK3dlpsmffp5fiqbM4
         ekunvp1ng26IA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 828025C0A6A; Fri,  4 Feb 2022 15:53:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/8] rcutorture: Enable limited callback-flooding tests of SRCU
Date:   Fri,  4 Feb 2022 15:53:27 -0800
Message-Id: <20220204235327.2948-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
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

This commit allows up to 50,000 callbacks worth of callback-flooding
tests of SRCU.  The goal of this change is to exercise Tree SRCU's
ability to transition from SRCU_SIZE_SMALL to SRCU_SIZE_BIG triggered
by callback-queue-time lock contention.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1c8f40b90f70b..b41db719085ef 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -674,6 +674,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.name		= "srcu"
@@ -708,6 +709,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.name		= "srcud"
-- 
2.31.1.189.g2e36527f23

