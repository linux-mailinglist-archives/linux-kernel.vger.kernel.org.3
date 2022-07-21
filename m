Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279E757C4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiGUGup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiGUGuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:50:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386242ADA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:50:43 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:50:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658386240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPAOjeZDV8PQ0JIHQbcC+MvRzPwsrJZD80FwPieDSug=;
        b=l5EyobWaZSf2DM369jADlWsHiS7CgvjJ82mgiui7AoqXhzuCyxKpgpIUSzyHxw5f1L3QJR
        hPEjA5p2SQX+0zK1CSv/xVrKNkw2TCDpvvfyzOdGiOyEeQyu4id+5jNWEJMEEoDdX8zgx/
        i+TUfW6g72lztuiHvOom2vEurfww51IR+FNXtlYT09lrkgG8Nt7qVREzZ07M3bxrLSgvUa
        EhTpDLYCbPU4BEOVeQp7PbPP1QFzvYvSAbQYvU887frMIdy5XM1QUA5GG9OV3VzqcFG00r
        PHrmBUNvzwGlWZq9MpBr8K7OMDl3uSAMfNMcHEDdmvpQzlWv//vq6Ief9D9OGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658386240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPAOjeZDV8PQ0JIHQbcC+MvRzPwsrJZD80FwPieDSug=;
        b=uw25/yj+CujdL2XiVlEpChMMWvTFNZd8FAowpYqzv8/3G1WQtWpz+exLueFWXMQYqJLLw8
        0hIQ/XXWuD+vdEDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <Ytj3PisFjOfS9L0Y@linutronix.de>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de>
 <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87ilnrn06u.fsf@jogness.linutronix.de>
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
v1=E2=80=A6v2:
   - Use __console_unlock() as suggested by John.

 kernel/printk/printk.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2843,6 +2843,16 @@ void console_unlock(void)
 	}
=20
 	/*
+	 * On PREEMPT_RT it is not possible to invoke console drivers with
+	 * disabled interrupts and or preemption. Therefore all drivers are
+	 * skipped and the output can be retrieved from the buffer.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		__console_unlock();
+		return;
+	}
+
+	/*
 	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
 	 * end up dumping a lot of lines, for example, if called from
