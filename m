Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023D94859FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiAEU0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiAEU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:26:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB907C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:26:30 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641414387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dAVpE4K9WudDMKF/c5kgCwYBnVKLc4tGyQHTuLgAOqs=;
        b=h92A85Cpx2DZ4YSM6wX1EkUFaPjESI53bEJVUjHhve2HVB881ZkN/pYh6T6Byu6aDbhT9C
        ItCIdsc61Izj9kjgTrlkbC4In5Bw8aMtRB8fQs0Z/v0x5TrE3W6VHNf+3FVZdTDeNhjh/p
        vmuwRxJxl6nKgSfD5kc3gHGaAZOqvfQpKXTRKBdPNGF5Gfgotl/Oe2lmp9huj3/gYkGKrF
        ikeitTCX+7Eu27c/Rw7jNZYQgtaw7Qzpj1AcB4q2ni+a8wA2e6L6JzyDcQcDxhcbhDP19v
        5owLcnXQCS+65y5LttYDJp3KfOhhah9hUckw04ri8yyJgfPCfgvSiecc3m11mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641414387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dAVpE4K9WudDMKF/c5kgCwYBnVKLc4tGyQHTuLgAOqs=;
        b=P+1fxoNDhHx5DDQ9HXoPDc7G8NmB+gp2A4ce4xyQfp0aq+Ph7cqDfYSBMINGFVUK5ScuVr
        vACDLleKSAOhbGDA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] locking/local_lock: Make the empty local_lock_*() function a macro.
Date:   Wed,  5 Jan 2022 21:26:23 +0100
Message-Id: <20220105202623.1118172-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been said that local_lock() does not add any overhead compared to
preempt_disable() in a !LOCKDEP configuration. A microbenchmark showed
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
---
On -rc8, size says:
|     text    data     bss      dec     filename
| 19656718 8681015 3764440 32102173 vmlinux.old
| 19656218 8681015 3764440 32101673 vmlinux.new

Which is -500 text, not much but still.

 include/linux/local_lock_internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index 975e33b793a77..6d635e8306d64 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -44,9 +44,9 @@ static inline void local_lock_debug_init(local_lock_t *l)
 }
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
-static inline void local_lock_acquire(local_lock_t *l) { }
-static inline void local_lock_release(local_lock_t *l) { }
-static inline void local_lock_debug_init(local_lock_t *l) { }
+# define local_lock_acquire(__ll)  do { typecheck(local_lock_t *, __ll); }=
 while (0)
+# define local_lock_release(__ll)  do { typecheck(local_lock_t *, __ll); }=
 while (0)
+# define local_lock_debug_init(__ll)  do { typecheck(local_lock_t *, __ll)=
; } while (0)
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
--=20
2.34.1

