Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE954A8321
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiBCL3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbiBCL3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:29:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:29:19 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643887756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DHfSE0+ZjCNul2AthoCsWVuf+A6D43MMD2PnhTHCNMk=;
        b=gJ6DVQA8j4ACufeOfn8sqTwmf4oLsDyKgi2yxwcVQ1ZBs8R/vSRYrqcCDLLDd02J7FNOXX
        mCVmGTdNuJpuMJ/rZlFJtEwMyikSNguoD+Fnm6IPpLembrSkgri57ipROuVCWXMrCuIl/t
        oDuKrLQ4jSWwQrybI4pNDj6KQRoVYI+m/Yb0Qm/Bl+jj1TOkfTRQ+2sp9LEqGsBXXZlOMb
        9g5t6mCi8Ah4oozy/unwM+efuhi7zm+0CHdSDoHCdW5Z4Akr3I5wpBSpaZg9TjrO4jA7vB
        cRhlSTvXjuNZYKKceGgpIdXpPKG3UC8GDB23n0MlTLKLKoCqqp8tc7bfPFSOSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643887756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DHfSE0+ZjCNul2AthoCsWVuf+A6D43MMD2PnhTHCNMk=;
        b=2d19tgkrKxvW0p5pBq0N3PXF8CFvohKAxboETvG+tff3YBR49ym8oGl9lNNw5HwHwjHJ9n
        nWm/TauEmOulCDCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] printk: defer_console_output: do not assume interrupts disabled
Date:   Thu,  3 Feb 2022 12:35:15 +0106
Message-Id: <20220203112915.1350753-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 458df9fd4815 ("printk: remove separate printk_sched
buffers and use printk buf instead") defer_console_output() was
changed to no longer disable interrupts. However, it used the
function __this_cpu_or(), which assumes interrupts disabled. That
also should have been changed to this_cpu_or().

Although defer_console_output() is mostly used when interrupts are
disabled, this is not always the case. One example is
get_random_bytes(), which is often called with interrupts enabled.

  get_random_bytes()
    warn_unseeded_randomness()
      printk_deferred()

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf3c2aa..164ccdb9423e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3262,7 +3262,7 @@ void defer_console_output(void)
 		return;
 
 	preempt_disable();
-	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	preempt_enable();
 }

base-commit: 88808fbbead481aedb46640a5ace69c58287f56a
-- 
2.30.2

