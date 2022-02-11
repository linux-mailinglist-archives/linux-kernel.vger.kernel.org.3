Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2414B2420
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349380AbiBKLRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:17:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349351AbiBKLRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:17:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2AAE69;
        Fri, 11 Feb 2022 03:17:02 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644578220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wi9DzXRJl7xpfIIYvztSqpa0/2dDXkGYgVXxq1XpKs=;
        b=KkZ+xbIhOm+CAAXUeSQq30/Qw+5Fp0IV1Rsd5YS21sjE88qibM4supR1PAAw0Rq8bjyMCw
        HYQsWkLck1z+zBnqu4/EsNnHOFFz2jOOqD4i8ZVbwWasKRFTTtxwcbvgprCPHU4zTT6adb
        K/+gmKYShfNs6xR7VhSzJD5PGGakJLMFb7+nzILEqnVE878exAbbOkevCDbma0c8889Pcl
        9p8J4gzSnCLiDZQXx6yKey0IqL7fQBMsnLQqBIofAYgVd9g8kJFchxgkGxT48W8r9+ziYO
        TD0m2emhAR1A69c4QUDUNFOO+d/O/s3JicIVeFYIOjR276u6E37rNagFRkX5zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644578220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wi9DzXRJl7xpfIIYvztSqpa0/2dDXkGYgVXxq1XpKs=;
        b=DsgaWXk8ytWfM8Z2JWw0hpDc7kFX5wHY4L0MaATQ4jB0iDN0CpfEsSn3zboObGcPmKC4Yj
        7909kAvJ4o72sBBg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local_lock: Make the empty local_lock_*()
 function a macro.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YgKjciR60fZft2l4@linutronix.de>
References: <YgKjciR60fZft2l4@linutronix.de>
MIME-Version: 1.0
Message-ID: <164457821956.16921.6260017427574423665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9983a9d577db415c41099a20a5637ab25dd3c240
Gitweb:        https://git.kernel.org/tip/9983a9d577db415c41099a20a5637ab25dd3c240
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 08 Feb 2022 18:08:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 12:13:56 +01:00

locking/local_lock: Make the empty local_lock_*() function a macro.

It has been said that local_lock() does not add any overhead compared to
preempt_disable() in a !LOCKDEP configuration. A micro benchmark showed
an unexpected result which can be reduced to the fact that local_lock()
was not entirely optimized away.
In the !LOCKDEP configuration local_lock_acquire() is an empty static
inline function. On x86 the this_cpu_ptr() argument of that function is
fully evaluated leading to an additional mov+add instructions which are
not needed and not used.

Replace the static inline function with a macro. The typecheck() macro
ensures that the argument is of proper type while the resulting
disassembly shows no traces of this_cpu_ptr().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/YgKjciR60fZft2l4@linutronix.de
---
 include/linux/local_lock_internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 975e33b..6d635e8 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -44,9 +44,9 @@ static inline void local_lock_debug_init(local_lock_t *l)
 }
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
-static inline void local_lock_acquire(local_lock_t *l) { }
-static inline void local_lock_release(local_lock_t *l) { }
-static inline void local_lock_debug_init(local_lock_t *l) { }
+# define local_lock_acquire(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
+# define local_lock_release(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
+# define local_lock_debug_init(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
