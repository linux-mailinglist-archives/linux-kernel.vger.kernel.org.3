Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5F4CA99D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiCBPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbiCBPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:50:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73844DF7C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:49:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 779CBB82082
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F526C340F3;
        Wed,  2 Mar 2022 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236167;
        bh=GOoi6g4ctUqUHDqZeFC0Osd59H+sK7UFUWiNfmdM4sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GchxLgCOMc3ImfFguBtOgg8lb1eEi7ABmXlwkU1UgNt42MTVFrg2bshW/EJY5NwHu
         wiUXvSY6skQRiyPs1Qb930sLXBoYI1Py+hIzCF8qPDLmk0kVK8nkkc1RCSgKE5By7f
         6L8+W8oV0kOelAm1817ns08dR24m92Fz1K6EaJ0YzNHJEIwJBPs1F10/71qkETpqCB
         zjMJR8oDA690r7PnFK5yj6h8uDyKjgs3agKwkH1bIZrYYwN+uzthqdy4N/RT0jTdVx
         EAt0co2bf16ftUAo6txovtwjvY/67uRf1+nlKsu9u99gcqTVX7Q3B9TqywPsoXl4jj
         xxG0ZagQi+2Zg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 19/19] context_tracking: Exempt CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK from non-active tracking
Date:   Wed,  2 Mar 2022 16:48:10 +0100
Message-Id: <20220302154810.42308-20-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a CPU may save the state of the context tracking using
exception_enter() before calling into schedule(), we need all CPUs in
the system to track user <-> kernel transitions and not just those that
really need it (nohz_full CPUs).

The following illustrates the issue that could otherwise happen:

     CPU 0 (not tracking)                       CPU 1 (tracking)
     -------------------                       --------------------
     // we are past user_enter()
     // but this CPU is always in
     // CONTEXT_KERNEL
     // because it doesn't track user <-> kernel

     ctx = exception_enter(); //ctx == CONTEXT_KERNEL
     schedule();
     ===========================================>
                                               return from schedule();
                                               exception_exit(ctx);
                                               //go to user in CONTEXT_KERNEL

However CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK doesn't play those
games because schedule() can't be called between user_enter() and
user_exit() under such config. In this situation we can spare context
tracking on the CPUs that don't need it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 kernel/context_tracking.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 87e7b748791c..b1934264f77f 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -374,7 +374,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * when the CPU runs in userspace.
 			 */
 			ct_kernel_exit(true, RCU_DYNTICKS_IDX + state);
-		} else {
+		} else if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK)) {
 			/*
 			 * Even if context tracking is disabled on this CPU, because it's outside
 			 * the full dynticks mask for example, we still have to keep track of the
@@ -384,7 +384,8 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * handler and then migrate to another CPU, that new CPU must know where
 			 * the exception returns by the time we call exception_exit().
 			 * This information can only be provided by the previous CPU when it called
-			 * exception_enter().
+			 * exception_enter(). CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK is
+			 * excused though because it doesn't use exception_enter().
 			 * OTOH we can spare the calls to vtime and RCU when context_tracking.active
 			 * is false because we know that CPU is not tickless.
 			 */
@@ -460,7 +461,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 				trace_user_exit(0);
 				instrumentation_end();
 			}
-		} else {
+		} else if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK)) {
 			atomic_sub(state, &ct->state);
 		}
 	}
-- 
2.25.1

