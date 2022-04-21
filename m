Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AEE50A3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389945AbiDUPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiDUPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:17:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93D6743EC5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:14:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505791515;
        Thu, 21 Apr 2022 08:14:17 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9F963F73B;
        Thu, 21 Apr 2022 08:14:15 -0700 (PDT)
Date:   Thu, 21 Apr 2022 16:14:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <YmF0xYpTMoWOIl00@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220316100132.244849-4-bobo.shaobowang@huawei.com>
 <YmFXrBG5AmX3+4f8@lakrids>
 <20220421100639.03c0d123@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421100639.03c0d123@gandalf.local.home>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:06:39AM -0400, Steven Rostedt wrote:
> On Thu, 21 Apr 2022 14:10:04 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Wed, Mar 16, 2022 at 06:01:31PM +0800, Wang ShaoBo wrote:
> > > From: Cheng Jian <cj.chengjian@huawei.com>
> > > 
> > > When tracing multiple functions customly, a list function is called
> > > in ftrace_(regs)_caller, which makes all the other traced functions
> > > recheck the hash of the ftrace_ops when tracing happend, apparently
> > > it is inefficient.  
> > 
> > ... and when does that actually matter? Who does this and why?
> 
> I don't think it was explained properly. What dynamically allocated
> trampolines give you is this.

Thanks for the, explanation, btw!

> Let's say you have 10 ftrace_ops registered (with bpf and kprobes this can
> be quite common). But each of these ftrace_ops traces a function (or
> functions) that are not being traced by the other ftrace_ops. That is, each
> ftrace_ops has its own unique function(s) that they are tracing. One could
> be tracing schedule, the other could be tracing ksoftirqd_should_run
> (whatever).

Ok, so that's when messing around with bpf or kprobes, and not generally
when using plain old ftrace functionality under /sys/kernel/tracing/
(unless that's concurrent with one of the former, as per your other
reply) ?

> Without this change, because the arch does not support dynamically
> allocated trampolines, it means that all these ftrace_ops will be
> registered to the same trampoline. That means, for every function that is
> traced, it will loop through all 10 of theses ftrace_ops and check their
> hashes to see if their callback should be called or not.

Sure; I can see how that can be quite expensive.

What I'm trying to figure out is who this matters to and when, since the
implementation is going to come with a bunch of subtle/fractal
complexities, and likely a substantial overhead too when enabling or
disabling tracing of a patch-site. I'd like to understand the trade-offs
better.

> With dynamically allocated trampolines, each ftrace_ops will have their own
> trampoline, and that trampoline will be called directly if the function
> is only being traced by the one ftrace_ops. This is much more efficient.
> 
> If a function is traced by more than one ftrace_ops, then it falls back to
> the loop.

I see -- so the dynamic trampoline is just to get the ops? Or is that
doing additional things?

There might be a middle-ground here where we patch the ftrace_ops
pointer into a literal pool at the patch-site, which would allow us to
handle this atomically, and would avoid the issues with out-of-range
trampolines.

Thanks,
Mark.
