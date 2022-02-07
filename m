Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4AF4AC9D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiBGTpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiBGTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:43:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81527C0401E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:43:28 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644263006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZJXPJIT5SmBR9g67hmZQXBDjPIFa3gpior2KE3O7e0=;
        b=CqMCWvWy1KAyyVjByXMA0ujM9u6w+ZCFyMZNSYyn63S7b6CmLL3lXerptxJwIwQZTbKovg
        QuAo1sucTKPf8QGzb57657VkUKX2u5yCm80bRqBjSMFHyaEfzLi98AtxwiKDpVrQqJM28M
        hq3eKqj2+wG+VLBzV8Wbq8c7snZ67mVpD+qdlqJgu+8qi703w+0jXkOkiwEz2qSnCmpCDZ
        vwCahncH456hpG4NNHrcI2Tx+oGT0m/vUPbbQM3cJn2xoTFfqYQ/1hS0IaV+scnW9gyeyM
        lEXPxg5cJyPtiUFQs32dubWIpXS7Mrc8k+pG3mGrT7aoyaW0ER9ShEZ8UYfEMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644263006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZJXPJIT5SmBR9g67hmZQXBDjPIFa3gpior2KE3O7e0=;
        b=LAPJ8HRccNNN76RivwGemLEwfDBT7AeBoRlGNXX2uuCaUe5FcyV87ss5MklQKiFFO6/pAr
        df6GOvuLcOvpMPBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 04/13] printk: get caller_id/timestamp after migration disable
Date:   Mon,  7 Feb 2022 20:49:14 +0106
Message-Id: <20220207194323.273637-5-john.ogness@linutronix.de>
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

Currently the local CPU timestamp and caller_id for the record are
collected while migration is enabled. Since this information is
CPU-specific, it should be collected with migration disabled.

Migration is disabled immediately after collecting this information
anyway, so just move the information collection to after the
migration disabling.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b346e60e9e51..206405f349d0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2017,7 +2017,7 @@ static inline void printk_delay(void)
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
-		0x80000000 + raw_smp_processor_id();
+		0x80000000 + smp_processor_id();
 }
 
 /**
@@ -2099,7 +2099,6 @@ int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args)
 {
-	const u32 caller_id = printk_caller_id();
 	struct prb_reserved_entry e;
 	enum printk_info_flags flags = 0;
 	struct printk_record r;
@@ -2109,10 +2108,14 @@ int vprintk_store(int facility, int level,
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
@@ -2121,8 +2124,7 @@ int vprintk_store(int facility, int level,
 	 */
 	ts_nsec = local_clock();
 
-	if (!printk_enter_irqsave(recursion_ptr, irqflags))
-		return 0;
+	caller_id = printk_caller_id();
 
 	/*
 	 * The sprintf needs to come first since the syslog prefix might be
-- 
2.30.2

