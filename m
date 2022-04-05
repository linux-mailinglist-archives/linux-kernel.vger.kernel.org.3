Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21684F49E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451808AbiDEWau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352003AbiDEPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:11:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437FD10857E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:25:40 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649165138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vNeqajyflYseDN9U86copcD82UelhphMBtFer240cuQ=;
        b=W7/pb8xYxRRmMWdND5mpwMKRennaa0wwlKgGgp6un5Dap/qjWXdJga/yVEx1Lsm8KYQYqi
        +3c6JE15H0LAtHu33mG3Dep57WnXKRCrw+vyGSipCqT8Ff6HBsfEMkPSzHWhZurAUZZZhZ
        bLNeJtV0WV7TG/oqVL6padKSmVJsvfZk3DoYS65pdMNxokLQu5HkAQfdTK/7oEYn7T/bKv
        anAtrztsJMDz/1fUaT2Z8DEYDGwr71G/Uzbr77HUVN+EIrcqW9c2tloVxxxUU2+YIkNA+v
        JTZPehM+N2Q6U22YJ0T07YG6XCgddWEk/GF7Yyb7piO7iQxhK1BL6VJm3daieA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649165138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vNeqajyflYseDN9U86copcD82UelhphMBtFer240cuQ=;
        b=xawPdNh+P1cLeleF+r1Cmfe51m5joVK55Sjm+xx2D1TUS1vEZYcezfancq6p9tzdDvD5Jn
        GTT7zZcEs5mywaBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 03/12] printk: get caller_id/timestamp after migration disable
Date:   Tue,  5 Apr 2022 15:31:26 +0206
Message-Id: <20220405132535.649171-4-john.ogness@linutronix.de>
In-Reply-To: <20220405132535.649171-1-john.ogness@linutronix.de>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
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

Currently the local CPU timestamp and caller_id for the record are
collected while migration is enabled. Since this information is
CPU-specific, it should be collected with migration disabled.

Migration is disabled immediately after collecting this information
anyway, so just move the information collection to after the
migration disabling.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 13a1eebe72af..9774a3f6bafb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2041,7 +2041,7 @@ static inline void printk_delay(void)
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
-		0x80000000 + raw_smp_processor_id();
+		0x80000000 + smp_processor_id();
 }
 
 /**
@@ -2123,7 +2123,6 @@ int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args)
 {
-	const u32 caller_id = printk_caller_id();
 	struct prb_reserved_entry e;
 	enum printk_info_flags flags = 0;
 	struct printk_record r;
@@ -2133,10 +2132,14 @@ int vprintk_store(int facility, int level,
 	u8 *recursion_ptr;
 	u16 reserve_size;
 	va_list args2;
+	u32 caller_id;
 	u16 text_len;
 	int ret = 0;
 	u64 ts_nsec;
 
+	if (!printk_enter_irqsave(recursion_ptr, irqflags))
+		return 0;
+
 	/*
 	 * Since the duration of printk() can vary depending on the message
 	 * and state of the ringbuffer, grab the timestamp now so that it is
@@ -2145,8 +2148,7 @@ int vprintk_store(int facility, int level,
 	 */
 	ts_nsec = local_clock();
 
-	if (!printk_enter_irqsave(recursion_ptr, irqflags))
-		return 0;
+	caller_id = printk_caller_id();
 
 	/*
 	 * The sprintf needs to come first since the syslog prefix might be
-- 
2.30.2

