Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53EB4ADF60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384018AbiBHRVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352618AbiBHRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:21:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017FC061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:21:12 -0800 (PST)
Date:   Tue, 8 Feb 2022 18:21:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644340871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5V/2u/5F/SM5/Cd1EuQBv9Q9y3ryDORqqogy80F2+6Q=;
        b=X0u0L23luJuJPqbiEVgv0HSxKaaWz6rDGA5Yjis1/CIAl357EB9B3QH5pu6w4HXxOZefMA
        EpR8oIkX00CvCuqOoCGL19hp9HVxA8hKY/sxiBMLRmuK5UQ0KeH4WRWcW+Zuzg2AJelSxJ
        7xdzS/bB1BJdblXJ60AGQWiN4TcVlbjuYgLYpfD8nKLO0P3JmFwtgo2/t87H1rC7UdOa4D
        xAYX0yIDvSI53xBs95uoadPaMXVZj2zojgehUdFuSl7y7BIYgg+JxJWmGyBoVM1nfBLLvi
        EVFNg73rqpd0/kAuvB1gM4ab5Nvg69t7Djas9anjsuDlZQu5p5QmgpiaLAtq2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644340871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5V/2u/5F/SM5/Cd1EuQBv9Q9y3ryDORqqogy80F2+6Q=;
        b=QsdtkZxzCAQY0tcMWcHku3Vu04DhA17TpVJLJ+LCEmchCrzuZrs+rzehvu5yb6kJulMfSh
        X6VQFDcpMnFyqUAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking: Enable RT_MUTEXES by default on PREEMPT_RT.
Message-ID: <YgKmhjkcuqWXdUjQ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_RT_MUTEXES option is enabled by CONFIG_FUTEX and CONFIG_I2C.
If both are disabled then a CONFIG_PREEMPT_RT build fails to compile.
It is not possible to have a PREEMPT_RT kernel without RT_MUTEX support
because RT_MUTEX based locking is always used.

Enable CONFIG_RT_MUTEXES by default on PREEMPT_RT builds.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2058,6 +2058,7 @@ source "arch/Kconfig"
 
 config RT_MUTEXES
 	bool
+	default y if PREEMPT_RT
 
 config BASE_SMALL
 	int
