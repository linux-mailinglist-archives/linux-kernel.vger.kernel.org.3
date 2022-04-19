Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848305060AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiDSAK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbiDSAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088DE3A7;
        Mon, 18 Apr 2022 17:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2887B81128;
        Tue, 19 Apr 2022 00:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CC2C385A7;
        Tue, 19 Apr 2022 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326869;
        bh=foMf23lIes/rMz31pIG7k0ikz3d3jyzbGaaxO/rqneQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDWcWieJ9hUB60S2H6udEw6eCNgTrAhp+Z3TGaTP0n5G3sZ6ZHCP+jhTfTkAvunk3
         L5h+oVLbidYo6TcZDIwKBrZctHuvWKMCv7i+8qiCoBHB556yqWcXuVIGM+Bts8Ef1o
         UrZYZT7YPoQpuYbY/DqrMNeMgr4SnijxW+vpi4I3BEryq+CcRk1wduxT/qC0wXv1jQ
         2VkiJ06d6iQ2M6HQfHsBKG1vbdVCqmeSwcLcRTpjxcDTWJW2N3T1XNVTKxFrJk7yth
         LH3v3zbi1zdlvNGMlpOJe4NtQMGT3fGdJ1aGetddvEKTpypjJSXLoVbjlYmVC5FuGH
         hbeN8BgQmN2yg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2887A5C0A23; Mon, 18 Apr 2022 17:07:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, David Vernet <void@manifault.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/6] rcutorture: Add missing return and use __func__ in warning
Date:   Mon, 18 Apr 2022 17:07:45 -0700
Message-Id: <20220419000746.3949667-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
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

From: David Vernet <void@manifault.com>

The rcutorture module has an rcu_torture_writer task that repeatedly
performs writes, synchronizations, and deletes. There is a corner-case
check in rcu_torture_writer() wherein if nsynctypes is 0, a warning is
issued and the task waits to be stopped via a call to
torture_kthread_stopping() rather than performing any work.

There should be a return statement following this call to
torture_kthread_stopping(), as the intention with issuing the call to
torture_kthread_stopping() in the first place is to avoid the
rcu_torture_writer task from performing any work. Some of the work may even
be dangerous to perform, such as potentially causing a #DE due to
nsynctypes being used in a modulo operator when querying for sync updates
to issue.

This patch adds the missing return call.  As a bonus, it also fixes a
checkpatch warning that was emitted due to the WARN_ONCE() call using the
name of the function rather than __func__.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d5105fb6c980..f1292d9e86b5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1178,7 +1178,7 @@ rcu_torture_writer(void *arg)
 			 " GP expediting controlled from boot/sysfs for %s.\n",
 			 torture_type, cur_ops->name);
 	if (WARN_ONCE(nsynctypes == 0,
-		      "rcu_torture_writer: No update-side primitives.\n")) {
+		      "%s: No update-side primitives.\n", __func__)) {
 		/*
 		 * No updates primitives, so don't try updating.
 		 * The resulting test won't be testing much, hence the
@@ -1186,6 +1186,7 @@ rcu_torture_writer(void *arg)
 		 */
 		rcu_torture_writer_state = RTWS_STOPPING;
 		torture_kthread_stopping("rcu_torture_writer");
+		return 0;
 	}
 
 	do {
-- 
2.31.1.189.g2e36527f23

