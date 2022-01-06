Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4B3485CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiAFAAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:00:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38860 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245669AbiAFAAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:00:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D99EB619B0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 00:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B04C36AFA;
        Thu,  6 Jan 2022 00:00:05 +0000 (UTC)
Date:   Wed, 5 Jan 2022 19:00:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] trace/osnoise: fix event unhooking
Message-ID: <20220105190004.4a13f92e@gandalf.local.home>
In-Reply-To: <cf4347ed-45f5-5910-a19b-3b8a339bb7a3@kernel.org>
References: <20211228140727.2467771-1-nikita.yushchenko@virtuozzo.com>
        <cf4347ed-45f5-5910-a19b-3b8a339bb7a3@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 10:06:50 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> Hi Nikita
> 
> On 12/28/21 15:07, Nikita Yushchenko wrote:
> > If start_per_cpu_kthreads() called from osnoise_workload_start() returns
> > error, event hooks are left in broken state: unhook_irq_events() called
> > but unhook_thread_events() and unhook_softirq_events() not called, and
> > trace_osnoise_callback_enabled flag not cleared.
> > 
> > On the next tracer enable, hooks get not installed due to
> > trace_osnoise_callback_enabled flag.
> > 
> > And on the further tracer disable an attempt to remove non-installed
> > hooks happened, hitting a WARN_ON_ONCE() in tracepoint_remove_func().
> > 
> > Fix the error path by adding the missing part of cleanup.  
> 
> Regarding the subject:
> 
>  - use tracing/ as subsystem (yeah, I also made this mistake in the original
>    osnoise series).
>  - use a capital after the "tracing/osnoise:"
> 
> Using your subject as example, it should be:
>     tracing/osnoise: Fix event unhooking

Thanks for mentioning this, as was going to.

> 
> Anyway, I suggest using something more precise, like:
> 
>   tracing/osnoise: Properly unhook events if start_per_cpu_kthreads() fails
> 
> or something like that.
> 
> > While at this, introduce osnoise_unhook_events() to avoid code
> > duplication between this error path and notmal tracer disable.  
> 
> s/notmal/normal/
> 
> > 
> > Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> > Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> > ---
> >  kernel/trace/trace_osnoise.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> > index 7520d43aed55..aa6f26612ccc 100644
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
> > @@ -2123,6 +2123,13 @@ static int osnoise_hook_events(void)
> >  	return -EINVAL;
> >  }
> >  
> > +static void osnoise_unhook_events(void)
> > +{
> > +	unhook_thread_events();
> > +	unhook_softirq_events();
> > +	unhook_irq_events();
> > +}
> > +
> >  /*
> >   * osnoise_workload_start - start the workload and hook to events
> >   */
> > @@ -2155,7 +2162,8 @@ static int osnoise_workload_start(void)
> >  
> >  	retval = start_per_cpu_kthreads();
> >  	if (retval) {
> > -		unhook_irq_events();
> > +		trace_osnoise_callback_enabled = false;  
> 
> we need a barrier here, like:
> 
> 		/*
> 		 * Make sure that ftrace_nmi_enter/exit() see
> 		 * trace_osnoise_callback_enabled as false before continuing.
> 		 */
> 		barrier();

Nikita, are you going to send a v2?

-- Steve
