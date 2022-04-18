Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4594505FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiDRWx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiDRWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4931EC4C;
        Mon, 18 Apr 2022 15:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DF7961037;
        Mon, 18 Apr 2022 22:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42A6C385BC;
        Mon, 18 Apr 2022 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322235;
        bh=wmIlJ6/WDhkwaS97Yp3hE9UBlU+pg5c4XkawO23USPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUf7hJeKSLN3EUbzA3zrBuE0KCPYD2lpi6Cuee795GBF+pz306tBJ5vWmPMJ7NceF
         s/TNMIJhjWU2I8Xx1MdfhmunIwwU0yMhq2sujc9qKqdlKIUDtLGpy0Df3XVLvR0X21
         95/wzCrLbJacXSYx5h9RA5aQ/z8ZFX+Ir5tZfcbGcJfesaKA/1BAvGvdgHj28LrDqp
         GzFus2OpAg10cz6zJuafMjVZTU5vL5mVNMzzOD9BlSvvFgsiHOHgBY9bgTL4ymui86
         Ro5nJe2tKwOF1c1v7G5qjYCW5QgpYwSWDv9tCLWu001Q+RydFFaY6ZpHpvEutHAmGv
         w/YxqLYObX/8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 85B565C04BD; Mon, 18 Apr 2022 15:50:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU flavors
Date:   Mon, 18 Apr 2022 15:50:32 -0700
Message-Id: <20220418225033.3944860-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
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

This commit belatedly adds documentation of Tasks Rude RCU and Tasks
Trace RCU to RCU's requirements document.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 45278e2974c0..ff2be1ac54c4 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2654,6 +2654,38 @@ synchronize_rcu(), and rcu_barrier(), respectively. In
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
 
+Tasks Rude RCU
+~~~~~~~~~~~~~~
+
+Some forms of tracing need to wait for all preemption-disabled regions
+of code running on any online CPU, including those executed when RCU is
+not watching.  This means that synchronize_rcu() is insufficient, and
+Tasks Rude RCU must be used instead.  This flavor of RCU does its work by
+forcing a workqueue to be scheduled on each online CPU, hence the "Rude"
+moniker.  And this operation is considered to be quite rude by real-time
+workloads that don't want their ``nohz_full`` CPUs receiving IPIs and
+by battery-powered systems that don't want their idle CPUs to be awakened.
+
+The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
+consisting of call_rcu_tasks_rude(), synchronize_rcu_tasks_rude(),
+and rcu_barrier_tasks_rude().
+
+Tasks Trace RCU
+~~~~~~~~~~~~~~~
+
+Some forms of tracing need to sleep in readers, but cannot tolerate
+SRCU's read-side overhead, which includes a full memory barrier in both
+srcu_read_lock() and srcu_read_unlock().  This need is handled by a
+Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
+readers.  Real-time systems that cannot tolerate IPIs may build their
+kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=y``, which avoids the IPIs at
+the expense of adding full memory barriers to the read-side primitives.
+
+The tasks-trace-RCU API is also reasonably compact,
+consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
+rcu_read_lock_trace_held(), call_rcu_tasks_trace(),
+synchronize_rcu_tasks_trace(), and rcu_barrier_tasks_trace().
+
 Possible Future Changes
 -----------------------
 
-- 
2.31.1.189.g2e36527f23

