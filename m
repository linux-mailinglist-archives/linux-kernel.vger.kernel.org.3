Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D357BAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiGTPsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiGTPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:48:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D3422D7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:48:08 -0700 (PDT)
Date:   Wed, 20 Jul 2022 17:48:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658332087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=G/JNBs8/F1Gq6I1mESX8LBHCUKISdsTKHnaflhhlQXU=;
        b=HQ2Dg14+GjHmiQOWpUxRTUuyH12aZzrsVEP6D0BwV8XxLYioLFAKK9uKlCN1ZgY9WX3SEM
        1rDmVuZ/Id57VdgdyuUHMDiafRFjBP+8GTsPFgOdo8fySiQ+zCnH2LBvYf9cSSlWB/XjTd
        KiZnb2vW8j6YFR2JP9fZXM0DR5HGuMLuFSp/v2EU58EDsL9zwWrTN7yKJB7KE3AsHCs1zo
        Lo20M+qLIFqLSONd44vIKAFwdC3AmDczfhLdDgCfYvM73iOlWZ4EBN1uVUhA4hV8xVDVYu
        iceuP5LH+n5jiIuSF7gS7wGzDNLUyHMmLbdOtITYzeFRMmIFUbKLNxwFrINRMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658332087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=G/JNBs8/F1Gq6I1mESX8LBHCUKISdsTKHnaflhhlQXU=;
        b=APc5lwYh4anPJKgDf8YnjzeDSBkYAalNiT3DuRxLu9o87N5NNHlaUghfZ7RMngYiCBF4/Z
        +EdYFUK+GNxD5RCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <YtgjtfjYVMQrzFTK@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk might be invoked in a context with disabled interrupts and or
preemption and additionally disables interrupts before it invokes the
console drivers. This is behaviour is not compatible with PREEMPT_RT.

Disable console printing until the return of atomic consoles and the
printing thread. This allows to retrieve the log buffer from user space
which is not possible by disable printk.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/printk/printk.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2843,6 +2843,16 @@ void console_unlock(void)
 	}
 
 	/*
+	 * On PREEMPT_RT it is not possible to invoke console drivers with
+	 * disabled interrupts and or preemption. Therefore all drivers are
+	 * skipped and the output can be retrieved from the buffer.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		up_console_sem();
+		return;
+	}
+
+	/*
 	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
 	 * end up dumping a lot of lines, for example, if called from
