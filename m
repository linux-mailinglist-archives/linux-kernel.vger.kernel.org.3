Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7DF567A18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiGEW17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiGEW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800114020
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F1761D2B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F86C341C7;
        Tue,  5 Jul 2022 22:27:48 +0000 (UTC)
Date:   Tue, 5 Jul 2022 18:27:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, kernel@pengutronix.de
Subject: Re: Performance impact of CONFIG_FUNCTION_TRACER
Message-ID: <20220705182746.4ce53681@rorschach.local.home>
In-Reply-To: <20220705215948.GK5208@pengutronix.de>
References: <20220705105416.GE5208@pengutronix.de>
        <20220705103901.41a70cf0@rorschach.local.home>
        <20220705215948.GK5208@pengutronix.de>
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

On Tue, 5 Jul 2022 23:59:48 +0200
Sascha Hauer <sha@pengutronix.de> wrote:

> > 
> > As I believe due to using a link register for function calls, ARM
> > requires adding two 4 byte nops to every function where as x86 only
> > adds a single 5 byte nop.
> > 
> > Although nops are very fast (they should not be processed in the CPU's
> > pipe line, but I don't know if that's true for every arch). It also
> > affects instruction cache misses, as adding 8 bytes around the code
> > will cause more cache misses than when they do not exist.  
> 
> Just digged around a bit and saw that on ARM it's not even a real nop.
> The compiler emits:
> 
> 	push    {lr}
> 	bl      8010e7c0 <__gnu_mcount_nc>
> 
> Which is then turned into a nop by replacing the second instruction with
> 
> 	add   sp, sp, #4
> 
> to bring the stack pointer back to its original value. This indeed must
> be processed by the CPU pipeline. I wonder if that could be optimized by
> replacing both instructions with a nop. I have no idea though if that's
> feasible at all or if the overhead would even get smaller by that.

The problem is that there's no easy way to do that, because a task
could have been preempted after doing the 'push {lr}' and before the
'bl'. Thus, you create a race by changing either one to a nop first.

I wonder if it would have been better to change the first one to a jump
passed the second :-/

Actually, if you don't mind setups that take a long time, if you change
the first to a jump passed the second, then do synchronize_rcu_rude()
(which may take a while, possibly several seconds or more) then you know
that all users now only see the jump, and none will see the bl. Then
you could convert the bl to nop, and then even change the jump to nop
after that.

To convert back, you would need to reverse it. Convert the first nop
back to a jmp, run synchronize_rcu_rude(). Then convert the second nop
to the bl, and then convert the first to the push {lr}.

> 
> > 
> > Also, there's some configurations that use the old mcount that does add
> > some more code to handle the mcount case.
> > 
> > So if this is just to have us change the kconfig, I'm happy to do that.  
> 
> Yes, would be good to make the kconfig text clear. The overhead itself
> is fine when people know that's the price to pay for getting the
> function tracer.

Agreed. I'll write up a patch.

-- Steve
