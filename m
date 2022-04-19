Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F680506091
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiDSAHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiDSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B176237FA;
        Mon, 18 Apr 2022 17:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4726612DC;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEF1C385C7;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=YwNURKj9mCIVjxikZL9NORCNyWNTo9uPcdOZhbmsazc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxdI+F6nO1OTvalSor++1mZLjYnYU8Y+aoppUZZ8k3QCqMWlamU/36mJsF+OZGNBT
         86yeE7C3ZvDHvpaj+g00OR0hgH3ecm1bhH7UsBlPDRubzRgTS3lsq+RxR2/RIfna81
         YkzC9dnjPQKUPrv6t1R6kGnkf+1qWhayp0KqEv/OvRFxFsbOGQgF53cP7oaXl3mIL3
         E4R51gi4VREdCVH25xDY76DlJIpllyVqDGH5W8h9+IdyooPU8OP40d0xuiKLIyBLSz
         4EAdjiGIH7Giw8Q3UaOSG5gMWXzIkKUqDZGUv95f1d9rW6u7kgPYTqHjdHyj6+LSZa
         8kPVNIsHbcDww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6D2B45C30DF; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 18/21] srcu: Automatically determine size-transition strategy at boot
Date:   Mon, 18 Apr 2022 17:03:19 -0700
Message-Id: <20220419000322.3948903-18-paulmck@kernel.org>
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

This commit adds a srcutree.convert_to_big option of zero that causes
SRCU to decide at boot whether to wait for contention (small systems) or
immediately expand to large (large systems).  A new srcutree.big_cpu_lim
(defaulting to 128) defines how many CPUs constitute a large system.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++++++
 kernel/rcu/srcutree.c                         | 23 ++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 177e688768c0..057e30613d00 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5608,6 +5608,14 @@
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
@@ -5616,6 +5624,7 @@
 				   0:  Never.
 				   1:  At init_srcu_struct() time.
 				   2:  When rcutorture decides to.
+				   3:  Decide at boot time (default).
 				0x1X:  Above plus if high contention.
 
 			Either way, the srcu_node tree will be sized based
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0bc6a0a3edee..b9dec26245e0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -41,10 +41,10 @@ module_param(counter_wrap_check, ulong, 0444);
 
 /*
  * Control conversion to SRCU_SIZE_BIG:
- *    0: Don't convert at all (default).
+ *    0: Don't convert at all.
  *    1: Convert at init_srcu_struct() time.
  *    2: Convert when rcutorture invokes srcu_torture_stats_print().
- *    3: Decide at boot time based on system shape.
+ *    3: Decide at boot time based on system shape (default).
  * 0x1x: Convert when excessive contention encountered.
  */
 #define SRCU_SIZING_NONE	0
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
@@ -1619,6 +1623,17 @@ void __init srcu_init(void)
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
@@ -1629,6 +1644,8 @@ void __init srcu_init(void)
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
 				      work.work.entry);
 		list_del_init(&ssp->work.work.entry);
+		if (SRCU_SIZING_IS(SRCU_SIZING_INIT) && ssp->srcu_size_state == SRCU_SIZE_SMALL)
+			ssp->srcu_size_state = SRCU_SIZE_ALLOC;
 		queue_work(rcu_gp_wq, &ssp->work.work);
 	}
 }
-- 
2.31.1.189.g2e36527f23

