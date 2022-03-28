Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C34E9A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiC1PAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244149AbiC1O76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:59:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66BFDA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:58:16 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648479494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2K1bd9HAywoNYrUHng0l9se10lIg8eInYuxNMOXcG4=;
        b=EjUDbP7aP+qljVDBR2MAkDM5xU7vd9b9xa/rPob4/Vxcjov1URp6frYUNDHEpFX4qdKCGn
        dKuumlIgipJ0kMAxTQBICYpdOPU0HOI41z4KbrB2rPvndGLigSO5Vz7Qu6kfGdBfvVMk3X
        O02BpueYAoy3y5LOO7GEbe+Xl0RJPBQ8xUzUOsyz8skHJy3RtvZJM6LtQQqIjKgRS0oePz
        bAGZO0VYqwtA0/OkByTkrgrFK3IbNAy91Gcne3AR5we9OpsFS5X1D7VR8cGlC34WilEkx9
        jtbVKl7fP2Z4T8Lx5rsjB5FgZp3IRDkePP9e/gsBqi9D8mZIJ14xPiMRn3dIEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648479494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2K1bd9HAywoNYrUHng0l9se10lIg8eInYuxNMOXcG4=;
        b=AlG2M3cx5+lNV2y/UxoYM+/ULV7blsPiFDlKJqN+gLBnL9PpXqYyYZPN557Bqa+aVvqX03
        li9Dt4cAnMHsBSDQ==
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        boqun.feng@gmail.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v2 2/3] Revert "locking/local_lock: Make the empty local_lock_*() function a macro."
Date:   Mon, 28 Mar 2022 16:58:09 +0200
Message-Id: <20220328145810.86783-3-bigeasy@linutronix.de>
In-Reply-To: <20220328145810.86783-1-bigeasy@linutronix.de>
References: <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
 <20220328145810.86783-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With volatile removed from arch_raw_cpu_ptr() the compiler no longer
creates the per-CPU reference. The usage of the macro can be reverted
now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock_internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index 6d635e8306d64..975e33b793a77 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -44,9 +44,9 @@ static inline void local_lock_debug_init(local_lock_t *l)
 }
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
-# define local_lock_acquire(__ll)  do { typecheck(local_lock_t *, __ll); }=
 while (0)
-# define local_lock_release(__ll)  do { typecheck(local_lock_t *, __ll); }=
 while (0)
-# define local_lock_debug_init(__ll)  do { typecheck(local_lock_t *, __ll)=
; } while (0)
+static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_lock_release(local_lock_t *l) { }
+static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
--=20
2.35.1

