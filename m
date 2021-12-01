Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A1D46574C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353103AbhLAUqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352909AbhLAUof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0CC061748;
        Wed,  1 Dec 2021 12:41:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFDDEB81F49;
        Wed,  1 Dec 2021 20:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7973AC53FD2;
        Wed,  1 Dec 2021 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391271;
        bh=4y5hReX9l2hsG6EBXTxO7rccJ7/0dmlqmFS2ZJV98SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NVNhW/VPFdMgSTPEOCZSqXvGPtPqRmaigbBFZ5vk0EdTG5dwjLa9s4YX3tPJ2YNBl
         TwsUB/xhqZwn3kmSGQ6wrDQNHDbd6uYO4Cg3MmgQ9kurDskRBFu69DX/sQfc+rHCUk
         3utCcXeZNdPPykgY3o68fZ+TbWB4vfaXECOAsFT3uVWiV4u4gV1NojyzGGGS3BEKi0
         vikFac1FHyaLOvGjcneQ6wiOAtlBEwLnmhqAt/4iXDDH18ipnNHzQWWPqN3mHmCH1l
         2Vxgf+rYhG0w8Y2UazmB8HkusHlE3UlfPxh+eRdYxXpL1hvWdIlT58/OYHm41cMR1Z
         O0J6SbHwX0Mlw==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Mike Galbraith <efault@gmx.de>, stable-rt@vger.kernel.org
Subject: [PATCH RT 1/8] mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t
Date:   Wed,  1 Dec 2021 14:41:01 -0600
Message-Id: <8dd83edff24aac9dd53fdbadc7c767c3e9379ea2.1638391253.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Galbraith <efault@gmx.de>

v5.4.161-rt67-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream 5.10 commit f2d9006d27c9b12563b8e577951ff5021f3b36b2 ]

local_lock_t becoming a synonym of spinlock_t had consequences for the RT
mods to zsmalloc, which were taking a mutex while holding a local_lock,
inspiring a lockdep "BUG: Invalid wait context" gripe.

Converting zsmalloc_handle.lock to a spinlock_t restored lockdep silence.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 mm/zsmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e64eca4b0601..9fc494fe70ea 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -81,7 +81,7 @@
 
 struct zsmalloc_handle {
 	unsigned long addr;
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 #define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
@@ -368,7 +368,7 @@ static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 	if (p) {
 		struct zsmalloc_handle *zh = p;
 
-		mutex_init(&zh->lock);
+		spin_lock_init(&zh->lock);
 	}
 #endif
 	return (unsigned long)p;
@@ -926,7 +926,7 @@ static inline int testpin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_is_locked(&zh->lock);
+	return spin_is_locked(&zh->lock);
 #else
 	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -937,7 +937,7 @@ static inline int trypin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_trylock(&zh->lock);
+	return spin_trylock(&zh->lock);
 #else
 	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -948,7 +948,7 @@ static void pin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_lock(&zh->lock);
+	return spin_lock(&zh->lock);
 #else
 	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -959,7 +959,7 @@ static void unpin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_unlock(&zh->lock);
+	return spin_unlock(&zh->lock);
 #else
 	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
-- 
2.17.1

