Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0A59CE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiHWCBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiHWCBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:01:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383448EBF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C502FB816BF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A2AC433C1;
        Tue, 23 Aug 2022 02:01:36 +0000 (UTC)
Date:   Mon, 22 Aug 2022 22:01:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Message-ID: <20220822220134.5d91f3db@rorschach.local.home>
In-Reply-To: <20220822214024.216fa85d@rorschach.local.home>
References: <20220822164404.57952727@gandalf.local.home>
        <20220822182850.32f91017@gandalf.local.home>
        <20220822183836.6b80976f@gandalf.local.home>
        <20220822204825.3e88b1a4@rorschach.local.home>
        <20220822214024.216fa85d@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 21:40:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> And this patch (which is wrong, but will at least let my tests finish
> testing my code) makes the warning go away.

Well that patch was against the broken commit, but this patch against
6.0-rc2 works for me, albeit, it's still wrong ;-)

-- Steve

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 77978e372377..17201159f3df 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -330,13 +330,13 @@ EXPORT_SYMBOL_GPL(ct_idle_enter);
  * If you add or remove a call to ct_idle_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void noinstr ct_idle_exit(void)
+void ct_idle_exit(void)
 {
 	unsigned long flags;
 
-	raw_local_irq_save(flags);
+	local_irq_save(flags);
 	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
-	raw_local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
 
