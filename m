Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E613B55E441
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiF1NQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbiF1NQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FBE31907
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847A361772
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D4DC341CC;
        Tue, 28 Jun 2022 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422191;
        bh=TbV3AxRYc/xnNHiMMICF6mBjEdmNsICEJc79F/DGTgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BbUogdOPiiW3Y7Qq5WPgg6dCFvdH7KWXYvmHTKf5E8HQ3EJVwaA2OIuGUu7v2HiAl
         xGZLD9JjnKsX/893SVh3gLUq+VifU7IhEMABZU/I+KXzT52rRV74C488NCH+dpO+/Y
         z2m9S7DddVSlmBk1IBJKloQk5EdHtxEBdbao5vCeLDlUwbPTz9Hh/WGaHjtHRG9nCi
         rcT8HnluPIlRv9mcuU+HLl4uLUGee73dIGuG+Hn9j8bPaCIstDfL4UUXaCmi5L2l2c
         ORObKxIojhPxI2DJLXvq81tumaw4rbUVVpQSEtFEAoni4Ioohu+lcG4yt2huXyPKtL
         2EzZTjMSZKFpg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
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
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 01/20] context_tracking: Remove unused context_tracking_in_user()
Date:   Tue, 28 Jun 2022 15:16:00 +0200
Message-Id: <20220628131619.2109651-2-frederic@kernel.org>
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

This function is not used and CT_WARN_ON() coupled with ct_state() is
the preferred way to assert context tracking state values.

Reported-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/context_tracking_state.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index ae1e63e26947..edc7b46376a6 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -41,12 +41,7 @@ static inline bool context_tracking_enabled_this_cpu(void)
 	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
 }
 
-static __always_inline bool context_tracking_in_user(void)
-{
-	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
-}
 #else
-static __always_inline bool context_tracking_in_user(void) { return false; }
 static __always_inline bool context_tracking_enabled(void) { return false; }
 static __always_inline bool context_tracking_enabled_cpu(int cpu) { return false; }
 static __always_inline bool context_tracking_enabled_this_cpu(void) { return false; }
-- 
2.25.1

