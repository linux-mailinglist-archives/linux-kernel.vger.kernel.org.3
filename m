Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC35A165D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbiHYQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiHYQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:09:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB7B56D3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:09:01 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:08:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661443739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+/MBQUs6+j+/PaQAMzI039qlyHfkNnxmyhc5bJPAEZY=;
        b=G1eKz4Jg/J7JOFO+x70qJX7agTy+Vl3ltrDyFOO2YNM31Rf/j6Ffx8L3XUwLjX7l+uCaTn
        wgHBe2I61N/7kp5IytB0SUYjOMmzZ3E0pivEw2070lsEUbsrQLaYvFOvPL/ayt88Qd1OmB
        139QwM4dxcgCJgNwnqY7x+7sHyLZKbIOUVNQM529p56wFLzvHjZscpXpEcx5PftJ01SuZc
        ZCf6EcpOu6/IlyiPZB/rlWUummUZcxHpYdbdCOmB38oBcMrBYxOk573PHcPw5uR6Tyi2iQ
        HkSILa+/NZQNIdPAi82SGWtCT2GIs4Ival4YUiJK+h21k10ChUczvgy/9MTmfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661443739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+/MBQUs6+j+/PaQAMzI039qlyHfkNnxmyhc5bJPAEZY=;
        b=2kqE5S9edobVVkGYIYLtY1/suyQfELgXLsEZwrD8bHwOVIZR1vgSUiNxG9z13xfraZFlL5
        BlLJqXIqDRSAtEBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] locking: Detect includes rwlock.h outside of spinlock.h
Message-ID: <YweemHxJx7O8rjBx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=46rom: Michael S. Tsirkin <mst@redhat.com>

The check for __LINUX_SPINLOCK_H within rwlock.h (and other files)
detects the direct include of the header file if it is at the very
beginning of the include section.
If it is listed later then chances are high that spinlock.h was already
included (including rwlock.h) and the additional listing of rwlock.h
will not cause any failure.

On PREEMPT_RT this additional rwlock.h will lead to compile failures
since it uses a different rwlock implementation.

Add __LINUX_INSIDE_SPINLOCK_H to spinlock.h and check for this instead
of __LINUX_SPINLOCK_H to detect wrong includes. This will help detect
direct includes of rwlock.h with without PREEMPT_RT enabled.

[ bigeasy: add remaining __LINUX_SPINLOCK_H user and rewrite
  commit description. ]

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This is to avoid patches like
   https://lkml.kernel.org/r/20220816074816.173227-1-bigeasy@linutronix.de

in the future which is not the first I sent=E2=80=A6

 include/linux/rwlock.h           |    2 +-
 include/linux/spinlock.h         |    2 ++
 include/linux/spinlock_api_smp.h |    2 +-
 include/linux/spinlock_api_up.h  |    2 +-
 include/linux/spinlock_rt.h      |    2 +-
 include/linux/spinlock_up.h      |    2 +-
 6 files changed, 7 insertions(+), 5 deletions(-)

--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_RWLOCK_H
 #define __LINUX_RWLOCK_H
=20
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
=20
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_SPINLOCK_H
 #define __LINUX_SPINLOCK_H
+#define __LINUX_INSIDE_SPINLOCK_H
=20
 /*
  * include/linux/spinlock.h - generic spinlock/rwlock declarations
@@ -492,4 +493,5 @@ int __alloc_bucket_spinlocks(spinlock_t
=20
 void free_bucket_spinlocks(spinlock_t *locks);
=20
+#undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_API_SMP_H
 #define __LINUX_SPINLOCK_API_SMP_H
=20
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
=20
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_API_UP_H
 #define __LINUX_SPINLOCK_API_UP_H
=20
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
=20
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_SPINLOCK_RT_H
 #define __LINUX_SPINLOCK_RT_H
=20
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 #error Do not include directly. Use spinlock.h
 #endif
=20
--- a/include/linux/spinlock_up.h
+++ b/include/linux/spinlock_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_UP_H
 #define __LINUX_SPINLOCK_UP_H
=20
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
=20
