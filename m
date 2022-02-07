Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F844AC9CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiBGTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbiBGTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E40C0401E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:43:30 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcJAS7OHmwiIaC/n5sQLSDHnPEzEBeUZ3m1d4fP3mjQ=;
        b=yyO3GMreuW1+E5VBxVctTVFluNm8xtt5rxmastM+uZ/XRECiE/2lneXr1z2y+a1izvEnCq
        abPeFfwZ60L6SwnaSCcrFJ8jcLSdZXsB5nLV3hcigF6xO1w5PL+yj033xwyvTIvEIUDyOf
        E5V3L39EJZzvdizD+DzxPVKzVfvHFALNJs+LSgdd4jNJ0sMchRJwf+G8kU16cjBJWfwKpO
        WqbdqC7v4VbSHOvHM4g05J5yJIOK9DTVHlzhjXK+RGlQbJf7NSkyd9w1dyslwRQ6kTMKfU
        d/0q3L1ci9vmKaUBYAIGt2KyrOevUG+nowFF749PGMGWTJ1HXY4Y/PulWHGN5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcJAS7OHmwiIaC/n5sQLSDHnPEzEBeUZ3m1d4fP3mjQ=;
        b=R9l7ob6ZMwful/kMPl9aGn6l6U0+mxKAzj0UhtVw+mk58nrAKzJblGJfrBGTha8jPdnDY1
        vv9GJwFmccymSaDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 05/13] printk: call boot_delay_msec() in printk_delay()
Date:   Mon,  7 Feb 2022 20:49:15 +0106
Message-Id: <20220207194323.273637-6-john.ogness@linutronix.de>
In-Reply-To: <20220207194323.273637-1-john.ogness@linutronix.de>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot_delay_msec() is always called immediately before printk_delay()
so just call it from within printk_delay().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 206405f349d0..8c9a89c60989 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2002,8 +2002,10 @@ static u8 *__printk_recursion_counter(void)
 
 int printk_delay_msec __read_mostly;
 
-static inline void printk_delay(void)
+static inline void printk_delay(int level)
 {
+	boot_delay_msec(level);
+
 	if (unlikely(printk_delay_msec)) {
 		int m = printk_delay_msec;
 
@@ -2224,8 +2226,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		in_sched = true;
 	}
 
-	boot_delay_msec(level);
-	printk_delay();
+	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-- 
2.30.2

