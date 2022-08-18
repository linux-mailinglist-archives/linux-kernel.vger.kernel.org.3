Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6EA598269
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbiHRLnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHRLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:43:04 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352317CB6B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1660822983;
  x=1692358983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6eO/Ml80Sa/Ka0C2i96xu8VJgFQ73c/b6YqEaS18VYo=;
  b=iso9MBSUxSNPd4b3LCdwNNjjwB7UVY7wsZ+rHNdTT0EqUmbyQ42ZCxR/
   M3mGT17yzZZFDsr5L+BJRf/F4yvsU5q181/367kk4g5Rm38QswUfjiIBU
   XH0SA9seOBbP/p1am1Qcp6fCVqWbfiXbq6OYj8XWK5dbKFkP9CjecIvTh
   LjlrRfABRaTkS3CfFXpP1Qim1n+Th5TiTVIJNCDbMyEthUmea4jKA2KIq
   wNWKGJmj8fZCjs51mnTQpzdkLXKiqYUIdkYOGeQW6UzKDgAmKhBViD9Rb
   2iVcfqdBonU7F4nhLTLtczxgLad9ytKme4oA+CYFyE/ZOMztp58K5pe/o
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] lockdep: Panic on warning if panic_on_warn is set
Date:   Thu, 18 Aug 2022 13:42:58 +0200
Message-ID: <20220818114259.2203505-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There does not seem to be any way to get the system to panic if a
lockdep warning is emitted, since those warnings don't use the normal
WARN() infrastructure.  Panicking on any lockdep warning can be
desirable when the kernel is being run in a controlled environment
solely for the purpose of testing.  Make lockdep respect panic_on_warn
to allow this, similar to KASAN and others.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 kernel/locking/lockdep.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 64a13eb56078..d184bba02630 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -124,6 +124,12 @@ static __always_inline bool lockdep_enabled(void)
 	return true;
 }
 
+static void lockdep_panic(void)
+{
+	if (panic_on_warn)
+		panic("panic_on_warn set ...\n");
+}
+
 /*
  * lockdep_lock: protects the lockdep graph, the hashes and the
  *               class/list/hash allocators.
@@ -977,6 +983,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
 		pr_err("you didn't initialize this object before use?\n");
 		pr_err("turning off the locking correctness validator.\n");
 		dump_stack();
+		lockdep_panic();
 		return false;
 	}
 
@@ -2051,6 +2058,7 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	printk("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 static noinline void print_bfs_bug(int ret)
@@ -2607,6 +2615,7 @@ print_bad_irq_dependency(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 static const char *state_names[] = {
@@ -2986,6 +2995,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 /*
@@ -3583,6 +3593,7 @@ static void print_collision(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 #endif
 
@@ -3959,6 +3970,7 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 /*
@@ -4038,6 +4050,7 @@ print_irq_inversion_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 /*
@@ -4703,6 +4716,7 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 
 	pr_warn("stack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 
 	return 0;
 }
@@ -4892,6 +4906,7 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -5104,6 +5119,7 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 static noinstr int match_held_lock(const struct held_lock *hlock,
@@ -5795,6 +5811,7 @@ static void print_lock_contention_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 static void
@@ -6420,6 +6437,7 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 static inline int not_in_range(const void* mem_from, unsigned long mem_len,
@@ -6475,6 +6493,7 @@ static void print_held_locks_bug(void)
 	lockdep_print_held_locks(current);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 
 void debug_check_no_locks_held(void)
@@ -6593,5 +6612,6 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	lockdep_print_held_locks(curr);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	lockdep_panic();
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
-- 
2.34.1

