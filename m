Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5C523DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347042AbiEKTjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiEKTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:39:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D110A219351;
        Wed, 11 May 2022 12:39:50 -0700 (PDT)
Date:   Wed, 11 May 2022 19:39:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652297988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWYeWYPGfGQOMPi48DV8c7ousN/h9sYcLxp8xQFypMU=;
        b=bDSs1FyaPxRZKmQ6QC4YfIlk3HfjDP5TvzfknSZ6MJRnL6hutNeuRwvuFlSEm2bTSknEvy
        gU0bp6vQ0hvzuZl9RtsSa8lC/gmQICtXfawa9I8/tyeUowrfH94W+HTJzpudK+zZto7zmq
        pi27sA8w+tnYD2/87BztgGAKXDgVB78ps1UJADTFCfPkE9l/oZ7pAaw0V53/DzZlgtxApf
        Gy3ajaoI7SW25YTmCTthiPZTeu+OY6dYMgJbaj3VC1wNrDV9zH5u8hBTSqIDxzGblZ5cEe
        CcksRJLaRsgFZFLGwTe1RawncppNgDoxHBc6oEgih83oRX45EAQ2PMbQkIQsVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652297988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWYeWYPGfGQOMPi48DV8c7ousN/h9sYcLxp8xQFypMU=;
        b=ZR1Epl4VnkVQlE++e1cOVwspRRqWVzRTIpaJwVhYrQlmEEQYs73G/RRDoT5bs5DK7czUS0
        yWgosiN3c2D+XgDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Delete local_irq_enable_in_hardirq()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8735hir0j4.ffs@tglx>
References: <8735hir0j4.ffs@tglx>
MIME-Version: 1.0
Message-ID: <165229798773.4207.7897757507391012997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     deaf7c4b4bf8b802cc465bb9b33fe6c76e812924
Gitweb:        https://git.kernel.org/tip/deaf7c4b4bf8b802cc465bb9b33fe6c76e812924
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 09 May 2022 21:03:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:04 +02:00

lockdep: Delete local_irq_enable_in_hardirq()

No more users and there is no desire to grow new ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8735hir0j4.ffs@tglx
---
 include/linux/interrupt.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index f40754c..b5e06a6 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -222,24 +222,6 @@ devm_request_any_context_irq(struct device *dev, unsigned int irq,
 
 extern void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id);
 
-/*
- * On lockdep we dont want to enable hardirqs in hardirq
- * context. Use local_irq_enable_in_hardirq() to annotate
- * kernel code that has to do this nevertheless (pretty much
- * the only valid case is for old/broken hardware that is
- * insanely slow).
- *
- * NOTE: in theory this might break fragile code that relies
- * on hardirq delivery - in practice we dont seem to have such
- * places left. So the only effect should be slightly increased
- * irqs-off latencies.
- */
-#ifdef CONFIG_LOCKDEP
-# define local_irq_enable_in_hardirq()	do { } while (0)
-#else
-# define local_irq_enable_in_hardirq()	local_irq_enable()
-#endif
-
 bool irq_has_action(unsigned int irq);
 extern void disable_irq_nosync(unsigned int irq);
 extern bool disable_hardirq(unsigned int irq);
