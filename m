Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA77B5526E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbiFTWVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbiFTWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C30D1B7BC;
        Mon, 20 Jun 2022 15:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15BCEB8164C;
        Mon, 20 Jun 2022 22:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C325C341CE;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=dvayfTMczyv3C6g8GjwtjDg8jUO9BjwWnCpcNP6JWoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXwIw1hoF6M8JmrZhNW6N32tDGxEXEY7fyaa5fmnMwUGYflOYI+KdJE791fCCyVJs
         9WNtr2SwLSDmce5jZhN7Fq3bsO7LK3KpsXsC4UXWJgvOg3w7UCiTQttRp3jDB7S/K9
         WClbicMt+afMnOpGsrfOHuxBvGr9lofxt+R6mTUkOLCdEg2AwEBJ3BXo1agH6wFRj+
         5bTmuGRmoIgCloVv9meIHcbAho6yh6M7adTNhAA+Hg/Hvp3xmCq0IzEdUW7Mj7b7hf
         lCf8lDX4FmGSWQiewxv3KHP+TJB36fJdUakciOPOZPaPvLILH9UDWkkdTSACT5v2YV
         1Vsm1DW32i0oQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 094375C0BCC; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Johannes Berg <johannes.berg@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/12] rcu: tiny: Record kvfree_call_rcu() call stack for KASAN
Date:   Mon, 20 Jun 2022 15:20:27 -0700
Message-Id: <20220620222032.3839547-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
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

From: Johannes Berg <johannes.berg@intel.com>

When running KASAN with Tiny RCU (e.g. under ARCH=um, where
a working KASAN patch is now available), we don't get any
information on the original kfree_rcu() (or similar) caller
when a problem is reported, as Tiny RCU doesn't record this.

Add the recording, which required pulling kvfree_call_rcu()
out of line for the KASAN case since the recording function
(kasan_record_aux_stack_noalloc) is neither exported, nor
can we include kasan.h into rcutiny.h.

without KASAN, the patch has no size impact (ARCH=um kernel):
    text       data         bss         dec        hex    filename
 6151515    4423154    33148520    43723189    29b29b5    linux
 6151515    4423154    33148520    43723189    29b29b5    linux + patch

with KASAN, the impact on my build was minimal:
    text       data         bss         dec        hex    filename
13915539    7388050    33282304    54585893    340ea25    linux
13911266    7392114    33282304    54585684    340e954    linux + patch
   -4273      +4064         +-0        -209

Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h | 11 ++++++++++-
 kernel/rcu/tiny.c       | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5fed476f977f6..d84e13f2c3848 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
  */
 extern void kvfree(const void *addr);
 
-static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	if (head) {
 		call_rcu(head, func);
@@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	kvfree((void *) func);
 }
 
+#ifdef CONFIG_KASAN_GENERIC
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+#else
+static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	__kvfree_call_rcu(head, func);
+}
+#endif
+
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 340b3f8b090d4..58ff3721d975c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -217,6 +217,20 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 
+#ifdef CONFIG_KASAN_GENERIC
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	if (head) {
+		void *ptr = (void *) head - (unsigned long) func;
+
+		kasan_record_aux_stack_noalloc(ptr);
+	}
+
+	__kvfree_call_rcu(head, func);
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
+#endif
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
-- 
2.31.1.189.g2e36527f23

