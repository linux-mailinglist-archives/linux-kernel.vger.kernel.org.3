Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F055E45B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbiF1NTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbiF1NSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57AC3335D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5024061777
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD26BC341CC;
        Tue, 28 Jun 2022 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422273;
        bh=gggN7XhvwqPefMr2dyCvEY5+mqYiVRBxjchXNPR2PHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t32jNx9ovVMMLqc7euk7BI38bMOEmd5DXHNUBI7VOjCKyiBEGIXMzLlGYxAIbHtQ/
         qSy6sZzQo84tzzNIVWR5RcirNGPh3hotQUElk7icELHj0U5gVvA2Sk97KrWh8ktMgW
         BTLKrSYi3T8JegG8zBB4PrHaDii1mk8LW2+LM745VFxIOiPNuwe30ksbGcUKygFCpr
         0+gsruG1Tfhtk6ZZz/vOXvsF4wqdFrHN2MH7QJLslVop+hpVPc/wQ3ziB6MtQN80cH
         pQOKwvOY+NBgeCfZtCojz0N2rrLJt+FuuoXw+HrsCG3fl1Mvq6/jnrTF19Af99S5lQ
         7WnRqu20gvQUw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marco Elver <elver@google.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 20/20] context_tracking: Use arch_atomic_read() in __ct_state for KASAN
Date:   Tue, 28 Jun 2022 15:16:19 +0200
Message-Id: <20220628131619.2109651-21-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628131619.2109651-1-frederic@kernel.org>
References: <20220628131619.2109651-1-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

Context tracking's __ct_state() function can be invoked from noinstr state
where RCU is not watching.  This means that its use of atomic_read()
causes KASAN to invoke the non-noinstr __kasan_check_read() function
from the noinstr function __ct_state().  This is problematic because
someone tracing the __kasan_check_read() function could get a nasty
surprise because of RCU not watching.

This commit therefore replaces the __ct_state() function's use of
atomic_read() with arch_atomic_read(), which KASAN does not attempt to
add instrumention to.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Marco Elver <elver@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 include/linux/context_tracking_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index e20a74bc0597..4a4d56f77180 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
 static __always_inline int __ct_state(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
+	return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
 }
 #endif
 
-- 
2.25.1

