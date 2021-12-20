Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632F447AAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhLTOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:01:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49186 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhLTOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:01:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B850C6115C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFACBC36AED;
        Mon, 20 Dec 2021 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640008914;
        bh=kvnFKOvaR5qhoO+h5aA/rjGoloa3TsguK9JnuCFJCC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOJ9diqyEGAFgjaUpAHDmOVJHnc6gPhQ2BfhZAbVAJmqycm5CWRvbzq+Tk9i80X+5
         iA4aqJ1KxO8a4Kfxdd7rVUqfBTT9iz7L01uRxqaJrkYbzRRwMXmBLYPMeqIqPhjpZN
         kOFq4PgijAqW7lGxHuXIGQCCF8qSrxM+CYcujiIu3yRid5RwONMAxZldbdnTd7Q364
         ue9ifNbf3NRKnflZNaX4hoK6lyumipvyDyesAW9mraWJjiWHSVNdkXag/dahPIpbJ4
         j+SOIeY/gnCZ/CHbiB6ABdvJbXYxlXtH6unUtlzZ8VGRj9nXqfQIbwihW/VWeLZuRY
         6dxKeoKdb5avg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/5] static_call: Use non-function types to refer to the trampolines
Date:   Mon, 20 Dec 2021 15:01:38 +0100
Message-Id: <20211220140142.922323-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220140142.922323-1-frederic@kernel.org>
References: <20211220140142.922323-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

In order to prevent CFI enabled code from grabbing a jump table entry
that jumps to the trampoline, rather than the trampoline itself, use an
incomplete non-function type for the trampoline, and cast it to the
right type only when invoking it.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/static_call.h       |  4 ++--
 include/linux/static_call_types.h | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3e56a9751c06..616607393273 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -151,7 +151,7 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #define static_call_update(name, func)					\
 ({									\
-	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
+	typeof(&STATIC_CALL_TYPE(name)) __F = (func);			\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
 			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
 })
@@ -306,7 +306,7 @@ static inline void __static_call_nop(void) { }
 	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
 	if (!func)							\
 		func = &__static_call_nop;				\
-	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
+	(typeof(&STATIC_CALL_TYPE(name)))func;				\
 })
 
 #define static_call_cond(name)	(void)__static_call_cond(name)
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..5e658ef537e4 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -18,6 +18,9 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_TYPE_PREFIX		__SCtype__
+#define STATIC_CALL_TYPE(name)		__PASTE(STATIC_CALL_TYPE_PREFIX, name)
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
@@ -36,11 +39,13 @@ struct static_call_site {
 
 #define DECLARE_STATIC_CALL(name, func)					\
 	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
+	extern struct static_call_tramp STATIC_CALL_TRAMP(name);	\
+	extern typeof(func) STATIC_CALL_TYPE(name)
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
-#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+#define __raw_static_call(name)						\
+	((typeof(&STATIC_CALL_TYPE(name)))&STATIC_CALL_TRAMP(name))
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
@@ -96,7 +101,7 @@ struct static_call_key {
 };
 
 #define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+	((typeof(&STATIC_CALL_TYPE(name)))(STATIC_CALL_KEY(name).func))
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-- 
2.25.1

