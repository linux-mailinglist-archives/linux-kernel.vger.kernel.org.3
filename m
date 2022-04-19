Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F42507ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357627AbiDSUMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244421AbiDSUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB63D1C0;
        Tue, 19 Apr 2022 13:08:46 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiuTe736S/g8bz8JecqlNfPJ4fy14sOPXIbM7FpJ/4w=;
        b=rmQ2ActScofUKooJ9CRJO4q+u6ynPUNMSDiBB9DhU0weD1BCNKnTs04G3Ic60y/Afm/azz
        5h3Nno1d0srrn4U7wDWZdZlF9uMtqTvjgpzbjS91yfnb337Ni0TIYBjRA2t9s0fON+8+Ee
        lltz/27AYWUYpzNXIyJrgaxbhJFhLb8rmvabzvyJyEN7ItSHWB+lURTmYbhWE1GGfNOe77
        zsAo9+WlLFg5WYKcaJ6hzwWPKCuEbPkAN/Ek+pRlHNVKmJsF28KeOLBL6uDjw8dBT0eR2p
        +4UMj3ahtURltqiSiCgxmotSWTgb1YMrVBneHblfz2iDAcd25K/yFjhDXixDcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiuTe736S/g8bz8JecqlNfPJ4fy14sOPXIbM7FpJ/4w=;
        b=2nGAyhpYIfjKiopOUphLXmGJpuGq3rYjgXGCCkXkBbhiF6P/shXv+jtgobbci76NxiIDs3
        ucrUMrwscWteYXCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] lib/strn*,objtool: Enforce user_access_begin() rules
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408094718.262932488@infradead.org>
References: <20220408094718.262932488@infradead.org>
MIME-Version: 1.0
Message-ID: <165039892407.4207.8696896474032855966.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     226d44acf6dfe71c9df5804b82364e93cf908b53
Gitweb:        https://git.kernel.org/tip/226d44acf6dfe71c9df5804b82364e93cf908b53
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Apr 2022 11:45:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:47 +02:00

lib/strn*,objtool: Enforce user_access_begin() rules

Apparently GCC can fail to inline a 'static inline' single caller
function:

  lib/strnlen_user.o: warning: objtool: strnlen_user()+0x33: call to do_strnlen_user() with UACCESS enabled
  lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x33: call to do_strncpy_from_user() with UACCESS enabled

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220408094718.262932488@infradead.org
---
 lib/strncpy_from_user.c | 2 +-
 lib/strnlen_user.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 08fc72d..6432b8c 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -25,7 +25,7 @@
  * hit it), 'max' is the address space maximum (and we return
  * -EFAULT if we hit it).
  */
-static inline long do_strncpy_from_user(char *dst, const char __user *src,
+static __always_inline long do_strncpy_from_user(char *dst, const char __user *src,
 					unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index bffa0eb..feeb935 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -20,7 +20,7 @@
  * if it fits in a aligned 'long'. The caller needs to check
  * the return value against "> max".
  */
-static inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
+static __always_inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long align, res = 0;
