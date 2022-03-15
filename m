Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DAF4DA4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352023AbiCOVrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352016AbiCOVrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF5E4B842
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AD2861231
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232C1C340EE;
        Tue, 15 Mar 2022 21:46:08 +0000 (UTC)
Date:   Tue, 15 Mar 2022 17:46:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <20220315174606.02959816@gandalf.local.home>
In-Reply-To: <20220308161455.036e9933@gandalf.local.home>
References: <20220308161455.036e9933@gandalf.local.home>
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

On Tue, 8 Mar 2022 16:14:55 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Peter,

Have you had time to look into this?

Thanks,

-- Steve

> 
> A ChromeOS bug report showed a lockdep splat that I first thought was a bad
> backport. But when looking at upstream, I don't see how it would work there
> either. The lockdep splat had:
> 
> [56064.673346] Call Trace:
> [56064.676066]  dump_stack+0xb9/0x117
> [56064.679861]  ? print_usage_bug+0x2af/0x2c2
> [56064.684434]  mark_lock_irq+0x25e/0x27d
> [56064.688618]  mark_lock+0x11a/0x16c
> [56064.692412]  mark_held_locks+0x57/0x87
> [56064.696595]  ? _raw_spin_unlock_irq+0x2c/0x40
> [56064.701460]  lockdep_hardirqs_on+0xb1/0x19d
> [56064.706130]  _raw_spin_unlock_irq+0x2c/0x40
> [56064.710799]  sched_core_balance+0x8a/0x4af
> [56064.715369]  ? __balance_callback+0x1f/0x9a
> [56064.720030]  __balance_callback+0x4f/0x9a
> [56064.724506]  rt_mutex_setprio+0x43a/0x48b
> [56064.728982]  task_blocks_on_rt_mutex+0x14d/0x1d5
> 
> Where I see:
> 
> task_blocks_on_rt_mutex() {
>   spin_lock(pi_lock);
>   rt_mutex_setprio() {
>     balance_callback() {
>       sched_core_balance() {
>         spin_unlock_irq(rq);
> 
> Where spin_unlock_irq() enables interrupts while holding the pi_lock, and
> BOOM, lockdep (rightfully) complains.
> 
> The above was me looking at mainline, not the kernel that blew up. So, I'm
> guessing that this is a bug in mainline as well.
> 
> -- Steve

