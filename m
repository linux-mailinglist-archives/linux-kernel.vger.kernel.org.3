Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C2A59CB95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiHVWic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiHVWiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:38:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C93C63BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72EEB818FB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7613C433D6;
        Mon, 22 Aug 2022 22:38:19 +0000 (UTC)
Date:   Mon, 22 Aug 2022 18:38:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Message-ID: <20220822183836.6b80976f@gandalf.local.home>
In-Reply-To: <20220822182850.32f91017@gandalf.local.home>
References: <20220822164404.57952727@gandalf.local.home>
        <20220822182850.32f91017@gandalf.local.home>
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

On Mon, 22 Aug 2022 18:28:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 22 Aug 2022 16:44:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Looks like lockdep and the trace_rcu_dyntick() code is getting out of sync
> > with respect to whether or not interrupts are enabled.  
> 
> This is caused by this commit:
> 
> 172114552701 ("rcu/context-tracking: Move RCU-dynticks internal functions
> to context_tracking")
> 
> The warning happens with the commit, and does not for the commit just
> before it is applied.
> 

Nevermind, I tested the wrong kernel (the grub reboot failed to boot to the
new kernel). But it did give me a different lockdep splat when I tested the
right kernel :-/

I'll investigate some more.

-- Steve
