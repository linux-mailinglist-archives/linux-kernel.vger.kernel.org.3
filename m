Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8CF472A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhLMKad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbhLMK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:28:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CD8C0698E3;
        Mon, 13 Dec 2021 02:03:22 -0800 (PST)
Date:   Mon, 13 Dec 2021 10:03:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVyz3qgfS+tVUwuLQhfSllaBpTS5B2jkB9eopZdDbRM=;
        b=oZuLqofEy5xaTqyoi5YnjPuqGoMHV+YRA/PKgF6FYMoPfj0yOs9NAdCk5L5F3KZzGKpAr3
        XW95ausH8lttgHyIoaoUJZ9i64Q5xkVY+2GGaZXcPXlRcJxSgZWJ9fVW3F4wq/qfsKKlai
        ztG2okXp96YQN8h6sPUXMJFOGWyDimsIuSFeJou85jaXRU1kjL95vXDY1F1UJcNH1LGcQ/
        ol2plA78MdOJZlSq7BzibAA8zgC/qO0ZX/1SGVen65Ccj3JsyQt3rwqAwFr9O7NVfkAD7x
        G0P4u0TCaWpMhYNTrXNWRKjNuOem2tkrBk4zCkyexfHLKTvSjcifgskOX67VCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVyz3qgfS+tVUwuLQhfSllaBpTS5B2jkB9eopZdDbRM=;
        b=3//mC2lCHsejZ6/I//7c0d9mOdA4Sdz6Vil2GxeuNjnLPfzaHxQwUqiqAkDgCGHk+ByKbJ
        3g+8IqMz64PiPdBA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: atomic64: Remove unusable atomic ops
Cc:     kernel test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126115923.41489-1-mark.rutland@arm.com>
References: <20211126115923.41489-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163938980021.23020.4518866031238162814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5fb6e8cf53b005d287d4c2d137a415ff7d025a81
Gitweb:        https://git.kernel.org/tip/5fb6e8cf53b005d287d4c2d137a415ff7d025a81
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Fri, 26 Nov 2021 11:59:23 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Dec 2021 10:56:09 +01:00

locking/atomic: atomic64: Remove unusable atomic ops

The generic atomic64 implementation provides:

* atomic64_and_return()
* atomic64_or_return()
* atomic64_xor_return()

... but none of these exist in the standard atomic64 API as described by
scripts/atomic/atomics.tbl, and none of these have prototypes exposed by
<asm-generic/atomic64.h>.

The lkp kernel test robot noted this results in warnings when building with
W=1:

  lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_and_return' [-Wmissing-prototypes]

  lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_or_return' [-Wmissing-prototypes]

  lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_xor_return' [-Wmissing-prototypes]

This appears to have been a thinko in commit:

  28aa2bda2211f432 ("locking/atomic: Implement atomic{,64,_long}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()")

... where we grouped add/sub separately from and/ox/xor, so that we could avoid
implementing _return forms for the latter group, but forgot to remove
ATOMIC64_OP_RETURN() for that group.

This doesn't cause any functional problem, but it's pointless to build code
which cannot be used. Remove the unusable code. This does not affect add/sub,
for which _return forms will still be built.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20211126115923.41489-1-mark.rutland@arm.com
---
 lib/atomic64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/atomic64.c b/lib/atomic64.c
index 3df6539..caf8957 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -118,7 +118,6 @@ ATOMIC64_OPS(sub, -=)
 #undef ATOMIC64_OPS
 #define ATOMIC64_OPS(op, c_op)						\
 	ATOMIC64_OP(op, c_op)						\
-	ATOMIC64_OP_RETURN(op, c_op)					\
 	ATOMIC64_FETCH_OP(op, c_op)
 
 ATOMIC64_OPS(and, &=)
@@ -127,7 +126,6 @@ ATOMIC64_OPS(xor, ^=)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
-#undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
 s64 generic_atomic64_dec_if_positive(atomic64_t *v)
