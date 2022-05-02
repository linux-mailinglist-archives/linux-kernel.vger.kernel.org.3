Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF1516C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383758AbiEBIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383802AbiEBIeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:34:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684406399;
        Mon,  2 May 2022 01:30:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E87281F38C;
        Mon,  2 May 2022 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651480234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m5U9elRICPWSleScnMCrzm3cSvSDZ+t1d2mLrc+xdPA=;
        b=GrDoFmUIFdZ8y5dGow0KnPTRdoogF2Pvy/witwTizJGhkPqEz16PdCw33yjLy8AXllvUoz
        uzWsGoopijmEHEFBsKBYR2W1Zv4QyH4mv4Yn8k3oXIhCBGiQyWVw5xjbGfXIgPsnznb8Jh
        xC0ejVxLrKeflIkvR4VIo4XQqu9s7C0=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DDE392C142;
        Mon,  2 May 2022 08:30:33 +0000 (UTC)
Date:   Mon, 2 May 2022 10:30:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marco Elver <elver@google.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [next] i386: kunit: ASSERTION FAILED at
 mm/kfence/kfence_test.c:547
Message-ID: <Ym+WqKStCg/EHfh3@alley>
References: <CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com>
 <YmwPocGA9vRSvAEN@elver.google.com>
 <87fslup9dx.fsf@jogness.linutronix.de>
 <Ym+NkkglHI5D89Dx@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym+NkkglHI5D89Dx@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-05-02 09:51:46, Marco Elver wrote:
> On Sat, Apr 30, 2022 at 11:14PM +0206, John Ogness wrote:
> [...]
> > I am not familiar with how this works. Is the tracepoint getting set on
> > call_console_drivers()? Or on call_console_driver()?
> 
> It's at the start of call_console_drivers(). See trace_console_rcuidle()
> call.
> 
> > If so, there are a couple problems with that. First off, the prototype
> > for that function has changed. Second, that function is called when text
> > is printed, but this is not when the text was created. With the
> > kthreads, the printing can be significantly delayed.
> > 
> > Since printk() is now lockless and console printing is delayed, it
> > becomes a bit tricky to parse the records in the existing code using a
> > tracepoint.
> > 
> > I wonder if creating a NOP function for the kfence probe to attach to
> > would be more appropriate. In printk_sprint() we get the text after
> > space has been reserved, but before the text is committed to the
> > ringbuffer. This is guaranteed to be called from within the printk()
> > context.
> 
> I think we just need to fix the existing tracepoint, since it has
> changed its semantics vs. what it was intended to be:
> 
>  | commit 95100358491abaa2e9a5483811370059bbca4645
>  | Author: Johannes Berg <johannes.berg@intel.com>
>  | Date:   Thu Nov 24 20:03:08 2011 +0100
>  |
>  |     printk/tracing: Add console output tracing
>  |
>  |     Add a printk.console trace point to record any printk
>  |     messages into the trace, regardless of the current
>  |     console loglevel. This can help correlate (existing)
>  |     printk debugging with other tracing.
>  |
>  |     Link: http://lkml.kernel.org/r/1322161388.5366.54.camel@jlt3.sipsolutions.net
>  |
>  |     Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
>  |     Cc: Christoph Hellwig <hch@infradead.org>
>  |     Cc: Ingo Molnar <mingo@redhat.com>
>  |     Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
>  |     Acked-by: Thomas Gleixner <tglx@linutronix.de>
>  |     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>  |     Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Specifically using it to "correlate (existing) printk debugging with
> other tracing" is now broken.

It is pity that it was done in the console code in the first place.

printk() always used console_trylock() and the message was flushed
to the console only when the trylock succeeded. And it was always
deferred in NMI or when printed via printk_deferred().

> My proposal would be to fix the tracepoint like so:
> 
>  | --- a/kernel/printk/printk.c
>  | +++ b/kernel/printk/printk.c
>  | @@ -2002,8 +2002,6 @@ static void call_console_driver(struct console *con, const char *text, size_t le
>  |  {
>  |  	size_t dropped_len;
>  |  
>  | -	trace_console_rcuidle(text, len);
>  | -
>  |  	if (con->dropped && dropped_text) {
>  |  		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
>  |  				       "** %lu printk messages dropped **\n",
>  | @@ -2178,6 +2176,8 @@ static u16 printk_sprint(char *text, u16 size, int facility,
>  |  		}
>  |  	}
>  |  
>  | +	trace_console_rcuidle(text, text_len);
>  | +
>  |  	return text_len;
>  |  }
> 
> This fixes the KFENCE and KCSAN tests.
> 
> Unless I hear objections, I'll prepare a patch explaining why we need to
> fix the tracepoint.

It makes perfect sense to me.

Note that there is one difference. The original tracepoint stored the
string with the console header (loglevel + timestamp), see
info_print_prefix(). The new code will store "only" the plain message.

But the new code should be more user friendly. The printk() message
will be sorted with the other tracing messages out of box. Users will
not longer need to use the printk timestamp to find when it was
actually printed.

Best Regards,
Petr
