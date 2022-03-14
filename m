Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08C4D8614
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbiCNNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbiCNNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498FC1119
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64E8AB80DF4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28375C340ED;
        Mon, 14 Mar 2022 13:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647265078;
        bh=jk6umewZFxLd1Bf2B9rzTYEamkBtxaQMtyRXWqXjK5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TKfpqy3ZScfBv4im+6QkVJ2j+hVA+h1uU3wriYMhuXUNZBxFRLWsePk0v1wZusbnX
         0q0YFvXFwecwBCtTmJgWZOI/SsubvaBd5lpApSyErtV9tP4PGG7a4TDjz49QtWuZIG
         WzDJ1zmlXqWunGCdlDeo5jVbKjuOFv/52iSS+mI2uvuw6VFIvabFzglHiDiGoNyzoX
         tBnMMLWEETg3yI6TGrSEgXXTnl1ml10/7SXJfsSi27mTSvsbQ3Er0uODB5rSQrxEWr
         UHZgJEHjrJWjE7kdpAlYCPUkKLweEK2KRubcDMEJIObN61Qadhg8mnyvf934CI0NQS
         i1axDfgMDsBbg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/3] preempt/dynamic: Introduce preempt mode accessors
Date:   Mon, 14 Mar 2022 14:37:37 +0100
Message-Id: <20220314133738.269522-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314133738.269522-1-frederic@kernel.org>
References: <20220314133738.269522-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

CONFIG_PREEMPT{_NONE, _VOLUNTARY} designate either:
o The build-time preemption model when !PREEMPT_DYNAMIC
o The default boot-time preemption model when PREEMPT_DYNAMIC

IOW, using those on PREEMPT_DYNAMIC kernels is meaningless - the actual
model could have been set to something else by the "preempt=foo" cmdline
parameter.

Introduce a set of helpers to determine the actual preemption mode used by
the live kernel.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
---
 include/linux/sched.h | 16 ++++++++++++++++
 kernel/sched/core.c   | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 508b91d57470..d348e886e4d0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2096,6 +2096,22 @@ static inline void cond_resched_rcu(void)
 #endif
 }
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+extern bool preempt_mode_none(void);
+extern bool preempt_mode_voluntary(void);
+extern bool preempt_mode_full(void);
+
+#else
+
+#define preempt_mode_none() IS_ENABLED(CONFIG_PREEMPT_NONE)
+#define preempt_mode_voluntary() IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)
+#define preempt_mode_full() IS_ENABLED(CONFIG_PREEMPT)
+
+#endif
+
+#define preempt_mode_rt() IS_ENABLED(CONFIG_PREEMPT_RT)
+
 /*
  * Does a critical section need to be broken due to another
  * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00e52d1..6e5c8f0f874a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6684,6 +6684,17 @@ static void __init preempt_dynamic_init(void)
 	}
 }
 
+#define PREEMPT_MODE_ACCESSOR(mode) \
+	bool preempt_mode_##mode(void)						 \
+	{									 \
+		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
+		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
+	}
+
+PREEMPT_MODE_ACCESSOR(none)
+PREEMPT_MODE_ACCESSOR(voluntary)
+PREEMPT_MODE_ACCESSOR(full)
+
 #else /* !CONFIG_PREEMPT_DYNAMIC */
 
 static inline void preempt_dynamic_init(void) { }
-- 
2.25.1

