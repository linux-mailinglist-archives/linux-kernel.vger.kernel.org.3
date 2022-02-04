Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE904AA477
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378310AbiBDXj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47902 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378238AbiBDXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DDC561CAD;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBAFC3410B;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=x6pO0fVHUYqRxZjocoXSG7Zfk3O9t9S3+6VG14PmyDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RT8Ix1XY0Dhl+tMwdgoyhOHoJwg5lQFAXNynILCQKTTo+BwkaMdea0ku1mYbtpKpI
         4L1VSbN/8D7GNH9Ca4xqgDvNBXLSqhchM649udlwpsWOFxUyVpMIROLXrwhMJFI3QS
         UZilcqCrQHcSSA0R8TS7gRapyu3/SWCuJMbmE33hNUrvOQSZJZ3aFBIiGfYKbWFUrM
         JaxH+UoajrcsrUyYx2AG6ORymSQUVXbZcSWiT96K1WemTtze7MujmPrTrt7mkDu0u3
         UTl5TigFQphw+NvKJKDO8eqIKPizaHutC9dMo1M4X07XPXVg+IdmOIzGMHcXC2pX1m
         k6mwkXMqA8Urg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 140265C1273; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 18/19] srcu: Automatically determine size-transition strategy at boot
Date:   Fri,  4 Feb 2022 15:39:01 -0800
Message-Id: <20220204233902.1902-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a srcutree.convert_to_big option of zero that causes
SRCU to decide at boot whether to wait for contention (small systems) or
immediately expand to large (large systems).  A new srcutree.big_cpu_lim
(defaulting to 128) defines how many CPUs constitute a large system.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++++++++
 kernel/rcu/srcutree.c                         | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d7b64263fefbc..ad2388a431944 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5525,11 +5525,20 @@
 			off:    Disable mitigation and remove
 				performance impact to RDRAND and RDSEED
 
+	srcutree.big_cpu_lim [KNL]
+			Specifies the number of CPUs constituting a
+			large system, such that srcu_struct structures
+			should immediately allocate an srcu_node array.
+			This kernel-boot parameter defaults to 128, but
+			takes effect only when srcutree.convert_to_big
+			is equal to zero.
+
 	srcutree.convert_to_big [KNL]
 			Specifies under what conditions an SRCU tree
 			srcu_struct structure will be converted to big
 			form, that is, with an rcu_node tree:
 
+				   0:  Decide at boot time (default).
 				   1:  Never.
 				   2:  At init_srcu_struct() time.
 				   3:  When rcutorture decides to.
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f13e84ecbca6a..c3968e091d019 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -57,9 +57,13 @@ module_param(counter_wrap_check, ulong, 0444);
 #define SRCU_SIZING_IS_INIT() (SRCU_SIZING_IS(SRCU_SIZING_INIT))
 #define SRCU_SIZING_IS_TORTURE() (SRCU_SIZING_IS(SRCU_SIZING_TORTURE))
 #define SRCU_SIZING_IS_CONTEND() (convert_to_big & SRCU_SIZING_CONTEND)
-static int convert_to_big = SRCU_SIZING_NONE;
+static int convert_to_big = SRCU_SIZING_AUTO;
 module_param(convert_to_big, int, 0444);
 
+/* Number of CPUs to trigger init_srcu_struct()-time transition to big. */
+static int big_cpu_lim __read_mostly = 128;
+module_param(big_cpu_lim, int, 0444);
+
 /* Contention events per jiffy to initiate transition to big. */
 static int small_contention_lim __read_mostly = 100;
 module_param(small_contention_lim, int, 0444);
@@ -1592,6 +1596,17 @@ void __init srcu_init(void)
 {
 	struct srcu_struct *ssp;
 
+	/* Decide on srcu_struct-size strategy. */
+	if (SRCU_SIZING_IS(SRCU_SIZING_AUTO)) {
+		if (nr_cpu_ids >= big_cpu_lim) {
+			convert_to_big = SRCU_SIZING_INIT; // Don't bother waiting for contention.
+			pr_info("%s: Setting srcu_struct sizes to big.\n", __func__);
+		} else {
+			convert_to_big = SRCU_SIZING_NONE | SRCU_SIZING_CONTEND;
+			pr_info("%s: Setting srcu_struct sizes based on contention.\n", __func__);
+		}
+	}
+
 	/*
 	 * Once that is set, call_srcu() can follow the normal path and
 	 * queue delayed work. This must follow RCU workqueues creation
@@ -1602,6 +1617,8 @@ void __init srcu_init(void)
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
 				      work.work.entry);
 		list_del_init(&ssp->work.work.entry);
+		if (SRCU_SIZING_IS(SRCU_SIZING_INIT) && !ssp->srcu_size_state)
+			ssp->srcu_size_state = SRCU_SIZE_ALLOC;
 		queue_work(rcu_gp_wq, &ssp->work.work);
 	}
 }
-- 
2.31.1.189.g2e36527f23

