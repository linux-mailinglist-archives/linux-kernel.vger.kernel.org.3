Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C84ADB3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377570AbiBHOeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiBHOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:34:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C0C03FECE;
        Tue,  8 Feb 2022 06:34:08 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:34:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644330846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iNnPhQQ55Pi6kzQUFWyH2fbuUFx9XPFEGnLROqiOgsk=;
        b=O+denDhufo6iTSmlZ6HZ6jfgrU0ZFCQD+ZolHSs4uKRLGjJuxGNO6MmO12SO9RG8KfAZAc
        dXeAhEyraPIzzNejB10n+1fsZlhh1T4tem6dcW5cMvRqqWO9pxvcpJgffVIYJhLYc07gbu
        FXmEph2jOXzH19jM646R2nszV96uu5lKtZ93CBZj2eG+oUGoXSBWLU8EUeKHSnIyhUg1uD
        /vGc9xKgmTW7hZCpEg7S1XMOGYO+OPNQDDeV5cbchauduzadfh/JNWAYkWkWAxqpq6MKcW
        +cyDngqqs3hbv2fpinSk/6/QVu2YY6VVLkJeecLY8tdUl2dQMxk2vFHnFh3p7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644330846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iNnPhQQ55Pi6kzQUFWyH2fbuUFx9XPFEGnLROqiOgsk=;
        b=EAtS9W9/tFdRWSB8DBrg+XRxfFIJ+LSofSF3pL67wfKvTnFKghWlhiivAdd1VI1iOI3JTW
        Q4pZuXLesl+4C3Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH REPOST] irq_poll: Add local_bh_disable() in cpu_dead notifier
Message-ID: <YgJ/XWVxxWDVBBVA@linutronix.de>
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

__raise_softirq_irqoff() adds a bit to the pending sofirq mask and this
is it. The softirq won't be handled in a deterministic way but randomly
when an interrupt fires and handles the softirq in its irq_exit() routine or
if something randomly checks and handles pending softirqs in the call
chain before the CPU goes idle.

Add a local_bh_disable/enable() around the IRQ-off section which will
handle pending softirqs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Repost of 
     https://lkml.kernel.org/r/20210930103754.2128949-1-bigeasy@linutronix.de

 lib/irq_poll.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -191,11 +191,13 @@ static int irq_poll_cpu_dead(unsigned in
 	 * If a CPU goes away, splice its entries to the current CPU
 	 * and trigger a run of the softirq
 	 */
+	local_bh_disable();
 	local_irq_disable();
 	list_splice_init(&per_cpu(blk_cpu_iopoll, cpu),
 			 this_cpu_ptr(&blk_cpu_iopoll));
 	__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
 	local_irq_enable();
+	local_bh_enable();
 
 	return 0;
 }
