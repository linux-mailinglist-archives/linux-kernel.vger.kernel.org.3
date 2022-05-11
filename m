Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6F0523751
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiEKP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiEKP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:29:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95783BFA0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:29:24 -0700 (PDT)
Date:   Wed, 11 May 2022 17:29:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652282963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tMcPwtkjzQrnhDwYJUdmCPzDsoeRAwKIFe6lEIlQgCc=;
        b=L+UVoKBGnz7qUNSbs+O0CFqNucWazqcWPqwcuyS8tBhp6HV1KFzljBo9lCGNbySr6Rk6e1
        yp7vSlEqQveFuLmW9FGHOKzPeDZavy99KM1sYuK8vAFl+iaXR/ImjSkQ3V7sqSLAHkr44/
        BWJ8MCZZ3tf85wEerL1zXoCprSC/6Owg0a//HsxEg7ooQNem0sdmNRNHYxCzd3mx9tMU/b
        UpimwA8j1Q3Ay9zG44EXt27IzOkjN7MkHz0zTbRXW4vbq0BBC6m0L60TT5V1yzYqSi9D/k
        Sy6eiMRmhzrIdlZotmE8wC4jPNEvfPkRrJ8hRORxaAvfmQpou//iyHziayYSGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652282963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tMcPwtkjzQrnhDwYJUdmCPzDsoeRAwKIFe6lEIlQgCc=;
        b=VjS0wBzwyh8cdDV5fCuC59Pey5XHtOf+XZ9/9MF8fhxOE4D70MvytC7/sMknz78SthgmM7
        bn9o7HcC7tcbyfDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] futex: Remove a PREEMPT_RT_FULL reference.
Message-ID: <YnvWUvq1vpqCfCU7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier the PREEMPT_RT patch had a PREEMPT_RT_FULL and PREEMPT_RT_BASE
Kconfig option. The latter was a subset the functionality that was
enabled with PREEMPT_RT_FULL and was mainly useful for debugging.

During the merging efforts the two Kconfig options were abandoned in the
v5.4.3-rt1 release and since then there is only PREEMPT_RT which enables
the full features set (as PREEMPT_RT_FULL did in earlier releases).

Replace the PREEMPT_RT_FULL reference with PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 183b28c32c832..ce2889f123755 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1005,7 +1005,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	rt_mutex_init_waiter(&rt_waiter);
 
 	/*
-	 * On PREEMPT_RT_FULL, when hb->lock becomes an rt_mutex, we must not
+	 * On PREEMPT_RT, when hb->lock becomes an rt_mutex, we must not
 	 * hold it while doing rt_mutex_start_proxy(), because then it will
 	 * include hb->lock in the blocking chain, even through we'll not in
 	 * fact hold it while blocking. This will lead it to report -EDEADLK
-- 
2.36.1

