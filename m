Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8F57CCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiGUN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGUN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFD33C14A;
        Thu, 21 Jul 2022 06:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA6F561F5F;
        Thu, 21 Jul 2022 13:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1D0C3411E;
        Thu, 21 Jul 2022 13:59:26 +0000 (UTC)
Date:   Thu, 21 Jul 2022 09:59:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V6 04/16] rv/include: Add deterministic automata monitor
 definition via C macros
Message-ID: <20220721095924.151c6f5d@gandalf.local.home>
In-Reply-To: <3c0a4cb5-f88f-ec5f-e614-d1e8ceb036c2@kernel.org>
References: <cover.1658244826.git.bristot@kernel.org>
        <9ffc05b67fff087413143a420373731e0e34eef4.1658244826.git.bristot@kernel.org>
        <20220720160606.3e672b55@gandalf.local.home>
        <3c0a4cb5-f88f-ec5f-e614-d1e8ceb036c2@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 14:08:38 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 7/20/22 22:06, Steven Rostedt wrote:
> >> +/*												\
> >> + * da_monitor_enabled_##name - checks if the monitor is enabled					\
> >> + */												\
> >> +static inline bool da_monitor_enabled_##name(void)						\
> >> +{												\  
> > Should we add a:
> > 
> > 	smp_rmb();
> > 
> > here? And then a smp_wmb() where these switches get updated?
> >  
> 
> Makes sense.
> 
> Should I also add the READ_ONCE/WRITE_ONCE? like
> 
> smp_rmb()
> READ_ONCE(var)
> 
> WRITE_ONCE(var, value)
> smp_wmb()

I'm not sure the WRITE_ONCE() is necessary with the memory barriers.
Because they should also prevent gcc from doing anything after that
barrier. As Linus once stated, most cases WRITE_ONCE() is useless, but it's
fine to keep more for annotation (as to pair with the READ_ONCE()) than for
anything that is critical.

> 
> for all these on/off knobs, or just the barriers?
> 
> > I guess how critical is it that these turn off immediately after the switch
> > is flipped?  
> 
> It is not critical to continue the execution of those that have already crossed by
> the variable. Still, waiting for the tracepoints to finish their execution before
> returning to the user-space task that disabled the variable might be a good thing.

You mean after disabling, to wait for the tracepoints that are currently
running to end?

> 
> IIRC, we can do that via RCU... like, synchronize_rcu()?

We have tracepoint_synchronize_unregister() that does that, as some
traceponits use SRCU and not RCU.

-- Steve


> 
> >> +	/* global switch */									\
> >> +	if (unlikely(!rv_monitoring_on()))							\
> >> +		return 0;									\
> >> +												\
> >> +	/* monitor enabled */									\
> >> +	if (unlikely(!rv_##name.enabled))							\
> >> +		return 0;									\
> >> +												\
> >> +	return 1;										\
> >> +}												\
> >> +												\  

