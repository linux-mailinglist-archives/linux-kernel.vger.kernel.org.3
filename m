Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991124AC9D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiBGTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbiBGTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81297C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:43:28 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/cq4VzUVWEBg0IHZiL8z1jRPI1TZUzZwhqXEkTRhR4=;
        b=kJIVZ7eXjfCsw1hGcf4RnzGwUEkDZZJA847eIS6sqDXPBKLepIPub/Y9z+iAa72UNcmGPZ
        pErQAYArCGqCysUWHEM+Sw77R6GN8xURbcnMW8sZuEauIYE2JxlqO0Yvc+uSXESE3eGQSO
        /zn3WI8fhxb8RqfQ+AKHyCvSrV9yBaGzdhrXO7FWlft8+YS5WwgBee+pYN2P9moBGkPa3D
        fP/GbRKUy23SSCZXSkjflV9os+f/LIe0x538MCexanLtBjayLtLTRZRUrQ2yVEeOYnkkQB
        xbaMeq+HFwBqR7JqxUf4soH5RrmAd2VNQO0JNIzUZZJcBdEc1PV+f37Jl6mU5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/cq4VzUVWEBg0IHZiL8z1jRPI1TZUzZwhqXEkTRhR4=;
        b=APjx/qn9rMyCp3tv+25yde5jq4b4OrPAAeuDDnU3GuuPZhcUgp1S67tMVxaJi85t5AAwLA
        O5PfUYCD2P9eHJCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 03/13] printk: use percpu flag instead of cpu_online()
Date:   Mon,  7 Feb 2022 20:49:13 +0106
Message-Id: <20220207194323.273637-4-john.ogness@linutronix.de>
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

The CON_ANYTIME console flag is used to label consoles that will
work correctly before percpu resources are allocated. To check
the condition, cpu_online(raw_smp_processor_id()) was used.
However, this is odd because CPUs can go offline at a later point.
Also, the function is forced to use the raw_ variant because
migration is not disabled.

Since commit ab6f762f0f53 ("printk: queue wake_up_klogd irq_work
only if per-CPU areas are ready") there is a variable to identify
if percpu resources have been allocated. Use that variable instead
of cpu_online(raw_smp_processor_id()).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 2 +-
 kernel/printk/printk.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 7cd758a4f44e..aa4d3fb4c1c5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -133,7 +133,7 @@ static inline int con_debug_leave(void)
 #define CON_CONSDEV	(2) /* Preferred console, /dev/console */
 #define CON_ENABLED	(4)
 #define CON_BOOT	(8)
-#define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
+#define CON_ANYTIME	(16) /* Safe to call before per-cpu resources ready */
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d1b773823d63..b346e60e9e51 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2577,11 +2577,11 @@ static int have_callable_console(void)
  *
  * Console drivers may assume that per-cpu resources have been allocated. So
  * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
- * call them until this CPU is officially up.
+ * call them until per-cpu resources have been allocated.
  */
 static inline int can_use_console(void)
 {
-	return cpu_online(raw_smp_processor_id()) || have_callable_console();
+	return (printk_percpu_data_ready() || have_callable_console());
 }
 
 /**
-- 
2.30.2

