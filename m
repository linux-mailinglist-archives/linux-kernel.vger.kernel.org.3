Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7787F53546D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiEZUbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiEZUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:31:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A62DFF75
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:31:01 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653597057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SAFSnSkV1VEivcDSkrTNQ/mWfwoWqDGa1JHVMaX2nZo=;
        b=xwiY7PER4zBLAKzqhHJy3sw1qMEn1KYhwhsfqCQt0uju4sN1ROMyoh/OTnwLF8RThG/Xy+
        RrmqyMGfZSks+LfnRc4+R8sVPYKAUBT2bO3xaW8I6gpO28th6tfOMeehoMTy6bkl8FPRw4
        L+36TzvgirWbEn+cgP8LocpQrV1rckarhuL4+ic2sgH4NDdqZj/lgwye/mHt3SkhlwuOZ0
        L7DDCLb34oJPD8TVRtQNrbUOHlHjBql3thZ7U34g0nY32LDqz6XeP6CZ65vqnp4PPXvlml
        7980bmpLZm2ckjh2Ovxtc9nLr7rePURtHPzXiHkzvbzWa+fslCHHdyiOspuWvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653597057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SAFSnSkV1VEivcDSkrTNQ/mWfwoWqDGa1JHVMaX2nZo=;
        b=eDZldoJCUGXSWw7oL9YSmyeFeQLPu17+U1s7QkaKgPWM/ucZIqUfH/2QPM/r+R+2BSBjZH
        d4Uf9RQHyvo3oCAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "printk: wake up all waiters"
Date:   Thu, 26 May 2022 22:36:56 +0206
Message-Id: <20220526203056.81123-1-john.ogness@linutronix.de>
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

This reverts commit 938ba4084abcf6fdd21d9078513c52f8fb9b00d0.

The wait queue @log_wait never has exclusive waiters, so there
is no need to use wake_up_interruptible_all(). Using
wake_up_interruptible() was the correct function to wake all
waiters.

Since there are no exclusive waiters, erroneously changing
wake_up_interruptible() to wake_up_interruptible_all() did not
result in any behavior change. However, using
wake_up_interruptible_all() on a wait queue without exclusive
waiters is fundamentally wrong.

Go back to using wake_up_interruptible() to wake all waiters.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a3e1035929b0..ea3dd55709e7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3904,7 +3904,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
-		wake_up_interruptible_all(&log_wait);
+		wake_up_interruptible(&log_wait);
 }
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
-- 
2.30.2

