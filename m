Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A54ADEEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383710AbiBHRIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383626AbiBHRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:08:07 -0500
X-Greylist: delayed 834 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 09:08:04 PST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E9C061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:08:04 -0800 (PST)
Date:   Tue, 8 Feb 2022 18:08:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644340083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=n66/HLGuwk6U4j6T7sevm8VzSk/spXLEB/Pd7EnsaHo=;
        b=nE5OCZkOWASD252K/yqL0S/VkkBfDUUfzYab0D4nV9Ej/825xP3Hj6TfbOiBxP8Y771M7B
        lZCgC3drp0g3g1wGhfmHg4ZBvK3mYp48R2cK7lKJLdNreWolCD+d26Dp4VtUfKiDExj3mh
        zfkkChKpJs+Bgc9D/nyDLVYOMEkUCOGs7gO+RZuTP4u5mc52hXCvaDdN+5bDRfxKUM7kbj
        37DJUra3anwNPqPE06zCgDyS0kKjIdcXZYk9tASEBAh3+rIiaxKjSQGQjrQH9JN3OvcNBM
        qggsFoEB3kHOcZiyvdbCSSW/DmSKSEd7D4NUF51ipG7qRB3RXPc3uqJUp9y/LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644340083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=n66/HLGuwk6U4j6T7sevm8VzSk/spXLEB/Pd7EnsaHo=;
        b=WkYuJ9bzgkebWvxdytpuU8cmInv0m7/974knsvzEfjkECmfUCiqy2g45e+2ZkYfE51jJs1
        vX10mfW/uin0OZAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH REPOST] locking/local_lock: Make the empty local_lock_*()
 function a macro.
Message-ID: <YgKjciR60fZft2l4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Waiman Long <longman@redhat.com>
---
Repost of
   https://lkml.kernel.org/r/20220105202623.1118172-1-bigeasy@linutronix.de

 include/linux/local_lock_internal.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -44,9 +44,9 @@ static inline void local_lock_debug_init
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
