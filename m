Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3C507D56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358427AbiDSXtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358111AbiDSXt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB642180E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:46:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650412000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/ZHMq08ci045OAhMUJNVIZDxpbIlyVUYwdj4xaSdeg=;
        b=WpAXvkiTSXZMQ674ogMxZp8afAb5ChX1Kg7FdIfOs3jmfimGNNplrJyaZVbUDssxL+Llpu
        NFH0vn5Tv7ZZlaq36y9Kuao1tIZtMHLGh4/vvbMupgZd8u2PpsT6Wa0anTM7qghlrFSqvg
        SQkuo7K+4jU8BbRSnRV5D7dLg670GRm4JtHccx2Ur3t0R5eHI8jbD2YfzvyOsTQxPElkVG
        Jz151GW69P4Q5mn8v7h6eKPItWLiVNLlEwZkc04sX4ne1RXDFJgHE1ZauFNQQTk6vdq2SE
        qCrOEWRwu2hBeJByyulk5zh9ESPXCcFBL41irHmp2/Cm+qnT+nnxa1iqrkz0sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650412000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/ZHMq08ci045OAhMUJNVIZDxpbIlyVUYwdj4xaSdeg=;
        b=LpNawu4c2DvFXQD+KxVeaDagebzQg2TbKfx8qN03VLnO+CTQwPZ3TYJukNK36Cva5r2Ajo
        IGS7p6nisZI1TMDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 04/15] printk: wake up all waiters
Date:   Wed, 20 Apr 2022 01:52:26 +0206
Message-Id: <20220419234637.357112-5-john.ogness@linutronix.de>
In-Reply-To: <20220419234637.357112-1-john.ogness@linutronix.de>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
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

There can be multiple tasks waiting for new records. They should
all be woken. Use wake_up_interruptible_all() instead of
wake_up_interruptible().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
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

