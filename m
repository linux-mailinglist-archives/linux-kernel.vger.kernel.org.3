Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1215750AACE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442069AbiDUV0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiDUVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD04E39D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650576174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8HgeKR0CZMoWO++V1pVUUlbCNoJ4piAd7ilhw+cap0=;
        b=UcLUK5uo3jvclyMjO4+rAYJUOEin9m9BMg2Fpbr79nemLt+rDoyof6tChUzLO2Zgg2Fhje
        UCN+SAkLMOjGcJ/edXyJo7XVAnbejDnhxekQbJ4jZ8Ia9/Xh5dYWAZhlz8ANm4Hpzd/YaT
        mBm/ypNfgauImrIkZ9YK5X7S7FSo0ZE+NIehHTeRFVT3t66ZHu49B9TKbvHt5mLmqyUOHz
        NfBq5W/8q3hXUPaes5wvRai/xr6kfZTak8vp1mwXJ5rjLNYIbeGAPPdSFWTH5ocpHqiBOJ
        UHx3K/rQwezDdbbDZzSC1J91OOOdpT55Uyiuk80XwKguSyLBprYxPNC/tVIkNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650576174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8HgeKR0CZMoWO++V1pVUUlbCNoJ4piAd7ilhw+cap0=;
        b=WOP1UbiqA8zbCyj81tPJTpVOXuP4t6C+aXzU1r5ifWXj7C+hU4Zzv93RMJUcpFNH5hqd/b
        tiKk0uGwQc/BlTCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 06/15] printk: get caller_id/timestamp after migration disable
Date:   Thu, 21 Apr 2022 23:28:41 +0206
Message-Id: <20220421212250.565456-7-john.ogness@linutronix.de>
In-Reply-To: <20220421212250.565456-1-john.ogness@linutronix.de>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7bb148a1debb..82ad3d3d0d4a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2063,7 +2063,7 @@ static inline void printk_delay(void)
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
-		0x80000000 + raw_smp_processor_id();
+		0x80000000 + smp_processor_id();
 }
 
 /**
@@ -2145,7 +2145,6 @@ int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args)
 {
-	const u32 caller_id = printk_caller_id();
 	struct prb_reserved_entry e;
 	enum printk_info_flags flags = 0;
 	struct printk_record r;
@@ -2155,10 +2154,14 @@ int vprintk_store(int facility, int level,
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
@@ -2167,8 +2170,7 @@ int vprintk_store(int facility, int level,
 	 */
 	ts_nsec = local_clock();
 
-	if (!printk_enter_irqsave(recursion_ptr, irqflags))
-		return 0;
+	caller_id = printk_caller_id();
 
 	/*
 	 * The sprintf needs to come first since the syslog prefix might be
-- 
2.30.2

