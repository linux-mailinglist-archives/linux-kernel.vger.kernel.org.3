Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A4959B631
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiHUTz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 15:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiHUTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 15:55:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0D19289
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 12:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A2BDB80E11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2030AC433C1;
        Sun, 21 Aug 2022 19:55:18 +0000 (UTC)
Date:   Sun, 21 Aug 2022 15:55:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Message-ID: <20220821155533.34a0976a@gandalf.local.home>
In-Reply-To: <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
References: <20220821000737.328590235@goodmis.org>
        <20220821000844.510643400@goodmis.org>
        <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
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

On Sun, 21 Aug 2022 11:35:29 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Aug 20, 2022 at 5:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Since there is no known way of checking signedness of a bitwise type
> > without triggering sparse warnings, disable signedness checking when
> > verifying code with sparse.  
> 
> What, what, what?
> 
> The last I saw of this discussion, the fix was just to make sparse not
> warn about these cases. Why did this bogus fix make it into a pull
> request that I will now ignore?

Sorry, I was triaging my internal patchwork and saw the "Suggested-by"
Christoph and was thinking this was what we decided on.

> 
> If we want to just shut up the sparse warning, then afaik the simple
> one-liner fix would have been
> 
> -#define is_signed_type(type)   (((type)(-1)) < (type)1)
> +#define is_signed_type(type)   (((__force type)(-1)) < (__force type)1)
> 
> and at least then sparse checks the same source as is compiled,
> instead of passing a "this is not a signed type" to places.
> 
> So that "no known way" was always bogus, the real question was whether
> there was a way to make sparse not need the "ignore bitwise" hack.
> 
> Btw, that patch is entirely broken for *another* reason.
> 
> Even if you were to say "ok, sparse just gets a different argument",
> the fact that the trace_events file re-defined that is_signed_type()
> macro means that you added that
> 
> +#undef is_signed_type
> 
> to make the compiler happy about how you only modified one of them.
> 
> But that then means that if <linux/trace_events.h> gets included
> *before* <linux/overflow.h>, you'll just get the warning *there*
> instead.
> 
> Now, that warning would only happen for a __CHECKER__ build - but
> that's the only build this patch is relevant for anyway.
> 
> And maybe that ordering doesn't exist, or maybe it only exists on some
> very random config. Regardless, it's broken.
> 
> Of course, the real fix should be to just not re-define that macro at
> all, and just have it in *one* place.


I'll remove this patch and send another pull request.

Thanks,

-- Steve

