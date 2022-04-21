Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9450AAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiDUV0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442006AbiDUVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CC4EA14
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:55 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650576173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d25OS0lIHyT2YZUge8HFuc5eZjY2wCVUgqFbMMgN8b4=;
        b=07llAGxvfKwKiKefcAhA0pGW8UwQ92/VEHY2sbMZ+B+tkLikmQRJnZAnC9gLj5wCwDqLth
        xNSO3vjXZfla+4dAaVBcOuvuT5nBqrscks0Z44yEBhJX07K8Yd5sLOBxejrCz+c3iApgut
        v+PyUHtrpD+FDhQej2xuj4udj1rqQXCkjUXSDzlkVZ1iFeWdeSDDOlOHy87/scRoCt2W69
        s/S0Hf80OvdNNokfVGhfoJlS7PJ/v5AEmX0LqfoNPX2WbCD2aW1e9HVUInwXlP72+B1xxP
        ymzfWd4XvZZQSTK6tOb7B1uLigYmW8J64PWahqsohfluJ8qZ2S1HAg1+nAbujw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650576173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d25OS0lIHyT2YZUge8HFuc5eZjY2wCVUgqFbMMgN8b4=;
        b=p96CMTvvDbuH1JK5hxJECsSAeOBW2zHnk9BiDB2eSlWcxnTnuD9yDmscgv2HJp79jZhVIg
        5LQf/OGzf9V5DFBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 04/15] printk: wake up all waiters
Date:   Thu, 21 Apr 2022 23:28:39 +0206
Message-Id: <20220421212250.565456-5-john.ogness@linutronix.de>
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

There can be multiple tasks waiting for new records. They should
all be woken. Use wake_up_interruptible_all() instead of
wake_up_interruptible().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f817dfb4852d..e23357002648 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3326,7 +3326,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
-		wake_up_interruptible(&log_wait);
+		wake_up_interruptible_all(&log_wait);
 }
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
-- 
2.30.2

